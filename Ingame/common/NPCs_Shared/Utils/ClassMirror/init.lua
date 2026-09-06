local addToReflectionQueue, handleReflection
local u7 = game:GetService("RunService"):IsServer()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NPCs_Shared = game.ReplicatedStorage.common:WaitForChild("NPCs_Shared")
local AIClasses = NPCs_Shared:WaitForChild("AIClasses")
local RedEvents = game.ReplicatedStorage.common.RedEvents
local u31 = {}
local function findClientClass(p1) -- Line: 12 -- upvalues: u31 (val), AIClasses (val), ReplicatedStorage (val)
    if u31[p1] then
        return u31[p1]
    end
    local v1 = AIClasses:FindFirstChild(p1)
    if not v1 then
        local AIClasses_2, NPCs_Shared, v2
        local v3 = {"place", "arc", "chapter"}
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            v2 = ReplicatedStorage:FindFirstChild(j)
            if v2 then
                NPCs_Shared = v2:FindFirstChild("NPCs_Shared")
                if NPCs_Shared then
                    AIClasses_2 = NPCs_Shared:FindFirstChild("AIClasses")
                    if AIClasses_2 then
                        v1 = AIClasses_2:FindFirstChild(p1)
                        if v1 then
                            break
                        end
                    end
                end
            end
        end
    end
    if v1 then
        u31[p1] = v1
    end
    return v1
end
local NPCRegistry = require(game.ReplicatedStorage.common.NPCRegistry)
local u38 = require("@self/CompatibilityPatcher")
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local CreateMirrorClassEvent = require(RedEvents.NPC.CreateMirrorClassEvent)
local RequestExistingNPCs = require(RedEvents.NPC.RequestExistingNPCs)
local NPCReflectionEvent = require(RedEvents.NPC.NPCReflectionEvent)
local u57 = {}
local u58 = {}
local u59 = {}
local u60 = {}
local u61 = {}
local u62 = {}
local u63 = {}
if not u7 then
    handleReflection = false
    addToReflectionQueue = 0
    game:GetService("RunService").Heartbeat:Connect(function(p1) -- Line: 60 -- upvalues: GameState (val), NPCRegistry (val), handleReflection (ref), addToReflectionQueue (ref)
        local Rotation, Rotation_2, v1, v2, v3, v4
        debug.profilebegin("Client NPC")
        local NPCRotation = GameState.LocalState.NPCRotation
        local AllNPCs = NPCRegistry:GetAllNPCs()
        handleReflection = not handleReflection
        local v5 = {}
        local v6 = {}
        local v7 = AllNPCs
        local v8 = nil
        local v9 = nil
        local v10 = p1
        for i, j in v7, v8, v9 do
            if j.MoveTo and not j.Ragdolling then
                Rotation = nil
                if j.AlignDirection then
                    Rotation = j.AlignDirection.Rotation
                elseif j.RotateTowards then
                    v1 = Vector3.new(j.RotateTowards.Position.X, j.HRP.Position.Y, j.RotateTowards.Position.Z)
                    v2 = CFrame.new(j.HRP.Position, v1)
                    Rotation = v2 - v2.Position
                end
                if Rotation then
                    if not j.Rotation then
                        j.Rotation = Rotation
                    else
                        j.Rotation = j.Rotation:Lerp(Rotation, v10 * 5)
                    end
                end
                table.insert(v5, j.HRP)
                Rotation_2 = j.Rotation
                if not Rotation_2 then
                    Rotation_2 = CFrame.new()
                end
                v3 = CFrame.new(j.MoveTo) * NPCRotation * Rotation_2
                v4 = v10 * (j.WalkSpeed / 2)
                table.insert(v6, j.HRP.CFrame:Lerp(v3, (math.clamp(v4, 0, 1))))
            end
        end
        if 0 < #v5 then
            workspace:BulkMoveTo(v5, v6, Enum.BulkMoveMode.FireCFrameChanged)
        end
        v7 = v10 + addToReflectionQueue
        v8 = AllNPCs
        v9 = nil
        local v11 = nil
        for k, n in v8, v9, v11 do
            if n.FastThink then
                n:FastThink(v10)
                if not handleReflection then
                    v1 = not handleReflection
                    if v1 then
                        v1 = n.UID % 2 == 0
                    end
                else
                    v1 = true
                    if n.UID % 2 == 1 then end
                end
                if v1 then
                    n:ClientThink(v7)
                end
            end
        end
        addToReflectionQueue = v10
        debug.profileend()
    end)
