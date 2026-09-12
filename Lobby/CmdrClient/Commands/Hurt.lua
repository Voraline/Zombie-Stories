return {
    Name = "hurt",
    Description = "Hurt the player",
    Group = "Debug",
    Aliases = {"hrt"},
    AutoExec = {
        "alias \"killme|Instakill self skipping downed.\" hurt ${me} 5000 true",
        "alias \"hurtme|Hurt yourself.\" hurt ${me} $1{number|amt|Amount to hurt} false",
        "alias \"healme|Heal yourself.\" hurt ${me} -$1{number|amt|Amount to heal}",
        "alias \"heal|Heal a player.\" hurt $1{players|players|The players to bring} -$1{number|amt|Amount to heal}",
    },
    Args = {
        {Type = "player", Name = "target", Description = "The player to hurt"},
        {Type = "number", Name = "amt", Description = "Amount to hurt"},
        {
            Type = "boolean",
            Name = "instantKill",
            Description = "Die instantly instead of being downed",
            Optional = true,
            Default = false,
        },
    },
}