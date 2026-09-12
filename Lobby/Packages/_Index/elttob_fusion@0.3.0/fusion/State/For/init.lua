local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local depend = require(Parent.Graph.depend)
local peek = require(Parent.State.peek)
local castToState = require(Parent.State.castToState)
require(Parent.State.For.ForTypes)
local never = require(Parent.Utility.never)
local nicknames = require(Parent.Utility.nicknames)
local Disassembly = require(Parent.State.For.Disassembly)
local v1 = {type = "State", kind = "For", timeliness = "lazy"}
local u45 = table.freeze({__index = v1})

function v1.get(p1) -- Line: 76 -- upvalues: External (val), never (val)
    External.logError("stateGetWasRemoved")
    return never()
end

function v1._evaluate(p1) -- Line: 83 -- upvalues: depend (val), castToState (val), peek (val)
    if p1.scope == nil then
        return false
    end
    local scope = p1.scope
    depend(p1, p1._disassembly)
    table.clear(p1._EXTREMELY_DANGEROUS_usedAsValue)
    local _disassembly = p1._disassembly
    local _EXTREMELY_DANGEROUS_usedAsValue = p1._EXTREMELY_DANGEROUS_usedAsValue
    _disassembly:populate(function(p1_2) -- Line: 94 -- upvalues: castToState (upval), depend (upval), p1 (val), peek (upval)
        local v1 = castToState(p1_2)
        if v1 ~= nil then
            depend(p1, v1)
        end
        return peek(p1_2)
    end, _EXTREMELY_DANGEROUS_usedAsValue)
    return true
end

table.freeze(v1)
return function(p1, p2, p3) -- Line: 36 -- upvalues: Disassembly (val), u45 (val), nicknames (val)
    local v1 = {
        validity = "invalid",
        createdAt = os.clock(),
        dependencySet = {},
        dependentSet = {},
        scope = p1,
        _EXTREMELY_DANGEROUS_usedAsValue = {},
        _disassembly = Disassembly(p1, p2, p3),
    }
    local v2 = u45
    local u16 = setmetatable(v1, v2)

    function v1() -- Line: 63 -- upvalues: u16 (val)
        u16.scope = nil
        for k in pairs(u16.dependencySet) do
            k.dependentSet[u16] = nil
        end
    end

    u16.oldestTask = v1
    nicknames[u16.oldestTask] = "For"
    table.insert(p1, v1)
    return u16
end