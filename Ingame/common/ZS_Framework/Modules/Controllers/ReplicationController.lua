local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local u22 = require("@game/ReplicatedStorage/common/zap")
local LookAngleInbox = require(script.Parent.Parent.Utils.LookAngleInbox)
local CurrentCamera = workspace.CurrentCamera
local common = ReplicatedStorage.common
local Assets = ReplicatedStorage.common:WaitForChild("SharedResources"):WaitForChild("Assets")
local Utils = script.Parent.Parent.Utils
local RedEvents = ReplicatedStorage.common.RedEvents
local WepConfig = require(common:WaitForChild("WepConfig"))
local Promise = require(common:WaitForChild("Promise"))
local PlayerHandler = require(common:WaitForChild("PlayerHandler"))
local u68 = require("./FlashlightController")
local ClassMirror = require(ReplicatedStorage.common.NPCs_Shared.Utils.ClassMirror)
local CharacterAnimator = require(script.Parent.Parent.Utils:WaitForChild("CharacterAnimator"))
local Settings = require(ReplicatedStorage.common.Settings)
local peek = require(ReplicatedStorage.Packages.Fusion).peek
require("../Classes/WorldViewmodel")
local u99 = require("../Classes/WorldWeapon")
local BulletUtil = require(Utils:WaitForChild("BulletUtil"))
local RaycastUtil = require(Utils:WaitForChild("RaycastUtil"))
local GunID = require(common:WaitForChild("GunID"))
local FrameworkEvents = require(RedEvents.Framework.FrameworkEvents)
local Value = false
if workspace.Values:FindFirstChild("IsLobby") ~= nil then
    Value = workspace.Values.IsLobby.Value
end
local Attribute = workspace.Values:GetAttribute("EnableLobbyPeerReplication")
local u142 = not Value
if not u142 then
    u142 = Attribute == true
end
local u143 = {}
local u144 = {}
local u146 = 0
local u147 = {["rbxassetid://180426354"] = true}

local function reliefIKDisabled() -- Line: 57 -- upvalues: Value (val)
    if not Value then
        return false
    end
    local v1 = workspace.Values:GetAttribute("LobbyReliefIK") == true
    return v1
end

local function applyProceduralIKSetting() -- Line: 64 -- upvalues: peek (val), Settings (val), Value (val), u144 (val)
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
    v1 = u144
    local v3 = nil
    local v4 = nil
    for i, j in v1, v3, v4 do
        if j.Animator then
            j.Animator:SetIKEnabled(v2)
        end
    end
end

Settings.SettingsChanged:Connect(function(p1) -- Line: 74 -- upvalues: applyProceduralIKSetting (val)
    if p1 and p1[1] == "Graphics" and p1[2] == "ProceduralAnimations" then
        applyProceduralIKSetting()
    end
end)
local u162 = os.clock()
local u163 = nil
local u164 = nil
local u167 = Enum.RenderPriority.Character.Value + 1
local u181 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
local v1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
local u206 = (CFrame.new(0, -0.25, 0)) * CFrame.Angles(0, 3.141592653589793, 0)
local u212 = CFrame.new(0, -0.25, 0) * v1
if Value then
    (workspace.Values:GetAttributeChangedSignal("EnableLobbyPeerReplication")):Connect(function() -- Line: 97 -- upvalues: u142 (ref)
        local v1 = workspace.Values:GetAttribute("EnableLobbyPeerReplication") == true
        u142 = v1
    end)
    ;(workspace.Values:GetAttributeChangedSignal("LobbyReliefIK")):Connect(applyProceduralIKSetting)
end
local u244 = (CFrame.new(0, -0.15, -0.3)) * CFrame.Angles(0.5235987755982988, 0, 0)
local u255 = (CFrame.new(-0.3, -0.5, -0.2)) * CFrame.Angles(0.6108652381980153, -0.2617993877991494, 0)
local u266 = (CFrame.new(0.25, 0, 0)) * CFrame.Angles(0, -0.17453292519943295, 0)
local u277 = (CFrame.new(-0.25, 0, 0)) * CFrame.Angles(0, 0.17453292519943295, 0)
local u288 = (CFrame.new(-0.25, 0, -0.1)) * CFrame.Angles(0, 0.17453292519943295, 0)

local function GetMirroredCFrame(p1) -- Line: 114
    return CFrame.fromMatrix(p1.Position, p1.XVector * -1, p1.YVector, p1.ZVector)
end

local function GetPlayerSkinColor(p1) -- Line: 119
    local Character = p1
    if Character then
        Character = p1.Character
    end
    local Color = Color3.fromRGB(255, 204, 153)
    if Character then
        local BodyColors = Character:FindFirstChildOfClass("BodyColors")
        if BodyColors then
            local RightArmColor3 = BodyColors.RightArmColor3
            if not RightArmColor3 then
                RightArmColor3 = BodyColors.LeftArmColor3
                if not RightArmColor3 then
                    RightArmColor3 = Color
                end
            end
            return RightArmColor3
        end
        local v1 = Character:FindFirstChild("Right Arm")
        if v1 then
            Color = v1.Color
        end
    end
    return Color
end

local function CreateMirroredArmModel(p1, p2) -- Line: 139 -- upvalues: Assets (val), GetPlayerSkinColor (val)
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

local function round(p1, p2) -- Line: 180
    local v1 = string.format("%." .. (p2 or 0) .. "f", p1)
    return (tonumber(v1))
end

local function roundVector(p1, p2) -- Line: 183
    local X = p1.X
    local v1 = string.format("%." .. (p2 or 0) .. "f", X)
    local v2 = tonumber(v1)
    local Y = p1.Y
    local v3 = string.format("%." .. (p2 or 0) .. "f", Y)
    local v4 = tonumber(v3)
    local Z = p1.Z
    local v5 = string.format("%." .. (p2 or 0) .. "f", Z)
    return v2, v4, (tonumber(v5))
end

local function isInView(p1) -- Line: 186 -- upvalues: CurrentCamera (val)
    local v1 = CurrentCamera
    local LookVector = v1.CFrame.LookVector
    local v2 = p1 - CurrentCamera.CFrame.Position
    local v3 = CurrentCamera.FieldOfView + 2
    local v4 = v2.Unit:Angle(LookVector)
    local v5 = math.deg(v4)
    if math.floor(v5) <= v3 then
        return true
    end
    return false
end

