import Quickshell
import QtQuick
import qs.component


BarSection {
    color: mouse.hovered ? Theme.rectColourHover : Theme.rectColour
    StyledText {
        id: usage
        property string icon: Theme.widgetCpuUsageIcon
        property string perc: Theme.widgetCpuDecimals >= 0 ? StatMon.totalCpuUsage.toFixed(Theme.widgetCpuDecimals) : StatMon.totalCpuUsage

        color: mouse.hovered ? Theme.fontColourInverse : Theme.fontColour
        text: `${icon} ${perc}%`
    }

    HoverHandler {
        id: mouse
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }
}
