import Quickshell.Widgets
import QtQuick

StyledRect {
    color: pointer.hovered ? Theme.rectColourHover : Theme.rectColour
    property var pointer: mouse

    HoverHandler {
        id: mouse
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }
}