end
function handleReflection(p1, p2, p3) -- Line: 130 -- upvalues: u59 (val), u57 (val)
    local v1 = p1 ~= nil
    assert(v1, "Must pass NPC object")
    local UID = p1.UID
    if p1[p2] and typeof(p1[p2]) == "function" then
        if p3[1] == "_useself" then
            p3[1] = p1
        end
        if not p1._Destroyed then
            p1[p2](unpack(p3))
        end
    end
    if p2 == "Destroy" then
        u59[p1.Model] = nil
        u57[UID] = nil
    elseif p1._Destroyed then
        u59[p1.Model] = nil
        u57[UID] = nil
    end
end
function addToReflectionQueue(p1, p2, p3) -- Line: 150 -- upvalues: u60 (val), u61 (val), NPCRegistry (val), handleReflection (val)
    if not (u60[p1]) then
        u60[p1] = {}
    end
    local v1 = u60[p1]
    table.insert(v1, {p2, p3})
    if not (u61[p1]) then
        local v2
        u61[p1] = true
        while true do
            v2 = NPCRegistry.NPCAdded:Wait()
            if v2.UID == p1 then
                break
            end
        end
        while true do
            v1 = #u60[p1]
            if 0 >= v1 then
                break
            end
            v1 = table.remove(u60[p1], 1)
            handleReflection(v2, v1[1], v1[2])
        end
    end
end
if not u7 then
    local v1 = require("@game/ReplicatedStorage/common/zap")
    CreateMirrorClassEvent:SetClientListener(function(p1) -- Line: 229 -- upvalues: u57 (val), findClientClass (val), NPCRegistry (val), u63 (val)
        local v1, v2, v3, v4
        v1, v2, v3, v4 = unpack(p1)
        if u57[v2] then
            return
        end
        debug.profilebegin("createMirroredClass")
        local v5 = findClientClass(v1 .. "_Client")
        if v5 and v2 and v3 then
            local v6 = require(v5).new(v4)
            v6.UID = v2
            NPCRegistry:AddNPC(v6)
            v6:Init(v3)
            if not u63._Loaded then
                while true do
                    task.wait()
                    if u63._Loaded then
                        break
                    end
                end
            end
            u63.PrepareMirror(v6, v2)
        end
        debug.profileend()
    end)
    local u121 = {}
    u121[0] = 0
    u121[1] = 0
    u121[2] = 0
    u121[3] = 0
    u121[4] = 0
    u121[5] = 0
    u121[6] = 0
    u121[7] = 0
    u121[8] = 0
    u121[9] = 0
    u121[10] = 0
    u121[11] = 0
    u121[12] = 0
    u121[13] = 0
    u121[14] = 0
    u121[15] = 0
    u121[16] = 0
    u121[17] = 0
    u121[18] = 0
    u121[19] = 0
    u121[20] = 0
    v1.PositionChangedEvent.On(function(p1) -- Line: 259 -- upvalues: u121 (val), NPCRegistry (val)
        local NPC
        if p1.ServerTick < u121[p1.GroupIndex] then
            return
        end
        u121[p1.GroupIndex] = p1.ServerTick
        local NPCs = p1.NPCs
        local v1 = nil
        local v2 = nil
        for i, j in NPCs, v1, v2 do
            NPC = NPCRegistry:GetNPC(i)
            if NPC and not NPC.IsCompat then
                NPC:ServerUpdate(j)
            end
        end
    end)
    NPCReflectionEvent:SetClientListener(function(p1) -- Line: 273 -- upvalues: NPCRegistry (val), u62 (val), handleReflection (val), addToReflectionQueue (val)
        local v1, v2, v3
        v1, v2, v3 = unpack(p1)
        local NPC = NPCRegistry:GetNPC(v1)
        if not NPC then
            NPC = u62[v1]
        end
        if NPC then
            handleReflection(NPC, v2, v3)
            return
        end
        addToReflectionQueue(v1, v2, v3)
    end)
    RequestExistingNPCs:FireServer()
    NPCRegistry.NPCRemoved:Connect(function(p1) -- Line: 285 -- upvalues: u62 (val)
        u62[p1.UID] = p1
        task.delay(60, function() -- Line: 288 -- upvalues: u62 (upval), p1 (val)
            u62[p1.UID] = nil
        end)
    end)
