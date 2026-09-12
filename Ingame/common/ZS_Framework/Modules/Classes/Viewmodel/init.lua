local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CurrentCamera = workspace.CurrentCamera
local common = ReplicatedStorage.common
local VModels = ReplicatedStorage.common.SharedResources.VModels
local Ignore = workspace.Ignore
local ViewmodelUtils = script.ViewmodelUtils
local Utils = script.Parent.Parent.Utils
local Controllers = script.Parent.Parent.Controllers
local Shared = script.Parent.Parent.Shared
local Resources = script.Resources
local FakeArmUtil = require(ViewmodelUtils.FakeArmUtil)
local ArmModelUtil = require(ViewmodelUtils.ArmModelUtil)
local GunMovementUtil = require(ViewmodelUtils.GunMovementUtil)
local PointRotationUtil = require(ViewmodelUtils.PointRotationUtil)
local RecoilUtil = require(ViewmodelUtils.RecoilUtil)
local HolographicEffect = require(ViewmodelUtils.HolographicEffect)
local GripBlenderEffect = require(ViewmodelUtils.GripBlenderEffect)
local ScopeHideEffect = require(ViewmodelUtils.ScopeHideEffect)
local BobbingUtil = require(Utils.BobbingUtil)
local SpringUtil = require(Utils.SpringUtil)
local LocalPlayerController = require(Controllers.LocalPlayerController)
local SharedSprings = require(Shared.SharedSprings)
local Promise = require(common.Promise)
local Janitor = require(common.Janitor)
local CameraController = require(Controllers.CameraController)
local WepConfig = require(common.WepConfig)
local RaycastUtil = require(Utils.RaycastUtil)
local CursorRecoilUtil = require(Utils.CursorRecoilUtil)
local AttachmentSystem = require(ReplicatedStorage.common.SharedResources.Attachments.AttachmentSystem)
local DamageFalloffUtil = require(ReplicatedStorage.common.NPCs_Shared.Utils.DamageFalloffUtil)
local u107 = require("@game/ReplicatedStorage/common/Settings")
local peek = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local u120 = require("@game/ReplicatedStorage/common/Signal")
local ShellSystem = require(ViewmodelUtils.ShellSystem)
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local SkillTreeData = require(ReplicatedStorage.common.skillTree.SkillTreeData)
local AnimatedTextures = require(common.AnimatedTextures)
local u136 = 0
local u138 = CFrame.new()
local u141 = SpringUtil.new(0)
u141.Target = 0
u141.Speed = 13
u141.Damper = 0.9
local u147 = SpringUtil.new(0)
u147.Target = 0
u147.Speed = 18
u147.Damper = 1
local v1 = SpringUtil.new(0)
v1.Target = 0
v1.Speed = 19
v1.Damper = 0.7
local u159 = SpringUtil.new(0)
u159.Target = 0
u159.Speed = 20
u159.Damper = 0.7
local u165 = SpringUtil.new(0)
u165.Target = 0
u165.Speed = 20
u165.Damper = 1
local u171 = SpringUtil.new(0)
u171.Target = 0
u171.Speed = 20
u171.Damper = 1
local Value = Enum.RenderPriority.Last.Value
local new = CFrame.new
local Angles = CFrame.Angles
Vector2.new(0.5, 0.5)
local u183 = {}
u183.__index = u183

function u183.new(p1) -- Line: 119 -- upvalues: u183 (val), u136 (ref), Janitor (val), u120 (val), SpringUtil (val)
    local v1 = {}
    local v2 = u183
    setmetatable(v1, v2)
    v1.Weapon = p1
    v1.Config = p1.Config
    v1.Offsets = {}
    v1.TotalOffset = CFrame.new()
    v1.ImpulseCF = CFrame.new()
    u136 = u136 + 1
    v1.Name = "VM_" .. p1.Name .. "_" .. u136
    v1.Enabled = false
    v1.Animations = {}
    v1.Janitor = Janitor.new()
    v1.ConfigLoaded = u120.new()
    v1.ManagedByManager = false
    v1.ManagerState = "Full"
    v1.ManagerGrantedArms = {Right = true, Left = true}
    v1.ArmOffsets = {Right = CFrame.new(), Left = CFrame.new()}
    v1.ArmOffsetTargets = {Right = CFrame.new(), Left = CFrame.new()}
    v1.ArmOffsetSpeed = 12
    v1.ViewmodelBaseOffset = CFrame.new()
    v1.ViewmodelBaseOffsetTarget = CFrame.new()
    v1.PrevArmControlled = {Right = true, Left = true}
    v1.ForceOneHanded = false
    v1.ForceLoweredPosition = false
    v1.DedicatedArms = nil
    v1.RightArmOnly = false
    v1.LeftArmOnly = p1.IsDualWieldLeft or false
    v1.IsMirrored = p1.IsDualWieldLeft or false
    v1.IsDualWieldRight = p1.IsDualWieldRight or false
    v1.UseArmModels = p1.UseArmModels or false
    v1.LoadingFrame = SpringUtil.new(0)
    v1.LoadingFrame.Target = 0
    v1.LoadingFrame.Speed = 19
    v1.LoadingFrame.Damper = 0.7
    v1.EquipSpring = SpringUtil.new(0)
    v1.EquipSpring.Target = 0
    v1.EquipSpring.Speed = 12
    v1.EquipSpring.Damper = 0.8
    ;(loadViewmodelPromise(v1)):catch(function(p1_2) -- Line: 191 -- upvalues: p1 (val)
        warn("[Viewmodel] Failed to load viewmodel for weapon " .. p1.Name .. ": " .. tostring(p1_2))
    end)
    return v1
end

