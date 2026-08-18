return require(game.ReplicatedStorage.Packages.Red).SharedEvent("ParachuteAlarm", function(p1)
	if typeof(p1) == "table" then
		local v2 = p1.action
		local v3 = p1.session
		if (v2 == "Start" or v2 == "Stop") and (typeof(v3) == "string" and v3 ~= "") then
			if v2 == "Start" then
				local v4 = p1.config
				return (v4 == nil or typeof(v4) == "table") and {
					["action"] = v2,
					["session"] = v3,
					["config"] = v4
				} or nil
			else
				if p1.makeRed ~= nil then
					local v5 = p1.makeRed
					if typeof(v5) ~= "boolean" then
						return nil
					end
				end
				return {
					["action"] = v2,
					["session"] = v3,
					["makeRed"] = p1.makeRed
				}
			end
		else
			return nil
		end
	else
		return nil
	end
end)