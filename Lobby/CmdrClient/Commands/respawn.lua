return {
    Name = "respawn",
    Description = "Respawns a player or a group of players to destination.",
    Group = "DefaultAdmin",
    AutoExec = {
        "alias \"refresh|Respawns the player and teleports them to destination.\" var= .refresh_pos ${position $1{player|Player}} && respawn $1 && tp $1 @${{var .refresh_pos}}",
    },
    Args = {
        {Type = "players", Name = "targets", Description = "The players to respawn."},
        {Type = "player @ vector3", Name = "Destination", Description = "The player to teleport to"},
    },
}