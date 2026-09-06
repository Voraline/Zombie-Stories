local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local u9 = {}
return function(p1) -- Line: 17 -- upvalues: u9 (val), External (val)
    local v1 = u9[p1]
    if v1 == nil then
        u9[p1] = {
            type = "SpecialKey",
            kind = "OnChange",
            stage = "observer",
            apply = function(a1, p2, p3, p4) -- Line: 26 -- upvalues: p1 (val), External (upval)
                local v1, v2
                v1, v2 = pcall(p4.GetPropertyChangedSignal, p4, p1)
                if not v1 then
                    External.logError("cannotConnectChange", nil, p4.ClassName, p1)
                    return
                end
                if typeof(p3) ~= "function" then
                    External.logError("invalidChangeHandler", nil, p1)
                    return
                end
                table.insert(p2, v2:Connect(function() -- Line: 39 -- upvalues: p3 (val), p4 (val), p1 (upval)
                    p3(p4[p1])
                end))
            end,
        }
    end
    return v1
end