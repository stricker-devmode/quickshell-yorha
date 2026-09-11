import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.component


BarSection {
    color: mouse.hovered ? Theme.rectColourHover : Theme.rectColour
    RowLayout {
    spacing: Theme.fontSizePreferredPx / 2
        StyledText {
            id: usage
            property string icon: Theme.widgetCpuUsageIcon
            property string val: Theme.widgetCpuDecimals >= 0 ? StatMon.cpuUsage.toFixed(Theme.widgetCpuDecimals) : StatMon.cpuUsage

            color: mouse.hovered ? Theme.fontColourInverse : Theme.fontColour
            text: `${icon} ${val}%`
        }
        StyledText {
            id: temperature
            property string icon: Theme.widgetCpuTempIcon
            property string val: Theme.widgetCpuDecimals >= 0 ? StatMon.cpuTemp.toFixed(Theme.widgetCpuDecimals) : StatMon.cpuTemp

            color: mouse.hovered ? Theme.fontColourInverse : Theme.fontColour
            text: `${icon} ${val}󰔄`
        }
    }

    HoverHandler {
        id: mouse
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }
}
