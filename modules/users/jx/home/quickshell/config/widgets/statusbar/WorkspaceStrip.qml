import QtQuick
import "../../components/theme"
import Quickshell.Hyprland

Item {
    id: root

    required property string outputName

    readonly property var workspaces: Hyprland.workspaces.values
        .filter(workspace => workspace.monitor?.name === outputName
            && !workspace.name.startsWith("special:"))
        .sort((left, right) => left.id - right.id)
    readonly property int activePosition: {
        const position = workspaces.findIndex(workspace => workspace.active);
        return Math.max(0, position);
    }
    property int previousActivePosition: activePosition
    property real starRotation: 0

    implicitWidth: workspaceRow.width + 8
    implicitHeight: 32

    onActivePositionChanged: {
        const direction = activePosition >= previousActivePosition ? 1 : -1;
        starRotation += direction * 180;
        previousActivePosition = activePosition;
    }

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: Theme.selectedSurfaceColor
    }

    Rectangle {
        id: highlight
        visible: root.workspaces.length > 0

        x: workspaceRow.x + root.activePosition * (26 + workspaceRow.spacing)
        anchors.verticalCenter: parent.verticalCenter
        width: 26
        height: 26
        radius: height / 2
        color: Theme.accentHoverColor

        Text {
            anchors.centerIn: parent
            text: Icons.activeWorkspace
            color: Theme.accentTextColor
            font.family: Typography.symbolIconFontFamily
            font.pixelSize: 18
            rotation: root.starRotation

            Behavior on rotation {
                NumberAnimation {
                    duration: 700
                    easing.type: Easing.OutCubic
                }
            }
        }

        Behavior on x {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutCubic
            }
        }

        Behavior on width {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }
        }
    }

    Row {
        id: workspaceRow
        x: 4
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        Repeater {
            id: workspaceRepeater
            model: root.workspaces

            Item {
                id: delegate

                required property var modelData

                width: 26
                height: 26

                Text {
                    anchors.centerIn: parent
                    visible: !delegate.modelData.active
                    text: Icons.inactiveWorkspace
                    color: delegate.modelData.urgent
                            ? Theme.dangerColor
                            : Theme.mutedTextColor
                    font.family: Typography.symbolIconFontFamily
                    font.pixelSize: 18
                    scale: 0.6

                    Behavior on scale {
                        NumberAnimation {
                            duration: 150
                            easing.type: Easing.OutCubic
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: delegate.modelData.activate()
                }
            }
        }
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }
}
