pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: hypr

    property int activeWorkspaceId: 0
    property var workspacesByMonitor: []

    function resolveWorkspaces(ws) {
        let retVar = [];
        let _mon;
        for (_mon of Hyprland.monitors.values) {
            let listWs = [];
            let _ws;
            // normal workspaces
            for (_ws of ws) {
                if (_ws.id < 0) continue;
                else if (_ws.monitor === null && Hyprland.focusedMonitor.id === _mon.id) listWs.push(_ws);
                else if (_ws.monitor !== null && _ws.monitor.id === _mon.id) listWs.push(_ws);
            }
            // special workspaces
            for (_ws of ws) {
                if (_ws.id > 0) break; // special ws.id is always negative
                if (Hyprland.focusedMonitor.id === _mon.id) listWs.push(_ws);
            }
            retVar.push(listWs);
        }
        return retVar;
    }

    function switchWorkspace(w: int): void {
        Hyprland.dispatch(`workspace ${w}`);
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            let name = event.name;
            console.log(name, event.data)
            switch (name) {
                case "openlayer": {
                    if (event.data === "quickshell") {
                        hypr.workspacesByMonitor = hypr.resolveWorkspaces(Hyprland.workspaces.values);
                        hypr.activeWorkspaceId = Hyprland.focusedWorkspace.id;
                    }
                    break;
                }
                case "createworkspacev2": {
                    hypr.workspacesByMonitor = hypr.resolveWorkspaces(Hyprland.workspaces.values);
                    hypr.activeWorkspaceId = Hyprland.focusedWorkspace.id;
                    break;
                }
                case "destroyworkspacev2": {
                    hypr.workspacesByMonitor = hypr.resolveWorkspaces(Hyprland.workspaces.values);
                    // Don't update the activeWorkspaceId here!
                    break;
                }
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
                    hypr.workspacesByMonitor = hypr.resolveWorkspaces(Hyprland.workspaces.values);
                    // WORKSPACEID,WORKSPACENAME,MONNAME
                    let d = event.data.split(",");
                    hypr.activeWorkspaceId = d[0] !== "" ? d[0] : Hyprland.focusedWorkspace.id;
                    break;
                }
            }
        }
    }
}
