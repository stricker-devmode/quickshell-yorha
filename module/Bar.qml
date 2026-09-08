import Quickshell
import Quickshell.Io
import QtQuick
import "../widget"
import "../component"

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        StyledPanelWindow {
            required property var modelData
            screen: modelData
            implicitHeight: Theme.barHeight

            anchors {
                bottom: true
                left: true
                right: true
            }

            Clock {
                anchors.centerIn: parent
            }
        }
    }
}
