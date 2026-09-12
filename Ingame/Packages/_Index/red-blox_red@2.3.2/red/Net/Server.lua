local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Guard = require(script.Parent.Parent.Parent.Guard)
local ReliableRedEvent = ReplicatedStorage:WaitForChild("ReliableRedEvent")
local UnreliableRedEvent = ReplicatedStorage:WaitForChild("UnreliableRedEvent")
local u32 = Guard.Check(Guard.Map(Guard.String, Guard.List(Guard.Any)))
local u40 = Guard.Check(Guard.Map(Guard.String, Guard.List(Guard.Any)))
local u41 = {}
local u42 = {}

local function SendCallReturn(p1, p2, p3) -- Line: 43 -- upvalues: u42 (val)
    if not u42[p1] then
        local v1 = u42
        v1[p1] = {Reliable = {}, CallReturn = {}}
    end
    u42[p1].CallReturn[p2] = p3
end

return {
    SendReliableEvent = function(p1, p2, p3) -- Line: 20 -- upvalues: u42 (val)
        if not u42[p1] then
            local v1 = u42
            v1[p1] = {Reliable = {}, CallReturn = {}}
        end
        if not u42[p1].Reliable[p2] then
            u42[p1].Reliable[p2] = {}
        end
        local v2 = u42[p1].Reliable[p2]
        table.insert(v2, p3)
    end,
    SendUnreliableEvent = function(p1, p2, p3) -- Line: 35 -- upvalues: UnreliableRedEvent (val)
        UnreliableRedEvent:FireClient(p1, p2, p3)
    end,
    SetListener = function(p1, p2) -- Line: 39 -- upvalues: u41 (val)
        u41[p1] = p2
    end,
    SendCallReturn = SendCallReturn,
    Start = function() -- Line: 54
        -- upvalues: ReliableRedEvent (val), u32 (val), u41 (val), u40 (val), SendCallReturn (val)
        -- upvalues: UnreliableRedEvent (val), RunService (val), u42 (val)
        local v1 = ReliableRedEvent
        v1.OnServerEvent:Connect(function(p1, p2, p3) -- Line: 55 -- upvalues: u32 (upval), u41 (upval), u40 (upval), SendCallReturn (upval)
            local v1, v2, v3, v4, v5, v6, v7
            local v8, v9 = u32(p2)
            if not v8 then
                v4, v1 = p3, p1
            else
                local v10, v11
                v5 = v9
                v6 = nil
                v7 = nil
                v1, v4 = p1, p3
                for i, j in v5, v6, v7 do
                    v10 = u41[i]
                    if v10 then
                        v11 = j
                        v2 = nil
                        v3 = nil
                        for k, n in v11, v2, v3 do
                            v10(v1, n)
                        end
                    end
                end
            end
            v5, v6 = u40(v4)
            if v5 then
                local v12, v13, v14, v15
                v7 = v6
                local v16 = nil
                local v17 = nil
                for m, i5 in v7, v16, v17 do
                    v2 = u41[m]
                    if not v2 then
                        v3 = i5
                        v12 = nil
                        v13 = nil
                        for i6, i7 in v3, v12, v13 do
                            v14 = i7[1]
                            v15 = SendCallReturn
                            v15(v1, v14, {false, "Event has no listener."})
                        end
                    else
                        v3 = i5
                        v12 = nil
                        v13 = nil
                        for i8, i9 in v3, v12, v13 do
                            v2(v1, i9)
                        end
                    end
                end
            end
        end)
        v1 = UnreliableRedEvent
        v1.OnServerEvent:Connect(function(p1, p2, p3) -- Line: 91 -- upvalues: u41 (upval)
            if type(p2) == "string" and type(p3) == "table" then
                local v1 = u41[p2]
                if v1 then
                    v1(p1, p3)
                end
            end
        end)
        v1 = RunService
        v1.Heartbeat:Connect(function() -- Line: 101 -- upvalues: u42 (upval), ReliableRedEvent (upval)
            local CallReturn, Reliable, v1
            local v2 = u42
            local v3 = nil
            local v4 = nil
            for i, j in v2, v3, v4 do
                if next(j.Reliable) or next(j.CallReturn) then
                    v1 = ReliableRedEvent
                    Reliable = j.Reliable
                    CallReturn = j.CallReturn
                    v1:FireClient(i, Reliable, CallReturn)
                end
                u42[i] = nil
            end
        end)
    end,
}