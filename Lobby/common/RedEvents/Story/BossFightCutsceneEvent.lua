local v1 = game:GetService("ReplicatedStorage")
return require(v1.Packages.Red).SharedEvent("BossFightCutscene", function(p2)
	if typeof(p2) ~= "table" then
		return nil
	end
	local v3 = p2.action
	if typeof(v3) ~= "string" then
		return nil
	end
	if v3 == "StartIntro" then
		local v4 = p2.sequences
		if typeof(v4) ~= "table" then
			return nil
		end
		local v5 = {}
		for v6, v7 in ipairs(v4) do
			if typeof(v7) ~= "table" then
				return nil
			end
			local v8 = v7.duration
			if typeof(v8) ~= "number" or v8 <= 0 then
				return nil
			end
			local v9 = v7.easing
			if v9 == nil then
				v5[v6] = {
					["duration"] = v8
				}
			else
				if typeof(v9) ~= "table" then
					return nil
				end
				local v10 = v9.style
				local v11 = v9.direction
				if v10 ~= nil and typeof(v10) ~= "EnumItem" then
					return nil
				end
				if v11 ~= nil and typeof(v11) ~= "EnumItem" then
					return nil
				end
				v5[v6] = {
					["duration"] = v8,
					["easing"] = {
						["style"] = v10,
						["direction"] = v11
					}
				}
			end
		end
		local v12 = p2.cutsceneMode
		if v12 ~= nil and typeof(v12) ~= "string" then
			v12 = nil
		end
		return {
			["action"] = v3,
			["sequences"] = v5,
			["cutsceneMode"] = v12
		}
	end
	if v3 == "BossReachedWaypoint" then
		local v13 = p2.index
		return typeof(v13) == "number" and {
			["action"] = v3,
			["index"] = math.floor(v13)
		} or nil
	end
	if v3 ~= "TriggerFlash" then
		return v3 == "EndFlash" and {
			["action"] = v3
		} or (v3 == "BossSpawned" and {
			["action"] = v3
		} or (v3 == "EndCutscene" and {
			["action"] = v3
		} or nil))
	end
	local v14 = p2.position
	if typeof(v14) ~= "Vector3" then
		return nil
	end
	local v15 = p2.fadeIn
	local v16 = (typeof(v15) ~= "number" or v15 < 0) and 0.35 or v15
	local v17 = p2.hold
	local v18 = (typeof(v17) ~= "number" or v17 < 0) and 0.4 or v17
	local v19 = p2.fadeOut
	return {
		["action"] = v3,
		["position"] = v14,
		["fadeIn"] = v16,
		["hold"] = v18,
		["fadeOut"] = (typeof(v19) ~= "number" or v19 < 0) and 0.6 or v19
	}
end)