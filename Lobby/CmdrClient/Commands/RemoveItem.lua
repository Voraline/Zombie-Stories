return {
	["Name"] = "removeitem",
	["Description"] = "Removes an item from a player\'s inventory",
	["Group"] = "Game",
	["Args"] = nil,
	["Args"] = {
		{
			["Type"] = "playerId",
			["Name"] = "target",
			["Description"] = "Player to remove item from"
		},
		{
			["Type"] = "integer",
			["Name"] = "slot",
			["Description"] = "The inventory slot"
		}
	}
}