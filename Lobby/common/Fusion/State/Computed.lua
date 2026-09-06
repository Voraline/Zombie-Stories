local Parent = script.Parent.Parent
require(Parent.Types)
local captureDependencies = require(Parent.Dependencies.captureDependencies)
local initDependency = require(Parent.Dependencies.initDependency)
local useDependency = require(Parent.Dependencies.useDependency)
local logErrorNonFatal = require(Parent.Logging.logErrorNonFatal)
local logWarn = require(Parent.Logging.logWarn)
local isSimilar = require(Parent.Utility.isSimilar)
local needsDestruction = require(Parent.Utility.needsDestruction)
local v1 = {}
local u35 = {__index = v1}
local u36 = {__mode = "k"}
function v1.get(p1, p2) -- Line: 28 -- upvalues: useDependency (val)
    if p2 ~= false then
        useDependency(p1)
    end
    return p1._value
end
function v1:update() -- Line: 39 -- upvalues: captureDependencies (val), needsDestruction (val), logWarn (val), isSimilar (val), logErrorNonFatal (val)
    local v1, v2, v3
    for k in pairs(self.dependencySet) do
        k.dependentSet[self] = nil
    end
    local _oldDependencySet = self._oldDependencySet
    self._oldDependencySet = self.dependencySet
    self.dependencySet = _oldDependencySet
    table.clear(self.dependencySet)
    v1, v2, v3 = captureDependencies(self.dependencySet, self._processor)
    if not v1 then
        logErrorNonFatal("computedCallbackError", v2)
        local _oldDependencySet_2 = self._oldDependencySet
        self._oldDependencySet = self.dependencySet
        self.dependencySet = _oldDependencySet_2
        for k2 in pairs(self.dependencySet) do
            k2.dependentSet[self] = true
        end
        return false
    end
    if self._destructor == nil and needsDestruction(v2) then
        logWarn("destructorNeededComputed")
    end
    if v3 ~= nil then
        logWarn("multiReturnComputed")
    end
    local _value = self._value
    local v4 = isSimilar(_value, v2)
    if self._destructor ~= nil then
        self._destructor(_value)
    end
    self._value = v2
    for k3 in pairs(self.dependencySet) do
        k3.dependentSet[self] = true
    end
    return not v4
end
return function(p1, p2) -- Line: 93 -- upvalues: u36 (val), u35 (val), initDependency (val)
    local v1 = setmetatable({
        type = "State",
        kind = "Computed",
        dependencySet = {},
        dependentSet = setmetatable({}, u36),
        _oldDependencySet = {},
        _processor = p1,
        _destructor = p2,
    }, u35)
    initDependency(v1)
    v1:update()
    return v1
end