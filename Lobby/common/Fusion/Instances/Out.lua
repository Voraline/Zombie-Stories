local Parent = script.Parent.Parent
require(Parent.PubTypes)
local logError = require(Parent.Logging.logError)
local xtypeof = require(Parent.Utility.xtypeof)
return function(p1) -- Line: 13 -- upvalues: logError (val), xtypeof (val)
    return {
        type = "SpecialKey",
        kind = "Out",
        stage = "observer",
        apply = function(p1_2, p2, p3, p4) -- Line: 19 -- upvalues: p1 (val), logError (upval), xtypeof (upval)
            local success, result = pcall(p3.GetPropertyChangedSignal, p3, p1)
            if not success then
                logError("invalidOutProperty", nil, p3.ClassName, p1)
                return
            end
            if xtypeof(p2) == "State" and p2.kind == "Value" then
                local v1 = p3[p1]
                p2:set(v1)
                v1 = result:Connect(function() -- Line: 29 -- upvalues: p2 (val), p3 (val), p1 (upval)
                    local v1 = p2
                    local v2 = p3
                    local v3 = p1
                    local v4 = v2[v3]
                    v1:set(v4)
                end)
                table.insert(p4, v1)
                table.insert(p4, function() -- Line: 33 -- upvalues: p2 (val)
                    p2:set(nil)
                end)
                return
            end
            logError("invalidOutType")
        end,
    }
end