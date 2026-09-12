local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local parseError = require(Parent.Logging.parseError)
local v1 = {type = "Contextual"}
local u17 = table.freeze({__index = v1})
local u20 = table.freeze({__mode = "k"})

function v1.now(p1) -- Line: 48
    local v1 = coroutine.running()
    local v2 = p1._valuesNow[v1]
    if typeof(v2) ~= "table" then
        return p1._defaultValue
    end
    return v2.value
end

function v1.is(p1, p2) -- Line: 63 -- upvalues: parseError (val), External (val)
    return {
        during = function(p1_2, p2_2, ...) -- Line: 69 -- upvalues: p1 (val), p2 (val), parseError (upval), External (upval)
            local v1 = coroutine.running()
            local v2 = p1._valuesNow[v1]
            local v3 = p1
            local _valuesNow = v3._valuesNow
            _valuesNow[v1] = {value = p2}
            local success, result = xpcall(p2_2, parseError, ...)
            p1._valuesNow[v1] = v2
            if not success then
                External.logError("callbackError", result)
            end
            return result
        end,
    }
end

table.freeze(v1)
return function(p1) -- Line: 28 -- upvalues: u20 (val), u17 (val)
    local v1 = {}
    local v2 = u20
    v1._valuesNow = setmetatable({}, v2)
    v1._defaultValue = p1
    local v3 = u17
    return (setmetatable(v1, v3))
end