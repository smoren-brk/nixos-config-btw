import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../components"
import "../../components/theme"

PanelWindow {
    id: root
    property bool blocked: false
    property bool hoverOpen: false
    readonly property bool opened: hoverOpen && !blocked
    property real reveal: opened ? 1 : 0
    readonly property real occupiedHeight: surface.height
    readonly property real fullHeight: panel.implicitHeight + 32

    visible: opened || reveal > 0
    color: "transparent"
    anchors.top: true
    implicitWidth: Math.min(680, screen.width - 2 * ShellMetrics.borderWidth)
    // Animate the surface, never the Wayland window dimensions.
    implicitHeight: fullHeight + ShellMetrics.borderWidth
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "qqq-media"
    WlrLayershell.keyboardFocus: opened ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None
    mask: Region {
        x: 0; y: 0
        width: root.width
        height: Math.ceil(ShellMetrics.borderWidth + surface.height)
    }

    onBlockedChanged: if (blocked) hoverOpen = false
    onOpenedChanged: if (opened) hideTimer.restart()
    Behavior on reveal {
        NumberAnimation { duration: root.opened ? ShellMetrics.expandDuration : ShellMetrics.collapseDuration; easing.type: Easing.OutCubic }
    }
    Timer {
        id: hideTimer
        interval: ShellMetrics.hideDelay
        onTriggered: if (!hover.hovered && !panel.interacting) root.hoverOpen = false
    }

    // The activation strip meets the visible panel without a pointer gap.
    PanelWindow {
        screen: root.screen
        visible: !root.visible && !root.blocked
        anchors.top: true
        implicitWidth: root.implicitWidth - 40
        implicitHeight: ShellMetrics.borderWidth
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "wisp-media-activation"
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: root.hoverOpen = true
        }
    }

    Item {
        width: parent.width
        height: ShellMetrics.borderWidth + surface.height
        HoverHandler {
            id: hover
            onHoveredChanged: {
                if (hovered) {
                    hideTimer.stop();
                    root.hoverOpen = true;
                } else hideTimer.restart();
            }
        }
        AttachedSurface {
            id: surface
            x: 20
            y: ShellMetrics.borderWidth
            width: parent.width - 40
            height: root.fullHeight * root.reveal
            attachedTop: true
            radius: 20
            Item {
                anchors.fill: parent
                clip: true
                MediaPanel {
                    id: panel
                    x: 16; y: 16
                    width: parent.width - 32
                    height: implicitHeight
                    active: root.opened
                    enabled: root.opened
                    onInteractingChanged: if (!interacting && !hover.hovered) hideTimer.restart()
                    Keys.onEscapePressed: root.hoverOpen = false
                }
            }
        }
    }
}
