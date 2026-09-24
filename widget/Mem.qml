import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.component


BarSection {
    id: sec
    RowLayout {
    spacing: Theme.mem.spacing
        Row {
            id: usage
            spacing: Theme.mem.spacing
            property int length: Theme.metrics.floatMaxLength
            property string icon: Theme.mem.usageIcon
            property string val: StatMon.memUsage.toFixed(Theme.mem.decimals)

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
            id: total
            visible: Theme.mem.showTotal
            spacing: Theme.mem.spacing
            property string icon: Theme.mem.totalIcon
            property string unit: Theme.mem.unit
            property string val: {
                switch (unit) {
                    case "KiB": return `${StatMon.memUsedKiB.toFixed(Theme.mem.decimals)}/${StatMon.memTotalKiB.toFixed(Theme.mem.decimals)}`;
                    case "MiB": return `${StatMon.memUsedMiB.toFixed(Theme.mem.decimals)}/${StatMon.memTotalMiB.toFixed(Theme.mem.decimals)}`;
                    case "GiB": return `${StatMon.memUsedGiB.toFixed(Theme.mem.decimals)}/${StatMon.memTotalGiB.toFixed(Theme.mem.decimals)}`;
                    default: return `${StatMon.memUsedGiB.toFixed(Theme.mem.decimals)}/${StatMon.memTotalGiB.toFixed(Theme.mem.decimals)}`;
                }
            }

        StyledText {
            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: total.icon
        }
        StyledText {
            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${total.val} ${total.unit}`
        }
        }
    }
}
