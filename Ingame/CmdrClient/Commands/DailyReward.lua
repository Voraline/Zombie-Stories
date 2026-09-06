return {
    Name = "dailyreward",
    Description = "Sets the caller's daily reward state and refreshes the daily UI.",
    Group = "Debug",
    Args = {
        {Type = "string", Name = "state", Description = "claimable, locked, day7, or reset"},
    },
}