local resolveItems
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LevelInfo = require(ReplicatedStorage.common:WaitForChild("LevelInfo"))
local Probabilities = require(script:WaitForChild("Probabilities"))
local u24 = nil

local function getItems() -- Line: 15 -- upvalues: u24 (ref), ReplicatedStorage (val)
    if not u24 then
        u24 = require(ReplicatedStorage.common:WaitForChild("ItemData"))
    end
    return u24
end

local v1 = RunService:IsStudio()
local u29 = {Primary = true, Secondary = true, Melee = true, Outfit = true}
local u30 = {}
local u31 = {}
local u32 = {}
local u33 = {}
local u34 = {}

local function loadCrates() -- Line: 40 -- upvalues: u31 (val), u32 (val)
    local CrateId, Name, v1, v2
    for i, v in ipairs(script:WaitForChild("Crates"):GetChildren()) do
        if v:IsA("ModuleScript") then
            v1 = require(v)
            CrateId = v1.CrateId
            if not CrateId then
                CrateId = v.Name
            end
            if not u31[CrateId] then
                v1.CrateId = CrateId
                if v1.Enabled == nil then
                    v1.Enabled = true
                end
                u31[CrateId] = v1
                if v1.Enabled then
                    u32[CrateId] = v1
                end
            else
                v2 = warn
                Name = v.Name
                v2(("CrateHandler: duplicate CrateId '%s' declared by %s"):format(CrateId, Name))
            end
        end
    end
end

function resolveItems(p1, p2) -- Line: 66 -- upvalues: u33 (val), u31 (val), resolveItems (val)
    local v1
    local v2 = u33[p1]
    if v2 then
        return v2
    end
    local v3 = u31[p1]
    if not v3 then
        return table.freeze({})
    end
    if not v3.SharesPoolWith then
        local freeze = table.freeze
        local clone = table.clone
        local Items = v3.Items
        if not Items then
            Items = {}
        end
        v1 = freeze(clone(Items))
    else
        local v4 = p2 or {}
        local v5 = v4
        if not v5[p1] then
            v5[p1] = true
            if u31[v3.SharesPoolWith] then
                v1 = resolveItems(v3.SharesPoolWith, v5)
            else
                v4 = warn
                local SharesPoolWith = v3.SharesPoolWith
                local v6 = tostring(SharesPoolWith)
                v4(("CrateHandler: '%s' shares a pool with unknown crate '%s'"):format(p1, v6))
                v1 = table.freeze({})
            end
        else
            warn(("CrateHandler: SharesPoolWith cycle reached '%s'"):format(p1))
            v1 = table.freeze({})
        end
    end
    u33[p1] = v1
    return v1
end

local function bucketByRarity(p1) -- Line: 105
    -- upvalues: u34 (val), u24 (ref), ReplicatedStorage (val), resolveItems (val)
    local v1, v2
    local v3 = u34[p1]
    if v3 then
        return v3
    end
    if not u24 then
        u24 = require(ReplicatedStorage.common:WaitForChild("ItemData"))
    end
    local List = u24.List
    local v4 = {}
    local v5 = p1
    for i, v in ipairs(resolveItems(p1)) do
        v2 = List[v]
        if v2 then
            v1 = v4[v2.Rarity]
            if not v1 then
                v1 = {}
                v4[v2.Rarity] = v1
            end
            table.insert(v1, v)
        end
    end
    for k, i2 in pairs(v4) do
        v4[k] = (table.freeze(i2))
    end
    v4 = table.freeze(v4)
    u34[v5] = v4
    return v4
end

