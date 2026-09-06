local logError = require(script.Parent.Parent.Logging.logError)
return function(p1, p2) -- Line: 12 -- upvalues: logError (val)
    local v1 = getmetatable(p2)
    if v1 == nil then
        setmetatable(p2, {})
    end
    function v1.__index(a1, p2) -- Line: 21 -- upvalues: logError (upval), p1 (val)
        local v1 = tostring(p2)
        logError("strictReadError", nil, v1, p1)
    end
    return p2
end