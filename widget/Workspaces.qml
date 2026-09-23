import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.component


Row {
    id: sec
    property int monitorId: Hyprland.monitorFor(screen).id
    property int numWs: UtilHyprland.workspacesByMonitor[monitorId]?.length ?? 0
    spacing: 0

    Repeater {
        model: sec.numWs
        Layout.alignment: Qt.AlignCenter

        StyledRect {
            required property int index
            property HyprlandWorkspace ws: UtilHyprland.workspacesByMonitor[sec.monitorId][index]
            property bool focused: ws === null ? false : (ws.focused || ws.id === UtilHyprland.activeWorkspaceId)
            property string name: ws !== null ? ws.name : "default"

            width: Math.max(implicitHeight, child?.implicitWidth ?? 0)
            color: focused ? Theme.rect.colourHover : Theme.rect.colour
            
            StyledText {
                text: Theme.workspace.format[name] || Theme.workspace.format["default"]
                color: focused ? Theme.font.colourInverse : Theme.font.colour
                font.bold: true
            }
        }
    }
}
