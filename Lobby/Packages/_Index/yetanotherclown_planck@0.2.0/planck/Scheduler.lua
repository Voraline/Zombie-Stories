local DependencyGraph = require(script.Parent.DependencyGraph)
local Pipeline = require(script.Parent.Pipeline)
local Phase = require(script.Parent.Phase)
local utils = require(script.Parent.utils)
local hooks = require(script.Parent.hooks)
local conditions = require(script.Parent.conditions)
local getSystem = utils.getSystem
local getSystemName = utils.getSystemName
local isPhase = utils.isPhase
local isPipeline = utils.isPipeline
local isValidEvent = utils.isValidEvent
local getEventIdentifier = utils.getEventIdentifier
local u36 = {}
local u38 = os.clock()
local u39 = {}
u39.__index = u39
u39.Hooks = hooks.Hooks
function u39.addPlugin(p1, p2) -- Line: 51
    p2:build(p1)
    table.insert(p1._plugins, p2)
    return p1
end
function u39._addHook(p1, p2, p3) -- Line: 57
    assert(p1._hooks[p2], (("Unknown Hook: %*"):format(p2)))
    table.insert(p1._hooks[p2], p3)
end
function u39.getDeltaTime(p1) -- Line: 68
    local v1 = debug.info(2, "f")
    if not v1 then
        error("Scheduler:getDeltaTime() must be used within a registered system")
    elseif not (p1._systemInfo[v1]) then
        error("Scheduler:getDeltaTime() must be used within a registered system")
    end
    return p1._systemInfo[v1].deltaTime or 0
end
function u39._handleLogs(p1, p2) -- Line: 80
    local v1, v2, v3, v4
    if not p2.timeLastLogged then
        p2.timeLastLogged = os.clock()
    end
    if not p2.recentLogs then
        p2.recentLogs = {}
    end
    local v5 = os.clock() - p2.timeLastLogged
    if 10 < v5 then
        p2.timeLastLogged = os.clock()
        p2.recentLogs = {}
    end
    v5 = debug.info(p2.system, "n")
    local logs = p2.logs
    local v6 = nil
    local v7 = nil
    local v8 = p2
    for i, j in logs, v6, v7 do
        if not (v8.recentLogs[j]) then
            task.spawn(error, j, 0)
            v3 = warn
            v4 = "Planck: Error occurred in system%*, this error will be ignored for 10 seconds"
            v2 = string.len(v5)
            if 0 >= v2 then
                v1 = ""
            else
                v1 = (" '%*'"):format(v5)
            end
            v3((v4:format(v1)))
            v8.recentLogs[j] = true
        end
    end
    table.clear(v8.logs)
