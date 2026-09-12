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
        apply = function(p1_2, p2, p3, p4) -- Line: 22 -- upvalues: getProperty_unsafe (upval), p1 (val), logError (upval)
            local success, result = pcall(getProperty_unsafe, p3, p1)
            if success and typeof(result) == "RBXScriptSignal" then
                if typeof(p2) ~= "function" then
                    logError("invalidEventHandler", nil, p1)
                    return
                end
                local v1 = result:Connect(p2)
                table.insert(p4, v1)
                return
            end
            logError("cannotConnectEvent", nil, p3.ClassName, p1)
        end,
    }
end