return {
    Name = "sethealth",
    Description = "Sets the health of a player",
    Group = "Debug",
    Args = {
        {Type = "players", Name = "target", Description = "The player to activate god mode for"},
        {Type = "number", Name = "health", Description = "The health value"},
    },
}