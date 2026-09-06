local u0 = {}
local v1 = {}
local v2 = {}
v2.MostPoints = {
    accumulator = false,
    better = function(p1, p2) -- Line: 9
        local v1 = not p1
        if not v1 then
            v1 = p1 < p2
        end
        return v1
    end,
}
v1.Deadeye = v2
v2 = {}
v2.FastestTime = {
    accumulator = false,
    ascending = true,
    better = function(p1, p2) -- Line: 15
        local v1 = not p1
        if not v1 then
            v1 = if p1 ~= 0 then p2 < p1 else true
        end
        return v1
    end,
}
v1.GunGame = v2
v2 = {
    TotalKills = {accumulator = true},
}
v2.FastestTime = {
    accumulator = false,
    ascending = true,
    better = function(p1, p2) -- Line: 25
        local v1 = not p1
        if not v1 then
            v1 = if p1 ~= 0 then p2 < p1 else true
        end
        return v1
    end,
}
v1.Survival = v2
v2 = {}
v2.MostKills = {
    accumulator = false,
    better = function(p1, p2) -- Line: 32
        local v1 = not p1
        if not v1 then
            v1 = p1 < p2
        end
        return v1
    end,
}
v2.TotalKills = {accumulator = true}
v1.MinigunFiesta = v2
v2 = {}
v2.MostTurkeysKilled = {
    accumulator = false,
    better = function(p1, p2) -- Line: 41
        local v1 = not p1
        if not v1 then
            v1 = p1 < p2
        end
        return v1
    end,
}
v2.MostTurkeyWins = {accumulator = true}
v2.MostHunterWins = {accumulator = true}
v1.TurkeyHunt = v2
u0.ARCADE_MODES = v1
v1 = {}
v2 = {accumulator = false}
function v2.better(p1, p2) -- Line: 56
    local v1 = not p1
    if not v1 then
        v1 = p1 < p2
    end
    return v1
end
v2.dataPath = {"Progression", "Arcade", "Level"}
v1.Level = v2
v2 = {accumulator = true}
local v3 = {"Progression", "Arcade", "PlayTime"}
v2.dataPath = v3
v1.PlayTime = v2
u0.ARCADE_PROGRESSION = v1
v1 = {"Easy", "Medium", "Hard", "Nightmare"}
u0.DIFFICULTIES = v1
function u0.CreateArcadeLeaderboardStructure() -- Line: 71 -- upvalues: u0 (val)
    local v1
    local v2 = {}
    for k, v in pairs(u0.ARCADE_MODES) do
        v2[k] = {}
        for k2, i in pairs(v) do
            v2[k][k2] = {}
            for i2, j in ipairs(u0.DIFFICULTIES) do
                v1 = v2[k][k2]
                v1[j] = 0
            end
        end
    end
    return v2
end
function u0.GenerateArcadeConfigEntries() -- Line: 89 -- upvalues: u0 (val)
    local v1 = {}
    for k, v in pairs(u0.ARCADE_MODES) do
        v1[k] = {}
        for k2, i in pairs(v) do
            table.insert(v1[k], {
                dsKey = k2,
                dataPath = {k, k2},
                accumulator = i.accumulator,
                better = i.better,
            })
        end
    end
    return v1
end
function u0.GenerateArcadeProgressionConfigEntries() -- Line: 109 -- upvalues: u0 (val)
    local v1 = {}
    for k, v in pairs(u0.ARCADE_PROGRESSION) do
        table.insert(v1, {dsKey = k, dataPath = v.dataPath, accumulator = v.accumulator, better = v.better})
    end
    return v1
end
function u0.GetArcadeProgressionStats() -- Line: 125 -- upvalues: u0 (val)
    local v1 = {}
    for k, v in pairs(u0.ARCADE_PROGRESSION) do
        table.insert(v1, k)
    end
    return v1
end
function u0.GetArcadeStatsForMode(p1) -- Line: 134 -- upvalues: u0 (val)
    local v1 = {}
    if u0.ARCADE_MODES[p1] then
        for k, v in pairs(u0.ARCADE_MODES[p1]) do
            table.insert(v1, k)
        end
    end
    return v1
end
function u0.GetAllArcadeModes() -- Line: 145 -- upvalues: u0 (val)
    local v1 = {}
    for k, v in pairs(u0.ARCADE_MODES) do
        table.insert(v1, k)
    end
    return v1
end
function u0.IsArcadeAscendingMode(p1, p2) -- Line: 154 -- upvalues: u0 (val)
    local v1, v2
    if not p2 then
        v1 = p1
        v2 = v1 == "GunGame"
        return v2
    end
    if p1 == "Arcade" then
        v2 = u0.ARCADE_PROGRESSION[p2]
        if not v2 then
            v1 = p1
            v2 = v1 == "GunGame"
            return v2
        end
        if v2.ascending ~= nil then
            return v2.ascending
        end
        v1 = p1
        v2 = v1 == "GunGame"
        return v2
    end
    v2 = u0.ARCADE_MODES[p1]
    local v3 = v2
    if v3 then
        v3 = v2[p2]
    end
    if not v3 then
        v1 = p1
        v2 = v1 == "GunGame"
        return v2
    end
    if v3.ascending ~= nil then
        return v3.ascending
    end
    v1 = p1
    v2 = v1 == "GunGame"
    return v2
end
u0.MODES = u0.ARCADE_MODES
u0.CreateDefaultLeaderboardStructure = u0.CreateArcadeLeaderboardStructure
u0.GenerateConfigEntries = u0.GenerateArcadeConfigEntries
u0.GetStatsForMode = u0.GetArcadeStatsForMode
u0.GetAllModes = u0.GetAllArcadeModes
u0.IsAscendingMode = u0.IsArcadeAscendingMode
return u0