local v2 = {
    Init = function() -- Line: 203
        -- upvalues: u144 (val), u143 (val), FrameworkEvents (val), CharacterAnimator (val), RaycastUtil (val)
        -- upvalues: peek (val), Settings (val), Value (val), u147 (val), u142 (ref), Players (val), u146 (ref)
        -- upvalues: BulletUtil (val), ClassMirror (val), RunService (val), u167 (val), u162 (ref), CurrentCamera (val)
        -- upvalues: u163 (ref), u164 (ref), u22 (val), LookAngleInbox (val), PlayerHandler (val), u212 (val)
        -- upvalues: u206 (val), u181 (val), u68 (val), ReplicatedStorage (val), TweenService (val), u244 (val)
        -- upvalues: CreateMirroredArmModel (val), u277 (val), u255 (val), u266 (val), u288 (val)
        local function cleanPlayer(p1) -- Line: 204 -- upvalues: u144 (upval), u143 (upval)
            if u144[p1] then
                if u144[p1].LookAttachment then
                    u144[p1].LookAttachment:Destroy()
                end
                if u144[p1].WorldModel then
                    DestroyModel(u144[p1])
                end
                if u144[p1].SecondaryWorldModel then
                    DestroySecondaryModel(u144[p1])
                end
                if u144[p1].OffHandWorldModel then
                    DestroyOffHandModel(u144[p1])
                end
                if u144[p1].Animator then
                    u144[p1].Animator:Destroy()
                end
            end
            u143[p1.Name] = nil
            u144[p1] = nil
        end

        local CharacterLoaded = FrameworkEvents.CharacterLoaded

        local function CharAdded(p1, p2) -- Line: 228
            -- upvalues: CharacterLoaded (val), u144 (upval), CharacterAnimator (upval), RaycastUtil (upval)
            -- upvalues: peek (upval), Settings (upval), Value (upval), u147 (upval)
            local function finishLocalCharacterReady() -- Line: 229 -- upvalues: p2 (val), CharacterLoaded (upval)
                if p2 == game.Players.LocalPlayer then
                    CharacterLoaded:FireServer()
                end
            end

            if u144[p2] then
                if u144[p2].LookAttachment then
                    u144[p2].LookAttachment:Destroy()
                end
                if u144[p2].WorldModel then
                    DestroyModel(u144[p2])
                end
                if u144[p2].SecondaryWorldModel then
                    DestroySecondaryModel(u144[p2])
                end
                if u144[p2].OffHandWorldModel then
                    DestroyOffHandModel(u144[p2])
                end
                if u144[p2].Animator then
                    u144[p2].Animator:Destroy()
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
            u144[p2].HRP = HumanoidRootPart
            u144[p2].Head = Head
            if Humanoid and Humanoid:IsA("Humanoid") then
                if Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
                    warn(
                        "[ReplicationController] R6 replication setup skipped for unsupported rig:",
                        Humanoid.RigType.Name
                    )
                    if p2 == game.Players.LocalPlayer then
                        CharacterLoaded:FireServer()
                    end
                    return
                end
                local Torso = p1:FindFirstChild("Torso")
                if not Torso then
                    Torso = p1:WaitForChild("Torso", 5)
                end
                if HumanoidRootPart and Head and Torso then
                    local Terrain, v1, v2
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
                    local v3 = Head:Clone()
                    v3:ClearAllChildren()
                    v3.Name = "HEADCOPY"
                    v3.Transparency = 1
                    v3.CollisionGroup = "Player"
                    local v4 = Neck:Clone()
                    v4.Name = "NeckClone"
                    v4.Part1 = v3
                    v4.C0 = Neck.C0
                    v4.C1 = Neck.C1
                    v4.Parent = Torso
                    v3.Parent = p1
                    u144[p2].HeadCopy = v3
                    u144[p2].Head = Head
                    u144[p2].HRP = HumanoidRootPart
                    local v5 = u144[p2]
                    v5.RootJoint = HumanoidRootPart:WaitForChild("RootJoint", 5)
                    v5 = u144[p2]
                    v5.Shoulders = {}
                    v5 = u144[p2]
                    v5.LastLookAngleTick = 0
                    v5 = Torso:WaitForChild("Left Shoulder", 5)
                    local v6 = Torso:WaitForChild("Right Shoulder", 5)
                    if v5 then
                        v2 = u144
                        local Shoulders = v2[p2].Shoulders
                        table.insert(Shoulders, v5)
                    end
                    if v6 then
                        v2 = u144
                        local Shoulders_2 = v2[p2].Shoulders
                        table.insert(Shoulders_2, v6)
                    end
                    if p2 ~= game.Players.LocalPlayer then
                        v1 = u144[p2]
                        v1.Animator = CharacterAnimator.new(p1, false)
                        if u144[p2].Animator then
                            local v7 = u144
                            local Animator = v7[p2].Animator
                            local AltRaycastParams = RaycastUtil:GetAltRaycastParams()
                            Animator:SetRaycastParams(AltRaycastParams)
                            local Animator_2 = u144[p2].Animator
                            v2 = peek(Settings.Graphics.ProceduralAnimations)
                            if v2 then
                                local v8
                                if Value then
                                    v8 = workspace.Values:GetAttribute("LobbyReliefIK") == true
                                else
                                    v8 = false
                                end
                                v2 = not v8
                            end
                            Animator_2:SetIKEnabled(v2)
                        end
                        local Humanoid_2 = p1:FindFirstChildOfClass("Humanoid")
                        local Animator_3 = Humanoid_2
                        if Animator_3 then
                            Animator_3 = Humanoid_2:FindFirstChildOfClass("Animator")
                        end
                        if Animator_3 then
                            Animator_3.AnimationPlayed:Connect(function(p1) -- Line: 330 -- upvalues: u147 (upval)
                                if p1.Animation
                                    and p1.Animation.Name == "Animation"
                                    and u147[p1.Animation.AnimationId] then
                                    p1:Stop(0)
                                end
                            end)
                        end
                    end
                    v1 = u144[p2]
                    v1.LookAttachment = Instance.new("Attachment")
                    u144[p2].LookAttachment.WorldCFrame = Torso.CFrame + Torso.CFrame.LookVector * 3
                    local LookAttachment = u144[p2].LookAttachment
                    if p2 ~= game.Players.LocalPlayer then
                        Terrain = HumanoidRootPart
                    else
                        Terrain = workspace.Terrain
                    end
                    LookAttachment.Parent = Terrain
                    u144[p2].Neck = Neck
                    v1 = u144[p2]
                    v1.NeckCF = CFrame.new()
                    if p2 ~= game.Players.LocalPlayer then
                        u144[p2].LookAttachment.CFrame = CFrame.new(0, 0, -5)
                        v1 = u144[p2]
                        v1.LookGoal = 0
                        v1 = u144[p2]
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
                    return
                end
                warn("[ReplicationController] R6 character is missing a required body part:", p1:GetFullName())
                if p2 == game.Players.LocalPlayer then
                    CharacterLoaded:FireServer()
                end
                return
            end
            warn("[ReplicationController] Character has no Humanoid:", p1:GetFullName())
            if p2 == game.Players.LocalPlayer then
                CharacterLoaded:FireServer()
            end
        end

        local function PlrAdded(p1) -- Line: 365
            -- upvalues: u143 (upval), u142 (upval), Players (upval), u144 (upval), CharAdded (val), u146 (upval)
            u143[p1.Name] = p1
            local Character = p1.Character
            if not Character then
                Character = p1.CharacterAdded:Wait()
            end
            if u142 or Players.LocalPlayer == p1 then
                local v1 = u144
                local v2 = {LastLookAngleTick = 0, Update = os.clock()}
                v1[p1] = v2
                CharAdded(Character, p1)
            end
            p1.CharacterAdded:Connect(function(p1_2) -- Line: 373 -- upvalues: u142 (upval), Players (upval), p1 (val), CharAdded (upval)
                if u142 or Players.LocalPlayer == p1 then
                    CharAdded(p1_2, p1)
                end
            end)
            u146 = #Players:GetPlayers()
        end

        for i, j in Players:GetPlayers() do
            task.defer(function() -- Line: 383 -- upvalues: PlrAdded (val), j (val)
                PlrAdded(j)
            end)
        end
        game.Players.PlayerAdded:Connect(PlrAdded)
        game.Players.PlayerRemoving:Connect(function(p1) -- Line: 389 -- upvalues: u146 (upval), Players (upval), cleanPlayer (val)
            u146 = #Players:GetPlayers()
            cleanPlayer(p1)
        end)
        local v1 = FrameworkEvents
        v1.HitReplication:SetClientListener(function(p1) -- Line: 394 -- upvalues: u144 (upval), BulletUtil (upval), ClassMirror (upval)
            local Damage, Position, Position_2, Position_3, UID, Weapon, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
            local v11 = nil
            local WorldModel = nil
            local v12 = nil
            local v13 = {}
            local v14 = nil
            local v15 = p1
            local v16 = nil
            local v17 = nil
            for i, j in v15, v16, v17 do
                if i == 1 then
                    v11 = j
                    if not u144[v11] then
                        WorldModel = nil
                    else
                        WorldModel = u144[v11].WorldModel
                    end
                    if not WorldModel then
                        return
                    end
                    Weapon = WorldModel.Weapon
                    if Weapon then
                        Weapon = WorldModel.Weapon.Config
                    end
                    v14 = Weapon
                elseif typeof(j) ~= "Vector3" then
                    if string.sub(j, 1, 1) == "m" then
                        if v12 and v12.Model and v12.Model.Parent then
                            v1 = nil
                            v2 = nil
                            v3 = string.sub(j, 2)
                            if not v12.ArmorHPs then
                                if v12.UIDTable and v12.UIDTable[v3] then
                                    v1 = v12.UIDTable[v3]
                                end
                            elseif v12.ArmorHPs[v3] then
                                v1 = v12.Model[v12.ArmorHPs[v3][2]]
                                v2 = true
                            elseif v12.UIDTable and v12.UIDTable[v3] then
                                v1 = v12.UIDTable[v3]
                            end
                            if not v1 then
                                return
                            end
                            v4 = RaycastParams.new()
                            v4.FilterType = Enum.RaycastFilterType.Include
                            v4.FilterDescendantsInstances = {v1}
                            v5 = v1.Position - u144[v11].HRP.Position
                            v6 = workspace
                            v8 = u144
                            v7 = v8[v11]
                            Position = v7.HRP.Position
                            v6 = v6:Raycast(Position, v5, v4)
                            Position_2 = v1.Position + v5.Unit * -0.5
                            if v6 then
                                Position_2 = v6.Position
                            end
                            if v12.Flinch then
                                v9 = Position_2
                                Position_3 = u144[v11].HRP.Position
                                if not v14 then
                                    Damage = 5
                                else
                                    Damage = v14.Damage
                                    if not Damage then
                                        Damage = 5
                                    end
                                end
                                v10 = Damage / v12.MaxHP
                                v12:Flinch(v9, Position_3, v10)
                            end
                            if not v2 and v14 then
                                v7 = BulletUtil
                                v9 = v14 or {}
                                UID = v12.UID
                                v7:BloodNPC(v9, UID, v3)
                            end
                            continue
                        end
                        return
                    end
                    v12 = ClassMirror:GetObjFromId(j)
                else
                    table.insert(v13, j)
                end
            end
            if WorldModel and v14 and not v14.IsMelee then
                WorldModel.Weapon:Shoot(v13)
                WorldModel.Weapon.LastShotTime = os.clock()
            end
        end)
        v1 = FrameworkEvents
        v1.MeleeSwing:SetClientListener(function(p1) -- Line: 467 -- upvalues: u144 (upval)
            local WorldModel
            local v1, v2 = unpack(p1)
            if not u144[v1] then
                WorldModel = nil
            else
                WorldModel = u144[v1].WorldModel
            end
            if WorldModel and WorldModel.Weapon then
                WorldModel.Weapon:Melee(v2)
            end
        end)
        v1 = FrameworkEvents
        v1.Reloading:SetClientListener(function(p1) -- Line: 475 -- upvalues: u144 (upval)
            local v1 = p1[1]
            local v2 = p1[2]
            if u144[v1] and u144[v1].WorldModel and u144[v1].WorldModel.Weapon then
                u144[v1].WorldModel.Weapon:Reload(not v2)
            end
        end)
        local u52 = 0
        local v2 = RunService
        v2.Stepped:Connect(function(p1, p2) -- Line: 485 -- upvalues: u144 (upval), Players (upval), Value (upval)
            local v1 = u144
            local v2 = nil
            local v3 = nil
            local v4 = p2
            for i, j in v1, v2, v3 do
                if i ~= Players.LocalPlayer and j.Animator and i.Parent then
                    if not Value or j.ProceduralVisible == true then
                        j.Animator:UpdateStepped(v4)
                    end
                end
            end
        end)
        v2 = RunService
        local v3 = u167
        v2:BindToRenderStep("REPLICATION", v3, function(p1) -- Line: 498
            -- upvalues: u162 (upval), CurrentCamera (upval), Players (upval), u163 (upval), u164 (upval), u52 (ref)
            -- upvalues: u22 (upval), u144 (upval), LookAngleInbox (upval), u146 (upval), PlayerHandler (upval)
            -- upvalues: u212 (upval), u206 (upval), u181 (upval), RaycastUtil (upval), u68 (upval)
            -- upvalues: ReplicatedStorage (upval), TweenService (upval), u244 (upval), CreateMirroredArmModel (upval)
            -- upvalues: u277 (upval), u255 (upval), u266 (upval), u288 (upval), cleanPlayer (val)
            local AimTwistAngle, Angles_2, Animator, Animator_2, Animator_3, C0, C0_2, C0_3, C0_4, ClientTick, Diving, Equipped, Equipped_2, GunRestAlpha, HRP, HRPWeld, HRPWeldBase, HRPWeldBase_2, HRPWeldBase_3, HRPWeld_2, HRPWeld_3, HRPWeld_5, HRPWeld_7, LastShotTime, LookAttachment, LookAttachment_2, LookAttachment_3, LookVector, Model, Model_2, Name, Name_2, NeckCF, OffHandActive_2, OffHandEquipped, Pitch, PlayerState, Position, Proning, QuickSwapActive_2, QuickSwapActive_3, QuickSwapAlpha, RecoilOffset, RecoilOffset_2, ReplicationOffset, RightVector, RootJoint, SecondaryEquipped, SecondaryEquipped_2, SecondaryWorldModel_2, Shoulders, Shoulders_2, Velocity, Weapon, Weapon_2, Weapon_3, Weapon_4, Weapon_5, Weapon_6, Weapon_7, Weld, Weld_2, Weld_3, WeldedShoulders, WeldedShoulders_2, WeldedShoulders_3, WeldedShoulders_4, WeldedShoulders_5, WeldedShoulders_6, WorldModel_2, WorldModel_3, WorldModel_5, WorldModel_7, WorldPosition, Yaw, identity, identity_2, p, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31, v32, v33, v34
            local v35 = os.clock()
            if u162 < v35 then
                v35 = CurrentCamera.CFrame:ToOrientation()
                local LocalPlayer = Players.LocalPlayer
                local Character = LocalPlayer
                if Character then
                    Character = LocalPlayer.Character
                    if Character then
                        Character = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    end
                end
                local v36 = 0
                if Character then
                    local Unit = (Character.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
                    local Unit_2 = (CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
                    v32 = Unit_2:Cross(Unit)
                    v33 = Unit_2:Dot(Unit)
                    local Y = v32.Y
                    v36 = math.atan2(Y, v33)
                end
                u162 = os.clock() + 0.1
                local v37 = not u163
                if not v37 then
                    v33 = u163
                    v32 = v33 - v35
                    v37 = 0.05 < (math.abs(v32))
                end
                v31 = not u164
                if not v31 then
                    v34 = u164
                    v33 = v34 - v36
                    v31 = 0.05 < (math.abs(v33))
                end
                if v37 or v31 then
                    u52 = u52 + 1
                    u163 = v35
                    u164 = v36
                    v32 = u22
                    v32.UpdateLookAngle.Fire({
                        Pitch = math.clamp(v35, -1.4, 1.4),
                        Yaw = math.clamp(v36, -1.57, 1.57),
                        ClientTick = u52,
                    })
                end
            end
            v35 = u144
            local v38 = nil
            local v39 = nil
            local v40 = p1
            for i, j in v35, v38, v39 do
                if not i.Parent then
                    cleanPlayer(i)
                else
                    v31 = LookAngleInbox.Take(i)
                    if v31 then
                        ClientTick = v31.ClientTick
                        if (j.LastLookAngleTick or 0) <= ClientTick then
                            j.LastLookAngleTick = v31.ClientTick
                            Animator = j.Animator
                            if Animator then
                                Animator = j.Animator.States
                            end
                            Pitch = v31.Pitch
                            if not Animator or not Animator.Proning then
                                v2 = 0.3
                            else
                                v2 = 0.1
                            end
                            v34 = Pitch + v2
                            j.LookGoal = math.clamp(v34, -1.4, 1.4)
                            Yaw = v31.Yaw
                            j.YawGoal = math.clamp(Yaw, -1.57, 1.57)
                        end
                    end
                    if i == Players.LocalPlayer then
                        p = workspace.CurrentCamera.CFrame.p
                        v32 = i:DistanceFromCharacter(p) or (1 / 0)
                        if i == Players.LocalPlayer or not u144[i].LastTick then
                            v33 = v40
                        else
                            v33 = os.clock() - u144[i].LastTick
                        end
                        v2 = v33 * 10
                        v34 = math.clamp(v2, 0.01, 1)
                        v1 = u144[i]
                        v1.LastTick = os.clock()
                        v4 = u146
                        v2 = math.pow(v4, 4) * 0.01
                        v1 = math.clamp(v2, 1, 4)
                        HRP = j.HRP
                        if not HRP or not HRP.Parent then
                            v3 = false
                        else
                            Position = HRP.Position
                            v5 = CurrentCamera
                            LookVector = v5.CFrame.LookVector
                            v6 = Position - CurrentCamera.CFrame.Position
                            v7 = CurrentCamera.FieldOfView + 2
                            v10 = v6.Unit:Angle(LookVector)
                            v9 = math.deg(v10)
                            v4 = not not (math.floor(v9) <= v7)
                            v3 = not not v4
                        end
                        v4 = v3
                        if v4 then
                            v4 = v32 <= 120
                        end
                        j.ProceduralVisible = v4
                        v4 = u144[i]
                        v5 = os.clock()
                        v9 = v32 / 100 * 0.1
                        v8 = math.max(v9, 0.016666666666666666)
                        v4.Update = v5 + v1 * math.clamp(v8, 0, 1)
                        PlayerState = PlayerHandler:GetPlayerState(i)
                        if PlayerState then
                            RootJoint = j.RootJoint
                            if RootJoint and HRP and RootJoint.Parent and HRP.Parent and v3 then
                                if j.Animator then
                                    j.Animator:SetState(PlayerState)
                                    Animator_2 = j.Animator
                                    Equipped = PlayerState.Equipped
                                    if Equipped then
                                        Equipped = PlayerState.Equipped ~= ""
                                    end
                                    Animator_2:SetWeaponEquipped(Equipped)
                                    j.Animator:Heartbeat(v33)
                                    j.Animator:UpdateRenderStepped(v33, v32)
                                end
                                if i ~= Players.LocalPlayer then
                                    Proning = PlayerState.Proning
                                    Diving = PlayerState.Diving
                                    Velocity = HRP.Velocity
                                    RightVector = HRP.CFrame.RightVector
                                    v7 = -Velocity:Dot(RightVector)
                                    if not Diving then
                                        v8 = CFrame.new()
                                    else
                                        v8 = CFrame.Angles(0, math.clamp(v7, -1.0471975511965976, 1.0471975511965976), 0)
                                        if not v8 then
                                            v8 = CFrame.new()
                                        end
                                    end
                                    C0 = RootJoint.C0
                                    if not Proning then
                                        v11 = u212 * v8
                                        if not v11 then
                                            v11 = u206
                                        end
                                    elseif not Diving then
                                        v11 = u206
                                    else
                                        v11 = u212 * v8
                                        if not v11 then
                                            v11 = u206
                                        end
                                    end
                                    v9 = C0:Lerp(v11, v34)
                                    if not RootJoint.C0:FuzzyEq(v9, 0.0001) then
                                        RootJoint.C0 = v9
                                    end
                                end
                            end
                            if j.NeckCF and j.Neck then
                                NeckCF = j.NeckCF
                                if not PlayerState.Aiming then
                                    v7 = CFrame.new()
                                else
                                    v7 = CFrame.Angles(0, 0.3, 0)
                                    if not v7 then
                                        v7 = CFrame.new()
                                    end
                                end
                                j.NeckCF = NeckCF:Lerp(v7, v34)
                                j.Neck.C1 = u181 * j.NeckCF
                            end
                            if i ~= Players.LocalPlayer then
                                v5 = u144[i].YawGoal or 0
                                v6 = u144[i].LookGoal or 0
                                if u144[i].LookAttachment then
                                    LookAttachment_3 = u144[i].LookAttachment
                                    LookAttachment_3.CFrame = (CFrame.Angles(v6, v5, 0)) * CFrame.new(0, 0, -5)
                                    if j.Animator then
                                        Animator_3 = j.Animator
                                        WorldPosition = u144[i].LookAttachment.WorldPosition
                                        Animator_3:SetLookPoint(WorldPosition)
                                        j.Animator:SetYaw(v5)
                                    end
                                    v7 = u68
                                    v9 = u144[i].LookAttachment.WorldPosition - u144[i].Head.Position
                                    v7:UpdatePlayerLookDirection(v9, i)
                                    local HeadCopy = j.HeadCopy
                                    Equipped_2 = PlayerState.Equipped
                                    local WepId = PlayerState.WepId
                                    WorldModel_2 = j.WorldModel
                                    v11 = j._lastQuickSwapActive or false
                                    QuickSwapActive_2 = PlayerState.QuickSwapActive
                                    SecondaryEquipped = PlayerState.SecondaryEquipped
                                    if j._promotedToEquipped then
                                        v12 = false
                                        if Equipped_2 == j._promotedToEquipped
                                            or Equipped_2 ~= j._waitingForEquippedFrom
                                            or j._promotionTimestamp and 2 < os.clock() - j._promotionTimestamp then
                                            v12 = true
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
                                                    WorldModel_5 = j.WorldModel
                                                    WeldedShoulders_4 = j.WorldModel.WeldedShoulders
                                                    if not WeldedShoulders_4 then
                                                        WeldedShoulders_4 = {}
                                                    end
                                                    WorldModel_5.WeldedShoulders = WeldedShoulders_4
                                                    Shoulders_2 = j.Shoulders
                                                    v17 = nil
                                                    v18 = nil
                                                    for k, n in Shoulders_2, v17, v18 do
                                                        if n and n.Part1 then
                                                            if not Weapon_2.Config.ArmIgnores then
                                                                v21 = false
                                                                WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                                v23 = nil
                                                                v24 = nil
                                                                for m, i5 in WeldedShoulders_5, v23, v24 do
                                                                    if i5 == n then
                                                                        v21 = true
                                                                        break
                                                                    end
                                                                end
                                                                if not v21 then
                                                                    Name_2 = n.Part1.Name
                                                                    v22 = Model_2:FindFirstChild(Name_2)
                                                                    if v22 then
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = n.Part1
                                                                        Weld_3.Part1 = v22
                                                                        v24 = 3 < v22.Size.Y
                                                                        if not v24 then
                                                                            v25 = CFrame.new()
                                                                        else
                                                                            v25 = CFrame.new(0, -1, 0)
                                                                            if not v25 then
                                                                                v25 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld_3.C1 = v25
                                                                        Weld_3.Parent = Model_2
                                                                        WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_6, n)
                                                                    end
                                                                end
                                                                n.Enabled = false
                                                            elseif not Weapon_2.Config.ArmIgnores[n.Name] then
                                                                v21 = false
                                                                WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                                v23 = nil
                                                                v24 = nil
                                                                for i6, i7 in WeldedShoulders_5, v23, v24 do
                                                                    if i7 == n then
                                                                        v21 = true
                                                                        break
                                                                    end
                                                                end
                                                                if not v21 then
                                                                    Name_2 = n.Part1.Name
                                                                    v22 = Model_2:FindFirstChild(Name_2)
                                                                    if v22 then
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = n.Part1
                                                                        Weld_3.Part1 = v22
                                                                        v24 = 3 < v22.Size.Y
                                                                        if not v24 then
                                                                            v25 = CFrame.new()
                                                                        else
                                                                            v25 = CFrame.new(0, -1, 0)
                                                                            if not v25 then
                                                                                v25 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld_3.C1 = v25
                                                                        Weld_3.Parent = Model_2
                                                                        WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_6, n)
                                                                    end
                                                                end
                                                                n.Enabled = false
                                                            end
                                                        end
                                                    end
                                                    if not Weapon_2.HRPWeld then
                                                        Model_2.HumanoidRootPart.Anchored = false
                                                        Weld_2 = Instance.new("Weld")
                                                        Weld_2.Part0 = Model_2.HumanoidRootPart
                                                        Weld_2.Part1 = HeadCopy
                                                        C0_2 = Weld_2.C0
                                                        ReplicationOffset = Weapon_2.Config.ReplicationOffset
                                                        if not ReplicationOffset then
                                                            ReplicationOffset = CFrame.new()
                                                        end
                                                        Weld_2.C0 = C0_2 * ReplicationOffset
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
                                                        WorldModel_3 = j.WorldModel
                                                        WeldedShoulders = j.WorldModel.WeldedShoulders
                                                        if not WeldedShoulders then
                                                            WeldedShoulders = {}
                                                        end
                                                        WorldModel_3.WeldedShoulders = WeldedShoulders
                                                        Shoulders = j.Shoulders
                                                        v17 = nil
                                                        v18 = nil
                                                        for i8, i9 in Shoulders, v17, v18 do
                                                            if i9 and i9.Part1 then
                                                                if not Weapon.Config.ArmIgnores then
                                                                    Name = i9.Part1.Name
                                                                    v21 = Model:FindFirstChild(Name)
                                                                    if v21 then
                                                                        v22 = false
                                                                        for i10, i11 in Model:GetChildren() do
                                                                            if i11:IsA("Weld")
                                                                                and i11.Part0 == i9.Part1
                                                                                and i11.Part1 == v21 then
                                                                                v22 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v22 then
                                                                            Weld = Instance.new("Weld")
                                                                            Weld.Part0 = i9.Part1
                                                                            Weld.Part1 = v21
                                                                            v24 = 3 < v21.Size.Y
                                                                            if not v24 then
                                                                                v25 = CFrame.new()
                                                                            else
                                                                                v25 = CFrame.new(0, -1, 0)
                                                                                if not v25 then
                                                                                    v25 = CFrame.new()
                                                                                end
                                                                            end
                                                                            Weld.C1 = v25
                                                                            Weld.Parent = Model
                                                                        end
                                                                        v23 = false
                                                                        WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                        v25 = nil
                                                                        v26 = nil
                                                                        for i12, i13 in WeldedShoulders_2, v25, v26 do
                                                                            if i13 == i9 then
                                                                                v23 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v23 then
                                                                            WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_3, i9)
                                                                        end
                                                                    end
                                                                    i9.Enabled = false
                                                                elseif not Weapon.Config.ArmIgnores[i9.Name] then
                                                                    Name = i9.Part1.Name
                                                                    v21 = Model:FindFirstChild(Name)
                                                                    if v21 then
                                                                        v22 = false
                                                                        for i14, i15 in Model:GetChildren() do
                                                                            if i15:IsA("Weld")
                                                                                and i15.Part0 == i9.Part1
                                                                                and i15.Part1 == v21 then
                                                                                v22 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v22 then
                                                                            Weld = Instance.new("Weld")
                                                                            Weld.Part0 = i9.Part1
                                                                            Weld.Part1 = v21
                                                                            v24 = 3 < v21.Size.Y
                                                                            if not v24 then
                                                                                v25 = CFrame.new()
                                                                            else
                                                                                v25 = CFrame.new(0, -1, 0)
                                                                                if not v25 then
                                                                                    v25 = CFrame.new()
                                                                                end
                                                                            end
                                                                            Weld.C1 = v25
                                                                            Weld.Parent = Model
                                                                        end
                                                                        v23 = false
                                                                        WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                        v25 = nil
                                                                        v26 = nil
                                                                        for i16, i17 in WeldedShoulders_2, v25, v26 do
                                                                            if i17 == i9 then
                                                                                v23 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v23 then
                                                                            WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_3, i9)
                                                                        end
                                                                    end
                                                                    i9.Enabled = false
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        elseif SecondaryEquipped == ""
                                            and j.SecondaryWorldModel
                                            and j.SecondaryWorldModel.Weapon then
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
                                                WorldModel_5 = j.WorldModel
                                                WeldedShoulders_4 = j.WorldModel.WeldedShoulders
                                                if not WeldedShoulders_4 then
                                                    WeldedShoulders_4 = {}
                                                end
                                                WorldModel_5.WeldedShoulders = WeldedShoulders_4
                                                Shoulders_2 = j.Shoulders
                                                v17 = nil
                                                v18 = nil
                                                for i18, i19 in Shoulders_2, v17, v18 do
                                                    if i19 and i19.Part1 then
                                                        if not Weapon_2.Config.ArmIgnores then
                                                            v21 = false
                                                            WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                            v23 = nil
                                                            v24 = nil
                                                            for i20, i21 in WeldedShoulders_5, v23, v24 do
                                                                if i21 == i19 then
                                                                    v21 = true
                                                                    break
                                                                end
                                                            end
                                                            if not v21 then
                                                                Name_2 = i19.Part1.Name
                                                                v22 = Model_2:FindFirstChild(Name_2)
                                                                if v22 then
                                                                    Weld_3 = Instance.new("Weld")
                                                                    Weld_3.Part0 = i19.Part1
                                                                    Weld_3.Part1 = v22
                                                                    v24 = 3 < v22.Size.Y
                                                                    if not v24 then
                                                                        v25 = CFrame.new()
                                                                    else
                                                                        v25 = CFrame.new(0, -1, 0)
                                                                        if not v25 then
                                                                            v25 = CFrame.new()
                                                                        end
                                                                    end
                                                                    Weld_3.C1 = v25
                                                                    Weld_3.Parent = Model_2
                                                                    WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                    table.insert(WeldedShoulders_6, i19)
                                                                end
                                                            end
                                                            i19.Enabled = false
                                                        elseif not Weapon_2.Config.ArmIgnores[i19.Name] then
                                                            v21 = false
                                                            WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                            v23 = nil
                                                            v24 = nil
                                                            for i22, i23 in WeldedShoulders_5, v23, v24 do
                                                                if i23 == i19 then
                                                                    v21 = true
                                                                    break
                                                                end
                                                            end
                                                            if not v21 then
                                                                Name_2 = i19.Part1.Name
                                                                v22 = Model_2:FindFirstChild(Name_2)
                                                                if v22 then
                                                                    Weld_3 = Instance.new("Weld")
                                                                    Weld_3.Part0 = i19.Part1
                                                                    Weld_3.Part1 = v22
                                                                    v24 = 3 < v22.Size.Y
                                                                    if not v24 then
                                                                        v25 = CFrame.new()
                                                                    else
                                                                        v25 = CFrame.new(0, -1, 0)
                                                                        if not v25 then
                                                                            v25 = CFrame.new()
                                                                        end
                                                                    end
                                                                    Weld_3.C1 = v25
                                                                    Weld_3.Parent = Model_2
                                                                    WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                    table.insert(WeldedShoulders_6, i19)
                                                                end
                                                            end
                                                            i19.Enabled = false
                                                        end
                                                    end
                                                end
                                                if not Weapon_2.HRPWeld then
                                                    Model_2.HumanoidRootPart.Anchored = false
                                                    Weld_2 = Instance.new("Weld")
                                                    Weld_2.Part0 = Model_2.HumanoidRootPart
                                                    Weld_2.Part1 = HeadCopy
                                                    C0_2 = Weld_2.C0
                                                    ReplicationOffset = Weapon_2.Config.ReplicationOffset
                                                    if not ReplicationOffset then
                                                        ReplicationOffset = CFrame.new()
                                                    end
                                                    Weld_2.C0 = C0_2 * ReplicationOffset
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
                                                    WorldModel_3 = j.WorldModel
                                                    WeldedShoulders = j.WorldModel.WeldedShoulders
                                                    if not WeldedShoulders then
                                                        WeldedShoulders = {}
                                                    end
                                                    WorldModel_3.WeldedShoulders = WeldedShoulders
                                                    Shoulders = j.Shoulders
                                                    v17 = nil
                                                    v18 = nil
                                                    for i24, i25 in Shoulders, v17, v18 do
                                                        if i25 and i25.Part1 then
                                                            if not Weapon.Config.ArmIgnores then
                                                                Name = i25.Part1.Name
                                                                v21 = Model:FindFirstChild(Name)
                                                                if v21 then
                                                                    v22 = false
                                                                    for i26, i27 in Model:GetChildren() do
                                                                        if i27:IsA("Weld")
                                                                            and i27.Part0 == i25.Part1
                                                                            and i27.Part1 == v21 then
                                                                            v22 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v22 then
                                                                        Weld = Instance.new("Weld")
                                                                        Weld.Part0 = i25.Part1
                                                                        Weld.Part1 = v21
                                                                        v24 = 3 < v21.Size.Y
                                                                        if not v24 then
                                                                            v25 = CFrame.new()
                                                                        else
                                                                            v25 = CFrame.new(0, -1, 0)
                                                                            if not v25 then
                                                                                v25 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld.C1 = v25
                                                                        Weld.Parent = Model
                                                                    end
                                                                    v23 = false
                                                                    WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                    v25 = nil
                                                                    v26 = nil
                                                                    for i28, i29 in WeldedShoulders_2, v25, v26 do
                                                                        if i29 == i25 then
                                                                            v23 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v23 then
                                                                        WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_3, i25)
                                                                    end
                                                                end
                                                                i25.Enabled = false
                                                            elseif not Weapon.Config.ArmIgnores[i25.Name] then
                                                                Name = i25.Part1.Name
                                                                v21 = Model:FindFirstChild(Name)
                                                                if v21 then
                                                                    v22 = false
                                                                    for i30, i31 in Model:GetChildren() do
                                                                        if i31:IsA("Weld")
                                                                            and i31.Part0 == i25.Part1
                                                                            and i31.Part1 == v21 then
                                                                            v22 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v22 then
                                                                        Weld = Instance.new("Weld")
                                                                        Weld.Part0 = i25.Part1
                                                                        Weld.Part1 = v21
                                                                        v24 = 3 < v21.Size.Y
                                                                        if not v24 then
                                                                            v25 = CFrame.new()
                                                                        else
                                                                            v25 = CFrame.new(0, -1, 0)
                                                                            if not v25 then
                                                                                v25 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld.C1 = v25
                                                                        Weld.Parent = Model
                                                                    end
                                                                    v23 = false
                                                                    WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                    v25 = nil
                                                                    v26 = nil
                                                                    for i32, i33 in WeldedShoulders_2, v25, v26 do
                                                                        if i33 == i25 then
                                                                            v23 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v23 then
                                                                        WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_3, i25)
                                                                    end
                                                                end
                                                                i25.Enabled = false
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    j._lastQuickSwapActive = QuickSwapActive_2
                                    if not Equipped_2 or Equipped_2 == "" then
                                        if j.WorldModel then
                                            DestroyModel(j)
                                        end
                                    elseif HeadCopy then
                                        if not j.WorldModel then
                                            j.WorldModel = {}
                                        end
                                        v12 = j._promotedToEquipped ~= nil
                                        Weapon_3 = not v12
                                        if Weapon_3 then
                                            Weapon_3 = false
                                            v14 = os.clock()
                                            if (j.WorldModel.RetryAfter or 0) <= v14 then
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
                                            WorldModel_7 = j.WorldModel
                                            WorldModel_7.Promise = GetWeapon(Equipped_2, nil, i)
                                            ;(j.WorldModel.Promise:andThen(function(p1) -- Line: 885
                                                -- upvalues: j (val), WorldModel (val), WepId (val)
                                                -- upvalues: ReplicatedStorage (upval), HeadCopy (val)
                                                -- upvalues: QuickSwapActive (val), DualWieldActive (val)
                                                -- upvalues: OffHandActive (val)
                                                local Name, Weld_3, WeldedShoulders, WeldedShoulders_2, v1, v2, v3, v4, v5, v6, v7
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
                                                else
                                                    v6 = not not (5 <= p1.Config.BulletsPerShot)
                                                end
                                                local IsMelee = p1.Config.IsMelee
                                                if p1.Config.LODModel then
                                                    v7 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                                elseif IsAPistol then
                                                    v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                                elseif v6 then
                                                    v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                                elseif not IsMelee then
                                                    v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                                else
                                                    v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                                end
                                                local Weld = Instance.new("Weld")
                                                Weld.Part0 = v7.Handle
                                                Weld.Part1 = Model.KeyParts.Handle
                                                local C0 = Weld.C0
                                                local LODOffset = p1.Config.LODOffset
                                                if not LODOffset then
                                                    LODOffset = CFrame.new()
                                                end
                                                Weld.C0 = C0 * LODOffset
                                                Weld.Parent = v7
                                                v7.Parent = nil
                                                local Weld_2 = Instance.new("Weld")
                                                Weld_2.Part0 = Model.HumanoidRootPart
                                                Weld_2.Part1 = HeadCopy
                                                local C0_2 = Weld_2.C0
                                                local ReplicationOffset = p1.Config.ReplicationOffset
                                                if not ReplicationOffset then
                                                    ReplicationOffset = CFrame.new()
                                                end
                                                Weld_2.C0 = C0_2 * ReplicationOffset
                                                Weld_2.Parent = Model
                                                p1.HRPWeldBaseC1 = Weld_2.C1
                                                p1.HRPWeldBase = Weld_2.C0
                                                p1.HRPWeldBaseC0 = Weld_2.C0
                                                p1.HRPWeld = Weld_2
                                                j.WorldModel.LowPolyModel = v7
                                                j.WorldModel.HighPolyModel = Model.Weapon
                                                j.WorldModel.Attachments = Model.Attachments
                                                local Children = Model.KeyParts:GetChildren()
                                                local v8 = j
                                                local WorldModel_2 = v8.WorldModel

                                                function WorldModel_2.HideKeyparts(p1) -- Line: 942
                                                    -- upvalues: Children (val), Model (val)
                                                    local KeyParts
                                                    local v1 = Children
                                                    local v2 = nil
                                                    local v3 = nil
                                                    local v4 = p1
                                                    for i, j in v1, v2, v3 do
                                                        if not j:IsA("BasePart") then
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
                                                local v9 = nil
                                                local v10 = nil
                                                local v11 = p1
                                                for i, j2 in Shoulders, v9, v10 do
                                                    if j2 and j2.Part1 then
                                                        if not v11.Config.ArmIgnores
                                                            or not v11.Config.ArmIgnores[j2.Name] then
                                                            Name = j2.Part1.Name
                                                            v1 = Model:FindFirstChild(Name)
                                                            if v1 then
                                                                v2 = j2.Name == "Left Shoulder"
                                                                if QuickSwapActive or DualWieldActive then
                                                                    if not v2 then
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = j2.Part1
                                                                        Weld_3.Part1 = v1
                                                                        v3 = 3 < v1.Size.Y
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
                                                                        v5 = j
                                                                        WeldedShoulders_2 = v5.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_2, j2)
                                                                    elseif j2 then
                                                                        j2.Enabled = false
                                                                        v3 = j
                                                                        WeldedShoulders = v3.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders, j2)
                                                                    end
                                                                elseif not OffHandActive or not v2 then
                                                                    Weld_3 = Instance.new("Weld")
                                                                    Weld_3.Part0 = j2.Part1
                                                                    Weld_3.Part1 = v1
                                                                    v3 = 3 < v1.Size.Y
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
                                                                    v5 = j
                                                                    WeldedShoulders_2 = v5.WorldModel.WeldedShoulders
                                                                    table.insert(WeldedShoulders_2, j2)
                                                                elseif j2 then
                                                                    j2.Enabled = false
                                                                    v3 = j
                                                                    WeldedShoulders = v3.WorldModel.WeldedShoulders
                                                                    table.insert(WeldedShoulders, j2)
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                                j.WorldModel.Weapon = v11
                                                v11:Equip()
                                            end)):catch(function(p1) -- Line: 1003 -- upvalues: j (val), WorldModel (val), WepId (val)
                                                if j.WorldModel == WorldModel then
                                                    local v1 = warn
                                                    local v2 = WepId
                                                    v1("[ReplicationController] Failed to create world weapon " .. (tostring(v2)) .. ": " .. tostring(p1))
                                                    DestroyModel(j)
                                                    j.WorldModel.RetryAfter = os.clock() + 2
                                                end
                                            end)
                                        elseif j.WorldModel and j.WorldModel.Weapon then
                                            Weapon_4 = j.WorldModel.Weapon
                                            if not PlayerState.Sprinting then
                                                if Weapon_4.Sprinting then
                                                    Weapon_4.Sprinting = false
                                                    v15 = TweenService
                                                    HRPWeld_2 = Weapon_4.HRPWeld
                                                    v18 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                                                    v19 = {C1 = Weapon_4.HRPWeldBaseC1}
                                                    v15:Create(HRPWeld_2, v18, v19):Play()
                                                end
                                            elseif not Weapon_4.Sprinting then
                                                Weapon_4.Sprinting = true
                                                v15 = TweenService
                                                HRPWeld = Weapon_4.HRPWeld
                                                v18 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                                                v19 = {
                                                    C1 = Weapon_4.HRPWeldBaseC1 * CFrame.Angles(-0.4, 0, 0),
                                                }
                                                v15:Create(HRPWeld, v18, v19):Play()
                                            end
                                            if j.Animator and Weapon_4.HRPWeldBaseC0 then
                                                AimTwistAngle = j.Animator:GetAimTwistAngle()
                                                Weapon_4.aimTwistAngle = AimTwistAngle
                                                v16 = j.LookGoal or 0
                                                v18 = v16 / 1.5707963267948966
                                                v17 = math.clamp(v18, 0, 1)
                                                if not PlayerState.Aiming then
                                                    v18 = 0.5
                                                else
                                                    v18 = 0.8
                                                end
                                                v16 = v16 * v18
                                                if not PlayerState.Proning then
                                                    v18 = 0
                                                else
                                                    v18 = 1.5707963267948966
                                                end
                                                RecoilOffset = Weapon_4.RecoilOffset
                                                if not RecoilOffset then
                                                    RecoilOffset = CFrame.identity
                                                end
                                                identity = CFrame.identity
                                                Weapon_4.RecoilOffset = RecoilOffset:Lerp(identity, v34)
                                                v24 = Weapon_4.HRPWeldBaseC0 * Weapon_4.RecoilOffset
                                                if not PlayerState.Proning then
                                                    v25 = CFrame.new()
                                                else
                                                    v25 = CFrame.new(0, -1, -1)
                                                    if not v25 then
                                                        v25 = CFrame.new()
                                                    end
                                                end
                                                v23 = v24 * v25
                                                v24 = CFrame.new()
                                                if PlayerState.Proning then
                                                    v26 = CFrame.new()
                                                else
                                                    v26 = CFrame.new(0, 0, -0.5)
                                                    if not v26 then
                                                        v26 = CFrame.new()
                                                    end
                                                end
                                                v20 = v23 * v24:Lerp(v26, v17) * CFrame.Angles(-v18, 0, 0) * CFrame.Angles(-v16, 0, 0)
                                                Angles_2 = CFrame.Angles
                                                v22 = 0
                                                if PlayerState.Proning then
                                                    v23 = 0
                                                else
                                                    v23 = -AimTwistAngle
                                                    if not v23 then
                                                        v23 = 0
                                                    end
                                                end
                                                Weapon_4.HRPWeldBase = v20 * Angles_2(v22, v23, 0)
                                                v19 = os.clock()
                                                LastShotTime = Weapon_4.LastShotTime
                                                if LastShotTime then
                                                    LastShotTime = v19 - Weapon_4.LastShotTime < 2
                                                end
                                                v21 = not PlayerState.Aiming and not PlayerState.Sprinting and not LastShotTime and not PlayerState.Proning and not PlayerState.QuickSwapActive and not PlayerState.DualWieldActive and not PlayerState.OffHandActive
                                                Weapon_4.GunRestAlpha = Weapon_4.GunRestAlpha or 0
                                                if not v21 then
                                                    v22 = 0
                                                else
                                                    v22 = 1
                                                end
                                                Weapon_4.GunRestAlpha = Weapon_4.GunRestAlpha + (v22 - Weapon_4.GunRestAlpha) * v34 * 0.3
                                                HRPWeldBase = Weapon_4.HRPWeldBase
                                                v25 = CFrame.new()
                                                v27 = u244
                                                GunRestAlpha = Weapon_4.GunRestAlpha
                                                Weapon_4.HRPWeldBase = HRPWeldBase * v25:Lerp(v27, GunRestAlpha)
                                                HRPWeld_3 = Weapon_4.HRPWeld
                                                C0_3 = Weapon_4.HRPWeld.C0
                                                HRPWeldBase_2 = Weapon_4.HRPWeldBase
                                                HRPWeld_3.C0 = C0_3:Lerp(HRPWeldBase_2, v34)
                                            end
                                            if PlayerState.Charging then
                                                j.WorldModel.Weapon:Charging()
                                            end
                                            if PlayerState.Blocking then
                                                j.WorldModel.Weapon:Blocking()
                                            elseif j.WorldModel.Weapon.Block then
                                                j.WorldModel.Weapon:StopBlocking()
                                            end
                                            v18 = u146
                                            v17 = v18 * -0.3
                                            v14 = (math.exp(v17)) * 50 + 10
                                            if not v3 then
                                                if 5 < v32 then
                                                    j.WorldModel.Weapon.LowPolyMode = true
                                                    if j.WorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                        j.WorldModel.Attachments.Parent = nil
                                                    end
                                                    j.WorldModel.HideKeyparts(true)
                                                    j.WorldModel.HighPolyModel.Parent = nil
                                                    j.WorldModel.LowPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                end
                                            elseif v32 <= v14 then
                                                j.WorldModel.Weapon.LowPolyMode = false
                                                j.WorldModel.HighPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                j.WorldModel.Attachments.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                j.WorldModel.LowPolyModel.Parent = nil
                                                j.WorldModel.HideKeyparts(false)
                                            elseif 5 < v32 then
                                                j.WorldModel.Weapon.LowPolyMode = true
                                                if j.WorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                    j.WorldModel.Attachments.Parent = nil
                                                end
                                                j.WorldModel.HideKeyparts(true)
                                                j.WorldModel.HighPolyModel.Parent = nil
                                                j.WorldModel.LowPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                            end
                                        end
                                    elseif j.WorldModel then
                                        DestroyModel(j)
                                    end
                                    SecondaryEquipped_2 = PlayerState.SecondaryEquipped
                                    local SecondaryWepId = PlayerState.SecondaryWepId
                                    QuickSwapActive_3 = PlayerState.QuickSwapActive
                                    local DualWieldActive_2 = PlayerState.DualWieldActive
                                    v16 = SecondaryEquipped_2
                                    if v16 then
                                        v16 = false
                                        if SecondaryEquipped_2 ~= "" then
                                            v16 = SecondaryEquipped_2 ~= false
                                        end
                                    end
                                    if j.SecondaryWorldModel and j.SecondaryWorldModel.Weapon ~= nil then end
                                    if not v16 then
                                        if j.SecondaryWorldModel then
                                            DestroySecondaryModel(j)
                                        end
                                    elseif HeadCopy then
                                        if not j.SecondaryWorldModel then
                                            j.SecondaryWorldModel = {}
                                        end
                                        Weapon_5 = true
                                        if j.SecondaryWorldModel.Equipped == SecondaryEquipped_2 then
                                            if not j.SecondaryWorldModel.Weapon
                                                or not j.SecondaryWorldModel.Weapon.WepId then
                                                Weapon_5 = j.SecondaryWorldModel.Weapon
                                                if Weapon_5 then
                                                    Weapon_5 = j.SecondaryWorldModel.Weapon.IsMirrored ~= DualWieldActive_2
                                                end
                                            else
                                                Weapon_5 = true
                                                if j.SecondaryWorldModel.Weapon.WepId == SecondaryWepId then
                                                    Weapon_5 = j.SecondaryWorldModel.Weapon
                                                    if Weapon_5 then
                                                        Weapon_5 = j.SecondaryWorldModel.Weapon.IsMirrored ~= DualWieldActive_2
                                                    end
                                                end
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
                                            j.SecondaryWorldModel.Promise:andThen(function(p1) -- Line: 1171
                                                -- upvalues: j (val), SecondaryWorldModel (val), SecondaryWepId (val)
                                                -- upvalues: DualWieldActive_2 (val), ReplicatedStorage (upval)
                                                -- upvalues: HeadCopy (val), CreateMirroredArmModel (upval), i (val)
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
                                                else
                                                    v2 = not not (5 <= p1.Config.BulletsPerShot)
                                                end
                                                local IsMelee = p1.Config.IsMelee
                                                if p1.Config.LODModel then
                                                    v3 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                                elseif IsAPistol then
                                                    v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                                elseif v2 then
                                                    v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                                elseif not IsMelee then
                                                    v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                                else
                                                    v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                                end
                                                local Weld = Instance.new("Weld")
                                                Weld.Part0 = v3.Handle
                                                Weld.Part1 = Model.KeyParts.Handle
                                                local C0 = Weld.C0
                                                local LODOffset = p1.Config.LODOffset
                                                if not LODOffset then
                                                    LODOffset = CFrame.new()
                                                end
                                                Weld.C0 = C0 * LODOffset
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
                                                local v4 = j
                                                local SecondaryWorldModel_2 = v4.SecondaryWorldModel

                                                function SecondaryWorldModel_2.HideKeyparts(p1) -- Line: 1242
                                                    -- upvalues: Children (val), Model (val)
                                                    local KeyParts
                                                    local v1 = Children
                                                    local v2 = nil
                                                    local v3 = nil
                                                    local v4 = p1
                                                    for i, j in v1, v2, v3 do
                                                        if not j:IsA("BasePart") then
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
                                                local v5 = {}
                                                j.SecondaryWorldModel.WeldedShoulders = v5
                                                j.SecondaryWorldModel.ArmModel = nil
                                                if DualWieldActive_2 then
                                                    j.SecondaryWorldModel.ArmModel = CreateMirroredArmModel(Model, i)
                                                    v1 = p1
                                                else
                                                    local Name, Weld_3, WeldedShoulders, v6, v7, v8, v9
                                                    local Shoulders = j.Shoulders
                                                    v5 = nil
                                                    local v10 = nil
                                                    v1 = p1
                                                    for i2, j2 in Shoulders, v5, v10 do
                                                        if j2 and j2.Name == "Left Shoulder" and j2.Part1 then
                                                            if not v1.Config.ArmIgnores then
                                                                Name = j2.Part1.Name
                                                                v6 = Model:FindFirstChild(Name)
                                                                if not v6 then
                                                                    continue
                                                                else
                                                                    Weld_3 = Instance.new("Weld")
                                                                    Weld_3.Part0 = j2.Part1
                                                                    Weld_3.Part1 = v6
                                                                    v7 = 3 < v6.Size.Y
                                                                    if not v7 then
                                                                        v8 = CFrame.new()
                                                                    else
                                                                        v8 = CFrame.new(0, -1, 0)
                                                                        if not v8 then
                                                                            v8 = CFrame.new()
                                                                        end
                                                                    end
                                                                    Weld_3.C1 = v8
                                                                    Weld_3.Parent = Model
                                                                    j2.Enabled = false
                                                                    v9 = j
                                                                    WeldedShoulders = v9.SecondaryWorldModel.WeldedShoulders
                                                                    table.insert(WeldedShoulders, j2)
                                                                end
                                                            elseif v1.Config.ArmIgnores[j2.Name] then
                                                                continue
                                                            else
                                                                Name = j2.Part1.Name
                                                                v6 = Model:FindFirstChild(Name)
                                                                if not v6 then
                                                                    continue
                                                                else
                                                                    Weld_3 = Instance.new("Weld")
                                                                    Weld_3.Part0 = j2.Part1
                                                                    Weld_3.Part1 = v6
                                                                    v7 = 3 < v6.Size.Y
                                                                    if not v7 then
                                                                        v8 = CFrame.new()
                                                                    else
                                                                        v8 = CFrame.new(0, -1, 0)
                                                                        if not v8 then
                                                                            v8 = CFrame.new()
                                                                        end
                                                                    end
                                                                    Weld_3.C1 = v8
                                                                    Weld_3.Parent = Model
                                                                    j2.Enabled = false
                                                                    v9 = j
                                                                    WeldedShoulders = v9.SecondaryWorldModel.WeldedShoulders
                                                                    table.insert(WeldedShoulders, j2)
                                                                end
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
                                                v20 = CFrame.new()
                                                if DualWieldActive_2 then
                                                    v20 = u277
                                                elseif QuickSwapActive_3 then
                                                    Weapon_6.QuickSwapAlpha = Weapon_6.QuickSwapAlpha or 0
                                                    Weapon_6.QuickSwapAlpha = Weapon_6.QuickSwapAlpha + (1 - Weapon_6.QuickSwapAlpha) * v34 * 0.5
                                                    v21 = CFrame.new()
                                                    v23 = u255
                                                    QuickSwapAlpha = Weapon_6.QuickSwapAlpha
                                                    v20 = v21:Lerp(v23, QuickSwapAlpha)
                                                end
                                                v21 = j.LookGoal or 0
                                                v23 = v21 / 1.5707963267948966
                                                v22 = math.clamp(v23, 0, 1)
                                                if not PlayerState.Aiming then
                                                    v23 = 0.5
                                                else
                                                    v23 = 0.8
                                                end
                                                v21 = v21 * v23
                                                if not PlayerState.Proning then
                                                    v23 = 0
                                                else
                                                    v23 = 1.5707963267948966
                                                end
                                                RecoilOffset_2 = Weapon_6.RecoilOffset
                                                if not RecoilOffset_2 then
                                                    RecoilOffset_2 = CFrame.identity
                                                end
                                                identity_2 = CFrame.identity
                                                Weapon_6.RecoilOffset = RecoilOffset_2:Lerp(identity_2, v34)
                                                if not QuickSwapActive_3 then
                                                    v29 = Weapon_6.HRPWeldBaseC0 * v20
                                                    v28 = v29 * Weapon_6.RecoilOffset
                                                    if not PlayerState.Proning then
                                                        v29 = CFrame.new()
                                                    else
                                                        v29 = CFrame.new(0, -1, -1)
                                                        if not v29 then
                                                            v29 = CFrame.new()
                                                        end
                                                    end
                                                    v27 = v28 * v29
                                                    v28 = CFrame.new()
                                                    if PlayerState.Proning then
                                                        v30 = CFrame.new()
                                                    else
                                                        v30 = CFrame.new(0, 0, -0.5)
                                                        if not v30 then
                                                            v30 = CFrame.new()
                                                        end
                                                    end
                                                    Weapon_6.HRPWeldBase = v27 * v28:Lerp(v30, v22) * CFrame.Angles(-v23, 0, 0) * CFrame.Angles(-v21, 0, 0)
                                                else
                                                    Weapon_6.HRPWeldBase = Weapon_6.HRPWeldBaseC0 * v20
                                                end
                                                if not Weapon_6.IsMirrored then
                                                    if Weapon_6.HRPWeld then
                                                        HRPWeld_5 = Weapon_6.HRPWeld
                                                        C0_4 = Weapon_6.HRPWeld.C0
                                                        HRPWeldBase_3 = Weapon_6.HRPWeldBase
                                                        HRPWeld_5.C0 = C0_4:Lerp(HRPWeldBase_3, v34)
                                                    end
                                                elseif Weapon_6.HeadRef then
                                                    v25 = Weapon_6.HeadRef.CFrame * Weapon_6.HRPWeldBase
                                                    v26 = CFrame.fromMatrix(
                                                        v25.Position,
                                                        v25.XVector * -1,
                                                        v25.YVector,
                                                        v25.ZVector
                                                    )
                                                    Weapon_6.Viewmodel.Model.HumanoidRootPart.CFrame = v26
                                                elseif Weapon_6.HRPWeld then
                                                    HRPWeld_5 = Weapon_6.HRPWeld
                                                    C0_4 = Weapon_6.HRPWeld.C0
                                                    HRPWeldBase_3 = Weapon_6.HRPWeldBase
                                                    HRPWeld_5.C0 = C0_4:Lerp(HRPWeldBase_3, v34)
                                                end
                                            end
                                            v24 = u146
                                            v23 = v24 * -0.3
                                            v20 = (math.exp(v23)) * 50 + 10
                                            if not v3 then
                                                if 5 < v32 then
                                                    j.SecondaryWorldModel.Weapon.LowPolyMode = true
                                                    if j.SecondaryWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                        j.SecondaryWorldModel.Attachments.Parent = nil
                                                    end
                                                    j.SecondaryWorldModel.HideKeyparts(true)
                                                    j.SecondaryWorldModel.HighPolyModel.Parent = nil
                                                    j.SecondaryWorldModel.LowPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                end
                                            elseif v32 <= v20 then
                                                j.SecondaryWorldModel.Weapon.LowPolyMode = false
                                                j.SecondaryWorldModel.HighPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                j.SecondaryWorldModel.Attachments.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                j.SecondaryWorldModel.LowPolyModel.Parent = nil
                                                j.SecondaryWorldModel.HideKeyparts(false)
                                            elseif 5 < v32 then
                                                j.SecondaryWorldModel.Weapon.LowPolyMode = true
                                                if j.SecondaryWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                    j.SecondaryWorldModel.Attachments.Parent = nil
                                                end
                                                j.SecondaryWorldModel.HideKeyparts(true)
                                                j.SecondaryWorldModel.HighPolyModel.Parent = nil
                                                j.SecondaryWorldModel.LowPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                            end
                                        end
                                        if DualWieldActive_2 and j.WorldModel and j.WorldModel.Weapon then
                                            Weapon_7 = j.WorldModel.Weapon
                                            if Weapon_7.HRPWeldBaseC0 and Weapon_7.HRPWeldBase then
                                                v20 = Weapon_7.HRPWeldBase * u266
                                                HRPWeld_7 = Weapon_7.HRPWeld
                                                HRPWeld_7.C0 = Weapon_7.HRPWeld.C0:Lerp(v20, v34)
                                            end
                                        end
                                    elseif j.SecondaryWorldModel then
                                        DestroySecondaryModel(j)
                                    end
                                    OffHandActive_2 = PlayerState.OffHandActive
                                    OffHandEquipped = PlayerState.OffHandEquipped
                                    local OffHandWepId = PlayerState.OffHandWepId
                                    v21 = OffHandEquipped
                                    if v21 then
                                        v21 = false
                                        if OffHandEquipped ~= "" then
                                            v21 = OffHandEquipped ~= false
                                        end
                                    end
                                    if not v21 then
                                        if j.OffHandWorldModel then
                                            DestroyOffHandModel(j)
                                        end
                                    elseif HeadCopy then
                                        if not j.OffHandWorldModel then
                                            j.OffHandWorldModel = {}
                                        end
                                        v22 = true
                                        if j.OffHandWorldModel.Equipped == OffHandEquipped then
                                            v22 = j.OffHandWorldModel.Weapon
                                            if v22 then
                                                v22 = j.OffHandWorldModel.Weapon.WepId ~= OffHandWepId
                                            end
                                        end
                                        if v22 then
                                            if j.OffHandWorldModel and j.OffHandWorldModel.Weapon then
                                                DestroyOffHandModel(j)
                                                j.OffHandWorldModel = {}
                                            end
                                            j.OffHandWorldModel.Equipped = OffHandEquipped
                                            local OffHandWorldModel = j.OffHandWorldModel
                                            v24 = j.OffHandWorldModel
                                            v24.Promise = GetWeapon(OffHandEquipped, nil, i)
                                            j.OffHandWorldModel.Promise:andThen(function(p1) -- Line: 1416
                                                -- upvalues: j (val), OffHandWorldModel (val), OffHandWepId (val)
                                                -- upvalues: ReplicatedStorage (upval), HeadCopy (val)
                                                local Model_2, Name, Weld_3, WeldedShoulders, v1, v2, v3, v4, v5
                                                if j.OffHandWorldModel ~= OffHandWorldModel then
                                                    p1.Viewmodel:Destroy()
                                                    return
                                                end
                                                p1.WepId = OffHandWepId
                                                p1.IsOffHand = true
                                                local Model = p1.Viewmodel.Model
                                                Model.HumanoidRootPart.Anchored = false
                                                local IsAPistol = p1.Config.IsAPistol
                                                local BulletsPerShot = p1.Config.BulletsPerShot
                                                if BulletsPerShot then
                                                    BulletsPerShot = 5 <= p1.Config.BulletsPerShot
                                                end
                                                local IsMelee = p1.Config.IsMelee
                                                if p1.Config.LODModel then
                                                    v5 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                                elseif IsAPistol then
                                                    v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                                elseif BulletsPerShot then
                                                    v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                                elseif not IsMelee then
                                                    v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                                else
                                                    v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                                end
                                                local Weld = Instance.new("Weld")
                                                Weld.Part0 = v5.Handle
                                                Weld.Part1 = Model.KeyParts.Handle
                                                local C0 = Weld.C0
                                                local LODOffset = p1.Config.LODOffset
                                                if not LODOffset then
                                                    LODOffset = CFrame.new()
                                                end
                                                Weld.C0 = C0 * LODOffset
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
                                                local v6 = j
                                                local OffHandWorldModel_2 = v6.OffHandWorldModel

                                                function OffHandWorldModel_2.HideKeyparts(p1) -- Line: 1471
                                                    -- upvalues: Children (val), Model (val)
                                                    local KeyParts
                                                    local v1 = Children
                                                    local v2 = nil
                                                    local v3 = nil
                                                    local v4 = p1
                                                    for i, j in v1, v2, v3 do
                                                        if not j:IsA("BasePart") then
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
                                                local v7 = nil
                                                local v8 = nil
                                                local v9 = p1
                                                for i, j2 in Shoulders, v7, v8 do
                                                    if j2 and j2.Name == "Left Shoulder" and j2.Part1 then
                                                        if v9.Config.ArmIgnores and v9.Config.ArmIgnores[j2.Name] then
                                                            continue
                                                        end
                                                        Name = j2.Part1.Name
                                                        v1 = Model:FindFirstChild(Name)
                                                        if v1 then
                                                            if j.WorldModel
                                                                and j.WorldModel.Weapon
                                                                and j.WorldModel.Weapon.Viewmodel then
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
                                                            Weld_3.Part1 = v1
                                                            v2 = 3 < v1.Size.Y
                                                            if not v2 then
                                                                v3 = CFrame.new()
                                                            else
                                                                v3 = CFrame.new(0, -1, 0)
                                                                if not v3 then
                                                                    v3 = CFrame.new()
                                                                end
                                                            end
                                                            Weld_3.C1 = v3
                                                            Weld_3.Parent = Model
                                                            j2.Enabled = false
                                                            v4 = j
                                                            WeldedShoulders = v4.OffHandWorldModel.WeldedShoulders
                                                            table.insert(WeldedShoulders, j2)
                                                            break
                                                        end
                                                    end
                                                end
                                                j.OffHandWorldModel.Weapon = v9
                                                v9:Equip()
                                            end)
                                        elseif j.OffHandWorldModel and j.OffHandWorldModel.Weapon then
                                            v23 = j.OffHandWorldModel.Weapon
                                            if v23.HRPWeldBaseC0 and v23.HRPWeld then
                                                v23.HRPWeldBase = v23.HRPWeldBaseC0 * u288
                                                v24 = v23.HRPWeld
                                                v25 = v23.HRPWeld.C0
                                                v27 = v23.HRPWeldBase
                                                v24.C0 = v25:Lerp(v27, v34)
                                            end
                                            v28 = u146
                                            v27 = v28 * -0.3
                                            v24 = (math.exp(v27)) * 50 + 10
                                            if not v3 then
                                                if 5 < v32 then
                                                    j.OffHandWorldModel.Weapon.LowPolyMode = true
                                                    if j.OffHandWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                        j.OffHandWorldModel.Attachments.Parent = nil
                                                    end
                                                    j.OffHandWorldModel.HideKeyparts(true)
                                                    j.OffHandWorldModel.HighPolyModel.Parent = nil
                                                    j.OffHandWorldModel.LowPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                end
                                            elseif v32 <= v24 then
                                                j.OffHandWorldModel.Weapon.LowPolyMode = false
                                                j.OffHandWorldModel.HighPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                j.OffHandWorldModel.Attachments.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                j.OffHandWorldModel.LowPolyModel.Parent = nil
                                                j.OffHandWorldModel.HideKeyparts(false)
                                            elseif 5 < v32 then
                                                j.OffHandWorldModel.Weapon.LowPolyMode = true
                                                if j.OffHandWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                    j.OffHandWorldModel.Attachments.Parent = nil
                                                end
                                                j.OffHandWorldModel.HideKeyparts(true)
                                                j.OffHandWorldModel.HighPolyModel.Parent = nil
                                                j.OffHandWorldModel.LowPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                            end
                                        end
                                    elseif j.OffHandWorldModel then
                                        DestroyOffHandModel(j)
                                    end
                                end
                            elseif not HRP then
                                v5 = u144[i].YawGoal or 0
                                v6 = u144[i].LookGoal or 0
                                if u144[i].LookAttachment then
                                    LookAttachment_3 = u144[i].LookAttachment
                                    LookAttachment_3.CFrame = (CFrame.Angles(v6, v5, 0)) * CFrame.new(0, 0, -5)
                                    if j.Animator then
                                        Animator_3 = j.Animator
                                        WorldPosition = u144[i].LookAttachment.WorldPosition
                                        Animator_3:SetLookPoint(WorldPosition)
                                        j.Animator:SetYaw(v5)
                                    end
                                    v7 = u68
                                    v9 = u144[i].LookAttachment.WorldPosition - u144[i].Head.Position
                                    v7:UpdatePlayerLookDirection(v9, i)
                                    local HeadCopy = j.HeadCopy
                                    Equipped_2 = PlayerState.Equipped
                                    local WepId = PlayerState.WepId
                                    WorldModel_2 = j.WorldModel
                                    v11 = j._lastQuickSwapActive or false
                                    QuickSwapActive_2 = PlayerState.QuickSwapActive
                                    SecondaryEquipped = PlayerState.SecondaryEquipped
                                    if j._promotedToEquipped then
                                        v12 = false
                                        if Equipped_2 == j._promotedToEquipped
                                            or Equipped_2 ~= j._waitingForEquippedFrom
                                            or j._promotionTimestamp and 2 < os.clock() - j._promotionTimestamp then
                                            v12 = true
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
                                                    WorldModel_5 = j.WorldModel
                                                    WeldedShoulders_4 = j.WorldModel.WeldedShoulders
                                                    if not WeldedShoulders_4 then
                                                        WeldedShoulders_4 = {}
                                                    end
                                                    WorldModel_5.WeldedShoulders = WeldedShoulders_4
                                                    Shoulders_2 = j.Shoulders
                                                    v17 = nil
                                                    v18 = nil
                                                    for i34, i35 in Shoulders_2, v17, v18 do
                                                        if i35 and i35.Part1 then
                                                            if not Weapon_2.Config.ArmIgnores then
                                                                v21 = false
                                                                WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                                v23 = nil
                                                                v24 = nil
                                                                for i36, i37 in WeldedShoulders_5, v23, v24 do
                                                                    if i37 == i35 then
                                                                        v21 = true
                                                                        break
                                                                    end
                                                                end
                                                                if not v21 then
                                                                    Name_2 = i35.Part1.Name
                                                                    v22 = Model_2:FindFirstChild(Name_2)
                                                                    if v22 then
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = i35.Part1
                                                                        Weld_3.Part1 = v22
                                                                        v24 = 3 < v22.Size.Y
                                                                        if not v24 then
                                                                            v25 = CFrame.new()
                                                                        else
                                                                            v25 = CFrame.new(0, -1, 0)
                                                                            if not v25 then
                                                                                v25 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld_3.C1 = v25
                                                                        Weld_3.Parent = Model_2
                                                                        WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_6, i35)
                                                                    end
                                                                end
                                                                i35.Enabled = false
                                                            elseif not Weapon_2.Config.ArmIgnores[i35.Name] then
                                                                v21 = false
                                                                WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                                v23 = nil
                                                                v24 = nil
                                                                for i38, i39 in WeldedShoulders_5, v23, v24 do
                                                                    if i39 == i35 then
                                                                        v21 = true
                                                                        break
                                                                    end
                                                                end
                                                                if not v21 then
                                                                    Name_2 = i35.Part1.Name
                                                                    v22 = Model_2:FindFirstChild(Name_2)
                                                                    if v22 then
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = i35.Part1
                                                                        Weld_3.Part1 = v22
                                                                        v24 = 3 < v22.Size.Y
                                                                        if not v24 then
                                                                            v25 = CFrame.new()
                                                                        else
                                                                            v25 = CFrame.new(0, -1, 0)
                                                                            if not v25 then
                                                                                v25 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld_3.C1 = v25
                                                                        Weld_3.Parent = Model_2
                                                                        WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_6, i35)
                                                                    end
                                                                end
                                                                i35.Enabled = false
                                                            end
                                                        end
                                                    end
                                                    if not Weapon_2.HRPWeld then
                                                        Model_2.HumanoidRootPart.Anchored = false
                                                        Weld_2 = Instance.new("Weld")
                                                        Weld_2.Part0 = Model_2.HumanoidRootPart
                                                        Weld_2.Part1 = HeadCopy
                                                        C0_2 = Weld_2.C0
                                                        ReplicationOffset = Weapon_2.Config.ReplicationOffset
                                                        if not ReplicationOffset then
                                                            ReplicationOffset = CFrame.new()
                                                        end
                                                        Weld_2.C0 = C0_2 * ReplicationOffset
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
                                                        WorldModel_3 = j.WorldModel
                                                        WeldedShoulders = j.WorldModel.WeldedShoulders
                                                        if not WeldedShoulders then
                                                            WeldedShoulders = {}
                                                        end
                                                        WorldModel_3.WeldedShoulders = WeldedShoulders
                                                        Shoulders = j.Shoulders
                                                        v17 = nil
                                                        v18 = nil
                                                        for i40, i41 in Shoulders, v17, v18 do
                                                            if i41 and i41.Part1 then
                                                                if not Weapon.Config.ArmIgnores then
                                                                    Name = i41.Part1.Name
                                                                    v21 = Model:FindFirstChild(Name)
                                                                    if v21 then
                                                                        v22 = false
                                                                        for i42, i43 in Model:GetChildren() do
                                                                            if i43:IsA("Weld")
                                                                                and i43.Part0 == i41.Part1
                                                                                and i43.Part1 == v21 then
                                                                                v22 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v22 then
                                                                            Weld = Instance.new("Weld")
                                                                            Weld.Part0 = i41.Part1
                                                                            Weld.Part1 = v21
                                                                            v24 = 3 < v21.Size.Y
                                                                            if not v24 then
                                                                                v25 = CFrame.new()
                                                                            else
                                                                                v25 = CFrame.new(0, -1, 0)
                                                                                if not v25 then
                                                                                    v25 = CFrame.new()
                                                                                end
                                                                            end
                                                                            Weld.C1 = v25
                                                                            Weld.Parent = Model
                                                                        end
                                                                        v23 = false
                                                                        WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                        v25 = nil
                                                                        v26 = nil
                                                                        for i44, i45 in WeldedShoulders_2, v25, v26 do
                                                                            if i45 == i41 then
                                                                                v23 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v23 then
                                                                            WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_3, i41)
                                                                        end
                                                                    end
                                                                    i41.Enabled = false
                                                                elseif not Weapon.Config.ArmIgnores[i41.Name] then
                                                                    Name = i41.Part1.Name
                                                                    v21 = Model:FindFirstChild(Name)
                                                                    if v21 then
                                                                        v22 = false
                                                                        for i46, i47 in Model:GetChildren() do
                                                                            if i47:IsA("Weld")
                                                                                and i47.Part0 == i41.Part1
                                                                                and i47.Part1 == v21 then
                                                                                v22 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v22 then
                                                                            Weld = Instance.new("Weld")
                                                                            Weld.Part0 = i41.Part1
                                                                            Weld.Part1 = v21
                                                                            v24 = 3 < v21.Size.Y
                                                                            if not v24 then
                                                                                v25 = CFrame.new()
                                                                            else
                                                                                v25 = CFrame.new(0, -1, 0)
                                                                                if not v25 then
                                                                                    v25 = CFrame.new()
                                                                                end
                                                                            end
                                                                            Weld.C1 = v25
                                                                            Weld.Parent = Model
                                                                        end
                                                                        v23 = false
                                                                        WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                        v25 = nil
                                                                        v26 = nil
                                                                        for i48, i49 in WeldedShoulders_2, v25, v26 do
                                                                            if i49 == i41 then
                                                                                v23 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v23 then
                                                                            WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_3, i41)
                                                                        end
                                                                    end
                                                                    i41.Enabled = false
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        elseif SecondaryEquipped == ""
                                            and j.SecondaryWorldModel
                                            and j.SecondaryWorldModel.Weapon then
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
                                                WorldModel_5 = j.WorldModel
                                                WeldedShoulders_4 = j.WorldModel.WeldedShoulders
                                                if not WeldedShoulders_4 then
                                                    WeldedShoulders_4 = {}
                                                end
                                                WorldModel_5.WeldedShoulders = WeldedShoulders_4
                                                Shoulders_2 = j.Shoulders
                                                v17 = nil
                                                v18 = nil
                                                for i50, i51 in Shoulders_2, v17, v18 do
                                                    if i51 and i51.Part1 then
                                                        if not Weapon_2.Config.ArmIgnores then
                                                            v21 = false
                                                            WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                            v23 = nil
                                                            v24 = nil
                                                            for i52, i53 in WeldedShoulders_5, v23, v24 do
                                                                if i53 == i51 then
                                                                    v21 = true
                                                                    break
                                                                end
                                                            end
                                                            if not v21 then
                                                                Name_2 = i51.Part1.Name
                                                                v22 = Model_2:FindFirstChild(Name_2)
                                                                if v22 then
                                                                    Weld_3 = Instance.new("Weld")
                                                                    Weld_3.Part0 = i51.Part1
                                                                    Weld_3.Part1 = v22
                                                                    v24 = 3 < v22.Size.Y
                                                                    if not v24 then
                                                                        v25 = CFrame.new()
                                                                    else
                                                                        v25 = CFrame.new(0, -1, 0)
                                                                        if not v25 then
                                                                            v25 = CFrame.new()
                                                                        end
                                                                    end
                                                                    Weld_3.C1 = v25
                                                                    Weld_3.Parent = Model_2
                                                                    WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                    table.insert(WeldedShoulders_6, i51)
                                                                end
                                                            end
                                                            i51.Enabled = false
                                                        elseif not Weapon_2.Config.ArmIgnores[i51.Name] then
                                                            v21 = false
                                                            WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                            v23 = nil
                                                            v24 = nil
                                                            for i54, i55 in WeldedShoulders_5, v23, v24 do
                                                                if i55 == i51 then
                                                                    v21 = true
                                                                    break
                                                                end
                                                            end
                                                            if not v21 then
                                                                Name_2 = i51.Part1.Name
                                                                v22 = Model_2:FindFirstChild(Name_2)
                                                                if v22 then
                                                                    Weld_3 = Instance.new("Weld")
                                                                    Weld_3.Part0 = i51.Part1
                                                                    Weld_3.Part1 = v22
                                                                    v24 = 3 < v22.Size.Y
                                                                    if not v24 then
                                                                        v25 = CFrame.new()
                                                                    else
                                                                        v25 = CFrame.new(0, -1, 0)
                                                                        if not v25 then
                                                                            v25 = CFrame.new()
                                                                        end
                                                                    end
                                                                    Weld_3.C1 = v25
                                                                    Weld_3.Parent = Model_2
                                                                    WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                    table.insert(WeldedShoulders_6, i51)
                                                                end
                                                            end
                                                            i51.Enabled = false
                                                        end
                                                    end
                                                end
                                                if not Weapon_2.HRPWeld then
                                                    Model_2.HumanoidRootPart.Anchored = false
                                                    Weld_2 = Instance.new("Weld")
                                                    Weld_2.Part0 = Model_2.HumanoidRootPart
                                                    Weld_2.Part1 = HeadCopy
                                                    C0_2 = Weld_2.C0
                                                    ReplicationOffset = Weapon_2.Config.ReplicationOffset
                                                    if not ReplicationOffset then
                                                        ReplicationOffset = CFrame.new()
                                                    end
                                                    Weld_2.C0 = C0_2 * ReplicationOffset
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
                                                    WorldModel_3 = j.WorldModel
                                                    WeldedShoulders = j.WorldModel.WeldedShoulders
                                                    if not WeldedShoulders then
                                                        WeldedShoulders = {}
                                                    end
                                                    WorldModel_3.WeldedShoulders = WeldedShoulders
                                                    Shoulders = j.Shoulders
                                                    v17 = nil
                                                    v18 = nil
                                                    for i56, i57 in Shoulders, v17, v18 do
                                                        if i57 and i57.Part1 then
                                                            if not Weapon.Config.ArmIgnores then
                                                                Name = i57.Part1.Name
                                                                v21 = Model:FindFirstChild(Name)
                                                                if v21 then
                                                                    v22 = false
                                                                    for i58, i59 in Model:GetChildren() do
                                                                        if i59:IsA("Weld")
                                                                            and i59.Part0 == i57.Part1
                                                                            and i59.Part1 == v21 then
                                                                            v22 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v22 then
                                                                        Weld = Instance.new("Weld")
                                                                        Weld.Part0 = i57.Part1
                                                                        Weld.Part1 = v21
                                                                        v24 = 3 < v21.Size.Y
                                                                        if not v24 then
                                                                            v25 = CFrame.new()
                                                                        else
                                                                            v25 = CFrame.new(0, -1, 0)
                                                                            if not v25 then
                                                                                v25 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld.C1 = v25
                                                                        Weld.Parent = Model
                                                                    end
                                                                    v23 = false
                                                                    WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                    v25 = nil
                                                                    v26 = nil
                                                                    for i60, i61 in WeldedShoulders_2, v25, v26 do
                                                                        if i61 == i57 then
                                                                            v23 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v23 then
                                                                        WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_3, i57)
                                                                    end
                                                                end
                                                                i57.Enabled = false
                                                            elseif not Weapon.Config.ArmIgnores[i57.Name] then
                                                                Name = i57.Part1.Name
                                                                v21 = Model:FindFirstChild(Name)
                                                                if v21 then
                                                                    v22 = false
                                                                    for i62, i63 in Model:GetChildren() do
                                                                        if i63:IsA("Weld")
                                                                            and i63.Part0 == i57.Part1
                                                                            and i63.Part1 == v21 then
                                                                            v22 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v22 then
                                                                        Weld = Instance.new("Weld")
                                                                        Weld.Part0 = i57.Part1
                                                                        Weld.Part1 = v21
                                                                        v24 = 3 < v21.Size.Y
                                                                        if not v24 then
                                                                            v25 = CFrame.new()
                                                                        else
                                                                            v25 = CFrame.new(0, -1, 0)
                                                                            if not v25 then
                                                                                v25 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld.C1 = v25
                                                                        Weld.Parent = Model
                                                                    end
                                                                    v23 = false
                                                                    WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                    v25 = nil
                                                                    v26 = nil
                                                                    for i64, i65 in WeldedShoulders_2, v25, v26 do
                                                                        if i65 == i57 then
                                                                            v23 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v23 then
                                                                        WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_3, i57)
                                                                    end
                                                                end
                                                                i57.Enabled = false
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    j._lastQuickSwapActive = QuickSwapActive_2
                                    if not Equipped_2 or Equipped_2 == "" then
                                        if j.WorldModel then
                                            DestroyModel(j)
                                        end
                                    elseif HeadCopy then
                                        if not j.WorldModel then
                                            j.WorldModel = {}
                                        end
                                        v12 = j._promotedToEquipped ~= nil
                                        Weapon_3 = not v12
                                        if Weapon_3 then
                                            Weapon_3 = false
                                            v14 = os.clock()
                                            if (j.WorldModel.RetryAfter or 0) <= v14 then
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
                                            WorldModel_7 = j.WorldModel
                                            WorldModel_7.Promise = GetWeapon(Equipped_2, nil, i)
                                            ;(j.WorldModel.Promise:andThen(function(p1) -- Line: 885
                                                -- upvalues: j (val), WorldModel (val), WepId (val)
                                                -- upvalues: ReplicatedStorage (upval), HeadCopy (val)
                                                -- upvalues: QuickSwapActive (val), DualWieldActive (val)
                                                -- upvalues: OffHandActive (val)
                                                local Name, Weld_3, WeldedShoulders, WeldedShoulders_2, v1, v2, v3, v4, v5, v6, v7
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
                                                else
                                                    v6 = not not (5 <= p1.Config.BulletsPerShot)
                                                end
                                                local IsMelee = p1.Config.IsMelee
                                                if p1.Config.LODModel then
                                                    v7 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                                elseif IsAPistol then
                                                    v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                                elseif v6 then
                                                    v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                                elseif not IsMelee then
                                                    v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                                else
                                                    v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                                end
                                                local Weld = Instance.new("Weld")
                                                Weld.Part0 = v7.Handle
                                                Weld.Part1 = Model.KeyParts.Handle
                                                local C0 = Weld.C0
                                                local LODOffset = p1.Config.LODOffset
                                                if not LODOffset then
                                                    LODOffset = CFrame.new()
                                                end
                                                Weld.C0 = C0 * LODOffset
                                                Weld.Parent = v7
                                                v7.Parent = nil
                                                local Weld_2 = Instance.new("Weld")
                                                Weld_2.Part0 = Model.HumanoidRootPart
                                                Weld_2.Part1 = HeadCopy
                                                local C0_2 = Weld_2.C0
                                                local ReplicationOffset = p1.Config.ReplicationOffset
                                                if not ReplicationOffset then
                                                    ReplicationOffset = CFrame.new()
                                                end
                                                Weld_2.C0 = C0_2 * ReplicationOffset
                                                Weld_2.Parent = Model
                                                p1.HRPWeldBaseC1 = Weld_2.C1
                                                p1.HRPWeldBase = Weld_2.C0
                                                p1.HRPWeldBaseC0 = Weld_2.C0
                                                p1.HRPWeld = Weld_2
                                                j.WorldModel.LowPolyModel = v7
                                                j.WorldModel.HighPolyModel = Model.Weapon
                                                j.WorldModel.Attachments = Model.Attachments
                                                local Children = Model.KeyParts:GetChildren()
                                                local v8 = j
                                                local WorldModel_2 = v8.WorldModel

                                                function WorldModel_2.HideKeyparts(p1) -- Line: 942
                                                    -- upvalues: Children (val), Model (val)
                                                    local KeyParts
                                                    local v1 = Children
                                                    local v2 = nil
                                                    local v3 = nil
                                                    local v4 = p1
                                                    for i, j in v1, v2, v3 do
                                                        if not j:IsA("BasePart") then
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
                                                local v9 = nil
                                                local v10 = nil
                                                local v11 = p1
                                                for i, j2 in Shoulders, v9, v10 do
                                                    if j2 and j2.Part1 then
                                                        if not v11.Config.ArmIgnores
                                                            or not v11.Config.ArmIgnores[j2.Name] then
                                                            Name = j2.Part1.Name
                                                            v1 = Model:FindFirstChild(Name)
                                                            if v1 then
                                                                v2 = j2.Name == "Left Shoulder"
                                                                if QuickSwapActive or DualWieldActive then
                                                                    if not v2 then
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = j2.Part1
                                                                        Weld_3.Part1 = v1
                                                                        v3 = 3 < v1.Size.Y
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
                                                                        v5 = j
                                                                        WeldedShoulders_2 = v5.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_2, j2)
                                                                    elseif j2 then
                                                                        j2.Enabled = false
                                                                        v3 = j
                                                                        WeldedShoulders = v3.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders, j2)
                                                                    end
                                                                elseif not OffHandActive or not v2 then
                                                                    Weld_3 = Instance.new("Weld")
                                                                    Weld_3.Part0 = j2.Part1
                                                                    Weld_3.Part1 = v1
                                                                    v3 = 3 < v1.Size.Y
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
                                                                    v5 = j
                                                                    WeldedShoulders_2 = v5.WorldModel.WeldedShoulders
                                                                    table.insert(WeldedShoulders_2, j2)
                                                                elseif j2 then
                                                                    j2.Enabled = false
                                                                    v3 = j
                                                                    WeldedShoulders = v3.WorldModel.WeldedShoulders
                                                                    table.insert(WeldedShoulders, j2)
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                                j.WorldModel.Weapon = v11
                                                v11:Equip()
                                            end)):catch(function(p1) -- Line: 1003 -- upvalues: j (val), WorldModel (val), WepId (val)
                                                if j.WorldModel == WorldModel then
                                                    local v1 = warn
                                                    local v2 = WepId
                                                    v1("[ReplicationController] Failed to create world weapon " .. (tostring(v2)) .. ": " .. tostring(p1))
                                                    DestroyModel(j)
                                                    j.WorldModel.RetryAfter = os.clock() + 2
                                                end
                                            end)
                                        elseif j.WorldModel and j.WorldModel.Weapon then
                                            Weapon_4 = j.WorldModel.Weapon
                                            if not PlayerState.Sprinting then
                                                if Weapon_4.Sprinting then
                                                    Weapon_4.Sprinting = false
                                                    v15 = TweenService
                                                    HRPWeld_2 = Weapon_4.HRPWeld
                                                    v18 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                                                    v19 = {C1 = Weapon_4.HRPWeldBaseC1}
                                                    v15:Create(HRPWeld_2, v18, v19):Play()
                                                end
                                            elseif not Weapon_4.Sprinting then
                                                Weapon_4.Sprinting = true
                                                v15 = TweenService
                                                HRPWeld = Weapon_4.HRPWeld
                                                v18 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                                                v19 = {
                                                    C1 = Weapon_4.HRPWeldBaseC1 * CFrame.Angles(-0.4, 0, 0),
                                                }
                                                v15:Create(HRPWeld, v18, v19):Play()
                                            end
                                            if j.Animator and Weapon_4.HRPWeldBaseC0 then
                                                AimTwistAngle = j.Animator:GetAimTwistAngle()
                                                Weapon_4.aimTwistAngle = AimTwistAngle
                                                v16 = j.LookGoal or 0
                                                v18 = v16 / 1.5707963267948966
                                                v17 = math.clamp(v18, 0, 1)
                                                if not PlayerState.Aiming then
                                                    v18 = 0.5
                                                else
                                                    v18 = 0.8
                                                end
                                                v16 = v16 * v18
                                                if not PlayerState.Proning then
                                                    v18 = 0
                                                else
                                                    v18 = 1.5707963267948966
                                                end
                                                RecoilOffset = Weapon_4.RecoilOffset
                                                if not RecoilOffset then
                                                    RecoilOffset = CFrame.identity
                                                end
                                                identity = CFrame.identity
                                                Weapon_4.RecoilOffset = RecoilOffset:Lerp(identity, v34)
                                                v24 = Weapon_4.HRPWeldBaseC0 * Weapon_4.RecoilOffset
                                                if not PlayerState.Proning then
                                                    v25 = CFrame.new()
                                                else
                                                    v25 = CFrame.new(0, -1, -1)
                                                    if not v25 then
                                                        v25 = CFrame.new()
                                                    end
                                                end
                                                v23 = v24 * v25
                                                v24 = CFrame.new()
                                                if PlayerState.Proning then
                                                    v26 = CFrame.new()
                                                else
                                                    v26 = CFrame.new(0, 0, -0.5)
                                                    if not v26 then
                                                        v26 = CFrame.new()
                                                    end
                                                end
                                                v20 = v23 * v24:Lerp(v26, v17) * CFrame.Angles(-v18, 0, 0) * CFrame.Angles(-v16, 0, 0)
                                                Angles_2 = CFrame.Angles
                                                v22 = 0
                                                if PlayerState.Proning then
                                                    v23 = 0
                                                else
                                                    v23 = -AimTwistAngle
                                                    if not v23 then
                                                        v23 = 0
                                                    end
                                                end
                                                Weapon_4.HRPWeldBase = v20 * Angles_2(v22, v23, 0)
                                                v19 = os.clock()
                                                LastShotTime = Weapon_4.LastShotTime
                                                if LastShotTime then
                                                    LastShotTime = v19 - Weapon_4.LastShotTime < 2
                                                end
                                                v21 = not PlayerState.Aiming and not PlayerState.Sprinting and not LastShotTime and not PlayerState.Proning and not PlayerState.QuickSwapActive and not PlayerState.DualWieldActive and not PlayerState.OffHandActive
                                                Weapon_4.GunRestAlpha = Weapon_4.GunRestAlpha or 0
                                                if not v21 then
                                                    v22 = 0
                                                else
                                                    v22 = 1
                                                end
                                                Weapon_4.GunRestAlpha = Weapon_4.GunRestAlpha + (v22 - Weapon_4.GunRestAlpha) * v34 * 0.3
                                                HRPWeldBase = Weapon_4.HRPWeldBase
                                                v25 = CFrame.new()
                                                v27 = u244
                                                GunRestAlpha = Weapon_4.GunRestAlpha
                                                Weapon_4.HRPWeldBase = HRPWeldBase * v25:Lerp(v27, GunRestAlpha)
                                                HRPWeld_3 = Weapon_4.HRPWeld
                                                C0_3 = Weapon_4.HRPWeld.C0
                                                HRPWeldBase_2 = Weapon_4.HRPWeldBase
                                                HRPWeld_3.C0 = C0_3:Lerp(HRPWeldBase_2, v34)
                                            end
                                            if PlayerState.Charging then
                                                j.WorldModel.Weapon:Charging()
                                            end
                                            if PlayerState.Blocking then
                                                j.WorldModel.Weapon:Blocking()
                                            elseif j.WorldModel.Weapon.Block then
                                                j.WorldModel.Weapon:StopBlocking()
                                            end
                                            v18 = u146
                                            v17 = v18 * -0.3
                                            v14 = (math.exp(v17)) * 50 + 10
                                            if not v3 then
                                                if 5 < v32 then
                                                    j.WorldModel.Weapon.LowPolyMode = true
                                                    if j.WorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                        j.WorldModel.Attachments.Parent = nil
                                                    end
                                                    j.WorldModel.HideKeyparts(true)
                                                    j.WorldModel.HighPolyModel.Parent = nil
                                                    j.WorldModel.LowPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                end
                                            elseif v32 <= v14 then
                                                j.WorldModel.Weapon.LowPolyMode = false
                                                j.WorldModel.HighPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                j.WorldModel.Attachments.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                j.WorldModel.LowPolyModel.Parent = nil
                                                j.WorldModel.HideKeyparts(false)
                                            elseif 5 < v32 then
                                                j.WorldModel.Weapon.LowPolyMode = true
                                                if j.WorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                    j.WorldModel.Attachments.Parent = nil
                                                end
                                                j.WorldModel.HideKeyparts(true)
                                                j.WorldModel.HighPolyModel.Parent = nil
                                                j.WorldModel.LowPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                            end
                                        end
                                    elseif j.WorldModel then
                                        DestroyModel(j)
                                    end
                                    SecondaryEquipped_2 = PlayerState.SecondaryEquipped
                                    local SecondaryWepId = PlayerState.SecondaryWepId
                                    QuickSwapActive_3 = PlayerState.QuickSwapActive
                                    local DualWieldActive_2 = PlayerState.DualWieldActive
                                    v16 = SecondaryEquipped_2
                                    if v16 then
                                        v16 = false
                                        if SecondaryEquipped_2 ~= "" then
                                            v16 = SecondaryEquipped_2 ~= false
                                        end
                                    end
                                    if j.SecondaryWorldModel and j.SecondaryWorldModel.Weapon ~= nil then end
                                    if not v16 then
                                        if j.SecondaryWorldModel then
                                            DestroySecondaryModel(j)
                                        end
                                    elseif HeadCopy then
                                        if not j.SecondaryWorldModel then
                                            j.SecondaryWorldModel = {}
                                        end
                                        Weapon_5 = true
                                        if j.SecondaryWorldModel.Equipped == SecondaryEquipped_2 then
                                            if not j.SecondaryWorldModel.Weapon
                                                or not j.SecondaryWorldModel.Weapon.WepId then
                                                Weapon_5 = j.SecondaryWorldModel.Weapon
                                                if Weapon_5 then
                                                    Weapon_5 = j.SecondaryWorldModel.Weapon.IsMirrored ~= DualWieldActive_2
                                                end
                                            else
                                                Weapon_5 = true
                                                if j.SecondaryWorldModel.Weapon.WepId == SecondaryWepId then
                                                    Weapon_5 = j.SecondaryWorldModel.Weapon
                                                    if Weapon_5 then
                                                        Weapon_5 = j.SecondaryWorldModel.Weapon.IsMirrored ~= DualWieldActive_2
                                                    end
                                                end
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
                                            j.SecondaryWorldModel.Promise:andThen(function(p1) -- Line: 1171
                                                -- upvalues: j (val), SecondaryWorldModel (val), SecondaryWepId (val)
                                                -- upvalues: DualWieldActive_2 (val), ReplicatedStorage (upval)
                                                -- upvalues: HeadCopy (val), CreateMirroredArmModel (upval), i (val)
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
                                                else
                                                    v2 = not not (5 <= p1.Config.BulletsPerShot)
                                                end
                                                local IsMelee = p1.Config.IsMelee
                                                if p1.Config.LODModel then
                                                    v3 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                                elseif IsAPistol then
                                                    v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                                elseif v2 then
                                                    v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                                elseif not IsMelee then
                                                    v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                                else
                                                    v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                                end
                                                local Weld = Instance.new("Weld")
                                                Weld.Part0 = v3.Handle
                                                Weld.Part1 = Model.KeyParts.Handle
                                                local C0 = Weld.C0
                                                local LODOffset = p1.Config.LODOffset
                                                if not LODOffset then
                                                    LODOffset = CFrame.new()
                                                end
                                                Weld.C0 = C0 * LODOffset
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
                                                local v4 = j
                                                local SecondaryWorldModel_2 = v4.SecondaryWorldModel

                                                function SecondaryWorldModel_2.HideKeyparts(p1) -- Line: 1242
                                                    -- upvalues: Children (val), Model (val)
                                                    local KeyParts
                                                    local v1 = Children
                                                    local v2 = nil
                                                    local v3 = nil
                                                    local v4 = p1
                                                    for i, j in v1, v2, v3 do
                                                        if not j:IsA("BasePart") then
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
                                                local v5 = {}
                                                j.SecondaryWorldModel.WeldedShoulders = v5
                                                j.SecondaryWorldModel.ArmModel = nil
                                                if DualWieldActive_2 then
                                                    j.SecondaryWorldModel.ArmModel = CreateMirroredArmModel(Model, i)
                                                    v1 = p1
                                                else
                                                    local Name, Weld_3, WeldedShoulders, v6, v7, v8, v9
                                                    local Shoulders = j.Shoulders
                                                    v5 = nil
                                                    local v10 = nil
                                                    v1 = p1
                                                    for i2, j2 in Shoulders, v5, v10 do
                                                        if j2 and j2.Name == "Left Shoulder" and j2.Part1 then
                                                            if not v1.Config.ArmIgnores then
                                                                Name = j2.Part1.Name
                                                                v6 = Model:FindFirstChild(Name)
                                                                if not v6 then
                                                                    continue
                                                                else
                                                                    Weld_3 = Instance.new("Weld")
                                                                    Weld_3.Part0 = j2.Part1
                                                                    Weld_3.Part1 = v6
                                                                    v7 = 3 < v6.Size.Y
                                                                    if not v7 then
                                                                        v8 = CFrame.new()
                                                                    else
                                                                        v8 = CFrame.new(0, -1, 0)
                                                                        if not v8 then
                                                                            v8 = CFrame.new()
                                                                        end
                                                                    end
                                                                    Weld_3.C1 = v8
                                                                    Weld_3.Parent = Model
                                                                    j2.Enabled = false
                                                                    v9 = j
                                                                    WeldedShoulders = v9.SecondaryWorldModel.WeldedShoulders
                                                                    table.insert(WeldedShoulders, j2)
                                                                end
                                                            elseif v1.Config.ArmIgnores[j2.Name] then
                                                                continue
                                                            else
                                                                Name = j2.Part1.Name
                                                                v6 = Model:FindFirstChild(Name)
                                                                if not v6 then
                                                                    continue
                                                                else
                                                                    Weld_3 = Instance.new("Weld")
                                                                    Weld_3.Part0 = j2.Part1
                                                                    Weld_3.Part1 = v6
                                                                    v7 = 3 < v6.Size.Y
                                                                    if not v7 then
                                                                        v8 = CFrame.new()
                                                                    else
                                                                        v8 = CFrame.new(0, -1, 0)
                                                                        if not v8 then
                                                                            v8 = CFrame.new()
                                                                        end
                                                                    end
                                                                    Weld_3.C1 = v8
                                                                    Weld_3.Parent = Model
                                                                    j2.Enabled = false
                                                                    v9 = j
                                                                    WeldedShoulders = v9.SecondaryWorldModel.WeldedShoulders
                                                                    table.insert(WeldedShoulders, j2)
                                                                end
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
                                                v20 = CFrame.new()
                                                if DualWieldActive_2 then
                                                    v20 = u277
                                                elseif QuickSwapActive_3 then
                                                    Weapon_6.QuickSwapAlpha = Weapon_6.QuickSwapAlpha or 0
                                                    Weapon_6.QuickSwapAlpha = Weapon_6.QuickSwapAlpha + (1 - Weapon_6.QuickSwapAlpha) * v34 * 0.5
                                                    v21 = CFrame.new()
                                                    v23 = u255
                                                    QuickSwapAlpha = Weapon_6.QuickSwapAlpha
                                                    v20 = v21:Lerp(v23, QuickSwapAlpha)
                                                end
                                                v21 = j.LookGoal or 0
                                                v23 = v21 / 1.5707963267948966
                                                v22 = math.clamp(v23, 0, 1)
                                                if not PlayerState.Aiming then
                                                    v23 = 0.5
                                                else
                                                    v23 = 0.8
                                                end
                                                v21 = v21 * v23
                                                if not PlayerState.Proning then
                                                    v23 = 0
                                                else
                                                    v23 = 1.5707963267948966
                                                end
                                                RecoilOffset_2 = Weapon_6.RecoilOffset
                                                if not RecoilOffset_2 then
                                                    RecoilOffset_2 = CFrame.identity
                                                end
                                                identity_2 = CFrame.identity
                                                Weapon_6.RecoilOffset = RecoilOffset_2:Lerp(identity_2, v34)
                                                if not QuickSwapActive_3 then
                                                    v29 = Weapon_6.HRPWeldBaseC0 * v20
                                                    v28 = v29 * Weapon_6.RecoilOffset
                                                    if not PlayerState.Proning then
                                                        v29 = CFrame.new()
                                                    else
                                                        v29 = CFrame.new(0, -1, -1)
                                                        if not v29 then
                                                            v29 = CFrame.new()
                                                        end
                                                    end
                                                    v27 = v28 * v29
                                                    v28 = CFrame.new()
                                                    if PlayerState.Proning then
                                                        v30 = CFrame.new()
                                                    else
                                                        v30 = CFrame.new(0, 0, -0.5)
                                                        if not v30 then
                                                            v30 = CFrame.new()
                                                        end
                                                    end
                                                    Weapon_6.HRPWeldBase = v27 * v28:Lerp(v30, v22) * CFrame.Angles(-v23, 0, 0) * CFrame.Angles(-v21, 0, 0)
                                                else
                                                    Weapon_6.HRPWeldBase = Weapon_6.HRPWeldBaseC0 * v20
                                                end
                                                if not Weapon_6.IsMirrored then
                                                    if Weapon_6.HRPWeld then
                                                        HRPWeld_5 = Weapon_6.HRPWeld
                                                        C0_4 = Weapon_6.HRPWeld.C0
                                                        HRPWeldBase_3 = Weapon_6.HRPWeldBase
                                                        HRPWeld_5.C0 = C0_4:Lerp(HRPWeldBase_3, v34)
                                                    end
                                                elseif Weapon_6.HeadRef then
                                                    v25 = Weapon_6.HeadRef.CFrame * Weapon_6.HRPWeldBase
                                                    v26 = CFrame.fromMatrix(
                                                        v25.Position,
                                                        v25.XVector * -1,
                                                        v25.YVector,
                                                        v25.ZVector
                                                    )
                                                    Weapon_6.Viewmodel.Model.HumanoidRootPart.CFrame = v26
                                                elseif Weapon_6.HRPWeld then
                                                    HRPWeld_5 = Weapon_6.HRPWeld
                                                    C0_4 = Weapon_6.HRPWeld.C0
                                                    HRPWeldBase_3 = Weapon_6.HRPWeldBase
                                                    HRPWeld_5.C0 = C0_4:Lerp(HRPWeldBase_3, v34)
                                                end
                                            end
                                            v24 = u146
                                            v23 = v24 * -0.3
                                            v20 = (math.exp(v23)) * 50 + 10
                                            if not v3 then
                                                if 5 < v32 then
                                                    j.SecondaryWorldModel.Weapon.LowPolyMode = true
                                                    if j.SecondaryWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                        j.SecondaryWorldModel.Attachments.Parent = nil
                                                    end
                                                    j.SecondaryWorldModel.HideKeyparts(true)
                                                    j.SecondaryWorldModel.HighPolyModel.Parent = nil
                                                    j.SecondaryWorldModel.LowPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                end
                                            elseif v32 <= v20 then
                                                j.SecondaryWorldModel.Weapon.LowPolyMode = false
                                                j.SecondaryWorldModel.HighPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                j.SecondaryWorldModel.Attachments.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                j.SecondaryWorldModel.LowPolyModel.Parent = nil
                                                j.SecondaryWorldModel.HideKeyparts(false)
                                            elseif 5 < v32 then
                                                j.SecondaryWorldModel.Weapon.LowPolyMode = true
                                                if j.SecondaryWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                    j.SecondaryWorldModel.Attachments.Parent = nil
                                                end
                                                j.SecondaryWorldModel.HideKeyparts(true)
                                                j.SecondaryWorldModel.HighPolyModel.Parent = nil
                                                j.SecondaryWorldModel.LowPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                            end
                                        end
                                        if DualWieldActive_2 and j.WorldModel and j.WorldModel.Weapon then
                                            Weapon_7 = j.WorldModel.Weapon
                                            if Weapon_7.HRPWeldBaseC0 and Weapon_7.HRPWeldBase then
                                                v20 = Weapon_7.HRPWeldBase * u266
                                                HRPWeld_7 = Weapon_7.HRPWeld
                                                HRPWeld_7.C0 = Weapon_7.HRPWeld.C0:Lerp(v20, v34)
                                            end
                                        end
                                    elseif j.SecondaryWorldModel then
                                        DestroySecondaryModel(j)
                                    end
                                    OffHandActive_2 = PlayerState.OffHandActive
                                    OffHandEquipped = PlayerState.OffHandEquipped
                                    local OffHandWepId = PlayerState.OffHandWepId
                                    v21 = OffHandEquipped
                                    if v21 then
                                        v21 = false
                                        if OffHandEquipped ~= "" then
                                            v21 = OffHandEquipped ~= false
                                        end
                                    end
                                    if not v21 then
                                        if j.OffHandWorldModel then
                                            DestroyOffHandModel(j)
                                        end
                                    elseif HeadCopy then
                                        if not j.OffHandWorldModel then
                                            j.OffHandWorldModel = {}
                                        end
                                        v22 = true
                                        if j.OffHandWorldModel.Equipped == OffHandEquipped then
                                            v22 = j.OffHandWorldModel.Weapon
                                            if v22 then
                                                v22 = j.OffHandWorldModel.Weapon.WepId ~= OffHandWepId
                                            end
                                        end
                                        if v22 then
                                            if j.OffHandWorldModel and j.OffHandWorldModel.Weapon then
                                                DestroyOffHandModel(j)
                                                j.OffHandWorldModel = {}
                                            end
                                            j.OffHandWorldModel.Equipped = OffHandEquipped
                                            local OffHandWorldModel = j.OffHandWorldModel
                                            v24 = j.OffHandWorldModel
                                            v24.Promise = GetWeapon(OffHandEquipped, nil, i)
                                            j.OffHandWorldModel.Promise:andThen(function(p1) -- Line: 1416
                                                -- upvalues: j (val), OffHandWorldModel (val), OffHandWepId (val)
                                                -- upvalues: ReplicatedStorage (upval), HeadCopy (val)
                                                local Model_2, Name, Weld_3, WeldedShoulders, v1, v2, v3, v4, v5
                                                if j.OffHandWorldModel ~= OffHandWorldModel then
                                                    p1.Viewmodel:Destroy()
                                                    return
                                                end
                                                p1.WepId = OffHandWepId
                                                p1.IsOffHand = true
                                                local Model = p1.Viewmodel.Model
                                                Model.HumanoidRootPart.Anchored = false
                                                local IsAPistol = p1.Config.IsAPistol
                                                local BulletsPerShot = p1.Config.BulletsPerShot
                                                if BulletsPerShot then
                                                    BulletsPerShot = 5 <= p1.Config.BulletsPerShot
                                                end
                                                local IsMelee = p1.Config.IsMelee
                                                if p1.Config.LODModel then
                                                    v5 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                                elseif IsAPistol then
                                                    v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                                elseif BulletsPerShot then
                                                    v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                                elseif not IsMelee then
                                                    v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                                else
                                                    v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                                end
                                                local Weld = Instance.new("Weld")
                                                Weld.Part0 = v5.Handle
                                                Weld.Part1 = Model.KeyParts.Handle
                                                local C0 = Weld.C0
                                                local LODOffset = p1.Config.LODOffset
                                                if not LODOffset then
                                                    LODOffset = CFrame.new()
                                                end
                                                Weld.C0 = C0 * LODOffset
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
                                                local v6 = j
                                                local OffHandWorldModel_2 = v6.OffHandWorldModel

                                                function OffHandWorldModel_2.HideKeyparts(p1) -- Line: 1471
                                                    -- upvalues: Children (val), Model (val)
                                                    local KeyParts
                                                    local v1 = Children
                                                    local v2 = nil
                                                    local v3 = nil
                                                    local v4 = p1
                                                    for i, j in v1, v2, v3 do
                                                        if not j:IsA("BasePart") then
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
                                                local v7 = nil
                                                local v8 = nil
                                                local v9 = p1
                                                for i, j2 in Shoulders, v7, v8 do
                                                    if j2 and j2.Name == "Left Shoulder" and j2.Part1 then
                                                        if v9.Config.ArmIgnores and v9.Config.ArmIgnores[j2.Name] then
                                                            continue
                                                        end
                                                        Name = j2.Part1.Name
                                                        v1 = Model:FindFirstChild(Name)
                                                        if v1 then
                                                            if j.WorldModel
                                                                and j.WorldModel.Weapon
                                                                and j.WorldModel.Weapon.Viewmodel then
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
                                                            Weld_3.Part1 = v1
                                                            v2 = 3 < v1.Size.Y
                                                            if not v2 then
                                                                v3 = CFrame.new()
                                                            else
                                                                v3 = CFrame.new(0, -1, 0)
                                                                if not v3 then
                                                                    v3 = CFrame.new()
                                                                end
                                                            end
                                                            Weld_3.C1 = v3
                                                            Weld_3.Parent = Model
                                                            j2.Enabled = false
                                                            v4 = j
                                                            WeldedShoulders = v4.OffHandWorldModel.WeldedShoulders
                                                            table.insert(WeldedShoulders, j2)
                                                            break
                                                        end
                                                    end
                                                end
                                                j.OffHandWorldModel.Weapon = v9
                                                v9:Equip()
                                            end)
                                        elseif j.OffHandWorldModel and j.OffHandWorldModel.Weapon then
                                            v23 = j.OffHandWorldModel.Weapon
                                            if v23.HRPWeldBaseC0 and v23.HRPWeld then
                                                v23.HRPWeldBase = v23.HRPWeldBaseC0 * u288
                                                v24 = v23.HRPWeld
                                                v25 = v23.HRPWeld.C0
                                                v27 = v23.HRPWeldBase
                                                v24.C0 = v25:Lerp(v27, v34)
                                            end
                                            v28 = u146
                                            v27 = v28 * -0.3
                                            v24 = (math.exp(v27)) * 50 + 10
                                            if not v3 then
                                                if 5 < v32 then
                                                    j.OffHandWorldModel.Weapon.LowPolyMode = true
                                                    if j.OffHandWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                        j.OffHandWorldModel.Attachments.Parent = nil
                                                    end
                                                    j.OffHandWorldModel.HideKeyparts(true)
                                                    j.OffHandWorldModel.HighPolyModel.Parent = nil
                                                    j.OffHandWorldModel.LowPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                end
                                            elseif v32 <= v24 then
                                                j.OffHandWorldModel.Weapon.LowPolyMode = false
                                                j.OffHandWorldModel.HighPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                j.OffHandWorldModel.Attachments.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                j.OffHandWorldModel.LowPolyModel.Parent = nil
                                                j.OffHandWorldModel.HideKeyparts(false)
                                            elseif 5 < v32 then
                                                j.OffHandWorldModel.Weapon.LowPolyMode = true
                                                if j.OffHandWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                    j.OffHandWorldModel.Attachments.Parent = nil
                                                end
                                                j.OffHandWorldModel.HideKeyparts(true)
                                                j.OffHandWorldModel.HighPolyModel.Parent = nil
                                                j.OffHandWorldModel.LowPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                            end
                                        end
                                    elseif j.OffHandWorldModel then
                                        DestroyOffHandModel(j)
                                    end
                                end
                            elseif not (100 < (CurrentCamera.CFrame.Position - HRP.Position).Magnitude)
                                and j.LookAttachment then
                                if not PlayerState.Proning then
                                    j.HeadCopy.CanCollide = false
                                    LookAttachment_2 = j.LookAttachment
                                    LookAttachment_2.WorldPosition = RaycastUtil.CastBaseRay().Position
                                else
                                    j.HeadCopy.CanCollide = false
                                    LookAttachment = j.LookAttachment
                                    LookAttachment.WorldPosition = RaycastUtil.CastNoneRay().Position
                                end
                                u68:UpdatePlayerLookDirection(nil, i)
                            end
                        end
                    else
                        v32 = os.clock()
                        if j.Update < v32 then
                            p = workspace.CurrentCamera.CFrame.p
                            v32 = i:DistanceFromCharacter(p) or (1 / 0)
                            if i == Players.LocalPlayer or not u144[i].LastTick then
                                v33 = v40
                            else
                                v33 = os.clock() - u144[i].LastTick
                            end
                            v2 = v33 * 10
                            v34 = math.clamp(v2, 0.01, 1)
                            v1 = u144[i]
                            v1.LastTick = os.clock()
                            v4 = u146
                            v2 = math.pow(v4, 4) * 0.01
                            v1 = math.clamp(v2, 1, 4)
                            HRP = j.HRP
                            if not HRP or not HRP.Parent then
                                v3 = false
                            else
                                Position = HRP.Position
                                v5 = CurrentCamera
                                LookVector = v5.CFrame.LookVector
                                v6 = Position - CurrentCamera.CFrame.Position
                                v7 = CurrentCamera.FieldOfView + 2
                                v10 = v6.Unit:Angle(LookVector)
                                v9 = math.deg(v10)
                                v4 = not not (math.floor(v9) <= v7)
                                v3 = not not v4
                            end
                            v4 = v3
                            if v4 then
                                v4 = v32 <= 120
                            end
                            j.ProceduralVisible = v4
                            v4 = u144[i]
                            v5 = os.clock()
                            v9 = v32 / 100 * 0.1
                            v8 = math.max(v9, 0.016666666666666666)
                            v4.Update = v5 + v1 * math.clamp(v8, 0, 1)
                            PlayerState = PlayerHandler:GetPlayerState(i)
                            if PlayerState then
                                RootJoint = j.RootJoint
                                if RootJoint and HRP and RootJoint.Parent and HRP.Parent and v3 then
                                    if j.Animator then
                                        j.Animator:SetState(PlayerState)
                                        Animator_2 = j.Animator
                                        Equipped = PlayerState.Equipped
                                        if Equipped then
                                            Equipped = PlayerState.Equipped ~= ""
                                        end
                                        Animator_2:SetWeaponEquipped(Equipped)
                                        j.Animator:Heartbeat(v33)
                                        j.Animator:UpdateRenderStepped(v33, v32)
                                    end
                                    if i ~= Players.LocalPlayer then
                                        Proning = PlayerState.Proning
                                        Diving = PlayerState.Diving
                                        Velocity = HRP.Velocity
                                        RightVector = HRP.CFrame.RightVector
                                        v7 = -Velocity:Dot(RightVector)
                                        if not Diving then
                                            v8 = CFrame.new()
                                        else
                                            v8 = CFrame.Angles(0, math.clamp(v7, -1.0471975511965976, 1.0471975511965976), 0)
                                            if not v8 then
                                                v8 = CFrame.new()
                                            end
                                        end
                                        C0 = RootJoint.C0
                                        if not Proning then
                                            v11 = u212 * v8
                                            if not v11 then
                                                v11 = u206
                                            end
                                        elseif not Diving then
                                            v11 = u206
                                        else
                                            v11 = u212 * v8
                                            if not v11 then
                                                v11 = u206
                                            end
                                        end
                                        v9 = C0:Lerp(v11, v34)
                                        if not RootJoint.C0:FuzzyEq(v9, 0.0001) then
                                            RootJoint.C0 = v9
                                        end
                                    end
                                end
                                if j.NeckCF and j.Neck then
                                    NeckCF = j.NeckCF
                                    if not PlayerState.Aiming then
                                        v7 = CFrame.new()
                                    else
                                        v7 = CFrame.Angles(0, 0.3, 0)
                                        if not v7 then
                                            v7 = CFrame.new()
                                        end
                                    end
                                    j.NeckCF = NeckCF:Lerp(v7, v34)
                                    j.Neck.C1 = u181 * j.NeckCF
                                end
                                if i ~= Players.LocalPlayer then
                                    v5 = u144[i].YawGoal or 0
                                    v6 = u144[i].LookGoal or 0
                                    if u144[i].LookAttachment then
                                        LookAttachment_3 = u144[i].LookAttachment
                                        LookAttachment_3.CFrame = (CFrame.Angles(v6, v5, 0)) * CFrame.new(0, 0, -5)
                                        if j.Animator then
                                            Animator_3 = j.Animator
                                            WorldPosition = u144[i].LookAttachment.WorldPosition
                                            Animator_3:SetLookPoint(WorldPosition)
                                            j.Animator:SetYaw(v5)
                                        end
                                        v7 = u68
                                        v9 = u144[i].LookAttachment.WorldPosition - u144[i].Head.Position
                                        v7:UpdatePlayerLookDirection(v9, i)
                                        local HeadCopy = j.HeadCopy
                                        Equipped_2 = PlayerState.Equipped
                                        local WepId = PlayerState.WepId
                                        WorldModel_2 = j.WorldModel
                                        v11 = j._lastQuickSwapActive or false
                                        QuickSwapActive_2 = PlayerState.QuickSwapActive
                                        SecondaryEquipped = PlayerState.SecondaryEquipped
                                        if j._promotedToEquipped then
                                            v12 = false
                                            if Equipped_2 == j._promotedToEquipped
                                                or Equipped_2 ~= j._waitingForEquippedFrom
                                                or j._promotionTimestamp and 2 < os.clock() - j._promotionTimestamp then
                                                v12 = true
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
                                                        WorldModel_5 = j.WorldModel
                                                        WeldedShoulders_4 = j.WorldModel.WeldedShoulders
                                                        if not WeldedShoulders_4 then
                                                            WeldedShoulders_4 = {}
                                                        end
                                                        WorldModel_5.WeldedShoulders = WeldedShoulders_4
                                                        Shoulders_2 = j.Shoulders
                                                        v17 = nil
                                                        v18 = nil
                                                        for i66, i67 in Shoulders_2, v17, v18 do
                                                            if i67 and i67.Part1 then
                                                                if not Weapon_2.Config.ArmIgnores then
                                                                    v21 = false
                                                                    WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                                    v23 = nil
                                                                    v24 = nil
                                                                    for i68, i69 in WeldedShoulders_5, v23, v24 do
                                                                        if i69 == i67 then
                                                                            v21 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v21 then
                                                                        Name_2 = i67.Part1.Name
                                                                        v22 = Model_2:FindFirstChild(Name_2)
                                                                        if v22 then
                                                                            Weld_3 = Instance.new("Weld")
                                                                            Weld_3.Part0 = i67.Part1
                                                                            Weld_3.Part1 = v22
                                                                            v24 = 3 < v22.Size.Y
                                                                            if not v24 then
                                                                                v25 = CFrame.new()
                                                                            else
                                                                                v25 = CFrame.new(0, -1, 0)
                                                                                if not v25 then
                                                                                    v25 = CFrame.new()
                                                                                end
                                                                            end
                                                                            Weld_3.C1 = v25
                                                                            Weld_3.Parent = Model_2
                                                                            WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_6, i67)
                                                                        end
                                                                    end
                                                                    i67.Enabled = false
                                                                elseif not Weapon_2.Config.ArmIgnores[i67.Name] then
                                                                    v21 = false
                                                                    WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                                    v23 = nil
                                                                    v24 = nil
                                                                    for i70, i71 in WeldedShoulders_5, v23, v24 do
                                                                        if i71 == i67 then
                                                                            v21 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v21 then
                                                                        Name_2 = i67.Part1.Name
                                                                        v22 = Model_2:FindFirstChild(Name_2)
                                                                        if v22 then
                                                                            Weld_3 = Instance.new("Weld")
                                                                            Weld_3.Part0 = i67.Part1
                                                                            Weld_3.Part1 = v22
                                                                            v24 = 3 < v22.Size.Y
                                                                            if not v24 then
                                                                                v25 = CFrame.new()
                                                                            else
                                                                                v25 = CFrame.new(0, -1, 0)
                                                                                if not v25 then
                                                                                    v25 = CFrame.new()
                                                                                end
                                                                            end
                                                                            Weld_3.C1 = v25
                                                                            Weld_3.Parent = Model_2
                                                                            WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_6, i67)
                                                                        end
                                                                    end
                                                                    i67.Enabled = false
                                                                end
                                                            end
                                                        end
                                                        if not Weapon_2.HRPWeld then
                                                            Model_2.HumanoidRootPart.Anchored = false
                                                            Weld_2 = Instance.new("Weld")
                                                            Weld_2.Part0 = Model_2.HumanoidRootPart
                                                            Weld_2.Part1 = HeadCopy
                                                            C0_2 = Weld_2.C0
                                                            ReplicationOffset = Weapon_2.Config.ReplicationOffset
                                                            if not ReplicationOffset then
                                                                ReplicationOffset = CFrame.new()
                                                            end
                                                            Weld_2.C0 = C0_2 * ReplicationOffset
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
                                                            WorldModel_3 = j.WorldModel
                                                            WeldedShoulders = j.WorldModel.WeldedShoulders
                                                            if not WeldedShoulders then
                                                                WeldedShoulders = {}
                                                            end
                                                            WorldModel_3.WeldedShoulders = WeldedShoulders
                                                            Shoulders = j.Shoulders
                                                            v17 = nil
                                                            v18 = nil
                                                            for i72, i73 in Shoulders, v17, v18 do
                                                                if i73 and i73.Part1 then
                                                                    if not Weapon.Config.ArmIgnores then
                                                                        Name = i73.Part1.Name
                                                                        v21 = Model:FindFirstChild(Name)
                                                                        if v21 then
                                                                            v22 = false
                                                                            for i74, i75 in Model:GetChildren() do
                                                                                if i75:IsA("Weld")
                                                                                    and i75.Part0 == i73.Part1
                                                                                    and i75.Part1 == v21 then
                                                                                    v22 = true
                                                                                    break
                                                                                end
                                                                            end
                                                                            if not v22 then
                                                                                Weld = Instance.new("Weld")
                                                                                Weld.Part0 = i73.Part1
                                                                                Weld.Part1 = v21
                                                                                v24 = 3 < v21.Size.Y
                                                                                if not v24 then
                                                                                    v25 = CFrame.new()
                                                                                else
                                                                                    v25 = CFrame.new(0, -1, 0)
                                                                                    if not v25 then
                                                                                        v25 = CFrame.new()
                                                                                    end
                                                                                end
                                                                                Weld.C1 = v25
                                                                                Weld.Parent = Model
                                                                            end
                                                                            v23 = false
                                                                            WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                            v25 = nil
                                                                            v26 = nil
                                                                            for i76, i77 in WeldedShoulders_2, v25, v26 do
                                                                                if i77 == i73 then
                                                                                    v23 = true
                                                                                    break
                                                                                end
                                                                            end
                                                                            if not v23 then
                                                                                WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                                table.insert(WeldedShoulders_3, i73)
                                                                            end
                                                                        end
                                                                        i73.Enabled = false
                                                                    elseif not Weapon.Config.ArmIgnores[i73.Name] then
                                                                        Name = i73.Part1.Name
                                                                        v21 = Model:FindFirstChild(Name)
                                                                        if v21 then
                                                                            v22 = false
                                                                            for i78, i79 in Model:GetChildren() do
                                                                                if i79:IsA("Weld")
                                                                                    and i79.Part0 == i73.Part1
                                                                                    and i79.Part1 == v21 then
                                                                                    v22 = true
                                                                                    break
                                                                                end
                                                                            end
                                                                            if not v22 then
                                                                                Weld = Instance.new("Weld")
                                                                                Weld.Part0 = i73.Part1
                                                                                Weld.Part1 = v21
                                                                                v24 = 3 < v21.Size.Y
                                                                                if not v24 then
                                                                                    v25 = CFrame.new()
                                                                                else
                                                                                    v25 = CFrame.new(0, -1, 0)
                                                                                    if not v25 then
                                                                                        v25 = CFrame.new()
                                                                                    end
                                                                                end
                                                                                Weld.C1 = v25
                                                                                Weld.Parent = Model
                                                                            end
                                                                            v23 = false
                                                                            WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                            v25 = nil
                                                                            v26 = nil
                                                                            for i80, i81 in WeldedShoulders_2, v25, v26 do
                                                                                if i81 == i73 then
                                                                                    v23 = true
                                                                                    break
                                                                                end
                                                                            end
                                                                            if not v23 then
                                                                                WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                                table.insert(WeldedShoulders_3, i73)
                                                                            end
                                                                        end
                                                                        i73.Enabled = false
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            elseif SecondaryEquipped == ""
                                                and j.SecondaryWorldModel
                                                and j.SecondaryWorldModel.Weapon then
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
                                                    WorldModel_5 = j.WorldModel
                                                    WeldedShoulders_4 = j.WorldModel.WeldedShoulders
                                                    if not WeldedShoulders_4 then
                                                        WeldedShoulders_4 = {}
                                                    end
                                                    WorldModel_5.WeldedShoulders = WeldedShoulders_4
                                                    Shoulders_2 = j.Shoulders
                                                    v17 = nil
                                                    v18 = nil
                                                    for i82, i83 in Shoulders_2, v17, v18 do
                                                        if i83 and i83.Part1 then
                                                            if not Weapon_2.Config.ArmIgnores then
                                                                v21 = false
                                                                WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                                v23 = nil
                                                                v24 = nil
                                                                for i84, i85 in WeldedShoulders_5, v23, v24 do
                                                                    if i85 == i83 then
                                                                        v21 = true
                                                                        break
                                                                    end
                                                                end
                                                                if not v21 then
                                                                    Name_2 = i83.Part1.Name
                                                                    v22 = Model_2:FindFirstChild(Name_2)
                                                                    if v22 then
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = i83.Part1
                                                                        Weld_3.Part1 = v22
                                                                        v24 = 3 < v22.Size.Y
                                                                        if not v24 then
                                                                            v25 = CFrame.new()
                                                                        else
                                                                            v25 = CFrame.new(0, -1, 0)
                                                                            if not v25 then
                                                                                v25 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld_3.C1 = v25
                                                                        Weld_3.Parent = Model_2
                                                                        WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_6, i83)
                                                                    end
                                                                end
                                                                i83.Enabled = false
                                                            elseif not Weapon_2.Config.ArmIgnores[i83.Name] then
                                                                v21 = false
                                                                WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                                v23 = nil
                                                                v24 = nil
                                                                for i86, i87 in WeldedShoulders_5, v23, v24 do
                                                                    if i87 == i83 then
                                                                        v21 = true
                                                                        break
                                                                    end
                                                                end
                                                                if not v21 then
                                                                    Name_2 = i83.Part1.Name
                                                                    v22 = Model_2:FindFirstChild(Name_2)
                                                                    if v22 then
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = i83.Part1
                                                                        Weld_3.Part1 = v22
                                                                        v24 = 3 < v22.Size.Y
                                                                        if not v24 then
                                                                            v25 = CFrame.new()
                                                                        else
                                                                            v25 = CFrame.new(0, -1, 0)
                                                                            if not v25 then
                                                                                v25 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld_3.C1 = v25
                                                                        Weld_3.Parent = Model_2
                                                                        WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_6, i83)
                                                                    end
                                                                end
                                                                i83.Enabled = false
                                                            end
                                                        end
                                                    end
                                                    if not Weapon_2.HRPWeld then
                                                        Model_2.HumanoidRootPart.Anchored = false
                                                        Weld_2 = Instance.new("Weld")
                                                        Weld_2.Part0 = Model_2.HumanoidRootPart
                                                        Weld_2.Part1 = HeadCopy
                                                        C0_2 = Weld_2.C0
                                                        ReplicationOffset = Weapon_2.Config.ReplicationOffset
                                                        if not ReplicationOffset then
                                                            ReplicationOffset = CFrame.new()
                                                        end
                                                        Weld_2.C0 = C0_2 * ReplicationOffset
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
                                                        WorldModel_3 = j.WorldModel
                                                        WeldedShoulders = j.WorldModel.WeldedShoulders
                                                        if not WeldedShoulders then
                                                            WeldedShoulders = {}
                                                        end
                                                        WorldModel_3.WeldedShoulders = WeldedShoulders
                                                        Shoulders = j.Shoulders
                                                        v17 = nil
                                                        v18 = nil
                                                        for i88, i89 in Shoulders, v17, v18 do
                                                            if i89 and i89.Part1 then
                                                                if not Weapon.Config.ArmIgnores then
                                                                    Name = i89.Part1.Name
                                                                    v21 = Model:FindFirstChild(Name)
                                                                    if v21 then
                                                                        v22 = false
                                                                        for i90, i91 in Model:GetChildren() do
                                                                            if i91:IsA("Weld")
                                                                                and i91.Part0 == i89.Part1
                                                                                and i91.Part1 == v21 then
                                                                                v22 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v22 then
                                                                            Weld = Instance.new("Weld")
                                                                            Weld.Part0 = i89.Part1
                                                                            Weld.Part1 = v21
                                                                            v24 = 3 < v21.Size.Y
                                                                            if not v24 then
                                                                                v25 = CFrame.new()
                                                                            else
                                                                                v25 = CFrame.new(0, -1, 0)
                                                                                if not v25 then
                                                                                    v25 = CFrame.new()
                                                                                end
                                                                            end
                                                                            Weld.C1 = v25
                                                                            Weld.Parent = Model
                                                                        end
                                                                        v23 = false
                                                                        WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                        v25 = nil
                                                                        v26 = nil
                                                                        for i92, i93 in WeldedShoulders_2, v25, v26 do
                                                                            if i93 == i89 then
                                                                                v23 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v23 then
                                                                            WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_3, i89)
                                                                        end
                                                                    end
                                                                    i89.Enabled = false
                                                                elseif not Weapon.Config.ArmIgnores[i89.Name] then
                                                                    Name = i89.Part1.Name
                                                                    v21 = Model:FindFirstChild(Name)
                                                                    if v21 then
                                                                        v22 = false
                                                                        for i94, i95 in Model:GetChildren() do
                                                                            if i95:IsA("Weld")
                                                                                and i95.Part0 == i89.Part1
                                                                                and i95.Part1 == v21 then
                                                                                v22 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v22 then
                                                                            Weld = Instance.new("Weld")
                                                                            Weld.Part0 = i89.Part1
                                                                            Weld.Part1 = v21
                                                                            v24 = 3 < v21.Size.Y
                                                                            if not v24 then
                                                                                v25 = CFrame.new()
                                                                            else
                                                                                v25 = CFrame.new(0, -1, 0)
                                                                                if not v25 then
                                                                                    v25 = CFrame.new()
                                                                                end
                                                                            end
                                                                            Weld.C1 = v25
                                                                            Weld.Parent = Model
                                                                        end
                                                                        v23 = false
                                                                        WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                        v25 = nil
                                                                        v26 = nil
                                                                        for i96, i97 in WeldedShoulders_2, v25, v26 do
                                                                            if i97 == i89 then
                                                                                v23 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v23 then
                                                                            WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_3, i89)
                                                                        end
                                                                    end
                                                                    i89.Enabled = false
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        j._lastQuickSwapActive = QuickSwapActive_2
                                        if not Equipped_2 or Equipped_2 == "" then
                                            if j.WorldModel then
                                                DestroyModel(j)
                                            end
                                        elseif HeadCopy then
                                            if not j.WorldModel then
                                                j.WorldModel = {}
                                            end
                                            v12 = j._promotedToEquipped ~= nil
                                            Weapon_3 = not v12
                                            if Weapon_3 then
                                                Weapon_3 = false
                                                v14 = os.clock()
                                                if (j.WorldModel.RetryAfter or 0) <= v14 then
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
                                                WorldModel_7 = j.WorldModel
                                                WorldModel_7.Promise = GetWeapon(Equipped_2, nil, i)
                                                ;(j.WorldModel.Promise:andThen(function(p1) -- Line: 885
                                                    -- upvalues: j (val), WorldModel (val), WepId (val)
                                                    -- upvalues: ReplicatedStorage (upval), HeadCopy (val)
                                                    -- upvalues: QuickSwapActive (val), DualWieldActive (val)
                                                    -- upvalues: OffHandActive (val)
                                                    local Name, Weld_3, WeldedShoulders, WeldedShoulders_2, v1, v2, v3, v4, v5, v6, v7
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
                                                    else
                                                        v6 = not not (5 <= p1.Config.BulletsPerShot)
                                                    end
                                                    local IsMelee = p1.Config.IsMelee
                                                    if p1.Config.LODModel then
                                                        v7 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                                    elseif IsAPistol then
                                                        v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                                    elseif v6 then
                                                        v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                                    elseif not IsMelee then
                                                        v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                                    else
                                                        v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                                    end
                                                    local Weld = Instance.new("Weld")
                                                    Weld.Part0 = v7.Handle
                                                    Weld.Part1 = Model.KeyParts.Handle
                                                    local C0 = Weld.C0
                                                    local LODOffset = p1.Config.LODOffset
                                                    if not LODOffset then
                                                        LODOffset = CFrame.new()
                                                    end
                                                    Weld.C0 = C0 * LODOffset
                                                    Weld.Parent = v7
                                                    v7.Parent = nil
                                                    local Weld_2 = Instance.new("Weld")
                                                    Weld_2.Part0 = Model.HumanoidRootPart
                                                    Weld_2.Part1 = HeadCopy
                                                    local C0_2 = Weld_2.C0
                                                    local ReplicationOffset = p1.Config.ReplicationOffset
                                                    if not ReplicationOffset then
                                                        ReplicationOffset = CFrame.new()
                                                    end
                                                    Weld_2.C0 = C0_2 * ReplicationOffset
                                                    Weld_2.Parent = Model
                                                    p1.HRPWeldBaseC1 = Weld_2.C1
                                                    p1.HRPWeldBase = Weld_2.C0
                                                    p1.HRPWeldBaseC0 = Weld_2.C0
                                                    p1.HRPWeld = Weld_2
                                                    j.WorldModel.LowPolyModel = v7
                                                    j.WorldModel.HighPolyModel = Model.Weapon
                                                    j.WorldModel.Attachments = Model.Attachments
                                                    local Children = Model.KeyParts:GetChildren()
                                                    local v8 = j
                                                    local WorldModel_2 = v8.WorldModel

                                                    function WorldModel_2.HideKeyparts(p1) -- Line: 942
                                                        -- upvalues: Children (val), Model (val)
                                                        local KeyParts
                                                        local v1 = Children
                                                        local v2 = nil
                                                        local v3 = nil
                                                        local v4 = p1
                                                        for i, j in v1, v2, v3 do
                                                            if not j:IsA("BasePart") then
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
                                                    local v9 = nil
                                                    local v10 = nil
                                                    local v11 = p1
                                                    for i, j2 in Shoulders, v9, v10 do
                                                        if j2 and j2.Part1 then
                                                            if not v11.Config.ArmIgnores
                                                                or not v11.Config.ArmIgnores[j2.Name] then
                                                                Name = j2.Part1.Name
                                                                v1 = Model:FindFirstChild(Name)
                                                                if v1 then
                                                                    v2 = j2.Name == "Left Shoulder"
                                                                    if QuickSwapActive or DualWieldActive then
                                                                        if not v2 then
                                                                            Weld_3 = Instance.new("Weld")
                                                                            Weld_3.Part0 = j2.Part1
                                                                            Weld_3.Part1 = v1
                                                                            v3 = 3 < v1.Size.Y
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
                                                                            v5 = j
                                                                            WeldedShoulders_2 = v5.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_2, j2)
                                                                        elseif j2 then
                                                                            j2.Enabled = false
                                                                            v3 = j
                                                                            WeldedShoulders = v3.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders, j2)
                                                                        end
                                                                    elseif not OffHandActive or not v2 then
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = j2.Part1
                                                                        Weld_3.Part1 = v1
                                                                        v3 = 3 < v1.Size.Y
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
                                                                        v5 = j
                                                                        WeldedShoulders_2 = v5.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_2, j2)
                                                                    elseif j2 then
                                                                        j2.Enabled = false
                                                                        v3 = j
                                                                        WeldedShoulders = v3.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders, j2)
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                    j.WorldModel.Weapon = v11
                                                    v11:Equip()
                                                end)):catch(function(p1) -- Line: 1003 -- upvalues: j (val), WorldModel (val), WepId (val)
                                                    if j.WorldModel == WorldModel then
                                                        local v1 = warn
                                                        local v2 = WepId
                                                        v1("[ReplicationController] Failed to create world weapon " .. (tostring(v2)) .. ": " .. tostring(p1))
                                                        DestroyModel(j)
                                                        j.WorldModel.RetryAfter = os.clock() + 2
                                                    end
                                                end)
                                            elseif j.WorldModel and j.WorldModel.Weapon then
                                                Weapon_4 = j.WorldModel.Weapon
                                                if not PlayerState.Sprinting then
                                                    if Weapon_4.Sprinting then
                                                        Weapon_4.Sprinting = false
                                                        v15 = TweenService
                                                        HRPWeld_2 = Weapon_4.HRPWeld
                                                        v18 = TweenInfo.new(
                                                            0.5,
                                                            Enum.EasingStyle.Sine,
                                                            Enum.EasingDirection.Out
                                                        )
                                                        v19 = {C1 = Weapon_4.HRPWeldBaseC1}
                                                        v15:Create(HRPWeld_2, v18, v19):Play()
                                                    end
                                                elseif not Weapon_4.Sprinting then
                                                    Weapon_4.Sprinting = true
                                                    v15 = TweenService
                                                    HRPWeld = Weapon_4.HRPWeld
                                                    v18 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                                                    v19 = {
                                                        C1 = Weapon_4.HRPWeldBaseC1 * CFrame.Angles(-0.4, 0, 0),
                                                    }
                                                    v15:Create(HRPWeld, v18, v19):Play()
                                                end
                                                if j.Animator and Weapon_4.HRPWeldBaseC0 then
                                                    AimTwistAngle = j.Animator:GetAimTwistAngle()
                                                    Weapon_4.aimTwistAngle = AimTwistAngle
                                                    v16 = j.LookGoal or 0
                                                    v18 = v16 / 1.5707963267948966
                                                    v17 = math.clamp(v18, 0, 1)
                                                    if not PlayerState.Aiming then
                                                        v18 = 0.5
                                                    else
                                                        v18 = 0.8
                                                    end
                                                    v16 = v16 * v18
                                                    if not PlayerState.Proning then
                                                        v18 = 0
                                                    else
                                                        v18 = 1.5707963267948966
                                                    end
                                                    RecoilOffset = Weapon_4.RecoilOffset
                                                    if not RecoilOffset then
                                                        RecoilOffset = CFrame.identity
                                                    end
                                                    identity = CFrame.identity
                                                    Weapon_4.RecoilOffset = RecoilOffset:Lerp(identity, v34)
                                                    v24 = Weapon_4.HRPWeldBaseC0 * Weapon_4.RecoilOffset
                                                    if not PlayerState.Proning then
                                                        v25 = CFrame.new()
                                                    else
                                                        v25 = CFrame.new(0, -1, -1)
                                                        if not v25 then
                                                            v25 = CFrame.new()
                                                        end
                                                    end
                                                    v23 = v24 * v25
                                                    v24 = CFrame.new()
                                                    if PlayerState.Proning then
                                                        v26 = CFrame.new()
                                                    else
                                                        v26 = CFrame.new(0, 0, -0.5)
                                                        if not v26 then
                                                            v26 = CFrame.new()
                                                        end
                                                    end
                                                    v20 = v23 * v24:Lerp(v26, v17) * CFrame.Angles(-v18, 0, 0) * CFrame.Angles(-v16, 0, 0)
                                                    Angles_2 = CFrame.Angles
                                                    v22 = 0
                                                    if PlayerState.Proning then
                                                        v23 = 0
                                                    else
                                                        v23 = -AimTwistAngle
                                                        if not v23 then
                                                            v23 = 0
                                                        end
                                                    end
                                                    Weapon_4.HRPWeldBase = v20 * Angles_2(v22, v23, 0)
                                                    v19 = os.clock()
                                                    LastShotTime = Weapon_4.LastShotTime
                                                    if LastShotTime then
                                                        LastShotTime = v19 - Weapon_4.LastShotTime < 2
                                                    end
                                                    v21 = not PlayerState.Aiming and not PlayerState.Sprinting and not LastShotTime and not PlayerState.Proning and not PlayerState.QuickSwapActive and not PlayerState.DualWieldActive and not PlayerState.OffHandActive
                                                    Weapon_4.GunRestAlpha = Weapon_4.GunRestAlpha or 0
                                                    if not v21 then
                                                        v22 = 0
                                                    else
                                                        v22 = 1
                                                    end
                                                    Weapon_4.GunRestAlpha = Weapon_4.GunRestAlpha + (v22 - Weapon_4.GunRestAlpha) * v34 * 0.3
                                                    HRPWeldBase = Weapon_4.HRPWeldBase
                                                    v25 = CFrame.new()
                                                    v27 = u244
                                                    GunRestAlpha = Weapon_4.GunRestAlpha
                                                    Weapon_4.HRPWeldBase = HRPWeldBase * v25:Lerp(v27, GunRestAlpha)
                                                    HRPWeld_3 = Weapon_4.HRPWeld
                                                    C0_3 = Weapon_4.HRPWeld.C0
                                                    HRPWeldBase_2 = Weapon_4.HRPWeldBase
                                                    HRPWeld_3.C0 = C0_3:Lerp(HRPWeldBase_2, v34)
                                                end
                                                if PlayerState.Charging then
                                                    j.WorldModel.Weapon:Charging()
                                                end
                                                if PlayerState.Blocking then
                                                    j.WorldModel.Weapon:Blocking()
                                                elseif j.WorldModel.Weapon.Block then
                                                    j.WorldModel.Weapon:StopBlocking()
                                                end
                                                v18 = u146
                                                v17 = v18 * -0.3
                                                v14 = (math.exp(v17)) * 50 + 10
                                                if not v3 then
                                                    if 5 < v32 then
                                                        j.WorldModel.Weapon.LowPolyMode = true
                                                        if j.WorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                            j.WorldModel.Attachments.Parent = nil
                                                        end
                                                        j.WorldModel.HideKeyparts(true)
                                                        j.WorldModel.HighPolyModel.Parent = nil
                                                        j.WorldModel.LowPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                    end
                                                elseif v32 <= v14 then
                                                    j.WorldModel.Weapon.LowPolyMode = false
                                                    j.WorldModel.HighPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                    j.WorldModel.Attachments.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                    j.WorldModel.LowPolyModel.Parent = nil
                                                    j.WorldModel.HideKeyparts(false)
                                                elseif 5 < v32 then
                                                    j.WorldModel.Weapon.LowPolyMode = true
                                                    if j.WorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                        j.WorldModel.Attachments.Parent = nil
                                                    end
                                                    j.WorldModel.HideKeyparts(true)
                                                    j.WorldModel.HighPolyModel.Parent = nil
                                                    j.WorldModel.LowPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                end
                                            end
                                        elseif j.WorldModel then
                                            DestroyModel(j)
                                        end
                                        SecondaryEquipped_2 = PlayerState.SecondaryEquipped
                                        local SecondaryWepId = PlayerState.SecondaryWepId
                                        QuickSwapActive_3 = PlayerState.QuickSwapActive
                                        local DualWieldActive_2 = PlayerState.DualWieldActive
                                        v16 = SecondaryEquipped_2
                                        if v16 then
                                            v16 = false
                                            if SecondaryEquipped_2 ~= "" then
                                                v16 = SecondaryEquipped_2 ~= false
                                            end
                                        end
                                        if j.SecondaryWorldModel and j.SecondaryWorldModel.Weapon ~= nil then end
                                        if not v16 then
                                            if j.SecondaryWorldModel then
                                                DestroySecondaryModel(j)
                                            end
                                        elseif HeadCopy then
                                            if not j.SecondaryWorldModel then
                                                j.SecondaryWorldModel = {}
                                            end
                                            Weapon_5 = true
                                            if j.SecondaryWorldModel.Equipped == SecondaryEquipped_2 then
                                                if not j.SecondaryWorldModel.Weapon
                                                    or not j.SecondaryWorldModel.Weapon.WepId then
                                                    Weapon_5 = j.SecondaryWorldModel.Weapon
                                                    if Weapon_5 then
                                                        Weapon_5 = j.SecondaryWorldModel.Weapon.IsMirrored ~= DualWieldActive_2
                                                    end
                                                else
                                                    Weapon_5 = true
                                                    if j.SecondaryWorldModel.Weapon.WepId == SecondaryWepId then
                                                        Weapon_5 = j.SecondaryWorldModel.Weapon
                                                        if Weapon_5 then
                                                            Weapon_5 = j.SecondaryWorldModel.Weapon.IsMirrored ~= DualWieldActive_2
                                                        end
                                                    end
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
                                                j.SecondaryWorldModel.Promise:andThen(function(p1) -- Line: 1171
                                                    -- upvalues: j (val), SecondaryWorldModel (val)
                                                    -- upvalues: SecondaryWepId (val), DualWieldActive_2 (val)
                                                    -- upvalues: ReplicatedStorage (upval), HeadCopy (val)
                                                    -- upvalues: CreateMirroredArmModel (upval), i (val)
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
                                                    else
                                                        v2 = not not (5 <= p1.Config.BulletsPerShot)
                                                    end
                                                    local IsMelee = p1.Config.IsMelee
                                                    if p1.Config.LODModel then
                                                        v3 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                                    elseif IsAPistol then
                                                        v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                                    elseif v2 then
                                                        v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                                    elseif not IsMelee then
                                                        v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                                    else
                                                        v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                                    end
                                                    local Weld = Instance.new("Weld")
                                                    Weld.Part0 = v3.Handle
                                                    Weld.Part1 = Model.KeyParts.Handle
                                                    local C0 = Weld.C0
                                                    local LODOffset = p1.Config.LODOffset
                                                    if not LODOffset then
                                                        LODOffset = CFrame.new()
                                                    end
                                                    Weld.C0 = C0 * LODOffset
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
                                                    local v4 = j
                                                    local SecondaryWorldModel_2 = v4.SecondaryWorldModel

                                                    function SecondaryWorldModel_2.HideKeyparts(p1) -- Line: 1242
                                                        -- upvalues: Children (val), Model (val)
                                                        local KeyParts
                                                        local v1 = Children
                                                        local v2 = nil
                                                        local v3 = nil
                                                        local v4 = p1
                                                        for i, j in v1, v2, v3 do
                                                            if not j:IsA("BasePart") then
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
                                                    local v5 = {}
                                                    j.SecondaryWorldModel.WeldedShoulders = v5
                                                    j.SecondaryWorldModel.ArmModel = nil
                                                    if DualWieldActive_2 then
                                                        j.SecondaryWorldModel.ArmModel = CreateMirroredArmModel(Model, i)
                                                        v1 = p1
                                                    else
                                                        local Name, Weld_3, WeldedShoulders, v6, v7, v8, v9
                                                        local Shoulders = j.Shoulders
                                                        v5 = nil
                                                        local v10 = nil
                                                        v1 = p1
                                                        for i2, j2 in Shoulders, v5, v10 do
                                                            if j2 and j2.Name == "Left Shoulder" and j2.Part1 then
                                                                if not v1.Config.ArmIgnores then
                                                                    Name = j2.Part1.Name
                                                                    v6 = Model:FindFirstChild(Name)
                                                                    if not v6 then
                                                                        continue
                                                                    else
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = j2.Part1
                                                                        Weld_3.Part1 = v6
                                                                        v7 = 3 < v6.Size.Y
                                                                        if not v7 then
                                                                            v8 = CFrame.new()
                                                                        else
                                                                            v8 = CFrame.new(0, -1, 0)
                                                                            if not v8 then
                                                                                v8 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld_3.C1 = v8
                                                                        Weld_3.Parent = Model
                                                                        j2.Enabled = false
                                                                        v9 = j
                                                                        WeldedShoulders = v9.SecondaryWorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders, j2)
                                                                    end
                                                                elseif v1.Config.ArmIgnores[j2.Name] then
                                                                    continue
                                                                else
                                                                    Name = j2.Part1.Name
                                                                    v6 = Model:FindFirstChild(Name)
                                                                    if not v6 then
                                                                        continue
                                                                    else
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = j2.Part1
                                                                        Weld_3.Part1 = v6
                                                                        v7 = 3 < v6.Size.Y
                                                                        if not v7 then
                                                                            v8 = CFrame.new()
                                                                        else
                                                                            v8 = CFrame.new(0, -1, 0)
                                                                            if not v8 then
                                                                                v8 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld_3.C1 = v8
                                                                        Weld_3.Parent = Model
                                                                        j2.Enabled = false
                                                                        v9 = j
                                                                        WeldedShoulders = v9.SecondaryWorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders, j2)
                                                                    end
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
                                                    v20 = CFrame.new()
                                                    if DualWieldActive_2 then
                                                        v20 = u277
                                                    elseif QuickSwapActive_3 then
                                                        Weapon_6.QuickSwapAlpha = Weapon_6.QuickSwapAlpha or 0
                                                        Weapon_6.QuickSwapAlpha = Weapon_6.QuickSwapAlpha + (1 - Weapon_6.QuickSwapAlpha) * v34 * 0.5
                                                        v21 = CFrame.new()
                                                        v23 = u255
                                                        QuickSwapAlpha = Weapon_6.QuickSwapAlpha
                                                        v20 = v21:Lerp(v23, QuickSwapAlpha)
                                                    end
                                                    v21 = j.LookGoal or 0
                                                    v23 = v21 / 1.5707963267948966
                                                    v22 = math.clamp(v23, 0, 1)
                                                    if not PlayerState.Aiming then
                                                        v23 = 0.5
                                                    else
                                                        v23 = 0.8
                                                    end
                                                    v21 = v21 * v23
                                                    if not PlayerState.Proning then
                                                        v23 = 0
                                                    else
                                                        v23 = 1.5707963267948966
                                                    end
                                                    RecoilOffset_2 = Weapon_6.RecoilOffset
                                                    if not RecoilOffset_2 then
                                                        RecoilOffset_2 = CFrame.identity
                                                    end
                                                    identity_2 = CFrame.identity
                                                    Weapon_6.RecoilOffset = RecoilOffset_2:Lerp(identity_2, v34)
                                                    if not QuickSwapActive_3 then
                                                        v29 = Weapon_6.HRPWeldBaseC0 * v20
                                                        v28 = v29 * Weapon_6.RecoilOffset
                                                        if not PlayerState.Proning then
                                                            v29 = CFrame.new()
                                                        else
                                                            v29 = CFrame.new(0, -1, -1)
                                                            if not v29 then
                                                                v29 = CFrame.new()
                                                            end
                                                        end
                                                        v27 = v28 * v29
                                                        v28 = CFrame.new()
                                                        if PlayerState.Proning then
                                                            v30 = CFrame.new()
                                                        else
                                                            v30 = CFrame.new(0, 0, -0.5)
                                                            if not v30 then
                                                                v30 = CFrame.new()
                                                            end
                                                        end
                                                        Weapon_6.HRPWeldBase = v27 * v28:Lerp(v30, v22) * CFrame.Angles(-v23, 0, 0) * CFrame.Angles(-v21, 0, 0)
                                                    else
                                                        Weapon_6.HRPWeldBase = Weapon_6.HRPWeldBaseC0 * v20
                                                    end
                                                    if not Weapon_6.IsMirrored then
                                                        if Weapon_6.HRPWeld then
                                                            HRPWeld_5 = Weapon_6.HRPWeld
                                                            C0_4 = Weapon_6.HRPWeld.C0
                                                            HRPWeldBase_3 = Weapon_6.HRPWeldBase
                                                            HRPWeld_5.C0 = C0_4:Lerp(HRPWeldBase_3, v34)
                                                        end
                                                    elseif Weapon_6.HeadRef then
                                                        v25 = Weapon_6.HeadRef.CFrame * Weapon_6.HRPWeldBase
                                                        v26 = CFrame.fromMatrix(
                                                            v25.Position,
                                                            v25.XVector * -1,
                                                            v25.YVector,
                                                            v25.ZVector
                                                        )
                                                        Weapon_6.Viewmodel.Model.HumanoidRootPart.CFrame = v26
                                                    elseif Weapon_6.HRPWeld then
                                                        HRPWeld_5 = Weapon_6.HRPWeld
                                                        C0_4 = Weapon_6.HRPWeld.C0
                                                        HRPWeldBase_3 = Weapon_6.HRPWeldBase
                                                        HRPWeld_5.C0 = C0_4:Lerp(HRPWeldBase_3, v34)
                                                    end
                                                end
                                                v24 = u146
                                                v23 = v24 * -0.3
                                                v20 = (math.exp(v23)) * 50 + 10
                                                if not v3 then
                                                    if 5 < v32 then
                                                        j.SecondaryWorldModel.Weapon.LowPolyMode = true
                                                        if j.SecondaryWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                            j.SecondaryWorldModel.Attachments.Parent = nil
                                                        end
                                                        j.SecondaryWorldModel.HideKeyparts(true)
                                                        j.SecondaryWorldModel.HighPolyModel.Parent = nil
                                                        j.SecondaryWorldModel.LowPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                    end
                                                elseif v32 <= v20 then
                                                    j.SecondaryWorldModel.Weapon.LowPolyMode = false
                                                    j.SecondaryWorldModel.HighPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                    j.SecondaryWorldModel.Attachments.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                    j.SecondaryWorldModel.LowPolyModel.Parent = nil
                                                    j.SecondaryWorldModel.HideKeyparts(false)
                                                elseif 5 < v32 then
                                                    j.SecondaryWorldModel.Weapon.LowPolyMode = true
                                                    if j.SecondaryWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                        j.SecondaryWorldModel.Attachments.Parent = nil
                                                    end
                                                    j.SecondaryWorldModel.HideKeyparts(true)
                                                    j.SecondaryWorldModel.HighPolyModel.Parent = nil
                                                    j.SecondaryWorldModel.LowPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                end
                                            end
                                            if DualWieldActive_2 and j.WorldModel and j.WorldModel.Weapon then
                                                Weapon_7 = j.WorldModel.Weapon
                                                if Weapon_7.HRPWeldBaseC0 and Weapon_7.HRPWeldBase then
                                                    v20 = Weapon_7.HRPWeldBase * u266
                                                    HRPWeld_7 = Weapon_7.HRPWeld
                                                    HRPWeld_7.C0 = Weapon_7.HRPWeld.C0:Lerp(v20, v34)
                                                end
                                            end
                                        elseif j.SecondaryWorldModel then
                                            DestroySecondaryModel(j)
                                        end
                                        OffHandActive_2 = PlayerState.OffHandActive
                                        OffHandEquipped = PlayerState.OffHandEquipped
                                        local OffHandWepId = PlayerState.OffHandWepId
                                        v21 = OffHandEquipped
                                        if v21 then
                                            v21 = false
                                            if OffHandEquipped ~= "" then
                                                v21 = OffHandEquipped ~= false
                                            end
                                        end
                                        if not v21 then
                                            if j.OffHandWorldModel then
                                                DestroyOffHandModel(j)
                                            end
                                        elseif HeadCopy then
                                            if not j.OffHandWorldModel then
                                                j.OffHandWorldModel = {}
                                            end
                                            v22 = true
                                            if j.OffHandWorldModel.Equipped == OffHandEquipped then
                                                v22 = j.OffHandWorldModel.Weapon
                                                if v22 then
                                                    v22 = j.OffHandWorldModel.Weapon.WepId ~= OffHandWepId
                                                end
                                            end
                                            if v22 then
                                                if j.OffHandWorldModel and j.OffHandWorldModel.Weapon then
                                                    DestroyOffHandModel(j)
                                                    j.OffHandWorldModel = {}
                                                end
                                                j.OffHandWorldModel.Equipped = OffHandEquipped
                                                local OffHandWorldModel = j.OffHandWorldModel
                                                v24 = j.OffHandWorldModel
                                                v24.Promise = GetWeapon(OffHandEquipped, nil, i)
                                                j.OffHandWorldModel.Promise:andThen(function(p1) -- Line: 1416
                                                    -- upvalues: j (val), OffHandWorldModel (val), OffHandWepId (val)
                                                    -- upvalues: ReplicatedStorage (upval), HeadCopy (val)
                                                    local Model_2, Name, Weld_3, WeldedShoulders, v1, v2, v3, v4, v5
                                                    if j.OffHandWorldModel ~= OffHandWorldModel then
                                                        p1.Viewmodel:Destroy()
                                                        return
                                                    end
                                                    p1.WepId = OffHandWepId
                                                    p1.IsOffHand = true
                                                    local Model = p1.Viewmodel.Model
                                                    Model.HumanoidRootPart.Anchored = false
                                                    local IsAPistol = p1.Config.IsAPistol
                                                    local BulletsPerShot = p1.Config.BulletsPerShot
                                                    if BulletsPerShot then
                                                        BulletsPerShot = 5 <= p1.Config.BulletsPerShot
                                                    end
                                                    local IsMelee = p1.Config.IsMelee
                                                    if p1.Config.LODModel then
                                                        v5 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                                    elseif IsAPistol then
                                                        v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                                    elseif BulletsPerShot then
                                                        v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                                    elseif not IsMelee then
                                                        v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                                    else
                                                        v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                                    end
                                                    local Weld = Instance.new("Weld")
                                                    Weld.Part0 = v5.Handle
                                                    Weld.Part1 = Model.KeyParts.Handle
                                                    local C0 = Weld.C0
                                                    local LODOffset = p1.Config.LODOffset
                                                    if not LODOffset then
                                                        LODOffset = CFrame.new()
                                                    end
                                                    Weld.C0 = C0 * LODOffset
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
                                                    local v6 = j
                                                    local OffHandWorldModel_2 = v6.OffHandWorldModel

                                                    function OffHandWorldModel_2.HideKeyparts(p1) -- Line: 1471
                                                        -- upvalues: Children (val), Model (val)
                                                        local KeyParts
                                                        local v1 = Children
                                                        local v2 = nil
                                                        local v3 = nil
                                                        local v4 = p1
                                                        for i, j in v1, v2, v3 do
                                                            if not j:IsA("BasePart") then
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
                                                    local v7 = nil
                                                    local v8 = nil
                                                    local v9 = p1
                                                    for i, j2 in Shoulders, v7, v8 do
                                                        if j2 and j2.Name == "Left Shoulder" and j2.Part1 then
                                                            if v9.Config.ArmIgnores
                                                                and v9.Config.ArmIgnores[j2.Name] then
                                                                continue
                                                            end
                                                            Name = j2.Part1.Name
                                                            v1 = Model:FindFirstChild(Name)
                                                            if v1 then
                                                                if j.WorldModel
                                                                    and j.WorldModel.Weapon
                                                                    and j.WorldModel.Weapon.Viewmodel then
                                                                    Model_2 = j.WorldModel.Weapon.Viewmodel.Model
                                                                    if Model_2 then
                                                                        for k, n in Model_2:GetChildren() do
                                                                            if n:IsA("Weld")
                                                                                and n.Part0 == j2.Part1 then
                                                                                n:Destroy()
                                                                                break
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                                Weld_3 = Instance.new("Weld")
                                                                Weld_3.Part0 = j2.Part1
                                                                Weld_3.Part1 = v1
                                                                v2 = 3 < v1.Size.Y
                                                                if not v2 then
                                                                    v3 = CFrame.new()
                                                                else
                                                                    v3 = CFrame.new(0, -1, 0)
                                                                    if not v3 then
                                                                        v3 = CFrame.new()
                                                                    end
                                                                end
                                                                Weld_3.C1 = v3
                                                                Weld_3.Parent = Model
                                                                j2.Enabled = false
                                                                v4 = j
                                                                WeldedShoulders = v4.OffHandWorldModel.WeldedShoulders
                                                                table.insert(WeldedShoulders, j2)
                                                                break
                                                            end
                                                        end
                                                    end
                                                    j.OffHandWorldModel.Weapon = v9
                                                    v9:Equip()
                                                end)
                                            elseif j.OffHandWorldModel and j.OffHandWorldModel.Weapon then
                                                v23 = j.OffHandWorldModel.Weapon
                                                if v23.HRPWeldBaseC0 and v23.HRPWeld then
                                                    v23.HRPWeldBase = v23.HRPWeldBaseC0 * u288
                                                    v24 = v23.HRPWeld
                                                    v25 = v23.HRPWeld.C0
                                                    v27 = v23.HRPWeldBase
                                                    v24.C0 = v25:Lerp(v27, v34)
                                                end
                                                v28 = u146
                                                v27 = v28 * -0.3
                                                v24 = (math.exp(v27)) * 50 + 10
                                                if not v3 then
                                                    if 5 < v32 then
                                                        j.OffHandWorldModel.Weapon.LowPolyMode = true
                                                        if j.OffHandWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                            j.OffHandWorldModel.Attachments.Parent = nil
                                                        end
                                                        j.OffHandWorldModel.HideKeyparts(true)
                                                        j.OffHandWorldModel.HighPolyModel.Parent = nil
                                                        j.OffHandWorldModel.LowPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                    end
                                                elseif v32 <= v24 then
                                                    j.OffHandWorldModel.Weapon.LowPolyMode = false
                                                    j.OffHandWorldModel.HighPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                    j.OffHandWorldModel.Attachments.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                    j.OffHandWorldModel.LowPolyModel.Parent = nil
                                                    j.OffHandWorldModel.HideKeyparts(false)
                                                elseif 5 < v32 then
                                                    j.OffHandWorldModel.Weapon.LowPolyMode = true
                                                    if j.OffHandWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                        j.OffHandWorldModel.Attachments.Parent = nil
                                                    end
                                                    j.OffHandWorldModel.HideKeyparts(true)
                                                    j.OffHandWorldModel.HighPolyModel.Parent = nil
                                                    j.OffHandWorldModel.LowPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                end
                                            end
                                        elseif j.OffHandWorldModel then
                                            DestroyOffHandModel(j)
                                        end
                                    end
                                elseif not HRP then
                                    v5 = u144[i].YawGoal or 0
                                    v6 = u144[i].LookGoal or 0
                                    if u144[i].LookAttachment then
                                        LookAttachment_3 = u144[i].LookAttachment
                                        LookAttachment_3.CFrame = (CFrame.Angles(v6, v5, 0)) * CFrame.new(0, 0, -5)
                                        if j.Animator then
                                            Animator_3 = j.Animator
                                            WorldPosition = u144[i].LookAttachment.WorldPosition
                                            Animator_3:SetLookPoint(WorldPosition)
                                            j.Animator:SetYaw(v5)
                                        end
                                        v7 = u68
                                        v9 = u144[i].LookAttachment.WorldPosition - u144[i].Head.Position
                                        v7:UpdatePlayerLookDirection(v9, i)
                                        local HeadCopy = j.HeadCopy
                                        Equipped_2 = PlayerState.Equipped
                                        local WepId = PlayerState.WepId
                                        WorldModel_2 = j.WorldModel
                                        v11 = j._lastQuickSwapActive or false
                                        QuickSwapActive_2 = PlayerState.QuickSwapActive
                                        SecondaryEquipped = PlayerState.SecondaryEquipped
                                        if j._promotedToEquipped then
                                            v12 = false
                                            if Equipped_2 == j._promotedToEquipped
                                                or Equipped_2 ~= j._waitingForEquippedFrom
                                                or j._promotionTimestamp and 2 < os.clock() - j._promotionTimestamp then
                                                v12 = true
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
                                                        WorldModel_5 = j.WorldModel
                                                        WeldedShoulders_4 = j.WorldModel.WeldedShoulders
                                                        if not WeldedShoulders_4 then
                                                            WeldedShoulders_4 = {}
                                                        end
                                                        WorldModel_5.WeldedShoulders = WeldedShoulders_4
                                                        Shoulders_2 = j.Shoulders
                                                        v17 = nil
                                                        v18 = nil
                                                        for i98, i99 in Shoulders_2, v17, v18 do
                                                            if i99 and i99.Part1 then
                                                                if not Weapon_2.Config.ArmIgnores then
                                                                    v21 = false
                                                                    WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                                    v23 = nil
                                                                    v24 = nil
                                                                    for i100, i101 in WeldedShoulders_5, v23, v24 do
                                                                        if i101 == i99 then
                                                                            v21 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v21 then
                                                                        Name_2 = i99.Part1.Name
                                                                        v22 = Model_2:FindFirstChild(Name_2)
                                                                        if v22 then
                                                                            Weld_3 = Instance.new("Weld")
                                                                            Weld_3.Part0 = i99.Part1
                                                                            Weld_3.Part1 = v22
                                                                            v24 = 3 < v22.Size.Y
                                                                            if not v24 then
                                                                                v25 = CFrame.new()
                                                                            else
                                                                                v25 = CFrame.new(0, -1, 0)
                                                                                if not v25 then
                                                                                    v25 = CFrame.new()
                                                                                end
                                                                            end
                                                                            Weld_3.C1 = v25
                                                                            Weld_3.Parent = Model_2
                                                                            WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_6, i99)
                                                                        end
                                                                    end
                                                                    i99.Enabled = false
                                                                elseif not Weapon_2.Config.ArmIgnores[i99.Name] then
                                                                    v21 = false
                                                                    WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                                    v23 = nil
                                                                    v24 = nil
                                                                    for i102, i103 in WeldedShoulders_5, v23, v24 do
                                                                        if i103 == i99 then
                                                                            v21 = true
                                                                            break
                                                                        end
                                                                    end
                                                                    if not v21 then
                                                                        Name_2 = i99.Part1.Name
                                                                        v22 = Model_2:FindFirstChild(Name_2)
                                                                        if v22 then
                                                                            Weld_3 = Instance.new("Weld")
                                                                            Weld_3.Part0 = i99.Part1
                                                                            Weld_3.Part1 = v22
                                                                            v24 = 3 < v22.Size.Y
                                                                            if not v24 then
                                                                                v25 = CFrame.new()
                                                                            else
                                                                                v25 = CFrame.new(0, -1, 0)
                                                                                if not v25 then
                                                                                    v25 = CFrame.new()
                                                                                end
                                                                            end
                                                                            Weld_3.C1 = v25
                                                                            Weld_3.Parent = Model_2
                                                                            WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_6, i99)
                                                                        end
                                                                    end
                                                                    i99.Enabled = false
                                                                end
                                                            end
                                                        end
                                                        if not Weapon_2.HRPWeld then
                                                            Model_2.HumanoidRootPart.Anchored = false
                                                            Weld_2 = Instance.new("Weld")
                                                            Weld_2.Part0 = Model_2.HumanoidRootPart
                                                            Weld_2.Part1 = HeadCopy
                                                            C0_2 = Weld_2.C0
                                                            ReplicationOffset = Weapon_2.Config.ReplicationOffset
                                                            if not ReplicationOffset then
                                                                ReplicationOffset = CFrame.new()
                                                            end
                                                            Weld_2.C0 = C0_2 * ReplicationOffset
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
                                                            WorldModel_3 = j.WorldModel
                                                            WeldedShoulders = j.WorldModel.WeldedShoulders
                                                            if not WeldedShoulders then
                                                                WeldedShoulders = {}
                                                            end
                                                            WorldModel_3.WeldedShoulders = WeldedShoulders
                                                            Shoulders = j.Shoulders
                                                            v17 = nil
                                                            v18 = nil
                                                            for i104, i105 in Shoulders, v17, v18 do
                                                                if i105 and i105.Part1 then
                                                                    if not Weapon.Config.ArmIgnores then
                                                                        Name = i105.Part1.Name
                                                                        v21 = Model:FindFirstChild(Name)
                                                                        if v21 then
                                                                            v22 = false
                                                                            for i106, i107 in Model:GetChildren() do
                                                                                if i107:IsA("Weld")
                                                                                    and i107.Part0 == i105.Part1
                                                                                    and i107.Part1 == v21 then
                                                                                    v22 = true
                                                                                    break
                                                                                end
                                                                            end
                                                                            if not v22 then
                                                                                Weld = Instance.new("Weld")
                                                                                Weld.Part0 = i105.Part1
                                                                                Weld.Part1 = v21
                                                                                v24 = 3 < v21.Size.Y
                                                                                if not v24 then
                                                                                    v25 = CFrame.new()
                                                                                else
                                                                                    v25 = CFrame.new(0, -1, 0)
                                                                                    if not v25 then
                                                                                        v25 = CFrame.new()
                                                                                    end
                                                                                end
                                                                                Weld.C1 = v25
                                                                                Weld.Parent = Model
                                                                            end
                                                                            v23 = false
                                                                            WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                            v25 = nil
                                                                            v26 = nil
                                                                            for i108, i109 in WeldedShoulders_2, v25, v26 do
                                                                                if i109 == i105 then
                                                                                    v23 = true
                                                                                    break
                                                                                end
                                                                            end
                                                                            if not v23 then
                                                                                WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                                table.insert(WeldedShoulders_3, i105)
                                                                            end
                                                                        end
                                                                        i105.Enabled = false
                                                                    elseif not Weapon.Config.ArmIgnores[i105.Name] then
                                                                        Name = i105.Part1.Name
                                                                        v21 = Model:FindFirstChild(Name)
                                                                        if v21 then
                                                                            v22 = false
                                                                            for i110, i111 in Model:GetChildren() do
                                                                                if i111:IsA("Weld")
                                                                                    and i111.Part0 == i105.Part1
                                                                                    and i111.Part1 == v21 then
                                                                                    v22 = true
                                                                                    break
                                                                                end
                                                                            end
                                                                            if not v22 then
                                                                                Weld = Instance.new("Weld")
                                                                                Weld.Part0 = i105.Part1
                                                                                Weld.Part1 = v21
                                                                                v24 = 3 < v21.Size.Y
                                                                                if not v24 then
                                                                                    v25 = CFrame.new()
                                                                                else
                                                                                    v25 = CFrame.new(0, -1, 0)
                                                                                    if not v25 then
                                                                                        v25 = CFrame.new()
                                                                                    end
                                                                                end
                                                                                Weld.C1 = v25
                                                                                Weld.Parent = Model
                                                                            end
                                                                            v23 = false
                                                                            WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                            v25 = nil
                                                                            v26 = nil
                                                                            for i112, i113 in WeldedShoulders_2, v25, v26 do
                                                                                if i113 == i105 then
                                                                                    v23 = true
                                                                                    break
                                                                                end
                                                                            end
                                                                            if not v23 then
                                                                                WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                                table.insert(WeldedShoulders_3, i105)
                                                                            end
                                                                        end
                                                                        i105.Enabled = false
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            elseif SecondaryEquipped == ""
                                                and j.SecondaryWorldModel
                                                and j.SecondaryWorldModel.Weapon then
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
                                                    WorldModel_5 = j.WorldModel
                                                    WeldedShoulders_4 = j.WorldModel.WeldedShoulders
                                                    if not WeldedShoulders_4 then
                                                        WeldedShoulders_4 = {}
                                                    end
                                                    WorldModel_5.WeldedShoulders = WeldedShoulders_4
                                                    Shoulders_2 = j.Shoulders
                                                    v17 = nil
                                                    v18 = nil
                                                    for i114, i115 in Shoulders_2, v17, v18 do
                                                        if i115 and i115.Part1 then
                                                            if not Weapon_2.Config.ArmIgnores then
                                                                v21 = false
                                                                WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                                v23 = nil
                                                                v24 = nil
                                                                for i116, i117 in WeldedShoulders_5, v23, v24 do
                                                                    if i117 == i115 then
                                                                        v21 = true
                                                                        break
                                                                    end
                                                                end
                                                                if not v21 then
                                                                    Name_2 = i115.Part1.Name
                                                                    v22 = Model_2:FindFirstChild(Name_2)
                                                                    if v22 then
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = i115.Part1
                                                                        Weld_3.Part1 = v22
                                                                        v24 = 3 < v22.Size.Y
                                                                        if not v24 then
                                                                            v25 = CFrame.new()
                                                                        else
                                                                            v25 = CFrame.new(0, -1, 0)
                                                                            if not v25 then
                                                                                v25 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld_3.C1 = v25
                                                                        Weld_3.Parent = Model_2
                                                                        WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_6, i115)
                                                                    end
                                                                end
                                                                i115.Enabled = false
                                                            elseif not Weapon_2.Config.ArmIgnores[i115.Name] then
                                                                v21 = false
                                                                WeldedShoulders_5 = j.WorldModel.WeldedShoulders
                                                                v23 = nil
                                                                v24 = nil
                                                                for i118, i119 in WeldedShoulders_5, v23, v24 do
                                                                    if i119 == i115 then
                                                                        v21 = true
                                                                        break
                                                                    end
                                                                end
                                                                if not v21 then
                                                                    Name_2 = i115.Part1.Name
                                                                    v22 = Model_2:FindFirstChild(Name_2)
                                                                    if v22 then
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = i115.Part1
                                                                        Weld_3.Part1 = v22
                                                                        v24 = 3 < v22.Size.Y
                                                                        if not v24 then
                                                                            v25 = CFrame.new()
                                                                        else
                                                                            v25 = CFrame.new(0, -1, 0)
                                                                            if not v25 then
                                                                                v25 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld_3.C1 = v25
                                                                        Weld_3.Parent = Model_2
                                                                        WeldedShoulders_6 = j.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_6, i115)
                                                                    end
                                                                end
                                                                i115.Enabled = false
                                                            end
                                                        end
                                                    end
                                                    if not Weapon_2.HRPWeld then
                                                        Model_2.HumanoidRootPart.Anchored = false
                                                        Weld_2 = Instance.new("Weld")
                                                        Weld_2.Part0 = Model_2.HumanoidRootPart
                                                        Weld_2.Part1 = HeadCopy
                                                        C0_2 = Weld_2.C0
                                                        ReplicationOffset = Weapon_2.Config.ReplicationOffset
                                                        if not ReplicationOffset then
                                                            ReplicationOffset = CFrame.new()
                                                        end
                                                        Weld_2.C0 = C0_2 * ReplicationOffset
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
                                                        WorldModel_3 = j.WorldModel
                                                        WeldedShoulders = j.WorldModel.WeldedShoulders
                                                        if not WeldedShoulders then
                                                            WeldedShoulders = {}
                                                        end
                                                        WorldModel_3.WeldedShoulders = WeldedShoulders
                                                        Shoulders = j.Shoulders
                                                        v17 = nil
                                                        v18 = nil
                                                        for i120, i121 in Shoulders, v17, v18 do
                                                            if i121 and i121.Part1 then
                                                                if not Weapon.Config.ArmIgnores then
                                                                    Name = i121.Part1.Name
                                                                    v21 = Model:FindFirstChild(Name)
                                                                    if v21 then
                                                                        v22 = false
                                                                        for i122, i123 in Model:GetChildren() do
                                                                            if i123:IsA("Weld")
                                                                                and i123.Part0 == i121.Part1
                                                                                and i123.Part1 == v21 then
                                                                                v22 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v22 then
                                                                            Weld = Instance.new("Weld")
                                                                            Weld.Part0 = i121.Part1
                                                                            Weld.Part1 = v21
                                                                            v24 = 3 < v21.Size.Y
                                                                            if not v24 then
                                                                                v25 = CFrame.new()
                                                                            else
                                                                                v25 = CFrame.new(0, -1, 0)
                                                                                if not v25 then
                                                                                    v25 = CFrame.new()
                                                                                end
                                                                            end
                                                                            Weld.C1 = v25
                                                                            Weld.Parent = Model
                                                                        end
                                                                        v23 = false
                                                                        WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                        v25 = nil
                                                                        v26 = nil
                                                                        for i124, i125 in WeldedShoulders_2, v25, v26 do
                                                                            if i125 == i121 then
                                                                                v23 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v23 then
                                                                            WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_3, i121)
                                                                        end
                                                                    end
                                                                    i121.Enabled = false
                                                                elseif not Weapon.Config.ArmIgnores[i121.Name] then
                                                                    Name = i121.Part1.Name
                                                                    v21 = Model:FindFirstChild(Name)
                                                                    if v21 then
                                                                        v22 = false
                                                                        for i126, i127 in Model:GetChildren() do
                                                                            if i127:IsA("Weld")
                                                                                and i127.Part0 == i121.Part1
                                                                                and i127.Part1 == v21 then
                                                                                v22 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v22 then
                                                                            Weld = Instance.new("Weld")
                                                                            Weld.Part0 = i121.Part1
                                                                            Weld.Part1 = v21
                                                                            v24 = 3 < v21.Size.Y
                                                                            if not v24 then
                                                                                v25 = CFrame.new()
                                                                            else
                                                                                v25 = CFrame.new(0, -1, 0)
                                                                                if not v25 then
                                                                                    v25 = CFrame.new()
                                                                                end
                                                                            end
                                                                            Weld.C1 = v25
                                                                            Weld.Parent = Model
                                                                        end
                                                                        v23 = false
                                                                        WeldedShoulders_2 = j.WorldModel.WeldedShoulders
                                                                        v25 = nil
                                                                        v26 = nil
                                                                        for i128, i129 in WeldedShoulders_2, v25, v26 do
                                                                            if i129 == i121 then
                                                                                v23 = true
                                                                                break
                                                                            end
                                                                        end
                                                                        if not v23 then
                                                                            WeldedShoulders_3 = j.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_3, i121)
                                                                        end
                                                                    end
                                                                    i121.Enabled = false
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        j._lastQuickSwapActive = QuickSwapActive_2
                                        if not Equipped_2 or Equipped_2 == "" then
                                            if j.WorldModel then
                                                DestroyModel(j)
                                            end
                                        elseif HeadCopy then
                                            if not j.WorldModel then
                                                j.WorldModel = {}
                                            end
                                            v12 = j._promotedToEquipped ~= nil
                                            Weapon_3 = not v12
                                            if Weapon_3 then
                                                Weapon_3 = false
                                                v14 = os.clock()
                                                if (j.WorldModel.RetryAfter or 0) <= v14 then
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
                                                WorldModel_7 = j.WorldModel
                                                WorldModel_7.Promise = GetWeapon(Equipped_2, nil, i)
                                                ;(j.WorldModel.Promise:andThen(function(p1) -- Line: 885
                                                    -- upvalues: j (val), WorldModel (val), WepId (val)
                                                    -- upvalues: ReplicatedStorage (upval), HeadCopy (val)
                                                    -- upvalues: QuickSwapActive (val), DualWieldActive (val)
                                                    -- upvalues: OffHandActive (val)
                                                    local Name, Weld_3, WeldedShoulders, WeldedShoulders_2, v1, v2, v3, v4, v5, v6, v7
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
                                                    else
                                                        v6 = not not (5 <= p1.Config.BulletsPerShot)
                                                    end
                                                    local IsMelee = p1.Config.IsMelee
                                                    if p1.Config.LODModel then
                                                        v7 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                                    elseif IsAPistol then
                                                        v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                                    elseif v6 then
                                                        v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                                    elseif not IsMelee then
                                                        v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                                    else
                                                        v7 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                                    end
                                                    local Weld = Instance.new("Weld")
                                                    Weld.Part0 = v7.Handle
                                                    Weld.Part1 = Model.KeyParts.Handle
                                                    local C0 = Weld.C0
                                                    local LODOffset = p1.Config.LODOffset
                                                    if not LODOffset then
                                                        LODOffset = CFrame.new()
                                                    end
                                                    Weld.C0 = C0 * LODOffset
                                                    Weld.Parent = v7
                                                    v7.Parent = nil
                                                    local Weld_2 = Instance.new("Weld")
                                                    Weld_2.Part0 = Model.HumanoidRootPart
                                                    Weld_2.Part1 = HeadCopy
                                                    local C0_2 = Weld_2.C0
                                                    local ReplicationOffset = p1.Config.ReplicationOffset
                                                    if not ReplicationOffset then
                                                        ReplicationOffset = CFrame.new()
                                                    end
                                                    Weld_2.C0 = C0_2 * ReplicationOffset
                                                    Weld_2.Parent = Model
                                                    p1.HRPWeldBaseC1 = Weld_2.C1
                                                    p1.HRPWeldBase = Weld_2.C0
                                                    p1.HRPWeldBaseC0 = Weld_2.C0
                                                    p1.HRPWeld = Weld_2
                                                    j.WorldModel.LowPolyModel = v7
                                                    j.WorldModel.HighPolyModel = Model.Weapon
                                                    j.WorldModel.Attachments = Model.Attachments
                                                    local Children = Model.KeyParts:GetChildren()
                                                    local v8 = j
                                                    local WorldModel_2 = v8.WorldModel

                                                    function WorldModel_2.HideKeyparts(p1) -- Line: 942
                                                        -- upvalues: Children (val), Model (val)
                                                        local KeyParts
                                                        local v1 = Children
                                                        local v2 = nil
                                                        local v3 = nil
                                                        local v4 = p1
                                                        for i, j in v1, v2, v3 do
                                                            if not j:IsA("BasePart") then
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
                                                    local v9 = nil
                                                    local v10 = nil
                                                    local v11 = p1
                                                    for i, j2 in Shoulders, v9, v10 do
                                                        if j2 and j2.Part1 then
                                                            if not v11.Config.ArmIgnores
                                                                or not v11.Config.ArmIgnores[j2.Name] then
                                                                Name = j2.Part1.Name
                                                                v1 = Model:FindFirstChild(Name)
                                                                if v1 then
                                                                    v2 = j2.Name == "Left Shoulder"
                                                                    if QuickSwapActive or DualWieldActive then
                                                                        if not v2 then
                                                                            Weld_3 = Instance.new("Weld")
                                                                            Weld_3.Part0 = j2.Part1
                                                                            Weld_3.Part1 = v1
                                                                            v3 = 3 < v1.Size.Y
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
                                                                            v5 = j
                                                                            WeldedShoulders_2 = v5.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders_2, j2)
                                                                        elseif j2 then
                                                                            j2.Enabled = false
                                                                            v3 = j
                                                                            WeldedShoulders = v3.WorldModel.WeldedShoulders
                                                                            table.insert(WeldedShoulders, j2)
                                                                        end
                                                                    elseif not OffHandActive or not v2 then
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = j2.Part1
                                                                        Weld_3.Part1 = v1
                                                                        v3 = 3 < v1.Size.Y
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
                                                                        v5 = j
                                                                        WeldedShoulders_2 = v5.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders_2, j2)
                                                                    elseif j2 then
                                                                        j2.Enabled = false
                                                                        v3 = j
                                                                        WeldedShoulders = v3.WorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders, j2)
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                    j.WorldModel.Weapon = v11
                                                    v11:Equip()
                                                end)):catch(function(p1) -- Line: 1003 -- upvalues: j (val), WorldModel (val), WepId (val)
                                                    if j.WorldModel == WorldModel then
                                                        local v1 = warn
                                                        local v2 = WepId
                                                        v1("[ReplicationController] Failed to create world weapon " .. (tostring(v2)) .. ": " .. tostring(p1))
                                                        DestroyModel(j)
                                                        j.WorldModel.RetryAfter = os.clock() + 2
                                                    end
                                                end)
                                            elseif j.WorldModel and j.WorldModel.Weapon then
                                                Weapon_4 = j.WorldModel.Weapon
                                                if not PlayerState.Sprinting then
                                                    if Weapon_4.Sprinting then
                                                        Weapon_4.Sprinting = false
                                                        v15 = TweenService
                                                        HRPWeld_2 = Weapon_4.HRPWeld
                                                        v18 = TweenInfo.new(
                                                            0.5,
                                                            Enum.EasingStyle.Sine,
                                                            Enum.EasingDirection.Out
                                                        )
                                                        v19 = {C1 = Weapon_4.HRPWeldBaseC1}
                                                        v15:Create(HRPWeld_2, v18, v19):Play()
                                                    end
                                                elseif not Weapon_4.Sprinting then
                                                    Weapon_4.Sprinting = true
                                                    v15 = TweenService
                                                    HRPWeld = Weapon_4.HRPWeld
                                                    v18 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                                                    v19 = {
                                                        C1 = Weapon_4.HRPWeldBaseC1 * CFrame.Angles(-0.4, 0, 0),
                                                    }
                                                    v15:Create(HRPWeld, v18, v19):Play()
                                                end
                                                if j.Animator and Weapon_4.HRPWeldBaseC0 then
                                                    AimTwistAngle = j.Animator:GetAimTwistAngle()
                                                    Weapon_4.aimTwistAngle = AimTwistAngle
                                                    v16 = j.LookGoal or 0
                                                    v18 = v16 / 1.5707963267948966
                                                    v17 = math.clamp(v18, 0, 1)
                                                    if not PlayerState.Aiming then
                                                        v18 = 0.5
                                                    else
                                                        v18 = 0.8
                                                    end
                                                    v16 = v16 * v18
                                                    if not PlayerState.Proning then
                                                        v18 = 0
                                                    else
                                                        v18 = 1.5707963267948966
                                                    end
                                                    RecoilOffset = Weapon_4.RecoilOffset
                                                    if not RecoilOffset then
                                                        RecoilOffset = CFrame.identity
                                                    end
                                                    identity = CFrame.identity
                                                    Weapon_4.RecoilOffset = RecoilOffset:Lerp(identity, v34)
                                                    v24 = Weapon_4.HRPWeldBaseC0 * Weapon_4.RecoilOffset
                                                    if not PlayerState.Proning then
                                                        v25 = CFrame.new()
                                                    else
                                                        v25 = CFrame.new(0, -1, -1)
                                                        if not v25 then
                                                            v25 = CFrame.new()
                                                        end
                                                    end
                                                    v23 = v24 * v25
                                                    v24 = CFrame.new()
                                                    if PlayerState.Proning then
                                                        v26 = CFrame.new()
                                                    else
                                                        v26 = CFrame.new(0, 0, -0.5)
                                                        if not v26 then
                                                            v26 = CFrame.new()
                                                        end
                                                    end
                                                    v20 = v23 * v24:Lerp(v26, v17) * CFrame.Angles(-v18, 0, 0) * CFrame.Angles(-v16, 0, 0)
                                                    Angles_2 = CFrame.Angles
                                                    v22 = 0
                                                    if PlayerState.Proning then
                                                        v23 = 0
                                                    else
                                                        v23 = -AimTwistAngle
                                                        if not v23 then
                                                            v23 = 0
                                                        end
                                                    end
                                                    Weapon_4.HRPWeldBase = v20 * Angles_2(v22, v23, 0)
                                                    v19 = os.clock()
                                                    LastShotTime = Weapon_4.LastShotTime
                                                    if LastShotTime then
                                                        LastShotTime = v19 - Weapon_4.LastShotTime < 2
                                                    end
                                                    v21 = not PlayerState.Aiming and not PlayerState.Sprinting and not LastShotTime and not PlayerState.Proning and not PlayerState.QuickSwapActive and not PlayerState.DualWieldActive and not PlayerState.OffHandActive
                                                    Weapon_4.GunRestAlpha = Weapon_4.GunRestAlpha or 0
                                                    if not v21 then
                                                        v22 = 0
                                                    else
                                                        v22 = 1
                                                    end
                                                    Weapon_4.GunRestAlpha = Weapon_4.GunRestAlpha + (v22 - Weapon_4.GunRestAlpha) * v34 * 0.3
                                                    HRPWeldBase = Weapon_4.HRPWeldBase
                                                    v25 = CFrame.new()
                                                    v27 = u244
                                                    GunRestAlpha = Weapon_4.GunRestAlpha
                                                    Weapon_4.HRPWeldBase = HRPWeldBase * v25:Lerp(v27, GunRestAlpha)
                                                    HRPWeld_3 = Weapon_4.HRPWeld
                                                    C0_3 = Weapon_4.HRPWeld.C0
                                                    HRPWeldBase_2 = Weapon_4.HRPWeldBase
                                                    HRPWeld_3.C0 = C0_3:Lerp(HRPWeldBase_2, v34)
                                                end
                                                if PlayerState.Charging then
                                                    j.WorldModel.Weapon:Charging()
                                                end
                                                if PlayerState.Blocking then
                                                    j.WorldModel.Weapon:Blocking()
                                                elseif j.WorldModel.Weapon.Block then
                                                    j.WorldModel.Weapon:StopBlocking()
                                                end
                                                v18 = u146
                                                v17 = v18 * -0.3
                                                v14 = (math.exp(v17)) * 50 + 10
                                                if not v3 then
                                                    if 5 < v32 then
                                                        j.WorldModel.Weapon.LowPolyMode = true
                                                        if j.WorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                            j.WorldModel.Attachments.Parent = nil
                                                        end
                                                        j.WorldModel.HideKeyparts(true)
                                                        j.WorldModel.HighPolyModel.Parent = nil
                                                        j.WorldModel.LowPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                    end
                                                elseif v32 <= v14 then
                                                    j.WorldModel.Weapon.LowPolyMode = false
                                                    j.WorldModel.HighPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                    j.WorldModel.Attachments.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                    j.WorldModel.LowPolyModel.Parent = nil
                                                    j.WorldModel.HideKeyparts(false)
                                                elseif 5 < v32 then
                                                    j.WorldModel.Weapon.LowPolyMode = true
                                                    if j.WorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                        j.WorldModel.Attachments.Parent = nil
                                                    end
                                                    j.WorldModel.HideKeyparts(true)
                                                    j.WorldModel.HighPolyModel.Parent = nil
                                                    j.WorldModel.LowPolyModel.Parent = j.WorldModel.Weapon.Viewmodel.Model
                                                end
                                            end
                                        elseif j.WorldModel then
                                            DestroyModel(j)
                                        end
                                        SecondaryEquipped_2 = PlayerState.SecondaryEquipped
                                        local SecondaryWepId = PlayerState.SecondaryWepId
                                        QuickSwapActive_3 = PlayerState.QuickSwapActive
                                        local DualWieldActive_2 = PlayerState.DualWieldActive
                                        v16 = SecondaryEquipped_2
                                        if v16 then
                                            v16 = false
                                            if SecondaryEquipped_2 ~= "" then
                                                v16 = SecondaryEquipped_2 ~= false
                                            end
                                        end
                                        if j.SecondaryWorldModel and j.SecondaryWorldModel.Weapon ~= nil then end
                                        if not v16 then
                                            if j.SecondaryWorldModel then
                                                DestroySecondaryModel(j)
                                            end
                                        elseif HeadCopy then
                                            if not j.SecondaryWorldModel then
                                                j.SecondaryWorldModel = {}
                                            end
                                            Weapon_5 = true
                                            if j.SecondaryWorldModel.Equipped == SecondaryEquipped_2 then
                                                if not j.SecondaryWorldModel.Weapon
                                                    or not j.SecondaryWorldModel.Weapon.WepId then
                                                    Weapon_5 = j.SecondaryWorldModel.Weapon
                                                    if Weapon_5 then
                                                        Weapon_5 = j.SecondaryWorldModel.Weapon.IsMirrored ~= DualWieldActive_2
                                                    end
                                                else
                                                    Weapon_5 = true
                                                    if j.SecondaryWorldModel.Weapon.WepId == SecondaryWepId then
                                                        Weapon_5 = j.SecondaryWorldModel.Weapon
                                                        if Weapon_5 then
                                                            Weapon_5 = j.SecondaryWorldModel.Weapon.IsMirrored ~= DualWieldActive_2
                                                        end
                                                    end
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
                                                j.SecondaryWorldModel.Promise:andThen(function(p1) -- Line: 1171
                                                    -- upvalues: j (val), SecondaryWorldModel (val)
                                                    -- upvalues: SecondaryWepId (val), DualWieldActive_2 (val)
                                                    -- upvalues: ReplicatedStorage (upval), HeadCopy (val)
                                                    -- upvalues: CreateMirroredArmModel (upval), i (val)
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
                                                    else
                                                        v2 = not not (5 <= p1.Config.BulletsPerShot)
                                                    end
                                                    local IsMelee = p1.Config.IsMelee
                                                    if p1.Config.LODModel then
                                                        v3 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                                    elseif IsAPistol then
                                                        v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                                    elseif v2 then
                                                        v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                                    elseif not IsMelee then
                                                        v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                                    else
                                                        v3 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                                    end
                                                    local Weld = Instance.new("Weld")
                                                    Weld.Part0 = v3.Handle
                                                    Weld.Part1 = Model.KeyParts.Handle
                                                    local C0 = Weld.C0
                                                    local LODOffset = p1.Config.LODOffset
                                                    if not LODOffset then
                                                        LODOffset = CFrame.new()
                                                    end
                                                    Weld.C0 = C0 * LODOffset
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
                                                    local v4 = j
                                                    local SecondaryWorldModel_2 = v4.SecondaryWorldModel

                                                    function SecondaryWorldModel_2.HideKeyparts(p1) -- Line: 1242
                                                        -- upvalues: Children (val), Model (val)
                                                        local KeyParts
                                                        local v1 = Children
                                                        local v2 = nil
                                                        local v3 = nil
                                                        local v4 = p1
                                                        for i, j in v1, v2, v3 do
                                                            if not j:IsA("BasePart") then
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
                                                    local v5 = {}
                                                    j.SecondaryWorldModel.WeldedShoulders = v5
                                                    j.SecondaryWorldModel.ArmModel = nil
                                                    if DualWieldActive_2 then
                                                        j.SecondaryWorldModel.ArmModel = CreateMirroredArmModel(Model, i)
                                                        v1 = p1
                                                    else
                                                        local Name, Weld_3, WeldedShoulders, v6, v7, v8, v9
                                                        local Shoulders = j.Shoulders
                                                        v5 = nil
                                                        local v10 = nil
                                                        v1 = p1
                                                        for i2, j2 in Shoulders, v5, v10 do
                                                            if j2 and j2.Name == "Left Shoulder" and j2.Part1 then
                                                                if not v1.Config.ArmIgnores then
                                                                    Name = j2.Part1.Name
                                                                    v6 = Model:FindFirstChild(Name)
                                                                    if not v6 then
                                                                        continue
                                                                    else
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = j2.Part1
                                                                        Weld_3.Part1 = v6
                                                                        v7 = 3 < v6.Size.Y
                                                                        if not v7 then
                                                                            v8 = CFrame.new()
                                                                        else
                                                                            v8 = CFrame.new(0, -1, 0)
                                                                            if not v8 then
                                                                                v8 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld_3.C1 = v8
                                                                        Weld_3.Parent = Model
                                                                        j2.Enabled = false
                                                                        v9 = j
                                                                        WeldedShoulders = v9.SecondaryWorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders, j2)
                                                                    end
                                                                elseif v1.Config.ArmIgnores[j2.Name] then
                                                                    continue
                                                                else
                                                                    Name = j2.Part1.Name
                                                                    v6 = Model:FindFirstChild(Name)
                                                                    if not v6 then
                                                                        continue
                                                                    else
                                                                        Weld_3 = Instance.new("Weld")
                                                                        Weld_3.Part0 = j2.Part1
                                                                        Weld_3.Part1 = v6
                                                                        v7 = 3 < v6.Size.Y
                                                                        if not v7 then
                                                                            v8 = CFrame.new()
                                                                        else
                                                                            v8 = CFrame.new(0, -1, 0)
                                                                            if not v8 then
                                                                                v8 = CFrame.new()
                                                                            end
                                                                        end
                                                                        Weld_3.C1 = v8
                                                                        Weld_3.Parent = Model
                                                                        j2.Enabled = false
                                                                        v9 = j
                                                                        WeldedShoulders = v9.SecondaryWorldModel.WeldedShoulders
                                                                        table.insert(WeldedShoulders, j2)
                                                                    end
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
                                                    v20 = CFrame.new()
                                                    if DualWieldActive_2 then
                                                        v20 = u277
                                                    elseif QuickSwapActive_3 then
                                                        Weapon_6.QuickSwapAlpha = Weapon_6.QuickSwapAlpha or 0
                                                        Weapon_6.QuickSwapAlpha = Weapon_6.QuickSwapAlpha + (1 - Weapon_6.QuickSwapAlpha) * v34 * 0.5
                                                        v21 = CFrame.new()
                                                        v23 = u255
                                                        QuickSwapAlpha = Weapon_6.QuickSwapAlpha
                                                        v20 = v21:Lerp(v23, QuickSwapAlpha)
                                                    end
                                                    v21 = j.LookGoal or 0
                                                    v23 = v21 / 1.5707963267948966
                                                    v22 = math.clamp(v23, 0, 1)
                                                    if not PlayerState.Aiming then
                                                        v23 = 0.5
                                                    else
                                                        v23 = 0.8
                                                    end
                                                    v21 = v21 * v23
                                                    if not PlayerState.Proning then
                                                        v23 = 0
                                                    else
                                                        v23 = 1.5707963267948966
                                                    end
                                                    RecoilOffset_2 = Weapon_6.RecoilOffset
                                                    if not RecoilOffset_2 then
                                                        RecoilOffset_2 = CFrame.identity
                                                    end
                                                    identity_2 = CFrame.identity
                                                    Weapon_6.RecoilOffset = RecoilOffset_2:Lerp(identity_2, v34)
                                                    if not QuickSwapActive_3 then
                                                        v29 = Weapon_6.HRPWeldBaseC0 * v20
                                                        v28 = v29 * Weapon_6.RecoilOffset
                                                        if not PlayerState.Proning then
                                                            v29 = CFrame.new()
                                                        else
                                                            v29 = CFrame.new(0, -1, -1)
                                                            if not v29 then
                                                                v29 = CFrame.new()
                                                            end
                                                        end
                                                        v27 = v28 * v29
                                                        v28 = CFrame.new()
                                                        if PlayerState.Proning then
                                                            v30 = CFrame.new()
                                                        else
                                                            v30 = CFrame.new(0, 0, -0.5)
                                                            if not v30 then
                                                                v30 = CFrame.new()
                                                            end
                                                        end
                                                        Weapon_6.HRPWeldBase = v27 * v28:Lerp(v30, v22) * CFrame.Angles(-v23, 0, 0) * CFrame.Angles(-v21, 0, 0)
                                                    else
                                                        Weapon_6.HRPWeldBase = Weapon_6.HRPWeldBaseC0 * v20
                                                    end
                                                    if not Weapon_6.IsMirrored then
                                                        if Weapon_6.HRPWeld then
                                                            HRPWeld_5 = Weapon_6.HRPWeld
                                                            C0_4 = Weapon_6.HRPWeld.C0
                                                            HRPWeldBase_3 = Weapon_6.HRPWeldBase
                                                            HRPWeld_5.C0 = C0_4:Lerp(HRPWeldBase_3, v34)
                                                        end
                                                    elseif Weapon_6.HeadRef then
                                                        v25 = Weapon_6.HeadRef.CFrame * Weapon_6.HRPWeldBase
                                                        v26 = CFrame.fromMatrix(
                                                            v25.Position,
                                                            v25.XVector * -1,
                                                            v25.YVector,
                                                            v25.ZVector
                                                        )
                                                        Weapon_6.Viewmodel.Model.HumanoidRootPart.CFrame = v26
                                                    elseif Weapon_6.HRPWeld then
                                                        HRPWeld_5 = Weapon_6.HRPWeld
                                                        C0_4 = Weapon_6.HRPWeld.C0
                                                        HRPWeldBase_3 = Weapon_6.HRPWeldBase
                                                        HRPWeld_5.C0 = C0_4:Lerp(HRPWeldBase_3, v34)
                                                    end
                                                end
                                                v24 = u146
                                                v23 = v24 * -0.3
                                                v20 = (math.exp(v23)) * 50 + 10
                                                if not v3 then
                                                    if 5 < v32 then
                                                        j.SecondaryWorldModel.Weapon.LowPolyMode = true
                                                        if j.SecondaryWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                            j.SecondaryWorldModel.Attachments.Parent = nil
                                                        end
                                                        j.SecondaryWorldModel.HideKeyparts(true)
                                                        j.SecondaryWorldModel.HighPolyModel.Parent = nil
                                                        j.SecondaryWorldModel.LowPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                    end
                                                elseif v32 <= v20 then
                                                    j.SecondaryWorldModel.Weapon.LowPolyMode = false
                                                    j.SecondaryWorldModel.HighPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                    j.SecondaryWorldModel.Attachments.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                    j.SecondaryWorldModel.LowPolyModel.Parent = nil
                                                    j.SecondaryWorldModel.HideKeyparts(false)
                                                elseif 5 < v32 then
                                                    j.SecondaryWorldModel.Weapon.LowPolyMode = true
                                                    if j.SecondaryWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                        j.SecondaryWorldModel.Attachments.Parent = nil
                                                    end
                                                    j.SecondaryWorldModel.HideKeyparts(true)
                                                    j.SecondaryWorldModel.HighPolyModel.Parent = nil
                                                    j.SecondaryWorldModel.LowPolyModel.Parent = j.SecondaryWorldModel.Weapon.Viewmodel.Model
                                                end
                                            end
                                            if DualWieldActive_2 and j.WorldModel and j.WorldModel.Weapon then
                                                Weapon_7 = j.WorldModel.Weapon
                                                if Weapon_7.HRPWeldBaseC0 and Weapon_7.HRPWeldBase then
                                                    v20 = Weapon_7.HRPWeldBase * u266
                                                    HRPWeld_7 = Weapon_7.HRPWeld
                                                    HRPWeld_7.C0 = Weapon_7.HRPWeld.C0:Lerp(v20, v34)
                                                end
                                            end
                                        elseif j.SecondaryWorldModel then
                                            DestroySecondaryModel(j)
                                        end
                                        OffHandActive_2 = PlayerState.OffHandActive
                                        OffHandEquipped = PlayerState.OffHandEquipped
                                        local OffHandWepId = PlayerState.OffHandWepId
                                        v21 = OffHandEquipped
                                        if v21 then
                                            v21 = false
                                            if OffHandEquipped ~= "" then
                                                v21 = OffHandEquipped ~= false
                                            end
                                        end
                                        if not v21 then
                                            if j.OffHandWorldModel then
                                                DestroyOffHandModel(j)
                                            end
                                        elseif HeadCopy then
                                            if not j.OffHandWorldModel then
                                                j.OffHandWorldModel = {}
                                            end
                                            v22 = true
                                            if j.OffHandWorldModel.Equipped == OffHandEquipped then
                                                v22 = j.OffHandWorldModel.Weapon
                                                if v22 then
                                                    v22 = j.OffHandWorldModel.Weapon.WepId ~= OffHandWepId
                                                end
                                            end
                                            if v22 then
                                                if j.OffHandWorldModel and j.OffHandWorldModel.Weapon then
                                                    DestroyOffHandModel(j)
                                                    j.OffHandWorldModel = {}
                                                end
                                                j.OffHandWorldModel.Equipped = OffHandEquipped
                                                local OffHandWorldModel = j.OffHandWorldModel
                                                v24 = j.OffHandWorldModel
                                                v24.Promise = GetWeapon(OffHandEquipped, nil, i)
                                                j.OffHandWorldModel.Promise:andThen(function(p1) -- Line: 1416
                                                    -- upvalues: j (val), OffHandWorldModel (val), OffHandWepId (val)
                                                    -- upvalues: ReplicatedStorage (upval), HeadCopy (val)
                                                    local Model_2, Name, Weld_3, WeldedShoulders, v1, v2, v3, v4, v5
                                                    if j.OffHandWorldModel ~= OffHandWorldModel then
                                                        p1.Viewmodel:Destroy()
                                                        return
                                                    end
                                                    p1.WepId = OffHandWepId
                                                    p1.IsOffHand = true
                                                    local Model = p1.Viewmodel.Model
                                                    Model.HumanoidRootPart.Anchored = false
                                                    local IsAPistol = p1.Config.IsAPistol
                                                    local BulletsPerShot = p1.Config.BulletsPerShot
                                                    if BulletsPerShot then
                                                        BulletsPerShot = 5 <= p1.Config.BulletsPerShot
                                                    end
                                                    local IsMelee = p1.Config.IsMelee
                                                    if p1.Config.LODModel then
                                                        v5 = ReplicatedStorage.common.SharedResources.LOD[p1.Config.LODModel]:Clone()
                                                    elseif IsAPistol then
                                                        v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultPistol:Clone()
                                                    elseif BulletsPerShot then
                                                        v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultShotgun:Clone()
                                                    elseif not IsMelee then
                                                        v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultRifle:Clone()
                                                    else
                                                        v5 = ReplicatedStorage.common.SharedResources.LOD.DefaultKatana:Clone()
                                                    end
                                                    local Weld = Instance.new("Weld")
                                                    Weld.Part0 = v5.Handle
                                                    Weld.Part1 = Model.KeyParts.Handle
                                                    local C0 = Weld.C0
                                                    local LODOffset = p1.Config.LODOffset
                                                    if not LODOffset then
                                                        LODOffset = CFrame.new()
                                                    end
                                                    Weld.C0 = C0 * LODOffset
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
                                                    local v6 = j
                                                    local OffHandWorldModel_2 = v6.OffHandWorldModel

                                                    function OffHandWorldModel_2.HideKeyparts(p1) -- Line: 1471
                                                        -- upvalues: Children (val), Model (val)
                                                        local KeyParts
                                                        local v1 = Children
                                                        local v2 = nil
                                                        local v3 = nil
                                                        local v4 = p1
                                                        for i, j in v1, v2, v3 do
                                                            if not j:IsA("BasePart") then
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
                                                    local v7 = nil
                                                    local v8 = nil
                                                    local v9 = p1
                                                    for i, j2 in Shoulders, v7, v8 do
                                                        if j2 and j2.Name == "Left Shoulder" and j2.Part1 then
                                                            if v9.Config.ArmIgnores
                                                                and v9.Config.ArmIgnores[j2.Name] then
                                                                continue
                                                            end
                                                            Name = j2.Part1.Name
                                                            v1 = Model:FindFirstChild(Name)
                                                            if v1 then
                                                                if j.WorldModel
                                                                    and j.WorldModel.Weapon
                                                                    and j.WorldModel.Weapon.Viewmodel then
                                                                    Model_2 = j.WorldModel.Weapon.Viewmodel.Model
                                                                    if Model_2 then
                                                                        for k, n in Model_2:GetChildren() do
                                                                            if n:IsA("Weld")
                                                                                and n.Part0 == j2.Part1 then
                                                                                n:Destroy()
                                                                                break
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                                Weld_3 = Instance.new("Weld")
                                                                Weld_3.Part0 = j2.Part1
                                                                Weld_3.Part1 = v1
                                                                v2 = 3 < v1.Size.Y
                                                                if not v2 then
                                                                    v3 = CFrame.new()
                                                                else
                                                                    v3 = CFrame.new(0, -1, 0)
                                                                    if not v3 then
                                                                        v3 = CFrame.new()
                                                                    end
                                                                end
                                                                Weld_3.C1 = v3
                                                                Weld_3.Parent = Model
                                                                j2.Enabled = false
                                                                v4 = j
                                                                WeldedShoulders = v4.OffHandWorldModel.WeldedShoulders
                                                                table.insert(WeldedShoulders, j2)
                                                                break
                                                            end
                                                        end
                                                    end
                                                    j.OffHandWorldModel.Weapon = v9
                                                    v9:Equip()
                                                end)
                                            elseif j.OffHandWorldModel and j.OffHandWorldModel.Weapon then
                                                v23 = j.OffHandWorldModel.Weapon
                                                if v23.HRPWeldBaseC0 and v23.HRPWeld then
                                                    v23.HRPWeldBase = v23.HRPWeldBaseC0 * u288
                                                    v24 = v23.HRPWeld
                                                    v25 = v23.HRPWeld.C0
                                                    v27 = v23.HRPWeldBase
                                                    v24.C0 = v25:Lerp(v27, v34)
                                                end
                                                v28 = u146
                                                v27 = v28 * -0.3
                                                v24 = (math.exp(v27)) * 50 + 10
                                                if not v3 then
                                                    if 5 < v32 then
                                                        j.OffHandWorldModel.Weapon.LowPolyMode = true
                                                        if j.OffHandWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                            j.OffHandWorldModel.Attachments.Parent = nil
                                                        end
                                                        j.OffHandWorldModel.HideKeyparts(true)
                                                        j.OffHandWorldModel.HighPolyModel.Parent = nil
                                                        j.OffHandWorldModel.LowPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                    end
                                                elseif v32 <= v24 then
                                                    j.OffHandWorldModel.Weapon.LowPolyMode = false
                                                    j.OffHandWorldModel.HighPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                    j.OffHandWorldModel.Attachments.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                    j.OffHandWorldModel.LowPolyModel.Parent = nil
                                                    j.OffHandWorldModel.HideKeyparts(false)
                                                elseif 5 < v32 then
                                                    j.OffHandWorldModel.Weapon.LowPolyMode = true
                                                    if j.OffHandWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
                                                        j.OffHandWorldModel.Attachments.Parent = nil
                                                    end
                                                    j.OffHandWorldModel.HideKeyparts(true)
                                                    j.OffHandWorldModel.HighPolyModel.Parent = nil
                                                    j.OffHandWorldModel.LowPolyModel.Parent = j.OffHandWorldModel.Weapon.Viewmodel.Model
                                                end
                                            end
                                        elseif j.OffHandWorldModel then
                                            DestroyOffHandModel(j)
                                        end
                                    end
                                elseif not (100 < (CurrentCamera.CFrame.Position - HRP.Position).Magnitude)
                                    and j.LookAttachment then
                                    if not PlayerState.Proning then
                                        j.HeadCopy.CanCollide = false
                                        LookAttachment_2 = j.LookAttachment
                                        LookAttachment_2.WorldPosition = RaycastUtil.CastBaseRay().Position
                                    else
                                        j.HeadCopy.CanCollide = false
                                        LookAttachment = j.LookAttachment
                                        LookAttachment.WorldPosition = RaycastUtil.CastNoneRay().Position
                                    end
                                    u68:UpdatePlayerLookDirection(nil, i)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end,
    GetPlayerLookDirection = function(p1, p2) -- Line: 1575 -- upvalues: u144 (val)
        local v1 = u144[p2]
        if v1 and v1.LookAttachment and v1.Head then
            return (v1.LookAttachment.WorldPosition - v1.Head.Position).Unit
        end
        return nil
    end,
}

