import Quickshell
import QtQuick

Rectangle {
    color: mouse.hovered ? Theme.colourForeground : Theme.colourForeground_inv

    HoverHandler {
        id: mouse
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }
}
