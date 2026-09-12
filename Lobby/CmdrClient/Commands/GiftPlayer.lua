return {
    Name = "gift",
    Description = "Grants a giftable product to a player for free, bypassing the Robux purchase.",
    Group = "EventManager",
    Aliases = {"freegift", "grantgift"},
    Args = {
        {Type = "playerId", Name = "target", Description = "Player to gift (online or offline)"},
        {Type = "giftKey", Name = "gift", Description = "What to grant"},
        {
            Type = "integer",
            Name = "count",
            Description = "Repeat count for repeatable gifts (max 10); crates must total 1 or 5",
            Default = 1,
        },
    },
}