import QtQuick
import qs.component

BarSection {
    id: sec

    Row {
        id: menu
        spacing: Theme.powermenu.spacing
        property string icon: Theme.powermenu.formatIcon["menu"]

        StyledText {
            color: sec.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: menu.icon
            font.bold: true
        }
        StyledText {
            // visible: sec.hovered
            color: sec.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: sec.hovered ? "powermenu" : ""
        }
    }
}