function GetWeapon(p1, p2, p3) -- Line: 1584 -- upvalues: Promise (val), WepConfig (val), GunID (val), u99 (val)
    local v1 = Promise
    return v1.new(function(p1_2) -- Line: 1585 -- upvalues: WepConfig (upval), p1 (val), p2 (val), GunID (upval), p3 (val), u99 (upval)
        local v1 = WepConfig
        local v2 = p1
        v1 = v1:StreamViewmodel(v2)
        v1:andThen(function(p1_3) -- Line: 1586 -- upvalues: p2 (upval), GunID (upval), p3 (upval), p1_2 (val), u99 (upval), p1 (upval)
            local v1 = p1_3:Clone()
            v1.HumanoidRootPart.Anchored = false
            local v2 = nil
            if p2 and p2 ~= "" then
                local v3 = GunID
                local v4 = p2
                local v5 = p3
                v2 = v3:RetrieveAttachmentData(v4, v5)
            end
            p1_2(u99.new(p1, v1, v2))
        end)
    end)
end

function DestroyModel(p1) -- Line: 1598
    if p1.WorldModel then
        local v1, v2
        local WorldModel = p1.WorldModel
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
            local WeldedShoulders = WorldModel.WeldedShoulders
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

function DestroySecondaryModel(p1) -- Line: 1631
    if p1.SecondaryWorldModel then
        if p1.SecondaryWorldModel.Promise then
            p1.SecondaryWorldModel.Promise:cancel()
        end
        if p1.SecondaryWorldModel.WeldedShoulders then
            local WeldedShoulders = p1.SecondaryWorldModel.WeldedShoulders
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

