import Quickshell.Widgets
import QtQuick

StyledRect {
    id: root
    color: hovered ? Theme.rect.colourHover : Theme.rect.colour
    signal leftClicked
    signal rightClicked
    property bool activated: false
    property bool hovered: hoverHandler.hovered

    HoverHandler {
        id: hoverHandler
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }
    TapHandler {
        id: leftClickHandler
        acceptedButtons: Qt.LeftButton
        onTapped: root.leftClicked()
    }
    TapHandler {
        id: rightClickHandler
        acceptedButtons: Qt.RightButton
        onTapped: root.rightClicked()
    }
}
