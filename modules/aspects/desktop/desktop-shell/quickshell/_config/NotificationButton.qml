import QtQuick
import "Palette.js" as Palette

Rectangle {
    id: button
    required property string label
    property string accessibleName: label
    signal activated()
    implicitWidth: textItem.implicitWidth + 14
    implicitHeight: 24
    radius: 6
    color: mouse.containsMouse ? Palette.hover : "transparent"
    Accessible.role: Accessible.Button
    Accessible.name: accessibleName
    Accessible.onPressAction: activated()
    BarText {
        id: textItem
        anchors.centerIn: parent
        width: Math.min(implicitWidth, button.width - 10)
        font.pixelSize: 12
        color: Palette.secondary
        text: button.label
    }
    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: button.activated()
    }
}
