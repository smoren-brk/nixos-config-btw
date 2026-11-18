// SPDX-License-Identifier: GPL-3.0-only
// Adapted from caelestia-dots/shell modules/dashboard/media/Details.qml.
// See LICENSES/Caelestia-GPL-3.0.txt and README.md for attribution.
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Services.Mpris
import "../../components/theme"
import "../../services"

Item {
    id: root
    property var player: MediaService.active
    property bool active: false
    readonly property bool knownLength: (player?.lengthSupported ?? false) && player.length > 0 && player.length < 2147483647
    readonly property bool canSeek: knownLength && (player?.canSeek ?? false) && (player?.positionSupported ?? false)
    readonly property bool interacting: seek.pressed || selector.down || selector.popup.visible
    property var seekingPlayer: null
    property real seekPosition: 0
    implicitHeight: 224
    onActiveChanged: if (!active) selector.popup.close()

    function lengthStr(seconds): string {
        if (!Number.isFinite(seconds) || seconds < 0) return "--:--";
        const hours = Math.floor(seconds / 3600);
        const minutes = Math.floor((seconds % 3600) / 60);
        const remainder = Math.floor(seconds % 60).toString().padStart(2, "0");
        return hours > 0 ? `${hours}:${minutes.toString().padStart(2, "0")}:${remainder}` : `${minutes}:${remainder}`;
    }

    Timer {
        interval: 1000
        repeat: true
        triggeredOnStart: true
        running: root.active && (root.player?.isPlaying ?? false)
        onTriggered: root.player?.positionChanged()
    }

    RowLayout {
        anchors.fill: parent
        spacing: 24

        ClippingRectangle {
            Layout.preferredWidth: 164
            Layout.preferredHeight: 164
            Layout.alignment: Qt.AlignVCenter
            radius: 24
            color: Theme.panelSurfaceColor
            Image {
                id: cover
                anchors.fill: parent
                source: root.player?.trackArtUrl ?? ""
                sourceSize.width: 328
                sourceSize.height: 328
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                visible: status === Image.Ready
            }
            Text {
                anchors.centerIn: parent
                visible: !cover.visible
                text: Icons.music
                font.family: Typography.nerdIconFontFamily
                font.pixelSize: 64
                color: Theme.accentColor
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 6

            ComboBox {
                id: selector
                Layout.fillWidth: true
                implicitHeight: 28
                model: MediaService.players
                textRole: "identity"
                currentIndex: MediaService.players.indexOf(root.player)
                enabled: count > 1
                onActivated: index => MediaService.select(MediaService.players[index])
                Accessible.name: "Media player"
                background: Rectangle { radius: 6; color: selector.hovered ? Theme.panelSurfaceColor : "transparent" }
                contentItem: Text {
                    text: root.player?.identity || "Media"
                    font.family: Typography.bodyFontFamily
                    font.pixelSize: 12
                    color: Theme.secondaryTextColor
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    rightPadding: 24
                }
                indicator: Text {
                    anchors { right: parent.right; verticalCenter: parent.verticalCenter; rightMargin: 6 }
                    visible: selector.count > 1
                    text: "⌄"
                    color: Theme.secondaryTextColor
                }
                delegate: ItemDelegate {
                    required property var modelData
                    required property int index
                    width: selector.width
                    text: modelData.identity
                    highlighted: selector.highlightedIndex === index
                    contentItem: Text { text: parent.text; color: Theme.primaryTextColor; font.family: Typography.bodyFontFamily; font.pixelSize: 12; elide: Text.ElideRight }
                    background: Rectangle { radius: 6; color: parent.highlighted ? Theme.selectedSurfaceColor : Theme.panelSurfaceColor }
                }
                popup: Popup {
                    y: selector.height
                    width: selector.width
                    implicitHeight: Math.min(180, playerList.contentHeight + 8)
                    padding: 4
                    background: Rectangle { color: Theme.panelSurfaceColor; radius: 8; border.color: Theme.surfaceBorderColor; border.width: 1 }
                    contentItem: ListView { id: playerList; clip: true; implicitHeight: contentHeight; model: selector.popup.visible ? selector.delegateModel : null; currentIndex: selector.highlightedIndex }
                }
            }

            Text {
                Layout.fillWidth: true
                text: root.player ? root.player.trackTitle || "Unknown title" : "Nothing playing"
                color: Theme.primaryTextColor
                font.family: Typography.bodyFontFamily
                font.pixelSize: 20
                font.weight: Font.DemiBold
                elide: Text.ElideRight
            }
            Text {
                Layout.fillWidth: true
                text: root.player ? root.player.trackArtist || "Unknown artist" : "Play something for it to appear here"
                color: Theme.secondaryTextColor
                font.family: Typography.bodyFontFamily
                font.pixelSize: 13
                elide: Text.ElideRight
            }
            Text {
                Layout.fillWidth: true
                text: root.player?.trackAlbum || ""
                color: Theme.mutedTextColor
                font.family: Typography.bodyFontFamily
                font.pixelSize: 12
                elide: Text.ElideRight
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.topMargin: 6
                spacing: 8
                Text {
                    text: root.lengthStr(seek.pressed ? seek.value : root.player?.position ?? -1)
                    color: Theme.secondaryTextColor
                    font.family: Typography.bodyFontFamily
                    font.pixelSize: 11
                }
                Slider {
                    id: seek
                    Layout.fillWidth: true
                    from: 0
                    to: root.knownLength ? root.player.length : 1
                    enabled: root.canSeek
                    implicitHeight: 24
                    Accessible.name: "Track position"
                    Binding { target: seek; property: "value"; value: root.player?.position ?? 0; when: !seek.pressed }
                    onPressedChanged: {
                        if (pressed) {
                            root.seekingPlayer = root.player;
                            root.seekPosition = value;
                        } else if (root.canSeek && root.player === root.seekingPlayer) root.player.position = root.seekPosition;
                    }
                    onMoved: {
                        root.seekPosition = value;
                        if (!pressed && root.canSeek) root.player.position = value;
                    }
                    background: Rectangle {
                        x: seek.leftPadding
                        y: (seek.height - height) / 2
                        width: seek.availableWidth
                        height: 4
                        radius: 2
                        color: Theme.selectedSurfaceColor
                        Rectangle { width: parent.width * seek.visualPosition; height: parent.height; radius: 2; color: Theme.accentColor }
                    }
                    handle: Rectangle {
                        x: seek.leftPadding + seek.visualPosition * (seek.availableWidth - width)
                        y: (seek.height - height) / 2
                        width: 10; height: 10; radius: 5
                        color: Theme.primaryTextColor
                        visible: seek.enabled
                    }
                }
                Text {
                    text: root.lengthStr(root.knownLength ? root.player.length : -1)
                    color: Theme.secondaryTextColor
                    font.family: Typography.bodyFontFamily
                    font.pixelSize: 11
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 6
                MediaButton {
                    glyph: Icons.shuffle; label: "Shuffle"
                    active: root.player?.shuffle ?? false
                    enabled: (root.player?.canControl ?? false) && (root.player?.shuffleSupported ?? false)
                    onClicked: root.player.shuffle = !root.player.shuffle
                }
                MediaButton {
                    glyph: Icons.previous; label: "Previous track"
                    enabled: root.player?.canGoPrevious ?? false
                    onClicked: root.player.previous()
                }
                MediaButton {
                    Layout.fillWidth: true
                    glyph: root.player?.isPlaying ? Icons.pause : Icons.play
                    label: root.player?.isPlaying ? "Pause" : "Play"
                    prominent: true
                    enabled: root.player?.canTogglePlaying ?? false
                    onClicked: root.player.togglePlaying()
                }
                MediaButton {
                    glyph: Icons.next; label: "Next track"
                    enabled: root.player?.canGoNext ?? false
                    onClicked: root.player.next()
                }
                MediaButton {
                    glyph: root.player?.loopState === MprisLoopState.Track ? Icons.repeatOne : Icons.repeat
                    label: root.player?.loopState === MprisLoopState.Track ? "Repeat track" : root.player?.loopState === MprisLoopState.Playlist ? "Repeat all" : "Repeat off"
                    active: (root.player?.loopState ?? MprisLoopState.None) !== MprisLoopState.None
                    enabled: (root.player?.canControl ?? false) && (root.player?.loopSupported ?? false)
                    onClicked: root.player.loopState = root.player.loopState === MprisLoopState.None ? MprisLoopState.Track
                        : root.player.loopState === MprisLoopState.Track ? MprisLoopState.Playlist : MprisLoopState.None
                }
            }
        }
    }
}
