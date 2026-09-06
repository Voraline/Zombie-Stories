local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local checkLifetime = require(Parent.Memory.checkLifetime)
local depend = require(Parent.Graph.depend)
local change = require(Parent.Graph.change)
local evaluate = require(Parent.Graph.evaluate)
local castToState = require(Parent.State.castToState)
local peek = require(Parent.State.peek)
local ExternalTime = require(Parent.Animation.ExternalTime)
local Stopwatch = require(Parent.Animation.Stopwatch)
local packType = require(Parent.Animation.packType)
local unpackType = require(Parent.Animation.unpackType)
local springCoefficients = require(Parent.Animation.springCoefficients)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {type = "State", kind = "Spring", timeliness = "eager"}
local u63 = table.freeze({__index = v1})
function v1.addVelocity(p1, p2) -- Line: 148 -- upvalues: evaluate (val), External (val), unpackType (val), change (val)
    evaluate(p1, false)
    local v1 = typeof(p2)
    if v1 ~= p1._activeType then
        External.logError("springTypeMismatch", nil, v1, p1._activeType)
    end
    local v2 = unpackType(p2, v1)
    local _activeLatestV = p1._activeLatestV
    local v3 = nil
    local v4 = nil
    for i, j in _activeLatestV, v3, v4 do
        v2[i] = v2[i] + j
    end
    p1._activeStartP = table.clone(p1._activeLatestP)
    p1._activeStartV = v2
    p1._stopwatch:zero()
    p1._stopwatch:unpause()
    change(p1)
end
function v1.get(p1) -- Line: 168 -- upvalues: External (val)
    return External.logError("stateGetWasRemoved")
end
function v1.setPosition(p1, p2) -- Line: 174 -- upvalues: evaluate (val), External (val), unpackType (val), change (val)
    evaluate(p1, false)
    local v1 = typeof(p2)
    if v1 ~= p1._activeType then
        External.logError("springTypeMismatch", nil, v1, p1._activeType)
    end
    p1._activeStartP = unpackType(p2, v1)
    p1._activeStartV = table.clone(p1._activeLatestV)
    p1._stopwatch:zero()
    p1._stopwatch:unpause()
    change(p1)
end
function v1.setVelocity(p1, p2) -- Line: 190 -- upvalues: evaluate (val), External (val), unpackType (val), change (val)
    evaluate(p1, false)
    local v1 = typeof(p2)
    if v1 ~= p1._activeType then
        External.logError("springTypeMismatch", nil, v1, p1._activeType)
    end
    p1._activeStartP = table.clone(p1._activeLatestP)
    p1._activeStartV = unpackType(p2, v1)
    p1._stopwatch:zero()
    p1._stopwatch:unpause()
    change(p1)