function u183.SetEnabled(p1, p2) -- Line: 203
    -- upvalues: Fusion (val), SkillTreeData (val), RecoilUtil (val), BobbingUtil (val), u147 (val), SpringUtil (val)
    -- upvalues: new (val), ShellSystem (val), RunService (val), Value (val), PointRotationUtil (val)
    -- upvalues: GunMovementUtil (val), u141 (val), LocalPlayerController (val), SharedSprings (val), peek (val)
    -- upvalues: u107 (val), u138 (ref), Angles (val), u159 (val), u165 (val), CurrentCamera (val)
    -- upvalues: CameraController (val), CursorRecoilUtil (val), RaycastUtil (val), u171 (val), HolographicEffect (val)
    -- upvalues: ScopeHideEffect (val), FakeArmUtil (val), GripBlenderEffect (val), TweenService (val)
    -- upvalues: AnimatedTextures (val), ArmModelUtil (val)
    local v1
    if p1.Enabled == p2 then
        return
    end
    p1.Enabled = p2
    if not p2 then
        p1.EquipSpring.Target = 1.5
        p1.EquipSpring.Speed = 12 * (p1.Weapon.Config.HolsterSpeed or 1)
        ShellSystem.UsingViewmodelStep = false
        if not p1.UseArmModels then
            v1 = FakeArmUtil
            local Model_2 = p1.Model
            v1:Hide(Model_2)
        else
            v1 = ArmModelUtil
            local Model = p1.Model
            v1:DetachArms(Model)
        end
        if p1.Model then
            p1.Model.Parent = nil
        end
        v1 = RunService
        local Name_2 = p1.Name
        v1:UnbindFromRenderStep(Name_2)
        CameraController:SetCameraBone(nil, nil)
        if p1.HRPADSAttachment then
            p1.HRPADSAttachment:Destroy()
            p1.HRPADSAttachment = nil
        end
        return
    end
    p1.LoadingFrame.Position = 1
    p1.LoadingFrame.Target = 1
    p1.EquipSpring.Position = 1
    p1.EquipSpring.Target = 0
    p1.EquipSpring.Speed = 12 * (p1.Weapon.Config.DrawSpeed or 1)
    v1 = Fusion.peek(SkillTreeData.SwapSpeedMult)
    p1.EquipSpring.Speed = p1.EquipSpring.Speed * v1
    p1.RecoilInstance = RecoilUtil.getOrCreate(p1.Weapon)
    if not p1.LeftArmOnly and not p1.IsMirrored then
        RecoilUtil.CurrentWeapon = p1.Weapon
        BobbingUtil.CurrentWeapon = p1.Weapon
    end
    local u41 = p1.Weapon.Config.ADSSpeed or 1
    u147.Speed = 18 * u41
    if p1.Aimpart then
        p1.HRPADSAttachment = Instance.new("Attachment")
        p1.HRPADSAttachment.Parent = p1.PrimaryPart
        if p1._idleAimRelCF then
            local HRPADSAttachment = p1.HRPADSAttachment
            HRPADSAttachment.WorldCFrame = p1.PrimaryPart.CFrame * p1._idleAimRelCF:Inverse()
        end
        p1.VMAnimInfluenceSpring = SpringUtil.new(0)
        p1.VMAnimInfluenceSpring.Target = 0
        p1.VMAnimInfluenceSpring.Speed = 10
        p1.VMAnimInfluenceSpring.Damper = 0.8
    end
    if p1.ViewmodelReady then
        p1:Loaded()
    end
    local v2 = new
    local u77 = v2()
    ShellSystem.UsingViewmodelStep = true
    local v3 = RunService
    local Name = p1.Name
    local v4 = Value
    v3:BindToRenderStep(Name, v4, function(p1_2) -- Line: 249
        -- upvalues: PointRotationUtil (upval), p1 (val), u41 (ref), u147 (upval), GunMovementUtil (upval), u141 (upval)
        -- upvalues: LocalPlayerController (upval), SharedSprings (upval), new (upval), peek (upval), u107 (upval)
        -- upvalues: BobbingUtil (upval), u138 (upval), Angles (upval), u159 (upval), u165 (upval)
        -- upvalues: CurrentCamera (upval), CameraController (upval), RecoilUtil (upval), CursorRecoilUtil (upval)
        -- upvalues: SpringUtil (upval), RaycastUtil (upval), u171 (upval), HolographicEffect (upval)
        -- upvalues: ScopeHideEffect (upval), FakeArmUtil (upval), GripBlenderEffect (upval), Fusion (upval)
        -- upvalues: SkillTreeData (upval), TweenService (upval), ShellSystem (upval), u77 (ref)
        -- upvalues: AnimatedTextures (upval)
        local v1, v2, v3, v4
        PointRotationUtil.SetActiveViewmodel(p1.Weapon)
        u41 = p1.Weapon.Config.ADSSpeed or 1
        u147.Speed = 18 * u41
        local Config = p1.Weapon.Config
        local IsDualWieldRight = p1.IsDualWieldRight
        if not IsDualWieldRight then
            IsDualWieldRight = p1.IsMirrored
        end
        local Aimpart = p1.Aimpart
        if Aimpart then
            Aimpart = not Config.AimingDisabled
        end
        local v5 = Aimpart and not IsDualWieldRight
        if not Aimpart or p1.Weapon.Aiming or not p1.Weapon.SecondaryAttackDown then
            if p1.Weapon.Aiming then
                if not p1.Weapon.SecondaryAttackDown or not p1.Weapon.IsEquipped then
                    p1.Weapon.Aiming = false
                    if Config.CustomAiming then
                        Config.CustomAiming(p1.Model, false)
                    end
                end
            end
        elseif p1.Weapon.IsEquipped then
            p1:StopAnimation("Inspect")
            p1.Weapon.Aiming = true
            if Config.CustomAiming then
                Config.CustomAiming(p1.Model, true)
            end
        elseif p1.Weapon.Aiming then
            if not p1.Weapon.SecondaryAttackDown or not p1.Weapon.IsEquipped then
                p1.Weapon.Aiming = false
                if Config.CustomAiming then
                    Config.CustomAiming(p1.Model, false)
                end
            end
        end
        local v6 = GunMovementUtil
        local v7 = p1
        local Aiming = v7.Weapon.Aiming
        v6, v3 = v6:Update(p1_2, Aiming)
        if not p1.RecoilInstance then
            v4 = CFrame.new()
        else
            v4 = p1
            local RecoilInstance = v4.RecoilInstance
            v1 = u147
            v2 = u141
            v4 = RecoilInstance:Update(p1_2, v1, v2)
            if not v4 then
                v4 = CFrame.new()
            end
        end
        p1:UpdatePhysics()
        if p1.ViewmodelReady
            or not p1.ViewmodelLoaded
            or not p1.Model
            or not p1.Animations
            or not p1.Animations.Idle
            or not (0 < p1.Animations.Idle.Length) then
            p1.LoadingFrame.Target = 0
        else
            p1.ViewmodelReady = true
            p1:Loaded()
        end
        if p1.Model and p1.ViewmodelReady then
            local Position_2, Position_4, PrimaryPart_3, hrp, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31
            if LocalPlayerController.ThirdPerson then
                hrp = 0.05 < SharedSprings.TPSpring.Position
            else
                hrp = LocalPlayerController.hrp
                if hrp then
                    hrp = 0.05 < SharedSprings.TPSpring.Position
                end
            end
            if p1.VMAnimInfluenceSpring then
                if not p1.Weapon.Reloading then
                    p1.VMAnimInfluenceSpring.Target = 0
                else
                    p1.VMAnimInfluenceSpring.Target = Config.ReloadADSInfluence or 0.15
                end
            end
            if not v5 then
                v31 = new()
            else
                local Attribute, CFrame_3
                if not p1.HRPADSAttachment or not p1.VMAnimInfluenceSpring then
                    CFrame_3 = p1.Aimpart.CFrame
                else
                    v2 = p1
                    local CFrame_2 = v2.Aimpart.CFrame
                    v10 = p1
                    local WorldCFrame = v10.HRPADSAttachment.WorldCFrame
                    v11 = p1
                    local Position = v11.VMAnimInfluenceSpring.Position
                    CFrame_3 = CFrame_2:Lerp(WorldCFrame, Position)
                end
                if p1.Aimpart ~= p1.DefaultAimpart then
                    Attribute = new()
                else
                    Attribute = p1.Model:GetAttribute("SkinAimPartOffset")
                    if not Attribute then
                        Attribute = new()
                        if not Attribute then
                            Attribute = new()
                        end
                    end
                end
                local AimOffset = Config.AimOffset
                if not AimOffset then
                    AimOffset = new()
                end
                v9 = CFrame_3 * AimOffset * Attribute
                v11 = p1
                local CFrame_4 = v11.PrimaryPart.CFrame
                v31 = v9:toObjectSpace(CFrame_4)
            end
            if hrp then
                v31 = new()
            end
            if not p1.ForceLoweredPosition then
                v1 = u147
                if not p1.Weapon.Aiming then
                    v2 = 0
                elseif not Config.DisableADSReload then
                    v2 = 1
                elseif not Config.DisableADSReload or p1.Weapon.Reloading then
                    v2 = 0
                else
                    v2 = 1
                end
                v1.Target = v2
            end
            local Weapon_2 = p1.Weapon
            if not (1 <= u147.Target) then
                v2 = 0
            else
                v2 = u147.Position / u147.Target
                if not v2 then
                    v2 = 0
                end
            end
            Weapon_2.ADSStrength = v2
            local GripOffset = Config.GripOffset
            if not Config.LeftArmGrip or not GripOffset then
                v1 = new()
            else
                v11 = new
                v11 = v11()
                v12 = p1
                local ADSStrength = v12.Weapon.ADSStrength
                v1 = GripOffset:Lerp(v11, ADSStrength)
            end
            v10 = p1_2 * 10
            v9 = math.clamp(v10, 0.01, 1)
            v10 = p1
            v11 = p1
            local ImpulseCF = v11.ImpulseCF
            local v32 = CFrame.new()
            v10.ImpulseCF = ImpulseCF:Lerp(v32, v9)
            local DynamicFOVOffsetConstant = Config.DynamicFOVOffsetConstant
            v11 = Config.AimDynamicFOVOffsetConstant or DynamicFOVOffsetConstant
            v12 = CFrame.new()
            v32 = CFrame.new()
            if DynamicFOVOffsetConstant then
                v16 = peek
                v17 = u107
                v16 = v16(v17.Graphics.BaseFOV)
                v15 = v16 * 0.5
                v14 = math.rad(v15)
                v13 = math.sin(v14) + -0.573576436351046
                v12 = CFrame.new(0, 0, v13 * DynamicFOVOffsetConstant)
                v32 = CFrame.new(0, 0, v13 * v11)
            end
            if not hrp then
                Position_2 = u147.Position
            else
                Position_2 = 0
            end
            v17 = (v12:Lerp(v32, Position_2)) * BobbingUtil.gunBobCF * v6
            v14 = v17 * u138 * v4 * p1.TotalOffset
            v13 = v14 * p1.ImpulseCF * v1
            local v33 = CFrame.new()
            if p1.StartingTransform and p1.CameraBoneMotor6D then
                local Position_3
                v14 = p1.StartingTransform * p1.CameraBoneMotor6D.Transform:inverse()
                if Config.UseAltCameraReload then
                    _, _, v17 = (v14 - v14.Position):ToOrientation()
                    v14 = Angles(0, 0, v17 * 0.05)
                end
                if p1.LeftArmOnly then
                    Position_3 = p1.EquipSpring.Position
                    if not Position_3 then
                        Position_3 = SharedSprings.EquipSpring.Position
                    end
                elseif not p1.IsMirrored then
                    Position_3 = SharedSprings.EquipSpring.Position
                else
                    Position_3 = p1.EquipSpring.Position
                    if not Position_3 then
                        Position_3 = SharedSprings.EquipSpring.Position
                    end
                end
                v18 = CFrame.new()
                v33 = v14:Lerp(v18, Position_3)
            end
            v17 = v31 * BobbingUtil.gunBobCF * v6 * u138 * v4 * v33
            v16 = v17 * p1.ImpulseCF
            if not hrp then
                Position_4 = u147.Position
            else
                Position_4 = 0
            end
            v13 = v13:Lerp(v16, Position_4)
            v14 = u159
            v15 = Lerp
            v16 = u159
            local Target = v16.Target
            local v34 = p1_2 * 10 * u41
            v14.Target = v15(Target, 0, (math.clamp(v34, 0.0001, 1)))
            v14 = u165
            v15 = Lerp
            v16 = u165
            local Target_2 = v16.Target
            v34 = p1_2 * 10 * u41
            v14.Target = v15(Target_2, 0, (math.clamp(v34, 0.0001, 1)))
            local CFrame_5 = CurrentCamera.CFrame
            if hrp
                and LocalPlayerController.hrp
                and LocalPlayerController.hrp.Parent
                and LocalPlayerController.humanoid.Humanoid
                and 0 < LocalPlayerController.humanoid.Humanoid.Health then
                local Parent = LocalPlayerController.hrp.Parent
                local HEADCOPY = Parent:FindFirstChild("HEADCOPY")
                if not HEADCOPY or not HEADCOPY:IsA("BasePart") then
                    HEADCOPY = Parent:FindFirstChild("Head")
                end
                if not HEADCOPY or not HEADCOPY:IsA("BasePart") then
                    HEADCOPY = LocalPlayerController.hrp
                end
                local CFrame_6 = HEADCOPY.CFrame
                local CFrame_7 = LocalPlayerController.hrp.CFrame
                local Position_5 = u147.Position
                if not LocalPlayerController.Animator then
                    CFrame_5 = CFrame_6
                else
                    local AimTwistAngle
                    local Proning = LocalPlayerController.States.Proning
                    local Y = CameraController.Y
                    if not Proning then
                        v20 = 0
                    else
                        v20 = 1.5707963267948966
                    end
                    v22 = -Y / 1.5707963267948966
                    v21 = math.clamp(v22, 0, 1)
                    v23 = Y / 1.5707963267948966
                    v22 = math.clamp(v23, 0, 1)
                    if Proning then
                        CFrame_6 = CFrame_6 * new(0, -1, 0.8)
                        CFrame_7 = CFrame_7 * new(0, -1, 0.8)
                    end
                    if not Proning then
                        AimTwistAngle = LocalPlayerController.Animator:GetAimTwistAngle()
                    else
                        AimTwistAngle = 0
                    end
                    v17 = CFrame_6 * Angles(v20, 0, 0) * Angles(0, AimTwistAngle, 0) * Angles(Y * 0.5, 0, 0)
                    local PitchRecoil = RecoilUtil:GetPitchRecoil()
                    v27 = CFrame_7 * new(0, 1.5, 0)
                    local v35 = Angles
                    v28 = Y + PitchRecoil * 2
                    v26 = v27 * v35(v28, 0, 0)
                    v27 = new()
                    if Proning then
                        v28 = new()
                    else
                        v28 = new(0, 0.5, -1.5)
                        if not v28 then
                            v28 = new()
                        end
                    end
                    v25 = v26 * v27:Lerp(v28, v21)
                    v26 = new()
                    if Proning then
                        v35 = new()
                    else
                        v35 = new(0, 1, 1.5)
                        if not v35 then
                            v35 = new()
                        end
                    end
                    v26 = v26:Lerp(v35, v22)
                    v18 = v25 * v26
                    CFrame_5 = v17:Lerp(v18, Position_5)
                end
            end
            if p1.ManagerState == "Lowered" or p1.ManagerState == "Hidden" then
                v15 = p1
                PrimaryPart_3 = v15.PrimaryPart
                PrimaryPart_3.CFrame = CFrame_5 * p1.ViewmodelBaseOffset * BobbingUtil.gunBobCF * v6 * p1.TotalOffset * p1.ImpulseCF
            elseif not p1.ForceLoweredPosition then
                if not (0 < u147.Target) then
                    v15 = 1
                else
                    v15 = 0
                end
                v16 = p1.LoadingFrame.Position * v15
                v17 = u159.Position * v15
                v18 = u165.Position * v15
                v34 = p1
                local PrimaryPart_2 = v34.PrimaryPart
                v22 = CFrame_5 * p1.ViewmodelBaseOffset
                v23 = new
                v23 = v23()
                v25 = (new(0, 0, -0.5)) * Angles(-0.2617993877991494, 0, 0.2617993877991494)
                v21 = v22 * v23:Lerp(v25, v17)
                v22 = new
                v22 = v22()
                v24 = (new(0, 0, -0.5)) * Angles(0, 0, -0.2617993877991494)
                v20 = v21 * v22:Lerp(v24, v18)
                v21 = new
                v21 = v21()
                v23 = new(0, 0, 1)
                PrimaryPart_2.CFrame = v20 * v21:Lerp(v23, v16) * v13
            else
                v15 = p1
                PrimaryPart_3 = v15.PrimaryPart
                PrimaryPart_3.CFrame = CFrame_5 * p1.ViewmodelBaseOffset * BobbingUtil.gunBobCF * v6 * p1.TotalOffset * p1.ImpulseCF
            end
            if p1.IsMirrored then
                local CFrame_8 = p1.PrimaryPart.CFrame
                v15 = CFrame.fromMatrix(CFrame_8.Position, CFrame_8.XVector * -1, CFrame_8.YVector, CFrame_8.ZVector)
                p1.PrimaryPart.CFrame = v15
            end
            if not p1.ForceLoweredPosition then
                PointRotationUtil.Update(p1_2, p1.Model, p1.Weapon.Aiming, u147, CFrame_5, v32, p1.Weapon)
            end
            local crosshairRecoil = CursorRecoilUtil.crosshairRecoil
            if p1.Weapon.Aiming and 0.0001 < crosshairRecoil.Magnitude and p1.Aimpart then
                v16 = CFrame.new(Vector3.new(0, 0, 1), crosshairRecoil * Vector3.new(1, 1, 1))
                v17 = v16 - v16.Position
                local CFrame_9 = p1.Aimpart.CFrame
                v19 = p1
                local CFrame_10 = v19.PrimaryPart.CFrame
                v34 = CFrame_9:ToObjectSpace(CFrame_10)
                v18 = CFrame_9 * v17
                p1.PrimaryPart.CFrame = v18:ToWorldSpace(v34)
            end
            if Config.Lasers then
                local LookVector, Position_7, Position_8, Position_9
                local Lasers = Config.Lasers
                v17 = nil
                v18 = nil
                v8 = p1_2
                for i, j in Lasers, v17, v18 do
                    v19 = j[1]
                    v20 = j[2]
                    if not j[3] then
                        j[3] = (SpringUtil.new(0))
                        j[3].Target = 0
                        j[3].Speed = 20
                        j[3].Damper = 1
                    end
                    v21 = j[3]
                    Position_7 = RaycastUtil.CustomRayDirection(v19.CFrame.Position, -v19.CFrame.RightVector.Unit * 100).Position
                    v19.End.WorldCFrame = new(Position_7)
                    LookVector = CFrame_5.LookVector
                    v24 = -v19.CFrame.RightVector
                    v25 = LookVector:Dot(v24)
                    v26 = 1 - math.abs(v25)
                    if 0.0005 < v26 then
                        v26 = 1
                    end
                    if hrp then
                        u171.Target = 1 - v26
                    else
                        u171.Target = 0
                    end
                    v20.BillboardGui.Enabled = true
                    v28 = RaycastUtil
                    v28 = v28.CastBaseRay()
                    Position_8 = v28.Position
                    v29 = u171
                    Position_9 = v29.Position
                    v20.Position = Position_7:Lerp(Position_8, Position_9)
                end
            end
            local Lense = Config.Lense
            if Lense and p1.Reticle then
                HolographicEffect.UpdateReticle(Lense, p1, CFrame_5)
            end
            local Shadow = Config.Shadow
            if Shadow and p1.ShadowRing then
                HolographicEffect.UpdateShadow(Shadow, p1, CFrame_5)
            end
            if Config.HideScopeModel then
                ScopeHideEffect.Update(p1, Config.HideScopeModel, u147)
            end
            local DedicatedArms = p1.DedicatedArms
            if not DedicatedArms then
                DedicatedArms = FakeArmUtil.Arms
            end
            v34 = new()
            local v36 = FakeArmUtil
            v20 = p1
            local Model = v20.Model
            v36 = v36:OwnsArm(Model, "Left")
            v19 = FakeArmUtil
            v21 = p1
            local Model_2 = v21.Model
            v19 = v19:OwnsArm(Model_2, "Right")
            if DedicatedArms and v36 then
                if not Config.LeftArmGrip then
                    DedicatedArms.LeftWeld.C0 = new()
                else
                    v34 = GripBlenderEffect(DedicatedArms, p1.Weapon)
                end
            end
            if v36 then
                if not p1.Weapon.Config.ArmIgnores then
                    v20 = false
                else
                    v20 = not not p1.Weapon.Config.ArmIgnores["Left Arm"]
                end
                if LocalPlayerController.States.IsDowned and not Fusion.peek(SkillTreeData.HasLastStand) then
                    v20 = true
                end
                if not p1.ManagerGrantedArms.Left or p1.ForceOneHanded then
                    v20 = true
                end
                if DedicatedArms then
                    local CFrame_14
                    local Left = p1.PrevArmControlled.Left
                    v22 = not v20
                    if not Left then
                        if Left or not v22 then
                            DedicatedArms.LeftWeld.Enabled = not v20
                            DedicatedArms.LeftShoulder.Enabled = v20
                        else
                            CFrame_14 = DedicatedArms.Left.CFrame
                            v25 = DedicatedArms.LeftWeld.Part0.CFrame:Inverse() * CFrame_14
                            DedicatedArms.LeftWeld.C0 = v25
                            DedicatedArms.LeftWeld.Enabled = true
                            DedicatedArms.LeftShoulder.Enabled = false
                        end
                    elseif not v22 then
                        local CFrame_12 = DedicatedArms.Left.CFrame
                        local CFrame_13 = DedicatedArms.LeftShoulder.Part0.CFrame
                        local C1 = DedicatedArms.LeftShoulder.C1
                        v26 = CFrame_13:Inverse() * CFrame_12 * C1
                        DedicatedArms.LeftShoulder.C0 = v26
                        DedicatedArms.LeftShoulder.Enabled = true
                        DedicatedArms.LeftWeld.Enabled = false
                        v27 = TweenService
                        local LeftShoulder_3 = DedicatedArms.LeftShoulder
                        v29 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        v30 = {C0 = DedicatedArms.LeftShoulderC0}
                        v27:Create(LeftShoulder_3, v29, v30):Play()
                    elseif Left or not v22 then
                        DedicatedArms.LeftWeld.Enabled = not v20
                        DedicatedArms.LeftShoulder.Enabled = v20
                    else
                        CFrame_14 = DedicatedArms.Left.CFrame
                        v25 = DedicatedArms.LeftWeld.Part0.CFrame:Inverse() * CFrame_14
                        DedicatedArms.LeftWeld.C0 = v25
                        DedicatedArms.LeftWeld.Enabled = true
                        DedicatedArms.LeftShoulder.Enabled = false
                    end
                    p1.PrevArmControlled.Left = v22
                end
            end
            if v19 then
                if not p1.Weapon.Config.ArmIgnores then
                    v20 = false
                else
                    v20 = not not p1.Weapon.Config.ArmIgnores["Right Arm"]
                end
                if not p1.ManagerGrantedArms.Right then
                    v20 = true
                end
                if DedicatedArms then
                    local CFrame_17
                    local Right = p1.PrevArmControlled.Right
                    v22 = not v20
                    if not Right then
                        if Right or not v22 then
                            DedicatedArms.RightWeld.Enabled = not v20
                            DedicatedArms.RightShoulder.Enabled = v20
                        else
                            CFrame_17 = DedicatedArms.Right.CFrame
                            v25 = DedicatedArms.RightWeld.Part0.CFrame:Inverse() * CFrame_17
                            DedicatedArms.RightWeld.C0 = v25
                            DedicatedArms.RightWeld.Enabled = true
                            DedicatedArms.RightShoulder.Enabled = false
                        end
                    elseif not v22 then
                        local CFrame_15 = DedicatedArms.Right.CFrame
                        local CFrame_16 = DedicatedArms.RightShoulder.Part0.CFrame
                        local C1_2 = DedicatedArms.RightShoulder.C1
                        v26 = CFrame_16:Inverse() * CFrame_15 * C1_2
                        DedicatedArms.RightShoulder.C0 = v26
                        DedicatedArms.RightShoulder.Enabled = true
                        DedicatedArms.RightWeld.Enabled = false
                        v27 = TweenService
                        local RightShoulder_3 = DedicatedArms.RightShoulder
                        v29 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        v30 = {C0 = DedicatedArms.RightShoulderC0}
                        v27:Create(RightShoulder_3, v29, v30):Play()
                    elseif Right or not v22 then
                        DedicatedArms.RightWeld.Enabled = not v20
                        DedicatedArms.RightShoulder.Enabled = v20
                    else
                        CFrame_17 = DedicatedArms.Right.CFrame
                        v25 = DedicatedArms.RightWeld.Part0.CFrame:Inverse() * CFrame_17
                        DedicatedArms.RightWeld.C0 = v25
                        DedicatedArms.RightWeld.Enabled = true
                        DedicatedArms.RightShoulder.Enabled = false
                    end
                    p1.PrevArmControlled.Right = v22
                end
            end
            p1:UpdateArmOffsets(v8)
            if DedicatedArms
                and p1.ManagerState ~= "Lowered"
                and p1.ManagerState ~= "Hidden"
                and not p1.ForceLoweredPosition then
                v20 = Lerp(0.4, 1, SharedSprings.SprintSpring.Position)
                if p1.Weapon.Config.IsMelee then
                    v20 = 1
                end
                v22 = p1.PrimaryPart.CFrame * v3
                v21 = v22 * BobbingUtil.gunBobCF
                v23 = p1
                local CFrame_18 = v23.PrimaryPart.CFrame
                v21 = v21:Lerp(CFrame_18, v20)
                if v36 then
                    v22 = DedicatedArms.LeftWeld.Part0.CFrame * v34
                    v23 = v21:ToObjectSpace(v22)
                    v24 = v22 * CFrame.new(0.1, -1.4, 0)
                    local LeftWeld = DedicatedArms.LeftWeld
                    LeftWeld.C0 = (DedicatedArms.LeftWeld.Part0.CFrame:Inverse()) * p1.PrimaryPart.CFrame * v23
                    local CFrame_19 = DedicatedArms.LeftWeld.Part0.CFrame
                    v27 = CFrame.new(DedicatedArms.LeftWeld.C0.Position)
                    v25 = CFrame_19:toWorldSpace(v27)
                    DedicatedArms.LeftWeld.C0 = DedicatedArms.LeftWeld.C0 * CFrame.Angles(-1.5707963267948966, 0, 0)
                    v26 = (CFrame.lookAt(v25.Position, v24.Position, DedicatedArms.Left.CFrame.UpVector)) * CFrame.Angles(1.5707963267948966, 0, 0)
                    DedicatedArms.LeftWeld.C0 = DedicatedArms.LeftWeld.Part0.CFrame:toObjectSpace(v26)
                    DedicatedArms.LeftWeld.C0 = DedicatedArms.LeftWeld.C0 * p1.ArmOffsets.Left
                end
                if v19 then
                    local CFrame_20 = DedicatedArms.RightWeld.Part0.CFrame
                    v23 = v21:ToObjectSpace(CFrame_20)
                    v24 = CFrame_20 * CFrame.new(-0.1, -1.4, 0)
                    local RightWeld = DedicatedArms.RightWeld
                    RightWeld.C0 = (DedicatedArms.RightWeld.Part0.CFrame:Inverse()) * p1.PrimaryPart.CFrame * v23
                    local CFrame_21 = DedicatedArms.RightWeld.Part0.CFrame
                    v27 = CFrame.new(DedicatedArms.RightWeld.C0.Position)
                    v25 = CFrame_21:toWorldSpace(v27)
                    DedicatedArms.RightWeld.C0 = DedicatedArms.RightWeld.C0 * CFrame.Angles(-1.5707963267948966, 0, 0)
                    v26 = (CFrame.lookAt(v25.Position, v24.Position, DedicatedArms.Right.CFrame.UpVector)) * CFrame.Angles(1.5707963267948966, 0, 0)
                    DedicatedArms.RightWeld.C0 = DedicatedArms.RightWeld.Part0.CFrame:toObjectSpace(v26)
                    DedicatedArms.RightWeld.C0 = DedicatedArms.RightWeld.C0 * p1.ArmOffsets.Right
                end
            end
            ShellSystem:Update(v8)
            if Config.ChainAtt then
                local CFrame_22 = Config.ChainAtt.CFrame
                u77 = CFrame_22 - CFrame_22.Position
                local ChainAtt = Config.ChainAtt
                ChainAtt.CFrame = (new(Config.ChainAtt.Parent.AttachmentPart.Position)) * u77
            end
            if p1.AnimatedTextures then
                AnimatedTextures.update(p1.AnimatedTextures)
            end
            if Config.CustomRS then
                local CustomRS = Config.CustomRS
                v21 = p1
                CustomRS(v21.Model, {Ammo = p1.Weapon.Ammo}, v8)
            end
            if Config.AnimateTextureThink then
                Config.AnimateTextureThink(p1.Model, Config, u147, v8, p1)
            end
        end
    end)
