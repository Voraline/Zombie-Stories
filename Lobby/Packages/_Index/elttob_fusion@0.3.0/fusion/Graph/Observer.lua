local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local checkLifetime = require(Parent.Memory.checkLifetime)
local castToGraph = require(Parent.Graph.castToGraph)
local depend = require(Parent.Graph.depend)
local evaluate = require(Parent.Graph.evaluate)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {type = "Observer", timeliness = "eager", dependentSet = table.freeze({})}
local u37 = table.freeze({__index = v1})
function v1.onBind(p1, p2) -- Line: 82 -- upvalues: External (val)
    External.doTaskImmediate(p2)
    return p1:onChange(p2)
end
function v1:onChange(p2) -- Line: 90
    local u4 = table.freeze({})
    self._changeListeners[u4] = p2
    return function() -- Line: 96 -- upvalues: self (val), u4 (val)
        self._changeListeners[u4] = nil
    end
end
function v1._evaluate(p1) -- Line: 101 -- upvalues: depend (val), External (val)
    if p1._watchingGraph ~= nil then
        depend(p1, p1._watchingGraph)
    end
    local _changeListeners = p1._changeListeners
    local v1 = nil
    local v2 = nil
    for i, j in _changeListeners, v1, v2 do
        External.doTaskImmediate(j)
    end
    return true
end
table.freeze(v1)
return function(p1, p2) -- Line: 36 -- upvalues: External (val), castToGraph (val), u37 (val), nicknames (val), checkLifetime (val), evaluate (val)
    local v1 = os.clock()
    if p2 == nil then
        External.logError("scopeMissing", nil, "Observers", "myScope:Observer(watching)")
    end
    local u22 = setmetatable({
        validity = "invalid",
        scope = p1,
        createdAt = v1,
        dependencySet = {},
        _watchingGraph = castToGraph(p2),
        _changeListeners = {},
    }, u37)
    local function v2() -- Line: 57 -- upvalues: u22 (val)
        u22.scope = nil
        for k in pairs(u22.dependencySet) do
            k.dependentSet[u22] = nil
        end
    end
    u22.oldestTask = v2
    nicknames[u22.oldestTask] = "Observer"
    table.insert(p1, v2)
    if u22._watchingGraph ~= nil then
        checkLifetime.bOutlivesA(p1, u22.oldestTask, u22._watchingGraph.scope, u22._watchingGraph.oldestTask, checkLifetime.formatters.observer)
    end
    evaluate(u22, true)
    return u22
end