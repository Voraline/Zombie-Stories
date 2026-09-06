return {
    Name = "addzbucks",
    Description = "Add to or negate from a player's ZBucks",
    Group = "Progression",
    Args = {
        {Type = "playerId", Name = "target", Description = "Target player"},
        {Type = "integer", Name = "amount", Description = "Amount to add or negate"},
    },
}