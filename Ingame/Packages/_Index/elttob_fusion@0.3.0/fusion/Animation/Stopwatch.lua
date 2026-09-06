local Parent = script.Parent.Parent
require(Parent.Types)
local checkLifetime = require(Parent.Memory.checkLifetime)
local depend = require(Parent.Graph.depend)
local change = require(Parent.Graph.change)
local peek = require(Parent.State.peek)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {type = "State", kind = "Stopwatch", timeliness = "lazy"}
local u32 = table.freeze({__index = v1})
function v1.zero(p1) -- Line: 81 -- upvalues: peek (val), change (val)
    local v1 = peek(p1._timer)
    if v1 ~= p1._measureTimeSince then
        p1._measureTimeSince = v1
        p1._EXTREMELY_DANGEROUS_usedAsValue = 0
        change(p1)
    end
end
function v1.pause(p1) -- Line: 92 -- upvalues: change (val)
    if p1._playing == true then
        p1._playing = false
        change(p1)
    end
end
function v1.unpause(p1) -- Line: 101 -- upvalues: peek (val), change (val)
    if p1._playing == false then
        p1._playing = true
        local v1 = peek(p1._timer)
        p1._measureTimeSince = v1 - p1._EXTREMELY_DANGEROUS_usedAsValue
        change(p1)
    end
end
function v1._evaluate(p1) -- Line: 111 -- upvalues: depend (val), peek (val)
    if not p1._playing then
        return false
    end
    depend(p1, p1._timer)
    local v1 = peek(p1._timer)
    local _EXTREMELY_DANGEROUS_usedAsValue = p1._EXTREMELY_DANGEROUS_usedAsValue
    local v2 = v1 - p1._measureTimeSince
    p1._EXTREMELY_DANGEROUS_usedAsValue = v2
    local v3 = _EXTREMELY_DANGEROUS_usedAsValue ~= v2
    return v3
end
table.freeze(v1)
return function(p1, p2) -- Line: 44 -- upvalues: u32 (val), nicknames (val), checkLifetime (val), depend (val)
    local u9 = setmetatable({
        awake = true,
        validity = "invalid",
        _EXTREMELY_DANGEROUS_usedAsValue = 0,
        _measureTimeSince = 0,
        _playing = false,
        createdAt = os.clock(),
        dependencySet = {},
        dependentSet = {},
        scope = p1,
        _timer = p2,
    }, u32)
    local function v1() -- Line: 65 -- upvalues: u9 (val)
        u9.scope = nil
    end
    u9.oldestTask = v1
    nicknames[u9.oldestTask] = "Stopwatch"
    table.insert(p1, v1)
    checkLifetime.bOutlivesA(p1, u9.oldestTask, p2.scope, p2.oldestTask, checkLifetime.formatters.parameter, "timer")
    depend(u9, p2)
    return u9
end