end
function v1._evaluate(p1) -- Line: 206 -- upvalues: castToState (val), peek (val), External (val), depend (val), springCoefficients (val), packType (val), unpackType (val)
    local v1, v2, v3, v4, v5
    local v6 = castToState(p1._goal)
    if v6 == nil then
        p1._EXTREMELY_DANGEROUS_usedAsValue = p1._goal
        return false
    end
    local v7 = peek(v6)
    if v7 ~= v7 then
        External.logWarn("springNanGoal")
        return false
    end
    local v8 = typeof(v7)
    local v9 = v8 ~= p1._activeType
    local _stopwatch = p1._stopwatch
    local v10 = peek(_stopwatch)
    depend(p1, _stopwatch)
    local _EXTREMELY_DANGEROUS_usedAsValue = p1._EXTREMELY_DANGEROUS_usedAsValue
    if v9 then
        v4 = v7
        v1 = p1
    elseif v10 > 0 then
        local v11, v12, v13, v14, v15, v16, v17
        v5, v2, v3, v11 = springCoefficients(v10, p1._activeDamping, p1._activeSpeed)
        local v18 = false
        local _activeNumSprings = p1._activeNumSprings
        local v19 = 1
        v1 = p1
        for i = 1, _activeNumSprings, v19 do
            v12 = v1._activeTargetP[i]
            v13 = v1._activeStartV[i]
            v14 = v1._activeStartP[i] - v12
            v15 = v14 * v5 + v13 * v2
            v16 = v14 * v3 + v13 * v11
            if v15 ~= v15 then
                External.logWarn("springNanMotion")
                v15 = 0
                v16 = 0
            elseif v16 == v16 then
            end
            v17 = math.abs(v15)
            if 1e-05 < v17 then
                v18 = true
            else
                v17 = math.abs(v16)
                if 1e-05 >= v17 then end
            end
            v1._activeLatestP[i] = v15 + v12
            v1._activeLatestV[i] = v16
        end
        if not v18 then
            local _activeNumSprings_2 = v1._activeNumSprings
            v19 = 1
            for j = 1, _activeNumSprings_2, v19 do
                v1._activeLatestP[j] = v1._activeTargetP[j]
            end
        end
        v4 = packType(v1._activeLatestP, v1._activeType)
    else
        v4 = _EXTREMELY_DANGEROUS_usedAsValue
        v1 = p1
    end
    v5 = peek(v1._speed)
    v2 = peek(v1._damping)
    if v9 then
        v1._activeTargetP = unpackType(v7, v8)
        v1._activeNumSprings = #v1._activeTargetP
        if not v9 then
            v1._activeStartP = table.clone(v1._activeLatestP)
            v1._activeStartV = table.clone(v1._activeLatestV)
        else
            v1._activeStartP = table.clone(v1._activeTargetP)
            v1._activeLatestP = table.clone(v1._activeTargetP)
            v1._activeStartV = table.create(v1._activeNumSprings, 0)
            v1._activeLatestV = table.create(v1._activeNumSprings, 0)
        end
        v1._activeType = v8
        v1._activeGoal = v7
        v1._activeDamping = v2
        v1._activeSpeed = v5
        _stopwatch:zero()
        _stopwatch:unpause()
    elseif v7 == v1._activeGoal and v5 == v1._activeSpeed and v2 == v1._activeDamping then
    end
    v1._EXTREMELY_DANGEROUS_usedAsValue = v4
    v3 = _EXTREMELY_DANGEROUS_usedAsValue ~= v4
    return v3
end
table.freeze(v1)
return function(p1, p2, p3, p4) -- Line: 60 -- upvalues: castToState (val), External (val), Stopwatch (val), ExternalTime (val), peek (val), u63 (val), nicknames (val), checkLifetime (val), evaluate (val)
    local v1 = os.clock()
    if typeof(p1) ~= "table" then
        External.logError("scopeMissing", nil, "Springs", "myScope:Spring(goalState, speed, damping)")
    elseif castToState(p1) == nil then
    end
    local v2 = castToState(p2)
    local v3 = nil
    if v2 ~= nil then
        v3 = Stopwatch(p1, ExternalTime(p1))
        v3:unpause()
    end
    local v4 = p3 or 10
    local v5 = p4 or 1
    local u64 = setmetatable({
        validity = "invalid",
        _activeDamping = -1,
        _activeNumSprings = 0,
        _activeSpeed = -1,
        _activeType = "",
        createdAt = v1,
        dependencySet = {},
        dependentSet = {},
        scope = p1,
        _activeLatestP = {},
        _activeLatestV = {},
        _activeStartP = {},
        _activeStartV = {},
        _activeTargetP = {},
        _damping = v5,
        _EXTREMELY_DANGEROUS_usedAsValue = peek(p2),
        _goal = p2,
        _speed = v4,
        _stopwatch = v3,
    }, u63)
    local function v6() -- Line: 107 -- upvalues: u64 (val)
        u64.scope = nil
        for k in pairs(u64.dependencySet) do
            k.dependentSet[u64] = nil
        end
    end
    u64.oldestTask = v6
    nicknames[u64.oldestTask] = "Spring"
    table.insert(p1, v6)
    if v2 ~= nil then
        checkLifetime.bOutlivesA(p1, u64.oldestTask, v2.scope, v2.oldestTask, checkLifetime.formatters.animationGoal)
    end
    local v7 = castToState(v4)
    if v7 ~= nil then
        checkLifetime.bOutlivesA(p1, u64.oldestTask, v7.scope, v7.oldestTask, checkLifetime.formatters.parameter, "speed")
    end
    local v8 = castToState(v5)
    if v8 ~= nil then
        checkLifetime.bOutlivesA(p1, u64.oldestTask, v8.scope, v8.oldestTask, checkLifetime.formatters.parameter, "damping")
    end
    evaluate(u64, true)
    return u64
end