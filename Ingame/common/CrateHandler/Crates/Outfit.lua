return {
    CrateId = "Outfit",
    DisplayName = "Outfit Lootbox",
    Tier = "Outfit",
    Slot = "Outfit",
    Price = 3000,
    ImageId = "rbxassetid://132639764670163",
    ExcludeOwned = true,
    ProbabilityTable = (require(script.Parent.Parent:WaitForChild("Probabilities"))).Outfit,
    Items = {"4004", "4005", "4006", "4007", "4008", "4009", "4010", "4011", "4012", "4013"},
}