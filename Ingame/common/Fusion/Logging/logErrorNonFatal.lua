local Parent = script.Parent.Parent
require(Parent.Types)
local messages = require(Parent.Logging.messages)
return function(p1, p2, ...) -- Line: 11 -- upvalues: messages (val)
    local u40, v1, v2
    if messages[p1] == nil then
        v2 = messages.unknownMessage
    else
        v2 = messages[p1]
        v1 = p1
    end
    if p2 ~= nil then
        v2 = v2:gsub("ERROR_MESSAGE", p2.message)
        u40 = string.format("[Fusion] " .. v2 .. "\n(ID: " .. v1 .. ")\n---- Stack trace ----\n" .. p2.trace, ...)
    else
        u40 = string.format("[Fusion] " .. v2 .. "\n(ID: " .. v1 .. ")", ...)
    end
    task.spawn(function(...) -- Line: 29 -- upvalues: u40 (ref)
        local v1 = u40:gsub("\n", "\n    ")
        error(v1, 0)
    end, ...)
end