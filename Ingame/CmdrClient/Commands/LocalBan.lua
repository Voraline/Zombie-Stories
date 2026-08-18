return {
	["Name"] = "localban",
	["Description"] = "Ban a player locally (this server only)",
	["Group"] = "Moderation",
	["Args"] = nil,
	["Args"] = {
		{
			["Type"] = "playerId",
			["Name"] = "target",
			["Description"] = "Player to ban"
		},
		{
			["Type"] = "string",
			["Name"] = "Reason",
			["Description"] = "Local ban reason",
			["Default"] = ""
		}
	}
}