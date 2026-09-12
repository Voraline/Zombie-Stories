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
local u53 = table.freeze({__index = v1})

function v1.populate(p1, p2, p3) -- Line: 89 -- upvalues: External (val)
    local v1, v2
    local v3 = (1 / 0)
    local v4 = (-1 / 0)
    local v5 = false
    local _subObjects = p1._subObjects
    local v6 = nil
    local v7 = nil
    local v8, v9 = p3, p2
    for i in _subObjects, v6, v7 do
        v1, v2 = i:useOutputPair(v9)
        if v1 == nil or v2 == nil then
            v5 = true
        elseif v8[v1] == nil then
            v8[v1] = v2
            if typeof(v1) == "number" then
                v3 = math.min(v3, v1)
                v4 = math.max(v4, v1)
            end
        else
            External.logErrorNonFatal("forKeyCollision", nil, (tostring(v1)))
        end
    end
    if v5 and v3 < v4 then
        local v10
        local v11 = v3
        v6 = v4
        for j = v3, v6 do
            v10 = v8[j]
            if v10 ~= nil then
                v8[j] = nil
                v8[v11] = v10
                v11 = v11 + 1
            end
        end
    end
end

function v1._evaluate(p1) -- Line: 129
    -- upvalues: castToState (val), External (val), nameOf (val), depend (val), peek (val), doCleanup (val)
    -- upvalues: deriveScope (val), scopePool (val)
    local inputKey, inputValue, v1, v2, v3, v4, v5, v6
    local scope = p1.scope
    local v7 = castToState(p1._inputTable)
    if v7 ~= nil then
        if v7.scope == nil then
            v6 = External
            local logError = v6.logError
            local v8 = nameOf
            v8 = v8(v7, "table")
            logError("useAfterDestroy", nil, ("The input %*"):format(v8), "the For object that is watching it")
        end
        depend(p1, v7)
    end
    v6 = {}
    for i, j in peek(p1._inputTable) do
        v6[i] = j
    end
    local v9 = {}
    local _subObjects = p1._subObjects
    local v10 = nil
    local v11 = nil
    local v12 = p1
    for k in _subObjects, v10, v11 do
        v1 = false
        inputKey = k.inputKey
        inputValue = k.inputValue
        v2 = nil
        if k.roamKeys then
            v3 = v6
            v4 = nil
            v5 = nil
            for n, m in v3, v4, v5 do
                v1 = true
                v2 = n
                if k.roamValues or m == inputValue then
                    break
                end
            end
        elseif v6[inputKey] == nil then
            v3 = v6
            v4 = nil
            v5 = nil
            for i5, i6 in v3, v4, v5 do
                v1 = true
                v2 = i5
                if k.roamValues or i6 == inputValue then
                    break
                end
            end
        else
            v1 = true
            v2 = inputKey
        end
        if v1 then
            v3 = v6[v2]
            v9[k] = true
            if v2 ~= inputKey then
                k.inputKey = v2
                k:invalidateInputKey()
            end
            if v3 ~= inputValue then
                k.inputValue = v3
                k:invalidateInputValue()
            end
            v6[v2] = nil
        elseif k.maybeScope ~= nil then
            doCleanup(k.maybeScope)
            k.maybeScope = nil
        end
    end
    local v13 = v6
    v10 = nil
    v11 = nil
    for i7, i8 in v13, v10, v11 do
        v1 = v12._constructor(deriveScope(scope), i7, i8)
        if v1.maybeScope ~= nil then
            v1.maybeScope = scopePool.giveIfEmpty(v1.maybeScope)
        end
        v9[v1] = true
    end
    v12._subObjects = v9
    return true
end

table.freeze(v1)
return function(p1, p2, p3) -- Line: 46 -- upvalues: u53 (val), doCleanup (val), nicknames (val)
    local v1 = {
        validity = "invalid",
        createdAt = os.clock(),
        dependencySet = {},
        dependentSet = {},
        scope = p1,
        _inputTable = p2,
        _constructor = p3,
        _subObjects = {},
    }
    local v2 = u53
    local u11 = setmetatable(v1, v2)

    function v1() -- Line: 70 -- upvalues: u11 (val), doCleanup (upval)
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