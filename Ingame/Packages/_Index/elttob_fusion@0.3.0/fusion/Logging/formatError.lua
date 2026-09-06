local Parent = script.Parent.Parent
require(Parent.Types)
local messages = require(Parent.Logging.messages)
return function(p1, p2, p3, ...) -- Line: 16 -- upvalues: messages (val)
    local trace, v1, v2
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
    local v3 = messages[p2]
    if v3 ~= nil then
        v1 = p2
    else
        v3 = messages.unknownMessage
    end
    v3 = v3:format(...)
    if v2 == nil then
        v3 = v3:gsub("ERROR_MESSAGE", p2)
    else
        v3 = v3:gsub("ERROR_MESSAGE", v2.message)
        if v2.context ~= nil then
            v3 = v3 .. (" (%*)"):format(v2.context)
        end
    end
    v3 = ("[Fusion] %* \nID: %*"):format(v3, v1)
    if p1 ~= nil and p1.policies.allowWebLinks then
        v3 = v3 .. ("\nLearn more: https://elttob.uk/Fusion/0.3/api-reference/general/errors/#%*"):format((v1:lower()))
    end
    if trace ~= nil then
        v3 = v3 .. (" \n---- Stack trace ----\n%*"):format(trace)
    end
    return v3:gsub("\n", "\n    ")
end