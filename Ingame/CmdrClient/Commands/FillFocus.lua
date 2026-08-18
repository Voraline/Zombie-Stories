return {
	["Name"] = "fillfocus",
	["Aliases"] = nil,
	["Description"] = "Fills the focus meter for a player (optionally by a percentage)",
	["Group"] = "Debug",
	["Args"] = nil,
	["Aliases"] = { "ff" },
	["Args"] = {
		{
			["Type"] = "player",
			["Name"] = "target",
			["Description"] = "The player to fill focus for. Defaults to yourself.",
			["Optional"] = true
		},
		{
			["Type"] = "number",
			["Name"] = "amount",
			["Description"] = "Amount to fill (0-100%). Defaults to 100 (full).",
			["Optional"] = true
		}
	}
}