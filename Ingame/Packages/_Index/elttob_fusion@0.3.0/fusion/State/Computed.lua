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
function v1._evaluate(p1) -- Line: 93 -- upvalues: deriveScope (val), castToState (val), checkLifetime (val), depend (val), peek (val), parseError (val), scopePool (val), isSimilar (val), doCleanup (val), External (val)
    local scope, v1, v2
    if p1.scope == nil then
        return false
    end
    scope = p1.scope
    local v3 = deriveScope(scope)
    v1, v2 = xpcall(p1._processor, parseError, function(a1) -- Line: 101 -- upvalues: castToState (upval), checkLifetime (upval), scope (val), p1 (val), depend (upval), peek (upval)
        local v1 = castToState(a1)
        if v1 ~= nil then
            checkLifetime.bOutlivesA(scope, p1.oldestTask, v1.scope, v1.oldestTask, checkLifetime.formatters.useFunction)
            depend(p1, v1)
        end
        return peek(a1)
    end, v3)
    local v4 = scopePool.giveIfEmpty(v3)
    if not v1 then
        if v4 ~= nil then
            doCleanup(v4)
        end
        External.logErrorNonFatal("callbackError", v2)
        return false
    end
    local v5 = isSimilar(p1._EXTREMELY_DANGEROUS_usedAsValue, v2)
    if p1._innerScope ~= nil then
        doCleanup(p1._innerScope)
    end
    p1._innerScope = v4
    p1._EXTREMELY_DANGEROUS_usedAsValue = v2
    return not v5
end
table.freeze(v1)
return function(p1, p2, p3) -- Line: 46 -- upvalues: External (val), u59 (val), doCleanup (val), nicknames (val)
    local v1 = os.clock()
    if typeof(p1) == "function" then
        External.logError("scopeMissing", nil, "Computeds", "myScope:Computed(function(use, scope) ... end)")
    elseif p3 ~= nil then
        External.logWarn("destructorRedundant", "Computed")
    end
    local u28 = setmetatable({
        validity = "invalid",
        createdAt = v1,
        dependencySet = {},
        dependentSet = {},
        scope = p1,
        _processor = p2,
    }, u59)
    local function v2() -- Line: 71 -- upvalues: u28 (val), doCleanup (upval)
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