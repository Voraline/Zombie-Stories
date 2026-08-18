local v1 = game:GetService("ReplicatedStorage")
local function v_u_5(p2) -- name: sanitizeSequence
	if typeof(p2) == "table" then
		local v3 = {}
		for _, v4 in ipairs(p2) do
			if typeof(v4) ~= "string" then
				return nil
			end
			table.insert(v3, v4)
		end
		if #v3 == 0 then
			return nil
		else
			return v3
		end
	else
		return nil
	end
end
return require(v1.Packages.Red).SharedEvent("PrayerGrounds", function(p6)
	-- upvalues: (copy) v_u_5
	if typeof(p6) ~= "table" then
		return nil
	end
	local v7 = p6.action
	if typeof(v7) ~= "string" then
		return nil
	end
	if v7 ~= "Configure" then
		if v7 == "Disable" or v7 == "PuzzleComplete" then
			return {
				["action"] = v7
			}
		end
		if v7 ~= "CorrectTile" and v7 ~= "WrongTile" then
			return v7 == "RequestState" and {
				["action"] = v7
			} or nil
		end
		local v8 = p6.tileId
		return typeof(v8) == "string" and {
			["action"] = v7,
			["tileId"] = v8
		} or nil
	end
	local v9 = v_u_5(p6.sequence)
	if not v9 then
		return nil
	end
	local v10 = p6.resetDelay
	if typeof(v10) ~= "number" then
		v10 = nil
	end
	return {
		["action"] = v7,
		["sequence"] = v9,
		["resetDelay"] = v10
	}
end)