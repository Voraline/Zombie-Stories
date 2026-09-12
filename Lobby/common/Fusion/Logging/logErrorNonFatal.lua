local Parent = script.Parent.Parent
require(Parent.Types)
local messages = require(Parent.Logging.messages)
return function(p1, p2, ...) -- Line: 11 -- upvalues: messages (val)
    local u40, v1, v2
    if messages[p1] == nil then
        v1 = "unknownMessage"
        v2 = messages[v1]
    else
        v2 = messages[p1]
        v1 = p1
    end
    if p2 ~= nil then
        local message = p2.message
        v2 = v2:gsub("ERROR_MESSAGE", message)
        u40 = string.format("[Fusion] " .. v2 .. "\n(ID: " .. v1 .. ")\n---- Stack trace ----\n" .. p2.trace, ...)
    else
        u40 = string.format("[Fusion] " .. v2 .. "\n(ID: " .. v1 .. ")", ...)
    end
    task.spawn(function(...) -- Line: 29 -- upvalues: u40 (ref)
        error(u40:gsub("\n", "\n    "), 0)
    end, ...)
end