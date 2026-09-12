local Price, v1, v2, v3, v4
local ItemData = require(script.Parent.ItemData)
local u132 = {
    PERIOD_SECONDS = 86400,
    EPOCH = 0,
    SEED_SALT = 5918541,
    SLOT_TEMPLATE = {"Rare", "Rare", "Unique", "Unique", "Typical", "Typical"},
    MAX_SANE_PRICE = 100000,
}
local u135 = {Rare = true, Unique = true, Typical = true}
local u137 = {
    Rare = {"Rare", "Unique", "Typical"},
    Unique = {"Unique", "Typical", "Rare"},
    Typical = {"Typical", "Unique", "Rare"},
}

local function hashSeed(p1) -- Line: 30
    local v1 = 0
    local v2 = #p1
    for i = 1, v2 do
        v1 = (v1 * 31 + string.byte(p1, i)) % 2147483647
    end
    return v1
end

local function isEligible(p1, p2) -- Line: 38 -- upvalues: u132 (val), u135 (val)
    local Price = p2.Price
    local v1 = tonumber(Price)
    if not p2.Inactive and v1 and not (v1 <= 0) and not (u132.MAX_SANE_PRICE <= v1) then
        local v2 = false
        if u135[p1] == true then
            v2 = false
            if p2.Rarity == p1 then
                v2 = p2.Featureable == true
            end
        end
        return v2
    end
    return false
end

local u139 = {}
for k in pairs(u137) do
    v1 = {}
    for k2, v in pairs(ItemData.List) do
        Price = v.Price
        v3 = tonumber(Price)
        if v.Inactive or not v3 or v3 <= 0 then
            v2 = false
        elseif not (u132.MAX_SANE_PRICE <= v3) then
            v2 = false
            if u135[k] == true then
                v2 = false
                if v.Rarity == k then
                    v2 = v.Featureable == true
                end
            end
        else
            v2 = false
        end
        if v2 then
            v4 = tostring(k2)
            table.insert(v1, v4)
        end
    end
    table.sort(v1, function(p1, p2) -- Line: 55
        local v1
        local v2 = tonumber(p1)
        local v3 = tonumber(p2)
        if v2 and v3 and v2 ~= v3 then
            v1 = v2 < v3
            return v1
        end
        v1 = p1 < p2
        return v1
    end)
    u139[k] = v1
end
local u45 = {}
for i, i2 in ipairs(u132.SLOT_TEMPLATE) do
    u45[i2] = (u45[i2] or 0) + 1
end
local u59 = {}

local function getShuffle(p1, p2) -- Line: 72 -- upvalues: u59 (val), u139 (val), u132 (val)
    local v1
    local v2 = u59
    local v3 = u59[p1]
    if not v3 then
        v3 = {}
    end
    v2[p1] = v3
    v2 = u59[p1][p2]
    if v2 then
        return v2
    end
    v3 = table.clone(u139[p1])
    local SEED_SALT = u132.SEED_SALT
    local v4 = 0
    local v5 = #p1
    for i = 1, v5 do
        v4 = (v4 * 31 + string.byte(p1, i)) % 2147483647
    end
    local v6 = (SEED_SALT + v4 + p2) % 2147483647
    local v7 = Random.new(v6)
    for j = #v3, 2, -1 do
        v4 = v7:NextInteger(1, j)
        v5 = v3[v4]
        v1 = v3[j]
        v3[j] = v5
        v3[v4] = v1
    end
    u59[p1][p2] = v3
    return v3
end

local function getBucketItem(p1, p2) -- Line: 90 -- upvalues: u139 (val), getShuffle (val)
    local v1 = #u139[p1]
    if v1 == 0 then
        return nil
    end
    local v2 = p2 / v1
    local v3 = math.floor(v2)
    v2 = p2 % v1
    return (getShuffle(p1, v3))[v2 + 1]
end

local function chooseSlotItem(p1, p2, p3, p4) -- Line: 101
    -- upvalues: u137 (val), u139 (val), u45 (val), getShuffle (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    local v10, v11, v12, v13 = p1, p3, p2, p4
    for i, v in ipairs(u137[p1]) do
        v9 = #u139[v]
        v1 = u45[v] or 1
        if 0 < v9 then
            if v == v10 and not (v11 <= v9) then
                continue
            end
            v2 = v12 * v1 + v11 - 1
            v3 = v9 - 1
            for i2 = 0, v3 do
                v5 = v2 + i2
                v6 = #u139[v]
                if v6 ~= 0 then
                    v8 = v5 / v6
                    v7 = math.floor(v8)
                    v8 = v5 % v6
                    v4 = (getShuffle(v, v7))[v8 + 1]
                else
                    v4 = nil
                end
                if v4 and not v13[v4] then
                    return v4
                end
            end
        end
    end
    return nil
end

function u132.GetDayIndex(p1) -- Line: 119 -- upvalues: u132 (val)
    local v1 = p1 - u132.EPOCH
    local v2 = u132
    local v3 = v1 / v2.PERIOD_SECONDS
    return (math.floor(v3))
end

function u132.GetPeriodBounds(p1) -- Line: 123 -- upvalues: u132 (val)
    local v1 = u132
    v1 = v1.GetDayIndex(p1)
    local v2 = u132.EPOCH + v1 * u132.PERIOD_SECONDS
    return v2, v2 + u132.PERIOD_SECONDS
end

function u132.GetSelection(p1) -- Line: 129 -- upvalues: u132 (val), chooseSlotItem (val)
    local v1
    local v2 = math.floor(p1)
    local v3 = {}
    local v4 = {}
    local v5 = {}
    for i, v in ipairs(u132.SLOT_TEMPLATE) do
        v5[v] = (v5[v] or 0) + 1
        v1 = chooseSlotItem(v, v2, v5[v], v4)
        if v1 then
            table.insert(v3, v1)
            v4[v1] = true
        end
    end
    return v3
end

function u132.IsFeaturedOn(p1, p2) -- Line: 147 -- upvalues: u132 (val)
    local v1 = tostring(p2)
    for i, v in ipairs(u132.GetSelection(p1)) do
        if v == v1 then
            return true
        end
    end
    return false
end

return u132