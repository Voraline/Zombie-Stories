local v1, v2, v3
local u119 = {}
local v4 = {
    "core1",
    "core2",
    "core3",
    "core4",
    "core5",
}
u119[1] = v4
local u90 = {}
local v5 = {"steadyAim", "fastHands"}
u90[1] = v5
u90[2] = {"deepPockets", "quickInteract", "sleightSwitch", "meleeTempo"}
u90[3] = {"fury", "deadEye", "parryMaster"}
u90[4] = {"quickDraw"}
local u122 = {}
local v6 = {"thickSkin", "grit"}
u122[1] = v6
u122[2] = {"adrenaline", "ironWill", "desperateSprint"}
u122[3] = {"secondChance", "swanSong", "secondWind", "lastStand"}
u122[4] = {"theSpartan"}
local u124 = {}
local v7 = u119[1]
local v8 = nil
local v9 = nil
for i, j in v7, v8, v9 do
    u124[j] = {column = 0, row = (i - 1) * 1.5}
end
v7 = u122
v8 = nil
v9 = nil
for k, n in v7, v8, v9 do
    v1 = n
    v2 = nil
    v3 = nil
    for m, i5 in v1, v2, v3 do
        u124[i5] = {row = 1.5 + ((#n - 1) / 2 - (m - 1)), column = -k}
    end
end
v7 = u90
v8 = nil
v9 = nil
for i6, i7 in v7, v8, v9 do
    v1 = i7
    v2 = nil
    v3 = nil
    for i8, i9 in v1, v2, v3 do
        u124[i9] = {row = 3 + ((#i7 - 1) / 2 - (i8 - 1)), column = i6}
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