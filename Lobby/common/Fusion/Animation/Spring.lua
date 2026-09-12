local Parent = script.Parent.Parent
require(Parent.PubTypes)
require(Parent.Types)
local logError = require(Parent.Logging.logError)
local logErrorNonFatal = require(Parent.Logging.logErrorNonFatal)
local unpackType = require(Parent.Animation.unpackType)
local SpringScheduler = require(Parent.Animation.SpringScheduler)
local useDependency = require(Parent.Dependencies.useDependency)
local initDependency = require(Parent.Dependencies.initDependency)
local updateAll = require(Parent.Dependencies.updateAll)
local xtypeof = require(Parent.Utility.xtypeof)
local unwrap = require(Parent.State.unwrap)
local v1 = {}
local u46 = {}
u46.__index = v1
local u47 = {__mode = "k"}

function v1:get(p2) -- Line: 30 -- upvalues: useDependency (val)
    if p2 ~= false then
        useDependency(self)
    end
    return self._currentValue
end

function v1.setPosition(p1, p2) -- Line: 44
    -- upvalues: logError (val), unpackType (val), SpringScheduler (val), updateAll (val)
    local v1 = typeof(p2)
    if v1 ~= p1._currentType then
        logError("springTypeMismatch", nil, v1, p1._currentType)
    end
    p1._springPositions = unpackType(p2, v1)
    p1._currentValue = p2
    SpringScheduler.add(p1)
    updateAll(p1)
end

function v1.setVelocity(p1, p2) -- Line: 63 -- upvalues: logError (val), unpackType (val), SpringScheduler (val)
    local v1 = typeof(p2)
    if v1 ~= p1._currentType then
        logError("springTypeMismatch", nil, v1, p1._currentType)
    end
    p1._springVelocities = unpackType(p2, v1)
    SpringScheduler.add(p1)
end

function v1.addVelocity(p1, p2) -- Line: 80 -- upvalues: logError (val), unpackType (val), SpringScheduler (val)
    local _springVelocities
    local v1 = typeof(p2)
    if v1 ~= p1._currentType then
        logError("springTypeMismatch", nil, v1, p1._currentType)
    end
    local v2 = unpackType(p2, v1)
    for i, v in ipairs(v2) do
        _springVelocities = p1._springVelocities
        _springVelocities[i] = _springVelocities[i] + v
    end
    SpringScheduler.add(p1)
end

function v1:update() -- Line: 97
    -- upvalues: unwrap (val), logErrorNonFatal (val), unpackType (val), SpringScheduler (val)
    local v1
    local v2 = self._goalState:get(false)
    if v2 == self._goalValue then
        local v3 = unwrap(self._damping)
        if typeof(v3) ~= "number" then
            logErrorNonFatal("mistypedSpringDamping", nil, (typeof(v3)))
        elseif not (v3 < 0) then
            self._currentDamping = v3
        else
            logErrorNonFatal("invalidSpringDamping", nil, v3)
        end
        v1 = unwrap(self._speed)
        if typeof(v1) ~= "number" then
            logErrorNonFatal("mistypedSpringSpeed", nil, (typeof(v1)))
        elseif not (v1 < 0) then
            self._currentSpeed = v1
        else
            logErrorNonFatal("invalidSpringSpeed", nil, v1)
        end
        return false
    end
    self._goalValue = v2
    local _currentType = self._currentType
    v1 = typeof(v2)
    self._currentType = v1
    local v4 = unpackType(v2, v1)
    local v5 = #v4
    self._springGoals = v4
    if v1 == _currentType then
        if v5 == 0 then
            self._currentValue = self._goalValue
            return true
        end
        SpringScheduler.add(self)
        return false
    end
    self._currentValue = self._goalValue
    local v6 = table.create(v5, 0)
    local v7 = table.create(v5, 0)
    for i, v in ipairs(v4) do
        v6[i] = v
    end
    self._springPositions = v6
    self._springVelocities = v7
    SpringScheduler.remove(self)
    return true
end

return function(p1, p2, p3) -- Line: 165 -- upvalues: xtypeof (val), u47 (val), unwrap (val), u46 (val), initDependency (val)
    local v1, v2
    if p2 ~= nil then
        v1 = p2
    else
        v1 = 10
    end
    if p3 ~= nil then
        v2 = p3
    else
        v2 = 1
    end
    local v3 = {}
    v3[p1] = true
    if xtypeof(v1) == "State" then
        v3[v1] = true
    end
    if xtypeof(v2) == "State" then
        v3[v2] = true
    end
    local v4 = {type = "State", kind = "Spring", dependencySet = v3}
    local v5 = u47
    v4.dependentSet = setmetatable({}, v5)
    v4._speed = v1
    v4._damping = v2
    v4._goalState = p1
    v4._currentSpeed = unwrap(v1)
    v4._currentDamping = unwrap(v2)
    local v6 = u46
    local v7 = setmetatable(v4, v6)
    initDependency(v7)
    p1.dependentSet[v7] = true
    v7:update()
    return v7
end