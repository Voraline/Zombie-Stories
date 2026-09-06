local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local checkLifetime = require(Parent.Memory.checkLifetime)
local castToState = require(Parent.State.castToState)
local u17 = {}
return function(p1) -- Line: 21 -- upvalues: u17 (val), External (val), castToState (val), checkLifetime (val)
    local v1 = u17[p1]
    if v1 == nil then
        u17[p1] = {
            type = "SpecialKey",
            kind = "Out",
            stage = "observer",
            apply = function(a1, p2, p3, p4) -- Line: 30 -- upvalues: p1 (val), External (upval), castToState (upval), checkLifetime (upval)
                local v1, v2
                v1, v2 = pcall(p4.GetPropertyChangedSignal, p4, p1)
                if not v1 then
                    External.logError("invalidOutProperty", nil, p4.ClassName, p1)
                end
                if not (castToState(p3)) then
                    External.logError("invalidOutType")
                end
                if p3.kind ~= "Value" then
                    External.logError("invalidOutType")
                end
                checkLifetime.bOutlivesA(p2, p4, p3.scope, p3.oldestTask, checkLifetime.formatters.propertyOutputsTo, p1)
                p3:set(p4[p1])
                table.insert(p2, v2:Connect(function() -- Line: 58 -- upvalues: p3 (val), p4 (val), p1 (upval)
                    p3:set(p4[p1])
                end))
            end,
        }
    end
    return v1
end