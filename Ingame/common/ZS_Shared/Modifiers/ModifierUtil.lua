local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModifierData = require(ReplicatedStorage.common.ZS_Shared.Data.ModifierData)
local ModifierGroupData = require(ReplicatedStorage.common.ZS_Shared.Data.ModifierGroupData)
local u17 = {}

function u17.GetGroupingIcon(p1) -- Line: 8 -- upvalues: ModifierGroupData (val)
    if not p1 then
        return nil
    end
    return ModifierGroupData[p1]
end

function u17.GetModifierIcon(p1) -- Line: 14 -- upvalues: ModifierData (val), u17 (val)
    local v1 = ModifierData[p1]
    if not v1 then
        return nil
    end
    local Icon = v1.Icon
    if not Icon then
        local GetGroupingIcon = u17.GetGroupingIcon
        local Grouping = v1.Grouping
        if not Grouping then
            Grouping = v1.Group
        end
        Icon = GetGroupingIcon(Grouping)
    end
    return Icon
end

function u17.GetModifierStatText(p1) -- Line: 21 -- upvalues: ModifierData (val)
    local v1 = ModifierData[p1]
    if not v1 then
        return ""
    end
    if v1.StatText then
        return v1.StatText
    end
    if v1.VariableAdditions then
        local v2, v3
        for k, v in pairs(v1.VariableAdditions) do
            if not k:find("Rate") and not k:find("Speed") and not k:find("Health") then
                continue
            end
            if 0 < v then
                v2 = v * 100
                return "+" .. (math.floor(v2)) .. "%"
            end
            v3 = v * 100
            return (math.floor(v3)) .. "%"
        end
    end
    if v1.VariableSets and v1.VariableSets.HeadshotOnly then
        return "HEAD"
    end
    return ""
end

return u17