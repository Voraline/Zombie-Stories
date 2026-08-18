return {
	["Name"] = "pick",
	["Aliases"] = nil,
	["Description"] = "Picks a value out of a comma-separated list.",
	["Group"] = "DefaultUtil",
	["Args"] = nil,
	["Run"] = nil,
	["Aliases"] = {},
	["Args"] = {
		{
			["Type"] = "integer",
			["Name"] = "Index to pick",
			["Description"] = "The index of the item you want to pick"
		},
		{
			["Type"] = "string",
			["Name"] = "CSV",
			["Description"] = "The comma-separated list"
		}
	},
	["Run"] = function(_, p1, p2) -- name: Run
		return p2:split(",")[p1] or ""
	end
}