return {
    Name = "globalannounce",
    Description = "Send a cross-server announcement to players in the chosen places.",
    Group = "Announcements",
    Aliases = {"ga", "broadcast"},
    Args = {
        {
            Type = "announceScope",
            Name = "scope",
            Description = "Who receives it: all, lobby, arcade, or story",
        },
        {
            Type = "string",
            Name = "message",
            Description = "Message text. Everything after the scope is used, spaces and all.",
        },
    },
}