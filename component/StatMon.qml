pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    // CPU average
    property real cpuUsage: 0
    property real lastCpuTotal: 0
    property real lastCpuIdle: 0

    // CPU cores
    property var lastCpuCoreIdle: []
    property var lastCpuCoreTotal: []
    property var totalCpuCoreUsage: []

    // CPU temperatur
    property string cpuTempPath: ""
    property real cpuTemp: 0
    property var cpuCoreTemp: []

    FileView {
        id: cpuUsageReader
        path: "/proc/stat"
        
        onLoaded: {
            let content = text().trim();
            if (!content) return;

            // vars to track individual cores
            let maxIndex = -1;
            let newCpuCoreIdle = [];
            let newCpuCoreTotal = [];
            let newCpuCoreUsage = [];

            let lines = content.split("\n");
            for (let i = 0; i < lines.length; i++) {
                let line = lines[i].trim();
                if (line === "") continue;
                let fields = line.split(/\s+/);

                // aggregated values
                if (fields[0] === "cpu") {
                    // grab idle + io_wait
                    let aggIdle = (parseInt(fields[4], 10) || 0) + (parseInt(fields[5], 10) || 0);
                    // sum total cpu time
                    let aggTotal = 0;
                    for (let j = 1; j < fields.length; j++) {
                        aggTotal += parseInt(fields[j], 10) || 0;
                    }

                    // average can only be calculated from a delta!
                    if (root.lastCpuTotal > 0) {
                        let dIdle = aggIdle - root.lastCpuIdle;
                        let dTotal = aggTotal - root.lastCpuTotal;
                        let aggUsage = dTotal > 0 ? 100 * (1 - dIdle / dTotal) : 0;
                        root.cpuUsage = aggUsage;
                    }
                    // update previous readings
                    root.lastCpuIdle = aggIdle;
                    root.lastCpuTotal = aggTotal;
                }
                else if (fields[0].startsWith("cpu") && fields[0].length > 3 && maxIndex !== -1) {
                    let coreIndex = parseInt(fields[0].substring(3), 10);
                    if (isNan(coreIndex) || coreIndex > maxIndex) continue;

                    // grab idle + io_wait
                    let idle = (parseInt(fields[4], 10) || 0) + (parseInt(fields[5], 10) || 0);
                    // sum total cpu time
                    let total = 0;
                    for (let j = 1; j < fields.length; j++) {
                        total += parseInt(fields[j], 10) || 0;
                    }

                    if (root.lastCpuCoreTotal[coreIndex] !== undefined) {
                        let dIdle = idle - root.lastCpuCoreIdle[coreIndex];
                        let dTotal = total - root.lastCpuCoreTotal[coreIndex];
                        newCpuCoreUsage[coreIndex] = dTotal >0 ? 100 * (1 - dIdle / dTotal) : 0;
                    }

                    newCpuCoreIdle[coreIndex] = idle;
                    newCpuCoreTotal[coreIndex] = total;

                }
            }
            
            // commit single core readings
            if (maxIndex !== -1) {
                root.lastCpuCoreIdle = newCpuCoreIdle;
                root.lastCpuCoreTotal = newCpuCoreTotal;
                root.totalCpuCoreUsage = newCpuCoreUsage;
            }
        }
    }

    // temporary vars
    property int _hwmonIdx: 0
    property int _labelIdx: 1
    property string _baseDir: ""
    property bool cpuTempPathReady: false
    // hardware monitor device discovery
    FileView {
        id: hwmonDiscovery
        printErrors: false

        onLoaded: {
            let t = text().trim();
            if (!t) return;

            if (_baseDir === "") {
                if (t == "coretemp" || t == "k10temp") {
                    _baseDir = "/sys/class/hwmon/hwmon" + (_hwmonIdx - 1);
                }
            } else if (_baseDir !== "") {
                    root.cpuTempPath = _baseDir + "/temp" + (_labelIdx - 1) + "_input";
                    root.cpuTempPathReady = true;
            }
        }
    }

    FileView {
        id: cpuTempReader
        path: root.cpuTempPath
        printErrors: false

        onLoaded: {
            let t = text().trim();
            if (!t) return;

            let rawTemp = parseInt(t, 10);
            if (!isNaN(rawTemp) && rawTemp > 0) {
                root.cpuTemp = rawTemp/1000;
            }
        }
    }

    Timer {
        id: timerHwmonDiscovery
        interval: 25
        running: !root.cpuTempPathReady
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            if (_baseDir === "") {
                if (_hwmonIdx < 32) {
                    hwmonDiscovery.path = "/sys/class/hwmon/hwmon" + _hwmonIdx++ + "/name";
                } else {
                    repeat = false;
                }
            } else {
                if (_labelIdx <= 96) {
                    hwmonDiscovery.path = _baseDir + "/temp" + _labelIdx++ + "_label";
                } else {
                    root.cpuTempPath = _baseDir + "/temp1_input"
                    root.cpuTempPathReady = true;
                }
            }
        }
    }

    // universal reader timer, triggers all updates
    Timer {
        id: timerStatClock
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            cpuUsageReader.reload();
            if (root.cpuTempPathReady) cpuTempReader.reload();
        }
    }
}
