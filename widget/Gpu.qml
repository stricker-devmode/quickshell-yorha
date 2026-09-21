import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.component


BarSection {
    id: sec
    visible: usage.visible || temperature.visible
    RowLayout {
    spacing: Theme.gpu.spacing
        StyledText {
            id: usage
            visible: StatMon.gpuTempPathReady
            property string icon: Theme.gpu.usageIcon
            property string val: Theme.gpu.decimals >= 0 ? StatMon.gpuUsage.toFixed(Theme.gpu.decimals) : StatMon.gpuUsage

            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${icon} ${val}%`
        }
        StyledText {
            id: temperature
            visible: StatMon.gpuTempPathReady
            property string icon: Theme.gpu.tempIcon
            property string val: Theme.gpu.decimals >= 0 ? StatMon.gpuTemp.toFixed(Theme.gpu.decimals) : StatMon.gpuTemp

            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${icon} ${val}󰔄`
        }
    }
}
