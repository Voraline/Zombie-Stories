return require(game.ReplicatedStorage.Packages.Red).SharedEvent("DoorSystem", function(p1)
	if typeof(p1) ~= "table" then
		return nil
	end
	local v2 = p1.action
	local v3 = p1.doorId
	local v4 = p1.state
	if typeof(v2) ~= "string" or typeof(v3) ~= "string" then
		return nil
	end
	if v2 == "Proximity" then
		if typeof(v4) ~= "boolean" then
			return nil
		end
	else
		if v2 ~= "StopCycle" then
			return nil
		end
		if v4 ~= nil and typeof(v4) ~= "boolean" then
			return nil
		end
	end
	return {
		["action"] = v2,
		["doorId"] = v3,
		["state"] = v4
	}
end)