import QtQuick
import QtQuick.Controls
import "../../components/theme"

Button {
    id: root
    required property string glyph
    required property string label
    property bool prominent: false
    property bool active: false
    implicitWidth: prominent ? 72 : 38
    implicitHeight: 38
    hoverEnabled: true
    opacity: enabled ? 1 : 0.35
    Accessible.name: label
    ToolTip.visible: hovered
    ToolTip.delay: 600
    ToolTip.text: label

    background: Rectangle {
        radius: height / 2
        color: root.prominent ? (root.hovered ? Theme.accentHoverColor : Theme.accentColor)
            : root.hovered || root.active ? Theme.selectedSurfaceColor : Theme.panelSurfaceColor
        Behavior on color { ColorAnimation { duration: 110 } }
        border.width: root.visualFocus ? 1 : 0
        border.color: Theme.accentColor
    }
    contentItem: Text {
        text: root.glyph
        color: root.prominent ? Theme.accentTextColor : root.active ? Theme.accentColor : Theme.primaryTextColor
        font.family: Typography.nerdIconFontFamily
        font.pixelSize: root.prominent ? 26 : 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
