local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local u9 = {}

local function getProperty_unsafe(p1, p2) -- Line: 17
    return p1[p2]
end

return function(p1) -- Line: 24 -- upvalues: u9 (val), getProperty_unsafe (val), External (val)
    local v1 = u9[p1]
    if v1 == nil then
        v1 = {
            type = "SpecialKey",
            kind = "OnEvent",
            stage = "observer",
            apply = function(p1_2, p2, p3, p4) -- Line: 33 -- upvalues: getProperty_unsafe (upval), p1 (val), External (upval)
                local success, result = pcall(getProperty_unsafe, p4, p1)
                if success and typeof(result) == "RBXScriptSignal" then
                    if typeof(p3) ~= "function" then
                        External.logError("invalidEventHandler", nil, p1)
                        return
                    end
                    local v1 = result:Connect(p3)
                    table.insert(p2, v1)
                    return
                end
                External.logError("cannotConnectEvent", nil, p4.ClassName, p1)
            end,
        }
        u9[p1] = v1
    end
    return v1
end