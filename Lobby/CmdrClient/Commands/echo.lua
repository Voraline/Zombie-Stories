return {
	["Name"] = "echo",
	["Aliases"] = nil,
	["Description"] = "Echoes your text back to you.",
	["Group"] = "DefaultUtil",
	["Args"] = nil,
	["Run"] = nil,
	["Aliases"] = { "=" },
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Text",
			["Description"] = "The text."
		}
	},
	["Run"] = function(_, p1) -- name: Run
		return p1
	end
}