local Players = game:GetService("Players")
local Spawn = require(script.Parent.Parent.Parent.Spawn)
local Net = require(script.Parent.Parent.Net)
local function Fire(p1, p2, ...) -- Line: 22 -- upvalues: Net (val)
    if p1.Unreliable then
        Net.Server.SendUnreliableEvent(p2, p1.Id, table.pack(...))
        return
    end
    Net.Server.SendReliableEvent(p2, p1.Id, table.pack(...))
end
local function FireAll(p1, ...) -- Line: 30 -- upvalues: Players (val), Net (val)
    local v1 = table.pack(...)
    for i, j in Players:GetPlayers() do
        if not p1.Unreliable then
            Net.Server.SendReliableEvent(j, p1.Id, v1)
        else
            Net.Server.SendUnreliableEvent(j, p1.Id, v1)
        end
    end
end
local function FireAllExcept(p1, p2, ...) -- Line: 42 -- upvalues: Players (val), Net (val)
    local v1 = table.pack(...)
    for i, j in Players:GetPlayers() do
        if j ~= p2 then
            if not p1.Unreliable then
                Net.Server.SendReliableEvent(j, p1.Id, v1)
            else
                Net.Server.SendUnreliableEvent(j, p1.Id, v1)
            end
        end
    end
end
local function FireList(p1, p2, ...) -- Line: 56 -- upvalues: Net (val)
    local v1 = table.pack(...)
    local v2 = p2
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if not p1.Unreliable then
            Net.Server.SendReliableEvent(j, p1.Id, v1)
        else
            Net.Server.SendUnreliableEvent(j, p1.Id, v1)
        end
    end
end
local function FireWithFilter(p1, p2, ...) -- Line: 68 -- upvalues: Players (val), Net (val)
    local v1 = table.pack(...)
    for i, j in Players:GetPlayers() do
        if p2(j) then
            if not p1.Unreliable then
                Net.Server.SendReliableEvent(j, p1.Id, v1)
            else
                Net.Server.SendUnreliableEvent(j, p1.Id, v1)
            end
        end
    end
end
local function On(p1, p2) -- Line: 82 -- upvalues: Net (val), Spawn (val)
    Net.Server.SetListener(p1.Id, function(a1, a2) -- Line: 83 -- upvalues: Spawn (upval), p2 (val), p1 (val)
        Spawn(function(p1, a2, ...) -- Line: 84 -- upvalues: p2 (upval)
            if pcall(p1.Validate, ...) then
                p2(a2, ...)
            end
        end, p1, a1, table.unpack(a2))
    end)
end
return function(p1, p2, p3) -- Line: 92 -- upvalues: Fire (val), FireAll (val), FireAllExcept (val), FireList (val), FireWithFilter (val), On (val)
    return {
        Id = p1,
        Validate = p2,
        Unreliable = p3,
        Fire = Fire,
        FireAll = FireAll,
        FireAllExcept = FireAllExcept,
        FireList = FireList,
        FireWithFilter = FireWithFilter,
        On = On,
    }
end