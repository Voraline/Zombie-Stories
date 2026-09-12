local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local u9 = {}
return function(p1) -- Line: 17 -- upvalues: u9 (val), External (val)
    local v1 = u9[p1]
    if v1 == nil then
        v1 = {
            type = "SpecialKey",
            kind = "OnChange",
            stage = "observer",
            apply = function(p1_2, p2, p3, p4) -- Line: 26 -- upvalues: p1 (val), External (upval)
                local success, result = pcall(p4.GetPropertyChangedSignal, p4, p1)
                if not success then
                    External.logError("cannotConnectChange", nil, p4.ClassName, p1)
                    return
                end
                if typeof(p3) ~= "function" then
                    External.logError("invalidChangeHandler", nil, p1)
                    return
                end
                local v1 = result:Connect(function() -- Line: 39 -- upvalues: p3 (val), p4 (val), p1 (upval)
                    p3(p4[p1])
                end)
                table.insert(p2, v1)
            end,
        }
        u9[p1] = v1
    end
    return v1
end