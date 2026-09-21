import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.component


BarSection {
    id: sec
    RowLayout {
    spacing: Theme.mem.spacing
        StyledText {
            id: usage
            property int length: Theme.metrics.floatMaxLength
            property string icon: Theme.mem.usageIcon
            property string val: StatMon.memUsage.toFixed(Theme.mem.decimals)

            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${icon} ${val.padStart(length,"0").slice(0,length)}%`
        }
        StyledText {
            id: total
            visible: Theme.mem.showTotal
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

            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${icon} ${val} ${unit}`
        }
    }
}
