local Parent = script.Parent.Parent
require(Parent.PubTypes)
require(Parent.Types)
local captureDependencies = require(Parent.Dependencies.captureDependencies)
local initDependency = require(Parent.Dependencies.initDependency)
local useDependency = require(Parent.Dependencies.useDependency)
local parseError = require(Parent.Logging.parseError)
local logErrorNonFatal = require(Parent.Logging.logErrorNonFatal)
local logError = require(Parent.Logging.logError)
local logWarn = require(Parent.Logging.logWarn)
local cleanup = require(Parent.Utility.cleanup)
local needsDestruction = require(Parent.Utility.needsDestruction)
local v1 = {}
local u46 = {__index = v1}
local u47 = {__mode = "k"}
function v1:get(p2) -- Line: 36 -- upvalues: useDependency (val)
    if p2 ~= false then
        useDependency(self)
    end
    return self._outputTable
end
function v1:update() -- Line: 61 -- upvalues: u47 (val), captureDependencies (val), needsDestruction (val), logWarn (val), logError (val), cleanup (val), parseError (val), logErrorNonFatal (val)
    local _destructor, _destructor_2, _inputTable, oldDependencySet, oldDependencySet_2, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15
    local _inputIsState = self._inputIsState
    if not _inputIsState then
        _inputTable = self._inputTable
    else
        _inputTable = self._inputTable:get(false)
    end
    local _oldInputTable = self._oldInputTable
    local _keyIOMap = self._keyIOMap
    local _meta = self._meta
    local v16 = false
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
    local _oldOutputTable = self._oldOutputTable
    self._oldOutputTable = self._outputTable
    self._outputTable = _oldOutputTable
    local _oldOutputTable_2 = self._oldOutputTable
    local _outputTable = self._outputTable
    table.clear(_outputTable)
    local v17 = self
    for k2, v in pairs(_inputTable) do
        v1 = v17._keyData[k2]
        if v1 == nil then
            v17._keyData[k2] = {dependencySet = setmetatable({}, u47), oldDependencySet = setmetatable({}, u47), dependencyValues = setmetatable({}, u47)}
        end
        v2 = _oldInputTable[k2] ~= v
        if not v2 then
            for k3, i in pairs(v1.dependencyValues) do
                if i ~= k3:get(false) then
                    v2 = true
                    break
                end
            end
        end
        if not v2 then
            v3 = _keyIOMap[k2]
            if _outputTable[v3] ~= nil then
                v4 = nil
                v5 = nil
                for k4, j in pairs(_keyIOMap) do
                    if v3 == j then
                        v5 = _inputTable[k4]
                        if v5 ~= nil then
                            v4 = k4
                            break
                        end
                    end
                end
                if v4 ~= nil then
                    v9 = tostring(v3)
                    v10 = tostring(v4)
                    v11 = tostring(v5)
                    v12 = tostring(k2)
                    logError("forPairsKeyCollision", nil, v9, v10, v11, v12, (tostring(v)))
                end
            end
            _outputTable[v3] = _oldOutputTable_2[v3]
        else
            oldDependencySet = v1.oldDependencySet
            v1.oldDependencySet = v1.dependencySet
            v1.dependencySet = oldDependencySet
            table.clear(v1.dependencySet)
            v3, v4, v5, v6 = captureDependencies(v1.dependencySet, v17._processor, k2, v)
            if not v3 then
                oldDependencySet_2 = v1.oldDependencySet
                v1.oldDependencySet = v1.dependencySet
                v1.dependencySet = oldDependencySet_2
                logErrorNonFatal("forPairsProcessorError", v4)
            else
                if v17._destructor == nil then
                    if needsDestruction(v4) then
                        logWarn("destructorNeededForPairs")
                    elseif not (needsDestruction(v5)) and not (needsDestruction(v6)) then
                    end
                end
                if _outputTable[v4] ~= nil then
                    v7 = nil
                    v8 = nil
                    for k5, k6 in pairs(_keyIOMap) do
                        if k6 == v4 then
                            v8 = _inputTable[k5]
                            if v8 ~= nil then
                                v7 = k5
                                break
                            end
                        end
                    end
                    if v7 ~= nil then
                        v12 = tostring(v4)
                        v13 = tostring(v7)
                        v14 = tostring(v8)
                        v15 = tostring(k2)
                        logError("forPairsKeyCollision", nil, v12, v13, v14, v15, (tostring(v)))
                    end
                end
                v7 = _oldOutputTable_2[v4]
                if v7 ~= v5 then
                    if v7 ~= nil then
                        _destructor_2 = v17._destructor
                        if not _destructor_2 then
                            _destructor_2 = cleanup
                        end
                        v9, v10 = xpcall(_destructor_2, parseError, v4, v7, _meta[v4])
                        if not v9 then
                            logErrorNonFatal("forPairsDestructorError", v10)
                        end
                    end
                    _oldOutputTable_2[v4] = nil
                end
                _oldInputTable[k2] = v
                _keyIOMap[k2] = v4
                _meta[v4] = v6
                _outputTable[v4] = v5
                v16 = true
            end
        end
        for k7 in pairs(v1.dependencySet) do
            v1.dependencyValues[k7] = k7:get(false)
            v17.dependencySet[k7] = true
            k7.dependentSet[v17] = true
        end
    end
    for k8, n in pairs(_oldOutputTable_2) do
        if _outputTable[k8] ~= n then
            if n ~= nil then
                _destructor = v17._destructor
                if not _destructor then
                    _destructor = cleanup
                end
                v2, v3 = xpcall(_destructor, parseError, k8, n, _meta[k8])
                if not v2 then
                    logErrorNonFatal("forPairsDestructorError", v3)
                end
            end
            if _outputTable[k8] == nil then
                _meta[k8] = nil
                v17._keyData[k8] = nil
            end
            v16 = true
        end
    end
    for k9 in pairs(_oldInputTable) do
        if _inputTable[k9] == nil then
            _oldInputTable[k9] = nil
            _keyIOMap[k9] = nil
        end
    end
    return v16
end
return function(p1, p2, p3) -- Line: 273 -- upvalues: u47 (val), u46 (val), initDependency (val)
    local v1 = if p1.type == "State" then typeof(p1.get) == "function" else false
    local v2 = setmetatable({
        type = "State",
        kind = "ForPairs",
        dependencySet = {},
        dependentSet = setmetatable({}, u47),
        _oldDependencySet = {},
        _processor = p2,
        _destructor = p3,
        _inputIsState = v1,
        _inputTable = p1,
        _oldInputTable = {},
        _outputTable = {},
        _oldOutputTable = {},
        _keyIOMap = {},
        _keyData = {},
        _meta = {},
    }, u46)
    initDependency(v2)
    v2:update()
    return v2
end