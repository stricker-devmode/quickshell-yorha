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
            id: bar
            required property var modelData
            screen: modelData
            implicitHeight: Theme.bar.heightPreferred

            anchors {
                top: true
                // bottom: true
                left: true
                right: true
            }

            RowLayout {
                id: sections
                spacing: 0
                anchors.fill: parent
                uniformCellSizes: true

                RowLayout {
                    id: left
                    spacing: Theme.bar.layoutSpacing
                    Layout.alignment: Qt.AlignLeft
                    Layout.fillWidth: true

                    Workspaces {}
                    Cpu {}
                    Gpu {}
                    Mem {}
                }
                Clock { Layout.alignment: Qt.AlignCenter }
                RowLayout {
                    id: right
                    spacing: Theme.bar.layoutSpacing
                    Layout.alignment: Qt.AlignRight
                    Layout.fillWidth: true

                    Battery {}
                }
            }
        }
    }
}
