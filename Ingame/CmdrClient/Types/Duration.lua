local v_u_1 = require("../Shared/Util")
local v_u_2 = {
	["Years"] = 31556926,
	["Months"] = 2629744,
	["Weeks"] = 604800,
	["Days"] = 86400,
	["Hours"] = 3600,
	["Minutes"] = 60,
	["Seconds"] = 1
}
local v3 = {}
for v4, _ in pairs(v_u_2) do
	table.insert(v3, v4)
end
local v_u_5 = v_u_1.MakeFuzzyFinder(v3)
local function v_u_14(p6) -- name: stringToSecondDuration
	-- upvalues: (copy) v_u_5, (copy) v_u_2
	if p6 == nil or p6 == "" then
		return nil
	else
		local v7 = tonumber(p6)
		if v7 and v7 == 0 then
			return 0, 0, true
		else
			local v8 = p6:gsub("-?%d+%a+", ""):match("-?%d+")
			if v8 then
				return nil, tonumber(v8), true
			else
				local v9 = nil
				local v10 = nil
				for v11 in p6:gmatch("-?%d+%a+") do
					local v12
					v10, v12 = v11:match("(-?%d+)(%a+)")
					local v13 = v_u_5(v12)
					if #v13 == 0 then
						return nil, tonumber(v10)
					end
					v9 = (v9 == nil and 0 or v9) + (v12:lower() == "m" and 60 or v_u_2[v13[1]]) * tonumber(v10)
				end
				if v9 == nil then
					return nil
				else
					return v9, tonumber(v10)
				end
			end
		end
	end
end
local function v_u_23(p15, p16, p17, p18) -- name: mapUnits
	local v19 = p18 or 1
	local v20 = {}
	for v21, v22 in pairs(p15) do
		if p17 == 1 then
			v20[v21] = p16 .. v22:sub(v19, #v22 - 1)
		else
			v20[v21] = p16 .. v22:sub(v19)
		end
	end
	return v20
end
local v_u_34 = {
	["Transform"] = function(p24) -- name: Transform
		-- upvalues: (copy) v_u_14
		return p24, v_u_14(p24)
	end,
	["Validate"] = function(_, p25) -- name: Validate
		return p25 ~= nil
	end,
	["Autocomplete"] = function(p26, p27, p28, p29, p30) -- name: Autocomplete
		-- upvalues: (copy) v_u_5, (copy) v_u_23
		local v31 = {}
		if p29 or p30 then
			if p29 == true then
				p30 = v_u_5("") or p30
			end
			if p29 == true then
				return v_u_23(p30, p26, p28)
			else
				return v_u_23(p30, p26, p26:match("^.*(%a+)$"):len() + 1)
			end
		else
			if p27 ~= nil then
				local v32 = p26:match("^.*-?%d+(%a+)%s?$")
				v31 = v_u_23(v_u_5(v32), p26, p28, #v32 + 1)
				table.sort(v31)
			end
			return v31
		end
	end,
	["Parse"] = function(_, p33) -- name: Parse
		return p33
	end
}
return function(p35)
	-- upvalues: (copy) v_u_34, (copy) v_u_1
	p35:RegisterType("duration", v_u_34)
	p35:RegisterType("durations", v_u_1.MakeListableType(v_u_34))
end