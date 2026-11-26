import QtQuick
import "Palette.js" as Palette

Text {
    color: Palette.foreground
    font.family: "Noto Sans"
    font.pixelSize: 14
    font.weight: Font.DemiBold
    textFormat: Text.PlainText
    verticalAlignment: Text.AlignVCenter
    maximumLineCount: 1
    elide: Text.ElideRight
}
