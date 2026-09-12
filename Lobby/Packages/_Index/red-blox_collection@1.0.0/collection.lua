local CollectionService = game:GetService("CollectionService")
local Spawn = require(script.Parent.Spawn)
return function(p1, p2) -- Line: 5 -- upvalues: CollectionService (val), Spawn (val)
    local v1
    local u2 = {}
    for i, j in CollectionService:GetTagged(p1) do
        v1 = Spawn
        v1(function() -- Line: 9 -- upvalues: u2 (val), j (val), p2 (val)
            u2[j] = (p2(j))
        end)
    end
    local u28 = (CollectionService:GetInstanceAddedSignal(p1)):Connect(function(p1) -- Line: 14 -- upvalues: u2 (val), p2 (val)
        u2[p1] = (p2(p1))
    end)
    local u37 = (CollectionService:GetInstanceRemovedSignal(p1)):Connect(function(p1) -- Line: 18 -- upvalues: u2 (val)
        local v1 = u2[p1]
        if v1 then
            u2[p1] = nil
            v1()
        end
    end)
    return function() -- Line: 27 -- upvalues: u28 (val), u37 (val), u2 (val), Spawn (upval)
        u28:Disconnect()
        u37:Disconnect()
        local v1 = u2
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            Spawn(j)
        end
    end
end