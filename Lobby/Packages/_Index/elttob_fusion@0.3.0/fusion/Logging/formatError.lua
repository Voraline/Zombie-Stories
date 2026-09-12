local Parent = script.Parent.Parent
require(Parent.Types)
local messages = require(Parent.Logging.messages)
return function(p1, p2, p3, ...) -- Line: 16 -- upvalues: messages (val)
    local trace, v1, v2
    local v3 = p2
    if typeof(p3) ~= "table" then
        v2 = nil
    else
        v2 = p3
    end
    if typeof(p3) ~= "table" then
        trace = p3
    else
        trace = p3.trace
    end
    local v4 = messages[p2]
    if v4 ~= nil then
        v1 = p2
    else
        v1 = "unknownMessage"
        v4 = messages[v1]
    end
    v4 = v4:format(...)
    if v2 == nil then
        v4 = v4:gsub("ERROR_MESSAGE", v3)
    else
        local message = v2.message
        v4 = v4:gsub("ERROR_MESSAGE", message)
        if v2.context ~= nil then
            local context = v2.context
            v4 = v4 .. (" (%*)"):format(context)
        end
    end
    v4 = ("[Fusion] %* \nID: %*"):format(v4, v1)
    if p1 ~= nil and p1.policies.allowWebLinks then
        local v5 = v1:lower()
        v4 = v4 .. ("\nLearn more: https://elttob.uk/Fusion/0.3/api-reference/general/errors/#%*"):format(v5)
    end
    if trace ~= nil then
        v4 = v4 .. (" \n---- Stack trace ----\n%*"):format(trace)
    end
    return v4:gsub("\n", "\n    ")
end