else
    game:GetService("ServerScriptService")
    local u91 = require("@game/ServerScriptService/common/zap")
    local u92 = {}
    game:GetService("Players").PlayerRemoving:Connect(function(p1) -- Line: 173 -- upvalues: u92 (val)
        u92[p1] = nil
    end)
    RequestExistingNPCs:SetServerListener(function(p1) -- Line: 176 -- upvalues: u92 (val), u57 (val), CreateMirrorClassEvent (val)
        if not (u92[p1]) then
            local NoReplicatedModel, v1, v2
            u92[p1] = true
            local v3 = 1
            local v4 = p1
            while v3 <= #u57 do
                v1 = u57[v3]
                if not v1._Destroyed then
                    v2 = {}
                    NoReplicatedModel = v1.NoReplicatedModel
                    if not NoReplicatedModel then
                        NoReplicatedModel = v1.Model
                    end
                    v2[1] = v1._ClassName
                    v2[2] = v1.UID
                    v2[3] = NoReplicatedModel
                    v2[4] = v1.InitData
                    CreateMirrorClassEvent:FireClient(v4, v2)
                    v3 = v3 + 1
                else
                    table.remove(u57, v3)
                end
            end
        end
    end)
    task.defer(function() -- Line: 195 -- upvalues: NPCRegistry (val), u91 (val)
        local v1, v2, v3, v4
        local v5 = 0
        local v6 = 0
        while task.wait(0.025) do
            v5 = v5 + 1
            v6 = (v6 + 1) % 4
            v1 = {}
            v2 = NPCRegistry:GetAllNPCs()
            v3 = nil
            v4 = nil
            for i, j in v2, v3, v4 do
                if j.UID % 4 == v6 and j.HRP and not j.IsCompat then
                    v1[j.UID] = j.HRP.Position
                end
            end
            u91.PositionChangedEvent.FireAll({NPCs = v1, ServerTick = v5, GroupIndex = v6})
        end
    end)
end
function u63.GetObjs(p1) -- Line: 296 -- upvalues: u58 (val)
    local v1 = {}
    local v2 = u58
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if not j._Destroyed then
            table.insert(v1, j)
        end
    end
    return v1
end
function u63.CompatiblityPatchModel(p1, p2, p3, p4) -- Line: 307 -- upvalues: u38 (val), u59 (val)
    local u10 = u38:Create(p2, p3, p4)
    u10.Died:Connect(function() -- Line: 309 -- upvalues: u10 (val), u59 (upval), p2 (val)
        task.delay(10, function() -- Line: 310 -- upvalues: u10 (upval), u59 (upval), p2 (upval)
            u10.Died:DisconnectAll()
            u10.PlayerHurtNPC:DisconnectAll()
            u59[p2] = nil
        end)
    end)
    return u10
end
u38.AddedNPC:Connect(function(p1) -- Line: 319 -- upvalues: u59 (val), NPCRegistry (val)
    u59[p1.Model] = p1
    NPCRegistry:AddNPC(p1)
end)
function u63.GetObjFromModel(p1, p2) -- Line: 324 -- upvalues: u59 (val)
    return u59[p2]
end
function u63.GetObjFromId(p1, p2) -- Line: 328 -- upvalues: NPCRegistry (val)
    return NPCRegistry:GetNPC(p2)
end
function u63.GetLiveDamagePos(p1, p2) -- Line: 349 -- upvalues: u63 (val)
    if not p2 then
        return nil, false
    end
    local damageUID = p2.damageUID
    if not damageUID then
        return p2.damagePos, false
    end
    local ObjFromId = u63:GetObjFromId(damageUID)
    local HRP = ObjFromId
    if HRP then
        HRP = ObjFromId.HRP
    end
    if not HRP then
        return p2.damagePos, false
    end
    if HRP.Parent then
        return HRP.Position, true
    end
    return p2.damagePos, false
