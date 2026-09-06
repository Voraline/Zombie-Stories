local Parent = script.Parent.Parent
require(Parent.Types)
local checkLifetime = require(Parent.Memory.checkLifetime)
local Observer = require(Parent.Graph.Observer)
local castToState = require(Parent.State.castToState)
local peek = require(Parent.State.peek)
local u22 = {}
return function(p1) -- Line: 23 -- upvalues: u22 (val), castToState (val), checkLifetime (val), Observer (val), peek (val)
    local v1 = u22[p1]
    if v1 == nil then
        u22[p1] = {
            type = "SpecialKey",
            kind = "Attribute",
            stage = "self",
            apply = function(a1, p2, p3, p4) -- Line: 32 -- upvalues: castToState (upval), checkLifetime (upval), p1 (val), Observer (upval), peek (upval)
                if not (castToState(p3)) then
                    p4:SetAttribute(p1, p3)
                    return
                end
                checkLifetime.bOutlivesA(p2, p4, p3.scope, p3.oldestTask, checkLifetime.formatters.boundAttribute, p1)
                local v1 = Observer(p2, p3)
                v1:onBind(function() -- Line: 45 -- upvalues: p4 (val), p1 (upval), peek (upval), p3 (val)
                    p4:SetAttribute(p1, peek(p3))
                end)
            end,
        }
    end
    return v1
end