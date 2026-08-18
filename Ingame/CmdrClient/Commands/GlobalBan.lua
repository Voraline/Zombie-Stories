return {
	["Name"] = "globalban",
	["Description"] = "Ban a player globally",
	["Group"] = "Moderation",
	["Args"] = nil,
	["Args"] = {
		{
			["Type"] = "playerId",
			["Name"] = "target",
			["Description"] = "Player to ban"
		},
		{
			["Type"] = "banType",
			["Name"] = "banType",
			["Description"] = "Type of ban"
		},
		{
			["Type"] = "string",
			["Name"] = "Reason",
			["Description"] = "Ban reason (use \'none\' when none is given)"
		},
		{
			["Type"] = "boolean",
			["Name"] = "Permanent",
			["Description"] = "Whether or not the ban is permanent"
		},
		{
			["Type"] = "integer",
			["Name"] = "Year",
			["Description"] = "Year the ban ends",
			["Optional"] = true
		},
		{
			["Type"] = "integer",
			["Name"] = "Month",
			["Description"] = "Month the ban ends",
			["Optional"] = true
		},
		{
			["Type"] = "integer",
			["Name"] = "Day",
			["Description"] = "Day the ban ends",
			["Optional"] = true
		}
	}
}