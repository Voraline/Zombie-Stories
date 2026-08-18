local v1 = script.Parent.Parent
require(v1.PubTypes)
return {
	["type"] = "SpecialKey",
	["kind"] = "Cleanup",
	["stage"] = "observer",
	["apply"] = function(_, p2, _, p3) -- name: apply
		table.insert(p3, p2)
	end
}