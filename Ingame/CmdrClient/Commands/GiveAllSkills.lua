return {
    Name = "giveallskills",
    Description = "Gives all skills at max rank to a player",
    Group = "Debug",
    Aliases = {"maxskills"},
    Args = {
        {
            Type = "player",
            Name = "target",
            Description = "The player to give all skills to",
            Optional = true,
        },
    },
}