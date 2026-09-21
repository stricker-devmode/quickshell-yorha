pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property Item colour: colourPalette
    Item {
        id: colourPalette
        property color black_n: '#212121'
        property color black_l: '#625f50'
        property color red_n: '#ff3333'
        property color red_l: '#f76e6e'
        property color green_n: '#33ff85'
        property color green_l: '#86f9b4'
        property color yellow_n: '#ffee33'
        property color yellow_l: '#f9ef86'
        property color blue_n: '#808aff'
        property color blue_l: '#b6bcfb'
        property color magenta_n: '#f53df5'
        property color magenta_l: '#f5a3f5'
        property color cyan_n: '#6afbfb'
        property color cyan_l: '#baf7f7'
        property color white_n: '#d4d4c4'
        property color white_l: '#f3f3f2'
        property color foreground: '#dcd8c0'
        property color background: '#171412'
        property color foreground_inv: '#2e2824'
        property color background_inv: '#f1efe5'
        property color transparent: '#00000000'
    }

    // Font and Text
    property Item font: fontModel
    Item {
        id: fontModel
        property string familyMono: "JetBrainsMono Nerd Font"
        property int sizePreferredPx: 17
        property color colour: colourPalette.foreground
        property color colourInverse: colourPalette.foreground_inv
    }

    // Rect Model
    property Item rect: rectModel
    Item {
        id: rectModel
        property real radius: 4
        property real margin: 2
        property color colour: colourPalette.transparent
        property color colourHover: colourPalette.foreground
    }

    // Bar Model
    property Item bar: barModel
    Item {
        id: barModel
        property int layoutSpacing: fontModel.sizePreferredPx / 2
        property color colour: colourPalette.foreground_inv
        property int heightPreferred: 30
        property int heightMax: 30
    }

    // Global metrics settings
    property Item metrics: metricsModel
    Item {
        id: metricsModel
        property int floatDecimals: 2
        property int floatMaxLength: 5
    }

    // Cpu Widget
    property Item cpu: cpuModel
    Item {
        id: cpuModel
        property int spacing: fontModel.sizePreferredPx / 2
        property int decimals: metricsModel.floatDecimals
        property string tempIcon: "󰏈"
        property string usageIcon: "󰝪"
    }

    // Gpu Widget
    property Item gpu: gpuModel
    Item {
        id: gpuModel
        property int spacing: fontModel.sizePreferredPx / 2
        property int decimals: metricsModel.floatDecimals
        property string usageIcon: "󰄧"
        property string tempIcon: "󰿸"
    }

    // Mem Widget
    property Item mem: memModel
    Item {
        id: memModel
        property int spacing: fontModel.sizePreferredPx / 2
        property int decimals: metricsModel.floatDecimals
        property bool showTotal: false
        property string unit: "GiB"
        property string usageIcon: "󰞰"
        property string totalIcon: "󰄦"
    }

    property Item workspace: wsModel
    Item {
        id: wsModel
        property var format: {
            "1": "一",
            "2": "二",
            "3": "三",
            "4": "四",
            "5": "五",
            "6": "六",
            "7": "七",
            "8": "八",
            "9": "九",
            "10": "十",
            "special:G1": "󰎦",
            "special:G2": "󰎩",
            "special:G3": "󰎬",
            "special:G4": "󰎮",
            "special:G5": "󰎰",
            "special:G6": "󰎵",
            "default": ""
        }
    }
}
