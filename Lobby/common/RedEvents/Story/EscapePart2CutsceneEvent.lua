return require(game.ReplicatedStorage.Packages.Red).SharedEvent("EscapePart2Cutscene", function(p1)
	if typeof(p1) == "table" then
		local v2 = p1.action
		if v2 == "Play" then
			local v3 = p1.cameraCFrame
			local v4 = p1.travelTime
			local v5 = p1.holdTime
			if v3 == nil or typeof(v3) == "CFrame" then
				if v4 == nil or typeof(v4) == "number" then
					return (v5 == nil or typeof(v5) == "number") and {
						["action"] = v2,
						["cameraCFrame"] = v3,
						["travelTime"] = v4,
						["holdTime"] = v5
					} or nil
				else
					return nil
				end
			else
				return nil
			end
		else
			if v2 ~= "StartEndCutscene" then
				return v2 == "Stop" and {
					["action"] = v2
				} or (v2 == "CompleteEndCutscene" and {
					["action"] = v2
				} or nil)
			end
			local v6 = p1.triggeringPlayerName
			local v7
			if typeof(v6) == "string" then
				local v8 = p1.triggeringPlayerName
				v7 = string.sub(v8, 1, 32)
			else
				v7 = nil
			end
			local v9 = p1.animations
			local v10
			if typeof(v9) == "table" then
				v10 = {}
				for v11, v12 in pairs(p1.animations) do
					if typeof(v11) == "string" and typeof(v12) == "table" then
						local v13 = v12.id
						if typeof(v13) == "string" then
							v10[v11] = {
								["id"] = v13,
								["looped"] = v12.looped == true
							}
						end
					end
				end
			else
				v10 = nil
			end
			local v14 = p1.rotorSoundId
			local v15
			if typeof(v14) == "string" then
				v15 = p1.rotorSoundId
			else
				v15 = nil
			end
			return {
				["action"] = v2,
				["triggeringPlayerName"] = v7,
				["animations"] = v10,
				["rotorSoundId"] = v15
			}
		end
	else
		return nil
	end
end)