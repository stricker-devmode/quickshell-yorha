import Quickshell.Widgets
import QtQuick

ClippingWrapperRectangle {
    color: Theme.rect.colour
    margin: Theme.rect.margin
    topMargin: Theme.rect.topMargin
    bottomMargin: Theme.rect.bottomMargin
    leftMargin: Theme.rect.leftMargin
    rightMargin: Theme.rect.rightMargin
    radius: Theme.rect.radius

    Behavior on color {
        ColorAnimation {
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }
}
