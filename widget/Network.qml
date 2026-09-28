import QtQuick
import QtQuick.Layouts
import Quickshell.Networking
import qs.component

Row {
    id: net
    spacing: Theme.net.spacing
    
    Repeater {
        model: Networking.devices
        Layout.alignment: Qt.AlignCenter

        BarSection {
            id: sec

            required property NetworkDevice modelData
            property string type: DeviceType.toString(modelData.type)
            property string name: modelData.name
            property bool connected: modelData.connected
            // TODO: cleanup because this si horrendous
            property string iconName: {
                let name = "";
                if (sec.type === "Wired") {
                    name += "eth-";
                    if (sec.modelData.hasLink) {
                        name += "link-";
                        if (sec.connected) {
                            name += "connected";
                        } else {
                            name += "disconnected";
                        }
                    } else {
                        name += "nolink";
                    }
                } else {
                    name += "wifi-";
                    if (Networking.wifiEnabled) {
                        name += "enabled-";
                        if (sec.connected) {
                            name += "connected-";
                            let nws = sec.modelData.networks
                            let nw;
                            for (nw of nws.values) {
                                if (!nw.connected) continue;
                                let sigStr = Math.min(Math.floor(nw.signalStrength * 100 / 20), 4);
                                name += sigStr;
                            }
                        } else {
                            name += "disconnected";
                        }
                    } else {
                        name += "disabled";
                    }
                }
                return name;
            }
            property string icon: Theme.net.formatIcon[iconName] || iconName

            Row {
                spacing: Theme.net.spacing
                StyledText {
                    color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
                    text: sec.icon
                }
                StyledText {
                    visible: sec.pointer.hovered
                    color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
                    text: sec.name
                }
            }
        }
    }
}
