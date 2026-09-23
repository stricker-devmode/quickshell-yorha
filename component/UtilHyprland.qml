pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Singleton {
    id: hypr

    property int activeWorkspaceId: 0
    property var workspacesByMonitor: []
    property var workspaces: Hyprland.workspaces.values
    property bool firstRun: true

    function resolveWorkspaces(ws) {
        if (ws === undefined) {
           ws = Hyprland.workspaces.values.map(e => e).sort((a, b) => a.id - b.id); 
        }
        let retVar = [];
        let _mon;
        for (_mon of Hyprland.monitors.values) {
            let listWs = [];
            let _ws;
            // normal workspaces
            for (_ws of ws) {
                if (_ws.id < 0) {
                    continue;
                }
                else if (_ws.monitor === null && Hyprland.focusedMonitor.id === _mon.id) {
                    listWs.push(_ws);
                }
                else if (_ws.monitor !== null && _ws.monitor.id === _mon.id) {
                    listWs.push(_ws);
                }
            }
            // special workspaces
            for (_ws of ws) {
                if (_ws.id > 0) break; // special ws.id is always negative
                if (_ws.monitor === null && Hyprland.focusedMonitor.id === _mon.id) {
                    listWs.push(_ws);
                }
                else if (_ws.monitor !== null && _ws.monitor.id === _mon.id) {
                    listWs.push(_ws);
                }
            }
            retVar.push(listWs);
        }
        return retVar;
    }

    function switchWorkspace(w: int): void {
        Hyprland.dispatch(`workspace ${w}`);
    }

    property int _findWsId: 0
    function findWorkspaceById(value, index, array) {
        return value.id === hypr._findWsId;
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            switch (event.name) {
                case "focusedmonv2": {
                    let d = event.data.split(",");
                    hypr.activeWorkspaceId = d[1];
                    break;
                }
                case "workspacev2": {
                    hypr.activeWorkspaceId = Hyprland.focusedWorkspace.id;
                    break;
                }
                case "activespecialv2": {
                    // WORKSPACEID,WORKSPACENAME,MONNAME
                    let d = event.data.split(",");
                    hypr.activeWorkspaceId = d[0] !== "" ? d[0] : Hyprland.focusedWorkspace.id;
                    break;
                    // TODO: maybe get this to work? Logically it should already but updates
                    //       aren't firing :/
                    // Handle special ws moving screen
                    // if (d[0] !== "") {
                    //     let monId = Hyprland.focusedMonitor.id;
                    //     hypr._findWsId = d[0];
                    //     for (let i = 0; i < hypr.workspacesByMonitor.length; i++) {
                    //         // skip; we know it's not here
                    //         let j = hypr.workspacesByMonitor[i].findIndex(hypr.findWorkspaceById);
                    //         if (i === monId && j !== -1) { continue; }
                    //         if (j !== -1) {
                    //             hypr.resolveWorkspaces();
                    //             break;
                    //         }
                    //     }
                    // }
                }
            }
        }
    }

    onWorkspacesChanged: {
        hypr.workspacesByMonitor = hypr.resolveWorkspaces();
    }
}
