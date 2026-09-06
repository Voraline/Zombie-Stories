return {
    Name = "setzbucks",
    Description = "Set a player's ZBucks",
    Group = "Progression",
    Args = {
        {Type = "playerId", Name = "target", Description = "Target player"},
        {Type = "integer", Name = "amount", Description = "Amount of ZBucks"},
    },
}