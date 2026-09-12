local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local parseError = require(Parent.Logging.parseError)
local isSimilar = require(Parent.Utility.isSimilar)
local never = require(Parent.Utility.never)
local depend = require(Parent.Graph.depend)
local castToState = require(Parent.State.castToState)
local peek = require(Parent.State.peek)
local doCleanup = require(Parent.Memory.doCleanup)
local deriveScope = require(Parent.Memory.deriveScope)
local checkLifetime = require(Parent.Memory.checkLifetime)
local scopePool = require(Parent.Memory.scopePool)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {type = "State", kind = "Computed", timeliness = "lazy"}
local u59 = table.freeze({__index = v1})

function v1.get(p1) -- Line: 86 -- upvalues: External (val), never (val)
    External.logError("stateGetWasRemoved")
    return never()
end

function v1._evaluate(p1) -- Line: 93
    -- upvalues: deriveScope (val), castToState (val), checkLifetime (val), depend (val), peek (val), parseError (val)
    -- upvalues: scopePool (val), isSimilar (val), doCleanup (val), External (val)
    if p1.scope == nil then
        return false
    end
    local scope = p1.scope
    local v1 = deriveScope(scope)
    local success, result = xpcall(p1._processor, parseError, function(p1_2) -- Line: 101
        -- upvalues: castToState (upval), checkLifetime (upval), scope (val), p1 (val), depend (upval), peek (upval)
        local v1 = castToState(p1_2)
        if v1 ~= nil then
            checkLifetime.bOutlivesA(
                scope,
                p1.oldestTask,
                v1.scope,
                v1.oldestTask,
                checkLifetime.formatters.useFunction
            )
            depend(p1, v1)
        end
        return peek(p1_2)
    end, v1)
    local v2 = scopePool.giveIfEmpty(v1)
    if not success then
        if v2 ~= nil then
            doCleanup(v2)
        end
        External.logErrorNonFatal("callbackError", result)
        return false
    end
    local v3 = isSimilar(p1._EXTREMELY_DANGEROUS_usedAsValue, result)
    if p1._innerScope ~= nil then
        doCleanup(p1._innerScope)
    end
    p1._innerScope = v2
    p1._EXTREMELY_DANGEROUS_usedAsValue = result
    return not v3
end

table.freeze(v1)
return function(p1, p2, p3) -- Line: 46 -- upvalues: External (val), u59 (val), doCleanup (val), nicknames (val)
    local v1 = os.clock()
    if typeof(p1) == "function" then
        External.logError("scopeMissing", nil, "Computeds", "myScope:Computed(function(use, scope) ... end)")
    elseif p3 ~= nil then
        External.logWarn("destructorRedundant", "Computed")
    end
    local v2 = {
        validity = "invalid",
        createdAt = v1,
        dependencySet = {},
        dependentSet = {},
        scope = p1,
        _processor = p2,
    }
    local v3 = u59
    local u28 = setmetatable(v2, v3)

    function v2() -- Line: 71 -- upvalues: u28 (val), doCleanup (upval)
        u28.scope = nil
        for k in pairs(u28.dependencySet) do
            k.dependentSet[u28] = nil
        end
        if u28._innerScope ~= nil then
            doCleanup(u28._innerScope)
        end
    end

    u28.oldestTask = v2
    nicknames[u28.oldestTask] = "Computed"
    table.insert(p1, v2)
    return u28
end