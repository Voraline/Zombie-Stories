local CollectionService = game:GetService("CollectionService")
require("./types/fusion")
local u13 = require(script.Parent.utils["lock-value"])
local u18 = require(script.Parent["use-event-listener"])
return function(p1, p2) -- Line: 13 -- upvalues: CollectionService (val), u18 (val), u13 (val)
    local peek = p1.peek
    local Tagged = CollectionService:GetTagged(p2)
    local u10 = p1:Value(Tagged)
    local v1 = u18
    local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal(p2)
    v1(p1, InstanceAddedSignal, function(p1) -- Line: 17 -- upvalues: peek (val), u10 (val)
        local v1 = table.clone(peek(u10))
        table.insert(v1, p1)
        u10:set(v1)
    end)
    v1 = u18
    local InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal(p2)
    v1(p1, InstanceRemovedSignal, function(p1) -- Line: 23 -- upvalues: peek (val), u10 (val)
        local v1 = table.clone(peek(u10))
        local v2 = table.find(v1, p1)
        if v2 then
            table.remove(v1, v2)
        end
        u10:set(v1)
    end)
    return u13(u10)
end