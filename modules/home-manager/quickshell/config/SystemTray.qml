import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    property color backgroundColor: "#FFFFFF"
    property color foregroundColor: "#000000"
    required property var window

    color: backgroundColor
    radius: width / 2

    implicitHeight: content.implicitHeight + 20

    ColumnLayout {
        id: content

        anchors.fill: parent
        anchors.margins: 10
        spacing: 8

        Repeater {
            model: SystemTray.items

            Item {
                required property var modelData

                Layout.fillWidth: true
                Layout.preferredHeight: width

                QsMenuAnchor {
                    id: menuAnchor
                    menu: modelData.menu
                    anchor.window: window
                }

                IconImage {
                    anchors.fill: parent
                    source: modelData.icon
                }

                MouseArea {
                    anchors.fill: parent

                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onClicked: mouse => {
                        if (mouse.button === Qt.LeftButton)
                            modelData.activate()
                        else if (mouse.button === Qt.RightButton && modelData.hasMenu)
                            menuAnchor.open()
                    }
                }
            }
        }
    }
}

