import QtQuick
import qs.component
import qs.service

BarSection {
    id: sec
    StyledText {
        color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
        text: Time.time
    }
}
