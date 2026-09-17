import QtQuick
import qs.component

BarSection {
    id: sec
    StyledText {
        color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
        text: Time.time
    }
}
