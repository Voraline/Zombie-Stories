return {
	["Name"] = "giveallitems",
	["Description"] = "Adds all items to a player\'s inventory.)",
	["Group"] = "Items",
	["Args"] = nil,
	["Args"] = {
		{
			["Type"] = "playerId",
			["Name"] = "target",
			["Description"] = "Player to give items"
		},
		{
			["Type"] = "boolean",
			["Name"] = "level100",
			["Description"] = "Set all weapon levels to 100",
			["Default"] = false
		}
	}
}