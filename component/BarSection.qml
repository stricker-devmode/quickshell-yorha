import Quickshell.Widgets
import QtQuick

StyledRect {
    color: pointer.hovered ? Theme.rect.colourHover : Theme.rect.colour
    property var pointer: mouse

    HoverHandler {
        id: mouse
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }
}