end

function u183.ChangedFiremode(p1) -- Line: 830 -- upvalues: u159 (val), u165 (val)
    u159.Target = 0.3
    u165.Target = -0.2
end

function u183.GetModel(p1) -- Line: 836
    return p1.Model
end

function u183:Destroy() -- Line: 841 -- upvalues: RunService (val)
    if self.Model then
        self.Model:Destroy()
    end
    if self.Enabled then
        local v1 = RunService
        local Name = self.Name
        v1:UnbindFromRenderStep(Name)
    end
    if self.HRPADSAttachment then
        self.HRPADSAttachment:Destroy()
        self.HRPADSAttachment = nil
    end
    local Janitor = self.Janitor
    if Janitor then
        Janitor:Destroy()
        self.Janitor = nil
    end
end

function u183:StopAnimation(p2) -- Line: 863
    if self.Animations and self.Animations[p2] then
        self.Animations[p2]:Stop()
    end
end

function u183.PlayAnimation(p1, p2, ...) -- Line: 869 -- upvalues: Promise (val)
    local v1, v2

    local function AnimationsPromise() -- Line: 870 -- upvalues: Promise (upval), p1 (val)
        local v1 = Promise
        return v1.new(function(p1_2, p2, p3) -- Line: 871 -- upvalues: p1 (upval)
            if not p1.Animations then
                repeat
                    task.wait()
                until p1.Animations
            end
            p1_2()
        end)
    end

    local v3 = {...}
    v1, v3, v2 = unpack(v3)
    local u9 = v1 or 0
    local u10 = v3 or 1
    local u11 = v2 or 1

    local function round(p1, p2) -- Line: 886
        local v1 = string.format("%." .. (p2 or 0) .. "f", p1)
        return (tonumber(v1))
    end

    local v4 = Promise
    v4 = v4.new(function(p1_2, p2, p3) -- Line: 871 -- upvalues: p1 (val)
        if not p1.Animations then
            repeat
                task.wait()
            until p1.Animations
        end
        p1_2()
    end)
    v4 = v4:andThen(function() -- Line: 890 -- upvalues: p1 (val), p2 (val), u9 (ref), u10 (ref), u11 (ref)
        if not p1.Animations[p2] then
            return
        end
        local v1 = p1.Animations[p2]
        local v2 = u9
        local v3 = u10
        local v4 = u11
        v1:Play(v2, v3, v4)
    end)
    return v4
