return {
    CrateId = "WorldCup",
    DisplayName = "World Cup Lootbox",
    Tier = "Special",
    Slot = "WorldCup",
    Price = 3000,
    ImageId = "rbxassetid://124117881922761",
    Enabled = false,
    ProbabilityTable = (require(script.Parent.Parent:WaitForChild("Probabilities"))).WorldCup,
    Items = {"1336", "1337", "1338", "1339", "1340", "1341", "1342", "1343"},
}