local Parent_2 = script.Parent.Parent
local messages = require(Parent_2.Logging.messages)
return function(p1, ...) -- Line: 10 -- upvalues: messages (val)
    local v1, v2
    if messages[p1] == nil then
        v1 = "unknownMessage"
        v2 = messages[v1]
    else
        v2 = messages[p1]
        v1 = p1
    end
    warn(string.format("[Fusion] " .. v2 .. "\n(ID: " .. v1 .. ")", ...))
end