import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    required property var screen
    property color foregroundColor: "#FFFFFF"
    property color backgroundColor: "#000000"
    property color accentColor: "#505050"

    color: backgroundColor
    radius: width / 2

    implicitHeight: workspacesColumn.implicitHeight + 10

    function getAppIcon(app) {
        switch (app.toLowerCase()) {
            case "kitty":
            case "alacritty":
            case "konsole":
                return "󰆍";

            case "org.kde.dolphin":
                return "󰉖";

            case "firefox":
                return "󰈹";

            case "discord":
                return "󰙯";

            case "steam":
                return "󰓓";

            case "vlc":
                return "󰕼";

            default:
                return "󰧞";
        }
    }

    ColumnLayout {
        id: workspacesColumn

        anchors.fill: parent
        anchors.margins: 5
        spacing: 5

        Repeater {
            model: Hyprland.workspaces.values.filter(ws => ws.monitor.name === screen.name)

            Rectangle {
                required property var modelData
                property var workspace: modelData

                color: workspace.focused ? root.accentColor : "transparent"

                Layout.preferredWidth: workspacesColumn.width
                Layout.preferredHeight: content.implicitHeight
                Layout.alignment: Qt.AlignHCenter

                radius: height / 2

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        workspace.activate()
                        console.log(workspace.monitor.name)
                        console.log(screen.name)
                        console.log(workspace.monitor.name === screen.name)
                    }
                }

                ColumnLayout {
                    id: content
                    anchors.fill: parent
                    spacing: 0

                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: width

                        Text {
                            anchors.centerIn: parent
                            text: workspace.name
                            font.family: "JetBrainsMono NF"
                            font.pixelSize: 14
                            color: workspace.focused ? backgroundColor : foregroundColor
                        }
                    }

                    ColumnLayout {
                        Layout.leftMargin: 5
                        Layout.rightMargin: 5
                        Layout.bottomMargin: 5

                        visible: toplevelContainer.count > 0 ? true : false
                        spacing: 5

                        Repeater {
                            id: toplevelContainer
                            model: workspace.toplevels

                            Item {
                                required property var modelData
                                property var toplevel: modelData

                                Layout.fillWidth: true
                                Layout.preferredHeight: width

                                Layout.alignment: Qt.AlignHCenter

                                Text {
                                    anchors.centerIn: parent
                                    text: getAppIcon(toplevel.wayland.appId)
                                    color: workspace.focused ? root.backgroundColor : root.foregroundColor
                                    font.pixelSize: parent.width
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

