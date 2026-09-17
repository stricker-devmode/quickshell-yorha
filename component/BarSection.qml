import Quickshell.Widgets
import QtQuick

ClippingWrapperRectangle {
    color: pointer.hovered ? Theme.rectColourHover : Theme.rectColour
    margin: Theme.rectMargin
    radius: Theme.rectRadius
    property var pointer: mouse

    HoverHandler {
        id: mouse
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }
}
