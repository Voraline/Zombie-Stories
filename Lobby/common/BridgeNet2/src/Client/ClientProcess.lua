local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require("../Types")
require("../Utilities/Output")
local u18 = require("../Utilities/RecycledSpawn")
local u19 = {}
local u20 = 0
local u21 = {}
local u22 = {}
return {
    start = function() -- Line: 16
        -- upvalues: ReplicatedStorage (val), u21 (val), RunService (val), u20 (ref), u19 (val), u22 (val), u18 (val)
        debug.setmemorycategory("BridgeNet2")
        local dataRemoteEvent = ReplicatedStorage:WaitForChild("dataRemoteEvent")
        local metaRemoteEvent = ReplicatedStorage:WaitForChild("metaRemoteEvent")
        dataRemoteEvent.OnClientEvent:Connect(function(p1) -- Line: 24 -- upvalues: u21 (upval)
            local v1 = u21
            table.insert(v1, p1)
        end)
        local v1 = RunService
        v1.PostSimulation:Connect(function() -- Line: 28
            -- upvalues: u20 (upval), dataRemoteEvent (val), u19 (upval), u21 (upval), u22 (upval), u18 (upval)
            local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13
            debug.profilebegin("BridgeNet2")
            if 0 < u20 then
                v1 = dataRemoteEvent
                v10 = {}
                local v14 = u19
                v12 = u20
                v10[1] = table.unpack(v14, 1, v12)
                v1:FireServer(v10)
                u20 = 0
                table.clear(u19)
            end
            debug.profilebegin("BridgeNet2:Receive")
            v1 = u21
            local v15 = nil
            v10 = nil
            for i, j in v1, v15, v10 do
                v11 = j
                v12 = nil
                v13 = nil
                for k, n in v11, v12, v13 do
                    v2 = u22[k]
                    if v2 then
                        if #v2 ~= 1 then
                            v3 = n
                            v4 = nil
                            v5 = nil
                            for m, i5 in v3, v4, v5 do
                                v7 = v2
                                v8 = nil
                                v9 = nil
                                for i6, i7 in v7, v8, v9 do
                                    u18(i7, i5)
                                end
                            end
                        else
                            v3 = v2[1]
                            v4 = n
                            v5 = nil
                            v6 = nil
                            for i8, i9 in v4, v5, v6 do
                                u18(v3, i9)
                            end
                        end
                    end
                end
            end
            table.clear(u21)
            debug.profileend()
        end)
        task.spawn(function() -- Line: 69 -- upvalues: metaRemoteEvent (val)
            for i = 1, 15 do
                task.wait()
            end
            metaRemoteEvent:FireServer("1")
        end)
    end,
    registerBridge = function(p1) -- Line: 82 -- upvalues: u22 (val)
        u22[p1] = {}
    end,
    addToQueue = function(p1, p2) -- Line: 86 -- upvalues: u19 (val), u20 (ref)
        u19[u20 + 1] = p2
        u19[u20 + 2] = p1
        u20 = u20 + 2
    end,
    connect = function(p1, p2) -- Line: 95 -- upvalues: u22 (val)
        local v1 = u22[p1]
        table.insert(v1, p2)
        return function() -- Line: 99 -- upvalues: u22 (upval), p1 (val), p2 (val)
            local v1 = table.find(u22[p1], p2)
            table.remove(u22[p1], v1)
        end
    end,
}