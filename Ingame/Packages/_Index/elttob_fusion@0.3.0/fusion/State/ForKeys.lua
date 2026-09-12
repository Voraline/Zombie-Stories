local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local doCleanup = require(Parent.Memory.doCleanup)
local For = require(Parent.State.For)
local Value = require(Parent.State.Value)
local Computed = require(Parent.State.Computed)
require(Parent.State.For.ForTypes)
local parseError = require(Parent.Logging.parseError)
local u34 = {}
local v1 = {
    roamKeys = false,
    roamValues = true,
    invalidateInputKey = function(p1) -- Line: 33
        local _inputKeyState = p1._inputKeyState
        local inputKey = p1.inputKey
        _inputKeyState:set(inputKey)
    end,
    invalidateInputValue = function(p1) end,
    useOutputPair = function(p1, p2) -- Line: 39
        return (p2(p1._outputKeyState)), p1.inputValue
    end,
}
u34.__index = v1

local function SubObject(p1, p2, p3, p4) -- Line: 45
    -- upvalues: Value (val), Computed (val), parseError (val), External (val), doCleanup (val), u34 (val)
    local u4 = {}
    u4.maybeScope = p1
    u4.inputKey = p2
    u4.inputValue = p3
    u4._inputKeyState = Value(p1, p2)
    u4._processor = p4
    local v1 = Computed
    u4._outputKeyState = v1(p1, function(p1, p2) -- Line: 57 -- upvalues: u4 (val), parseError (upval), External (upval), doCleanup (upval)
        local v1 = p1(u4._inputKeyState)
        local success, result = xpcall(u4._processor, parseError, p1, p2, v1)
        if success then
            return result
        end
        local v2 = tostring(v1)
        result.context = ("while processing key %*"):format(v2)
        External.logErrorNonFatal("callbackError", result)
        doCleanup(p2)
        table.clear(p2)
        return nil
    end)
    local v2 = u34
    return (setmetatable(u4, v2))
end

return function(p1, p2, p3, p4) -- Line: 74 -- upvalues: External (val), For (val), SubObject (val)
    if typeof(p2) == "function" then
        External.logError(
            "scopeMissing",
            nil,
            "ForKeys",
            "myScope:ForKeys(inputTable, function(scope, use, key) ... end)"
        )
    elseif p4 ~= nil then
        External.logWarn("destructorRedundant", "ForKeys")
    end
    local v1 = For
    return v1(p1, p2, function(p1, p2, p3_2) -- Line: 88 -- upvalues: SubObject (upval), p3 (val)
        return (SubObject(p1, p2, p3_2, p3))
    end)
end