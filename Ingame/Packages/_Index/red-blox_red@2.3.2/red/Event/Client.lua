local Spawn = require(script.Parent.Parent.Parent.Spawn)
local Net = require(script.Parent.Parent.Net)

local function Fire(p1, ...) -- Line: 14 -- upvalues: Net (val)
    if p1.Unreliable then
        Net.Client.SendUnreliableEvent(p1.Id, table.pack(...))
        return
    end
    Net.Client.SendReliableEvent(p1.Id, table.pack(...))
end

local function On(p1, p2) -- Line: 22 -- upvalues: Net (val), Spawn (val)
    local v1 = Net
    v1.Client.SetListener(p1.Id, function(p1) -- Line: 23 -- upvalues: Spawn (upval), p2 (val)
        Spawn(p2, table.unpack(p1))
    end)
end

return function(p1, p2) -- Line: 28 -- upvalues: Fire (val), On (val)
    return {Id = p1, Unreliable = p2, Fire = Fire, On = On}
end