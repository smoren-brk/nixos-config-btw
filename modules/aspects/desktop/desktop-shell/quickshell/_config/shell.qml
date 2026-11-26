//@ pragma ShellId niri-status-bar
//@ pragma Env QS_NO_RELOAD_POPUP=1
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import "Palette.js" as Palette

ShellRoot {
    id: shell
    readonly property var barModes: ["hover", "hidden", "shown"]
    property string barMode: "hover"
    NiriState { id: niri }
    NotificationStore { id: notifications }

    AppLauncher { id: launcher }
    function openLauncher(output) {
        if (notifications.openCenter) notifications.openCenter.visible = false
        launcher.openOn(output)
    }

    IpcHandler {
        target: "launcher"
        function toggle(): void {
            if (launcher.visible) {
                launcher.visible = false
                return
            }
            shell.openLauncher(Quickshell.screens.find(s => s.name === niri.focusedOutput) ?? Quickshell.screens[0])
        }
    }
    IpcHandler {
        target: "bar"
        function toggle(): void {
            shell.barMode = shell.barModes[(shell.barModes.indexOf(shell.barMode) + 1) % shell.barModes.length]
        }
    }

    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: barWindow
            required property var modelData
            screen: modelData
            readonly property bool expanded: shell.barMode === "shown" ||
                    (shell.barMode === "hover" && (edge.hovered || hideDelay.running || status.centerOpen))
            property real reveal: expanded ? 1 : 0
            property real revealOrigin: 0.5
            readonly property real panelWidth: Math.max(0, width - 20)

            Behavior on reveal {
                enabled: shell.barMode === "hover"
                NumberAnimation {
                    duration: barWindow.expanded ? 320 : 210
                    easing.type: barWindow.expanded ? Easing.OutCubic : Easing.InOutCubic
                }
            }
            visible: shell.barMode !== "hidden"
            anchors { top: true; left: true; right: true }
            implicitHeight: expanded || reveal > 0 ? 50 : 2
            exclusiveZone: shell.barMode === "shown" ? 50 : 0
            color: "transparent"
            WlrLayershell.namespace: "quickshell-status-bar"
            BackgroundEffect.blurRegion: Region { item: surface.visible ? surface : null; radius: surface.radius }

            readonly property var activeWorkspace: niri.activeByOutput[screen.name]
            readonly property string appId: niri.apps[niri.windowByWorkspace[activeWorkspace]] ?? ""
            readonly property string appName: appId ? (DesktopEntries.heuristicLookup(appId)?.name ?? appId) : ""

            HoverHandler {
                id: edge
                onHoveredChanged: {
                    if (hovered && barWindow.reveal === 0)
                        barWindow.revealOrigin = Math.max(0, Math.min(1, (point.position.x - 10) / Math.max(1, barWindow.panelWidth)))
                    if (hovered || shell.barMode !== "hover") hideDelay.stop()
                    else hideDelay.restart()
                }
            }
            Timer { id: hideDelay; interval: 180 }

            NotificationToasts {
                screen: barWindow.screen
                store: notifications
                showOnOutput: barWindow.screen.name === niri.focusedOutput
                barVisible: barWindow.expanded || barWindow.reveal > 0
            }

            PanelSurface {
                id: surface
                readonly property real seedWidth: Math.min(48, barWindow.panelWidth)
                visible: barWindow.reveal > 0
                width: Math.round(seedWidth + (barWindow.panelWidth - seedWidth) * barWindow.reveal)
                height: Math.round(2 + 38 * barWindow.reveal * barWindow.reveal)
                x: 10 + Math.round((barWindow.panelWidth - width) * barWindow.revealOrigin)
                y: Math.round(10 * barWindow.reveal)
                clip: true

                RowLayout {
                    // Clip the full-size layout so the labels keep their final positions as the glass opens.
                    x: 17 - surface.x
                    y: (surface.height - height) / 2
                    width: Math.max(0, barWindow.panelWidth - 21)
                    height: 40
                    opacity: Math.max(0, (barWindow.reveal - 0.55) / 0.45)
                    spacing: 12

                    Image {
                        source: Quickshell.iconPath("nix-snowflake")
                        sourceSize: Qt.size(22, 22)
                        fillMode: Image.PreserveAspectFit
                        Accessible.role: Accessible.Graphic
                        Accessible.name: "NixOS"
                    }

                    Rectangle {
                        implicitWidth: workspaceRow.width
                        implicitHeight: 26
                        radius: 8
                        color: Qt.alpha(Palette.hover, 0.92)

                        Row {
                            id: workspaceRow
                            Repeater {
                                model: niri.workspaces.filter(w => w.output === barWindow.screen.name)
                                Rectangle {
                                    id: button
                                    required property var modelData
                                    width: 34
                                    height: 26
                                    radius: 8
                                    color: mouse.containsMouse ? Palette.border : "transparent"
                                    BarText {
                                        anchors.centerIn: parent
                                        text: button.modelData.idx
                                        color: button.modelData.id === barWindow.activeWorkspace ? Palette.pink : Palette.secondary
                                    }
                                    MouseArea {
                                        id: mouse
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: niri.focusWorkspace(button.modelData.id)
                                    }
                                }
                            }
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 9
                        BarText {
                            visible: barWindow.appName.length > 0
                            font.pixelSize: 16
                            font.weight: Font.Bold
                            text: "❯"
                        }
                        Grid {
                            visible: barWindow.appName.length > 0
                            columns: 2
                            spacing: 2
                            Repeater {
                                model: 4
                                Rectangle { width: 8; height: 6; radius: 1.5; color: Palette.orange }
                            }
                        }
                        BarText {
                            Layout.fillWidth: true
                            Layout.minimumWidth: 0
                            font.pixelSize: 12
                            font.weight: Font.Bold
                            text: barWindow.appName
                        }
                    }

                    StatusRow {
                        id: status
                        Layout.fillHeight: true
                        panel: barWindow
                        store: notifications
                        compact: barWindow.panelWidth < 760
                        onLauncherRequested: shell.openLauncher(barWindow.screen)
                    }
                }
            }
        }
    }
}
