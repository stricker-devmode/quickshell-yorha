import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.component


BarSection {
    id: sec
    visible: StatMon.gpuUsagePathReady || StatMon.gpuTempPathReady
    RowLayout {
    spacing: Theme.gpu.spacing
        Row {
            id: usage
            spacing: Theme.gpu.spacing
            visible: StatMon.gpuUsagePathReady
            property int length: Theme.metrics.floatMaxLength
            property string icon: Theme.gpu.usageIcon
            property string val: StatMon.gpuUsage.toFixed(Theme.gpu.decimals)

            StyledText {
                color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
                text: usage.icon
            }
            StyledText {
                color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
                text: `${usage.val.padStart(usage.length,"0").slice(0,usage.length)}%`
            }
        }
        Row {
            id: temp
            spacing: Theme.gpu.spacing
            visible: StatMon.gpuTempPathReady
            property int length: Theme.metrics.floatMaxLength
            property string icon: Theme.gpu.tempIcon
            property string val: StatMon.gpuTemp.toFixed(Theme.gpu.decimals)

            StyledText {
                color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
                text: temp.icon
            }
            StyledText {
                color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
                text: `${temp.val.padStart(temp.length,"0").slice(0,temp.length)}󰔄`
            }
        }
    }
}
