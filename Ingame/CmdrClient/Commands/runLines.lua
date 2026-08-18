return {
	["Name"] = "run-lines",
	["Aliases"] = nil,
	["Description"] = "Splits input by newlines and runs each line as its own command. This is used by the init-run command.",
	["Group"] = "DefaultUtil",
	["Args"] = nil,
	["ClientRun"] = nil,
	["Aliases"] = {},
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Script",
			["Description"] = "The script to parse.",
			["Default"] = ""
		}
	},
	["ClientRun"] = function(p1, p2) -- name: ClientRun
		if #p2 == 0 then
			return ""
		end
		local v3 = p1.Dispatcher:Run("var", "INIT_PRINT_OUTPUT") ~= ""
		local v4 = p2:gsub("\n+", "\n"):split("\n")
		for _, v5 in ipairs(v4) do
			if v5:sub(1, 1) ~= "#" then
				local v6 = p1.Dispatcher:EvaluateAndRun(v5)
				if v3 then
					p1:Reply(v6)
				end
			end
		end
		return ""
	end
}