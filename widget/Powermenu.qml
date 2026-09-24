import QtQuick
import qs.component

BarSection {
    id: sec

    Row {
        id: menu
        spacing: Theme.powermenu.spacing
        property string icon: Theme.powermenu.formatIcon["menu"]

        StyledText {
            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: menu.icon
            font.bold: true
        }
        StyledText {
            visible: sec.pointer.hovered
            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: "powermenu"
        }
    }
}
