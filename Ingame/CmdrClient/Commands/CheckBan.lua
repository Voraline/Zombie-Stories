return {
    Name = "checkban",
    Description = "Check a player's ban status",
    Group = "Moderation",
    Args = {
        {Type = "playerId", Name = "target", Description = "Player to check"},
    },
}