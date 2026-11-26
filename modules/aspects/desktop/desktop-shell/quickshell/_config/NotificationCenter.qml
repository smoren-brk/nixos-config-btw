import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "Palette.js" as Palette

PopupWindow {
    id: center
    required property PanelWindow panel
    required property NotificationStore store
    anchor.window: panel
    anchor.rect.x: panel.width - implicitWidth - 10
    anchor.rect.y: panel.height + 8
    grabFocus: true
    color: "transparent"
    implicitWidth: Math.min(360, panel.width)
    implicitHeight: header.implicitHeight + viewport.height + 32
    BackgroundEffect.blurRegion: Region { item: surface; radius: surface.radius }
    onVisibleChanged: {
        if (visible) {
            if (store.openCenter && store.openCenter !== center) store.openCenter.visible = false
            store.openCenter = center
            store.markRead()
        } else if (store.openCenter === center) {
            store.openCenter = null
        }
    }
    Connections {
        target: center.panel
        function onVisibleChanged() { if (!center.panel.visible) center.visible = false }
    }
    PanelSurface {
        id: surface
        anchors.fill: parent
        border.color: Qt.alpha(Palette.border, 0.6)
        focus: true
        Keys.onEscapePressed: center.visible = false
        RowLayout {
            id: header
            anchors { top: parent.top; left: parent.left; right: parent.right; margins: 12 }
            BarText { Layout.fillWidth: true; font.weight: Font.Bold; text: "Notifications" }
            NotificationButton {
                visible: center.store.history.length > 0
                label: "Clear all"
                onActivated: center.store.clearHistory()
            }
        }
        Flickable {
            id: viewport
            anchors { top: header.bottom; topMargin: 8; left: parent.left; right: parent.right; leftMargin: 10; rightMargin: 10 }
            height: Math.min(contentHeight, center.panel.screen.height * 0.55)
            contentHeight: cards.implicitHeight
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            Column {
                id: cards
                width: viewport.width
                spacing: 6
                BarText {
                    visible: center.store.history.length === 0
                    width: parent.width
                    height: 50
                    horizontalAlignment: Text.AlignHCenter
                    color: Palette.secondary
                    text: "No notifications"
                }
                Repeater {
                    model: center.visible ? center.store.history : []
                    NotificationCard {
                        required property var modelData
                        width: cards.width
                        entry: modelData
                    }
                }
            }
        }
    }
}
