local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local checkLifetime = require(Parent.Memory.checkLifetime)
local depend = require(Parent.Graph.depend)
local evaluate = require(Parent.Graph.evaluate)
local castToState = require(Parent.State.castToState)
local peek = require(Parent.State.peek)
local ExternalTime = require(Parent.Animation.ExternalTime)
local Stopwatch = require(Parent.Animation.Stopwatch)
local lerpType = require(Parent.Animation.lerpType)
local getTweenRatio = require(Parent.Animation.getTweenRatio)
local getTweenDuration = require(Parent.Animation.getTweenDuration)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {type = "State", kind = "Tween", timeliness = "eager"}
local u59 = table.freeze({__index = v1})

function v1.get(p1) -- Line: 121 -- upvalues: External (val)
    return External.logError("stateGetWasRemoved")
end

function v1._evaluate(p1) -- Line: 127
    -- upvalues: castToState (val), depend (val), peek (val), External (val), getTweenDuration (val)
    -- upvalues: getTweenRatio (val), lerpType (val)
    local v1
    local v2 = castToState(p1._goal)
    if v2 == nil then
        p1._EXTREMELY_DANGEROUS_usedAsValue = p1._goal
        return false
    end
    depend(p1, v2)
    local v3 = peek(v2)
    if v3 ~= v3 then
        External.logWarn("tweenNanGoal")
        return false
    end
    local _stopwatch = p1._stopwatch
    local v4 = peek(p1._tweenInfo)
    if p1._activeTo ~= v3 or p1._activeElapsed < p1._activeDuration and p1._activeTweenInfo ~= v4 then
        p1._activeDuration = getTweenDuration(v4)
        p1._activeFrom = p1._EXTREMELY_DANGEROUS_usedAsValue
        p1._activeTo = v3
        p1._activeTweenInfo = v4
        _stopwatch:zero()
        _stopwatch:unpause()
    end
    depend(p1, _stopwatch)
    p1._activeElapsed = peek(_stopwatch)
    if p1._activeFrom == p1._activeTo then
        p1._activeFrom = p1._activeTo
        p1._activeElapsed = p1._activeDuration
        _stopwatch:pause()
    else
        local _activeElapsed = p1._activeElapsed
        if p1._activeDuration <= _activeElapsed then
            p1._activeFrom = p1._activeTo
            p1._activeElapsed = p1._activeDuration
            _stopwatch:pause()
        else
            local _activeTo = p1._activeTo
            v1 = typeof(_activeTo)
            local _activeFrom = p1._activeFrom
            if v1 ~= typeof(_activeFrom) then
                p1._activeFrom = p1._activeTo
                p1._activeElapsed = p1._activeDuration
                _stopwatch:pause()
            end
        end
    end
    v1 = getTweenRatio(v4, p1._activeElapsed)
    local _EXTREMELY_DANGEROUS_usedAsValue = p1._EXTREMELY_DANGEROUS_usedAsValue
    local _activeTo_2 = lerpType(p1._activeFrom, p1._activeTo, v1)
    if _activeTo_2 ~= _activeTo_2 then
        External.logWarn("tweenNanMotion")
        _activeTo_2 = p1._activeTo
    end
    p1._EXTREMELY_DANGEROUS_usedAsValue = _activeTo_2
    local v5 = _EXTREMELY_DANGEROUS_usedAsValue ~= _activeTo_2
    return v5
end

table.freeze(v1)
return function(p1, p2, p3) -- Line: 51
    -- upvalues: castToState (val), External (val), Stopwatch (val), ExternalTime (val), peek (val), u59 (val)
    -- upvalues: nicknames (val), checkLifetime (val), evaluate (val)
    local v1 = os.clock()
    if castToState(p1) then
        External.logError("scopeMissing", nil, "Tweens", "myScope:Tween(goalState, tweenInfo)")
    end
    local v2 = castToState(p2)
    local v3 = nil
    if v2 ~= nil then
        v3 = Stopwatch(p1, ExternalTime(p1))
    end
    local v4 = {
        validity = "invalid",
        createdAt = v1,
        dependencySet = {},
        dependentSet = {},
        scope = p1,
        _EXTREMELY_DANGEROUS_usedAsValue = peek(p2),
        _goal = p2,
        _stopwatch = v3,
    }
    local v5 = p3
    if not v5 then
        v5 = TweenInfo.new()
    end
    v4._tweenInfo = v5
    v5 = u59
    local u48 = setmetatable(v4, v5)

    function v4() -- Line: 87 -- upvalues: u48 (val)
        u48.scope = nil
        for k in pairs(u48.dependencySet) do
            k.dependentSet[u48] = nil
        end
    end

    u48.oldestTask = v4
    nicknames[u48.oldestTask] = "Tween"
    table.insert(p1, v4)
    if v2 ~= nil then
        checkLifetime.bOutlivesA(p1, u48.oldestTask, v2.scope, v2.oldestTask, checkLifetime.formatters.animationGoal)
    end
    v5 = castToState(p3)
    if v5 ~= nil then
        checkLifetime.bOutlivesA(
            p1,
            u48.oldestTask,
            v5.scope,
            v5.oldestTask,
            checkLifetime.formatters.parameter,
            "tween info"
        )
    end
    evaluate(u48, true)
    return u48
end