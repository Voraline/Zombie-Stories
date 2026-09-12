local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ReliableRedEvent = ReplicatedStorage:WaitForChild("ReliableRedEvent")
local UnreliableRedEvent = ReplicatedStorage:WaitForChild("UnreliableRedEvent")
local u18 = {}
local u19 = {}
local u20 = {Reliable = {}, Call = {}}
return {
    SendReliableEvent = function(p1, p2) -- Line: 17 -- upvalues: u20 (val)
        if not u20.Reliable[p1] then
            u20.Reliable[p1] = {}
        end
        local v1 = u20.Reliable[p1]
        table.insert(v1, p2)
    end,
    SendUnreliableEvent = function(p1, p2) -- Line: 25 -- upvalues: UnreliableRedEvent (val)
        UnreliableRedEvent:FireServer(p1, p2)
    end,
    SetListener = function(p1, p2) -- Line: 29 -- upvalues: u18 (val)
        u18[p1] = p2
    end,
    CallAsync = function(p1, p2) -- Line: 33 -- upvalues: u20 (val), u19 (val)
        if not u20.Call[p1] then
            u20.Call[p1] = {}
        end
        local v1 = u20.Call[p1]
        table.insert(v1, p2)
        u19[p2[1]] = (coroutine.running())
        return coroutine.yield()
    end,
    Start = function() -- Line: 44
        -- upvalues: ReliableRedEvent (val), u18 (val), u19 (val), UnreliableRedEvent (val), RunService (val), u20 (val)
        local v1 = ReliableRedEvent
        v1.OnClientEvent:Connect(function(p1, p2) -- Line: 45 -- upvalues: u18 (upval), u19 (upval)
            local v1, v2, v3, v4, v5
            if not p1 then
                v1 = p2
            else
                local v6, v7, v8
                v2 = p1
                v3 = nil
                v4 = nil
                v1 = p2
                for i, j in v2, v3, v4 do
                    v5 = u18[i]
                    if v5 then
                        v7 = j
                        v8 = nil
                        v6 = nil
                        for k, n in v7, v8, v6 do
                            v5(n)
                        end
                    end
                end
            end
            if v1 then
                v2 = v1
                v3 = nil
                v4 = nil
                for m, i5 in v2, v3, v4 do
                    v5 = u19[m]
                    if v5 then
                        u19[m] = nil
                        coroutine.resume(v5, i5)
                    end
                end
            end
        end)
        v1 = UnreliableRedEvent
        v1.OnClientEvent:Connect(function(p1, p2) -- Line: 70 -- upvalues: u18 (upval)
            local v1 = u18[p1]
            if v1 then
                v1(p2)
            end
        end)
        v1 = RunService
        v1.Heartbeat:Connect(function() -- Line: 78 -- upvalues: u20 (upval), ReliableRedEvent (upval)
            if next(u20.Reliable) or next(u20.Call) then
                local v1 = ReliableRedEvent
                local v2 = u20
                local Reliable = v2.Reliable
                local v3 = u20
                local Call = v3.Call
                v1:FireServer(Reliable, Call)
                u20.Reliable = {}
                u20.Call = {}
            end
        end)
    end,
}