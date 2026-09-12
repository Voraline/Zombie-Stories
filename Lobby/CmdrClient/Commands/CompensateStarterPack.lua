local ZS_Shared = game.ReplicatedStorage.common:WaitForChild("ZS_Shared")
return {
    Name = "compensatestarterpack",
    Group = "Items",
    Description = "Gives a player the contents of the Starter Pack (" .. (require((ZS_Shared:WaitForChild("Data")):WaitForChild("StarterPackOffer"))).GetFormattedZBucks() .. " ZBucks + 3 free crates) as compensation",
    Args = {
        {Type = "playerId", Name = "target", Description = "Player to compensate"},
    },
}