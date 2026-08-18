return {
	["Name"] = "giveallskills",
	["Aliases"] = nil,
	["Description"] = "Gives all skills at max rank to a player",
	["Group"] = "Debug",
	["Args"] = nil,
	["Aliases"] = { "maxskills" },
	["Args"] = {
		{
			["Type"] = "player",
			["Name"] = "target",
			["Description"] = "The player to give all skills to",
			["Optional"] = true
		}
	}
}