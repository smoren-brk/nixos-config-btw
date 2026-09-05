import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property color textColor: "#FFFFFF"

    implicitWidth: content.implicitWidth + 16
    implicitHeight: content.implicitHeight

    ColumnLayout {
        id: content

        anchors.centerIn: parent
        spacing: 0

        Text {
            Layout.alignment: Qt.AlignHCenter

            font.family: "JetBrainsMono NF"
            font.pixelSize: 24

            text: "󰃭"
            color: root.textColor
        }

        ColumnLayout {
            spacing: -8
            Layout.alignment: Qt.AlignHCenter

            Text {
                Layout.alignment: Qt.AlignHCenter

                font.family: "JetBrainsMono NF"
                font.pixelSize: 20

                text: Time.hour
                color: root.textColor
            }

            Text {
                Layout.alignment: Qt.AlignHCenter

                font.family: "JetBrainsMono NF"
                font.pixelSize: 20

                text: Time.minute
                color: root.textColor
            }
        }
    }
}

