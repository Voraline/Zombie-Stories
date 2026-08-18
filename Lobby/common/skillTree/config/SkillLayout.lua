local v_u_1 = {
	{
		"core1",
		"core2",
		"core3",
		"core4",
		"core5"
	}
}
local v_u_2 = {}
local v_u_3 = {
	{ "thickSkin", "grit" },
	{ "adrenaline", "ironWill", "desperateSprint" },
	{
		"secondChance",
		"swanSong",
		"secondWind",
		"lastStand"
	},
	{ "theSpartan" }
}
local v_u_4 = {
	{ "steadyAim", "fastHands" },
	{
		"deepPockets",
		"quickInteract",
		"sleightSwitch",
		"meleeTempo"
	},
	{ "fury", "deadEye", "parryMaster" },
	{ "quickDraw" }
}
for v5, v6 in v_u_1[1] do
	v_u_2[v6] = {
		["row"] = nil,
		["column"] = 0,
		["row"] = (v5 - 1) * 1.5
	}
end
for v7, v8 in v_u_3 do
	local v9 = #v8
	for v10, v11 in v8 do
		v_u_2[v11] = {
			["row"] = 1.5 + ((v9 - 1) / 2 - (v10 - 1)),
			["column"] = -v7
		}
	end
end
for v12, v13 in v_u_4 do
	local v14 = #v13
	for v15, v16 in v13 do
		v_u_2[v16] = {
			["row"] = 3 + ((v14 - 1) / 2 - (v15 - 1)),
			["column"] = v12
		}
	end
end
return {
	["positions"] = v_u_2,
	["combatTiers"] = v_u_4,
	["survivalTiers"] = v_u_3,
	["coreTiers"] = v_u_1,
	["getPosition"] = function(p17) -- name: getPosition
		-- upvalues: (copy) v_u_2
		return v_u_2[p17]
	end,
	["getTierInfo"] = function(p18) -- name: getTierInfo
		-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_1
		for v19, v20 in v_u_4 do
			for _, v21 in v20 do
				if v21 == p18 then
					return {
						["branch"] = "combat",
						["tier"] = nil,
						["tier"] = v19
					}
				end
			end
		end
		for v22, v23 in v_u_3 do
			for _, v24 in v23 do
				if v24 == p18 then
					return {
						["branch"] = "survival",
						["tier"] = nil,
						["tier"] = v22
					}
				end
			end
		end
		for _, v25 in v_u_1[1] do
			if v25 == p18 then
				return {
					["branch"] = "core",
					["tier"] = 0
				}
			end
		end
		return nil
	end
}