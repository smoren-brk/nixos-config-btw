"""Passive Ironbar labels driven by Niri's IPC event stream."""

from functools import lru_cache
from html import escape
import json
import os
import socket
import sys

from gi.repository import GioUnix


def connect(request):
    client = socket.socket(socket.AF_UNIX)
    client.connect(os.environ["NIRI_SOCKET"])
    client.sendall((json.dumps(request) + "\n").encode())
    return client


def snapshot(request):
    with connect(request) as client, client.makefile() as stream:
        return json.loads(stream.readline())["Ok"][request]


@lru_cache(maxsize=128)
def app_name(app_id):
    try:
        entry = GioUnix.DesktopAppInfo.new(app_id + ".desktop")
    except TypeError:  # The desktop entry does not exist.
        name = app_id.removesuffix(".exe")
        return name.rsplit(".", 1)[-1] if name.count(".") >= 2 else name
    return entry.get_display_name()


def application(event):
    if "WindowOpenedOrChanged" in event:
        window = event["WindowOpenedOrChanged"]["window"]
        if not window["is_focused"]:
            return None
    elif "WindowsChanged" in event:
        window = next((w for w in event["WindowsChanged"]["windows"] if w["is_focused"]), None)
    elif "WindowFocusChanged" in event or "WindowClosed" in event:
        window = snapshot("FocusedWindow")
    else:
        return None

    if not window or not window["app_id"]:
        return ""
    name = app_name(window["app_id"])
    return f'<span foreground="{sys.argv[2]}">❯</span>   {escape(name)}'


def workspaces(event):
    if "WorkspacesChanged" in event:
        items = event["WorkspacesChanged"]["workspaces"]
    elif "WorkspaceActivated" in event:
        items = snapshot("Workspaces")
    else:
        return None

    output = next((w["output"] for w in items if w["is_focused"]), None)
    labels = []
    for workspace in sorted(items, key=lambda w: w["idx"]):
        if workspace["output"] == output:
            label = str(workspace["idx"])
            if workspace["is_focused"]:
                label = f'<span foreground="{sys.argv[2]}">{label}</span>'
            labels.append(label)
    return "    ".join(labels)


render = {"application": application, "workspaces": workspaces}[sys.argv[1]]
with connect("EventStream") as client, client.makefile() as events:
    previous = None
    for line in events:
        label = render(json.loads(line))
        if label is not None and label != previous:
            print(label, flush=True)
            previous = label