end

function u183.Shoot(p1) -- Line: 899 -- upvalues: ShellSystem (val), peek (val), u107 (val)
    if not p1.Weapon.Config.ShellOn then
        ShellSystem:Eject(p1)
    end
    if p1.RecoilInstance then
        p1.RecoilInstance:Impulse()
    end
    if 1 < (peek(u107.Graphics.ParticleQuality)) and p1.MuzzleModule then
        pcall(function() -- Line: 909 -- upvalues: p1 (val)
            local v1 = p1
            local MuzzleModule = v1.MuzzleModule
            local v2 = p1
            MuzzleModule:Emit(v2)
        end)
    end
    if p1.Weapon.Config.CustomShoot then
        p1.Weapon.Config.CustomShoot(p1.Weapon.Ammo, p1.Model)
    end
end

function u183:Loaded() -- Line: 920
    -- upvalues: ArmModelUtil (val), FakeArmUtil (val), PointRotationUtil (val), Ignore (val), CameraController (val)
    local v1
    local v2 = not self.RightArmOnly
    local v3 = not self.LeftArmOnly
    if not self.UseArmModels then
        v1 = FakeArmUtil
        local Model_2 = self.Model
        v1:ShowForArms(Model_2, v2, v3)
    else
        v1 = ArmModelUtil
        local Model = self.Model
        local IsMirrored = self.IsMirrored
        v1:AttachArms(Model, v3, v2, IsMirrored)
    end
    if not self.ForceLoweredPosition then
        PointRotationUtil.NewWeapon(self)
    end
    self.Model.Parent = Ignore
    if not self.NoCameraBone
        and not self.CameraBoneMotor6D
        and not self.IgnoreCameraBone
        and not self.Weapon.Config.DisableCameraBone then
        local Head, Head_2 = self.Model:FindFirstChild("Head")
        if Head then
            Head_2 = self.Model.Head:FindFirstChild("Camera")
        end
        if not Head_2 then
            Head_2 = self.Model.HumanoidRootPart:FindFirstChild("Camera")
        end
        if not Head_2 then
            Head_2 = self.Model:FindFirstChild("TrackMe", true) or self.Model:FindFirstChild("Head 🡪 Handle", true)
        end
        if not Head_2 then
            self.NoCameraBone = true
        else
            self.StartingTransform = Head_2.Transform
            self.CameraBoneMotor6D = Head_2
        end
    end
    v1 = CameraController
    local StartingTransform = self.StartingTransform
    local CameraBoneMotor6D = self.CameraBoneMotor6D
    v1:SetCameraBone(StartingTransform, CameraBoneMotor6D)
    local FirstDrawAnimation = self.Weapon.Config.FirstDrawAnimation
    local DrawAnimation = self.Weapon.Config.DrawAnimation
    if FirstDrawAnimation and not self.FirstDrew then
        self.FirstDrew = true
        ;(self:PlayAnimation(FirstDrawAnimation)):andThen(function() -- Line: 984 -- upvalues: self (val), FirstDrawAnimation (val)
            local v1 = self.Animations[FirstDrawAnimation]
            v1.TimePosition = self.Weapon.Config.FirstDrawAnimationTime or 0
        end)
        return
    end
    if DrawAnimation and not self.Weapon.Reloading then
        local DrawSpeed = self.Weapon.Config.DrawSpeed
        ;(self:PlayAnimation(DrawAnimation, nil, nil, DrawSpeed or 1)):andThen(function() -- Line: 989 -- upvalues: self (val), DrawAnimation (val)
            local v1 = self.Animations[DrawAnimation]
            v1.TimePosition = self.Weapon.Config.DrawAnimationTime or 0
        end)
    end
