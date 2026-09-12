local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("../../Theme")
return function(p1) -- Line: 28 -- upvalues: u11 (val)
    local scope = p1.scope
    return (scope:Computed(function(p1_2) -- Line: 31 -- upvalues: p1 (val), u11 (upval)
        if p1_2(p1.Quest.IsCompleted) then
            return u11.Menu.Positive
        end
        if p1_2(p1.Quest.IsBonus or false) then
            return u11.Menu.Accent
        end
        return u11.Menu.Border
    end)), (scope:Computed(function(p1_2) -- Line: 41 -- upvalues: p1 (val), u11 (upval)
        if p1_2(p1.Quest.IsCompleted) then
            return u11.Menu.Positive
        end
        return u11.Menu.Accent
    end)), (scope:Computed(function(p1_2) -- Line: 45 -- upvalues: p1 (val), u11 (upval)
        if p1_2(p1.Quest.IsCompleted) then
            return u11.Menu.Panel
        end
        return u11.Menu.PanelDeep
    end)), (scope:Computed(function(p1_2) -- Line: 49 -- upvalues: p1 (val), u11 (upval)
        if p1_2(p1.Quest.IsCompleted) then
            return u11.Menu.TextMuted
        end
        return u11.Menu.Text
    end))
end