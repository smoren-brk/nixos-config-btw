//@ pragma UseQApplication

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel

            required property var modelData

            screen: modelData

            anchors {
                top: true
                left: true
                bottom: true
            }

            implicitWidth: 60
            color: "#131217"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10

                Text {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    text: ""
                    color: "#C5BEF8"
                    font.pixelSize: 28
                }

                Workspaces {
                    screen: modelData

                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true

                    foregroundColor: "#FFFFFF"
                    backgroundColor: "#1F1F25"
                    accentColor: "#C5BEF8"
                }

                Item { Layout.fillHeight: true }

                Clock {
                    Layout.alignment: Qt.AlignHCenter
                    textColor: "#ffffff"
                }

                SystemTray {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true

                    backgroundColor: "#1F1F25"
                    foregroundColor: "#C5BEF8"

                    window: panel
                }
            }
        }
    }
}

