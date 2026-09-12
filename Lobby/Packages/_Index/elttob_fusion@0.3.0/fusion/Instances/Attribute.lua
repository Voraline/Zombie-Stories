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
        v1 = {
            type = "SpecialKey",
            kind = "Attribute",
            stage = "self",
            apply = function(p1_2, p2, p3, p4) -- Line: 32
                -- upvalues: castToState (upval), checkLifetime (upval), p1 (val), Observer (upval), peek (upval)
                if castToState(p3) then
                    checkLifetime.bOutlivesA(
                        p2,
                        p4,
                        p3.scope,
                        p3.oldestTask,
                        checkLifetime.formatters.boundAttribute,
                        p1
                    )
                    ;(Observer(p2, p3)):onBind(function() -- Line: 45 -- upvalues: p4 (val), p1 (upval), peek (upval), p3 (val)
                        local v1 = p4
                        local v2 = p1
                        local v3 = peek
                        local v4 = p3
                        v3 = v3(v4)
                        v1:SetAttribute(v2, v3)
                    end)
                    return
                end
                local v1 = p1
                p4:SetAttribute(v1, p3)
            end,
        }
        u22[p1] = v1
    end
    return v1
end