end
function u39:runSystem(p2) -- Line: 109 -- upvalues: hooks (val), u38 (ref), u36 (ref)
    local v1
    if self:_canRun(p2) == false then
        return
    end
    local u7 = self._systemInfo[p2]
    local v2 = os.clock()
    u7.deltaTime = v2 - (u7.lastTime or v2)
    u7.lastTime = v2
    if not self._thread then
        self._thread = coroutine.create(function() -- Line: 121 -- upvalues: self (val)
            while true do
                self._yielded = true
                coroutine.yield()()
                self._yielded = false
            end
        end)
        coroutine.resume(self._thread)
    end
    local u20 = false
    local function systemCall() -- Line: 135 -- upvalues: self (val), p2 (val), u20 (ref), u7 (val), hooks (upval)
        hooks.systemCall(self, "SystemCall", u7, function() -- Line: 136 -- upvalues: self (upval), p2 (upval), u20 (upval), u7 (upval), hooks (upval)
            local u0 = nil
            local u1 = nil
            coroutine.resume(self._thread, function() -- Line: 138 -- upvalues: u0 (ref), u1 (ref), p2 (upval), self (upval)
                local v1, v2
                v1, v2 = xpcall(p2, function(p1) -- Line: 139
                    return debug.traceback(p1)
                end, table.unpack(self._vargs))
                u0 = v1
                u1 = v2
            end)
            if u0 == false then
                u20 = true
                table.insert(u7.logs, u1)
                hooks.systemError(self, u7, u1)
                return
            end
            if self._yielded then
                local v1, v2
                u20 = true
                v1, v2 = debug.info(self._thread, 1, "sl")
                local v3 = ("%*:%*: System yielded"):format(v1, v2)
                table.insert(u7.logs, debug.traceback(self._thread, v3, 2))
                hooks.systemError(self, u7, debug.traceback(self._thread, v3, 2))
            end
        end)
    end
    local function inner() -- Line: 170 -- upvalues: hooks (upval), self (val), u7 (val), systemCall (val)
        hooks.systemCall(self, "InnerSystemCall", u7, systemCall)
    end
    local v3 = os.clock() - u38
    if 10 < v3 then
        u38 = os.clock()
        u36 = {}
    end
    v3, v1 = pcall(function() -- Line: 174 -- upvalues: hooks (upval), self (val), u7 (val), inner (val)
        hooks.systemCall(self, "OuterSystemCall", u7, inner)
    end)
    if not v3 and not (u36[v1]) then
        task.spawn(error, v1, 0)
        warn("Planck: Error occurred while running hooks, this error will be ignored for 10 seconds")
        hooks.systemError(self, u7, (("Error occurred while running hooks: %*"):format(v1)))
        u36[v1] = true
    end
    if u20 then
        coroutine.close(self._thread)
        self._thread = coroutine.create(function() -- Line: 200 -- upvalues: self (val)
            while true do
                self._yielded = true
                coroutine.yield()()
                self._yielded = false
            end
        end)
        coroutine.resume(self._thread)
    end
    self:_handleLogs(u7)
end
function u39:runPhase(p2) -- Line: 215 -- upvalues: hooks (val)
    if self:_canRun(p2) == false then
        return
    end
    hooks.phaseBegan(self, p2)
    if not (self._phaseToSystems[p2]) then
        self._phaseToSystems[p2] = {}
    end
    local v1 = self._phaseToSystems[p2]
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        self:runSystem(j)
    end
end
function u39:runPipeline(p2) -- Line: 231
    if self:_canRun(p2) == false then
        return
    end
    local v1 = p2.dependencyGraph:getOrderedList()
    assert(v1, (("Pipeline %* contains a circular dependency, check it's Phases"):format(p2)))
    local v2 = v1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        self:runPhase(j)
    end
end
function u39:_canRun(p2) -- Line: 247
    local v1 = self._runIfConditions[p2]
    if not v1 then
        return true
    end
    local v2 = v1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if j(table.unpack(self._vargs)) == false then
            return false
        end
    end
    return true
end
function u39:run(p2) -- Line: 282 -- upvalues: Pipeline (val), getSystem (val), isPhase (val), isPipeline (val)
    if not p2 then
        error("No dependent specified in Scheduler:run(_)")
    end
    self:runPipeline(Pipeline.Startup)
    if getSystem(p2) then
        self:runSystem(p2)
        return self
    end
    if isPhase(p2) then
        self:runPhase(p2)
        return self
    end
    if isPipeline(p2) then
        self:runPipeline(p2)
        return self
    end
    error("Unknown dependent passed into Scheduler:run(unknown)")
    return self
end
function u39.runAll(p1) -- Line: 320
    local v1, v2, v3, v4
    local v5 = p1._defaultDependencyGraph:getOrderedList()
    assert(v5, "Default Group contains a circular dependency, check your Pipelines/Phases")
    local v6 = v5
    local v7 = nil
    local v8 = nil
    for i, j in v6, v7, v8 do
        p1:run(j)
    end
    local _eventDependencyGraphs = p1._eventDependencyGraphs
    v7 = nil
    v8 = nil
    local v9 = p1
    for k, n in _eventDependencyGraphs, v7, v8 do
        v2 = n:getOrderedList()
        assert(v5, (("Event Group '%*' contains a circular dependency, check your Pipelines/Phases"):format(k)))
        v3 = v2
        v4 = nil
        v1 = nil
        for m, i5 in v3, v4, v1 do
            v9:run(i5)
        end
    end
    return v9
