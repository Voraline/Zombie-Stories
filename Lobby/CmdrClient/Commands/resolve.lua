return {
	["Name"] = "resolve",
	["Aliases"] = nil,
	["Description"] = "Resolves Argument Value Operators into lists. E.g., resolve players * gives you a list of all players.",
	["Group"] = "DefaultUtil",
	["AutoExec"] = nil,
	["Args"] = nil,
	["Run"] = nil,
	["Aliases"] = {},
	["AutoExec"] = { "alias \"me|Displays your username\" resolve players ." },
	["Args"] = {
		{
			["Type"] = "type",
			["Name"] = "Type",
			["Description"] = "The type for which to resolve"
		},
		function(p1)
			if p1:GetArgument(1):Validate() ~= false then
				return {
					["Type"] = nil,
					["Name"] = "Argument Value Operator",
					["Description"] = "The value operator to resolve. One of: * ** . ? ?N",
					["Optional"] = true,
					["Type"] = p1:GetArgument(1):GetValue()
				}
			end
		end
	},
	["Run"] = function(p2) -- name: Run
		return table.concat(p2:GetArgument(2).RawSegments, ",")
	end
}