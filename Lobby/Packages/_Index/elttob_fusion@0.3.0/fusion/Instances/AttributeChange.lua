local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local u9 = {}
return function(p1) -- Line: 17 -- upvalues: u9 (val), External (val)
    local v1 = u9[p1]
    if v1 == nil then
        v1 = {
            type = "SpecialKey",
            kind = "AttributeChange",
            stage = "observer",
            apply = function(p1_2, p2, p3, p4) -- Line: 26 -- upvalues: External (upval), p1 (val)
                if typeof(p3) ~= "function" then
                    External.logError("invalidAttributeChangeHandler", nil, p1)
                end
                local v1 = p1
                local v2 = (p4:GetAttributeChangedSignal(v1)):Connect(function() -- Line: 37 -- upvalues: p3 (val), p4 (val), p1 (upval)
                    local v1 = p3
                    local v2 = p4
                    local v3 = p1
                    v1(v2:GetAttribute(v3))
                end)
                table.insert(p2, v2)
            end,
        }
        u9[p1] = v1
    end
    return v1
end