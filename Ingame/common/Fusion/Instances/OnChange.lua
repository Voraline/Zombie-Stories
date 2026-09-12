local Parent = script.Parent.Parent
require(Parent.PubTypes)
local logError = require(Parent.Logging.logError)
return function(p1) -- Line: 12 -- upvalues: logError (val)
    return {
        type = "SpecialKey",
        kind = "OnChange",
        stage = "observer",
        apply = function(p1_2, p2, p3, p4) -- Line: 18 -- upvalues: p1 (val), logError (upval)
            local success, result = pcall(p3.GetPropertyChangedSignal, p3, p1)
            if not success then
                logError("cannotConnectChange", nil, p3.ClassName, p1)
                return
            end
            if typeof(p2) ~= "function" then
                logError("invalidChangeHandler", nil, p1)
                return
            end
            local v1 = result:Connect(function() -- Line: 25 -- upvalues: p2 (val), p3 (val), p1 (upval)
                p2(p3[p1])
            end)
            table.insert(p4, v1)
        end,
    }
end