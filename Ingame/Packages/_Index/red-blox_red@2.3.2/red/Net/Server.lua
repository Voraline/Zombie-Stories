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
    if not (u42[p1]) then
        u42[p1] = {Reliable = {}, CallReturn = {}}
    end
    u42[p1].CallReturn[p2] = p3
end
local v1 = {
    SendReliableEvent = function(p1, p2, p3) -- Line: 20 -- upvalues: u42 (val)
        if not (u42[p1]) then
            u42[p1] = {Reliable = {}, CallReturn = {}}
        end
        if not (u42[p1].Reliable[p2]) then
            u42[p1].Reliable[p2] = {}
        end
        table.insert(u42[p1].Reliable[p2], p3)
    end,
    SendUnreliableEvent = function(p1, p2, p3) -- Line: 35 -- upvalues: UnreliableRedEvent (val)
        UnreliableRedEvent:FireClient(p1, p2, p3)
    end,
    SetListener = function(p1, p2) -- Line: 39 -- upvalues: u41 (val)
        u41[p1] = p2
    end,
    SendCallReturn = SendCallReturn,
}
function v1.Start() -- Line: 54 -- upvalues: ReliableRedEvent (val), u32 (val), u41 (val), u40 (val), SendCallReturn (val), UnreliableRedEvent (val), RunService (val), u42 (val)
    ReliableRedEvent.OnServerEvent:Connect(function(p1, p2, p3) -- Line: 55 -- upvalues: u32 (upval), u41 (upval), u40 (upval), SendCallReturn (upval)
        local v1, v2, v3, v4, v5, v6, v7, v8, v9
        v5, v6 = u32(p2)
        if not v5 then
            v4, v1 = p3, p1
        else
            local v10, v11
            v7 = v6
            v8 = nil
            v9 = nil
            v1, v4 = p1, p3
            for i, j in v7, v8, v9 do
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
        v7, v8 = u40(v4)
        if v7 then
            local v12, v13
            v9 = v8
            local v14 = nil
            local v15 = nil
            for m, i5 in v9, v14, v15 do
                v2 = u41[m]
                if not v2 then
                    v3 = i5
                    v12 = nil
                    v13 = nil
                    for i6, i7 in v3, v12, v13 do
                        SendCallReturn(v1, i7[1], {false, "Event has no listener."})
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
    UnreliableRedEvent.OnServerEvent:Connect(function(p1, p2, p3) -- Line: 91 -- upvalues: u41 (upval)
        if type(p2) == "string" and type(p3) == "table" then
            local v1 = u41[p2]
            if v1 then
                v1(p1, p3)
            end
        end
    end)
    RunService.Heartbeat:Connect(function() -- Line: 101 -- upvalues: u42 (upval), ReliableRedEvent (upval)
        local v1 = u42
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            if next(j.Reliable) then
                ReliableRedEvent:FireClient(i, j.Reliable, j.CallReturn)
            elseif not (next(j.CallReturn)) then
            end
            u42[i] = nil
        end
    end)
end
return v1