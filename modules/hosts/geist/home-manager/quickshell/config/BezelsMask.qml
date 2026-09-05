import Quickshell
import QtQuick
import QtQuick.Effects

PanelWindow {
    color: "transparent"

    anchors {
        left: true
        right: true
        top: true
        bottom: true
    }
    mask: Region {
        item: effectContainer
        intersection: Intersection.Xor
    }

    Item {
        id: effectContainer
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            color: "#FF0000"
            layer.enabled: true

            layer.effect: MultiEffect {
                maskSource: cutoutShape
                maskEnabled: true
                maskInverted: true
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1
            }
        }

        Item {
            id: cutoutShape
            anchors.fill: parent
            layer.enabled: true
            visible: false

            Rectangle {
                anchors.fill: parent

                anchors {
                    leftMargin: 1
                    rightMargin: 1
                    topMargin: 1
                    bottomMargin: 1
                }

                radius: 20
            }
        }
    }
}

