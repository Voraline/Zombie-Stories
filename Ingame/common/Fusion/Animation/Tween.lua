local Parent = script.Parent.Parent
require(Parent.PubTypes)
require(Parent.Types)
local TweenScheduler = require(Parent.Animation.TweenScheduler)
local useDependency = require(Parent.Dependencies.useDependency)
local initDependency = require(Parent.Dependencies.initDependency)
local logError = require(Parent.Logging.logError)
local logErrorNonFatal = require(Parent.Logging.logErrorNonFatal)
local xtypeof = require(Parent.Utility.xtypeof)
local v1 = {}
local u34 = {__index = v1}
local u35 = {__mode = "k"}
function v1:get(p2) -- Line: 27 -- upvalues: useDependency (val)
    if p2 ~= false then
        useDependency(self)
    end
    return self._currentValue
end
function v1.update(p1) -- Line: 38 -- upvalues: logErrorNonFatal (val), TweenScheduler (val)
    local v1 = p1._goalState:get(false)
    if v1 ~= p1._nextValue then
        local _tweenInfo = p1._tweenInfo
        if p1._tweenInfoIsState then
            _tweenInfo = _tweenInfo:get()
        end
        if typeof(_tweenInfo) ~= "TweenInfo" then
            logErrorNonFatal("mistypedTweenInfo", nil, (typeof(_tweenInfo)))
            return false
        end
        p1._prevValue = p1._currentValue
        p1._nextValue = v1
        p1._currentTweenStartTime = os.clock()
        p1._currentTweenInfo = _tweenInfo
        local v2 = _tweenInfo.DelayTime + _tweenInfo.Time
        if _tweenInfo.Reverses then
            v2 = v2 + _tweenInfo.Time
        end
        p1._currentTweenDuration = v2 * (_tweenInfo.RepeatCount + 1)
        TweenScheduler.add(p1)
        return false
    elseif not p1._currentlyAnimating then
        return false
    end
end
return function(p1, p2) -- Line: 77 -- upvalues: xtypeof (val), logError (val), u35 (val), u34 (val), initDependency (val)
    local v1
    local v2 = p1:get(false)
    if p2 ~= nil then
        v1 = p2
    else
        v1 = TweenInfo.new()
    end
    local v3 = {}
    v3[p1] = true
    local v4 = xtypeof(v1) == "State"
    if v4 then
        v3[v1] = true
    end
    local v5 = v1
    if v4 then
        v5 = v5:get()
    end
    if typeof(v5) ~= "TweenInfo" then
        logError("mistypedTweenInfo", nil, (typeof(v5)))
    end
    local v6 = setmetatable({
        type = "State",
        kind = "Tween",
        _currentTweenDuration = 0,
        _currentTweenStartTime = 0,
        _currentlyAnimating = false,
        dependencySet = v3,
        dependentSet = setmetatable({}, u35),
        _goalState = p1,
        _tweenInfo = v1,
        _tweenInfoIsState = v4,
        _prevValue = v2,
        _nextValue = v2,
        _currentValue = v2,
        _currentTweenInfo = v1,
    }, u34)
    initDependency(v6)
    p1.dependentSet[v6] = true
    return v6
end