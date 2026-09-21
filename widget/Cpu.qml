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
            property int length: Theme.metrics.floatMaxLength
            property string icon: Theme.cpu.usageIcon
            property string val: StatMon.cpuUsage.toFixed(Theme.cpu.decimals)

            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${icon} ${val.padStart(length,"0").slice(0,length)}%`
        }
        StyledText {
            id: temperature
            property int length: Theme.metrics.floatMaxLength
            property string icon: Theme.cpu.tempIcon
            property string val: StatMon.cpuTemp.toFixed(Theme.cpu.decimals)

            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${icon} ${val.padStart(length,"0").slice(0,length)}󰔄`
        }
    }
}
