local v_u_1 = {
	["Enable"] = true,
	["UpdateState"] = true,
	["Disable"] = true
}
local v_u_2 = {
	["Broken"] = true,
	["Fixed"] = true
}
return require(game.ReplicatedStorage.Packages.Red).SharedEvent("Drill", function(p3)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	if typeof(p3) ~= "table" then
		return nil
	end
	local v4 = p3.action
	if not v_u_1[v4] then
		return nil
	end
	if v4 == "Disable" then
		return {
			["action"] = v4
		}
	end
	local v5 = p3.state
	return typeof(v5) == "string" and v_u_2[v5] and {
		["action"] = v4,
		["state"] = v5
	} or nil
end)