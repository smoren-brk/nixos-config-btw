import QtQuick
import Quickshell
import Quickshell.Networking
import Quickshell.Services.Pipewire
import "Palette.js" as Palette

Row {
    id: row
    required property PanelWindow panel
    required property NotificationStore store
    required property bool compact
    readonly property bool centerOpen: center.visible
    signal launcherRequested()
    spacing: compact ? 12 : 20

    readonly property var device: Networking.devices.values.find(d => d.connected && d.type === DeviceType.Wired)
                               ?? Networking.devices.values.find(d => d.connected && d.type === DeviceType.Wifi)
    readonly property bool wireless: device?.type === DeviceType.Wifi
    readonly property var mic: Pipewire.defaultAudioSource
    readonly property var output: Pipewire.defaultAudioSink

    PwObjectTracker { objects: [row.mic, row.output] }
    SystemClock { id: clock; precision: SystemClock.Minutes }

    component Glyph: BarText {
        font.family: "0xProto Nerd Font"
        font.pixelSize: 17
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignHCenter
        width: Math.max(18, implicitWidth)
        height: row.height
        elide: Text.ElideNone
    }
    component ActionGlyph: Glyph {
        signal activated()
        Accessible.role: Accessible.Button
        Accessible.onPressAction: if (enabled) activated()
        TapHandler { onTapped: parent.activated() }
    }
    component AudioButton: ActionGlyph {
        required property PwNode node
        required property string activeGlyph
        required property string mutedGlyph
        readonly property bool muted: node?.audio?.muted ?? false
        enabled: !!node?.ready && !!node?.audio
        Accessible.checkable: true
        Accessible.checked: muted
        text: enabled && !muted ? activeGlyph : mutedGlyph
        onActivated: node.audio.muted = !node.audio.muted
    }
    component Label: BarText { height: row.height }

    Row {
        spacing: 6
        Glyph { text: row.wireless ? "" : row.device ? "󰈀" : "󰖪" }
        Label {
            visible: row.wireless && !row.compact
            width: Math.min(implicitWidth, 160)
            text: row.wireless ? (row.device.networks.values.find(n => n.connected)?.name ?? "Wi-Fi") : ""
        }
    }
    ActionGlyph {
        text: ""
        Accessible.name: "Open application launcher"
        onActivated: row.launcherRequested()
    }
    AudioButton {
        node: row.mic
        Accessible.name: "Mute microphone"
        activeGlyph: "󰍬"
        mutedGlyph: "󰍭"
    }
    AudioButton {
        node: row.output
        Accessible.name: "Mute sound"
        activeGlyph: "󰋋"
        mutedGlyph: "󰟎"
    }
    ActionGlyph {
        text: row.store.history.length ? "󰂚" : "󰂜"
        color: center.visible || row.store.unread ? Palette.accent : Palette.foreground
        Accessible.name: "Notifications"
        onActivated: center.visible = !center.visible
    }
    Label {
        text: Qt.formatDateTime(clock.date, "HH:mm")
        HoverHandler { id: clockHover }
        PopupWindow {
            anchor.window: row.panel
            anchor.rect.x: row.panel.width - implicitWidth - 10
            anchor.rect.y: row.panel.height + 6
            visible: row.panel.visible && clockHover.hovered && !center.visible
            color: "transparent"
            implicitWidth: dateLabel.implicitWidth + 24
            implicitHeight: 32
            Rectangle {
                anchors.fill: parent
                radius: 8
                color: Palette.surface
                BarText { id: dateLabel; anchors.centerIn: parent; text: Qt.formatDateTime(clock.date, "dddd, d MMMM yyyy") }
            }
        }
    }

    NotificationCenter {
        id: center
        panel: row.panel
        store: row.store
    }
}
