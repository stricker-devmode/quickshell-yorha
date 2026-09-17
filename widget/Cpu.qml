import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.component


BarSection {
    id: sec
    RowLayout {
    spacing: Theme.widgetCpuSpacing
        StyledText {
            id: usage
            property string icon: Theme.widgetCpuUsageIcon
            property string val: Theme.widgetCpuDecimals >= 0 ? StatMon.cpuUsage.toFixed(Theme.widgetCpuDecimals) : StatMon.cpuUsage

            color: sec.pointer.hovered ? Theme.fontColourInverse : Theme.fontColour
            text: `${icon} ${val}%`
        }
        StyledText {
            id: temperature
            property string icon: Theme.widgetCpuTempIcon
            property string val: Theme.widgetCpuDecimals >= 0 ? StatMon.cpuTemp.toFixed(Theme.widgetCpuDecimals) : StatMon.cpuTemp

            color: sec.pointer.hovered ? Theme.fontColourInverse : Theme.fontColour
            text: `${icon} ${val}󰔄`
        }
    }
}
