local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage.common
local RedEvents = ReplicatedStorage.common.RedEvents
local SpawnBoxSerial551236123161233 = workspace:FindFirstChild("SpawnBoxSerial551236123161233")
local Signal = require(common:WaitForChild("Signal"))
local unseatCharacter = require(((common:WaitForChild("ZS_Shared")):WaitForChild("Util")):WaitForChild("unseatCharacter"))
local PlayerState = require(script:WaitForChild("PlayerState"))
local u104 = nil
local u58 = RunService:IsServer()
local UpdateStatusEvent = require(RedEvents.Framework.UpdateStatusEvent)
local ForceTeleport = require(RedEvents.Framework.ForceTeleport)
local CameraEvent = require(RedEvents.Framework.CameraEvent)
local FrameworkEvents = require(RedEvents.Framework.FrameworkEvents)
local u75 = {}
local u76 = {}
local u77 = {}
local u78 = {}
local u117 = nil
local u80 = {}
if u58 then
    local common_2 = (game:GetService("ServerStorage")):FindFirstChild("common")
    if common_2 then
        common_2 = game:GetService("ServerStorage").common:FindFirstChild("ProgressionTracker")
    end
    if common_2 then
        u104 = require(common_2)
    end
    if not SpawnBoxSerial551236123161233 then
        task.spawn(function() -- Line: 46 -- upvalues: SpawnBoxSerial551236123161233 (ref), u117 (ref)
            local SpawnBoxSerial551236123161233_2 = workspace:WaitForChild("SpawnBoxSerial551236123161233", 30)
            local FieldLocation = SpawnBoxSerial551236123161233_2
            if FieldLocation then
                FieldLocation = SpawnBoxSerial551236123161233_2:WaitForChild("FieldLocation", 10)
            end
            if not FieldLocation then
                warn("[PlayerHandler] SpawnBox/FieldLocation never appeared; dead players cannot be sent to spectate")
                return
            end
            SpawnBoxSerial551236123161233 = SpawnBoxSerial551236123161233_2
            u117 = FieldLocation.CFrame * CFrame.new(0, 2, 0)
        end)
    else
        u117 = SpawnBoxSerial551236123161233:WaitForChild("FieldLocation").CFrame * CFrame.new(0, 2, 0)
    end
    PhysicsService:RegisterCollisionGroup("NPCRagdoll")
    PhysicsService:RegisterCollisionGroup("NPC")
    PhysicsService:RegisterCollisionGroup("Player")
    PhysicsService:CollisionGroupSetCollidable("Player", "Player", false)
    PhysicsService:CollisionGroupSetCollidable("Player", "NPC", false)
    PhysicsService:CollisionGroupSetCollidable("NPC", "NPC", false)
    PhysicsService:CollisionGroupSetCollidable("NPC", "NPCRagdoll", false)
    PhysicsService:CollisionGroupSetCollidable("Player", "NPCRagdoll", false)
    for i, j in game.ServerStorage.common.ServerResources.StatusEffects:GetChildren() do
        u77[j.Name] = (require(j))
    end
end

local function relayLocalHealth(p1) -- Line: 78 -- upvalues: u80 (val)
    if rawget(p1, "_HealthRelayConnected") then
        return
    end
    rawset(p1, "_HealthRelayConnected", true)
    local u10 = nil

    local function flush() -- Line: 86 -- upvalues: u10 (ref), u80 (upval)
        local v1 = u10
        u10 = nil
        if v1 then
            local v2 = u80
            local HealthChanged = v2.HealthChanged
            local HP = v1.HP
            local Damage = v1.Damage
            local ExtraData = v1.ExtraData
            HealthChanged:Fire(HP, Damage, ExtraData)
        end
    end

    local function ensurePending(p1) -- Line: 94 -- upvalues: u10 (ref), flush (val)
        if not u10 then
            u10 = {Damage = 0, FromDamagePacket = false, HP = p1}
            task.defer(flush)
        else
            u10.HP = p1
        end
        return u10
    end

    p1.HPChanged:Connect(function(p1, p2) -- Line: 104 -- upvalues: u10 (ref), flush (val)
        if not u10 then
            u10 = {Damage = 0, FromDamagePacket = false, HP = p1}
            task.defer(flush)
        else
            u10.HP = p1
        end
        local v1 = u10
        if not v1.FromDamagePacket then
            local v2 = (p2 or p1) - p1
            v1.Damage = math.max(v2, 0)
        end
    end)
    p1.Damaged:Connect(function(p1, p2, p3) -- Line: 113 -- upvalues: u10 (ref), flush (val)
        if not u10 then
            u10 = {Damage = 0, FromDamagePacket = false, HP = p1}
            task.defer(flush)
        else
            u10.HP = p1
        end
        local v1 = u10
        if not v1.FromDamagePacket then
            v1.FromDamagePacket = true
            v1.Damage = 0
        end
        v1.Damage = v1.Damage + (p2 or 0)
        local ExtraData = p3
        if not ExtraData then
            ExtraData = v1.ExtraData
        end
        v1.ExtraData = ExtraData
    end)
