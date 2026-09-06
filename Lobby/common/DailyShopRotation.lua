local v1, v2, v3
local ItemData = require(script.Parent.ItemData)
local u146 = {PERIOD_SECONDS = 86400, EPOCH = 0, SEED_SALT = 5918541}
local v4 = {
    "Rare",
    "Rare",
    "Unique",
    "Unique",
    "Typical",
    "Outfit",
}
u146.SLOT_TEMPLATE = v4
u146.MAX_SANE_PRICE = 100000
local u150 = {Rare = true, Unique = true, Typical = true}
local u153 = {
    Rare = {"Rare", "Unique", "Typical", "Outfit"},
    Unique = {"Unique", "Typical", "Rare", "Outfit"},
    Typical = {"Typical", "Unique", "Rare", "Outfit"},
}
local v5 = {"Outfit", "Typical", "Unique", "Rare"}
u153.Outfit = v5
local function hashSeed(p1) -- Line: 31
    local v1 = 0
    local v2 = #p1
    local v3 = 1
    for i = 1, v2, v3 do
        v1 = (v1 * 31 + string.byte(p1, i)) % 2147483647
    end
    return v1
end
local function isEligible(p1, p2) -- Line: 39 -- upvalues: u146 (val), u150 (val)
    local v1
    local v2 = tonumber(p2.Price)
    if p2.Inactive or not v2 or v2 <= 0 or u146.MAX_SANE_PRICE <= v2 then
        return false
    end
    if u150[p1] == true then
        v1 = if p2.Rarity == p1 then p2.Featureable == true else false
    else
        v1 = if p1 == "Outfit" then if p2.Rarity == p1 then p2.Featureable == true else false else false
    end
    return v1
end
local u156 = {}
for k in pairs(u153) do
    v1 = {}
    for k2, v in pairs(ItemData.List) do
        v3 = tonumber(v.Price)
        if v.Inactive then
            v2 = false
        elseif v3 and v3 > 0 and u146.MAX_SANE_PRICE > v3 then
            if u150[k] == true then
                v2 = if v.Rarity == k then v.Featureable == true else false
            else
                v2 = false
                if k ~= "Outfit" then end
            end
        end
        if v2 then
            table.insert(v1, (tostring(k2)))
        end
    end
    table.sort(v1, function(p1, p2) -- Line: 58
        local v1
        local v2 = tonumber(p1)
        local v3 = tonumber(p2)
        if not v2 or not v3 then
            v1 = p1 < p2
            return v1
        end
        if v2 ~= v3 then
            v1 = v2 < v3
            return v1
        end
        v1 = p1 < p2
        return v1
    end)
    u156[k] = v1
end
local u53 = {}
for i, i2 in ipairs(u146.SLOT_TEMPLATE) do
    u53[i2] = (u53[i2] or 0) + 1
end
local u67 = {}
local function getShuffle(p1, p2) -- Line: 75 -- upvalues: u67 (val), u156 (val), u146 (val)
    local v1 = u67[p1]
    if not v1 then
        v1 = {}
    end
    u67[p1] = v1
    local v2 = u67[p1][p2]
    if v2 then
        return v2
    end
    v1 = table.clone(u156[p1])
    local SEED_SALT = u146.SEED_SALT
    local v3 = 0
    local v4 = #p1
    local v5 = 1
    for i = 1, v4, v5 do
        v3 = (v3 * 31 + string.byte(p1, i)) % 2147483647
    end
    local v6 = Random.new((SEED_SALT + v3 + p2) % 2147483647)
    local v7 = 2
    local v8 = -1
    for j = #v1, v7, v8 do
        v3 = v6:NextInteger(1, j)
        v5 = v1[j]
        v1[j] = v1[v3]
        v1[v3] = v5
    end
    u67[p1][p2] = v1
    return v1
end
local function getBucketItem(p1, p2) -- Line: 93 -- upvalues: u156 (val), getShuffle (val)
    local v1 = #u156[p1]
    if v1 == 0 then
        return nil
    end
    local v2 = math.floor(p2 / v1)
    local v3 = getShuffle(p1, v2)
    return v3[p2 % v1 + 1]
end
local function chooseSlotItem(p1, p2, p3, p4) -- Line: 104 -- upvalues: u153 (val), u156 (val), u53 (val), getShuffle (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13
    v1, v10, v2, v12 = p1, p3, p2, p4
    for i, v in ipairs(u153[p1]) do
        v13 = #u156[v]
        if 0 < v13 then
            if v == v1 and v10 > v13 then
                continue
            end
            v3 = v2 * (u53[v] or 1) + v10 - 1
            v4 = v13 - 1
            v5 = 1
            for i2 = 0, v4, v5 do
                v7 = v3 + i2
                v8 = #u156[v]
                if v8 ~= 0 then
                    v9 = math.floor(v7 / v8)
                    v11 = getShuffle(v, v9)
                    v6 = v11[v7 % v8 + 1]
                else
                    v6 = nil
                end
                if v6 and not (v12[v6]) then
                    return v6
                end
            end
        end
    end
    return nil
end
function u146.GetDayIndex(p1) -- Line: 122 -- upvalues: u146 (val)
    local v1 = p1 - u146.EPOCH
    return (math.floor(v1 / u146.PERIOD_SECONDS))
end
function u146.GetPeriodBounds(p1) -- Line: 126 -- upvalues: u146 (val)
    local v1 = u146.EPOCH + u146.GetDayIndex(p1) * u146.PERIOD_SECONDS
    return v1, v1 + u146.PERIOD_SECONDS
end
function u146.GetSelection(p1) -- Line: 132 -- upvalues: u146 (val), chooseSlotItem (val)
    local v1
    local v2 = {}
    local v3 = {}
    local v4 = {}
    for i, v in ipairs(u146.SLOT_TEMPLATE) do
        v4[v] = (v4[v] or 0) + 1
        v1 = chooseSlotItem(v, math.floor(p1), v4[v], v3)
        if v1 then
            table.insert(v2, v1)
            v3[v1] = true
        end
    end
    return v2
end
function u146.IsFeaturedOn(p1, p2) -- Line: 150 -- upvalues: u146 (val)
    for i, v in ipairs(u146.GetSelection(p1)) do
        if v == tostring(p2) then
            return true
        end
    end
    return false
end
return u146