pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    // CPU average
    property double totalCpuUsage: 0
    property real lastCpuTotal: 0
    property real lastCpuIdle: 0

    // CPU cores
    property var lastCpuCoreIdle: []
    property var lastCpuCoreTotal: []
    property var totalCpuCoreUsage: []

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
                        root.totalCpuUsage = aggUsage;
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
    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            cpuUsageReader.reload();
        }
    }
}
