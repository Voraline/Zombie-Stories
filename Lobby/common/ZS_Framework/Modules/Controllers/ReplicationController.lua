local Value
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local u22 = require("@game/ReplicatedStorage/common/zap")
local CurrentCamera = workspace.CurrentCamera
local common = ReplicatedStorage.common
local Assets = ReplicatedStorage.common:WaitForChild("SharedResources"):WaitForChild("Assets")
local Utils = script.Parent.Parent.Utils
local WepConfig = require(common:WaitForChild("WepConfig"))
local Promise = require(common:WaitForChild("Promise"))
local PlayerHandler = require(common:WaitForChild("PlayerHandler"))
local u61 = require("./FlashlightController")
local ClassMirror = require(ReplicatedStorage.common.NPCs_Shared.Utils.ClassMirror)
local CharacterAnimator = require(script.Parent.Parent.Utils:WaitForChild("CharacterAnimator"))
local Settings = require(ReplicatedStorage.common.Settings)
local peek = require(ReplicatedStorage.Packages.Fusion).peek
require("../Classes/WorldViewmodel")
local u92 = require("../Classes/WorldWeapon")
local BulletUtil = require(Utils:WaitForChild("BulletUtil"))
local RaycastUtil = require(Utils:WaitForChild("RaycastUtil"))
local GunID = require(common:WaitForChild("GunID"))
local FrameworkEvents = require(ReplicatedStorage.common.RedEvents.Framework.FrameworkEvents)
Value = if workspace.Values:FindFirstChild("IsLobby") ~= nil then workspace.Values.IsLobby.Value else false
local Attribute = workspace.Values:GetAttribute("EnableLobbyPeerReplication")
local u135 = not Value
if not u135 then
    u135 = Attribute == true
end
local u136 = {}
local u137 = {}
local v1 = {}
local u139 = 0
local u140 = {}
u140["rbxassetid://180426354"] = true
local function reliefIKDisabled() -- Line: 56 -- upvalues: Value (val)
    if not Value then
        return false
    end
    local v1 = workspace.Values:GetAttribute("LobbyReliefIK") == true
    return v1
end
local function applyProceduralIKSetting() -- Line: 63 -- upvalues: peek (val), Settings (val), Value (val), u137 (val)
    local v1
    local v2 = peek(Settings.Graphics.ProceduralAnimations)
    if v2 then
        if Value then
            v1 = workspace.Values:GetAttribute("LobbyReliefIK") == true
        else
            v1 = false
        end
        v2 = not v1
    end
    v1 = u137
    local v3 = nil
    local v4 = nil
    for i, j in v1, v3, v4 do
        if j.Animator then
            j.Animator:SetIKEnabled(v2)
        end
    end
end
Settings.SettingsChanged:Connect(function(p1) -- Line: 73 -- upvalues: applyProceduralIKSetting (val)
    if p1 and p1[1] == "Graphics" and p1[2] == "ProceduralAnimations" then
        applyProceduralIKSetting()
    end
end)
local u155 = os.clock()
local u156 = nil
local u157 = nil
local u160 = Enum.RenderPriority.Character.Value + 1
local u174 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
local v2 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
local v3 = CFrame.new(0, -0.25, 0)
local u199 = v3 * CFrame.Angles(0, 3.141592653589793, 0)
local u205 = CFrame.new(0, -0.25, 0) * v2
if Value then
    local AttributeChangedSignal = workspace.Values:GetAttributeChangedSignal("EnableLobbyPeerReplication")
    AttributeChangedSignal:Connect(function() -- Line: 96 -- upvalues: u135 (ref)
        local v1 = workspace.Values:GetAttribute("EnableLobbyPeerReplication") == true
        u135 = v1
    end)
    local AttributeChangedSignal_2 = workspace.Values:GetAttributeChangedSignal("LobbyReliefIK")
    AttributeChangedSignal_2:Connect(applyProceduralIKSetting)
end
local v4 = CFrame.new(0, -0.15, -0.3)
local u237 = v4 * CFrame.Angles(0.5235987755982988, 0, 0)
local v5 = CFrame.new(-0.3, -0.5, -0.2)
local u248 = v5 * CFrame.Angles(0.6108652381980153, -0.2617993877991494, 0)
local v6 = CFrame.new(0.25, 0, 0)
local u259 = v6 * CFrame.Angles(0, -0.17453292519943295, 0)
local v7 = CFrame.new(-0.25, 0, 0)
local u270 = v7 * CFrame.Angles(0, 0.17453292519943295, 0)
local v8 = CFrame.new(-0.25, 0, -0.1)
local u281 = v8 * CFrame.Angles(0, 0.17453292519943295, 0)
local function GetMirroredCFrame(p1) -- Line: 113
    return CFrame.fromMatrix(p1.Position, p1.XVector * -1, p1.YVector, p1.ZVector)
end
local function GetPlayerSkinColor(p1) -- Line: 118
    local Character = p1
    if Character then
        Character = p1.Character
    end
    local Color = Color3.fromRGB(255, 204, 153)
    if not Character then
        return Color
    end
    local BodyColors = Character:FindFirstChildOfClass("BodyColors")
    if not BodyColors then
        local v1 = Character:FindFirstChild("Right Arm")
        if v1 then
            Color = v1.Color
        end
        return Color
    end
    local RightArmColor3 = BodyColors.RightArmColor3
    if not RightArmColor3 then
        RightArmColor3 = BodyColors.LeftArmColor3
        if not RightArmColor3 then
            RightArmColor3 = Color
        end
    end
    return RightArmColor3
end
local function CreateMirroredArmModel(p1, p2) -- Line: 138 -- upvalues: Assets (val), GetPlayerSkinColor (val)
    local RightArm = Assets:FindFirstChild("RightArm")
    if not RightArm then
        warn("[ReplicationController] Could not find RightArm template for dual wield arm model")
        return nil
    end
    local v1 = p1:FindFirstChild("Right Arm")
    if not v1 then
        return nil
    end
    local v2 = RightArm:Clone()
    v2.Name = "DualWieldArmModel"
    v2.CanCollide = false
    v2.Anchored = false
    v2.Color = GetPlayerSkinColor(p2)
    local FileMesh = v2:FindFirstChildOfClass("FileMesh")
    if not FileMesh then
        FileMesh = v2:FindFirstChildOfClass("SpecialMesh")
    end
    if FileMesh then
        FileMesh.Scale = Vector3.new(-1, 1, 1)
    end
    local Motor6D = Instance.new("Motor6D")
    Motor6D.Name = "ArmModelWeld"
    Motor6D.Part0 = v1
    Motor6D.Part1 = v2
    Motor6D.C0 = CFrame.Angles(0, -3.141592653589793, 0)
    Motor6D.C1 = CFrame.new(0, 0, 0)
    Motor6D.Parent = v2
    v2.Parent = p1
    return v2
end
local function round(p1, p2) -- Line: 179
    local v1 = "%." .. (p2 or 0) .. "f"
    return (tonumber(string.format(v1, p1)))
end
local function roundVector(p1, p2) -- Line: 182
    local v1 = tonumber(string.format("%." .. (p2 or 0) .. "f", p1.X))
    local v2 = tonumber(string.format("%." .. (p2 or 0) .. "f", p1.Y))
    local v3 = "%." .. (p2 or 0) .. "f"
    return v1, v2, (tonumber(string.format(v3, p1.Z)))
end
local function isInView(p1) -- Line: 185 -- upvalues: CurrentCamera (val)
    local v1 = p1 - CurrentCamera.CFrame.Position
    local v2 = CurrentCamera.FieldOfView + 2
    if math.floor((math.deg((v1.Unit:Angle(CurrentCamera.CFrame.LookVector))))) <= v2 then
        return true
    end
    return false
