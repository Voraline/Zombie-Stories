return {
    Name = "kick",
    Description = "Kick a player",
    Group = "Moderation",
    Args = {
        {Type = "player", Name = "target", Description = "Player to kick"},
        {Type = "string", Name = "kickMessage", Description = "Kick message"},
    },
}