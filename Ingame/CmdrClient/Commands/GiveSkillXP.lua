return {
	["Name"] = "giveskillxp",
	["Aliases"] = nil,
	["Description"] = "Gives skill tree SP XP to a player",
	["Group"] = "Debug",
	["Args"] = nil,
	["Aliases"] = { "addspxp" },
	["Args"] = {
		{
			["Type"] = "player",
			["Name"] = "target",
			["Description"] = "The player to give XP to",
			["Optional"] = true
		},
		{
			["Type"] = "integer",
			["Name"] = "amount",
			["Description"] = "Amount of SP XP to give",
			["Optional"] = true
		}
	}
}