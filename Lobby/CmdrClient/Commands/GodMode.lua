return {
    Name = "godmode",
    Description = "Toggles god mode for the player",
    Group = "Debug",
    Aliases = {"gm"},
    Args = {
        {Type = "player", Name = "target", Description = "The player to activate god mode for"},
    },
}