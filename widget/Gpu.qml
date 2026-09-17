import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.component


BarSection {
    id: sec
    RowLayout {
    spacing: Theme.widgetGpuSpacing
        StyledText {
            id: usage
            property string icon: Theme.widgetGpuUsageIcon
            property string val: Theme.widgetGpuDecimals >= 0 ? StatMon.gpuUsage.toFixed(Theme.widgetGpuDecimals) : StatMon.gpuUsage

            color: sec.pointer.hovered ? Theme.fontColourInverse : Theme.fontColour
            text: `${icon} ${val}%`
        }
        StyledText {
            id: temperature
            property string icon: Theme.widgetGpuTempIcon
            property string val: Theme.widgetGpuDecimals >= 0 ? StatMon.gpuTemp.toFixed(Theme.widgetGpuDecimals) : StatMon.gpuTemp

            color: sec.pointer.hovered ? Theme.fontColourInverse : Theme.fontColour
            text: `${icon} ${val}󰔄`
        }
    }
}