end
function u39:insert(p2, p3, p4) -- Line: 395 -- upvalues: isPhase (val), isPipeline (val), isValidEvent (val), hooks (val)
    local v1 = isPhase(p2)
    if not v1 then
        v1 = isPipeline(p2)
    end
    assert(v1, "Unknown dependency passed to Scheduler:insert(unknown, _, _)")
    if p3 then
        v1 = isValidEvent(p3, p4)
        assert(v1, "Unknown instance/event passed to Scheduler:insert(_, instance, event)")
        local v2 = self:_getEventDependencyGraph(p3, p4)
        v2:insert(p2)
    else
        self._defaultDependencyGraph:insertBefore(p2, self._defaultPhase)
    end
    if isPhase(p2) then
        self._phaseToSystems[p2] = {}
        hooks.phaseAdd(self, p2)
    end
    return self
end
function u39:insertAfter(p2, p3) -- Line: 441 -- upvalues: isPhase (val), isPipeline (val), hooks (val)
    local v1 = isPhase(p3)
    if not v1 then
        v1 = isPipeline(p3)
    end
    assert(v1, "Unknown dependency passed in Scheduler:insertAfter(_, unknown)")
    v1 = isPhase(p2)
    if not v1 then
        v1 = isPipeline(p2)
    end
    assert(v1, "Unknown dependent passed in Scheduler:insertAfter(unknown, _)")
    self:_getGraphOfDependency(p3):insertAfter(p2, p3)
    if isPhase(p2) then
        self._phaseToSystems[p2] = {}
        hooks.phaseAdd(self, p2)
    end
    return self
end
function u39:insertBefore(p2, p3) -- Line: 481 -- upvalues: isPhase (val), isPipeline (val), hooks (val)
    local v1 = isPhase(p3)
    if not v1 then
        v1 = isPipeline(p3)
    end
    assert(v1, "Unknown dependency passed in Scheduler:insertBefore(_, unknown)")
    v1 = isPhase(p2)
    if not v1 then
        v1 = isPipeline(p2)
    end
    assert(v1, "Unknown dependent passed in Scheduler:insertBefore(unknown, _)")
    self:_getGraphOfDependency(p3):insertBefore(p2, p3)
    if isPhase(p2) then
        self._phaseToSystems[p2] = {}
        hooks.phaseAdd(self, p2)
    end
    return self
end
function u39:addSystem(p2, p3) -- Line: 509 -- upvalues: getSystem (val), getSystemName (val), hooks (val)
    local runConditions
    local v1 = getSystem(p2)
    if not v1 then
        error("Unknown system passed to Scheduler:addSystem(unknown, phase?)")
    end
    local name = getSystemName(v1)
    if type(p2) == "table" and p2.name then
        name = p2.name
    end
    local v2 = {system = v1, phase = p3, name = name, logs = {}}
    if not p3 then
        if type(p2) ~= "table" then
            v2.phase = self._defaultPhase
        elseif p2.phase then
            v2.phase = p2.phase
        end
    end
    self._systemInfo[v1] = v2
    if not (self._phaseToSystems[v2.phase]) then
        self._phaseToSystems[v2.phase] = {}
    end
    local v3 = self._phaseToSystems[v2.phase]
    table.insert(v3, v1)
    hooks.systemAdd(self, v2)
    if type(p2) == "table" and p2.runConditions then
        runConditions = p2.runConditions
        v3 = nil
        local v4 = nil
        for i, j in runConditions, v3, v4 do
            self:addRunCondition(v1, j)
        end
    end
    return self
end
function u39.addSystems(p1, p2, p3) -- Line: 562 -- upvalues: getSystem (val)
    if type(p2) ~= "table" then
        error("Unknown systems passed to Scheduler:addSystems(unknown, phase?)")
    end
    local v1 = false
    local v2 = 0
    local v3 = p2
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        v2 = v2 + 1
        if getSystem(j) then
            v1 = true
            p1:addSystem(j, p3)
        end
    end
    if v2 == 0 then
        error("Empty table passed to Scheduler:addSystems({ }, phase?)")
    end
    if not v1 then
        error("Unknown table passed to Scheduler:addSystems({ unknown }, phase?)")
    end
    return p1
