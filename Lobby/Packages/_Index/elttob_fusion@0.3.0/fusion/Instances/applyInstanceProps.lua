local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local parseError = require(Parent.Logging.parseError)
local checkLifetime = require(Parent.Memory.checkLifetime)
local Observer = require(Parent.Graph.Observer)
local castToState = require(Parent.State.castToState)
local peek = require(Parent.State.peek)
local xtypeof = require(Parent.Utility.xtypeof)

local function setProperty_unsafe(p1, p2, p3) -- Line: 34
    p1[p2] = p3
end

local function testPropertyAssignable(p1, p2) -- Line: 42
    p1[p2] = p1[p2]
end

local function setProperty(p1, p2, p3) -- Line: 49
    -- upvalues: setProperty_unsafe (val), parseError (val), testPropertyAssignable (val), External (val)
    local success, result = xpcall(setProperty_unsafe, parseError, p1, p2, p3)
    if not success then
        if not pcall(testPropertyAssignable, p1, p2) then
            External.logErrorNonFatal("cannotAssignProperty", nil, p1.ClassName, p2)
            return
        end
        local v1 = typeof(p3)
        local v2 = p1[p2]
        local v3 = typeof(v2)
        if v1 == v3 then
            External.logErrorNonFatal("propertySetError", result)
            return
        end
        External.logErrorNonFatal("invalidPropertyType", nil, p1.ClassName, p2, v3, v1)
    end
end

local function bindProperty(p1, p2, p3, p4) -- Line: 74
    -- upvalues: castToState (val), checkLifetime (val), Observer (val), setProperty (val), peek (val)
    if not castToState(p4) then
        setProperty(p2, p3, p4)
        return
    end
    checkLifetime.bOutlivesA(p1, p2, p4.scope, p4.oldestTask, checkLifetime.formatters.boundProperty, p3)
    ;(Observer(p1, p4)):onBind(function() -- Line: 88 -- upvalues: setProperty (upval), p2 (val), p3 (val), peek (upval), p4 (val)
        setProperty(p2, p3, peek(p4))
    end)
end

return function(p1, p2, p3) -- Line: 97 -- upvalues: xtypeof (val), bindProperty (val), External (val)
    local stage, v1, v2
    local v3 = {self = {}, descendants = {}, ancestor = {}, observer = {}}
    for k, v in pairs(p2) do
        v2 = xtypeof(k)
        if v2 ~= "string" then
            if v2 ~= "SpecialKey" then
                External.logError("unrecognisedPropertyKey", nil, v2)
            else
                stage = k.stage
                v1 = v3[stage]
                if v1 ~= nil then
                    v1[k] = v
                else
                    External.logError("unrecognisedPropertyStage", nil, stage)
                end
            end
        elseif k ~= "Parent" then
            bindProperty(p1, p3, k, v)
        end
    end
    for k2, i in pairs(v3.self) do
        k2:apply(p1, i, p3)
    end
    for k3, j in pairs(v3.descendants) do
        k3:apply(p1, j, p3)
    end
    if p2.Parent ~= nil then
        bindProperty(p1, p3, "Parent", p2.Parent)
    end
    for k4, k5 in pairs(v3.ancestor) do
        k4:apply(p1, k5, p3)
    end
    for k6, n in pairs(v3.observer) do
        k6:apply(p1, n, p3)
    end
end