local v_u_1 = {}
local v2 = {}
local v5 = {
	["MostPoints"] = {
		["accumulator"] = false,
		["better"] = nil,
		["better"] = function(p3, p4) -- name: better
			return not p3 or p3 < p4
		end
	}
}
v2.Deadeye = v5
local v8 = {
	["FastestTime"] = {
		["accumulator"] = false,
		["better"] = nil,
		["ascending"] = true,
		["better"] = function(p6, p7) -- name: better
			return not p6 or (p6 == 0 and true or p7 < p6)
		end
	}
}
v2.GunGame = v8
local v11 = {
	["TotalKills"] = {
		["accumulator"] = true
	},
	["FastestTime"] = {
		["accumulator"] = false,
		["better"] = nil,
		["ascending"] = true,
		["better"] = function(p9, p10) -- name: better
			return not p9 or (p9 == 0 and true or p10 < p9)
		end
	}
}
v2.Survival = v11
local v14 = {
	["MostKills"] = {
		["accumulator"] = false,
		["better"] = nil,
		["better"] = function(p12, p13) -- name: better
			return not p12 or p12 < p13
		end
	},
	["TotalKills"] = {
		["accumulator"] = true
	}
}
v2.MinigunFiesta = v14
local v17 = {
	["MostTurkeysKilled"] = {
		["accumulator"] = false,
		["better"] = nil,
		["better"] = function(p15, p16) -- name: better
			return not p15 or p15 < p16
		end
	},
	["MostTurkeyWins"] = {
		["accumulator"] = true
	},
	["MostHunterWins"] = {
		["accumulator"] = true
	}
}
v2.TurkeyHunt = v17
v_u_1.ARCADE_MODES = v2
local v20 = {
	["Level"] = {
		["accumulator"] = false,
		["better"] = nil,
		["dataPath"] = nil,
		["better"] = function(p18, p19) -- name: better
			return not p18 or p18 < p19
		end,
		["dataPath"] = { "Progression", "Arcade", "Level" }
	},
	["PlayTime"] = {
		["accumulator"] = true,
		["dataPath"] = nil,
		["dataPath"] = { "Progression", "Arcade", "PlayTime" }
	}
}
v_u_1.ARCADE_PROGRESSION = v20
v_u_1.DIFFICULTIES = {
	"Easy",
	"Medium",
	"Hard",
	"Nightmare"
}
function v_u_1.CreateArcadeLeaderboardStructure() -- name: CreateArcadeLeaderboardStructure
	-- upvalues: (copy) v_u_1
	local v21 = {}
	for v22, v23 in pairs(v_u_1.ARCADE_MODES) do
		v21[v22] = {}
		for v24, _ in pairs(v23) do
			v21[v22][v24] = {}
			for _, v25 in ipairs(v_u_1.DIFFICULTIES) do
				v21[v22][v24][v25] = 0
			end
		end
	end
	return v21
end
function v_u_1.GenerateArcadeConfigEntries() -- name: GenerateArcadeConfigEntries
	-- upvalues: (copy) v_u_1
	local v26 = {}
	for v27, v28 in pairs(v_u_1.ARCADE_MODES) do
		v26[v27] = {}
		for v29, v30 in pairs(v28) do
			local v31 = v26[v27]
			local v32 = {
				["dsKey"] = v29,
				["dataPath"] = { v27, v29 },
				["accumulator"] = v30.accumulator,
				["better"] = v30.better
			}
			table.insert(v31, v32)
		end
	end
	return v26
end
function v_u_1.GenerateArcadeProgressionConfigEntries() -- name: GenerateArcadeProgressionConfigEntries
	-- upvalues: (copy) v_u_1
	local v33 = {}
	for v34, v35 in pairs(v_u_1.ARCADE_PROGRESSION) do
		local v36 = {
			["dsKey"] = v34,
			["dataPath"] = v35.dataPath,
			["accumulator"] = v35.accumulator,
			["better"] = v35.better
		}
		table.insert(v33, v36)
	end
	return v33
end
function v_u_1.GetArcadeProgressionStats() -- name: GetArcadeProgressionStats
	-- upvalues: (copy) v_u_1
	local v37 = {}
	for v38, _ in pairs(v_u_1.ARCADE_PROGRESSION) do
		table.insert(v37, v38)
	end
	return v37
end
function v_u_1.GetArcadeStatsForMode(p39) -- name: GetArcadeStatsForMode
	-- upvalues: (copy) v_u_1
	local v40 = {}
	if v_u_1.ARCADE_MODES[p39] then
		for v41, _ in pairs(v_u_1.ARCADE_MODES[p39]) do
			table.insert(v40, v41)
		end
	end
	return v40
end
function v_u_1.GetAllArcadeModes() -- name: GetAllArcadeModes
	-- upvalues: (copy) v_u_1
	local v42 = {}
	for v43, _ in pairs(v_u_1.ARCADE_MODES) do
		table.insert(v42, v43)
	end
	return v42
end
function v_u_1.IsArcadeAscendingMode(p44, p45) -- name: IsArcadeAscendingMode
	-- upvalues: (copy) v_u_1
	if p45 then
		if p44 == "Arcade" then
			local v46 = v_u_1.ARCADE_PROGRESSION[p45]
			if v46 and v46.ascending ~= nil then
				return v46.ascending
			end
		else
			local v47 = v_u_1.ARCADE_MODES[p44]
			if v47 then
				v47 = v47[p45]
			end
			if v47 and v47.ascending ~= nil then
				return v47.ascending
			end
		end
	end
	return p44 == "GunGame"
end
v_u_1.MODES = v_u_1.ARCADE_MODES
v_u_1.CreateDefaultLeaderboardStructure = v_u_1.CreateArcadeLeaderboardStructure
v_u_1.GenerateConfigEntries = v_u_1.GenerateArcadeConfigEntries
v_u_1.GetStatsForMode = v_u_1.GetArcadeStatsForMode
v_u_1.GetAllModes = v_u_1.GetAllArcadeModes
v_u_1.IsAscendingMode = v_u_1.IsArcadeAscendingMode
return v_u_1