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
local u46 = {}
u46.__index = v1
local u47 = {__mode = "k"}

function v1:get(p2) -- Line: 36 -- upvalues: useDependency (val)
    if p2 ~= false then
        useDependency(self)
    end
    return self._outputTable
end

function v1:update() -- Line: 62
    -- upvalues: u47 (val), captureDependencies (val), needsDestruction (val), logWarn (val), logError (val)
    -- upvalues: cleanup (val), parseError (val), logErrorNonFatal (val)
    local _destructor, _destructor_2, _inputTable, dependencySet_2, dependencySet_3, oldDependencySet, oldDependencySet_2, result, result_2, success, success_2, v1, v2, v3, v4, v5, v6, v7, v8, v9
    local _inputIsState = self._inputIsState
    if not _inputIsState then
        _inputTable = self._inputTable
    else
        _inputTable = self._inputTable:get(false)
    end
    local _oldInputTable = self._oldInputTable
    local _outputTable = self._outputTable
    local _keyOIMap = self._keyOIMap
    local _keyIOMap = self._keyIOMap
    local _meta = self._meta
    local v10 = false
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
    local v11 = self
    for k2, v in pairs(_inputTable) do
        v1 = v11._keyData[k2]
        if v1 == nil then
            v2 = {}
            v5 = u47
            v2.dependencySet = setmetatable({}, v5)
            v5 = u47
            v2.oldDependencySet = setmetatable({}, v5)
            v5 = u47
            v2.dependencyValues = setmetatable({}, v5)
            v1 = v2
            v11._keyData[k2] = v1
        end
        v2 = _oldInputTable[k2] == nil
        if not v2 then
            for k3, i in pairs(v1.dependencyValues) do
                if i ~= k3:get(false) then
                    v2 = true
                    break
                end
            end
        end
        if v2 then
            dependencySet_2 = v1.dependencySet
            oldDependencySet = v1.oldDependencySet
            v1.oldDependencySet = dependencySet_2
            v1.dependencySet = oldDependencySet
            table.clear(v1.dependencySet)
            v3, v4, v5 = captureDependencies(v1.dependencySet, v11._processor, k2)
            if not v3 then
                dependencySet_3 = v1.dependencySet
                oldDependencySet_2 = v1.oldDependencySet
                v1.oldDependencySet = dependencySet_3
                v1.dependencySet = oldDependencySet_2
                logErrorNonFatal("forKeysProcessorError", v4)
            else
                if v11._destructor == nil then
                    if needsDestruction(v4) or needsDestruction(v5) then
                        logWarn("destructorNeededForKeys")
                    end
                end
                v6 = _keyOIMap[v4]
                v7 = _keyIOMap[k2]
                if v6 ~= k2 and _inputTable[v6] ~= nil then
                    v8 = logError
                    v8("forKeysKeyCollision", nil, tostring(v4), tostring(v6), (tostring(v4)))
                end
                if v7 ~= v4 and _keyOIMap[v7] == k2 then
                    v8 = _meta[v7]
                    v9 = xpcall
                    _destructor_2 = v11._destructor
                    if not _destructor_2 then
                        _destructor_2 = cleanup
                    end
                    success_2, result_2 = v9(_destructor_2, parseError, v7, v8)
                    if not success_2 then
                        logErrorNonFatal("forKeysDestructorError", result_2)
                    end
                    _keyOIMap[v7] = nil
                    _outputTable[v7] = nil
                    _meta[v7] = nil
                end
                _oldInputTable[k2] = v
                _meta[v4] = v5
                _keyOIMap[v4] = k2
                _keyIOMap[k2] = v4
                _outputTable[v4] = v
                v10 = true
            end
        end
        for k4 in pairs(v1.dependencySet) do
            v1.dependencyValues[k4] = (k4:get(false))
            v11.dependencySet[k4] = true
            k4.dependentSet[v11] = true
        end
    end
    for k5, j in pairs(_keyOIMap) do
        if _inputTable[j] == nil then
            v1 = _meta[k5]
            v2 = xpcall
            _destructor = v11._destructor
            if not _destructor then
                _destructor = cleanup
            end
            success, result = v2(_destructor, parseError, k5, v1)
            if not success then
                logErrorNonFatal("forKeysDestructorError", result)
            end
            _oldInputTable[j] = nil
            _meta[k5] = nil
            _keyOIMap[k5] = nil
            _keyIOMap[j] = nil
            _outputTable[k5] = nil
            v11._keyData[j] = nil
            v10 = true
        end
    end
    return v10
end

return function(p1, p2, p3) -- Line: 212 -- upvalues: u47 (val), u46 (val), initDependency (val)
    local v1 = false
    if p1.type == "State" then
        local get = p1.get
        v1 = typeof(get) == "function"
    end
    local v2 = {type = "State", kind = "ForKeys", dependencySet = {}}
    local v3 = u47
    v2.dependentSet = setmetatable({}, v3)
    v2._oldDependencySet = {}
    v2._processor = p2
    v2._destructor = p3
    v2._inputIsState = v1
    v2._inputTable = p1
    v2._oldInputTable = {}
    v2._outputTable = {}
    v2._keyOIMap = {}
    v2._keyIOMap = {}
    v2._keyData = {}
    v2._meta = {}
    local v4 = u46
    local v5 = setmetatable(v2, v4)
    initDependency(v5)
    v5:update()
    return v5
end