end

function u183:_resolveIdleAimCFrame() -- Line: 999 -- upvalues: new (val), RunService (val)
    local Viewmodel = self.Weapon.Config.Viewmodel
    if not Viewmodel then
        return
    end
    task.spawn(function() -- Line: 1009 -- upvalues: Viewmodel (val), new (upval), self (val), RunService (upval)
        local v1 = Viewmodel:Clone()
        local v2 = new
        v2 = v2(0, 10000, 0)
        v1:PivotTo(v2)
        v1.Parent = workspace.Ignore
        local HumanoidRootPart = v1:FindFirstChild("HumanoidRootPart")
        local Aimpart = (v1:WaitForChild("KeyParts")):FindFirstChild("Aimpart")
        if HumanoidRootPart and Aimpart then
            local CFrame_4, v3, v4
            local AnimationController = v1:FindFirstChildWhichIsA("AnimationController")
            if not AnimationController then
                AnimationController = Instance.new("AnimationController")
                AnimationController.Parent = v1
            end
            local Animator = AnimationController:FindFirstChildOfClass("Animator")
            if not Animator then
                Animator = Instance.new("Animator")
                Animator.Parent = AnimationController
            end
            local Animations = v1:FindFirstChild("Animations")
            if not Animations then
                v1:Destroy()
                return
            end
            local Idle = Animations:FindFirstChild("Idle")
            if not Idle then
                local Swing1
                local Config = self.Weapon.Config
                if Config.IsMelee then
                    Swing1 = Animations:FindFirstChild("Swing1")
                    if not Swing1 then
                        if not Config.UsesLoadLoop then
                            Swing1 = Animations:FindFirstChild("Reload")
                        else
                            Swing1 = Animations:FindFirstChild("LoadStart")
                            if not Swing1 then
                                Swing1 = Animations:FindFirstChild("Reload")
                            end
                        end
                    end
                elseif not Config.UsesLoadLoop then
                    Swing1 = Animations:FindFirstChild("Reload")
                else
                    Swing1 = Animations:FindFirstChild("LoadStart")
                    if not Swing1 then
                        Swing1 = Animations:FindFirstChild("Reload")
                    end
                end
                Idle = Swing1
                if Idle then
                    Idle = Idle:Clone()
                    Idle.Name = "Idle"
                end
            end
            if not Idle then
                v1:Destroy()
                return
            end
            local v5 = Animator:LoadAnimation(Idle)
            v5.Looped = true
            v5.Priority = Enum.AnimationPriority.Core
            v5:Play(0, 1, 1)
            local v6 = new()
            local Model = self.Model
            if Model then
                Model = self.Model:FindFirstChild("KeyParts")
                if Model then
                    Model = self.Model.KeyParts:FindFirstChild("Aimpart")
                end
            end
            if Model and self.Aimpart and self.Aimpart ~= Model then
                local CFrame = Model.CFrame
                local v7 = self
                local CFrame_2 = v7.Aimpart.CFrame
                v6 = CFrame:ToObjectSpace(CFrame_2)
            end
            local v8 = false
            for i = 1, 60 do
                RunService.RenderStepped:Wait()
                if self.Weapon.IsDestroyed then
                    v1:Destroy()
                    return
                end
                if not v8 and 0 < v5.Length then
                    v5:AdjustSpeed(0.0001)
                    v5.TimePosition = 0
                    v8 = true
                end
                v3 = Aimpart.CFrame * v6
                CFrame_4 = HumanoidRootPart.CFrame
                v4 = v3:ToObjectSpace(CFrame_4)
                self._idleAimRelCF = v4
                if self.HRPADSAttachment and self.PrimaryPart then
                    self.HRPADSAttachment.WorldCFrame = self.PrimaryPart.CFrame * v4:Inverse()
                end
            end
            v5:Stop(0)
            v5:Destroy()
            v1:Destroy()
            return
        end
        v1:Destroy()
    end)
