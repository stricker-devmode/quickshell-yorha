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
            property string icon: Theme.mem.usageIcon
            property string val: Theme.mem.decimals >= 0 ? StatMon.memUsage.toFixed(Theme.mem.decimals) : StatMon.memUsage

            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${icon} ${val}%`
        }
        StyledText {
            id: total
            visible: Theme.mem.showTotal
            property string unit: Theme.mem.unit
            property string val: {
                switch (unit) {
                    case "KiB": return `${StatMon.memUsedKiB}/${StatMon.memTotalKiB}`;
                    case "MiB": return `${StatMon.memUsedMiB}/${StatMon.memTotalMiB}`;
                    case "GiB": return `${StatMon.memUsedGiB}/${StatMon.memTotalGiB}`;
                    default: return `${StatMon.memUsedGiB}/${StatMon.memTotalGiB}`;
                }
            }

            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${val} ${unit}`
        }
    }
}
