local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local checkLifetime = require(Parent.Memory.checkLifetime)
local castToState = require(Parent.State.castToState)
local u17 = {}
return function(p1) -- Line: 21 -- upvalues: u17 (val), castToState (val), External (val), checkLifetime (val)
    local v1 = u17[p1]
    if v1 == nil then
        u17[p1] = {
            type = "SpecialKey",
            kind = "AttributeOut",
            stage = "observer",
            apply = function(a1, p2, p3, p4) -- Line: 30 -- upvalues: p1 (val), castToState (upval), External (upval), checkLifetime (upval)
                local AttributeChangedSignal = p4:GetAttributeChangedSignal(p1)
                if not (castToState(p3)) then
                    External.logError("invalidAttributeOutType")
                end
                if p3.kind ~= "Value" then
                    External.logError("invalidAttributeOutType")
                end
                checkLifetime.bOutlivesA(p2, p4, p3.scope, p3.oldestTask, checkLifetime.formatters.attributeOutputsTo, p1)
                p3:set(p4:GetAttribute(p1))
                table.insert(p2, AttributeChangedSignal:Connect(function() -- Line: 53 -- upvalues: p3 (val), p4 (val), p1 (upval)
                    p3:set(p4:GetAttribute(p1))
                end))
            end,
        }
    end
    return v1
end