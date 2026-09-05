import Quickshell
import QtQuick

Item {
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: "#10FFFFFF"
    }

    Text {
        anchors.centerIn: parent

        font.family: "JetBrainsMono NF"
        font.pixelSize: 16

        text: ""
        color: "#FFFFFF"
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            Quickshell.execDetached(["pavucontrol"])
        }
    }
}