end
function u39.editSystem(p1, p2, p3) -- Line: 597 -- upvalues: getSystem (val)
    local v1
    local v2 = getSystem(p2)
    local v3 = p1._systemInfo[v2]
    assert(v3, "Attempt to remove a non-exist system in Scheduler:removeSystem(_)")
    if not p3 then
        v1 = true
    else
        v1 = if p1._phaseToSystems[p3] == nil then true else true
    end
    assert(v1, "Phase never initialized before using Scheduler:editSystem(_, Phase)")
    local v4 = p1._phaseToSystems[v3.phase]
    v1 = table.find(v4, v2)
    assert(v1, "Unable to find system within phase")
    table.remove(v4, v1)
    if not (p1._phaseToSystems[p3]) then
        p1._phaseToSystems[p3] = {}
    end
    table.insert(p1._phaseToSystems[p3], v2)
    v3.phase = p3
    return p1
end
function u39:_removeCondition(p2, p3) -- Line: 626 -- upvalues: conditions (val)
    self._runIfConditions[p2] = nil
    local _runIfConditions = self._runIfConditions
    local v1 = nil
    local v2 = nil
    for i, j in _runIfConditions, v1, v2 do
        if table.find(j, p3) then
            return
        end
    end
    conditions.cleanupCondition(p3)
end
function u39.removeSystem(p1, p2) -- Line: 643 -- upvalues: getSystem (val), hooks (val)
    local v1 = getSystem(p2)
    local v2 = p1._systemInfo[v1]
    assert(v2, "Attempt to remove a non-exist system in Scheduler:removeSystem(_)")
    local v3 = p1._phaseToSystems[v2.phase]
    local v4 = table.find(v3, v1)
    assert(v4, "Unable to find system within phase")
    table.remove(v3, v4)
    p1._systemInfo[v1] = nil
    if p1._runIfConditions[p2] then
        local v5 = p1._runIfConditions[p2]
        local v6 = nil
        local v7 = nil
        for i, j in v5, v6, v7 do
            p1:_removeCondition(p2, j)
        end
        p1._runIfConditions[p2] = nil
    end
    hooks.systemRemove(p1, v2)
    return p1
end
function u39.replaceSystem(p1, p2, p3) -- Line: 678 -- upvalues: getSystem (val), getSystemName (val), hooks (val)
    local v1 = getSystem(p2)
    local v2 = p1._systemInfo[v1]
    assert(v2, "Attempt to replace a non-existent system in Scheduler:replaceSystem(unknown, _)")
    local v3 = getSystem(p3)
    assert(v3, "Attempt to pass non-system in Scheduler:replaceSystem(_, unknown)")
    local v4 = p1._phaseToSystems[v2.phase]
    local v5 = table.find(v4, v1)
    assert(v5, "Unable to find system within phase")
    table.remove(v4, v5)
    table.insert(v4, v5, v3)
    local v6 = table.clone(v2)
    v2.system = v3
    v2.name = getSystemName(v3)
    hooks.systemReplace(p1, v6, v2)
    p1._systemInfo[v3] = p1._systemInfo[v1]
    p1._systemInfo[v1] = nil
    return p1
end
function u39:addRunCondition(p2, p3) -- Line: 737 -- upvalues: getSystem (val), isPhase (val), isPipeline (val)
    local v1
    local v2 = getSystem(p2)
    if not v2 then
        v1 = p2
    else
        v1 = v2
    end
    local v3 = v2
    if not v3 then
        v3 = isPhase(v1)
        if not v3 then
            v3 = isPipeline(v1)
        end
    end
    assert(v3, "Attempt to pass unknown dependent into Scheduler:addRunCondition(unknown, _)")
    if not (self._runIfConditions[v1]) then
        self._runIfConditions[v1] = {}
    end
    table.insert(self._runIfConditions[v1], p3)
    return self
