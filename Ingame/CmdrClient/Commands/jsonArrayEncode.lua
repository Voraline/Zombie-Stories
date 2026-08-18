local v_u_1 = game:GetService("HttpService")
return {
	["Name"] = "json-array-encode",
	["Aliases"] = nil,
	["Description"] = "Encodes a comma-separated list into a JSON array",
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
	["Run"] = function(_, p2) -- name: Run
		-- upvalues: (copy) v_u_1
		return v_u_1:JSONEncode(p2:split(","))
	end
}