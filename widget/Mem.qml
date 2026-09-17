import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.component


BarSection {
    id: sec
    RowLayout {
    spacing: Theme.widgetMemSpacing
        StyledText {
            id: usage
            property string icon: Theme.widgetMemUsageIcon
            property string val: Theme.widgetMemDecimals >= 0 ? StatMon.memUsage.toFixed(Theme.widgetMemDecimals) : StatMon.memUsage

            color: sec.pointer.hovered ? Theme.fontColourInverse : Theme.fontColour
            text: `${icon} ${val}%`
        }
        StyledText {
            id: total
            visible: Theme.widgetMemShowTotal
            property string unit: Theme.widgetMemUnit
            property string val: {
                switch (unit) {
                    case "KiB": return `${StatMon.memUsedKiB}/${StatMon.memTotalKiB}`;
                    case "MiB": return `${StatMon.memUsedMiB}/${StatMon.memTotalMiB}`;
                    case "GiB": return `${StatMon.memUsedGiB}/${StatMon.memTotalGiB}`;
                    default: return `${StatMon.memUsedGiB}/${StatMon.memTotalGiB}`;
                }
            }

            color: sec.pointer.hovered ? Theme.fontColourInverse : Theme.fontColour
            text: `${val} ${unit}`
        }
    }
}
