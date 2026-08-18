return {
	["Name"] = "run",
	["Aliases"] = nil,
	["AutoExec"] = nil,
	["Description"] = "Runs a given command string (replacing embedded commands).",
	["Group"] = "DefaultUtil",
	["Args"] = nil,
	["Run"] = nil,
	["Aliases"] = { ">" },
	["AutoExec"] = { "alias \"discard|Run a command and discard the output.\" replace ${run $1} .* \\\"\\\"" },
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Command",
			["Description"] = "The command string to run"
		}
	},
	["Run"] = function(p1, p2) -- name: Run
		return p1.Cmdr.Util.RunCommandString(p1.Dispatcher, p2)
	end
}