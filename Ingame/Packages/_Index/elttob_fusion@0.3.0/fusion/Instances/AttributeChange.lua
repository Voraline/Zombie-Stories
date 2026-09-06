local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local u9 = {}
return function(p1) -- Line: 17 -- upvalues: u9 (val), External (val)
    local v1 = u9[p1]
    if v1 == nil then
        u9[p1] = {
            type = "SpecialKey",
            kind = "AttributeChange",
            stage = "observer",
            apply = function(a1, p2, p3, p4) -- Line: 26 -- upvalues: External (upval), p1 (val)
                if typeof(p3) ~= "function" then
                    External.logError("invalidAttributeChangeHandler", nil, p1)
                end
                local AttributeChangedSignal = p4:GetAttributeChangedSignal(p1)
                table.insert(p2, AttributeChangedSignal:Connect(function() -- Line: 37 -- upvalues: p3 (val), p4 (val), p1 (upval)
                    p3(p4:GetAttribute(p1))
                end))
            end,
        }
    end
    return v1
end