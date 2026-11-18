pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root
    readonly property var players: Mpris.players.values
    property string selectedPlayer: ""
    readonly property var active: players.find(player => player.dbusName === selectedPlayer)
        ?? players.find(player => player.isPlaying) ?? players[0] ?? null

    function select(player): void {
        selectedPlayer = player?.dbusName ?? "";
    }
}
