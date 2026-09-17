import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.component


BarSection {
    id: sec
    RowLayout {
    spacing: Theme.cpu.spacing
        StyledText {
            id: usage
            property string icon: Theme.cpu.usageIcon
            property string val: Theme.cpu.decimals >= 0 ? StatMon.cpuUsage.toFixed(Theme.cpu.decimals) : StatMon.cpuUsage

            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${icon} ${val}%`
        }
        StyledText {
            id: temperature
            property string icon: Theme.cpu.tempIcon
            property string val: Theme.cpu.decimals >= 0 ? StatMon.cpuTemp.toFixed(Theme.cpu.decimals) : StatMon.cpuTemp

            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${icon} ${val}󰔄`
        }
    }
}
