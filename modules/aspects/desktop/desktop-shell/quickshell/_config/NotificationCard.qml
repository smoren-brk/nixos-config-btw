import QtQuick
import QtQuick.Layouts
import "Palette.js" as Palette

Rectangle {
    id: card
    required property NotificationEntry entry
    property bool condensed: false
    implicitHeight: content.implicitHeight + 18
    radius: 8
    color: "transparent"
    border.color: Qt.alpha(Palette.border, 0.45)

    ColumnLayout {
        id: content
        anchors { left: parent.left; right: parent.right; top: parent.top; margins: 10 }
        spacing: 3
        RowLayout {
            Layout.fillWidth: true
            spacing: 6
            BarText {
                Layout.fillWidth: true
                font.pixelSize: 11
                color: card.entry.critical ? Palette.pink : Palette.accent
                text: card.entry.app
            }
            BarText {
                color: Palette.secondary
                font.pixelSize: 11
                text: Qt.formatTime(card.entry.received, "HH:mm")
            }
            NotificationButton {
                label: "×"
                accessibleName: "Dismiss notification"
                onActivated: card.entry.dismiss()
            }
        }
        BarText {
            Layout.fillWidth: true
            visible: text.length > 0
            font.weight: Font.Bold
            maximumLineCount: card.condensed ? 2 : 8
            wrapMode: Text.Wrap
            text: card.entry.title
        }
        BarText {
            Layout.fillWidth: true
            visible: text.length > 0
            font.pixelSize: 13
            font.weight: Font.Normal
            color: Palette.secondary
            maximumLineCount: card.condensed ? 3 : 128
            wrapMode: Text.Wrap
            text: card.entry.body
        }
        Flow {
            id: actions
            Layout.fillWidth: true
            Layout.preferredHeight: childrenRect.height
            visible: actionList.count > 0
            spacing: 4
            Repeater {
                id: actionList
                model: card.entry.notice?.actions ?? []
                NotificationButton {
                    required property var modelData
                    width: Math.min(implicitWidth, actions.width)
                    label: modelData.text || "Open"
                    onActivated: modelData.invoke()
                }
            }
        }
    }
}