function DestroyOffHandModel(p1) -- Line: 1656
    if p1.OffHandWorldModel then
        local WeldedShoulders_5, v1, v2, v3
        if p1.OffHandWorldModel.Promise then
            p1.OffHandWorldModel.Promise:cancel()
        end
        if not p1.WorldModel then
            if not p1.OffHandWorldModel.WeldedShoulders then
                v1 = p1
            else
                WeldedShoulders_5 = p1.OffHandWorldModel.WeldedShoulders
                v2 = nil
                v3 = nil
                for i, j in WeldedShoulders_5, v2, v3 do
                    if j then
                        j.Enabled = true
                    end
                end
            end
        elseif not p1.WorldModel.Weapon then
            if not p1.OffHandWorldModel.WeldedShoulders then
                v1 = p1
            else
                WeldedShoulders_5 = p1.OffHandWorldModel.WeldedShoulders
                v2 = nil
                v3 = nil
                for k, n in WeldedShoulders_5, v2, v3 do
                    if n then
                        n.Enabled = true
                    end
                end
            end
        elseif p1.OffHandWorldModel.WeldedShoulders then
            local Name, Weld, WeldedShoulders_3, WeldedShoulders_4, v4, v5, v6, v7, v8, v9
            local Model = p1.WorldModel.Weapon.Viewmodel.Model
            local Weapon = p1.WorldModel.Weapon
            local WorldModel = p1.WorldModel
            local WeldedShoulders = p1.WorldModel.WeldedShoulders
            if not WeldedShoulders then
                WeldedShoulders = {}
            end
            WorldModel.WeldedShoulders = WeldedShoulders
            local WeldedShoulders_2 = p1.OffHandWorldModel.WeldedShoulders
            local v10 = nil
            local v11 = nil
            v1 = p1
            for i6, i7 in WeldedShoulders_2, v10, v11 do
                if i7 and i7.Part1 then
                    if not Weapon.Config.ArmIgnores then
                        Name = i7.Part1.Name
                        v8 = Model:FindFirstChild(Name)
                        if not v8 then
                            i7.Enabled = true
                        else
                            v9 = false
                            for i8, i9 in Model:GetChildren() do
                                if i9:IsA("Weld") and i9.Part0 == i7.Part1 and i9.Part1 == v8 then
                                    v9 = true
                                    break
                                end
                            end
                            if not v9 then
                                Weld = Instance.new("Weld")
                                Weld.Part0 = i7.Part1
                                Weld.Part1 = v8
                                v5 = 3 < v8.Size.Y
                                if not v5 then
                                    v6 = CFrame.new()
                                else
                                    v6 = CFrame.new(0, -1, 0)
                                    if not v6 then
                                        v6 = CFrame.new()
                                    end
                                end
                                Weld.C1 = v6
                                Weld.Parent = Model
                            end
                            v4 = false
                            WeldedShoulders_3 = v1.WorldModel.WeldedShoulders
                            v6 = nil
                            v7 = nil
                            for i10, i11 in WeldedShoulders_3, v6, v7 do
                                if i11 == i7 then
                                    v4 = true
                                    break
                                end
                            end
                            if not v4 then
                                WeldedShoulders_4 = v1.WorldModel.WeldedShoulders
                                table.insert(WeldedShoulders_4, i7)
                            end
                        end
                        i7.Enabled = false
                    elseif not Weapon.Config.ArmIgnores[i7.Name] then
                        Name = i7.Part1.Name
                        v8 = Model:FindFirstChild(Name)
                        if not v8 then
                            i7.Enabled = true
                        else
                            v9 = false
                            for i12, i13 in Model:GetChildren() do
                                if i13:IsA("Weld") and i13.Part0 == i7.Part1 and i13.Part1 == v8 then
                                    v9 = true
                                    break
                                end
                            end
                            if not v9 then
                                Weld = Instance.new("Weld")
                                Weld.Part0 = i7.Part1
                                Weld.Part1 = v8
                                v5 = 3 < v8.Size.Y
                                if not v5 then
                                    v6 = CFrame.new()
                                else
                                    v6 = CFrame.new(0, -1, 0)
                                    if not v6 then
                                        v6 = CFrame.new()
                                    end
                                end
                                Weld.C1 = v6
                                Weld.Parent = Model
                            end
                            v4 = false
                            WeldedShoulders_3 = v1.WorldModel.WeldedShoulders
                            v6 = nil
                            v7 = nil
                            for i14, i15 in WeldedShoulders_3, v6, v7 do
                                if i15 == i7 then
                                    v4 = true
                                    break
                                end
                            end
                            if not v4 then
                                WeldedShoulders_4 = v1.WorldModel.WeldedShoulders
                                table.insert(WeldedShoulders_4, i7)
                            end
                        end
                        i7.Enabled = false
                    else
                        i7.Enabled = true
                    end
                end
            end
        elseif not p1.OffHandWorldModel.WeldedShoulders then
            v1 = p1
        else
            WeldedShoulders_5 = p1.OffHandWorldModel.WeldedShoulders
            v2 = nil
            v3 = nil
            for m, i5 in WeldedShoulders_5, v2, v3 do
                if i5 then
                    i5.Enabled = true
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

return v2