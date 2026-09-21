import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.component


RowLayout {
    property int monitorId: Hyprland.monitorFor(screen).id
    spacing: 0

    Repeater {
        model: UtilHyprland.workspacesByMonitor[monitorId].length

        StyledRect {
            required property int index
            property HyprlandWorkspace ws: UtilHyprland.workspacesByMonitor[monitorId][index] 
            property bool focused: ws !== null && ws.id === UtilHyprland.activeWorkspaceId
            property string name: ws !== null ? ws.name : "default"
            color: focused ? Theme.rect.colourHover : Theme.rect.colour
            border {
                color: "red"
                width: 1
            }
            
            StyledText {
                text: Theme.workspace.format[name] || Theme.workspace.format["default"]
                color: focused ? Theme.font.colourInverse : Theme.font.colour
            }
        }
    }
}
