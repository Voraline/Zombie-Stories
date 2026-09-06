local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModifierData = require(ReplicatedStorage.common.ZS_Shared.Data.ModifierData)
local ModifierGroupData = require(ReplicatedStorage.common.ZS_Shared.Data.ModifierGroupData)
local u17 = {
    GetGroupingIcon = function(p1) -- Line: 8 -- upvalues: ModifierGroupData (val)
        if not p1 then
            return nil
        end
        return ModifierGroupData[p1]
    end,
}
function u17.GetModifierIcon(p1) -- Line: 14 -- upvalues: ModifierData (val), u17 (val)
    local v1 = ModifierData[p1]
    if not v1 then
        return nil
    end
    local Icon = v1.Icon
    if not Icon then
        local Grouping = v1.Grouping
        if not Grouping then
            Grouping = v1.Group
        end
        Icon = u17.GetGroupingIcon(Grouping)
    end
    return Icon
end
function u17.GetModifierStatText(p1) -- Line: 21 -- upvalues: ModifierData (val)
    local v1, v2
    local v3 = ModifierData[p1]
    if not v3 then
        return ""
    end
    if v3.StatText then
        return v3.StatText
    end
    if not v3.VariableAdditions then
        if v3.VariableSets then
            if v3.VariableSets.HeadshotOnly then
                return "HEAD"
            end
            return ""
        end
        return ""
    end
    for k, v in pairs(v3.VariableAdditions) do
        if not (k:find("Rate")) and not (k:find("Speed")) and not (k:find("Health")) then
            continue
        end
        if 0 < v then
            v2 = math.floor(v * 100)
            return "+" .. v2 .. "%"
        end
        v1 = math.floor(v * 100)
        return v1 .. "%"
    end
    if not v3.VariableSets then
        return ""
    end
    if v3.VariableSets.HeadshotOnly then
        return "HEAD"
    end
    return ""
end
return u17