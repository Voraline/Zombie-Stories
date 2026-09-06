local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local parseError = require(Parent.Logging.parseError)
local v1 = {type = "Contextual"}
local u17 = table.freeze({__index = v1})
local u20 = table.freeze({__mode = "k"})
function v1.now(p1) -- Line: 48
    local v1 = p1._valuesNow[coroutine.running()]
    if typeof(v1) ~= "table" then
        return p1._defaultValue
    end
    return v1.value
end
function v1.is(p1, p2) -- Line: 63 -- upvalues: parseError (val), External (val)
    local v1 = {}
    function v1.during(a1, a2, ...) -- Line: 69 -- upvalues: p1 (val), p2 (val), parseError (upval), External (upval)
        local v1, v2
        local v3 = coroutine.running()
        local v4 = p1._valuesNow[v3]
        p1._valuesNow[v3] = {value = p2}
        v1, v2 = xpcall(a2, parseError, ...)
        p1._valuesNow[v3] = v4
        if not v1 then
            External.logError("callbackError", v2)
        end
        return v2
    end
    return v1
end
table.freeze(v1)
return function(p1) -- Line: 28 -- upvalues: u20 (val), u17 (val)
    local v1 = {_valuesNow = setmetatable({}, u20), _defaultValue = p1}
    return (setmetatable(v1, u17))
end