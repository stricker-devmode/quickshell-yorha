import QtQuick
import qs.component

BarSection {
    id: sec
    StyledText {
        color: sec.pointer.hovered ? Theme.fontColourInverse : Theme.fontColour
        text: Time.time
    }
}
