local Parent = script.Parent.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local depend = require(Parent.Graph.depend)
local peek = require(Parent.State.peek)
local castToState = require(Parent.State.castToState)
require(Parent.State.For.ForTypes)
local doCleanup = require(Parent.Memory.doCleanup)
local deriveScope = require(Parent.Memory.deriveScope)
local scopePool = require(Parent.Memory.scopePool)
local nameOf = require(Parent.Utility.nameOf)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {type = "Graph", kind = "For.Disassembly", timeliness = "lazy"}
local v2 = {__index = v1}
local u53 = table.freeze(v2)
function v1.populate(p1, p2, p3) -- Line: 89 -- upvalues: External (val)
    local v1, v2, v3, v4
    local v5 = (1 / 0)
    local v6 = (-1 / 0)
    local v7 = false
    local _subObjects = p1._subObjects
    local v8 = nil
    local v9 = nil
    v4, v1 = p3, p2
    for i in _subObjects, v8, v9 do
        v2, v3 = i:useOutputPair(v1)
        if v2 == nil then
            v7 = true
        elseif v3 ~= nil then
            if v4[v2] == nil then
                v4[v2] = v3
                if typeof(v2) == "number" then
                    v5 = math.min(v5, v2)
                    v6 = math.max(v6, v2)
                end
            else
                External.logErrorNonFatal("forKeyCollision", nil, (tostring(v2)))
            end
        end
    end
    if v7 and v5 < v6 then
        local v10
        local v11 = v5
        v8 = v6
        v9 = 1
        for j = v5, v8, v9 do
            v10 = v4[j]
            if v10 ~= nil then
                v4[j] = nil
                v4[v11] = v10
                v11 = v11 + 1
            end
        end
    end
end
function v1._evaluate(p1) -- Line: 129 -- upvalues: castToState (val), External (val), nameOf (val), depend (val), peek (val), doCleanup (val), deriveScope (val), scopePool (val)
    local inputKey, inputValue, v1, v2, v3, v4, v5, v6, v7
    local scope = p1.scope
    local v8 = castToState(p1._inputTable)
    if v8 ~= nil then
        if v8.scope == nil then
            v7 = ("The input %*"):format((nameOf(v8, "table")))
            External.logError("useAfterDestroy", nil, v7, "the For object that is watching it")
        end
        depend(p1, v8)
    end
    local v9 = {}
    for i, j in peek(p1._inputTable) do
        v9[i] = j
    end
    local v10 = {}
    local _subObjects = p1._subObjects
    v7 = nil
    local v11 = nil
    local v12 = p1
    for k in _subObjects, v7, v11 do
        v1 = false
        inputKey = k.inputKey
        inputValue = k.inputValue
        v3 = nil
        if k.roamKeys then
            v4 = v9
            v5 = nil
            v6 = nil
            for n, m in v4, v5, v6 do
                v1 = true
                v3 = n
                if k.roamValues or m == inputValue then
                    break
                end
            end
        elseif v9[inputKey] ~= nil then
            v1 = true
            v3 = inputKey
        end
        if v1 then
            v4 = v9[v3]
            v10[k] = true
            if v3 ~= inputKey then
                k.inputKey = v3
                k:invalidateInputKey()
            end
            if v4 ~= inputValue then
                k.inputValue = v4
                k:invalidateInputValue()
            end
            v9[v3] = nil
        elseif k.maybeScope ~= nil then
            doCleanup(k.maybeScope)
            k.maybeScope = nil
        end
    end
    local v13 = v9
    v7 = nil
    v11 = nil
    for i5, i6 in v13, v7, v11 do
        v2 = deriveScope(scope)
        v1 = v12._constructor(v2, i5, i6)
        if v1.maybeScope ~= nil then
            v1.maybeScope = scopePool.giveIfEmpty(v1.maybeScope)
        end
        v10[v1] = true
    end
    v12._subObjects = v10
    return true
end
table.freeze(v1)
return function(p1, p2, p3) -- Line: 46 -- upvalues: u53 (val), doCleanup (val), nicknames (val)
    local u11 = setmetatable({
        validity = "invalid",
        createdAt = os.clock(),
        dependencySet = {},
        dependentSet = {},
        scope = p1,
        _inputTable = p2,
        _constructor = p3,
        _subObjects = {},
    }, u53)
    local function v1() -- Line: 70 -- upvalues: u11 (val), doCleanup (upval)
        u11.scope = nil
        for k in pairs(u11.dependencySet) do
            k.dependentSet[u11] = nil
        end
        local _subObjects = u11._subObjects
        local v1 = nil
        local v2 = nil
        for i in _subObjects, v1, v2 do
            if i.maybeScope ~= nil then
                doCleanup(i.maybeScope)
                i.maybeScope = nil
            end
        end
    end
    u11.oldestTask = v1
    nicknames[u11.oldestTask] = "For (internal disassembler)"
    table.insert(p1, v1)
    return u11
end