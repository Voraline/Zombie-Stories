return {
	["Name"] = "json-array-decode",
	["Aliases"] = nil,
	["Description"] = "Decodes a JSON Array into a comma-separated list",
	["Group"] = "DefaultUtil",
	["Args"] = nil,
	["ClientRun"] = nil,
	["Aliases"] = {},
	["Args"] = {
		{
			["Type"] = "json",
			["Name"] = "JSON",
			["Description"] = "The JSON array."
		}
	},
	["ClientRun"] = function(_, p1) -- name: ClientRun
		local v2 = type(p1) ~= "table" and { p1 } or p1
		return table.concat(v2, ",")
	end
}