import Quickshell
import QtQuick

Text {
    horizontalAlignment: Text.AlignHCenter
    color: Theme.font.colour
    font {
        family: Theme.font.familyMono
        pixelSize: Theme.font.sizePreferredPx
    }
    width: implicitWidth
    Behavior on color {
        ColorAnimation {
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }
    Behavior on width {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }
}
