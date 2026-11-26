import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: window
    required property NotificationStore store
    required property bool showOnOutput
    required property bool barVisible
    visible: showOnOutput && store.toasts.length > 0
    anchors { top: true; right: true }
    margins { top: barVisible ? 58 : 10; right: 10 }
    exclusionMode: ExclusionMode.Ignore
    implicitWidth: Math.min(340, (screen?.width ?? 360) - 20)
    implicitHeight: column.implicitHeight + 12
    WlrLayershell.namespace: "quickshell-notifications"
    WlrLayershell.layer: WlrLayer.Overlay
    color: "transparent"
    BackgroundEffect.blurRegion: Region { item: surface; radius: surface.radius }
    PanelSurface {
        id: surface
        anchors.fill: parent
        Column {
            id: column
            x: 6; y: 6
            width: parent.width - 12
            spacing: 5
            Repeater {
                model: window.showOnOutput ? window.store.toasts : []
                NotificationCard {
                    required property var modelData
                    width: column.width
                    entry: modelData
                    condensed: true
                }
            }
        }
    }
}
