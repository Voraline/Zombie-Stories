local Parent_2 = script.Parent.Parent
local logError = require(Parent_2.Logging.logError)
return function(p1, p2) -- Line: 12 -- upvalues: logError (val)
    local v1 = getmetatable(p2)
    if v1 == nil then
        v1 = {}
        setmetatable(p2, v1)
    end

    function v1.__index(p1_2, p2) -- Line: 21 -- upvalues: logError (upval), p1 (val)
        local v1 = logError
        v1("strictReadError", nil, tostring(p2), p1)
    end

    return p2
end