local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local u17 = require("./HandleInvalidPlayer")
require("../Utilities/Output")
local u23 = require("../../TableKit")
require("../Types")
local u29 = require("../Utilities/RecycledSpawn")
local u30 = {}
local u31 = {}
local u32 = {}
local u33 = {}
local u34 = {}
local u35 = {}

local function playerAdded(p1) -- Line: 21 -- upvalues: u30 (val), u31 (val), u32 (val), u34 (val)
    u30[p1] = true
    u31[p1] = 0
    u32[p1] = {}
    u34[p1] = {}
end

return {
    start = function() -- Line: 38
        -- upvalues: ReplicatedStorage (val), Players (val), playerAdded (val), u30 (val), u31 (val), u32 (val)
        -- upvalues: u34 (val), u17 (ref), RunService (val), u33 (val), u23 (val), u35 (val), u29 (val)
        task.spawn(function() -- Line: 39
            -- upvalues: ReplicatedStorage (upval), Players (upval), playerAdded (upval), u30 (upval), u31 (upval)
            -- upvalues: u32 (upval), u34 (upval), u17 (upval), RunService (upval), u33 (upval), u23 (upval)
            -- upvalues: u35 (upval), u29 (upval)
            debug.setmemorycategory("BridgeNet2")
            local RemoteEvent_2 = Instance.new("RemoteEvent")
            local RemoteEvent = Instance.new("RemoteEvent")
            RemoteEvent_2.Name = "metaRemoteEvent"
            RemoteEvent.Name = "dataRemoteEvent"
            RemoteEvent_2.Parent = ReplicatedStorage
            RemoteEvent.Parent = ReplicatedStorage
            local v1 = Players
            local PlayerAdded = v1.PlayerAdded
            local v2 = playerAdded
            PlayerAdded:Connect(v2)
            v1 = Players
            v1.PlayerRemoving:Connect(function(p1) -- Line: 55 -- upvalues: u30 (upval), u31 (upval), u32 (upval), u34 (upval)
                u30[p1] = nil
                u31[p1] = nil
                u32[p1] = nil
                u34[p1] = nil
            end)
            RemoteEvent_2.OnServerEvent:Connect(function(p1, p2) -- Line: 63 -- upvalues: u31 (upval), RemoteEvent (val), u32 (upval)
                if p2 == "1" then
                    u31[p1] = nil
                    local v1 = RemoteEvent
                    local v2 = u32
                    local v3 = v2[p1]
                    v1:FireClient(p1, v3)
                    u32[p1] = nil
                end
            end)
            RemoteEvent.OnServerEvent:Connect(function(p1, p2) -- Line: 73 -- upvalues: u17 (upval), u34 (upval)
                if typeof(p2) ~= "table" then
                    u17(p1)
                    return
                end
                local v1 = u34[p1]
                table.insert(v1, p2)
            end)
            local u35_2 = {}

            local function addContentToQueue(p1, p2, p3) -- Line: 85 -- upvalues: u35_2 (val)
                local v1
                local v2 = u35_2[p1]
                if not v2 then
                    local v3 = u35_2
                    v1 = {}
                    v1[p2] = {p3}
                    v3[p1] = v1
                    return
                end
                if not v2[p2] then
                    v2[p2] = {p3}
                    return
                end
                v1 = v2[p2]
                table.insert(v1, p3)
            end

            v2 = RunService
            v2.PostSimulation:Connect(function() -- Line: 101
                -- upvalues: u33 (upval), addContentToQueue (val), u30 (upval), u35_2 (val), u31 (upval), u32 (upval)
                -- upvalues: u23 (upval), RemoteEvent (val), u34 (upval), u17 (upval), u35 (upval), u29 (upval)
                local MergeArrays, content, id, kind, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, value
                debug.profilebegin("BridgeNet2")
                debug.profilebegin("BridgeNet2:Send")
                local v14 = u33
                local v15 = nil
                local v16 = nil
                for i, j in v14, v15, v16 do
                    kind = j.playerContainer.kind
                    value = j.playerContainer.value
                    id = j.id
                    content = j.content
                    if kind == "single" then
                        addContentToQueue(value, id, content)
                    elseif kind == "all" then
                        v13 = u30
                        v1 = nil
                        v2 = nil
                        for i8 in v13, v1, v2 do
                            addContentToQueue(i8, id, content)
                        end
                    elseif kind == "except" then
                        v13 = value
                        v1 = nil
                        v2 = nil
                        for m, i5 in v13, v1, v2 do
                            u30[i5] = false
                        end
                        v13 = u30
                        v1 = nil
                        v2 = nil
                        for i6, i7 in v13, v1, v2 do
                            if not i7 then
                                u30[i6] = true
                            else
                                addContentToQueue(i6, id, content)
                            end
                        end
                    elseif kind == "set" then
                        v13 = value
                        v1 = nil
                        v2 = nil
                        for k, n in v13, v1, v2 do
                            addContentToQueue(n, id, content)
                        end
                    end
                end
                v14 = u35_2
                v15 = nil
                v16 = nil
                for i9, i10 in v14, v15, v16 do
                    if not u31[i9] then
                        RemoteEvent:FireClient(i9, i10)
                    elseif u32[i9] then
                        v10 = i10
                        v11 = nil
                        v12 = nil
                        for i11, i12 in v10, v11, v12 do
                            if u32[i9][i11] then
                                v1 = u32[i9]
                                v2 = u23
                                MergeArrays = v2.MergeArrays
                                v3 = u32[i9][i11]
                                v1[i11] = (MergeArrays(v3, i12))
                            else
                                u32[i9][i11] = i12
                            end
                        end
                    else
                        u32[i9] = i10
                    end
                    u35_2[i9] = nil
                end
                table.clear(u33)
                debug.profileend()
                debug.profilebegin("BridgeNet2:Receive")
                v14 = u34
                v15 = nil
                v16 = nil
                for i13, i14 in v14, v15, v16 do
                    v10 = i14
                    v11 = nil
                    v12 = nil
                    for i15, i16 in v10, v11, v12 do
                        v1 = #i16
                        for i17 = 1, v1, 2 do
                            v4 = i16[i17]
                            v5 = i16[i17 + 1]
                            if typeof(v5) ~= "string" then
                                u17(i13)
                                break
                            end
                            v6 = u35[v5]
                            if v6 then
                                v7 = v6
                                v8 = nil
                                v9 = nil
                                for i18, i19 in v7, v8, v9 do
                                    u29(i19, i13, v4)
                                end
                            end
                        end
                    end
                    table.clear(u34[i13])
                end
                debug.profileend()
                debug.profileend()
            end)
        end)
    end,
    addToQueue = function(p1, p2, p3) -- Line: 212 -- upvalues: u33 (val)
        local v1 = u33
        local v2 = {playerContainer = p1, id = p2, content = p3}
        table.insert(v1, v2)
    end,
    setInvalidPlayerFunction = function(p1) -- Line: 224 -- upvalues: u17 (ref)
        u17 = p1
    end,
    registerBridge = function(p1) -- Line: 228 -- upvalues: u35 (val)
        if not u35[p1] then
            u35[p1] = {}
        end
    end,
    connect = function(p1, p2) -- Line: 234 -- upvalues: u35 (val)
        local v1 = u35[p1]
        table.insert(v1, p2)
        return function() -- Line: 238 -- upvalues: u35 (upval), p1 (val), p2 (val)
            local v1 = table.find(u35[p1], p2)
            table.remove(u35[p1], v1)
        end
    end,
}