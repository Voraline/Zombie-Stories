return {
	["Name"] = "len",
	["Aliases"] = nil,
	["Description"] = "Returns the length of a comma-separated list",
	["Group"] = "DefaultUtil",
	["Args"] = nil,
	["Run"] = nil,
	["Aliases"] = {},
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "CSV",
			["Description"] = "The comma-separated list"
		}
	},
	["Run"] = function(_, p1) -- name: Run
		return #p1:split(",")
	end
}