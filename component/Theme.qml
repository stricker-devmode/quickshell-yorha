pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    // Colours
    property color colourBlack_n: '#212121'
    property color colourBlack_l: '#625f50'
    property color colourRed_n: '#ff3333'
    property color colourRed_l: '#f76e6e'
    property color colourGreen_n: '#33ff85'
    property color colourGreen_l: '#86f9b4'
    property color colourYellow_n: '#ffee33'
    property color colourYellow_l: '#f9ef86'
    property color colourBlue_n: '#808aff'
    property color colourBlue_l: '#b6bcfb'
    property color colourMagenta_n: '#f53df5'
    property color colourMagenta_l: '#f5a3f5'
    property color colourCyan_n: '#6afbfb'
    property color colourCyan_l: '#baf7f7'
    property color colourWhite_n: '#d4d4c4'
    property color colourWhite_l: '#f3f3f2'
    property color colourForeground: '#dcd8c0'
    property color colourBackground: '#171412'
    property color colourForeground_inv: '#2e2824'
    property color colourBackground_inv: '#f1efe5'
    property color colourTransparent: '#00000000'

    // Font and Text
    property string fontFamilyMono: "JetBrainsMono Nerd Font"
    property int fontSizePreferredPx: 17
    property color fontColour: colourForeground
    property color fontColourInverse: colourForeground_inv

    // Rect Model
    property real rectRadius: 4
    property real rectMargin: 2
    property color rectColour: colourForeground_inv
    property color rectColourHover: colourForeground

    // Bar Model
    property int barHeight: 30
    property int barHeightMax: 30

    // Cpu Widget
    property int widgetCpuDecimals: 2
    property string widgetCpuTempIcon: "󰏈"
    property string widgetCpuUsageIcon: "󰝪"

    // Gpu Widget
    property string widgetGpuUsageIcon: "󰄧"
    property string widgetGpuTempIcon: "󰿸"

    // Mem Widget
    property string widgetMemUsageIcon: "󰞰"
    property string widgetMemTempIcon: "󰏈"
}
