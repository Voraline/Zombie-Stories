local Parent = script.Parent.Parent
require(Parent.PubTypes)
local logError = require(Parent.Logging.logError)
return function(p1) -- Line: 12 -- upvalues: logError (val)
    return {
        type = "SpecialKey",
        kind = "OnChange",
        stage = "observer",
        apply = function(a1, p2, p3, p4) -- Line: 18 -- upvalues: p1 (val), logError (upval)
            local v1, v2
            v1, v2 = pcall(p3.GetPropertyChangedSignal, p3, p1)
            if not v1 then
                logError("cannotConnectChange", nil, p3.ClassName, p1)
                return
            end
            if typeof(p2) ~= "function" then
                logError("invalidChangeHandler", nil, p1)
                return
            end
            table.insert(p4, v2:Connect(function() -- Line: 25 -- upvalues: p2 (val), p3 (val), p1 (upval)
                p2(p3[p1])
            end))
        end,
    }
end