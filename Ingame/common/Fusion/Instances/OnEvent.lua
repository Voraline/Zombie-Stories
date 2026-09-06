local Parent = script.Parent.Parent
require(Parent.PubTypes)
local logError = require(Parent.Logging.logError)
local function getProperty_unsafe(p1, p2) -- Line: 12
    return p1[p2]
end
return function(p1) -- Line: 16 -- upvalues: getProperty_unsafe (val), logError (val)
    return {
        type = "SpecialKey",
        kind = "OnEvent",
        stage = "observer",
        apply = function(a1, p2, p3, p4) -- Line: 22 -- upvalues: getProperty_unsafe (upval), p1 (val), logError (upval)
            local v1, v2
            v1, v2 = pcall(getProperty_unsafe, p3, p1)
            if not v1 or typeof(v2) ~= "RBXScriptSignal" then
                logError("cannotConnectEvent", nil, p3.ClassName, p1)
                return
            end
            if typeof(p2) ~= "function" then
                logError("invalidEventHandler", nil, p1)
                return
            end
            table.insert(p4, v2:Connect(p2))
        end,
    }
end