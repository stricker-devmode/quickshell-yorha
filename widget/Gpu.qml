import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.component


BarSection {
    id: sec
    visible: StatMon.gpuUsagePathReady || StatMon.gpuTempPathReady
    RowLayout {
    spacing: Theme.gpu.spacing
        StyledText {
            id: usage
            property int length: Theme.metrics.floatMaxLength
            property string icon: Theme.gpu.usageIcon
            property string val: StatMon.gpuUsage.toFixed(Theme.gpu.decimals)

            visible: StatMon.gpuUsagePathReady
            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${icon} ${val.padStart(length,"0").slice(0,length)}%`
        }
        StyledText {
            id: temperature
            property int length: Theme.metrics.floatMaxLength
            property string icon: Theme.gpu.tempIcon
            property string val: StatMon.gpuTemp.toFixed(Theme.gpu.decimals)

            visible: StatMon.gpuTempPathReady
            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${icon} ${val.padStart(length,"0").slice(0,length)}󰔄`
        }
    }
}