end
local v9 = {
    Init = function() -- Line: 202 -- upvalues: u137 (val), u136 (val), FrameworkEvents (val), CharacterAnimator (val), RaycastUtil (val), peek (val), Settings (val), Value (val), u140 (val), u135 (ref), Players (val), u139 (ref), BulletUtil (val), ClassMirror (val), u22 (val), RunService (val), u160 (val), u155 (ref), CurrentCamera (val), u156 (ref), u157 (ref), PlayerHandler (val), u205 (val), u199 (val), u174 (val), u61 (val), ReplicatedStorage (val), TweenService (val), u237 (val), CreateMirroredArmModel (val), u270 (val), u248 (val), u259 (val), u281 (val)
        local function cleanPlayer(p1) -- Line: 203 -- upvalues: u137 (upval), u136 (upval)
            if u137[p1] then
                if u137[p1].LookAttachment then
                    u137[p1].LookAttachment:Destroy()
                end
                if u137[p1].WorldModel then
                    DestroyModel(u137[p1])
                end
                if u137[p1].SecondaryWorldModel then
                    DestroySecondaryModel(u137[p1])
                end
                if u137[p1].OffHandWorldModel then
                    DestroyOffHandModel(u137[p1])
                end
                if u137[p1].Animator then
                    u137[p1].Animator:Destroy()
                end
            end
            u136[p1.Name] = nil
            u137[p1] = nil
        end
        local CharacterLoaded = FrameworkEvents.CharacterLoaded
        local function CharAdded(p1, p2) -- Line: 227 -- upvalues: CharacterLoaded (val), u137 (upval), CharacterAnimator (upval), RaycastUtil (upval), peek (upval), Settings (upval), Value (upval), u140 (upval)
            local Animator, Terrain, v1
            local function finishLocalCharacterReady() -- Line: 228 -- upvalues: p2 (val), CharacterLoaded (upval)
                if p2 == game.Players.LocalPlayer then
                    CharacterLoaded:FireServer()
                end
            end
            if u137[p2] then
                if u137[p2].LookAttachment then
                    u137[p2].LookAttachment:Destroy()
                end
                if u137[p2].WorldModel then
                    DestroyModel(u137[p2])
                end
                if u137[p2].SecondaryWorldModel then
                    DestroySecondaryModel(u137[p2])
                end
                if u137[p2].OffHandWorldModel then
                    DestroyOffHandModel(u137[p2])
                end
                if u137[p2].Animator then
                    u137[p2].Animator:Destroy()
                end
            end
            local Humanoid = p1:FindFirstChildOfClass("Humanoid")
            if not Humanoid then
                Humanoid = p1:WaitForChild("Humanoid", 5)
            end
            local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
            if not HumanoidRootPart then
                HumanoidRootPart = p1:WaitForChild("HumanoidRootPart", 5)
            end
            local Head = p1:FindFirstChild("Head")
            if not Head then
                Head = p1:WaitForChild("Head", 5)
            end
            u137[p2].HRP = HumanoidRootPart
            u137[p2].Head = Head
            if not Humanoid or not (Humanoid:IsA("Humanoid")) then
                warn("[ReplicationController] Character has no Humanoid:", p1:GetFullName())
                if p2 == game.Players.LocalPlayer then
                    CharacterLoaded:FireServer()
                end
                return
            end
            if Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
                warn("[ReplicationController] R6 replication setup skipped for unsupported rig:", Humanoid.RigType.Name)
                if p2 == game.Players.LocalPlayer then
                    CharacterLoaded:FireServer()
                end
                return
            end
            local Torso = p1:FindFirstChild("Torso")
            if not Torso then
                Torso = p1:WaitForChild("Torso", 5)
            end
            if not HumanoidRootPart or not Head or not Torso then
                warn("[ReplicationController] R6 character is missing a required body part:", p1:GetFullName())
                if p2 == game.Players.LocalPlayer then
                    CharacterLoaded:FireServer()
                end
                return
            end
            local Neck = Torso:FindFirstChild("Neck")
            if not Neck then
                Neck = Torso:WaitForChild("Neck", 5)
            end
            if not Neck then
                warn("[ReplicationController] R6 character is missing Torso.Neck:", p1:GetFullName())
                if p2 == game.Players.LocalPlayer then
                    CharacterLoaded:FireServer()
                end
                return
            end
            local v2 = Head:Clone()
            v2:ClearAllChildren()
            v2.Name = "HEADCOPY"
            v2.Transparency = 1
            v2.CollisionGroup = "Player"
            local v3 = Neck:Clone()
            v3.Name = "NeckClone"
            v3.Part1 = v2
            v3.C0 = Neck.C0
            v3.C1 = Neck.C1
            v3.Parent = Torso
            v2.Parent = p1
            u137[p2].HeadCopy = v2
            u137[p2].Head = Head
            u137[p2].HRP = HumanoidRootPart
            local v4 = u137[p2]
            v4.RootJoint = HumanoidRootPart:WaitForChild("RootJoint", 5)
            v4 = u137[p2]
            v4.Shoulders = {}
            v4 = u137[p2]
            v4.LastLookAngleTick = 0
            v4 = Torso:WaitForChild("Left Shoulder", 5)
            local v5 = Torso:WaitForChild("Right Shoulder", 5)
            if v4 then
                table.insert(u137[p2].Shoulders, v4)
            end
            if v5 then
                table.insert(u137[p2].Shoulders, v5)
            end
            if p2 ~= game.Players.LocalPlayer then
                v1 = u137[p2]
                v1.Animator = CharacterAnimator.new(p1, false)
                if u137[p2].Animator then
                    u137[p2].Animator:SetRaycastParams(RaycastUtil:GetAltRaycastParams())
                    Animator = u137[p2].Animator
                    local v6 = peek(Settings.Graphics.ProceduralAnimations)
                    if v6 then
                        local v7
                        if Value then
                            v7 = workspace.Values:GetAttribute("LobbyReliefIK") == true
                        else
                            v7 = false
                        end
                        v6 = not v7
                    end
                    Animator:SetIKEnabled(v6)
                end
                local Humanoid_2 = p1:FindFirstChildOfClass("Humanoid")
                local Animator_2 = Humanoid_2
                if Animator_2 then
                    Animator_2 = Humanoid_2:FindFirstChildOfClass("Animator")
                end
                if Animator_2 then
                    Animator_2.AnimationPlayed:Connect(function(p1) -- Line: 329 -- upvalues: u140 (upval)
                        if p1.Animation and p1.Animation.Name == "Animation" and u140[p1.Animation.AnimationId] then
                            p1:Stop(0)
                        end
                    end)
                end
            end
            v1 = u137[p2]
            v1.LookAttachment = Instance.new("Attachment")
            u137[p2].LookAttachment.WorldCFrame = Torso.CFrame + Torso.CFrame.LookVector * 3
            if p2 ~= game.Players.LocalPlayer then
                Terrain = HumanoidRootPart
            else
                Terrain = workspace.Terrain
            end
            u137[p2].LookAttachment.Parent = Terrain
            u137[p2].Neck = Neck
            v1 = u137[p2]
            v1.NeckCF = CFrame.new()
            if p2 ~= game.Players.LocalPlayer then
                u137[p2].LookAttachment.CFrame = CFrame.new(0, 0, -5)
                v1 = u137[p2]
                v1.LookGoal = 0
                v1 = u137[p2]
                v1.YawGoal = 0
            end
            if p2 == game.Players.LocalPlayer then
                if p2 ~= game.Players.LocalPlayer then
                    return
                end
                CharacterLoaded:FireServer()
                return
            end
            local Vehicle = p1:WaitForChild("Vehicle", 2)
            if Vehicle then
                Vehicle:Destroy()
            end
        end
        local function PlrAdded(p1) -- Line: 364 -- upvalues: u136 (upval), u135 (upval), Players (upval), u137 (upval), CharAdded (val), u139 (upval)
            u136[p1.Name] = p1
            local Character = p1.Character
            if not Character then
                Character = p1.CharacterAdded:Wait()
            end
            if u135 then
                u137[p1] = {LastLookAngleTick = 0, Update = os.clock()}
                CharAdded(Character, p1)
            elseif Players.LocalPlayer == p1 then
                u137[p1] = {LastLookAngleTick = 0, Update = os.clock()}
                CharAdded(Character, p1)
            end
            p1.CharacterAdded:Connect(function(a1) -- Line: 372 -- upvalues: u135 (upval), Players (upval), p1 (val), CharAdded (upval)
                if u135 then
                    CharAdded(a1, p1)
                elseif Players.LocalPlayer == p1 then
                    CharAdded(a1, p1)
                end
            end)
            u139 = #Players:GetPlayers()
        end
        for i, j in Players:GetPlayers() do
            task.defer(function() -- Line: 382 -- upvalues: PlrAdded (val), j (val)
                PlrAdded(j)
            end)
        end
        game.Players.PlayerAdded:Connect(PlrAdded)
        game.Players.PlayerRemoving:Connect(function(p1) -- Line: 388 -- upvalues: u139 (upval), Players (upval), cleanPlayer (val)
            u139 = #Players:GetPlayers()
            cleanPlayer(p1)
        end)
        FrameworkEvents.HitReplication:SetClientListener(function(p1) -- Line: 393 -- upvalues: u137 (upval), BulletUtil (upval), ClassMirror (upval)
            local Damage, Position, Position_2, Weapon, v1, v2, v3, v4, v5, v6, v7
            local v8 = nil
            local WorldModel = nil
            local v9 = nil
            local v10 = {}
            local v11 = nil
            local v12 = p1
            local v13 = nil
            local v14 = nil
            for i, j in v12, v13, v14 do
                if i == 1 then
                    v8 = j
                    if not (u137[v8]) then
                        WorldModel = nil
                    else
                        WorldModel = u137[v8].WorldModel
                    end
                    if not WorldModel then
                        return
                    end
                    Weapon = WorldModel.Weapon
                    if Weapon then
                        Weapon = WorldModel.Weapon.Config
                    end
                    v11 = Weapon
                elseif typeof(j) ~= "Vector3" then
                    if string.sub(j, 1, 1) == "m" then
                        if v9 and v9.Model and v9.Model.Parent then
                            v1 = nil
                            v2 = nil
                            v3 = string.sub(j, 2)
                            if not v9.ArmorHPs then
                                if v9.UIDTable and v9.UIDTable[v3] then
                                    v1 = v9.UIDTable[v3]
                                end
                            elseif v9.ArmorHPs[v3] then
                                v1 = v9.Model[v9.ArmorHPs[v3][2]]
                                v2 = true
                            end
                            if not v1 then
                                return
                            end
                            v4 = RaycastParams.new()
                            v4.FilterType = Enum.RaycastFilterType.Include
                            v4.FilterDescendantsInstances = {v1}
                            v5 = v1.Position - u137[v8].HRP.Position
                            v6 = workspace:Raycast(u137[v8].HRP.Position, v5, v4)
                            Position = if v6 then v6.Position else v1.Position + v5.Unit * -0.5
                            if v9.Flinch then
                                Position_2 = u137[v8].HRP.Position
                                if not v11 then
                                    Damage = 5
                                else
                                    Damage = v11.Damage
                                end
                                v9:Flinch(Position, Position_2, Damage / v9.MaxHP)
                            end
                            if not v2 and v11 then
                                v7 = v11
                                if not v7 then
                                    v7 = {}
                                end
                                BulletUtil:BloodNPC(v7, v9.UID, v3)
                            end
                            continue
                        end
                        return
                    end
                    v9 = ClassMirror:GetObjFromId(j)
                else
                    table.insert(v10, j)
                end
            end
            if WorldModel and v11 and not v11.IsMelee then
                WorldModel.Weapon:Shoot(v10)
                WorldModel.Weapon.LastShotTime = os.clock()
            end
        end)
        FrameworkEvents.MeleeSwing:SetClientListener(function(p1) -- Line: 466 -- upvalues: u137 (upval)
            local WorldModel, v1, v2
            v1, v2 = unpack(p1)
            if not (u137[v1]) then
                WorldModel = nil
            else
                WorldModel = u137[v1].WorldModel
            end
            if WorldModel and WorldModel.Weapon then
                WorldModel.Weapon:Melee(v2)
            end
        end)
        FrameworkEvents.Reloading:SetClientListener(function(p1) -- Line: 474 -- upvalues: u137 (upval)
            local v1 = p1[1]
            if u137[v1] and u137[v1].WorldModel and u137[v1].WorldModel.Weapon then
                u137[v1].WorldModel.Weapon:Reload(not p1[2])
            end
        end)
        u22.LookAngleEvent.On(function(p1) -- Line: 481 -- upvalues: u137 (upval)
            local States, v1
            local v2 = u137[p1.Player]
            if not v2 then
                return
            end
            local v3 = v2.LastLookAngleTick or 0
            if p1.ClientTick < v3 then
                return
            end
            v2.LastLookAngleTick = p1.ClientTick
            if not v2.Animator then
                States = nil
            else
                States = v2.Animator.States
            end
            if not States then
                v1 = 0.3
            elseif not States.Proning then
                v1 = 0.3
            else
                v1 = 0.1
            end
            v2.LookGoal = math.clamp(p1.Pitch + v1, -1.4, 1.4)
            v2.YawGoal = math.clamp(p1.Yaw, -1.57, 1.57)
        end)
        local u57 = 0
        RunService.Stepped:Connect(function(p1, p2) -- Line: 502 -- upvalues: u137 (upval), Players (upval)
            local v1 = u137
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                if i ~= Players.LocalPlayer and j.Animator and i.Parent then
                    j.Animator:UpdateStepped(p2)
                end
            end
        end)
        RunService:BindToRenderStep("REPLICATION", u160, function(p1) -- Line: 510 -- upvalues: u155 (upval), CurrentCamera (upval), Players (upval), u156 (upval), u157 (upval), u57 (ref), u22 (upval), u137 (upval), u139 (upval), PlayerHandler (upval), u205 (upval), u199 (upval), u174 (upval), RaycastUtil (upval), u61 (upval), ReplicatedStorage (upval), TweenService (upval), u237 (upval), CreateMirroredArmModel (upval), u270 (upval), u248 (upval), u259 (upval), u281 (upval), cleanPlayer (val)
            local AimTwistAngle, Angles, C0, Diving, Equipped, Equipped_2, HRP, HRPWeld, HRPWeldBase, HRPWeld_2, HRPWeld_3, HRPWeld_4, HRPWeld_5, HRPWeld_6, LastShotTime, LocalPlayer, LookAttachment, LookAttachment_2, LookAttachment_3, Model, Model_2, Name, NeckCF, OffHandEquipped, OffHandWorldModel_2, PlayerState, Proning, QuickSwapActive_2, QuickSwapActive_3, RecoilOffset, RecoilOffset_2, ReplicationOffset, RootJoint, SecondaryEquipped, SecondaryEquipped_2, SecondaryWorldModel_2, Shoulders, Shoulders_2, Unit, Weapon, Weapon_2, Weapon_3, Weapon_4, Weapon_5, Weapon_6, Weapon_7, Weapon_8, Weapon_9, Weld, Weld_2, Weld_3, WeldedShoulders, WeldedShoulders_2, WeldedShoulders_3, WeldedShoulders_4, WorldModel_2, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31, v32, v33, v34
            if u155 < os.clock() then
                v1 = CurrentCamera.CFrame:ToOrientation()
                LocalPlayer = Players.LocalPlayer
                local Character = LocalPlayer
                if Character then
                    Character = LocalPlayer.Character
                    if Character then
                        Character = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    end
                end
                v27 = 0
                if Character then
                    Unit = (Character.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
                    local Unit_2 = (CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
                    v32 = Unit_2:Cross(Unit)
                    v33 = Unit_2:Dot(Unit)
                    v27 = math.atan2(v32.Y, v33)
                end
                u155 = os.clock() + 0.1
                v30 = not u156
                if not v30 then
                    v31 = math.abs(u156 - v1)
                    v30 = 0.05 < v31
                end
                v31 = not u157
                if not v31 then
                    v32 = math.abs(u157 - v27)
                    v31 = 0.05 < v32
                end
                if v30 then
                    u57 = u57 + 1
                    u156 = v1
                    u157 = v27
                    u22.UpdateLookAngle.Fire({Pitch = math.clamp(v1, -1.4, 1.4), Yaw = math.clamp(v27, -1.57, 1.57), ClientTick = u57})
                elseif not v31 then
                end
            end
            v1 = u137
            local v35 = nil
            local v36 = nil
            local v37 = p1
            for i, j in v1, v35, v36 do
                if not i.Parent then
                    cleanPlayer(i)
                elseif i == Players.LocalPlayer then
                    v31 = i:DistanceFromCharacter(workspace.CurrentCamera.CFrame.p) or (1 / 0)
                    if i == Players.LocalPlayer then
                        v32 = v37
                    elseif u137[i].LastTick then
                        v32 = os.clock() - u137[i].LastTick
                    end
                    v33 = math.clamp(v32 * 10, 0.01, 1)
                    v34 = u137[i]
                    v34.LastTick = os.clock()
                    v2 = math.pow(u139, 4) * 0.01
                    v34 = math.clamp(v2, 1, 4)
                    HRP = j.HRP
                    if not HRP then
                        v3 = false
                    elseif HRP.Parent then
                        v6 = HRP.Position - CurrentCamera.CFrame.Position
                        v7 = CurrentCamera.FieldOfView + 2
                        v4 = not (math.floor((math.deg((v6.Unit:Angle(CurrentCamera.CFrame.LookVector))))) > v7)
                        if v4 then
                            v3 = true
                        end
                    end
                    v4 = u137[i]
                    v9 = v31 / 100 * 0.1
                    v8 = math.max(v9, 0.016666666666666666)
                    v4.Update = os.clock() + v34 * math.clamp(v8, 0, 1)
                    PlayerState = PlayerHandler:GetPlayerState(i)
                    if PlayerState then
                        RootJoint = j.RootJoint
                        if RootJoint and HRP and RootJoint.Parent and HRP.Parent and v3 then
                            if j.Animator then
                                j.Animator:SetState(PlayerState)
                                Equipped = PlayerState.Equipped
                                if Equipped then
                                    Equipped = PlayerState.Equipped ~= ""
                                end
                                j.Animator:SetWeaponEquipped(Equipped)
                                j.Animator:Heartbeat(v32)
                                j.Animator:UpdateRenderStepped(v32, v31)
                            end
                            if i ~= Players.LocalPlayer then
                                Proning = PlayerState.Proning
                                Diving = PlayerState.Diving
                                v7 = -HRP.Velocity:Dot(HRP.CFrame.RightVector)
                                if not Diving then
                                    v8 = CFrame.new()
                                else
                                    v10 = math.clamp(v7, -1.0471975511965976, 1.0471975511965976)
                                    v8 = CFrame.Angles(0, v10, 0)
                                end
                                C0 = RootJoint.C0
                                if not Proning then
                                    v11 = u205 * v8
                                    if not v11 then
                                        v11 = u199
                                    end
                                elseif not Diving then
                                end
                                RootJoint.C0 = C0:Lerp(v11, v33)
                            end
                        end
                        if j.NeckCF and j.Neck then
                            NeckCF = j.NeckCF
                            if not PlayerState.Aiming then
                                v7 = CFrame.new()
                            else
                                v7 = CFrame.Angles(0, 0.3, 0)
                            end
                            j.NeckCF = NeckCF:Lerp(v7, v33)
                            j.Neck.C1 = u174 * j.NeckCF
                        end
                        if i ~= Players.LocalPlayer then
                            v5 = u137[i].YawGoal or 0
                            v6 = u137[i].LookGoal or 0
                            if u137[i].LookAttachment then
                                LookAttachment_3 = u137[i].LookAttachment
                                v9 = CFrame.Angles(v6, v5, 0)
                                LookAttachment_3.CFrame = v9 * CFrame.new(0, 0, -5)
                                if j.Animator then
                                    j.Animator:SetLookPoint(u137[i].LookAttachment.WorldPosition)
                                    j.Animator:SetYaw(v5)
                                end
                                v9 = u137[i].LookAttachment.WorldPosition - u137[i].Head.Position
                                u61:UpdatePlayerLookDirection(v9, i)
                                local HeadCopy = j.HeadCopy
                                Equipped_2 = PlayerState.Equipped
                                local WepId = PlayerState.WepId
                                v11 = j._lastQuickSwapActive or false
                                QuickSwapActive_2 = PlayerState.QuickSwapActive
                                SecondaryEquipped = PlayerState.SecondaryEquipped
                                if j._promotedToEquipped then
                                    v12 = false
                                    if Equipped_2 == j._promotedToEquipped then
                                        v12 = true
                                    elseif Equipped_2 ~= j._waitingForEquippedFrom then
                                        v12 = true
                                    elseif j._promotionTimestamp then
                                        v14 = os.clock() - j._promotionTimestamp
                                        if 2 < v14 then
                                            v12 = true
                                        end
                                    end
                                    if v12 then
                                        j._promotedToEquipped = nil
                                        j._waitingForEquippedFrom = nil
                                        j._promotionTimestamp = nil
                                    end
                                end
                                if v11 and not QuickSwapActive_2 then
                                    if SecondaryEquipped == false then
                                        if j.SecondaryWorldModel and j.SecondaryWorldModel.Weapon then
                                            v13 = Equipped_2 ~= j.SecondaryWorldModel.Equipped
                                            if not v13 then
                                                if j.WorldModel then
                                                    DestroyModel(j)
                                                end
                                                j.WorldModel = j.SecondaryWorldModel
                                                j.SecondaryWorldModel = nil
                                                j._promotedToEquipped = j.WorldModel.Equipped
                                                j._waitingForEquippedFrom = Equipped_2
                                                j._promotionTimestamp = os.clock()
                                                Model_2 = j.WorldModel.Weapon.Viewmodel.Model
                                                Weapon_2 = j.WorldModel.Weapon
                                                WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                if not WeldedShoulders_3 then
                                                    WeldedShoulders_3 = {}
                                                end
                                                j.WorldModel.WeldedShoulders = WeldedShoulders_3
                                                Shoulders_2 = j.Shoulders
                                                v16 = nil
                                                v17 = nil
                                                for k, n in Shoulders_2, v16, v17 do
                                                    if n and n.Part1 then
                                                        if not Weapon_2.Config.ArmIgnores then
                                                            v19 = false
                                                            WeldedShoulders_4 = j.WorldModel.WeldedShoulders
                                                            v21 = nil
                                                            v22 = nil
                                                            for m, i5 in WeldedShoulders_4, v21, v22 do
                                                                if i5 == n then
                                                                    v19 = true
                                                                    break
                                                                end
                                                            end
                                                            if not v19 then
                                                                v20 = Model_2:FindFirstChild(n.Part1.Name)
                                                                if v20 then
                                                                    Weld_3 = Instance.new("Weld")
                                                                    Weld_3.Part0 = n.Part1
                                                                    Weld_3.Part1 = v20
                                                                    v22 = 3 < v20.Size.Y
                                                                    if not v22 then
                                                                        v23 = CFrame.new()
                                                                    else
                                                                        v23 = CFrame.new(0, -1, 0)
                                                                    end
                                                                    Weld_3.C1 = v23
                                                                    Weld_3.Parent = Model_2
                                                                    table.insert(j.WorldModel.WeldedShoulders, n)
                                                                end
                                                            end
                                                            n.Enabled = false
                                                        elseif Weapon_2.Config.ArmIgnores[n.Name] then
                                                        end
                                                    end
                                                end
                                                if not Weapon_2.HRPWeld then
                                                    Model_2.HumanoidRootPart.Anchored = false
                                                    Weld_2 = Instance.new("Weld")
                                                    Weld_2.Part0 = Model_2.HumanoidRootPart
                                                    Weld_2.Part1 = HeadCopy
                                                    ReplicationOffset = Weapon_2.Config.ReplicationOffset
                                                    if not ReplicationOffset then
                                                        ReplicationOffset = CFrame.new()
                                                    end
                                                    Weld_2.C0 = Weld_2.C0 * ReplicationOffset
                                                    Weld_2.Parent = Model_2
                                                    Weapon_2.HRPWeldBaseC1 = Weld_2.C1
                                                    Weapon_2.HRPWeldBase = Weld_2.C0
                                                    Weapon_2.HRPWeldBaseC0 = Weld_2.C0
                                                    Weapon_2.HRPWeld = Weld_2
                                                end
                                                Weapon_2.IsMirrored = false
                                                Weapon_2.IsSecondary = false
                                            else
                                                DestroySecondaryModel(j)
                                                if j.WorldModel and j.WorldModel.Weapon then
                                                    Model = j.WorldModel.Weapon.Viewmodel.Model
                                                    Weapon = j.WorldModel.Weapon
                                                    WeldedShoulders = j.WorldModel.WeldedShoulders
                                                    if not WeldedShoulders then
                                                        WeldedShoulders = {}
                                                    end
                                                    j.WorldModel.WeldedShoulders = WeldedShoulders
                                                    Shoulders = j.Shoulders
                                                    v16 = nil
                                                    v17 = nil
                                                    for i6, i7 in Shoulders, v16, v17 do
                                                        if i7 and i7.Part1 then
                                                            if not Weapon.Config.ArmIgnores then
                                                                v19 = Model:FindFirstChild(i7.Part1.Name)
                                                                if v19 then
                                                                    v20 = false
                                                                    for i8, i9 in Model:GetChildren() do
                                                                        if i9:IsA("Weld") and i9.Part0 == i7.Part1 and i9.Part1 == v19 then
                                                                            v20 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v20 then
                                                                        Weld = Instance.new("Weld")
                                                                        Weld.Part0 = i7.Part1
                                                                        Weld.Part1 = v19
                                                                        v22 = 3 < v19.Size.Y
                                                                        if not v22 then
                                                                            v23 = CFrame.new()
                                                                        else
                                                                            v23 = CFrame.new(0, -1, 0)
                                                                        end
                                                                        Weld.C1 = v23
                                                                        Weld.Parent = Model
                                                                    end
                                                                    v21 = false
                                                                    WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                    v23 = nil
                                                                    v24 = nil
                                                                    for i10, i11 in WeldedShoulders_2, v23, v24 do
                                                                        if i11 == i7 then
                                                                            v21 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v21 then
                                                                        table.insert(j.WorldModel.WeldedShoulders, i7)
                                                                    end
                                                                end
                                                                i7.Enabled = false
                                                            elseif Weapon.Config.ArmIgnores[i7.Name] then
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    elseif SecondaryEquipped ~= "" then
                                    end
                                end
                                j._lastQuickSwapActive = QuickSwapActive_2
                                if not Equipped_2 then
                                    if j.WorldModel then
                                        DestroyModel(j)
                                    end
                                elseif Equipped_2 ~= "" and HeadCopy then
                                    if not j.WorldModel then
                                        j.WorldModel = {}
                                    end
                                    v12 = j._promotedToEquipped ~= nil
                                    Weapon_3 = not v12
                                    if Weapon_3 then
                                        Weapon_3 = false
                                        if j.WorldModel.RetryAfter or 0 <= os.clock() then
                                            Weapon_3 = true
                                            if j.WorldModel.Equipped == Equipped_2 then
                                                Weapon_3 = j.WorldModel.Weapon
                                                if Weapon_3 then
                                                    Weapon_3 = j.WorldModel.Weapon.WepId
                                                    if Weapon_3 then
                                                        Weapon_3 = j.WorldModel.Weapon.WepId ~= WepId
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    if Weapon_3 then
                                        if j.WorldModel then
                                            DestroyModel(j)
                                        end
                                        j.WorldModel.Equipped = Equipped_2
                                        local QuickSwapActive = PlayerState.QuickSwapActive
                                        local DualWieldActive = PlayerState.DualWieldActive
                                        local OffHandActive = PlayerState.OffHandActive
                                        local WorldModel = j.WorldModel
                                        WorldModel_2 = j.WorldModel
                                        WorldModel_2.Promise = GetWeapon(Equipped_2, nil, i)
                                        v17 = j.WorldModel.Promise:andThen(function(p1) -- Line: 884 -- upvalues: j (val), WorldModel (val), WepId (val), ReplicatedStorage (upval), HeadCopy (val), QuickSwapActive (val), DualWieldActive (val), OffHandActive (val)
                                            local Weld_3, v1, v2, v3, v4, v5, v6, v7
                                            if j.WorldModel ~= WorldModel then
                                                p1.Viewmodel:Destroy()
                                                return
                                            end
                                            p1.WepId = WepId
                                            local Model = p1.Viewmodel.Model
                                            WorldModel.Model = Model
                                            Model.HumanoidRootPart.Anchored = false
                                            local IsAPistol = p1.Config.IsAPistol
                                            if not p1.Config.BulletsPerShot then
                                                v6 = false
                                            elseif 5 <= p1.Config.BulletsPerShot then
                                                v6 = true
                                            end
                                            if p1.Config.LODModel then
                                                v7 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                            elseif IsAPistol then
                                                v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                            elseif v6 then
                                                v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                            elseif not p1.Config.IsMelee then
                                                v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                            else
                                                v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                            end
                                            local Weld = Instance.new("Weld")
                                            Weld.Part0 = v7.Handle
                                            Weld.Part1 = Model.KeyParts.Handle
                                            local LODOffset = p1.Config.LODOffset
                                            if not LODOffset then
                                                LODOffset = CFrame.new()
                                            end
                                            Weld.C0 = Weld.C0 * LODOffset
                                            Weld.Parent = v7
                                            v7.Parent = nil
                                            local Weld_2 = Instance.new("Weld")
                                            Weld_2.Part0 = Model.HumanoidRootPart
                                            Weld_2.Part1 = HeadCopy
                                            local ReplicationOffset = p1.Config.ReplicationOffset
                                            if not ReplicationOffset then
                                                ReplicationOffset = CFrame.new()
                                            end
                                            Weld_2.C0 = Weld_2.C0 * ReplicationOffset
                                            Weld_2.Parent = Model
                                            p1.HRPWeldBaseC1 = Weld_2.C1
                                            p1.HRPWeldBase = Weld_2.C0
                                            p1.HRPWeldBaseC0 = Weld_2.C0
                                            p1.HRPWeld = Weld_2
                                            j.WorldModel.LowPolyModel = v7
                                            j.WorldModel.HighPolyModel = Model.Weapon
                                            j.WorldModel.Attachments = Model.Attachments
                                            local Children = Model.KeyParts:GetChildren()
                                            function j.WorldModel.HideKeyparts(p1) -- Line: 941 -- upvalues: Children (val), Model (val)
                                                local KeyParts
                                                local v1 = Children
                                                local v2 = nil
                                                local v3 = nil
                                                local v4 = p1
                                                for i, j in v1, v2, v3 do
                                                    if not (j:IsA("BasePart")) then
                                                        if not v4 then
                                                            KeyParts = Model.KeyParts
                                                        else
                                                            KeyParts = nil
                                                        end
                                                        j.Parent = KeyParts
                                                    end
                                                end
                                            end
                                            Model.Parent = workspace.Ignore
                                            Model["Left Arm"].Transparency = 1
                                            Model["Right Arm"].Transparency = 1
                                            j.WorldModel.WeldedShoulders = {}
                                            local Shoulders = j.Shoulders
                                            local v8 = nil
                                            local v9 = nil
                                            v1 = p1
                                            for i, j2 in Shoulders, v8, v9 do
                                                if j2 and j2.Part1 then
                                                    if not v1.Config.ArmIgnores then
                                                        v2 = Model:FindFirstChild(j2.Part1.Name)
                                                        if v2 then
                                                            v3 = j2.Name == "Left Shoulder"
                                                            if QuickSwapActive then
                                                                if not v3 then
                                                                    Weld_3 = Instance.new("Weld")
                                                                    Weld_3.Part0 = j2.Part1
                                                                    Weld_3.Part1 = v2
                                                                    v4 = 3 < v2.Size.Y
                                                                    if not v4 then
                                                                        v5 = CFrame.new()
                                                                    else
                                                                        v5 = CFrame.new(0, -1, 0)
                                                                    end
                                                                    Weld_3.C1 = v5
                                                                    Weld_3.Parent = Model
                                                                    j2.Enabled = false
                                                                    table.insert(j.WorldModel.WeldedShoulders, j2)
                                                                elseif j2 then
                                                                    j2.Enabled = false
                                                                    table.insert(j.WorldModel.WeldedShoulders, j2)
                                                                end
                                                            elseif not DualWieldActive and not OffHandActive then
                                                            end
                                                        end
                                                    elseif v1.Config.ArmIgnores[j2.Name] then
                                                    end
                                                end
                                            end
                                            j.WorldModel.Weapon = v1
                                            v1:Equip()
                                        end)
                                        v17:catch(function(p1) -- Line: 1002 -- upvalues: j (val), WorldModel (val), WepId (val)
                                            if j.WorldModel == WorldModel then
                                                local v1 = tostring(WepId)
                                                warn("[ReplicationController] Failed to create world weapon " .. v1 .. ": " .. tostring(p1))
                                                DestroyModel(j)
                                                j.WorldModel.RetryAfter = os.clock() + 2
                                            end
                                        end)
                                    elseif j.WorldModel and j.WorldModel.Weapon then
                                        Weapon_4 = j.WorldModel.Weapon
                                        if not PlayerState.Sprinting then
                                            if Weapon_4.Sprinting then
                                                Weapon_4.Sprinting = false
                                                HRPWeld_2 = Weapon_4.HRPWeld
                                                v17 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                                                TweenService:Create(HRPWeld_2, v17, {C1 = Weapon_4.HRPWeldBaseC1}):Play()
                                            end
                                        elseif not Weapon_4.Sprinting then
                                            Weapon_4.Sprinting = true
                                            HRPWeld = Weapon_4.HRPWeld
                                            v17 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                                            TweenService:Create(HRPWeld, v17, {C1 = Weapon_4.HRPWeldBaseC1 * CFrame.Angles(-0.4, 0, 0)}):Play()
                                        end
                                        if j.Animator and Weapon_4.HRPWeldBaseC0 then
                                            AimTwistAngle = j.Animator:GetAimTwistAngle()
                                            Weapon_4.aimTwistAngle = AimTwistAngle
                                            v15 = j.LookGoal or 0
                                            v16 = math.clamp(v15 / 1.5707963267948966, 0, 1)
                                            if not PlayerState.Aiming then
                                                v17 = 0.5
                                            else
                                                v17 = 0.8
                                            end
                                            v15 = v15 * v17
                                            if not PlayerState.Proning then
                                                v17 = 0
                                            else
                                                v17 = 1.5707963267948966
                                            end
                                            RecoilOffset = Weapon_4.RecoilOffset
                                            if not RecoilOffset then
                                                RecoilOffset = CFrame.identity
                                            end
                                            Weapon_4.RecoilOffset = RecoilOffset:Lerp(CFrame.identity, v33)
                                            v22 = Weapon_4.HRPWeldBaseC0 * Weapon_4.RecoilOffset
                                            if not PlayerState.Proning then
                                                v23 = CFrame.new()
                                            else
                                                v23 = CFrame.new(0, -1, -1)
                                            end
                                            v21 = v22 * v23
                                            v22 = CFrame.new()
                                            if PlayerState.Proning then
                                                v24 = CFrame.new()
                                            else
                                                v24 = CFrame.new(0, 0, -0.5)
                                            end
                                            v20 = v21 * v22:Lerp(v24, v16)
                                            v19 = v20 * CFrame.Angles(-v17, 0, 0)
                                            v18 = v19 * CFrame.Angles(-v15, 0, 0)
                                            Angles = CFrame.Angles
                                            v20 = 0
                                            if PlayerState.Proning then
                                                v21 = 0
                                            else
                                                v21 = -AimTwistAngle
                                            end
                                            Weapon_4.HRPWeldBase = v18 * Angles(v20, v21, 0)
                                            LastShotTime = Weapon_4.LastShotTime
                                            if LastShotTime then
                                                v19 = os.clock() - Weapon_4.LastShotTime
                                                LastShotTime = v19 < 2
                                            end
                                            v19 = not PlayerState.Aiming
                                            if v19 then
                                                v19 = not PlayerState.Sprinting
                                                if v19 then
                                                    v19 = not LastShotTime
                                                    if v19 then
                                                        v19 = not PlayerState.Proning
                                                        if v19 then
                                                            v19 = not PlayerState.QuickSwapActive
                                                            if v19 then
                                                                v19 = not PlayerState.DualWieldActive
                                                                if v19 then
                                                                    v19 = not PlayerState.OffHandActive
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                            Weapon_4.GunRestAlpha = Weapon_4.GunRestAlpha or 0
                                            if not v19 then
                                                v20 = 0
                                            else
                                                v20 = 1
                                            end
                                            Weapon_4.GunRestAlpha = Weapon_4.GunRestAlpha + (v20 - Weapon_4.GunRestAlpha) * v33 * 0.3
                                            Weapon_4.HRPWeldBase = Weapon_4.HRPWeldBase * CFrame.new():Lerp(u237, Weapon_4.GunRestAlpha)
                                            HRPWeld_3 = Weapon_4.HRPWeld
                                            HRPWeld_3.C0 = Weapon_4.HRPWeld.C0:Lerp(Weapon_4.HRPWeldBase, v33)
                                        end
                                        if PlayerState.Charging then
                                            j.WorldModel.Weapon:Charging()
                                        end
                                        if PlayerState.Blocking then
                                            j.WorldModel.Weapon:Blocking()
                                        elseif j.WorldModel.Weapon.Block then
                                            j.WorldModel.Weapon:StopBlocking()
                                        end
                                        if not v3 then
                                            if 5 < v31 then
                                                j.WorldModel.Weapon.LowPolyMode = true
                                                if j.WorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                    j.WorldModel.Attachments.Parent = nil
                                                end
                                                j.WorldModel.HideKeyparts(true)
                                                j.WorldModel.HighPolyModel.Parent = nil
                                                j.WorldModel.LowPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                            end
                                        elseif v31 <= math.exp(u139 * -0.3) * 50 + 10 then
                                            j.WorldModel.Weapon.LowPolyMode = false
                                            j.WorldModel.HighPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                            j.WorldModel.Attachments.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                            j.WorldModel.LowPolyModel.Parent = nil
                                            j.WorldModel.HideKeyparts(false)
                                        end
                                    end
                                end
                                SecondaryEquipped_2 = PlayerState.SecondaryEquipped
                                local SecondaryWepId = PlayerState.SecondaryWepId
                                QuickSwapActive_3 = PlayerState.QuickSwapActive
                                local DualWieldActive_2 = PlayerState.DualWieldActive
                                v15 = SecondaryEquipped_2
                                if v15 then
                                    v15 = if SecondaryEquipped_2 ~= "" then SecondaryEquipped_2 ~= false else false
                                end
                                if j.SecondaryWorldModel and j.SecondaryWorldModel.Weapon ~= nil then end
                                if not v15 then
                                    if j.SecondaryWorldModel then
                                        DestroySecondaryModel(j)
                                    end
                                elseif HeadCopy then
                                    if not j.SecondaryWorldModel then
                                        j.SecondaryWorldModel = {}
                                    end
                                    Weapon_5 = true
                                    if j.SecondaryWorldModel.Equipped == SecondaryEquipped_2 then
                                        if not j.SecondaryWorldModel.Weapon then
                                            Weapon_5 = j.SecondaryWorldModel.Weapon
                                            if Weapon_5 then
                                                Weapon_5 = j.SecondaryWorldModel.Weapon.IsMirrored ~= DualWieldActive_2
                                            end
                                        elseif j.SecondaryWorldModel.Weapon.WepId then
                                            Weapon_5 = true
                                            if j.SecondaryWorldModel.Weapon.WepId ~= SecondaryWepId then end
                                        end
                                    end
                                    if Weapon_5 then
                                        if j.SecondaryWorldModel and j.SecondaryWorldModel.Weapon then
                                            DestroySecondaryModel(j)
                                            j.SecondaryWorldModel = {}
                                        end
                                        j.SecondaryWorldModel.Equipped = SecondaryEquipped_2
                                        local SecondaryWorldModel = j.SecondaryWorldModel
                                        SecondaryWorldModel_2 = j.SecondaryWorldModel
                                        SecondaryWorldModel_2.Promise = GetWeapon(SecondaryEquipped_2, nil, i)
                                        j.SecondaryWorldModel.Promise:andThen(function(p1) -- Line: 1170 -- upvalues: j (val), SecondaryWorldModel (val), SecondaryWepId (val), DualWieldActive_2 (val), ReplicatedStorage (upval), HeadCopy (val), CreateMirroredArmModel (upval), i (val)
                                            local v1, v2, v3
                                            if j.SecondaryWorldModel ~= SecondaryWorldModel then
                                                p1.Viewmodel:Destroy()
                                                return
                                            end
                                            p1.WepId = SecondaryWepId
                                            p1.IsSecondary = true
                                            p1.IsMirrored = DualWieldActive_2
                                            local Model = p1.Viewmodel.Model
                                            Model.HumanoidRootPart.Anchored = false
                                            local IsAPistol = p1.Config.IsAPistol
                                            if not p1.Config.BulletsPerShot then
                                                v2 = false
                                            elseif 5 <= p1.Config.BulletsPerShot then
                                                v2 = true
                                            end
                                            if p1.Config.LODModel then
                                                v3 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                            elseif IsAPistol then
                                                v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                            elseif v2 then
                                                v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                            elseif not p1.Config.IsMelee then
                                                v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                            else
                                                v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                            end
                                            local Weld = Instance.new("Weld")
                                            Weld.Part0 = v3.Handle
                                            Weld.Part1 = Model.KeyParts.Handle
                                            local LODOffset = p1.Config.LODOffset
                                            if not LODOffset then
                                                LODOffset = CFrame.new()
                                            end
                                            Weld.C0 = Weld.C0 * LODOffset
                                            Weld.Parent = v3
                                            v3.Parent = nil
                                            local ReplicationOffset = p1.Config.ReplicationOffset
                                            if not ReplicationOffset then
                                                ReplicationOffset = CFrame.new()
                                            end
                                            if not DualWieldActive_2 then
                                                local Weld_2 = Instance.new("Weld")
                                                Weld_2.Part0 = Model.HumanoidRootPart
                                                Weld_2.Part1 = HeadCopy
                                                Weld_2.C0 = Weld_2.C0 * ReplicationOffset
                                                Weld_2.Parent = Model
                                                p1.HRPWeldBaseC1 = Weld_2.C1
                                                p1.HRPWeldBase = Weld_2.C0
                                                p1.HRPWeldBaseC0 = Weld_2.C0
                                                p1.HRPWeld = Weld_2
                                            else
                                                Model.HumanoidRootPart.Anchored = true
                                                p1.HRPWeld = nil
                                                p1.HRPWeldBaseC0 = ReplicationOffset
                                                p1.HRPWeldBase = ReplicationOffset
                                                p1.HeadRef = HeadCopy
                                            end
                                            j.SecondaryWorldModel.LowPolyModel = v3
                                            j.SecondaryWorldModel.HighPolyModel = Model.Weapon
                                            j.SecondaryWorldModel.Attachments = Model.Attachments
                                            local Children = Model.KeyParts:GetChildren()
                                            function j.SecondaryWorldModel.HideKeyparts(p1) -- Line: 1241 -- upvalues: Children (val), Model (val)
                                                local KeyParts
                                                local v1 = Children
                                                local v2 = nil
                                                local v3 = nil
                                                local v4 = p1
                                                for i, j in v1, v2, v3 do
                                                    if not (j:IsA("BasePart")) then
                                                        if not v4 then
                                                            KeyParts = Model.KeyParts
                                                        else
                                                            KeyParts = nil
                                                        end
                                                        j.Parent = KeyParts
                                                    end
                                                end
                                            end
                                            Model.Parent = workspace.Ignore
                                            Model["Left Arm"].Transparency = 1
                                            Model["Right Arm"].Transparency = 1
                                            local v4 = {}
                                            j.SecondaryWorldModel.WeldedShoulders = v4
                                            j.SecondaryWorldModel.ArmModel = nil
                                            if DualWieldActive_2 then
                                                j.SecondaryWorldModel.ArmModel = CreateMirroredArmModel(Model, i)
                                                v1 = p1
                                            else
                                                local Weld_3, v5, v6, v7
                                                local Shoulders = j.Shoulders
                                                v4 = nil
                                                local v8 = nil
                                                v1 = p1
                                                for i2, j2 in Shoulders, v4, v8 do
                                                    if j2 and j2.Name == "Left Shoulder" and j2.Part1 then
                                                        if not v1.Config.ArmIgnores then
                                                            v5 = Model:FindFirstChild(j2.Part1.Name)
                                                            if not v5 then
                                                                continue
                                                            else
                                                                Weld_3 = Instance.new("Weld")
                                                                Weld_3.Part0 = j2.Part1
                                                                Weld_3.Part1 = v5
                                                                v6 = 3 < v5.Size.Y
                                                                if not v6 then
                                                                    v7 = CFrame.new()
                                                                else
                                                                    v7 = CFrame.new(0, -1, 0)
                                                                    if not v7 then
                                                                        v7 = CFrame.new()
                                                                    end
                                                                end
                                                                Weld_3.C1 = v7
                                                                Weld_3.Parent = Model
                                                                j2.Enabled = false
                                                                table.insert(j.SecondaryWorldModel.WeldedShoulders, j2)
                                                            end
                                                        elseif v1.Config.ArmIgnores[j2.Name] then
                                                            continue
                                                        end
                                                        j.SecondaryWorldModel.Weapon = v1
                                                        v1:Equip()
                                                        return
                                                    end
                                                end
                                            end
                                            j.SecondaryWorldModel.Weapon = v1
                                            v1:Equip()
                                        end)
                                    elseif j.SecondaryWorldModel and j.SecondaryWorldModel.Weapon then
                                        Weapon_6 = j.SecondaryWorldModel.Weapon
                                        if Weapon_6.HRPWeldBaseC0 then
                                            v18 = CFrame.new()
                                            if DualWieldActive_2 then
                                                v18 = u270
                                            elseif QuickSwapActive_3 then
                                                Weapon_6.QuickSwapAlpha = Weapon_6.QuickSwapAlpha or 0
                                                Weapon_6.QuickSwapAlpha = Weapon_6.QuickSwapAlpha + (1 - Weapon_6.QuickSwapAlpha) * v33 * 0.5
                                                v18 = CFrame.new():Lerp(u248, Weapon_6.QuickSwapAlpha)
                                            end
                                            v19 = j.LookGoal or 0
                                            v20 = math.clamp(v19 / 1.5707963267948966, 0, 1)
                                            if not PlayerState.Aiming then
                                                v21 = 0.5
                                            else
                                                v21 = 0.8
                                            end
                                            v19 = v19 * v21
                                            if not PlayerState.Proning then
                                                v21 = 0
                                            else
                                                v21 = 1.5707963267948966
                                            end
                                            RecoilOffset_2 = Weapon_6.RecoilOffset
                                            if not RecoilOffset_2 then
                                                RecoilOffset_2 = CFrame.identity
                                            end
                                            Weapon_6.RecoilOffset = RecoilOffset_2:Lerp(CFrame.identity, v33)
                                            if not QuickSwapActive_3 then
                                                v28 = Weapon_6.HRPWeldBaseC0 * v18
                                                v26 = v28 * Weapon_6.RecoilOffset
                                                if not PlayerState.Proning then
                                                    v28 = CFrame.new()
                                                else
                                                    v28 = CFrame.new(0, -1, -1)
                                                end
                                                v25 = v26 * v28
                                                v26 = CFrame.new()
                                                if PlayerState.Proning then
                                                    v29 = CFrame.new()
                                                else
                                                    v29 = CFrame.new(0, 0, -0.5)
                                                end
                                                v24 = v25 * v26:Lerp(v29, v20)
                                                v23 = v24 * CFrame.Angles(-v21, 0, 0)
                                                Weapon_6.HRPWeldBase = v23 * CFrame.Angles(-v19, 0, 0)
                                            else
                                                Weapon_6.HRPWeldBase = Weapon_6.HRPWeldBaseC0 * v18
                                            end
                                            if not Weapon_6.IsMirrored then
                                                if Weapon_6.HRPWeld then
                                                    HRPWeld_4 = Weapon_6.HRPWeld
                                                    HRPWeld_4.C0 = Weapon_6.HRPWeld.C0:Lerp(Weapon_6.HRPWeldBase, v33)
                                                end
                                            elseif Weapon_6.HeadRef then
                                                v23 = Weapon_6.HeadRef.CFrame * Weapon_6.HRPWeldBase
                                                v24 = CFrame.fromMatrix(v23.Position, v23.XVector * -1, v23.YVector, v23.ZVector)
                                                Weapon_6.Viewmodel.Model.HumanoidRootPart.CFrame = v24
                                            end
                                        end
                                        if not v3 then
                                            if 5 < v31 then
                                                j.SecondaryWorldModel.Weapon.LowPolyMode = true
                                                if j.SecondaryWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                    j.SecondaryWorldModel.Attachments.Parent = nil
                                                end
                                                j.SecondaryWorldModel.HideKeyparts(true)
                                                j.SecondaryWorldModel.HighPolyModel.Parent = nil
                                                j.SecondaryWorldModel.LowPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                            end
                                        elseif v31 <= math.exp(u139 * -0.3) * 50 + 10 then
                                            j.SecondaryWorldModel.Weapon.LowPolyMode = false
                                            j.SecondaryWorldModel.HighPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                            j.SecondaryWorldModel.Attachments.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                            j.SecondaryWorldModel.LowPolyModel.Parent = nil
                                            j.SecondaryWorldModel.HideKeyparts(false)
                                        end
                                    end
                                    if DualWieldActive_2 and j.WorldModel and j.WorldModel.Weapon then
                                        Weapon_7 = j.WorldModel.Weapon
                                        if Weapon_7.HRPWeldBaseC0 and Weapon_7.HRPWeldBase then
                                            HRPWeld_5 = Weapon_7.HRPWeld
                                            HRPWeld_5.C0 = Weapon_7.HRPWeld.C0:Lerp(Weapon_7.HRPWeldBase * u259, v33)
                                        end
                                    end
                                end
                                OffHandEquipped = PlayerState.OffHandEquipped
                                local OffHandWepId = PlayerState.OffHandWepId
                                v19 = OffHandEquipped
                                if v19 then
                                    v19 = if OffHandEquipped ~= "" then OffHandEquipped ~= false else false
                                end
                                if not v19 then
                                    if j.OffHandWorldModel then
                                        DestroyOffHandModel(j)
                                    end
                                elseif HeadCopy then
                                    if not j.OffHandWorldModel then
                                        j.OffHandWorldModel = {}
                                    end
                                    Weapon_8 = true
                                    if j.OffHandWorldModel.Equipped == OffHandEquipped then
                                        Weapon_8 = j.OffHandWorldModel.Weapon
                                        if Weapon_8 then
                                            Weapon_8 = j.OffHandWorldModel.Weapon.WepId ~= OffHandWepId
                                        end
                                    end
                                    if Weapon_8 then
                                        if j.OffHandWorldModel and j.OffHandWorldModel.Weapon then
                                            DestroyOffHandModel(j)
                                            j.OffHandWorldModel = {}
                                        end
                                        j.OffHandWorldModel.Equipped = OffHandEquipped
                                        local OffHandWorldModel = j.OffHandWorldModel
                                        OffHandWorldModel_2 = j.OffHandWorldModel
                                        OffHandWorldModel_2.Promise = GetWeapon(OffHandEquipped, nil, i)
                                        j.OffHandWorldModel.Promise:andThen(function(p1) -- Line: 1415 -- upvalues: j (val), OffHandWorldModel (val), OffHandWepId (val), ReplicatedStorage (upval), HeadCopy (val)
                                            local Model_2, Weld_3, v1, v2, v3, v4, v5
                                            if j.OffHandWorldModel ~= OffHandWorldModel then
                                                p1.Viewmodel:Destroy()
                                                return
                                            end
                                            p1.WepId = OffHandWepId
                                            p1.IsOffHand = true
                                            local Model = p1.Viewmodel.Model
                                            Model.HumanoidRootPart.Anchored = false
                                            local BulletsPerShot = p1.Config.BulletsPerShot
                                            if BulletsPerShot then
                                                BulletsPerShot = 5 <= p1.Config.BulletsPerShot
                                            end
                                            if p1.Config.LODModel then
                                                v5 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                            elseif p1.Config.IsAPistol then
                                                v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                            elseif BulletsPerShot then
                                                v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                            elseif not p1.Config.IsMelee then
                                                v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                            else
                                                v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                            end
                                            local Weld = Instance.new("Weld")
                                            Weld.Part0 = v5.Handle
                                            Weld.Part1 = Model.KeyParts.Handle
                                            local LODOffset = p1.Config.LODOffset
                                            if not LODOffset then
                                                LODOffset = CFrame.new()
                                            end
                                            Weld.C0 = Weld.C0 * LODOffset
                                            Weld.Parent = v5
                                            v5.Parent = nil
                                            local ReplicationOffset = p1.Config.ReplicationOffset
                                            if not ReplicationOffset then
                                                ReplicationOffset = CFrame.new()
                                            end
                                            local Weld_2 = Instance.new("Weld")
                                            Weld_2.Part0 = Model.HumanoidRootPart
                                            Weld_2.Part1 = HeadCopy
                                            Weld_2.C0 = Weld_2.C0 * ReplicationOffset
                                            Weld_2.Parent = Model
                                            p1.HRPWeldBaseC1 = Weld_2.C1
                                            p1.HRPWeldBase = Weld_2.C0
                                            p1.HRPWeldBaseC0 = Weld_2.C0
                                            p1.HRPWeld = Weld_2
                                            j.OffHandWorldModel.LowPolyModel = v5
                                            j.OffHandWorldModel.HighPolyModel = Model.Weapon
                                            j.OffHandWorldModel.Attachments = Model.Attachments
                                            local Children = Model.KeyParts:GetChildren()
                                            function j.OffHandWorldModel.HideKeyparts(p1) -- Line: 1470 -- upvalues: Children (val), Model (val)
                                                local KeyParts
                                                local v1 = Children
                                                local v2 = nil
                                                local v3 = nil
                                                local v4 = p1
                                                for i, j in v1, v2, v3 do
                                                    if not (j:IsA("BasePart")) then
                                                        if not v4 then
                                                            KeyParts = Model.KeyParts
                                                        else
                                                            KeyParts = nil
                                                        end
                                                        j.Parent = KeyParts
                                                    end
                                                end
                                            end
                                            Model.Parent = workspace.Ignore
                                            Model["Left Arm"].Transparency = 1
                                            Model["Right Arm"].Transparency = 1
                                            j.OffHandWorldModel.WeldedShoulders = {}
                                            local Shoulders = j.Shoulders
                                            local v6 = nil
                                            local v7 = nil
                                            v1 = p1
                                            for i, j2 in Shoulders, v6, v7 do
                                                if j2 and j2.Name == "Left Shoulder" and j2.Part1 then
                                                    if v1.Config.ArmIgnores and v1.Config.ArmIgnores[j2.Name] then
                                                        continue
                                                    end
                                                    v2 = Model:FindFirstChild(j2.Part1.Name)
                                                    if v2 then
                                                        if j.WorldModel and j.WorldModel.Weapon and j.WorldModel.Weapon.Viewmodel then
                                                            Model_2 = j.WorldModel.Weapon.Viewmodel.Model
                                                            if Model_2 then
                                                                for k, n in Model_2:GetChildren() do
                                                                    if n:IsA("Weld") and n.Part0 == j2.Part1 then
                                                                        n:Destroy()
                                                                        break
                                                                    end
                                                                end
                                                            end
                                                        end
                                                        Weld_3 = Instance.new("Weld")
                                                        Weld_3.Part0 = j2.Part1
                                                        Weld_3.Part1 = v2
                                                        v3 = 3 < v2.Size.Y
                                                        if not v3 then
                                                            v4 = CFrame.new()
                                                        else
                                                            v4 = CFrame.new(0, -1, 0)
                                                            if not v4 then
                                                                v4 = CFrame.new()
                                                            end
                                                        end
                                                        Weld_3.C1 = v4
                                                        Weld_3.Parent = Model
                                                        j2.Enabled = false
                                                        table.insert(j.OffHandWorldModel.WeldedShoulders, j2)
                                                        break
                                                    end
                                                end
                                            end
                                            j.OffHandWorldModel.Weapon = v1
                                            v1:Equip()
                                        end)
                                    elseif j.OffHandWorldModel and j.OffHandWorldModel.Weapon then
                                        Weapon_9 = j.OffHandWorldModel.Weapon
                                        if Weapon_9.HRPWeldBaseC0 and Weapon_9.HRPWeld then
                                            Weapon_9.HRPWeldBase = Weapon_9.HRPWeldBaseC0 * u281
                                            HRPWeld_6 = Weapon_9.HRPWeld
                                            HRPWeld_6.C0 = Weapon_9.HRPWeld.C0:Lerp(Weapon_9.HRPWeldBase, v33)
                                        end
                                        if not v3 then
                                            if 5 < v31 then
                                                j.OffHandWorldModel.Weapon.LowPolyMode = true
                                                if j.OffHandWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                    j.OffHandWorldModel.Attachments.Parent = nil
                                                end
                                                j.OffHandWorldModel.HideKeyparts(true)
                                                j.OffHandWorldModel.HighPolyModel.Parent = nil
                                                j.OffHandWorldModel.LowPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                            end
                                        elseif v31 <= math.exp(u139 * -0.3) * 50 + 10 then
                                            j.OffHandWorldModel.Weapon.LowPolyMode = false
                                            j.OffHandWorldModel.HighPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                            j.OffHandWorldModel.Attachments.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                            j.OffHandWorldModel.LowPolyModel.Parent = nil
                                            j.OffHandWorldModel.HideKeyparts(false)
                                        end
                                    end
                                end
                            end
                        elseif HRP and 100 >= (CurrentCamera.CFrame.Position - HRP.Position).Magnitude and j.LookAttachment then
                            if not PlayerState.Proning then
                                j.HeadCopy.CanCollide = false
                                LookAttachment_2 = j.LookAttachment
                                LookAttachment_2.WorldPosition = RaycastUtil.CastBaseRay().Position
                            else
                                j.HeadCopy.CanCollide = false
                                LookAttachment = j.LookAttachment
                                LookAttachment.WorldPosition = RaycastUtil.CastNoneRay().Position
                            end
                            u61:UpdatePlayerLookDirection(nil, i)
                        end
                    end
                elseif j.Update >= os.clock() then
                end
            end
        end)
    end,
    GetPlayerLookDirection = function(p1, p2) -- Line: 1574 -- upvalues: u137 (val)
        local v1 = u137[p2]
        if not v1 or not v1.LookAttachment then
            return nil
        end
        if v1.Head then
            return (v1.LookAttachment.WorldPosition - v1.Head.Position).Unit
        end
        return nil
    end,
}
function GetWeapon(p1, p2, p3) -- Line: 1583 -- upvalues: Promise (val), WepConfig (val), GunID (val), u92 (val)
    return Promise.new(function(a1) -- Line: 1584 -- upvalues: WepConfig (upval), p1 (val), p2 (val), GunID (upval), p3 (val), u92 (upval)
        local v1 = WepConfig:StreamViewmodel(p1)
        v1:andThen(function(a1_2) -- Line: 1585 -- upvalues: p2 (upval), GunID (upval), p3 (upval), a1 (val), u92 (upval), p1 (upval)
            local v1 = a1_2:Clone()
            v1.HumanoidRootPart.Anchored = false
            local v2 = if p2 and p2 ~= "" then GunID:RetrieveAttachmentData(p2, p3) else nil
            a1(u92.new(p1, v1, v2))
        end)
    end)
end
function DestroyModel(p1) -- Line: 1597
    local WorldModel
    if p1.WorldModel then
        local WeldedShoulders, v1, v2
        WorldModel = p1.WorldModel
        if WorldModel.Promise then
            WorldModel.Promise:cancel()
        end
        if not WorldModel.WeldedShoulders then
            local Shoulders = p1.Shoulders
            v1 = nil
            v2 = nil
            for i, j in Shoulders, v1, v2 do
                if j then
                    j.Enabled = true
                end
            end
        else
            WeldedShoulders = WorldModel.WeldedShoulders
            v1 = nil
            v2 = nil
            for k, n in WeldedShoulders, v1, v2 do
                if n then
                    n.Enabled = true
                end
            end
        end
        if WorldModel.Weapon then
            WorldModel.Weapon.Viewmodel:Destroy()
        elseif WorldModel.Model then
            WorldModel.Model:Destroy()
        end
        if WorldModel.LowPolyModel then
            WorldModel.LowPolyModel:Destroy()
        end
        p1.WorldModel = {}
    end
end
function DestroySecondaryModel(p1) -- Line: 1630
    if p1.SecondaryWorldModel then
        local WeldedShoulders
        if p1.SecondaryWorldModel.Promise then
            p1.SecondaryWorldModel.Promise:cancel()
        end
        if p1.SecondaryWorldModel.WeldedShoulders then
            WeldedShoulders = p1.SecondaryWorldModel.WeldedShoulders
            local v1 = nil
            local v2 = nil
            for i, j in WeldedShoulders, v1, v2 do
                if j then
                    j.Enabled = true
                end
            end
        end
        if p1.SecondaryWorldModel.ArmModel then
            p1.SecondaryWorldModel.ArmModel:Destroy()
        end
        if p1.SecondaryWorldModel.Weapon then
            p1.SecondaryWorldModel.Weapon.Viewmodel:Destroy()
            p1.SecondaryWorldModel.LowPolyModel:Destroy()
        end
        p1.SecondaryWorldModel = nil
    end
end
function DestroyOffHandModel(p1) -- Line: 1655
    if p1.OffHandWorldModel then
        local Weapon, WeldedShoulders, v1
        if p1.OffHandWorldModel.Promise then
            p1.OffHandWorldModel.Promise:cancel()
        end
        if not p1.WorldModel then
            if not p1.OffHandWorldModel.WeldedShoulders then
                v1 = p1
            else
                local WeldedShoulders_4 = p1.OffHandWorldModel.WeldedShoulders
                local v2 = nil
                local v3 = nil
                for i, j in WeldedShoulders_4, v2, v3 do
                    if j then
                        j.Enabled = true
                    end
                end
            end
        elseif p1.WorldModel.Weapon and p1.OffHandWorldModel.WeldedShoulders then
            local Weld, WeldedShoulders_3, v4, v5, v6, v7, v8, v9
            local Model = p1.WorldModel.Weapon.Viewmodel.Model
            Weapon = p1.WorldModel.Weapon
            WeldedShoulders = p1.WorldModel.WeldedShoulders
            if not WeldedShoulders then
                WeldedShoulders = {}
            end
            p1.WorldModel.WeldedShoulders = WeldedShoulders
            local WeldedShoulders_2 = p1.OffHandWorldModel.WeldedShoulders
            local v10 = nil
            local v11 = nil
            v1 = p1
            for k, n in WeldedShoulders_2, v10, v11 do
                if n and n.Part1 then
                    if not Weapon.Config.ArmIgnores then
                        v8 = Model:FindFirstChild(n.Part1.Name)
                        if not v8 then
                            n.Enabled = true
                        else
                            v9 = false
                            for m, i5 in Model:GetChildren() do
                                if i5:IsA("Weld") and i5.Part0 == n.Part1 and i5.Part1 == v8 then
                                    v9 = true
                                    break
                                end
                            end
                            if not v9 then
                                Weld = Instance.new("Weld")
                                Weld.Part0 = n.Part1
                                Weld.Part1 = v8
                                v5 = 3 < v8.Size.Y
                                if not v5 then
                                    v6 = CFrame.new()
                                else
                                    v6 = CFrame.new(0, -1, 0)
                                end
                                Weld.C1 = v6
                                Weld.Parent = Model
                            end
                            v4 = false
                            WeldedShoulders_3 = v1.WorldModel.WeldedShoulders
                            v6 = nil
                            v7 = nil
                            for i6, i7 in WeldedShoulders_3, v6, v7 do
                                if i7 == n then
                                    v4 = true
                                    break
                                end
                            end
                            if not v4 then
                                table.insert(v1.WorldModel.WeldedShoulders, n)
                            end
                        end
                        n.Enabled = false
                    elseif Weapon.Config.ArmIgnores[n.Name] then
                        n.Enabled = true
                    end
                end
            end
        end
        if v1.OffHandWorldModel.Weapon then
            v1.OffHandWorldModel.Weapon.Viewmodel:Destroy()
            v1.OffHandWorldModel.LowPolyModel:Destroy()
        end
        v1.OffHandWorldModel = nil
    end
end
return v9