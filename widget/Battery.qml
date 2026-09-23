import QtQuick
import Quickshell.Services.UPower
import qs.component

BarSection {
    id: sec
    visible: UPower.displayDevice.ready && UPowerDeviceType.toString(UPower.displayDevice.type) === "Battery"

    StyledText {
        property UPowerDevice dev: UPower.displayDevice
        property real val: (100 * dev.energy / dev.energyCapacity).toFixed(Theme.bat.decimals)
        property string icon: Theme.bat.formatIcon[dev.iconName] || ""

        color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
        text: `${icon} ${val}%`
    }
}