end

local u204 = (CFrame.new(0.5, 1.5, -0.3)) * CFrame.Angles(0.5235987755982988, 0, 0.2617993877991494)
local u215 = (CFrame.new(-0.5, 1.5, -0.3)) * CFrame.Angles(0.5235987755982988, 0, -0.2617993877991494)
local u226 = (CFrame.new(0, 3, -1)) * CFrame.Angles(1.0471975511965976, 0, 0)
local u237 = (CFrame.new(0, 0, 0)) * CFrame.Angles(-0.3490658503988659, 0.4363323129985824, 0)

function u183.ApplyManagerState(p1, p2, p3) -- Line: 1127 -- upvalues: u237 (val), u226 (val), u204 (val), u215 (val)
    p1.ManagerState = p2
    p1.ManagerGrantedArms = p3
    if p2 == "Lowered" then
        p1.ViewmodelBaseOffsetTarget = u237
        p1.ArmOffsetTargets.Right = u226
        p1.ArmOffsetTargets.Left = u226
        return
    end
    if p2 == "Hidden" then
        p1.ViewmodelBaseOffsetTarget = CFrame.new(0, -10, 0)
        p1.ArmOffsetTargets.Right = u226
        p1.ArmOffsetTargets.Left = u226
        return
    end
    if not p1.ForceLoweredPosition then
        p1.ViewmodelBaseOffsetTarget = CFrame.new()
    else
        p1.ViewmodelBaseOffsetTarget = u237
    end
    if p1.ForceOneHanded then
        p1.ArmOffsetTargets.Right = CFrame.new()
        p1.ArmOffsetTargets.Left = u204
        return
    end
    if not p3.Right then
        p1.ArmOffsetTargets.Right = u215
    else
        p1.ArmOffsetTargets.Right = CFrame.new()
    end
    if p3.Left then
        p1.ArmOffsetTargets.Left = CFrame.new()
        return
    end
    p1.ArmOffsetTargets.Left = u204
end

function u183.SetArmOffset(p1, p2, p3) -- Line: 1173
    if p2 == "Right" or p2 == "Left" then
        p1.ArmOffsetTargets[p2] = p3
    end
end

function u183.GetArmOffset(p1, p2) -- Line: 1180
    if p2 ~= "Right" and p2 ~= "Left" then
        return CFrame.new()
    end
    return p1.ArmOffsets[p2]
end

function u183:UpdateArmOffsets(p2) -- Line: 1188
    local v1 = self.ArmOffsetSpeed * p2
    v1 = math.clamp(v1, 0.01, 1)
    local ArmOffsets = self.ArmOffsets
    local Right = self.ArmOffsets.Right
    local Right_2 = self.ArmOffsetTargets.Right
    ArmOffsets.Right = Right:Lerp(Right_2, v1)
    local ArmOffsets_3 = self.ArmOffsets
    local Left = self.ArmOffsets.Left
    local Left_2 = self.ArmOffsetTargets.Left
    ArmOffsets_3.Left = Left:Lerp(Left_2, v1)
    local ViewmodelBaseOffset = self.ViewmodelBaseOffset
    local ViewmodelBaseOffsetTarget = self.ViewmodelBaseOffsetTarget
    self.ViewmodelBaseOffset = ViewmodelBaseOffset:Lerp(ViewmodelBaseOffsetTarget, v1)
end

function u183:CreateDedicatedArms() -- Line: 1199 -- upvalues: FakeArmUtil (val)
    if self.DedicatedArms then
        return self.DedicatedArms
    end
    if not self.Model then
        return nil
    end
    local v1 = FakeArmUtil
    local Model = self.Model
    self.DedicatedArms = v1:CreateDedicatedArms(Model)
    return self.DedicatedArms
end

function u183:DestroyDedicatedArms() -- Line: 1211 -- upvalues: FakeArmUtil (val)
    if self.DedicatedArms then
        local v1 = FakeArmUtil
        local Model = self.Model
        v1:DestroyDedicatedArms(Model)
        self.DedicatedArms = nil
    end
end

function u183.ApplyImpulse(p1, p2) -- Line: 1221
    p1.ImpulseCF = p1.ImpulseCF * p2
end

function u183.ApplyOffset(p1, p2, p3) -- Line: 1228
    local Offsets = p1.Offsets
    local v1 = p3
    if not v1 then
        v1 = CFrame.new()
    end
    Offsets[p2] = v1
    updateOffset(p1)
end

function u183.RemoveOffset(p1, p2) -- Line: 1235
    p1.Offsets[p2] = nil
    updateOffset(p1)
end

function u183.ApplyOffsetImpulse(p1, p2, p3) -- Line: 1243
    local v1
    local v2 = p1.Offsets[p2]
    if not v2 then
        local v3 = _G
        v1 = "Tried to apply impulse to a non-existant offset: " .. p2
        v3:warn(v1)
        return
    end
    local Offsets = p1.Offsets
    v1 = p3
    if not v1 then
        v1 = CFrame.new()
    end
    Offsets[p2] = v2 * v1
    updateOffset(p1)
end

