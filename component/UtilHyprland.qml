pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: hypr

    property int numMonitors: Hyprland.monitors.values.length
    property int activeWorkspaceId: 0
    property var workspacesByMonitor: []

    function resolveWorkspaces(ws) {
        let num = hypr.numMonitors;
        let retVar = [];
        let specialWs = []; // special workspaces are independent of monitors
        for (let i = 0; i < num; i++) {
            let listWs = [];
            let _ws;
            for (_ws of ws) {
                console.log(_ws.id, _ws.name);
                if (_ws.id < 0 ) specialWs.push(_ws);
                else if (_ws.monitor === null && Hyprland.focusedMonitor.id === i) listWs.push(_ws);
                else if (_ws.monitor.id === i) listWs.push(_ws);
            }
            for (_ws of specialWs) listWs.push(_ws); // duplicate special workspaces
            retVar.push(listWs.concat(specialWs));
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
                    hypr.activeWorkspaceId = Hyprland.focusedWorkspace.id;
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
                }
            }
        }
    }
}
