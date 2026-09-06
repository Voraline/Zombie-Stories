local Parent = script.Parent.Parent
require(Parent.PubTypes)
require(Parent.Types)
local captureDependencies = require(Parent.Dependencies.captureDependencies)
local initDependency = require(Parent.Dependencies.initDependency)
local useDependency = require(Parent.Dependencies.useDependency)
local parseError = require(Parent.Logging.parseError)
local logErrorNonFatal = require(Parent.Logging.logErrorNonFatal)
local logWarn = require(Parent.Logging.logWarn)
local cleanup = require(Parent.Utility.cleanup)
local needsDestruction = require(Parent.Utility.needsDestruction)
local v1 = {}
local u42 = {__index = v1}
local u43 = {__mode = "k"}
function v1:get(p2) -- Line: 34 -- upvalues: useDependency (val)
    if p2 ~= false then
        useDependency(self)
    end
    return self._outputTable
end
function v1:update() -- Line: 59 -- upvalues: u43 (val), captureDependencies (val), needsDestruction (val), logWarn (val), cleanup (val), parseError (val), logErrorNonFatal (val)
    local _destructor, _destructor_2, _inputTable, meta, oldDependencySet, oldDependencySet_2, v1, v2, v3, v4, v5, v6, v7, value, valueData
    local _inputIsState = self._inputIsState
    if not _inputIsState then
        _inputTable = self._inputTable
    else
        _inputTable = self._inputTable:get(false)
    end
    local v8 = {}
    local v9 = false
    local _oldValueCache = self._oldValueCache
    self._oldValueCache = self._valueCache
    self._valueCache = _oldValueCache
    local _valueCache = self._valueCache
    local _oldValueCache_2 = self._oldValueCache
    table.clear(_valueCache)
    for k in pairs(self.dependencySet) do
        k.dependentSet[self] = nil
    end
    local _oldDependencySet = self._oldDependencySet
    self._oldDependencySet = self.dependencySet
    self.dependencySet = _oldDependencySet
    table.clear(self.dependencySet)
    if _inputIsState then
        self._inputTable.dependentSet[self] = true
        self.dependencySet[self._inputTable] = true
    end
    local v10 = self
    for k2, v in pairs(_inputTable) do
        v1 = _oldValueCache_2[v]
        v2 = v1 == nil
        value = nil
        valueData = nil
        meta = nil
        if type(v1) ~= "table" then
            if v1 ~= nil then
                _oldValueCache_2[v] = nil
                v2 = true
            end
        elseif 0 < #v1 then
            v3 = table.remove(v1, #v1)
            value = v3.value
            valueData = v3.valueData
            meta = v3.meta
            if #v1 <= 0 then
                _oldValueCache_2[v] = nil
            end
        end
        if valueData == nil then
            valueData = {dependencySet = setmetatable({}, u43), oldDependencySet = setmetatable({}, u43), dependencyValues = setmetatable({}, u43)}
        end
        if not v2 then
            for k3, i in pairs(valueData.dependencyValues) do
                if i ~= k3:get(false) then
                    v2 = true
                    break
                end
            end
        end
        if v2 then
            oldDependencySet = valueData.oldDependencySet
            valueData.oldDependencySet = valueData.dependencySet
            valueData.dependencySet = oldDependencySet
            table.clear(valueData.dependencySet)
            v3, v4, v5 = captureDependencies(valueData.dependencySet, v10._processor, v)
            if not v3 then
                oldDependencySet_2 = valueData.oldDependencySet
                valueData.oldDependencySet = valueData.dependencySet
                valueData.dependencySet = oldDependencySet_2
                logErrorNonFatal("forValuesProcessorError", v4)
            else
                if v10._destructor == nil then
                    if needsDestruction(v4) then
                        logWarn("destructorNeededForValues")
                    elseif not (needsDestruction(v5)) then
                    end
                end
                if value ~= nil then
                    _destructor_2 = v10._destructor
                    if not _destructor_2 then
                        _destructor_2 = cleanup
                    end
                    v6, v7 = xpcall(_destructor_2, parseError, value, meta)
                    if not v6 then
                        logErrorNonFatal("forValuesDestructorError", v7)
                    end
                end
                value = v4
                meta = v5
                v9 = true
            end
        end
        v3 = _valueCache[v]
        if v3 == nil then
            _valueCache[v] = {}
        end
        table.insert(v3, {value = value, valueData = valueData, meta = meta})
        v8[k2] = value
        for k4 in pairs(valueData.dependencySet) do
            valueData.dependencyValues[k4] = k4:get(false)
            v10.dependencySet[k4] = true
            k4.dependentSet[v10] = true
        end
    end
    for k5, j in pairs(_oldValueCache_2) do
        for i2, k6 in ipairs(j) do
            _destructor = v10._destructor
            if not _destructor then
                _destructor = cleanup
            end
            v5, v6 = xpcall(_destructor, parseError, k6.value, k6.meta)
            if not v5 then
                logErrorNonFatal("forValuesDestructorError", v6)
            end
            v9 = true
        end
        table.clear(j)
    end
    v10._outputTable = v8
    return v9
end
return function(p1, p2, p3) -- Line: 213 -- upvalues: u43 (val), u42 (val), initDependency (val)
    local v1 = if p1.type == "State" then typeof(p1.get) == "function" else false
    local v2 = setmetatable({
        type = "State",
        kind = "ForValues",
        dependencySet = {},
        dependentSet = setmetatable({}, u43),
        _oldDependencySet = {},
        _processor = p2,
        _destructor = p3,
        _inputIsState = v1,
        _inputTable = p1,
        _outputTable = {},
        _valueCache = {},
        _oldValueCache = {},
    }, u42)
    initDependency(v2)
    v2:update()
    return v2
end