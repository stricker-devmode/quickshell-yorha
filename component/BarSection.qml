import Quickshell.Widgets
import QtQuick

StyledRect {
    id: root
    color: hovered ? Theme.rect.colourHover : Theme.rect.colour
    property bool activated: false
    property bool hovered: hoverHandler.hovered
    property var onLeftClick: function() {}
    property var onRightClick: function() {}

    HoverHandler {
        id: hoverHandler
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }
    TapHandler {
        id: leftClickHandler
        acceptedButtons: Qt.LeftButton
        onTapped: root.onLeftClick
    }
    TapHandler {
        id: rightClickHandler
        acceptedButtons: Qt.RightButton
        onTapped: root.onRightClick
    }
}
