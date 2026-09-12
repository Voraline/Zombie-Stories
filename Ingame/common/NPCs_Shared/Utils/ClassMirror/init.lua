local u7 = game:GetService("RunService"):IsServer()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AIClasses = (game.ReplicatedStorage.common:WaitForChild("NPCs_Shared")):WaitForChild("AIClasses")
local common = game.ReplicatedStorage.common
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

local NPCRegistry = require(common.NPCRegistry)
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
    local u64 = false
    local u65 = 0
    ;(game:GetService("RunService")).Heartbeat:Connect(function(p1) -- Line: 60 -- upvalues: GameState (val), NPCRegistry (val), u64 (ref), u65 (ref)
        local CFrame_2, HRP_2, Rotation, Rotation_2, Rotation_3, X, Y, Z, v1, v2, v3, v4, v5, v6, v7
        debug.profilebegin("Client NPC")
        local NPCRotation = GameState.LocalState.NPCRotation
        local AllNPCs = NPCRegistry:GetAllNPCs()
        u64 = not u64
        local v8 = {}
        local v9 = {}
        local v10 = AllNPCs
        local v11 = nil
        local v12 = nil
        local v13 = p1
        for i, j in v10, v11, v12 do
            if j.MoveTo and not j.Ragdolling then
                Rotation = nil
                if j.AlignDirection then
                    Rotation = j.AlignDirection.Rotation
                elseif j.RotateTowards then
                    X = j.RotateTowards.Position.X
                    Y = j.HRP.Position.Y
                    Z = j.RotateTowards.Position.Z
                    v1 = Vector3.new(X, Y, Z)
                    v2 = CFrame.new(j.HRP.Position, v1)
                    Rotation = v2 - v2.Position
                end
                if Rotation then
                    if not j.Rotation then
                        j.Rotation = Rotation
                    else
                        Rotation_2 = j.Rotation
                        v4 = v13 * 5
                        j.Rotation = Rotation_2:Lerp(Rotation, v4)
                    end
                end
                HRP_2 = j.HRP
                table.insert(v8, HRP_2)
                CFrame_2 = j.HRP.CFrame
                v6 = CFrame.new(j.MoveTo) * NPCRotation
                Rotation_3 = j.Rotation
                if not Rotation_3 then
                    Rotation_3 = CFrame.new()
                end
                v5 = v6 * Rotation_3
                v7 = v13 * (j.WalkSpeed / 2)
                v6 = math.clamp(v7, 0, 1)
                v3 = CFrame_2:Lerp(v5, v6)
                table.insert(v9, v3)
            end
        end
        if 0 < #v8 then
            v10 = workspace
            local FireCFrameChanged = Enum.BulkMoveMode.FireCFrameChanged
            v10:BulkMoveTo(v8, v9, FireCFrameChanged)
        end
        v10 = v13 + u65
        v11 = AllNPCs
        v12 = nil
        local v14 = nil
        for k, n in v11, v12, v14 do
            if n.FastThink then
                n:FastThink(v13)
                if not u64 then
                    v1 = not u64
                    if v1 then
                        v1 = n.UID % 2 == 0
                    end
                else
                    v1 = true
                    if n.UID % 2 ~= 1 then
                        v1 = not u64
                        if v1 then
                            v1 = n.UID % 2 == 0
                        end
                    end
                end
                if v1 then
                    n:ClientThink(v10)
                end
            end
        end
        u65 = v13
        debug.profileend()
    end)
end

local function handleReflection(p1, p2, p3) -- Line: 130 -- upvalues: u59 (val), u57 (val)
    local v1 = p1 ~= nil
    assert(v1, "Must pass NPC object")
    local UID = p1.UID
    if p1[p2] then
        local v2 = p1[p2]
        if typeof(v2) == "function" then
            if p3[1] == "_useself" then
                p3[1] = p1
            end
            if not p1._Destroyed then
                p1[p2](unpack(p3))
            end
        end
    end
    if p2 == "Destroy" or p1._Destroyed then
        u59[p1.Model] = nil
        u57[UID] = nil
    end
end

