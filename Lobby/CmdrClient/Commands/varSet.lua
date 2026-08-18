return {
	["Name"] = "var=",
	["Aliases"] = nil,
	["Description"] = "Sets a stored value.",
	["Group"] = "DefaultUtil",
	["Args"] = nil,
	["ClientRun"] = nil,
	["Aliases"] = {},
	["Args"] = {
		{
			["Type"] = "storedKey",
			["Name"] = "Key",
			["Description"] = "The key to set, saved in your user data store. Keys prefixed with . are not saved. Keys prefixed with $ are game-wide. Keys prefixed with $. are game-wide and non-saved."
		},
		{
			["Type"] = "string",
			["Name"] = "Value",
			["Description"] = "Value or values to set.",
			["Default"] = ""
		}
	},
	["ClientRun"] = function(p1, p2) -- name: ClientRun
		p1:GetStore("vars_used")[p2] = true
	end
}