end

if not u58 then
    u80.HealthChanged = Signal.new()
    u80.ReplicatedState = Signal.new()
    u80.StatusUpdated = Signal.new()
end
u80.PlayerDied = Signal.new()

function u80.KillPlayer(p1) -- Line: 133 -- upvalues: u76 (val)
    local v1 = u76[p1]
    if not v1 then
        return
    end
    print("PlayerHandler:KillPlayer", p1.Name, v1.HP)
    v1.IsDead = true
end

function u80.Init(p1) -- Line: 143
    -- upvalues: u80 (val), u76 (val), u58 (val), Players (val), relayLocalHealth (val), u104 (ref), PlayerState (val)
    -- upvalues: u117 (ref), u78 (val), FrameworkEvents (val)
    if u80._Init then
        return
    end

    local function setupPlayerState(p1) -- Line: 148
        -- upvalues: u76 (upval), u58 (upval), Players (upval), relayLocalHealth (upval), u80 (upval), u104 (upval)
        local Player = p1.Player
        u76[Player] = p1
        if not u58 and Player == Players.LocalPlayer then
            relayLocalHealth(p1)
        end
        ;(u76[Player]:GetPropertyChangedSignal("IsDead")):Connect(function(p1) -- Line: 154 -- upvalues: Player (val), u80 (upval), u76 (upval), u104 (upval)
            local Character = Player.Character
            if Character then
                local PrimaryPart = Character.PrimaryPart
                if PrimaryPart then
                    PrimaryPart.Anchored = p1
                end
            end
            if not p1 then
                return
            end
            local v1 = u80
            local PlayerDied = v1.PlayerDied
            local v2 = Player
            local v3 = u76
            local v4 = Player
            local v5 = v3[v4]
            PlayerDied:Fire(v2, v5)
            if u104 and u104.RecordPlayerDeath then
                v1 = u104
                v2 = Player
                v1:RecordPlayerDeath(v2)
            end
        end)
    end

    PlayerState.StateAdded:Connect(setupPlayerState)

    local function PlayerAdded(p1) -- Line: 176
        -- upvalues: u58 (upval), setupPlayerState (val), PlayerState (upval), u76 (upval), u80 (upval), u117 (upval)
        -- upvalues: u104 (upval)
        if u58 then
            setupPlayerState(PlayerState.new(p1))
            local v1 = u76
            v1[p1].Died:Connect(function() -- Line: 179 -- upvalues: u80 (upval), p1 (val), u117 (upval)
                local v1 = u80
                local v2 = p1
                local v3 = u117
                v1:Teleport(v2, v3)
            end)
            p1.CharacterAdded:Connect(function(p1_2) -- Line: 182 -- upvalues: u104 (upval), p1 (val)
                if u104 then
                    local v1 = u104
                    local v2 = p1
                    local v3 = u104
                    local v4 = p1
                    local Class = v3:GetClass(v4)
                    v1:UniformPlayer(v2, Class)
                end
            end)
        end
    end

    for i, j in game.Players:GetPlayers() do
        PlayerAdded(j)
    end
    Players.PlayerRemoving:Connect(function(p1) -- Line: 190 -- upvalues: u76 (upval), u78 (upval)
        if u76[p1] then
            u76[p1]:Destroy()
        end
        u76[p1] = nil
        u78[p1] = nil
    end)
    if u58 then
        Players.PlayerAdded:Connect(PlayerAdded)
        require("@game/ServerStorage/common/PhysBall").init()
        local v1 = FrameworkEvents
        v1.RequestPendingTeleport:SetCallback(function(p1) -- Line: 208 -- upvalues: u78 (upval)
            local v1 = u78[p1]
            u78[p1] = nil
            return v1
        end)
    end
    u80._Init = true
end

function u80.Teleport(p1, p2, p3) -- Line: 219
    -- upvalues: u58 (val), u78 (val), ForceTeleport (val), unseatCharacter (val)
    local v1
    local v2 = u58
    assert(v2, "Teleport only available on server")
    local v3 = typeof(p3)
    if v3 ~= "CFrame" and v3 ~= "Vector3" then
        v2 = warn
        local Name = p2.Name
        v2(("[PlayerHandler] Teleport for %s ignored: destination was %s"):format(Name, v3))
        return
    end
    u78[p2] = p3
    if workspace.StreamingEnabled then
        local Position
        if typeof(p3) ~= "CFrame" then
            Position = p3
        else
            Position = p3.Position
        end
        v1 = 5 + (p2:GetNetworkPing()) * 2
        p2:RequestStreamAroundAsync(Position, v1)
    end
    ForceTeleport:FireClient(p2, p3)
    local Character = p2.Character
    if not Character then
        return
    end
    unseatCharacter(Character)
    if typeof(p3) ~= "CFrame" then
        v1 = CFrame.new(p3)
    else
        v1 = p3
    end
    Character:PivotTo(v1)