end
function u39:_addBuiltins() -- Line: 757 -- upvalues: Phase (val), DependencyGraph (val), Pipeline (val), conditions (val)
    self._defaultPhase = Phase.new("Default")
    self._defaultDependencyGraph = DependencyGraph.new()
    self._defaultDependencyGraph:insert(Pipeline.Startup)
    self._defaultDependencyGraph:insert(self._defaultPhase)
    self:addRunCondition(Pipeline.Startup, conditions.runOnce())
    local nodes = Pipeline.Startup.dependencyGraph.nodes
    local v1 = nil
    local v2 = nil
    for i, j in nodes, v1, v2 do
        self:addRunCondition(j, conditions.runOnce())
    end
end
function u39:_scheduleEvent(p2, p3) -- Line: 770 -- upvalues: utils (val), getEventIdentifier (val), DependencyGraph (val), u36 (ref)
    local v1 = utils.getConnectFunction(p2, p3)
    assert(v1, "Couldn't connect to event as no valid connect methods were found! Ensure the passed event has a 'Connect' or an 'on' method!")
    local u15 = getEventIdentifier(p2, p3)
    local u18 = DependencyGraph.new()
    local _connectedEvents = self._connectedEvents
    _connectedEvents[u15] = v1(function() -- Line: 781 -- upvalues: u18 (val), u15 (val), u36 (upval), self (val)
        local v1
        local v2 = u18:getOrderedList()
        if v2 == nil then
            v1 = ("Event Group '%*' contains a circular dependency, check your Pipelines/Phases"):format(u15)
            if not (u36[v1]) then
                task.spawn(error, v1, 0)
                warn("Planck: Error occurred while running event, this error will be ignored for 10 seconds")
                u36[v1] = true
            end
        end
        v1 = v2
        local v3 = nil
        local v4 = nil
        for i, j in v1, v3, v4 do
            self:run(j)
        end
    end)
    self._eventDependencyGraphs[u15] = u18
end
function u39:_getEventDependencyGraph(p2, p3) -- Line: 805 -- upvalues: getEventIdentifier (val)
    local v1 = getEventIdentifier(p2, p3)
    if not (self._connectedEvents[v1]) then
        self:_scheduleEvent(p2, p3)
    end
    return self._eventDependencyGraphs[v1]
end
function u39:_getGraphOfDependency(p2) -- Line: 815
    if table.find(self._defaultDependencyGraph.nodes, p2) then
        return self._defaultDependencyGraph
    end
    local _eventDependencyGraphs = self._eventDependencyGraphs
    local v1 = nil
    local v2 = nil
    for i, j in _eventDependencyGraphs, v1, v2 do
        if table.find(j.nodes, p2) then
            return j
        end
    end
    error("Dependency does not belong to a DependencyGraph")
end
function u39:cleanup() -- Line: 848 -- upvalues: utils (val), conditions (val)
    local v1, v2, v3
    local _connectedEvents = self._connectedEvents
    local v4 = nil
    local v5 = nil
    for i, j in _connectedEvents, v4, v5 do
        utils.disconnectEvent(j)
    end
    local _plugins = self._plugins
    v4 = nil
    v5 = nil
    for k, n in _plugins, v4, v5 do
        if n.cleanup then
            n:cleanup()
        end
    end
    if self._thread then
        coroutine.close(self._thread)
    end
    local _runIfConditions = self._runIfConditions
    v4 = nil
    v5 = nil
    for m, i5 in _runIfConditions, v4, v5 do
        v1 = i5
        v2 = nil
        v3 = nil
        for i6, i7 in v1, v2, v3 do
            conditions.cleanupCondition(i7)
        end
    end
end
function u39.new(...) -- Line: 876 -- upvalues: u39 (val), hooks (val)
    local v1 = {
        _hooks = {},
        _vargs = {...},
        _eventDependencyGraphs = {},
        _connectedEvents = {},
        _phaseToSystems = {},
        _systemInfo = {},
        _runIfConditions = {},
        _plugins = {},
    }
    setmetatable(v1, u39)
    local Hooks = hooks.Hooks
    local v2 = nil
    local v3 = nil
    for i, j in Hooks, v2, v3 do
        if not (v1._hooks[j]) then
            v1._hooks[j] = {}
        end
    end
    v1:_addBuiltins()
    return v1
end
return u39