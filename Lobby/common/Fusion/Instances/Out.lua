local Parent = script.Parent.Parent
require(Parent.PubTypes)
local logError = require(Parent.Logging.logError)
local xtypeof = require(Parent.Utility.xtypeof)
return function(p1) -- Line: 13 -- upvalues: logError (val), xtypeof (val)
    return {
        type = "SpecialKey",
        kind = "Out",
        stage = "observer",
        apply = function(a1, p2, p3, p4) -- Line: 19 -- upvalues: p1 (val), logError (upval), xtypeof (upval)
            local v1, v2
            v1, v2 = pcall(p3.GetPropertyChangedSignal, p3, p1)
            if not v1 then
                logError("invalidOutProperty", nil, p3.ClassName, p1)
                return
            end
            if xtypeof(p2) ~= "State" or p2.kind ~= "Value" then
                logError("invalidOutType")
                return
            end
            p2:set(p3[p1])
            table.insert(p4, v2:Connect(function() -- Line: 29 -- upvalues: p2 (val), p3 (val), p1 (upval)
                p2:set(p3[p1])
            end))
            table.insert(p4, function() -- Line: 33 -- upvalues: p2 (val)
                p2:set(nil)
            end)
        end,
    }
end