function u183:UpdatePhysics() -- Line: 1257
    -- upvalues: SharedSprings (val), u141 (val), LocalPlayerController (val), CameraController (val)
    -- upvalues: PointRotationUtil (val), new (val), Angles (val), u138 (ref)
    local Position_2, hrp, v1, v2
    local Config = self.Weapon.Config
    if not Config.BlockSpringSpeed or not self.Weapon.Blocking then
        SharedSprings.BlockSpring.Speed = 25
    else
        SharedSprings.BlockSpring.Speed = Config.BlockSpringSpeed
    end
    local BlockSpring = SharedSprings.BlockSpring
    if not self.Weapon.Blocking then
        v1 = 0
    else
        v1 = 1
    end
    BlockSpring.Target = v1
    local IsDualWieldRight = self.IsDualWieldRight
    if not IsDualWieldRight then
        IsDualWieldRight = self.IsMirrored
    end
    local ForceOneHanded = self.ForceOneHanded
    if ForceOneHanded then
        ForceOneHanded = not IsDualWieldRight
    end
    local v3 = u141
    if not LocalPlayerController.States.Crouching or self.Weapon.Aiming or IsDualWieldRight or ForceOneHanded then
        v2 = 0
    else
        v2 = 1
    end
    v3.Target = v2
    if LocalPlayerController.ThirdPerson then
        hrp = 0.05 < SharedSprings.TPSpring.Position
    else
        hrp = LocalPlayerController.hrp
        if hrp then
            hrp = 0.05 < SharedSprings.TPSpring.Position
        end
    end
    v2 = hrp
    if v2 then
        v2 = CameraController:ShouldGunRest()
    end
    local v4 = not IsDualWieldRight
    if not v4 then
        v4 = true
        if Config.DualWieldRestMode ~= "sprint" then
            local DualWieldRestMode = Config.DualWieldRestMode
            v4 = typeof(DualWieldRestMode) == "CFrame"
        end
    end
    local ForceOneHanded_2 = self.ForceOneHanded
    if ForceOneHanded_2 then
        ForceOneHanded_2 = not IsDualWieldRight
    end
    local v5 = v4 and not ForceOneHanded_2
    if LocalPlayerController.States.Sliding then
        SharedSprings.SprintSpring.Target = 0
    elseif not LocalPlayerController.States.Sprinting then
        if not v2 or not v5 then
            SharedSprings.SprintSpring.Target = 0
        else
            SharedSprings.SprintSpring.Target = 1
        end
    elseif not Config.FireWhileSprinting then
        local v6
        local SprintSpring = SharedSprings.SprintSpring
        if not LocalPlayerController.States.Jogging then
            v6 = 1
        else
            v6 = 0.5
        end
        SprintSpring.Target = v6
    elseif not v2 or not v5 then
        SharedSprings.SprintSpring.Target = 0
    else
        SharedSprings.SprintSpring.Target = 1
    end
    local UpdateRotation = PointRotationUtil.UpdateRotation
    local v7 = new()
    local CrouchAnimation = self.Weapon.Config.CrouchAnimation
    if not CrouchAnimation then
        CrouchAnimation = (new(-0.6, 0, 0)) * Angles(0, 0, 0.7853981633974483)
    end
    local v8 = u141
    local Position = v8.Position
    UpdateRotation("Sliding", nil, v7:Lerp(CrouchAnimation, Position))
    local v9 = (new(0, 0, 0)) * Angles(-0.7853981633974483, 0.4363323129985824, 0.4363323129985824)
    if self.LeftArmOnly then
        Position_2 = self.EquipSpring.Position
        if not Position_2 then
            Position_2 = SharedSprings.EquipSpring.Position
        end
    elseif not self.IsMirrored then
        Position_2 = SharedSprings.EquipSpring.Position
    else
        Position_2 = self.EquipSpring.Position
        if not Position_2 then
            Position_2 = SharedSprings.EquipSpring.Position
        end
    end
    local v10 = new():Lerp(v9, Position_2)
    local SprintOffset = self.Config.SprintOffset
    if IsDualWieldRight and self.Config.DualWieldSprintOffset then
        SprintOffset = self.Config.DualWieldSprintOffset
    end
    local v11 = CFrame.new()
    local v12 = SharedSprings
    local Position_3 = v12.SprintSpring.Position
    v11 = v11:Lerp(SprintOffset, Position_3)
    local v13 = CFrame.new()
    local BlockOffset = self.Config.BlockOffset
    if not BlockOffset then
        BlockOffset = new()
    end
    local v14 = SharedSprings
    local Position_4 = v14.BlockSpring.Position
    u138 = v11 * v13:Lerp(BlockOffset, Position_4) * v10
end

function createVM(p1) -- Line: 1349
    local Attachment, Handle, KeyParts, v1, v2, v3
    local Name = p1.Name
    local Viewmodel = p1.Config.Viewmodel
    if not Viewmodel then
        warn("[Viewmodel] Could not find viewmodel for weapon: " .. Name)
        return
    end
    local v4 = p1.Config.BarrelCount or 1
    for i = 1, v4 do
        KeyParts = Viewmodel:WaitForChild("KeyParts")
        v3 = "Barrel"
        v1 = 1 < i and i or ""
        v2 = v3 .. v1
        Handle = KeyParts:FindFirstChild(v2)
        if not Handle then
            Handle = Viewmodel.KeyParts.Handle
        end
        if not Handle:FindFirstChild("BarrelAttachment") then
            Attachment = Instance.new("Attachment")
            Attachment.Name = "BarrelAttachment"
            Attachment.Parent = Handle
            for j, k in Handle:GetChildren() do
                if k:IsA("ParticleEmitter") or k:IsA("Light") or k:IsA("Attachment") and k ~= Attachment then
                    k.Parent = Attachment
                end
            end
        end
    end
    v4 = Viewmodel:Clone()
    v4.Name = Name
    local HumanoidRootPart = v4:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        warn("[Viewmodel]: Could not find HumanoidRootPart for weapon: " .. Name)
        return
    end
    local AnimationController = v4:FindFirstChildWhichIsA("AnimationController")
    if not AnimationController then
        AnimationController = Instance.new("AnimationController")
        AnimationController.Parent = v4
    end
    local Animator = AnimationController:FindFirstChildOfClass("Animator")
    if not Animator then
        Animator = Instance.new("Animator")
        Animator.Parent = AnimationController
    end
    for n, m in v4:QueryDescendants("BasePart") do
        m.CastShadow = false
    end
    return v4, HumanoidRootPart, Animator
end

function updateOffset(p1) -- Line: 1397
    p1.TotalOffset = CFrame.new()
    for k, v in pairs(p1.Offsets) do
        p1.TotalOffset = p1.TotalOffset * v
    end
end

function loadAnimations(p1, p2, p3) -- Line: 1406 -- upvalues: ShellSystem (val)
    local Janitor, v1, v2, v3
    local v4 = {}
    local v5, v6 = p3, p2
    for k, v in pairs(p3:GetChildren()) do
        if v:IsA("Animation") then
            local Config = p1.Weapon.Config
            v1 = v6:LoadAnimation(v)
            v2 = v.Name == "Idle"
            v1.Looped = v2
            p1.Janitor:Add(v1, "Destroy")
            Janitor = p1.Janitor
            v3 = v1.KeyframeReached:Connect(function(p1_2) -- Line: 1415 -- upvalues: Config (val), p1 (val), ShellSystem (upval)
                if Config.KeyFrameSounds[p1_2] then
                    local Sound = Instance.new("Sound")
                    local SoundId = Config.KeyFrameSounds[p1_2][1]
                    if not SoundId then
                        SoundId = Config.KeyFrameSounds[p1_2].SoundId
                    end
                    Sound.SoundId = "rbxassetid://" .. SoundId
                    local Volume = Config.KeyFrameSounds[p1_2][2]
                    if not Volume then
                        Volume = Config.KeyFrameSounds[p1_2].Volume
                    end
                    Sound.Volume = Volume
                    Sound.Parent = script
                    ;(game:GetService("SoundService")):PlayLocalSound(Sound)
                    game.Debris:AddItem(Sound, 10)
                end
                if Config.ShellOn and p1_2 == Config.ShellOn and p1.Weapon.NeedShell then
                    p1.Weapon.NeedShell = false
                    local v1 = ShellSystem
                    local v2 = p1
                    v1:Eject(v2)
                end
                if Config.OnKeyframeReached then
                    Config.OnKeyframeReached(p1_2, p1.Weapon)
                end
                if Config.CustomKF then
                    Config.CustomKF(p1_2, p1.Model, p1.Weapon.Config)
                end
            end)
            Janitor:Add(v3, "Disconnect")
            v4[v.Name] = v1
        end
    end
    if v4.Idle then
        v4.Idle:Play(0, 1, 1)
        v4.Idle.Priority = Enum.AnimationPriority.Idle
        v4.Idle.Looped = true
    else
        local v7
        if p1.Weapon.Config.IsMelee then
            v7 = v5.Swing1:Clone()
            if not v7 then
                if not p1.Weapon.Config.UsesLoadLoop then
                    v7 = v5.Reload:Clone()
                else
                    v7 = v5.LoadStart:Clone()
                    if not v7 then
                        v7 = v5.Reload:Clone()
                    end
                end
            end
        elseif not p1.Weapon.Config.UsesLoadLoop then
            v7 = v5.Reload:Clone()
        else
            v7 = v5.LoadStart:Clone()
            if not v7 then
                v7 = v5.Reload:Clone()
            end
        end
        v7.Name = "Idle"
        local v8 = v6:LoadAnimation(v7)
        v8.Looped = true
        repeat
            task.wait()
        until 0 < v8.Length
        v8:Play(0, 1, 1)
        v8.TimePosition = v8.Length
        v8:AdjustSpeed(0)
        v4.Idle = v8
    end
    if v4.IdleLayer then
        v4.IdleLayer:Play(0, 1, 1)
    end
    return v4
