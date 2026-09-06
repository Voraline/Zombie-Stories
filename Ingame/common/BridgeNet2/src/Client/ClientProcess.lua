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
    start = function() -- Line: 16 -- upvalues: ReplicatedStorage (val), u21 (val), RunService (val), u20 (ref), u19 (val), u22 (val), u18 (val)
        debug.setmemorycategory("BridgeNet2")
        local dataRemoteEvent = ReplicatedStorage:WaitForChild("dataRemoteEvent")
        local metaRemoteEvent = ReplicatedStorage:WaitForChild("metaRemoteEvent")
        dataRemoteEvent.OnClientEvent:Connect(function(p1) -- Line: 24 -- upvalues: u21 (upval)
            table.insert(u21, p1)
        end)
        RunService.PostSimulation:Connect(function() -- Line: 28 -- upvalues: u20 (upval), dataRemoteEvent (val), u19 (upval), u21 (upval), u22 (upval), u18 (upval)
            local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
            debug.profilebegin("BridgeNet2")
            if 0 < u20 then
                dataRemoteEvent:FireServer({table.unpack(u19, 1, u20)})
                u20 = 0
                table.clear(u19)
            end
            debug.profilebegin("BridgeNet2:Receive")
            local v12 = u21
            local v13 = nil
            local v14 = nil
            for i, j in v12, v13, v14 do
                v9 = j
                v10 = nil
                v11 = nil
                for k, n in v9, v10, v11 do
                    v1 = u22[k]
                    if v1 then
                        if #v1 ~= 1 then
                            v2 = n
                            v3 = nil
                            v4 = nil
                            for m, i5 in v2, v3, v4 do
                                v6 = v1
                                v7 = nil
                                v8 = nil
                                for i6, i7 in v6, v7, v8 do
                                    u18(i7, i5)
                                end
                            end
                        else
                            v3 = n
                            v4 = nil
                            v5 = nil
                            for i8, i9 in v3, v4, v5 do
                                u18(v1[1], i9)
                            end
                        end
                    end
                end
            end
            table.clear(u21)
            debug.profileend()
        end)
        task.spawn(function() -- Line: 69 -- upvalues: metaRemoteEvent (val)
            local v1 = 15
            local v2 = 1
            for i = 1, v1, v2 do
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
        table.insert(u22[p1], p2)
        return function() -- Line: 99 -- upvalues: u22 (upval), p1 (val), p2 (val)
            local v1 = table.find(u22[p1], p2)
            table.remove(u22[p1], v1)
        end
    end,
}