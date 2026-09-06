import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    property color backgroundColor: "#FFFFFF"
    property color foregroundColor: "#000000"

    color: backgroundColor
    radius: width / 2

    implicitHeight: width

    ColumnLayout {
        id: content

        anchors.fill: parent
        anchors.margins: 10
        spacing: 8

        Audio {
            Layout.preferredWidth: 15
            Layout.preferredHeight: 15
        }
    }
}

