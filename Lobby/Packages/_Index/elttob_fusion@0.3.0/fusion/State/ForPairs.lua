local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local For = require(Parent.State.For)
local Value = require(Parent.State.Value)
local Computed = require(Parent.State.Computed)
require(Parent.State.For.ForTypes)
local parseError = require(Parent.Logging.parseError)
local doCleanup = require(Parent.Memory.doCleanup)
local u34 = {}
local v1 = {
    roamKeys = false,
    roamValues = false,
    invalidateInputKey = function(p1) -- Line: 33
        local _inputKeyState = p1._inputKeyState
        local inputKey = p1.inputKey
        _inputKeyState:set(inputKey)
    end,
    invalidateInputValue = function(p1) -- Line: 36
        local _inputValueState = p1._inputValueState
        local inputValue = p1.inputValue
        _inputValueState:set(inputValue)
    end,
    useOutputPair = function(p1, p2) -- Line: 39
        local v1 = p2(p1._outputPairState)
        return v1.key, v1.value
    end,
}
u34.__index = v1

local function SubObject(p1, p2, p3, p4) -- Line: 46
    -- upvalues: Value (val), Computed (val), parseError (val), External (val), doCleanup (val), u34 (val)
    local u4 = {}
    u4.maybeScope = p1
    u4.inputKey = p2
    u4.inputValue = p3
    u4._inputKeyState = Value(p1, p2)
    u4._inputValueState = Value(p1, p3)
    u4._processor = p4
    local v1 = Computed
    u4._outputPairState = v1(p1, function(p1, p2) -- Line: 59 -- upvalues: u4 (val), parseError (upval), External (upval), doCleanup (upval)
        local v1 = p1(u4._inputKeyState)
        local v2 = p1(u4._inputValueState)
        local success, result, v3 = xpcall(u4._processor, parseError, p1, p2, v1, v2)
        if success then
            return {key = result, value = v3}
        end
        local v4 = tostring(v2)
        local v5 = tostring(v2)
        result.context = ("while processing key %* and value %*"):format(v4, v5)
        External.logErrorNonFatal("callbackError", result)
        doCleanup(p2)
        table.clear(p2)
        return {}
    end)
    local v2 = u34
    return (setmetatable(u4, v2))
end

return function(p1, p2, p3, p4) -- Line: 77 -- upvalues: External (val), For (val), SubObject (val)
    if typeof(p2) == "function" then
        External.logError(
            "scopeMissing",
            nil,
            "ForPairs",
            "myScope:ForPairs(inputTable, function(scope, use, key, value) ... end)"
        )
    elseif p4 ~= nil then
        External.logWarn("destructorRedundant", "ForPairs")
    end
    local v1 = For
    return v1(p1, p2, function(p1, p2, p3_2) -- Line: 91 -- upvalues: SubObject (upval), p3 (val)
        return (SubObject(p1, p2, p3_2, p3))
    end)
end