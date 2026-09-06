local Parent = script.Parent.Parent
require(Parent.Types)
local messages = require(Parent.Logging.messages)
return function(p1, p2, ...) -- Line: 11 -- upvalues: messages (val)
    local v1, v2, v3
    if messages[p1] == nil then
        v2 = messages.unknownMessage
    else
        v2 = messages[p1]
        v1 = p1
    end
    if p2 ~= nil then
        v2 = v2:gsub("ERROR_MESSAGE", p2.message)
        v3 = string.format("[Fusion] " .. v2 .. "\n(ID: " .. v1 .. ")\n---- Stack trace ----\n" .. p2.trace, ...)
    else
        v3 = string.format("[Fusion] " .. v2 .. "\n(ID: " .. v1 .. ")", ...)
    end
    local v4 = v3:gsub("\n", "\n    ")
    error(v4, 0)
end