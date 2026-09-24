import QtQuick
import Quickshell.Services.Pipewire
import qs.component

BarSection {
    id: sec
    visible: Pipewire.ready

    Row {
        id: audio
        spacing: Theme.audio.spacing
        visible: Pipewire.ready
        property PwNode sink: Pipewire.defaultAudioSink
        property real val: sink.audio.volume * 100
        property bool muted: sink.audio.muted
        property string status: {
            if (!audio.sink?.ready) { return "missing"; }
            if (audio.muted) { return "muted"; }
            if (audio.val <= 33) { return "low"; }
            else if (audio.val < 66) { return "medium"; }
            else if (audio.val > 66) { return "high"; }
        }
        property string icon: Theme.audio.formatIcon[status] || ""

        PwObjectTracker { objects: [ audio.sink ] }

        StyledText {
            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: audio.icon
        }
        StyledText {
            visible: !audio.muted
            color: sec.pointer.hovered ? Theme.font.colourInverse : Theme.font.colour
            text: `${audio.val.toFixed(0).padStart(2,"0").slice(0,3)}%`
        }
    }
}

