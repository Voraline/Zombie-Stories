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
        u9[p1] = {
            type = "SpecialKey",
            kind = "OnEvent",
            stage = "observer",
            apply = function(a1, p2, p3, p4) -- Line: 33 -- upvalues: getProperty_unsafe (upval), p1 (val), External (upval)
                local v1, v2
                v1, v2 = pcall(getProperty_unsafe, p4, p1)
                if not v1 or typeof(v2) ~= "RBXScriptSignal" then
                    External.logError("cannotConnectEvent", nil, p4.ClassName, p1)
                    return
                end
                if typeof(p3) ~= "function" then
                    External.logError("invalidEventHandler", nil, p1)
                    return
                end
                table.insert(p2, v2:Connect(p3))
            end,
        }
    end
    return v1
end