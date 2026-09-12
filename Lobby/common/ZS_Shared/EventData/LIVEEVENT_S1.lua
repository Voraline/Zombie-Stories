local LiveEventSchedule = require(script.Parent.Parent.Data.LiveEventSchedule)
local v1 = {
    {RewardId = "WATCH_COMPLETE", Type = "ZBucks", Amount = 1000, DisplayName = "1,000 Z$"},
    {
        RewardId = "WATCH_CHARM",
        Type = "Entitlement",
        EntitlementKey = "RatCharm",
        DisplayName = "Rat Charm",
    },
}
return {
    Id = "LIVEEVENT_S1",
    DataStoreKey = "LIVEEVENT_S1",
    ContentVersion = 1,
    Title = "Live Event",
    Description = "Watch the scheduled live-event cinematic.",
    StartTimestamp = LiveEventSchedule.ActiveFrom,
    EndTimestamp = LiveEventSchedule.ActiveUntil,
    RewardItems = v1,
    Rewards = v1,
}