end
function u63.PrepareMirror(p1, p2) -- Line: 366 -- upvalues: u7 (val), u58 (val), NPCReflectionEvent (val), u59 (val), u57 (val)
    if not u7 then
        u59[p1.Model] = p1
        u57[p2] = p1
    else
        local UID = p1.UID
        if p1.Model then
            u58[UID] = p1
            if p1.Destroyed then
                p1.Destroyed:Connect(function() -- Line: 373 -- upvalues: u58 (upval), UID (ref), p1 (val)
                    local v1 = u58[UID]
                    if v1 == p1 then
                        u58[UID] = nil
                    end
                end)
            end
            function p1.Rollback(a1) -- Line: 379 -- upvalues: NPCReflectionEvent (upval), UID (ref), p1 (val)
                local v1 = {}
                local v2 = {"_useself", p1.HP}
                v1[1] = UID
                v1[2] = "Rollback"
                v1[3] = v2
                NPCReflectionEvent:FireClient(a1, v1)
            end
            function p1.ReconcileDamage(p1, p2, p3) -- Line: 389 -- upvalues: NPCReflectionEvent (upval), UID (ref)
                NPCReflectionEvent:FireClient(p1, {
                    UID,
                    "ReconcileDamage",
                    {"_useself", p2, p3},
                })
            end
        end
    end
end
function u63.CreateMirrorMetamethods(p1) -- Line: 403 -- upvalues: u7 (val), NPCRegistry (val), u63 (val), CreateMirrorClassEvent (val), u57 (val), findClientClass (val), NPCReflectionEvent (val)
    function p1.__index(a1, p2) -- Line: 404 -- upvalues: u7 (upval), p1 (val), NPCRegistry (upval), u63 (upval), CreateMirrorClassEvent (upval), u57 (upval), findClientClass (upval), NPCReflectionEvent (upval)
        if p2 == "Init" then
            if u7 then
                return function(...) -- Line: 408 -- upvalues: p1 (upval), a1 (val), NPCRegistry (upval), u63 (upval), CreateMirrorClassEvent (upval), u57 (upval)
                    local NoReplicatedModel, v1, v2
                    local v3 = {...}
                    if not (v3[10]) then
                        v3[10] = "__ParentClass"
                        v1 = p1.Init(unpack(v3, 1, 10))
                        if a1._MirrorRegistered then
                            return v1
                        end
                        a1._MirrorRegistered = true
                        NPCRegistry:AddNPC(a1)
                        u63.PrepareMirror(a1)
                        v2 = {}
                        NoReplicatedModel = a1.NoReplicatedModel
                        if not NoReplicatedModel then
                            NoReplicatedModel = a1.Model
                        end
                        v2[1] = a1._ClassName
                        v2[2] = a1.UID
                        v2[3] = NoReplicatedModel
                        v2[4] = a1.InitData
                        CreateMirrorClassEvent:FireAllClients(v2)
                        table.insert(u57, a1)
                        return v1
                    end
                    if v3[10] == "__ParentClass" then
                        return p1.Init(...)
                    end
                    v3[10] = "__ParentClass"
                    v1 = p1.Init(unpack(v3, 1, 10))
                    if a1._MirrorRegistered then
                        return v1
                    end
                    a1._MirrorRegistered = true
                    NPCRegistry:AddNPC(a1)
                    u63.PrepareMirror(a1)
                    v2 = {}
                    NoReplicatedModel = a1.NoReplicatedModel
                    if not NoReplicatedModel then
                        NoReplicatedModel = a1.Model
                    end
                    v2[1] = a1._ClassName
                    v2[2] = a1.UID
                    v2[3] = NoReplicatedModel
                    v2[4] = a1.InitData
                    CreateMirrorClassEvent:FireAllClients(v2)
                    table.insert(u57, a1)
                    return v1
                end
            end
            return p1[p2]
        end
        if p2 == "new" or not (rawget(a1, "_Initialized")) then
            return p1[p2]
        end
        if typeof(p1[p2]) == "function" then
            return function(...) -- Line: 451 -- upvalues: a1 (val), findClientClass (upval), p2 (val), u7 (upval), NPCReflectionEvent (upval), p1 (upval)
                local v1 = {...}
                if v1[1] and v1[1] == a1 then
                    v1[1] = "_useself"
                end
                local v2 = findClientClass(a1._ClassName .. "_Client")
                if v2 and require(v2)[p2] and u7 then
                    NPCReflectionEvent:FireAllClients({a1.UID, p2, v1})
                end
                return p1[p2](...)
            end
        end
        return p1[p2]
    end
end
u63._Loaded = true
return u63