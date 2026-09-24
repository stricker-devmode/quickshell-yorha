import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.component


BarSection {
    id: sec
    RowLayout {
    spacing: Theme.cpu.spacing
        Row {
            id: usage
            spacing: Theme.cpu.spacing
            property int length: Theme.metrics.floatMaxLength
            property string icon: Theme.cpu.usageIcon
            property string val: StatMon.cpuUsage.toFixed(Theme.cpu.decimals)

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
            spacing: Theme.cpu.spacing
            property int length: Theme.metrics.floatMaxLength
            property string icon: Theme.cpu.tempIcon
            property string val: StatMon.cpuTemp.toFixed(Theme.cpu.decimals)

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
