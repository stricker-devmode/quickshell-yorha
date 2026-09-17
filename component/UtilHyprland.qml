pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: hypr

    property int numMonitors: Hyprland.monitors.values.length
    property var workspacesByMonitor: resolveWorkspaces(Hyprland.workspaces.values)

    function resolveWorkspaces(ws) {
        let num = hypr.numMonitors;
        let retVar = []
        for (let i = 0; i < num; i++) {
            let listWs = [];
            let _ws;
            for (_ws of ws) {
                console.log(_ws.id, _ws.name, _ws.monitor?.id);
                if (_ws.monitor.id === i) listWs.push(_ws);
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
            switch (name) {
                case "createworkspacev2": {
                    Hyprland.refreshMonitors();
                    Hyprland.refreshWorkspaces();
                    hypr.workspacesByMonitor = hypr.resolveWorkspaces(Hyprland.workspaces.values);
                    break;
                }
                case "destroyworkspacev2": {
                    Hyprland.refreshMonitors();
                    Hyprland.refreshWorkspaces();
                    hypr.workspacesByMonitor = hypr.resolveWorkspaces(Hyprland.workspaces.values);
                    break;
                }
                case "activespecialv2": {
                    Hyprland.refreshMonitors();
                    Hyprland.refreshWorkspaces();
                    hypr.workspacesByMonitor = hypr.resolveWorkspaces(Hyprland.workspaces.values);
                    break;
                }
            }
        }
    }
}
