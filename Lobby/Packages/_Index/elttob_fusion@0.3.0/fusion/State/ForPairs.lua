local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local For = require(Parent.State.For)
local Value = require(Parent.State.Value)
local Computed = require(Parent.State.Computed)
require(Parent.State.For.ForTypes)
local parseError = require(Parent.Logging.parseError)
local doCleanup = require(Parent.Memory.doCleanup)
local u34 = {
    __index = {
        roamKeys = false,
        roamValues = false,
        invalidateInputKey = function(p1) -- Line: 33
            p1._inputKeyState:set(p1.inputKey)
        end,
        invalidateInputValue = function(p1) -- Line: 36
            p1._inputValueState:set(p1.inputValue)
        end,
        useOutputPair = function(p1, p2) -- Line: 39
            local v1 = p2(p1._outputPairState)
            return v1.key, v1.value
        end,
    },
}
local function SubObject(p1, p2, p3, p4) -- Line: 46 -- upvalues: Value (val), Computed (val), parseError (val), External (val), doCleanup (val), u34 (val)
    local u4 = {
        maybeScope = p1,
        inputKey = p2,
        inputValue = p3,
        _inputKeyState = Value(p1, p2),
        _inputValueState = Value(p1, p3),
        _processor = p4,
    }
    u4._outputPairState = Computed(p1, function(p1, p2) -- Line: 59 -- upvalues: u4 (val), parseError (upval), External (upval), doCleanup (upval)
        local v1, v2, v3
        local v4 = p1(u4._inputKeyState)
        local v5 = p1(u4._inputValueState)
        v1, v2, v3 = xpcall(u4._processor, parseError, p1, p2, v4, v5)
        if v1 then
            return {key = v2, value = v3}
        end
        local v6 = tostring(v5)
        v2.context = ("while processing key %* and value %*"):format(v6, (tostring(v5)))
        External.logErrorNonFatal("callbackError", v2)
        doCleanup(p2)
        table.clear(p2)
        return {}
    end)
    return (setmetatable(u4, u34))
end
return function(p1, p2, p3, p4) -- Line: 77 -- upvalues: External (val), For (val), SubObject (val)
    if typeof(p2) == "function" then
        External.logError("scopeMissing", nil, "ForPairs", "myScope:ForPairs(inputTable, function(scope, use, key, value) ... end)")
    elseif p4 ~= nil then
        External.logWarn("destructorRedundant", "ForPairs")
    end
    return For(p1, p2, function(p1, p2, a3) -- Line: 91 -- upvalues: SubObject (upval), p3 (val)
        return (SubObject(p1, p2, a3, p3))
    end)
end