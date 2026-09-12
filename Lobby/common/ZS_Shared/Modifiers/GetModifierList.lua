local ReplicatedStorage = game:GetService("ReplicatedStorage")
local peek = (require(ReplicatedStorage.Packages.Fusion)).peek
local ModifierData = require(ReplicatedStorage.common.ZS_Shared.Data.ModifierData)
return function(p1) -- Line: 7 -- upvalues: ModifierData (val), peek (val)
    local v1
    local u1 = {}

    local function turnOnModifier(p1) -- Line: 23 -- upvalues: ModifierData (upval), u1 (val)
        local v1 = ModifierData[p1]
        if v1 and u1[p1] then
            local v2 = u1
            local v3 = nil
            local v4 = nil
            for i, j in v2, v3, v4 do
                if ModifierData[i].Grouping == v1.Grouping then
                    j.IsActive:set(false)
                end
            end
            u1[p1].IsActive:set(true)
            return true
        end
        return false
    end

    local v2 = ModifierData
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        v1 = {IsLocked = p1:Value(false), IsActive = p1:Value(false)}
        u1[i] = v1
    end
    return {
        ModifierList = u1,
        ActivateModifier = function(p1) -- Line: 47 -- upvalues: turnOnModifier (val)
            return (turnOnModifier(p1))
        end,
        DeactivateModifier = function(p1) -- Line: 51 -- upvalues: u1 (val)
            local v1 = u1[p1]
            if not v1 then
                return false
            end
            v1.IsActive:set(false)
            return true
        end,
        ToggleModifier = function(p1) -- Line: 60 -- upvalues: u1 (val), peek (upval), turnOnModifier (val)
            local v1 = u1[p1]
            if not v1 then
                return false
            end
            if not peek(v1.IsActive) then
                return (turnOnModifier(p1))
            end
            v1.IsActive:set(false)
            return true
        end,
        GetSelected = function() -- Line: 72 -- upvalues: u1 (val), peek (upval)
            local v1 = {}
            local v2 = u1
            local v3 = nil
            local v4 = nil
            for i, j in v2, v3, v4 do
                if peek(j.IsActive) then
                    v1[i] = true
                end
            end
            return v1
        end,
        Clear = function() -- Line: 82 -- upvalues: u1 (val)
            local v1 = u1
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                j.IsActive:set(false)
            end
        end,
        IsGroupActive = function(p1, p2) -- Line: 88 -- upvalues: u1 (val), ModifierData (upval)
            local v1
            local v2 = u1
            local v3 = nil
            local v4 = nil
            for i, j in v2, v3, v4 do
                v1 = ModifierData[i]
                if v1 and v1.Grouping == p1 and p2(j.IsActive) then
                    return true
                end
            end
            return false
        end,
    }
end