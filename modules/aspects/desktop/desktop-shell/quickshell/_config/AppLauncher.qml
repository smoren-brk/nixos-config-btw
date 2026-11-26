import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import "Palette.js" as Palette

PanelWindow {
    id: launcher
    visible: false
    color: "transparent"
    anchors { top: true; bottom: true; left: true; right: true }
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.namespace: "quickshell-app-launcher"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    BackgroundEffect.blurRegion: Region { item: card; radius: card.radius }

    function openOn(output) {
        if (!output) return
        screen = output
        search.clear()
        visible = true
        list.currentIndex = list.count ? 0 : -1
        list.positionViewAtBeginning()
        search.forceActiveFocus()
    }

    function launch(app) {
        if (!app) return
        visible = false
        if (app.runInTerminal) {
            Quickshell.execDetached({command: ["ghostty", "-e", ...app.command], workingDirectory: app.workingDirectory})
        } else {
            app.execute()
        }
    }

    readonly property var matches: {
        if (!visible) return []
        const query = search.text.trim().toLowerCase()
        const words = query.split(/\s+/)
        const apps = DesktopEntries.applications.values.filter(app => {
            const fields = [app.name, app.genericName, app.id, ...app.keywords].join(" ").toLowerCase()
            return words.every(word => fields.includes(word))
        })
        return apps.sort((a, b) => {
            const prefix = Number(b.name.toLowerCase().startsWith(query)) - Number(a.name.toLowerCase().startsWith(query))
            return prefix || a.name.localeCompare(b.name)
        })
    }

    MouseArea {
        anchors.fill: parent
        onClicked: mouse => {
            if (!card.contains(mapToItem(card, mouse.x, mouse.y))) launcher.visible = false
        }
    }
    Rectangle {
        id: card
        readonly property int rowHeight: 40
        readonly property int maxListHeight: Math.max(rowHeight, Math.min(6 * rowHeight, launcher.height - 100))
        anchors.horizontalCenter: parent.horizontalCenter
        y: Math.max(8, (launcher.height - 64 - maxListHeight) / 2)
        width: Math.min(440, launcher.width - 24)
        height: 64 + (list.count ? list.height : empty.height)
        radius: 12
        color: Qt.alpha(Palette.surface, 0.94)
        border.color: Qt.alpha(Palette.border, 0.78)

        BarText {
            id: searchIcon
            x: 18
            height: 52
            text: ""
            font.family: "0xProto Nerd Font"
            font.pixelSize: 17
            color: Palette.accent
        }
        TextField {
            id: search
            anchors { left: searchIcon.right; leftMargin: 12; right: parent.right; rightMargin: 16 }
            height: 52
            padding: 0
            background: null
            placeholderText: "Search applications"
            Accessible.name: placeholderText
            font.family: "Noto Sans"
            font.pixelSize: 16
            color: Palette.foreground
            placeholderTextColor: Palette.secondary
            selectionColor: Palette.selection
            selectedTextColor: Palette.foreground
            Keys.onEscapePressed: launcher.visible = false
            Keys.onDownPressed: list.incrementCurrentIndex()
            Keys.onUpPressed: list.decrementCurrentIndex()
            onAccepted: launcher.launch(launcher.matches[list.currentIndex])
        }
        Rectangle {
            x: 14; y: 51
            width: parent.width - 28; height: 1
            color: Qt.alpha(Palette.border, 0.65)
        }
        ListView {
            id: list
            x: 7; y: 57
            width: parent.width - 14
            height: Math.min(count * card.rowHeight, card.maxListHeight)
            model: launcher.matches
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            onModelChanged: {
                currentIndex = launcher.matches.length ? 0 : -1
                positionViewAtBeginning()
            }
            delegate: Rectangle {
                id: result
                required property var modelData
                required property int index
                readonly property string appIcon: modelData.icon
                width: ListView.view.width
                height: card.rowHeight
                radius: 7
                color: ListView.isCurrentItem ? Palette.hover : "transparent"
                Image {
                    id: icon
                    anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
                    width: 22; height: 22
                    sourceSize: Qt.size(22, 22)
                    source: !result.appIcon ? "" : result.appIcon.startsWith("/") ? "file://" + result.appIcon
                                                                                  : Quickshell.iconPath(result.appIcon, true)
                    fillMode: Image.PreserveAspectFit
                }
                BarText {
                    anchors.centerIn: icon
                    visible: icon.status !== Image.Ready
                    text: result.modelData.name.charAt(0).toUpperCase()
                    color: Palette.accent
                }
                BarText {
                    anchors { left: icon.right; leftMargin: 12; right: parent.right; rightMargin: 12; verticalCenter: parent.verticalCenter }
                    text: result.modelData.name
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onPositionChanged: list.currentIndex = result.index
                    onClicked: launcher.launch(result.modelData)
                }
            }
        }
        BarText {
            id: empty
            visible: !list.count
            x: 18; y: 57
            height: 40
            color: Palette.secondary
            text: "No matching applications"
        }
    }
}