local function addToReflectionQueue(p1, p2, p3) -- Line: 150
    -- upvalues: u60 (val), u61 (val), NPCRegistry (val), handleReflection (val)
    if not u60[p1] then
        u60[p1] = {}
    end
    local v1 = u60[p1]
    local v2 = {p2, p3}
    table.insert(v1, v2)
    if not u61[p1] then
        local v3
        u61[p1] = true
        repeat
            v3 = NPCRegistry.NPCAdded:Wait()
        until v3.UID == p1
        while true do
            if not (0 < #u60[p1]) then
                break
            end
            v1 = table.remove(u60[p1], 1)
            handleReflection(v3, v1[1], v1[2])
        end
    end
end

if not u7 then
    local v1 = require("@game/ReplicatedStorage/common/zap")
    CreateMirrorClassEvent:SetClientListener(function(p1) -- Line: 229 -- upvalues: u57 (val), findClientClass (val), NPCRegistry (val), u63 (val)
        local v1, v2, v3, v4 = unpack(p1)
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
                repeat
                    task.wait()
                until u63._Loaded
            end
            u63.PrepareMirror(v6, v2)
        end
        debug.profileend()
    end)
    local u121 = {
        [0] = 0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    }
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
        local v1, v2, v3 = unpack(p1)
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
    ;(game:GetService("Players")).PlayerRemoving:Connect(function(p1) -- Line: 173 -- upvalues: u92 (val)
        u92[p1] = nil
    end)
    RequestExistingNPCs:SetServerListener(function(p1) -- Line: 176 -- upvalues: u92 (val), u57 (val), CreateMirrorClassEvent (val)
        if not u92[p1] then
            local NoReplicatedModel, UID, _ClassName, v1, v2, v3
            u92[p1] = true
            local v4 = 1
            local v5 = p1
            while v4 <= #u57 do
                v1 = u57[v4]
                if not v1._Destroyed then
                    v2 = CreateMirrorClassEvent
                    v3 = {}
                    _ClassName = v1._ClassName
                    UID = v1.UID
                    NoReplicatedModel = v1.NoReplicatedModel
                    if not NoReplicatedModel then
                        NoReplicatedModel = v1.Model
                    end
                    v3[1] = _ClassName
                    v3[2] = UID
                    v3[3] = NoReplicatedModel
                    v3[4] = v1.InitData
                    v2:FireClient(v5, v3)
                    v4 = v4 + 1
                else
                    table.remove(u57, v4)
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
            v2 = u91
            v2.PositionChangedEvent.FireAll({NPCs = v1, ServerTick = v5, GroupIndex = v6})
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
    if damageUID then
        local ObjFromId = u63:GetObjFromId(damageUID)
        local HRP = ObjFromId
        if HRP then
            HRP = ObjFromId.HRP
        end
        if HRP and HRP.Parent then
            return HRP.Position, true
        end
    end
    return p2.damagePos, false
end

function u63.PrepareMirror(p1, p2) -- Line: 366
    -- upvalues: u7 (val), u58 (val), NPCReflectionEvent (val), u59 (val), u57 (val)
    if not u7 then
        u59[p1.Model] = p1
        u57[p2] = p1
    else
        local UID = p1.UID
        if p1.Model then
            u58[UID] = p1
            if p1.Destroyed then
                p1.Destroyed:Connect(function() -- Line: 373 -- upvalues: u58 (upval), UID (ref), p1 (val)
                    if u58[UID] == p1 then
                        u58[UID] = nil
                    end
                end)
            end

            function p1.Rollback(p1_2) -- Line: 379 -- upvalues: NPCReflectionEvent (upval), UID (ref), p1 (val)
                local v1 = NPCReflectionEvent
                local v2 = {}
                local v3 = UID
                local v4 = {"_useself", p1.HP}
                v2[1] = v3
                v2[2] = "Rollback"
                v2[3] = v4
                v1:FireClient(p1_2, v2)
            end

            function p1.ReconcileDamage(p1, p2, p3) -- Line: 389 -- upvalues: NPCReflectionEvent (upval), UID (ref)
                local v1 = NPCReflectionEvent
                local v2 = {}
                local v3 = UID
                v2[1] = v3
                v2[2] = "ReconcileDamage"
                v2[3] = {"_useself", p2, p3}
                v1:FireClient(p1, v2)
            end
        end
    end
end

function u63.CreateMirrorMetamethods(p1) -- Line: 403
    -- upvalues: u7 (val), NPCRegistry (val), u63 (val), CreateMirrorClassEvent (val), u57 (val), findClientClass (val)
    -- upvalues: NPCReflectionEvent (val)
    function p1.__index(p1_2, p2) -- Line: 404
        -- upvalues: u7 (upval), p1 (val), NPCRegistry (upval), u63 (upval), CreateMirrorClassEvent (upval), u57 (upval)
        -- upvalues: findClientClass (upval), NPCReflectionEvent (upval)
        if p2 == "Init" then
            if u7 then
                return function(...) -- Line: 408
                    -- upvalues: p1 (upval), p1_2 (val), NPCRegistry (upval), u63 (upval)
                    -- upvalues: CreateMirrorClassEvent (upval), u57 (upval)
                    local v1 = {...}
                    if v1[10] and v1[10] == "__ParentClass" then
                        return p1.Init(...)
                    end
                    v1[10] = "__ParentClass"
                    local v2 = p1.Init(unpack(v1, 1, 10))
                    if p1_2._MirrorRegistered then
                        return v2
                    end
                    p1_2._MirrorRegistered = true
                    local v3 = NPCRegistry
                    local v4 = p1_2
                    v3:AddNPC(v4)
                    u63.PrepareMirror(p1_2)
                    v3 = CreateMirrorClassEvent
                    v4 = {}
                    local _ClassName = p1_2._ClassName
                    local UID = p1_2.UID
                    local NoReplicatedModel = p1_2.NoReplicatedModel
                    if not NoReplicatedModel then
                        NoReplicatedModel = p1_2.Model
                    end
                    v4[1] = _ClassName
                    v4[2] = UID
                    v4[3] = NoReplicatedModel
                    v4[4] = p1_2.InitData
                    v3:FireAllClients(v4)
                    local v5 = u57
                    v4 = p1_2
                    table.insert(v5, v4)
                    return v2
                end
            end
            return p1[p2]
        end
        if p2 ~= "new" and rawget(p1_2, "_Initialized") then
            local v1 = p1
            local v2 = v1[p2]
            if typeof(v2) == "function" then
                return function(...) -- Line: 451
                    -- upvalues: p1_2 (val), findClientClass (upval), p2 (val), u7 (upval), NPCReflectionEvent (upval)
                    -- upvalues: p1 (upval)
                    local v1 = {...}
                    if v1[1] and v1[1] == p1_2 then
                        v1[1] = "_useself"
                    end
                    local v2 = findClientClass(p1_2._ClassName .. "_Client")
                    if v2 and require(v2)[p2] and u7 then
                        local v3 = NPCReflectionEvent
                        local v4 = {p1_2.UID, p2, v1}
                        v3:FireAllClients(v4)
                    end
                    return p1[p2](...)
                end
            end
        end
        return p1[p2]
    end
end

u63._Loaded = true
return u63