local ItemData = require(script.Parent.Parent:WaitForChild("ItemData"))
local u9 = {HATS_BIT = 1, FORCE_BIT = 2, EXPLICIT_BIT = 3}

local function readBit(p1, p2) -- Line: 9
    if type(p1) ~= "table" then
        return 0
    end
    local v1 = p1[p2]
    if v1 == nil then
        v1 = p1[tostring(p2)]
    end
    if v1 == 1 then
        return 1
    end
    return 0
end

function u9.Resolve(p1, p2, p3) -- Line: 22 -- upvalues: u9 (val), ItemData (val)
    local v1, v2, v3, v4, v5
    local EXPLICIT_BIT = u9.EXPLICIT_BIT
    if type(p1) == "table" then
        v3 = p1[EXPLICIT_BIT]
        if v3 == nil then
            v3 = p1[tostring(EXPLICIT_BIT)]
        end
        if v3 ~= 1 then
            v1 = 0
        else
            v1 = 1
        end
    else
        v1 = 0
    end
    local v6 = v1 == 1
    if not v6 then
        v1 = true
    else
        local FORCE_BIT = u9.FORCE_BIT
        if type(p1) == "table" then
            v4 = p1[FORCE_BIT]
            if v4 == nil then
                v4 = p1[tostring(FORCE_BIT)]
            end
            if v4 ~= 1 then
                v2 = 0
            else
                v2 = 1
            end
        else
            v2 = 0
        end
        v1 = v2 == 1
    end
    if p3 and p3.ForceOutfit ~= nil then
        v1 = p3.ForceOutfit == true
    end
    local HATS_BIT = u9.HATS_BIT
    if type(p1) == "table" then
        v5 = p1[HATS_BIT]
        if v5 == nil then
            v5 = p1[tostring(HATS_BIT)]
        end
        if v5 ~= 1 then
            v3 = 0
        else
            v3 = 1
        end
    else
        v3 = 0
    end
    v2 = v3 ~= 1
    if p2 == nil then
        v3 = nil
    else
        v3 = ItemData.List[tostring(p2)]
        if not v3 then
            v3 = nil
        end
    end
    if v3 and v3.HasHats == false then
        v2 = false
    end
    v2 = v1 and v2
    v4 = {ForceOutfit = v1, UseOutfitHats = v2, HatsToggleOn = v2}
    v5 = v1
    if v5 then
        v5 = true
        if v3 ~= nil then
            v5 = v3.HasHats ~= false
        end
    end
    v4.HatsToggleVisible = v5
    return v4
end

function u9.ResolveForClass(p1, p2, p3) -- Line: 46 -- upvalues: u9 (val)
    local v1, v2, v3
    local Loadout = p1
    if Loadout then
        Loadout = p1.Loadout
    end
    local Classes = Loadout
    if Classes then
        Classes = Loadout.Classes
    end
    local v4 = Classes
    if v4 then
        v4 = Classes[p2]
    end
    local v5 = v4
    if v5 then
        v5 = v4[4]
    end
    local Inventory = v5
    if Inventory then
        Inventory = p1.Inventory
        if Inventory then
            Inventory = p1.Inventory[v5]
        end
    end
    if not Inventory then
        v2 = nil
    else
        v2 = Inventory[1]
        if not v2 then
            v2 = nil
        end
    end
    if v2 == nil then
        v3 = nil
    else
        v3 = tostring(v2)
        if not v3 then
            v3 = nil
        end
    end
    if not v3 or not Loadout.OutfitMods then
        v1 = nil
    else
        v1 = Loadout.OutfitMods[v3]
        if not v1 then
            v1 = nil
        end
    end
    return (u9.Resolve(v1, v3, p3)), v3
end

function u9.NextValue(p1, p2) -- Line: 59 -- upvalues: u9 (val)
    local v1
    if p2 == u9.FORCE_BIT then
        if u9.Resolve(p1, nil).ForceOutfit then
            return 0
        end
        return 1
    end
    if p2 ~= u9.HATS_BIT then
        error("Invalid outfit mod type", 2)
        return
    end
    local HATS_BIT = u9.HATS_BIT
    if type(p1) == "table" then
        local v2 = p1[HATS_BIT]
        if v2 == nil then
            v2 = p1[tostring(HATS_BIT)]
        end
        if v2 ~= 1 then
            v1 = 0
        else
            v1 = 1
        end
    else
        v1 = 0
    end
    if v1 == 1 then
        return 0
    end
    return 1
end

function u9.WriteBit(p1, p2, p3) -- Line: 69 -- upvalues: u9 (val)
    local v1, v2, v3
    if p2 ~= u9.HATS_BIT and p2 ~= u9.FORCE_BIT then
        error("Invalid outfit mod type", 2)
    end
    local v4 = {}
    local HATS_BIT = u9.HATS_BIT
    if type(p1) == "table" then
        v3 = p1[HATS_BIT]
        if v3 == nil then
            v3 = p1[tostring(HATS_BIT)]
        end
        if v3 ~= 1 then
            v1 = 0
        else
            v1 = 1
        end
    else
        v1 = 0
    end
    local FORCE_BIT = u9.FORCE_BIT
    if type(p1) == "table" then
        local v5 = p1[FORCE_BIT]
        if v5 == nil then
            v5 = p1[tostring(FORCE_BIT)]
        end
        if v5 ~= 1 then
            v2 = 0
        else
            v2 = 1
        end
    else
        v2 = 0
    end
    local EXPLICIT_BIT = u9.EXPLICIT_BIT
    if type(p1) == "table" then
        local v6 = p1[EXPLICIT_BIT]
        if v6 == nil then
            v6 = p1[tostring(EXPLICIT_BIT)]
        end
        if v6 ~= 1 then
            v3 = 0
        else
            v3 = 1
        end
    else
        v3 = 0
    end
    v4[1] = v1
    v4[2] = v2
    v4[3] = v3
    if p3 ~= 1 then
        v1 = 0
    else
        v1 = 1
    end
    v4[p2] = v1
    if p2 == u9.FORCE_BIT then
        v4[u9.EXPLICIT_BIT] = 1
    end
    return v4
end

function u9.IsValidWrite(p1, p2) -- Line: 87 -- upvalues: u9 (val)
    local v1
    if p1 == u9.HATS_BIT then
        v1 = false
        if type(p2) == "number" then
            v1 = true
            if p2 ~= 0 then
                v1 = p2 == 1
            end
        end
    else
        v1 = false
        if p1 == u9.FORCE_BIT then
            v1 = false
            if type(p2) == "number" then
                v1 = true
                if p2 ~= 0 then
                    v1 = p2 == 1
                end
            end
        end
    end
    return v1
end

return table.freeze(u9)