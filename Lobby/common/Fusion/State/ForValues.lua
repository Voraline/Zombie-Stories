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
local u42 = {}
u42.__index = v1
local u43 = {__mode = "k"}

function v1:get(p2) -- Line: 34 -- upvalues: useDependency (val)
    if p2 ~= false then
        useDependency(self)
    end
    return self._outputTable
end

function v1:update() -- Line: 59
    -- upvalues: u43 (val), captureDependencies (val), needsDestruction (val), logWarn (val), cleanup (val)
    -- upvalues: parseError (val), logErrorNonFatal (val)
    local _destructor, _destructor_2, _inputTable, dependencySet_2, dependencySet_3, meta, meta_2, oldDependencySet, oldDependencySet_2, result, result_2, success, success_2, v1, v2, v3, v4, v5, v6, value, valueData, value_2
    local _inputIsState = self._inputIsState
    if not _inputIsState then
        _inputTable = self._inputTable
    else
        _inputTable = self._inputTable:get(false)
    end
    local v7 = {}
    local v8 = false
    local _valueCache = self._valueCache
    local _oldValueCache = self._oldValueCache
    self._oldValueCache = _valueCache
    self._valueCache = _oldValueCache
    local _valueCache_2 = self._valueCache
    local _oldValueCache_2 = self._oldValueCache
    table.clear(_valueCache_2)
    for k in pairs(self.dependencySet) do
        k.dependentSet[self] = nil
    end
    local dependencySet = self.dependencySet
    local _oldDependencySet = self._oldDependencySet
    self._oldDependencySet = dependencySet
    self.dependencySet = _oldDependencySet
    table.clear(self.dependencySet)
    if _inputIsState then
        self._inputTable.dependentSet[self] = true
        self.dependencySet[self._inputTable] = true
    end
    local v9 = self
    for k2, v in pairs(_inputTable) do
        v1 = _oldValueCache_2[v]
        v2 = v1 == nil
        value_2 = nil
        valueData = nil
        meta_2 = nil
        if type(v1) ~= "table" then
            if v1 ~= nil then
                _oldValueCache_2[v] = nil
                v2 = true
            end
        elseif 0 < #v1 then
            v3 = table.remove(v1, #v1)
            value_2 = v3.value
            valueData = v3.valueData
            meta_2 = v3.meta
            if #v1 <= 0 then
                _oldValueCache_2[v] = nil
            end
        elseif v1 ~= nil then
            _oldValueCache_2[v] = nil
            v2 = true
        end
        if valueData == nil then
            v3 = {}
            v6 = u43
            v3.dependencySet = setmetatable({}, v6)
            v6 = u43
            v3.oldDependencySet = setmetatable({}, v6)
            v6 = u43
            v3.dependencyValues = setmetatable({}, v6)
            valueData = v3
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
            dependencySet_2 = valueData.dependencySet
            oldDependencySet = valueData.oldDependencySet
            valueData.oldDependencySet = dependencySet_2
            valueData.dependencySet = oldDependencySet
            table.clear(valueData.dependencySet)
            v3, v4, v5 = captureDependencies(valueData.dependencySet, v9._processor, v)
            if not v3 then
                dependencySet_3 = valueData.dependencySet
                oldDependencySet_2 = valueData.oldDependencySet
                valueData.oldDependencySet = dependencySet_3
                valueData.dependencySet = oldDependencySet_2
                logErrorNonFatal("forValuesProcessorError", v4)
            else
                if v9._destructor == nil then
                    if needsDestruction(v4) or needsDestruction(v5) then
                        logWarn("destructorNeededForValues")
                    end
                end
                if value_2 ~= nil then
                    v6 = xpcall
                    _destructor_2 = v9._destructor
                    if not _destructor_2 then
                        _destructor_2 = cleanup
                    end
                    success_2, result_2 = v6(_destructor_2, parseError, value_2, meta_2)
                    if not success_2 then
                        logErrorNonFatal("forValuesDestructorError", result_2)
                    end
                end
                value_2 = v4
                meta_2 = v5
                v8 = true
            end
        end
        v3 = _valueCache_2[v]
        if v3 == nil then
            v3 = {}
            _valueCache_2[v] = v3
        end
        v6 = {value = value_2, valueData = valueData, meta = meta_2}
        table.insert(v3, v6)
        v7[k2] = value_2
        for k4 in pairs(valueData.dependencySet) do
            valueData.dependencyValues[k4] = (k4:get(false))
            v9.dependencySet[k4] = true
            k4.dependentSet[v9] = true
        end
    end
    for k5, j in pairs(_oldValueCache_2) do
        for i2, k6 in ipairs(j) do
            value = k6.value
            meta = k6.meta
            v5 = xpcall
            _destructor = v9._destructor
            if not _destructor then
                _destructor = cleanup
            end
            success, result = v5(_destructor, parseError, value, meta)
            if not success then
                logErrorNonFatal("forValuesDestructorError", result)
            end
            v8 = true
        end
        table.clear(j)
    end
    v9._outputTable = v7
    return v8
end

return function(p1, p2, p3) -- Line: 213 -- upvalues: u43 (val), u42 (val), initDependency (val)
    local v1 = false
    if p1.type == "State" then
        local get = p1.get
        v1 = typeof(get) == "function"
    end
    local v2 = {type = "State", kind = "ForValues", dependencySet = {}}
    local v3 = u43
    v2.dependentSet = setmetatable({}, v3)
    v2._oldDependencySet = {}
    v2._processor = p2
    v2._destructor = p3
    v2._inputIsState = v1
    v2._inputTable = p1
    v2._outputTable = {}
    v2._valueCache = {}
    v2._oldValueCache = {}
    local v4 = u42
    local v5 = setmetatable(v2, v4)
    initDependency(v5)
    v5:update()
    return v5
end