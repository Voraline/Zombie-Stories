return {
    CrateId = "MythicalPrimary",
    DisplayName = "Primary Lootbox",
    Tier = "Mythical",
    Slot = "Primary",
    Price = 5000,
    ImageId = "rbxassetid://79087028007940",
    SharesPoolWith = "Primary",
    ProbabilityTable = (require(script.Parent.Parent:WaitForChild("Probabilities"))).Mythical,
}