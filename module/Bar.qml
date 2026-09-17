import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
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
                top: true
                // bottom: true
                left: true
                right: true
            }
            RowLayout {
                spacing: Theme.barLayoutSpacing
                Cpu {}
                Gpu {}
                Mem {}
            }
            Clock {
                anchors.centerIn: parent
            }
        }
    }
}
