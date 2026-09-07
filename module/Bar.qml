import Quickshell
import Quickshell.Io
import QtQuick
import "../widget"
import "../component"

Scope {
    id: root
    property string time

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            color: Colour.foreground_inv
            implicitHeight: 30

            anchors {
                bottom: true
                left: true
                right: true
            }

            Clock {
                color: Colour.foreground
                anchors.centerIn: parent
            }
        }
    }
}
