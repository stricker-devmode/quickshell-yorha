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

    // GPU temperatur
    property string gpuTempPath: ""
    property string gpuUsagePath: ""
    property real gpuTemp: 0
    property real gpuUsage: 0

    // Memory
    property real memUsage: 0
    property int memTotalKiB: 0
    property int memTotalMiB: 0
    property int memTotalGiB: 0
    property int memUsedKiB: 0
    property int memUsedMiB: 0
    property int memUsedGiB: 0

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
    property int _hwmonIdxCpu: 0
    property int _labelIdxCpu: 1
    property string _baseDirCpu: ""
    property bool cpuTempPathReady: false
    // hardware monitor cpu discovery
    FileView {
        id: hwmonCpuDiscovery
        printErrors: false

        onLoaded: {
            let t = text().trim();
            if (!t) return;

            if (_baseDirCpu === "") {
                if (t == "coretemp" || t == "k10temp") {
                    _baseDirCpu = "/sys/class/hwmon/hwmon" + (_hwmonIdxCpu - 1);
                }
            } else if (_baseDirCpu !== "") {
                root.cpuTempPath = _baseDirCpu + "/temp" + (_labelIdxCpu - 1) + "_input";
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
        id: timerHwmonCpuDiscovery
        interval: 25
        running: !root.cpuTempPathReady
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            if (_baseDirCpu === "") {
                if (_hwmonIdxCpu < 32) {
                    hwmonCpuDiscovery.path = "/sys/class/hwmon/hwmon" + _hwmonIdxCpu++ + "/name";
                } else {
                    repeat = false;
                }
            } else {
                if (_labelIdxCpu <= 96) {
                    hwmonCpuDiscovery.path = _baseDirCpu + "/temp" + _labelIdxCpu++ + "_label";
                } else {
                    root.cpuTempPath = _baseDirCpu + "/temp1_input"
                    root.cpuTempPathReady = true;
                }
            }
        }
    }

    // temporary vars
    property int _hwmonIdxGpu: 0
    property int _labelIdxGpu: 1
    property string _baseDirGpu: ""
    property bool gpuUsagePathReady: false
    property bool gpuTempPathReady: false
    // hardware monitor gpu discovery
    FileView {
        id: hwmonGpuDiscovery
        printErrors: false

        onLoaded: {
            let t = text().trim();
            if (!t) return;

            if (_baseDirGpu === "") {
                if (t == "amdgpu") {
                    _baseDirGpu = "/sys/class/hwmon/hwmon" + (_hwmonIdxGpu - 1);
                }
            } else if (_baseDirGpu !== "") {
                root.gpuUsagePath = _baseDirGpu + "/device/gpu_busy_percent";
                root.gpuUsagePathReady = true;
                root.gpuTempPath = _baseDirGpu + "/temp" + (_labelIdxGpu - 1) + "_input";
                root.gpuTempPathReady = true;
            }
        }
    }

    FileView {
        id: gpuUsageReader
        path: root.gpuUsagePath
        printErrors: false

        onLoaded: {
            let t = text().trim();
            if (!t) return;

            let rawPerc = parseInt(t, 10);
            if (!isNaN(rawPerc)) root.gpuUsage = rawPerc;
        }
    }

    FileView {
        id: gpuTempReader
        path: root.gpuTempPath
        printErrors: false

        onLoaded: {
            let t = text().trim();
            if (!t) return;

            let rawTemp = parseInt(t, 10);
            if (!isNaN(rawTemp) && rawTemp > 0) {
                root.gpuTemp = rawTemp/1000;
            }
        }
    }

    Timer {
        id: timerHwmonGpuDiscovery
        interval: 25
        running: !root.gpuUsagePathReady || !root.gpuTempPathReady
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            if (_baseDirGpu === "") {
                if (_hwmonIdxGpu < 32) {
                    hwmonGpuDiscovery.path = "/sys/class/hwmon/hwmon" + _hwmonIdxGpu++ + "/name";
                } else {
                    repeat = false;
                }
            } else {
                if (_labelIdxGpu <= 96) {
                    hwmonGpuDiscovery.path = _baseDirGpu + "/temp" + _labelIdxGpu++ + "_label";
                } else {
                    root.gpuTempPath = _baseDirGpu + "/temp1_input"
                    root.gpuTempPathReady = true;
                }
            }
        }
    }

    FileView {
        id: memUsageReader
        path: "/proc/meminfo"

        onLoaded: {
            let t = text().trim();
            if (!t) return;

            let lines = t.split("\n");
            let data = { memTotalKiB: 0, memAvailableKiB: 0 }

            function parseKiB(line) {
                let p = line.split(":");
                if (p.length < 2) return 0;
                let valStr = p[1].trim().split(/\s+/)[0];
                let kb = parseInt(valStr, 10);
                return isNaN(kb) ? 0 : kb;
            }

            for (let i = 0; i < lines.length; i++) {
                let l = lines[i].trim();
                if (l.startsWith("MemTotal:")) data.memTotalKiB = parseKiB(l);
                else if (l.startsWith("MemAvailable:")) data.memAvailableKiB = parseKiB(l);
            }

            root.memTotalKiB = data.memTotalKiB;
            root.memTotalMiB = data.memTotalKiB / 1024;
            root.memTotalGiB = root.memTotalMiB / 1024;

            root.memUsedKiB = data.memTotalKiB - data.memAvailableKiB;
            root.memUsedMiB = root.memUsedKiB / 1024;
            root.memUsedGiB = root.memUsedMiB / 1024;

            root.memUsage = data.memTotalKiB > 0 ? (root.memUsedKiB / root.memTotalKiB * 100) : 0
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
            memUsageReader.reload();
            if (root.cpuTempPathReady) cpuTempReader.reload();
            if (root.gpuTempPathReady) {
                gpuUsageReader.reload();
                gpuTempReader.reload();
            }
        }
    }
}
