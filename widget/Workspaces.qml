import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.component


RowLayout {
    property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
    spacing: 0

    Repeater {
        model: UtilHyprland.workspacesByMonitor[monitor.id].length

        StyledRect {
            required property int index
            property int workspaceId: UtilHyprland.workspacesByMonitor[monitor.id][index].id
            property bool focused: Hyprland.focusedMonitor?.activeWorkspace?.id === workspaceId
            color: focused ? Theme.rect.colourHover : Theme.rect.colour
            border {
                color: "red"
                width: 1
            }

            // implicitWidth: wsText.implicitWidth
            // implicitHeight: wsText.implicitHeight
            
            StyledText {
                id: wsText
                // text: Hyprland.monitorFor(screen).id
                text: workspaceId
                color: focused ? Theme.font.colourInverse : Theme.font.colour
            }
        }
    }
}
