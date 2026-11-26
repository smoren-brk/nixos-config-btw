import QtQuick
import Quickshell
import Quickshell.Io

Scope {
    id: state
    property var workspaces: []
    property var activeByOutput: ({})
    property var windowByWorkspace: ({})
    property var apps: ({})
    property string focusedOutput: ""

    function focusWorkspace(id) {
        commands.write(JSON.stringify({Action: {FocusWorkspace: {reference: {Id: id}}}}) + "\n")
        commands.flush()
    }

    function update(event) {
        if (event.WorkspacesChanged) {
            const items = event.WorkspacesChanged.workspaces
            const active = {}, windows = {}
            for (const ws of items) {
                if (ws.is_active) active[ws.output] = ws.id
                if (ws.is_focused) focusedOutput = ws.output
                windows[ws.id] = ws.active_window_id
            }
            activeByOutput = active
            windowByWorkspace = windows
            workspaces = items.sort((a, b) => a.idx - b.idx)
        } else if (event.WorkspaceActivated) {
            const ws = workspaces.find(w => w.id === event.WorkspaceActivated.id)
            if (ws && event.WorkspaceActivated.focused) focusedOutput = ws.output
            if (ws) activeByOutput = Object.assign({}, activeByOutput, {[ws.output]: ws.id})
        } else if (event.WorkspaceActiveWindowChanged) {
            const change = event.WorkspaceActiveWindowChanged
            windowByWorkspace = Object.assign({}, windowByWorkspace, {[change.workspace_id]: change.active_window_id})
        } else if (event.WindowsChanged) {
            const names = {}
            for (const w of event.WindowsChanged.windows) names[w.id] = w.app_id
            apps = names
        } else if (event.WindowOpenedOrChanged) {
            const w = event.WindowOpenedOrChanged.window
            if (apps[w.id] !== w.app_id) apps = Object.assign({}, apps, {[w.id]: w.app_id})
        } else if (event.WindowClosed) {
            const names = Object.assign({}, apps)
            delete names[event.WindowClosed.id]
            apps = names
        }
    }

    Socket {
        id: events
        path: Quickshell.env("NIRI_SOCKET")
        connected: true
        onConnectionStateChanged: if (connected) write('"EventStream"\n')
        parser: SplitParser { onRead: line => state.update(JSON.parse(line)) }
    }
    Socket {
        id: commands
        path: events.path
        connected: true
        parser: SplitParser {
            onRead: line => {
                const reply = JSON.parse(line)
                if (reply.Err) console.warn(reply.Err)
            }
        }
    }
    Timer {
        interval: 1000
        running: !events.connected || !commands.connected
        repeat: true
        onTriggered: {
            if (!events.connected) events.connected = true
            if (!commands.connected) commands.connected = true
        }
    }
}
