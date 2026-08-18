local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = {
	["StartHallucination"] = true,
	["ShowSequence"] = true,
	["Clear"] = true
}
local function v_u_14(p3) -- name: sanitizeMessages
	if typeof(p3) ~= "table" then
		return {}
	end
	local v4 = {}
	for v5, v9 in ipairs(p3) do
		if v5 > 6 then
			break
		end
		local v7 = nil
		local v8 = nil
		local v9
		if typeof(v9) == "table" then
			local v10 = v9.text
			if typeof(v10) == "string" then
				if #v10 > 120 then
					v10 = string.sub(v10, 1, 120)
				end
			else
				v10 = nil
			end
			local v11 = v9.duration
			if typeof(v11) == "number" then
				local v12 = v9.duration
				local v13 = math.min(v12, 10)
				v8 = math.max(0.5, v13)
				v9 = v10
			else
				v9 = v10
			end
		elseif typeof(v9) == "string" then
			if typeof(v9) == "string" then
				if #v9 > 120 then
					v9 = string.sub(v9, 1, 120)
				end
			else
				v9 = nil
			end
		else
			v9 = v7
		end
		if v9 then
			table.insert(v4, {
				["text"] = v9,
				["duration"] = v8 or 3
			})
		end
	end
	return v4
end
return require(v1.Packages.Red).SharedEvent("BadEndingEvent", function(p15)
	-- upvalues: (copy) v_u_2, (copy) v_u_14
	if typeof(p15) ~= "table" then
		return nil
	end
	local v16 = p15.action
	if not v_u_2[v16] then
		return nil
	end
	if v16 ~= "StartHallucination" then
		if v16 ~= "ShowSequence" then
			return {
				["action"] = v16
			}
		end
		local v17 = p15.fadeTime
		local v18
		if typeof(v17) == "number" then
			local v19 = p15.fadeTime
			v18 = math.clamp(v19, 0, 5)
		else
			v18 = 1.5
		end
		return {
			["action"] = v16,
			["fadeTime"] = v18,
			["messages"] = v_u_14(p15.messages)
		}
	end
	local v20 = p15.intensity
	local v21
	if typeof(v20) == "number" then
		local v22 = p15.intensity
		v21 = math.clamp(v22, 0, 5)
	else
		v21 = 1
	end
	local v23 = p15.profile
	local v24
	if typeof(v23) == "string" then
		local v25 = string.sub(v23, 1, 32)
		if v25 == "" then
			v24 = nil
		else
			v24 = string.lower(v25)
			if not string.match(v24, "^[%w_%-%?%.]+$") then
				v24 = nil
			end
		end
	else
		v24 = nil
	end
	local v26 = p15.resume
	if typeof(v26) ~= "boolean" then
		v26 = nil
	end
	local v27 = {
		["action"] = v16,
		["intensity"] = v21
	}
	if v24 then
		v27.profile = v24
	end
	if v26 ~= nil then
		v27.resume = v26
	end
	return v27
end)