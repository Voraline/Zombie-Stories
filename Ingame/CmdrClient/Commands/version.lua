return {
	["Name"] = "version",
	["Args"] = nil,
	["Description"] = "Shows the current version of Cmdr",
	["Group"] = "DefaultDebug",
	["Run"] = nil,
	["Args"] = {},
	["Run"] = function() -- name: Run
		return ("Cmdr Version %s"):format("v1.12.0")
	end
}