end

function u80.GetHealth(p1, p2) -- Line: 243 -- upvalues: u76 (val)
    local HP
    if not u76[p2] then
        HP = 100
    else
        HP = u76[p2].HP
        if not HP then
            HP = 100
        end
    end
    return HP
end

function u80.RespawnPlayer(p1, p2, p3) -- Line: 247 -- upvalues: u80 (val)
    local v1 = u80:WaitForPlayerState(p2)
    if v1 then
        if v1.HP == 0 or p3 ~= nil then
            local v2 = p3
            if not v2 then
                v2 = v1.MaxHP * 0.5
            end
            v1.HP = v2
        end
        v1.IsDowned = false
        v1.IsDead = false
    end
end

function u80.GetPlayerState(p1, p2) -- Line: 259 -- upvalues: u76 (val)
    return u76[p2]
end

function u80.GetPlayerStateProperty(p1, p2, p3) -- Line: 263 -- upvalues: u76 (val)
    if u76[p2] then
        return u76[p2][p3]
    end
    return nil
end

function u80.SetState(p1, p2, p3, p4) -- Line: 267 -- upvalues: u76 (val)
    if not u76[p2] then
        return
    end
    u76[p2][p3] = p4
end

function u80.SetMaxHP(p1, p2, p3, p4) -- Line: 275 -- upvalues: u80 (val)
    local v1 = u80:WaitForPlayerState(p2)
    if v1 and typeof(p3) == "number" and not (p3 <= 0) then
        v1.MaxHP = p3
        if not p4 then
            local HP = v1.HP
            v1.HP = math.min(HP, p3)
        else
            v1.HP = p3
        end
        local Character = p2.Character
        if Character then
            local MaxHP = Character:FindFirstChild("MaxHP")
            local HP_2 = Character:FindFirstChild("HP")
            if MaxHP and MaxHP:IsA("NumberValue") then
                MaxHP.Value = p3
            end
            if HP_2 and HP_2:IsA("NumberValue") then
                HP_2.Value = v1.HP
            end
        end
        if _G and _G.plrDictionary and _G.plrDictionary[p2] then
            local v2 = _G.plrDictionary[p2]
            if v2.MaxHealth then
                v2.MaxHealth.Value = p3
            end
            if v2.Health then
                v2.Health.Value = v1.HP
            end
        end
        p2:SetAttribute("Skill_MaxHP", p3)
        local HP_3 = v1.HP
        p2:SetAttribute("Skill_CurrentHP", HP_3)
        return
    end
end

function u80.UpdateStatBar(p1, p2) end

function u80.ResetStats(p1, p2) -- Line: 319 -- upvalues: u76 (val), u80 (val), UpdateStatusEvent (val), u75 (val)
    local StatusEffects = u76[p2].StatusEffects
    local v1 = nil
    local v2 = nil
    for i, j in StatusEffects, v1, v2 do
        u76[p2].StatusEffects[i] = false
    end
    u80:UpdateStatBar(p2)
    local v3 = UpdateStatusEvent
    local v4 = u75
    local v5 = v4[p2]
    v3:FireClient(p2, v5)
end

function u80.RemoveStatus(p1, p2, p3) -- Line: 328 -- upvalues: u58 (val), u76 (val)
    if not u58 then
        return
    end
    local v1 = u76[p2]
    if v1 then
        local StatusEffects = v1.StatusEffects
        if StatusEffects then
            StatusEffects[p3] = false
        end
    end
end

function u80.ApplyStatus(p1, p2, p3) -- Line: 345 -- upvalues: u58 (val), u76 (val), u77 (val)
    if not u58 then
        return
    end
    local v1 = u76[p2]
    if v1 then
        local StatusEffects = v1.StatusEffects
        if StatusEffects then
            if not StatusEffects[p3] then
                StatusEffects[p3] = 1
                return
            end
            if u77[p3].Stacks then
                StatusEffects[p3] = StatusEffects[p3] + 1
            end
        end
    end
end

function u80.WaitForPlayerState(p1, p2) -- Line: 364 -- upvalues: u76 (val)
    if not p2 then
        return nil
    end
    while not u76[p2] do
        if not p2.Parent then
            break
        end
        task.wait()
    end
    return u76[p2]
end

function u80.SetCameraControllerEnabled(p1, p2, p3) -- Line: 374 -- upvalues: u58 (val), CameraEvent (val)
    if not u58 then
        require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.CameraController):SetEnabled(p3)
        return
    end
    local v1 = CameraEvent
    local v2 = {Type = "SetEnabled", Enabled = p3}
    v1:FireClient(p2, v2)
end

RunService.Heartbeat:Connect(function(p1) -- Line: 388 -- upvalues: u76 (val)
    for k, v in pairs(u76) do
        v.StatusEffects:Update(p1)
        if v.UpdateSpartanShield then
            v:UpdateSpartanShield(p1)
        end
    end
end)
u80:Init()
return u80