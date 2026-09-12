return {
    CrateId = "MythicalSecondary",
    DisplayName = "Secondary Lootbox",
    Tier = "Mythical",
    Slot = "Secondary",
    Price = 5000,
    ImageId = "rbxassetid://81696562116264",
    SharesPoolWith = "Secondary",
    ProbabilityTable = (require(script.Parent.Parent:WaitForChild("Probabilities"))).Mythical,
}