end

function setupViewmodel(p1) -- Line: 1473
    -- upvalues: Ignore (val), AttachmentSystem (val), DamageFalloffUtil (val), AnimatedTextures (val)
    -- upvalues: ReplicatedStorage (val)
    local v1
    local u3, v2, v3 = createVM(p1.Weapon)
    p1.Model = u3
    p1.PrimaryPart = v2
    local Barrel = (u3:WaitForChild("KeyParts")):FindFirstChild("Barrel")
    if not Barrel then
        Barrel = u3.KeyParts:FindFirstChild("Handle")
    end
    p1.Barrel = Barrel
    p1.BarrelAttachment = p1.Barrel:WaitForChild("BarrelAttachment", 5)
    if not p1.BarrelAttachment then
        error("[Viewmodel] Missing BarrelAttachment for weapon: " .. p1.Weapon.Name)
    end
    p1.Aimpart = u3.KeyParts:FindFirstChild("Aimpart")
    p1.DefaultAimpart = p1.Aimpart
    p1.Animator = v3
    u3.Parent = Ignore
    p1.Animations = loadAnimations(p1, v3, u3:WaitForChild("Animations"))
    p1.Animations.Idle.Priority = Enum.AnimationPriority.Core
    if p1.Weapon.Mods then
        v1 = AttachmentSystem
        v1.DressWeapon(u3.Name, p1.Weapon.Mods, p1.Weapon.Config.AttachmentNodeData, u3, function(p1_2, p2, p3) -- Line: 1499 -- upvalues: u3 (val), Ignore (upval), p1 (val), DamageFalloffUtil (upval)
            local Parent = u3.Parent
            u3.Parent = Ignore
            local v1 = nil
            if p3 then
                v1 = require(p3).new(p2, p1.Weapon.Config, p1)
                if v1.SettingChanges then
                    local CFrame_2, CFrame_3, Handle, SurfaceGui, SurfaceGui_2, SurfaceGui_3, Weld, v2, v3
                    local SettingChanges = v1.SettingChanges
                    local v4 = nil
                    local v5 = nil
                    for i, j in SettingChanges, v4, v5 do
                        if i == "Aimpart" then
                            p1.Aimpart = j
                            Handle = p1.Model.KeyParts.Handle
                            CFrame_2 = j.CFrame
                            CFrame_3 = Handle.CFrame
                            v3 = CFrame_2:toObjectSpace(CFrame_3)
                            p1.Aimpart:BreakJoints()
                            Weld = Instance.new("Weld")
                            Weld.Name = Handle.Name .. ":" .. j.Name
                            Weld.Part0 = Handle
                            Weld.Part1 = j
                            Weld.C0 = CFrame.new()
                            Weld.C1 = v3
                            Weld.Parent = Handle
                        elseif i == "Lense" then
                            if p1.Weapon.Config.Lense then
                                SurfaceGui = (p1.Model.KeyParts:WaitForChild("Lense")):FindFirstChildWhichIsA("SurfaceGui")
                                SurfaceGui.Enabled = false
                            end
                            if p1.Weapon.Config.Shadow and not v1.SettingChanges.Shadow then
                                p1.Weapon.Config.Shadow = false
                                SurfaceGui_2 = (p1.Model.KeyParts:WaitForChild("Shadow")):FindFirstChildWhichIsA("SurfaceGui")
                                SurfaceGui_2.Enabled = false
                            end
                            v2 = p1
                            v3 = j:GetAttribute("IsCircular") == true
                            v2.LenseIsCircular = v3
                            p1.Reticle = j:FindFirstChildWhichIsA("ImageLabel", true)
                        elseif i == "Shadow" then
                            p1.ShadowRing = j:FindFirstChild("Ring", true)
                            if p1.Weapon.Config.Shadow then
                                p1.Weapon.Config.Shadow = false
                                SurfaceGui_3 = (p1.Model.KeyParts:WaitForChild("Shadow")):FindFirstChildWhichIsA("SurfaceGui")
                                SurfaceGui_3.Enabled = false
                            end
                        elseif i == "BarrelAttachment" then
                            p1.BarrelAttachment = j
                        end
                        if i == "Damage"
                            and p1.Weapon.Config.DamageDropoff
                            and not v1.SettingChanges.DamageDropoff then
                            p1.Weapon.Config.DamageDropoff = DamageFalloffUtil.RescaleDropoff(p1.Weapon.Config.DamageDropoff, p1.Weapon.Config.Damage, j)
                        end
                        p1.Weapon.Config[i] = j
                    end
                end
            end
            u3.Parent = Parent
            return v1
        end, true):expect()
    end
    p1.AnimatedTextures = AnimatedTextures.collect(u3)
    if p1.Weapon.Config.Lense == true then
        p1.Weapon.Config.Lense = p1.Model.KeyParts:WaitForChild("Lense")
        local SurfaceGui = p1.Weapon.Config.Lense:FindFirstChildWhichIsA("SurfaceGui")
        SurfaceGui.Enabled = true
        v1 = p1.Weapon.Config.Lense:GetAttribute("IsCircular") == true
        p1.LenseIsCircular = v1
        p1.Reticle = p1.Weapon.Config.Lense:FindFirstChildWhichIsA("ImageLabel", true)
    end
    if p1.Weapon.Config.Shadow == true then
        p1.Weapon.Config.Shadow = p1.Model.KeyParts:WaitForChild("Shadow")
        local SurfaceGui_2 = p1.Weapon.Config.Shadow:FindFirstChildWhichIsA("SurfaceGui")
        SurfaceGui_2.Enabled = true
        p1.ShadowRing = p1.Weapon.Config.Shadow:FindFirstChildWhichIsA("ImageLabel", true)
    end
    if p1.Weapon.Config.MuzzleModule then
        v1 = ReplicatedStorage.common.SharedResources.MuzzleFlash[p1.Weapon.Config.MuzzleModule]
        local v4 = v1.Effects.MuzzleModuleFX:Clone()
        v4.Parent = p1.BarrelAttachment
        p1.MuzzleModule = require(v1)
    end
    p1.EjectionAttachment = p1.Model.KeyParts.Handle:FindFirstChild("BulletEjection")
    if p1.EjectionAttachment and not p1.EjectionAttachment:IsA("Attachment") then
        p1.EjectionAttachment = nil
    end
    u3.Parent = nil
    p1.ViewmodelLoaded = true
    p1.ConfigLoaded:Fire()
    p1:_resolveIdleAimCFrame()
end

function loadViewmodelPromise(p1) -- Line: 1603 -- upvalues: WepConfig (val)
    local v1 = WepConfig
    local WeaponId = p1.Weapon.WeaponId
    v1 = v1:StreamViewmodel(WeaponId)
    return v1:andThen(function(p1_2) -- Line: 1604 -- upvalues: p1 (val)
        p1.Weapon.Config.Viewmodel = p1_2
        if not p1.Weapon.IsDestroyed then
            setupViewmodel(p1)
        end
    end)
end

function Lerp(p1, p2, p3) -- Line: 1612
    return p1 * (1 - p3) + p2 * p3
end

return u183