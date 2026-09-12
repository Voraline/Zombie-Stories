return {
    CrateId = "MythicalMelee",
    DisplayName = "Melee Lootbox",
    Tier = "Mythical",
    Slot = "Melee",
    Price = 9000,
    ImageId = "rbxassetid://94501769745526",
    SharesPoolWith = "Melee",
    ProbabilityTable = (require(script.Parent.Parent:WaitForChild("Probabilities"))).Mythical,
}