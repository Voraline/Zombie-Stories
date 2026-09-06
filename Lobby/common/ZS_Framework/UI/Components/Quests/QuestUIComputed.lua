local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("../../Theme")
return function(p1) -- Line: 28 -- upvalues: u11 (val)
    local scope = p1.scope
    local v1 = scope:Computed(function(a1) -- Line: 31 -- upvalues: p1 (val), u11 (upval)
        if a1(p1.Quest.IsCompleted) then
            return u11.Menu.Positive
        end
        if a1(p1.Quest.IsBonus or false) then
            return u11.Menu.Accent
        end
        return u11.Menu.Border
    end)
    local v2 = scope:Computed(function(a1) -- Line: 41 -- upvalues: p1 (val), u11 (upval)
        if a1(p1.Quest.IsCompleted) then
            return u11.Menu.Positive
        end
        return u11.Menu.Accent
    end)
    local v3 = scope:Computed(function(a1) -- Line: 45 -- upvalues: p1 (val), u11 (upval)
        if a1(p1.Quest.IsCompleted) then
            return u11.Menu.Panel
        end
        return u11.Menu.PanelDeep
    end)
    return v1, v2, v3, (scope:Computed(function(a1) -- Line: 49 -- upvalues: p1 (val), u11 (upval)
    if not (a1(p1.Quest.IsCompleted)) then
        return u11.Menu.Text
    else
        return u11.Menu.TextMuted
    end
end))
end