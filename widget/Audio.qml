import QtQuick
import Qt.labs.animation
import Quickshell.Services.Pipewire
import qs.component

BarSection {
    id: sec
    visible: Pipewire.ready
    PwObjectTracker { objects: [ sec.sink ] }

    property PwNode sink: Pipewire.defaultAudioSink
    property real val: sink.audio.volume * 100
    property bool muted: sink.audio.muted
    property string status: {
        if (!sec.sink?.ready) { return "missing"; }
        if (sec.muted) { return "muted"; }
        return Math.min(Math.floor(val/33),2)
    }
    property string icon: Theme.audio.formatIcon[status] || ""

    onLeftClicked: { sink.audio.muted = !sink.audio.muted }
    onValChanged: { sink.audio.volume = val / 100 }
    BoundaryRule on val {
        minimum: 0
        maximum: 100
    }
    WheelHandler {
        target: sec
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        property: "val"
    }

    Row {
        spacing: Theme.audio.spacing

        StyledText {
            color: sec.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: sec.icon
        }
        StyledText {
            visible: !sec.muted
            color: sec.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${sec.val.toFixed(0).padStart(2,"0").slice(0,3)}%`
        }
    }
}