loadCrates()
if v1 then
    task.defer(function() -- Line: 135 -- upvalues: u24 (ref), ReplicatedStorage (val), u31 (val), u29 (val), bucketByRarity (val)
        local Items, Name, Name_2, Name_3, ProbabilityTable, Slot, Slot_2, v1, v2, v3, v4, v5, v6, v7
        if not u24 then
            u24 = require(ReplicatedStorage.common:WaitForChild("ItemData"))
        end
        local List = u24.List
        for k, v in pairs(u31) do
            if v.SharesPoolWith and v.Items then
                warn(("CrateHandler: '%s' declares both Items and SharesPoolWith; Items is ignored"):format(k))
            end
            v5 = {}
            v6 = ipairs
            Items = v.Items
            if not Items then
                Items = {}
            end
            for i, i2 in v6(Items) do
                v1 = List[i2]
                if v1 then
                    if v5[i2] then
                        v2 = warn
                        Name = v1.Name
                        v2(("CrateHandler: '%s' lists item '%s' (%s) more than once"):format(k, i2, Name))
                    end
                    v5[i2] = true
                    if v1.Inactive then
                        v2 = warn
                        Name_2 = v1.Name
                        v2(("CrateHandler: '%s' lists inactive item '%s' (%s)"):format(k, i2, Name_2))
                    end
                    if u29[v.Slot] and v1.Slot ~= v.Slot then
                        v2 = warn
                        Slot_2 = v.Slot
                        Name_3 = v1.Name
                        Slot = v1.Slot
                        v4 = tostring(Slot)
                        v2(("CrateHandler: '%s' is a %s crate but lists '%s' (%s), a %s item"):format(
                            k,
                            Slot_2,
                            i2,
                            Name_3,
                            v4
                        ))
                    end
                else
                    v2 = warn
                    v3 = tostring(i2)
                    v2(("CrateHandler: '%s' lists unknown item id '%s'"):format(k, v3))
                end
            end
            v6 = bucketByRarity(k)
            v7 = pairs
            ProbabilityTable = v.ProbabilityTable
            if not ProbabilityTable then
                ProbabilityTable = {}
            end
            for k2, j in v7(ProbabilityTable) do
                if 0 < j and not v6[k2] then
                    warn(("CrateHandler: '%s' rolls %s at %d%% but has no %s items"):format(k, k2, j, k2))
                end
            end
        end
    end)
end
u30.Crates = u31
u30.Probabilities = Probabilities

function u30.Get(p1) -- Line: 192 -- upvalues: u31 (val)
    return u31[p1]
end

function u30.IsEnabled(p1) -- Line: 196 -- upvalues: u31 (val)
    local v1 = u31[p1]
    local v2 = false
    if v1 ~= nil then
        v2 = v1.Enabled == true
    end
    return v2
end

function u30.GetEnabled() -- Line: 203 -- upvalues: u32 (val)
    return u32
end

function u30.GetItems(p1) -- Line: 207 -- upvalues: resolveItems (val)
    return resolveItems(p1)
end

function u30.GetItemsByRarity(p1, p2) -- Line: 211 -- upvalues: bucketByRarity (val), resolveItems (val)
    local v1 = bucketByRarity(p1)
    if p2 ~= nil and p2 ~= "All" then
        local v2 = v1[p2]
        if not v2 then
            v2 = table.freeze({})
        end
        return v2
    end
    return resolveItems(p1)
end

function u30.ChooseRarity(p1, p2) -- Line: 219 -- upvalues: u31 (val)
    local v1 = u31[p1]
    if v1 and v1.ProbabilityTable then
        local v2 = p2
        if not v2 then
            v2 = Random.new()
        end
        v2 = v2:NextInteger(1, 100)
        local v3 = 0
        for k, v in pairs(v1.ProbabilityTable) do
            v3 = v3 + v
            if v2 <= v3 then
                return k
            end
        end
        return nil
    end
    return nil
end

function u30.BuildPool(p1, p2, p3) -- Line: 239 -- upvalues: u31 (val), u30 (val), LevelInfo (val)
    local v1 = u31[p1]
    if not v1 then
        return {}
    end
    local v2 = u30.GetItemsByRarity(p1, p2)
    if v1.ExcludeOwned and p3 then
        local v3 = {}
        for i, v in ipairs(v2) do
            if not LevelInfo.OwnsWeapon(p3, v) then
                table.insert(v3, v)
            end
        end
        return v3
    end
    return table.clone(v2)
end

function u30.Roll(p1, p2, p3) -- Line: 261 -- upvalues: u30 (val)
    local v1 = p2
    if not v1 then
        v1 = Random.new()
    end
    local v2 = v1
    v1 = u30.ChooseRarity(p1, v2)
    if not v1 then
        return nil, nil
    end
    local v3 = u30.BuildPool(p1, v1, p3)
    if #v3 == 0 then
        return nil, v1
    end
    local v4 = #v3
    return v3[v2:NextInteger(1, v4)], v1
end

return u30