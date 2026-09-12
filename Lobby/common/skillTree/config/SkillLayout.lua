local v1, v2, v3, v4, v5
local u119 = {
    {"core1", "core2", "core3", "core4", "core5"},
}
local u90 = {
    {"steadyAim", "fastHands"},
    {"deepPockets", "quickInteract", "sleightSwitch", "meleeTempo"},
    {"fury", "deadEye", "parryMaster"},
    {"quickDraw"},
}
local u122 = {
    {"thickSkin", "grit"},
    {"adrenaline", "ironWill", "desperateSprint"},
    {"secondChance", "swanSong", "secondWind", "lastStand"},
    {"theSpartan"},
}
local u124 = {}
local v6 = u119[1]
local v7 = nil
local v8 = nil
for i, j in v6, v7, v8 do
    v5 = {column = 0, row = (i - 1) * 1.5}
    u124[j] = v5
end
v6 = u122
v7 = nil
v8 = nil
for k, n in v6, v7, v8 do
    v5 = #n
    v1 = n
    v2 = nil
    v3 = nil
    for m, i5 in v1, v2, v3 do
        v4 = {row = 1.5 + ((v5 - 1) / 2 - (m - 1)), column = -k}
        u124[i5] = v4
    end
end
v6 = u90
v7 = nil
v8 = nil
for i6, i7 in v6, v7, v8 do
    v5 = #i7
    v1 = i7
    v2 = nil
    v3 = nil
    for i8, i9 in v1, v2, v3 do
        v4 = {row = 3 + ((v5 - 1) / 2 - (i8 - 1)), column = i6}
        u124[i9] = v4
    end
end
return {
    positions = u124,
    combatTiers = u90,
    survivalTiers = u122,
    coreTiers = u119,
    getPosition = function(p1) -- Line: 87 -- upvalues: u124 (val)
        return u124[p1]
    end,
    getTierInfo = function(p1) -- Line: 92 -- upvalues: u90 (val), u122 (val), u119 (val)
        local v1, v2, v3
        local v4 = u90
        local v5 = nil
        local v6 = nil
        local v7 = p1
        for i, j in v4, v5, v6 do
            v1 = j
            v2 = nil
            v3 = nil
            for k, n in v1, v2, v3 do
                if n == v7 then
                    return {branch = "combat", tier = i}
                end
            end
        end
        v4 = u122
        v5 = nil
        v6 = nil
        for m, i5 in v4, v5, v6 do
            v1 = i5
            v2 = nil
            v3 = nil
            for i6, i7 in v1, v2, v3 do
                if i7 == v7 then
                    return {branch = "survival", tier = m}
                end
            end
        end
        v4 = u119[1]
        v5 = nil
        v6 = nil
        for i8, i9 in v4, v5, v6 do
            if i9 == v7 then
                return {branch = "core", tier = 0}
            end
        end
        return nil
    end,
}