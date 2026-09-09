import Quickshell
import Quickshell.Io
import QtQuick
import qs.widget
import qs.component

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
