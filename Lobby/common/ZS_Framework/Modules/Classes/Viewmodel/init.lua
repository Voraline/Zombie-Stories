local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CurrentCamera = workspace.CurrentCamera
local common = ReplicatedStorage.common
local Ignore = workspace.Ignore
local ViewmodelUtils = script.ViewmodelUtils
local Utils = script.Parent.Parent.Utils
local Controllers = script.Parent.Parent.Controllers
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
local SharedSprings = require(script.Parent.Parent.Shared.SharedSprings)
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
    setmetatable(v1, u183)
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
    loadViewmodelPromise(v1):catch(function(a1) -- Line: 191 -- upvalues: p1 (val)
        warn("[Viewmodel] Failed to load viewmodel for weapon " .. p1.Name .. ": " .. tostring(a1))
    end)
    return v1
end
function u183.SetEnabled(p1, p2) -- Line: 203 -- upvalues: Fusion (val), SkillTreeData (val), RecoilUtil (val), BobbingUtil (val), u147 (val), SpringUtil (val), new (val), ShellSystem (val), RunService (val), Value (val), PointRotationUtil (val), GunMovementUtil (val), u141 (val), LocalPlayerController (val), SharedSprings (val), peek (val), u107 (val), u138 (ref), Angles (val), u159 (val), u165 (val), CurrentCamera (val), CameraController (val), CursorRecoilUtil (val), RaycastUtil (val), u171 (val), HolographicEffect (val), ScopeHideEffect (val), FakeArmUtil (val), GripBlenderEffect (val), TweenService (val), AnimatedTextures (val), ArmModelUtil (val)
    local HRPADSAttachment, Model
    if p1.Enabled == p2 then
        return
    end
    p1.Enabled = p2
    if not p2 then
        p1.EquipSpring.Target = 1.5
        Model = 12
        p1.EquipSpring.Speed = Model * (p1.Weapon.Config.HolsterSpeed or 1)
        ShellSystem.UsingViewmodelStep = false
        if not p1.UseArmModels then
            FakeArmUtil:Hide(p1.Model)
        else
            ArmModelUtil:DetachArms(p1.Model)
        end
        if p1.Model then
            p1.Model.Parent = nil
        end
        RunService:UnbindFromRenderStep(p1.Name)
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
    local v1 = Fusion.peek(SkillTreeData.SwapSpeedMult)
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
            HRPADSAttachment = p1.HRPADSAttachment
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
    Model = new()
    ShellSystem.UsingViewmodelStep = true
    RunService:BindToRenderStep(p1.Name, Value, function(a1) -- Line: 249 -- upvalues: PointRotationUtil (upval), p1 (val), u41 (ref), u147 (upval), GunMovementUtil (upval), u141 (upval), LocalPlayerController (upval), SharedSprings (upval), new (upval), peek (upval), u107 (upval), BobbingUtil (upval), u138 (upval), Angles (upval), u159 (upval), u165 (upval), CurrentCamera (upval), CameraController (upval), RecoilUtil (upval), CursorRecoilUtil (upval), SpringUtil (upval), RaycastUtil (upval), u171 (upval), HolographicEffect (upval), ScopeHideEffect (upval), FakeArmUtil (upval), GripBlenderEffect (upval), Fusion (upval), SkillTreeData (upval), TweenService (upval), ShellSystem (upval), Model (ref), AnimatedTextures (upval)
        local Weapon, v1, v2, v3
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
        local v4 = Aimpart
        if v4 then
            v4 = not IsDualWieldRight
        end
        if not Aimpart then
            if p1.Weapon.Aiming then
                if not p1.Weapon.SecondaryAttackDown then
                    p1.Weapon.Aiming = false
                    if Config.CustomAiming then
                        Config.CustomAiming(p1.Model, false)
                    end
                elseif p1.Weapon.IsEquipped then
                end
            end
        elseif not p1.Weapon.Aiming and p1.Weapon.SecondaryAttackDown and p1.Weapon.IsEquipped then
            p1:StopAnimation("Inspect")
            p1.Weapon.Aiming = true
            if Config.CustomAiming then
                Config.CustomAiming(p1.Model, true)
            end
        end
        v1, v2 = GunMovementUtil:Update(a1, p1.Weapon.Aiming)
        if not p1.RecoilInstance then
            v3 = CFrame.new()
        else
            v3 = p1.RecoilInstance:Update(a1, u147, u141)
        end
        p1:UpdatePhysics()
        if p1.ViewmodelReady then
            p1.LoadingFrame.Target = 0
        elseif p1.ViewmodelLoaded and p1.Model and p1.Animations and p1.Animations.Idle and 0 < p1.Animations.Idle.Length then
            p1.ViewmodelReady = true
            p1:Loaded()
        end
        if p1.Model and p1.ViewmodelReady then
            local CFrame, Lasers, Parent, Position, Position_3, hrp, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22
            if LocalPlayerController.ThirdPerson then
                hrp = 0.05 < SharedSprings.TPSpring.Position
            else
                hrp = LocalPlayerController.hrp
                if not hrp then end
            end
            if p1.VMAnimInfluenceSpring then
                if not p1.Weapon.Reloading then
                    p1.VMAnimInfluenceSpring.Target = 0
                else
                    p1.VMAnimInfluenceSpring.Target = Config.ReloadADSInfluence or 0.15
                end
            end
            if not v4 then
                v22 = new()
            else
                local Attribute
                if not p1.HRPADSAttachment then
                    CFrame = p1.Aimpart.CFrame
                elseif p1.VMAnimInfluenceSpring then
                    CFrame = p1.Aimpart.CFrame:Lerp(p1.HRPADSAttachment.WorldCFrame, p1.VMAnimInfluenceSpring.Position)
                end
                if p1.Aimpart ~= p1.DefaultAimpart then
                    Attribute = new()
                else
                    Attribute = p1.Model:GetAttribute("SkinAimPartOffset")
                    if not Attribute then
                        Attribute = new()
                    end
                end
                local AimOffset = Config.AimOffset
                if not AimOffset then
                    AimOffset = new()
                end
                v22 = (CFrame * AimOffset * Attribute):toObjectSpace(p1.PrimaryPart.CFrame)
            end
            if hrp then
                v22 = new()
            end
            if not p1.ForceLoweredPosition then
                v6 = u147
                if not p1.Weapon.Aiming then
                    v7 = 0
                elseif not Config.DisableADSReload then
                    v7 = 1
                elseif Config.DisableADSReload and p1.Weapon.Reloading then
                end
                v6.Target = v7
            end
            Weapon = p1.Weapon
            if 1 > u147.Target then
                v7 = 0
            else
                v7 = u147.Position / u147.Target
            end
            Weapon.ADSStrength = v7
            local GripOffset = Config.GripOffset
            if not Config.LeftArmGrip then
                v6 = new()
            elseif GripOffset then
                v6 = GripOffset:Lerp(new(), p1.Weapon.ADSStrength)
            end
            local v23 = math.clamp(a1 * 10, 0.01, 1)
            p1.ImpulseCF = p1.ImpulseCF:Lerp(CFrame.new(), v23)
            local DynamicFOVOffsetConstant = Config.DynamicFOVOffsetConstant
            local v24 = Config.AimDynamicFOVOffsetConstant or DynamicFOVOffsetConstant
            local v25 = CFrame.new()
            local v26 = CFrame.new()
            if DynamicFOVOffsetConstant then
                v8 = math.sin((math.rad(peek(u107.Graphics.BaseFOV) * 0.5))) + -0.573576436351046
                v25 = CFrame.new(0, 0, v8 * DynamicFOVOffsetConstant)
                v26 = CFrame.new(0, 0, v8 * v24)
            end
            if not hrp then
                Position = u147.Position
            else
                Position = 0
            end
            local v27 = v25:Lerp(v26, Position)
            local v28 = v27 * BobbingUtil.gunBobCF * v1
            local v29 = v28 * u138 * v3
            local v30 = v29 * p1.TotalOffset
            v8 = v30 * p1.ImpulseCF * v6
            local v31 = CFrame.new()
            if p1.StartingTransform and p1.CameraBoneMotor6D then
                local Position_2
                v30 = p1.StartingTransform * p1.CameraBoneMotor6D.Transform:inverse()
                if Config.UseAltCameraReload then
                    _, _, v28 = (v30 - v30.Position):ToOrientation()
                    v30 = Angles(0, 0, v28 * 0.05)
                end
                if p1.LeftArmOnly then
                    Position_2 = p1.EquipSpring.Position
                    if not Position_2 then
                        Position_2 = SharedSprings.EquipSpring.Position
                    end
                elseif not p1.IsMirrored then
                end
                v31 = v30:Lerp(CFrame.new(), Position_2)
            end
            v28 = v22 * BobbingUtil.gunBobCF * v1 * u138 * v3 * v31
            if not hrp then
                Position_3 = u147.Position
            else
                Position_3 = 0
            end
            v8 = v8:Lerp(v28 * p1.ImpulseCF, Position_3)
            v27 = a1 * 10 * u41
            u159.Target = Lerp(u159.Target, 0, (math.clamp(v27, 0.0001, 1)))
            v27 = a1 * 10 * u41
            u165.Target = Lerp(u165.Target, 0, (math.clamp(v27, 0.0001, 1)))
            local CFrame_2 = CurrentCamera.CFrame
            if hrp and LocalPlayerController.hrp and LocalPlayerController.hrp.Parent and LocalPlayerController.humanoid.Humanoid and 0 < LocalPlayerController.humanoid.Humanoid.Health then
                Parent = LocalPlayerController.hrp.Parent
                local HEADCOPY = Parent:FindFirstChild("HEADCOPY")
                if not HEADCOPY then
                    HEADCOPY = Parent:FindFirstChild("Head")
                elseif HEADCOPY:IsA("BasePart") then
                end
                if not HEADCOPY then
                    HEADCOPY = LocalPlayerController.hrp
                elseif HEADCOPY:IsA("BasePart") then
                end
                local CFrame_3 = HEADCOPY.CFrame
                local CFrame_4 = LocalPlayerController.hrp.CFrame
                local Position_4 = u147.Position
                if not LocalPlayerController.Animator then
                    CFrame_2 = CFrame_3
                else
                    local AimTwistAngle
                    local Proning = LocalPlayerController.States.Proning
                    local Y = CameraController.Y
                    if not Proning then
                        v12 = 0
                    else
                        v12 = 1.5707963267948966
                    end
                    v13 = math.clamp(-Y / 1.5707963267948966, 0, 1)
                    v14 = math.clamp(Y / 1.5707963267948966, 0, 1)
                    if Proning then
                        CFrame_3 = CFrame_3 * new(0, -1, 0.8)
                        CFrame_4 = CFrame_4 * new(0, -1, 0.8)
                    end
                    if not Proning then
                        AimTwistAngle = LocalPlayerController.Animator:GetAimTwistAngle()
                    else
                        AimTwistAngle = 0
                    end
                    v17 = CFrame_3 * Angles(v12, 0, 0)
                    v16 = v17 * Angles(0, AimTwistAngle, 0)
                    v28 = v16 * Angles(Y * 0.5, 0, 0)
                    v19 = CFrame_4 * new(0, 1.5, 0)
                    local v32 = Y + RecoilUtil:GetPitchRecoil() * 2
                    v18 = v19 * Angles(v32, 0, 0)
                    v19 = new()
                    if Proning then
                        v32 = new()
                    else
                        v32 = new(0, 0.5, -1.5)
                    end
                    v17 = v18 * v19:Lerp(v32, v13)
                    v18 = new()
                    if Proning then
                        v20 = new()
                    else
                        v20 = new(0, 1, 1.5)
                    end
                    CFrame_2 = v28:Lerp(v17 * v18:Lerp(v20, v14), Position_4)
                end
            end
            if p1.ManagerState == "Lowered" then
                p1.PrimaryPart.CFrame = CFrame_2 * p1.ViewmodelBaseOffset * BobbingUtil.gunBobCF * v1 * p1.TotalOffset * p1.ImpulseCF
            elseif p1.ManagerState ~= "Hidden" and not p1.ForceLoweredPosition then
                if 0 >= u147.Target then
                    v29 = 1
                else
                    v29 = 0
                end
                v9 = p1.LoadingFrame.Position * v29
                v28 = u159.Position * v29
                v10 = u165.Position * v29
                v14 = CFrame_2 * p1.ViewmodelBaseOffset
                v18 = new(0, 0, -0.5)
                v17 = v18 * Angles(-0.2617993877991494, 0, 0.2617993877991494)
                v13 = v14 * new():Lerp(v17, v28)
                v17 = new(0, 0, -0.5)
                v16 = v17 * Angles(0, 0, -0.2617993877991494)
                v12 = v13 * new():Lerp(v16, v10)
                v15 = new(0, 0, 1)
                p1.PrimaryPart.CFrame = v12 * new():Lerp(v15, v9) * v8
            end
            if p1.IsMirrored then
                local CFrame_5 = p1.PrimaryPart.CFrame
                v29 = CFrame.fromMatrix(CFrame_5.Position, CFrame_5.XVector * -1, CFrame_5.YVector, CFrame_5.ZVector)
                p1.PrimaryPart.CFrame = v29
            end
            if not p1.ForceLoweredPosition then
                PointRotationUtil.Update(a1, p1.Model, p1.Weapon.Aiming, u147, CFrame_2, v26, p1.Weapon)
            end
            local crosshairRecoil = CursorRecoilUtil.crosshairRecoil
            if p1.Weapon.Aiming and 0.0001 < crosshairRecoil.Magnitude and p1.Aimpart then
                v9 = CFrame.new(Vector3.new(0, 0, 1), crosshairRecoil * Vector3.new(1, 1, 1))
                v28 = v9 - v9.Position
                local CFrame_6 = p1.Aimpart.CFrame
                v27 = CFrame_6:ToObjectSpace(p1.PrimaryPart.CFrame)
                p1.PrimaryPart.CFrame = (CFrame_6 * v28):ToWorldSpace(v27)
            end
            if Config.Lasers then
                local Position_5
                Lasers = Config.Lasers
                v28 = nil
                v10 = nil
                v5 = a1
                for i, j in Lasers, v28, v10 do
                    v11 = j[1]
                    v12 = j[2]
                    if not (j[3]) then
                        j[3] = SpringUtil.new(0)
                        j[3].Target = 0
                        j[3].Speed = 20
                        j[3].Damper = 1
                    end
                    Position_5 = RaycastUtil.CustomRayDirection(v11.CFrame.Position, -v11.CFrame.RightVector.Unit * 100).Position
                    v11.End.WorldCFrame = new(Position_5)
                    v18 = 1 - math.abs((CFrame_2.LookVector:Dot(-v11.CFrame.RightVector)))
                    if 0.0005 < v18 then
                        v18 = 1
                    end
                    if hrp then
                        u171.Target = 1 - v18
                    else
                        u171.Target = 0
                    end
                    v12.BillboardGui.Enabled = true
                    v12.Position = Position_5:Lerp(RaycastUtil.CastBaseRay().Position, u171.Position)
                end
            end
            local Lense = Config.Lense
            if Lense and p1.Reticle then
                HolographicEffect.UpdateReticle(Lense, p1, CFrame_2)
            end
            local Shadow = Config.Shadow
            if Shadow and p1.ShadowRing then
                HolographicEffect.UpdateShadow(Shadow, p1, CFrame_2)
            end
            if Config.HideScopeModel then
                ScopeHideEffect.Update(p1, Config.HideScopeModel, u147)
            end
            local DedicatedArms = p1.DedicatedArms
            if not DedicatedArms then
                DedicatedArms = FakeArmUtil.Arms
            end
            v27 = new()
            local v33 = FakeArmUtil:OwnsArm(p1.Model, "Left")
            v11 = FakeArmUtil:OwnsArm(p1.Model, "Right")
            if DedicatedArms and v33 then
                if not Config.LeftArmGrip then
                    DedicatedArms.LeftWeld.C0 = new()
                else
                    v27 = GripBlenderEffect(DedicatedArms, p1.Weapon)
                end
            end
            if v33 then
                local Left
                if not p1.Weapon.Config.ArmIgnores then
                    v12 = false
                elseif p1.Weapon.Config.ArmIgnores["Left Arm"] then
                    v12 = true
                end
                if LocalPlayerController.States.IsDowned and not (Fusion.peek(SkillTreeData.HasLastStand)) then
                    v12 = true
                end
                if not p1.ManagerGrantedArms.Left then
                    v12 = true
                elseif not p1.ForceOneHanded then
                end
                if DedicatedArms then
                    Left = p1.PrevArmControlled.Left
                    v14 = not v12
                    if not Left then
                        if Left then
                            DedicatedArms.LeftWeld.Enabled = not v12
                            DedicatedArms.LeftShoulder.Enabled = v12
                        elseif v14 then
                            v17 = DedicatedArms.LeftWeld.Part0.CFrame:Inverse() * DedicatedArms.Left.CFrame
                            DedicatedArms.LeftWeld.C0 = v17
                            DedicatedArms.LeftWeld.Enabled = true
                            DedicatedArms.LeftShoulder.Enabled = false
                        end
                    elseif not v14 then
                        v18 = DedicatedArms.LeftShoulder.Part0.CFrame:Inverse() * DedicatedArms.Left.CFrame * DedicatedArms.LeftShoulder.C1
                        DedicatedArms.LeftShoulder.C0 = v18
                        DedicatedArms.LeftShoulder.Enabled = true
                        DedicatedArms.LeftWeld.Enabled = false
                        v21 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        TweenService:Create(DedicatedArms.LeftShoulder, v21, {C0 = DedicatedArms.LeftShoulderC0}):Play()
                    end
                    p1.PrevArmControlled.Left = v14
                end
            end
            if v11 then
                local Right
                if not p1.Weapon.Config.ArmIgnores then
                    v12 = false
                elseif p1.Weapon.Config.ArmIgnores["Right Arm"] then
                    v12 = true
                end
                if not p1.ManagerGrantedArms.Right then
                    v12 = true
                end
                if DedicatedArms then
                    Right = p1.PrevArmControlled.Right
                    v14 = not v12
                    if not Right then
                        if Right then
                            DedicatedArms.RightWeld.Enabled = not v12
                            DedicatedArms.RightShoulder.Enabled = v12
                        elseif v14 then
                            v17 = DedicatedArms.RightWeld.Part0.CFrame:Inverse() * DedicatedArms.Right.CFrame
                            DedicatedArms.RightWeld.C0 = v17
                            DedicatedArms.RightWeld.Enabled = true
                            DedicatedArms.RightShoulder.Enabled = false
                        end
                    elseif not v14 then
                        v18 = DedicatedArms.RightShoulder.Part0.CFrame:Inverse() * DedicatedArms.Right.CFrame * DedicatedArms.RightShoulder.C1
                        DedicatedArms.RightShoulder.C0 = v18
                        DedicatedArms.RightShoulder.Enabled = true
                        DedicatedArms.RightWeld.Enabled = false
                        v21 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        TweenService:Create(DedicatedArms.RightShoulder, v21, {C0 = DedicatedArms.RightShoulderC0}):Play()
                    end
                    p1.PrevArmControlled.Right = v14
                end
            end
            p1:UpdateArmOffsets(v5)
            if DedicatedArms and p1.ManagerState ~= "Lowered" and p1.ManagerState ~= "Hidden" and not p1.ForceLoweredPosition then
                v12 = if p1.Weapon.Config.IsMelee then 1 else Lerp(0.4, 1, SharedSprings.SprintSpring.Position)
                v14 = p1.PrimaryPart.CFrame * v2
                v13 = (v14 * BobbingUtil.gunBobCF):Lerp(p1.PrimaryPart.CFrame, v12)
                if v33 then
                    v14 = DedicatedArms.LeftWeld.Part0.CFrame * v27
                    v15 = v13:ToObjectSpace(v14)
                    v16 = v14 * CFrame.new(0.1, -1.4, 0)
                    v20 = DedicatedArms.LeftWeld.Part0.CFrame:Inverse()
                    DedicatedArms.LeftWeld.C0 = v20 * p1.PrimaryPart.CFrame * v15
                    v17 = DedicatedArms.LeftWeld.Part0.CFrame:toWorldSpace(CFrame.new(DedicatedArms.LeftWeld.C0.Position))
                    DedicatedArms.LeftWeld.C0 = DedicatedArms.LeftWeld.C0 * CFrame.Angles(-1.5707963267948966, 0, 0)
                    v19 = CFrame.lookAt(v17.Position, v16.Position, DedicatedArms.Left.CFrame.UpVector)
                    v18 = v19 * CFrame.Angles(1.5707963267948966, 0, 0)
                    DedicatedArms.LeftWeld.C0 = DedicatedArms.LeftWeld.Part0.CFrame:toObjectSpace(v18)
                    DedicatedArms.LeftWeld.C0 = DedicatedArms.LeftWeld.C0 * p1.ArmOffsets.Left
                end
                if v11 then
                    local CFrame_7 = DedicatedArms.RightWeld.Part0.CFrame
                    v15 = v13:ToObjectSpace(CFrame_7)
                    v16 = CFrame_7 * CFrame.new(-0.1, -1.4, 0)
                    v20 = DedicatedArms.RightWeld.Part0.CFrame:Inverse()
                    DedicatedArms.RightWeld.C0 = v20 * p1.PrimaryPart.CFrame * v15
                    v17 = DedicatedArms.RightWeld.Part0.CFrame:toWorldSpace(CFrame.new(DedicatedArms.RightWeld.C0.Position))
                    DedicatedArms.RightWeld.C0 = DedicatedArms.RightWeld.C0 * CFrame.Angles(-1.5707963267948966, 0, 0)
                    v19 = CFrame.lookAt(v17.Position, v16.Position, DedicatedArms.Right.CFrame.UpVector)
                    v18 = v19 * CFrame.Angles(1.5707963267948966, 0, 0)
                    DedicatedArms.RightWeld.C0 = DedicatedArms.RightWeld.Part0.CFrame:toObjectSpace(v18)
                    DedicatedArms.RightWeld.C0 = DedicatedArms.RightWeld.C0 * p1.ArmOffsets.Right
                end
            end
            ShellSystem:Update(v5)
            if Config.ChainAtt then
                local CFrame_8 = Config.ChainAtt.CFrame
                Model = CFrame_8 - CFrame_8.Position
                v15 = new(Config.ChainAtt.Parent.AttachmentPart.Position)
                Config.ChainAtt.CFrame = v15 * Model
            end
            if p1.AnimatedTextures then
                AnimatedTextures.update(p1.AnimatedTextures)
            end
            if Config.CustomRS then
                Config.CustomRS(p1.Model, {Ammo = p1.Weapon.Ammo}, v5)
            end
            if Config.AnimateTextureThink then
                Config.AnimateTextureThink(p1.Model, Config, u147, v5, p1)
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
        RunService:UnbindFromRenderStep(self.Name)
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
    local v1, v2, v3
    local function AnimationsPromise() -- Line: 870 -- upvalues: Promise (upval), p1 (val)
        return Promise.new(function(a1, p2, p3) -- Line: 871 -- upvalues: p1 (upval)
            if not p1.Animations then
                while true do
                    task.wait()
                    if p1.Animations then
                        break
                    end
                end
            end
            a1()
        end)
    end
    v1, v2, v3 = unpack({...})
    local u9 = v1 or 0
    local u10 = v2 or 1
    local u11 = v3 or 1
    local function round(p1, p2) -- Line: 886
        local v1 = "%." .. (p2 or 0) .. "f"
        return (tonumber(string.format(v1, p1)))
    end
    return Promise.new(function(a1, p2, p3) -- Line: 871 -- upvalues: p1 (val)
        if not p1.Animations then
            while true do
                task.wait()
                if p1.Animations then
                    break
                end
            end
        end
        a1()
    end):andThen(function() -- Line: 890 -- upvalues: p1 (val), p2 (val), u9 (ref), u10 (ref), u11 (ref)
        if not (p1.Animations[p2]) then
            return
        end
        p1.Animations[p2]:Play(u9, u10, u11)
    end)
end
function u183.Shoot(p1) -- Line: 899 -- upvalues: ShellSystem (val), peek (val), u107 (val)
    if not p1.Weapon.Config.ShellOn then
        ShellSystem:Eject(p1)
    end
    if p1.RecoilInstance then
        p1.RecoilInstance:Impulse()
    end
    local v1 = peek(u107.Graphics.ParticleQuality)
    if 1 < v1 and p1.MuzzleModule then
        pcall(function() -- Line: 909 -- upvalues: p1 (val)
            p1.MuzzleModule:Emit(p1)
        end)
    end
    if p1.Weapon.Config.CustomShoot then
        p1.Weapon.Config.CustomShoot(p1.Weapon.Ammo, p1.Model)
    end
end
function u183:Loaded() -- Line: 920 -- upvalues: ArmModelUtil (val), FakeArmUtil (val), PointRotationUtil (val), Ignore (val), CameraController (val)
    local CameraBoneMotor6D, v1
    local v2 = not self.RightArmOnly
    local v3 = not self.LeftArmOnly
    if not self.UseArmModels then
        FakeArmUtil:ShowForArms(self.Model, v2, v3)
    else
        ArmModelUtil:AttachArms(self.Model, v3, v2, self.IsMirrored)
    end
    if not self.ForceLoweredPosition then
        PointRotationUtil.NewWeapon(self)
    end
    self.Model.Parent = Ignore
    if not self.NoCameraBone and not self.CameraBoneMotor6D and not self.IgnoreCameraBone and not self.Weapon.Config.DisableCameraBone then
        local Head, Head_2
        Head, Head_2 = self.Model:FindFirstChild("Head")
        if Head then
            Head_2 = self.Model.Head:FindFirstChild("Camera")
        end
        if not Head_2 then
            Head_2 = self.Model.HumanoidRootPart:FindFirstChild("Camera")
        end
        if not Head_2 then
            Head_2 = self.Model:FindFirstChild("TrackMe", true)
            if not Head_2 then
                Head_2 = self.Model:FindFirstChild("Head 🡪 Handle", true)
            end
        end
        if not Head_2 then
            self.NoCameraBone = true
        else
            self.StartingTransform = Head_2.Transform
            self.CameraBoneMotor6D = Head_2
        end
    end
    CameraController:SetCameraBone(self.StartingTransform, self.CameraBoneMotor6D)
    local FirstDrawAnimation = self.Weapon.Config.FirstDrawAnimation
    local DrawAnimation = self.Weapon.Config.DrawAnimation
    if not FirstDrawAnimation then
        if DrawAnimation and not self.Weapon.Reloading then
            v1 = self:PlayAnimation(DrawAnimation, nil, nil, self.Weapon.Config.DrawSpeed or 1)
            v1:andThen(function() -- Line: 989 -- upvalues: self (val), DrawAnimation (val)
                local v1 = self.Animations[DrawAnimation]
                v1.TimePosition = self.Weapon.Config.DrawAnimationTime or 0
            end)
        end
        return
    end
    if not self.FirstDrew then
        self.FirstDrew = true
        local v4 = self:PlayAnimation(FirstDrawAnimation)
        v4:andThen(function() -- Line: 984 -- upvalues: self (val), FirstDrawAnimation (val)
            local v1 = self.Animations[FirstDrawAnimation]
            v1.TimePosition = self.Weapon.Config.FirstDrawAnimationTime or 0
        end)
        return
    end
    if DrawAnimation and not self.Weapon.Reloading then
        v1 = self:PlayAnimation(DrawAnimation, nil, nil, self.Weapon.Config.DrawSpeed or 1)
        v1:andThen(function() -- Line: 989 -- upvalues: self (val), DrawAnimation (val)
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
        local v1
        local v2 = Viewmodel:Clone()
        v2:PivotTo(new(0, 10000, 0))
        v2.Parent = workspace.Ignore
        local HumanoidRootPart = v2:FindFirstChild("HumanoidRootPart")
        local KeyParts = v2:WaitForChild("KeyParts")
        local Aimpart = KeyParts:FindFirstChild("Aimpart")
        if not HumanoidRootPart or not Aimpart then
            v2:Destroy()
            return
        end
        local AnimationController = v2:FindFirstChildWhichIsA("AnimationController")
        if not AnimationController then
            AnimationController = Instance.new("AnimationController")
            AnimationController.Parent = v2
        end
        local Animator = AnimationController:FindFirstChildOfClass("Animator")
        if not Animator then
            Animator = Instance.new("Animator")
            Animator.Parent = AnimationController
        end
        local Animations = v2:FindFirstChild("Animations")
        if not Animations then
            v2:Destroy()
            return
        end
        local Idle = Animations:FindFirstChild("Idle")
        if not Idle then
            local Swing1
            local Config = self.Weapon.Config
            if Config.IsMelee then
                Swing1 = Animations:FindFirstChild("Swing1")
            elseif not Config.UsesLoadLoop then
                Swing1 = Animations:FindFirstChild("Reload")
            else
                Swing1 = Animations:FindFirstChild("LoadStart")
            end
            Idle = Swing1
            if Idle then
                Idle = Idle:Clone()
                Idle.Name = "Idle"
            end
        end
        if not Idle then
            v2:Destroy()
            return
        end
        local v3 = Animator:LoadAnimation(Idle)
        v3.Looped = true
        v3.Priority = Enum.AnimationPriority.Core
        v3:Play(0, 1, 1)
        local v4 = new()
        local Model = self.Model
        if Model then
            Model = self.Model:FindFirstChild("KeyParts")
            if Model then
                Model = self.Model.KeyParts:FindFirstChild("Aimpart")
            end
        end
        if Model and self.Aimpart and self.Aimpart ~= Model then
            v4 = Model.CFrame:ToObjectSpace(self.Aimpart.CFrame)
        end
        local v5 = false
        local v6 = 60
        local v7 = 1
        for i = 1, v6, v7 do
            RunService.RenderStepped:Wait()
            if self.Weapon.IsDestroyed then
                v2:Destroy()
                return
            end
            if not v5 and 0 < v3.Length then
                v3:AdjustSpeed(0.0001)
                v3.TimePosition = 0
                v5 = true
            end
            v1 = (Aimpart.CFrame * v4):ToObjectSpace(HumanoidRootPart.CFrame)
            self._idleAimRelCF = v1
            if self.HRPADSAttachment and self.PrimaryPart then
                self.HRPADSAttachment.WorldCFrame = self.PrimaryPart.CFrame * v1:Inverse()
            end
        end
        v3:Stop(0)
        v3:Destroy()
        v2:Destroy()
    end)
end
local v2 = CFrame.new(0.5, 1.5, -0.3)
local u204 = v2 * CFrame.Angles(0.5235987755982988, 0, 0.2617993877991494)
local v3 = CFrame.new(-0.5, 1.5, -0.3)
local u215 = v3 * CFrame.Angles(0.5235987755982988, 0, -0.2617993877991494)
local v4 = CFrame.new(0, 3, -1)
local u226 = v4 * CFrame.Angles(1.0471975511965976, 0, 0)
local v5 = CFrame.new(0, 0, 0)
local u237 = v5 * CFrame.Angles(-0.3490658503988659, 0.4363323129985824, 0)
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
    if p2 == "Right" then
        p1.ArmOffsetTargets[p2] = p3
    elseif p2 == "Left" then
        p1.ArmOffsetTargets[p2] = p3
    end
end
function u183.GetArmOffset(p1, p2) -- Line: 1180
    if p2 == "Right" or p2 == "Left" then
        return p1.ArmOffsets[p2]
    end
    return CFrame.new()
end
function u183:UpdateArmOffsets(p2) -- Line: 1188
    local v1 = math.clamp(self.ArmOffsetSpeed * p2, 0.01, 1)
    self.ArmOffsets.Right = self.ArmOffsets.Right:Lerp(self.ArmOffsetTargets.Right, v1)
    self.ArmOffsets.Left = self.ArmOffsets.Left:Lerp(self.ArmOffsetTargets.Left, v1)
    self.ViewmodelBaseOffset = self.ViewmodelBaseOffset:Lerp(self.ViewmodelBaseOffsetTarget, v1)
end
function u183:CreateDedicatedArms() -- Line: 1199 -- upvalues: FakeArmUtil (val)
    if self.DedicatedArms then
        return self.DedicatedArms
    end
    if not self.Model then
        return nil
    end
    self.DedicatedArms = FakeArmUtil:CreateDedicatedArms(self.Model)
    return self.DedicatedArms
end
function u183:DestroyDedicatedArms() -- Line: 1211 -- upvalues: FakeArmUtil (val)
    if self.DedicatedArms then
        FakeArmUtil:DestroyDedicatedArms(self.Model)
        self.DedicatedArms = nil
    end
end
function u183.ApplyImpulse(p1, p2) -- Line: 1221
    p1.ImpulseCF = p1.ImpulseCF * p2
end
function u183.ApplyOffset(p1, p2, p3) -- Line: 1228
    local v1 = p3
    if not v1 then
        v1 = CFrame.new()
    end
    p1.Offsets[p2] = v1
    updateOffset(p1)
end
function u183.RemoveOffset(p1, p2) -- Line: 1235
    p1.Offsets[p2] = nil
    updateOffset(p1)
end
function u183.ApplyOffsetImpulse(p1, p2, p3) -- Line: 1243
    local v1 = p1.Offsets[p2]
    if not v1 then
        _G:warn("Tried to apply impulse to a non-existant offset: " .. p2)
        return
    end
    local v2 = p3
    if not v2 then
        v2 = CFrame.new()
    end
    p1.Offsets[p2] = v1 * v2
    updateOffset(p1)
end
function u183:UpdatePhysics() -- Line: 1257 -- upvalues: SharedSprings (val), u141 (val), LocalPlayerController (val), CameraController (val), PointRotationUtil (val), new (val), Angles (val), u138 (ref)
    local Position, SprintOffset, hrp, v1, v2, v3
    local Config = self.Weapon.Config
    if not Config.BlockSpringSpeed then
        SharedSprings.BlockSpring.Speed = 25
    elseif self.Weapon.Blocking then
        SharedSprings.BlockSpring.Speed = Config.BlockSpringSpeed
    end
    if not self.Weapon.Blocking then
        v2 = 0
    else
        v2 = 1
    end
    SharedSprings.BlockSpring.Target = v2
    local IsDualWieldRight = self.IsDualWieldRight
    if not IsDualWieldRight then
        IsDualWieldRight = self.IsMirrored
    end
    local ForceOneHanded = self.ForceOneHanded
    if ForceOneHanded then
        ForceOneHanded = not IsDualWieldRight
    end
    local v4 = u141
    if not LocalPlayerController.States.Crouching then
        v3 = 0
    elseif not self.Weapon.Aiming and not IsDualWieldRight and not ForceOneHanded then
        v3 = 1
    end
    v4.Target = v3
    if LocalPlayerController.ThirdPerson then
        hrp = 0.05 < SharedSprings.TPSpring.Position
    else
        hrp = LocalPlayerController.hrp
        if not hrp then end
    end
    v3 = hrp
    if v3 then
        v3 = CameraController:ShouldGunRest()
    end
    local v5 = not IsDualWieldRight
    if not v5 then
        v5 = if Config.DualWieldRestMode ~= "sprint" then typeof(Config.DualWieldRestMode) == "CFrame" else true
    end
    local ForceOneHanded_2 = self.ForceOneHanded
    if ForceOneHanded_2 then
        ForceOneHanded_2 = not IsDualWieldRight
    end
    local v6 = v5
    if v6 then
        v6 = not ForceOneHanded_2
    end
    if LocalPlayerController.States.Sliding then
        SharedSprings.SprintSpring.Target = 0
    elseif not LocalPlayerController.States.Sprinting then
        if not v3 then
            SharedSprings.SprintSpring.Target = 0
        elseif v6 then
            SharedSprings.SprintSpring.Target = 1
        end
    elseif not Config.FireWhileSprinting then
        if not LocalPlayerController.States.Jogging then
            v1 = 1
        else
            v1 = 0.5
        end
        SharedSprings.SprintSpring.Target = v1
    end
    local v7 = new()
    local CrouchAnimation = self.Weapon.Config.CrouchAnimation
    if not CrouchAnimation then
        local v8 = new(-0.6, 0, 0)
        CrouchAnimation = v8 * Angles(0, 0, 0.7853981633974483)
    end
    PointRotationUtil.UpdateRotation("Sliding", nil, v7:Lerp(CrouchAnimation, u141.Position))
    v1 = new(0, 0, 0)
    local v9 = v1 * Angles(-0.7853981633974483, 0.4363323129985824, 0.4363323129985824)
    if self.LeftArmOnly then
        Position = self.EquipSpring.Position
        if not Position then
            Position = SharedSprings.EquipSpring.Position
        end
    elseif not self.IsMirrored then
    end
    local v10 = new():Lerp(v9, Position)
    SprintOffset = if IsDualWieldRight and self.Config.DualWieldSprintOffset then self.Config.DualWieldSprintOffset else self.Config.SprintOffset
    local v11 = CFrame.new():Lerp(SprintOffset, SharedSprings.SprintSpring.Position)
    local v12 = CFrame.new()
    local BlockOffset = self.Config.BlockOffset
    if not BlockOffset then
        BlockOffset = new()
    end
    u138 = v11 * v12:Lerp(BlockOffset, SharedSprings.BlockSpring.Position) * v10
end
function createVM(p1) -- Line: 1349
    local Attachment, Handle, KeyParts, v1
    local Name = p1.Name
    local Viewmodel = p1.Config.Viewmodel
    if not Viewmodel then
        warn("[Viewmodel] Could not find viewmodel for weapon: " .. Name)
        return
    end
    local v2 = p1.Config.BarrelCount or 1
    local v3 = 1
    for i = 1, v2, v3 do
        KeyParts = Viewmodel:WaitForChild("KeyParts")
        if 1 >= i then
            v1 = ""
        else
            v1 = i
        end
        Handle = KeyParts:FindFirstChild("Barrel" .. v1)
        if not Handle then
            Handle = Viewmodel.KeyParts.Handle
        end
        if not (Handle:FindFirstChild("BarrelAttachment")) then
            Attachment = Instance.new("Attachment")
            Attachment.Name = "BarrelAttachment"
            Attachment.Parent = Handle
            for j, k in Handle:GetChildren() do
                if k:IsA("ParticleEmitter") then
                    k.Parent = Attachment
                elseif not (k:IsA("Light")) and k:IsA("Attachment") and k == Attachment then
                end
            end
        end
    end
    v2 = Viewmodel:Clone()
    v2.Name = Name
    local HumanoidRootPart = v2:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        warn("[Viewmodel]: Could not find HumanoidRootPart for weapon: " .. Name)
        return
    end
    local AnimationController = v2:FindFirstChildWhichIsA("AnimationController")
    if not AnimationController then
        AnimationController = Instance.new("AnimationController")
        AnimationController.Parent = v2
    end
    local Animator = AnimationController:FindFirstChildOfClass("Animator")
    if not Animator then
        Animator = Instance.new("Animator")
        Animator.Parent = AnimationController
    end
    for n, m in v2:QueryDescendants("BasePart") do
        m.CastShadow = false
    end
    return v2, HumanoidRootPart, Animator
end
function updateOffset(p1) -- Line: 1397
    p1.TotalOffset = CFrame.new()
    for k, v in pairs(p1.Offsets) do
        p1.TotalOffset = p1.TotalOffset * v
    end
end
function loadAnimations(p1, p2, p3) -- Line: 1406 -- upvalues: ShellSystem (val)
    local Janitor, u110, v1, v2, v3, v4, v5
    local v6 = {}
    u110, v5, v1 = p1, p3, p2
    for k, v in pairs(p3:GetChildren()) do
        if v:IsA("Animation") then
            local Config = u110.Weapon.Config
            v2 = v1:LoadAnimation(v)
            v3 = v.Name == "Idle"
            v2.Looped = v3
            u110.Janitor:Add(v2, "Destroy")
            Janitor = u110.Janitor
            v4 = v2.KeyframeReached:Connect(function(p1) -- Line: 1415 -- upvalues: Config (val), u110 (val), ShellSystem (upval)
                if Config.KeyFrameSounds[p1] then
                    local Sound = Instance.new("Sound")
                    local SoundId = Config.KeyFrameSounds[p1][1]
                    if not SoundId then
                        SoundId = Config.KeyFrameSounds[p1].SoundId
                    end
                    Sound.SoundId = "rbxassetid://" .. SoundId
                    local Volume = Config.KeyFrameSounds[p1][2]
                    if not Volume then
                        Volume = Config.KeyFrameSounds[p1].Volume
                    end
                    Sound.Volume = Volume
                    Sound.Parent = script
                    local SoundService = game:GetService("SoundService")
                    SoundService:PlayLocalSound(Sound)
                    game.Debris:AddItem(Sound, 10)
                end
                if Config.ShellOn and p1 == Config.ShellOn and u110.Weapon.NeedShell then
                    u110.Weapon.NeedShell = false
                    ShellSystem:Eject(u110)
                end
                if Config.OnKeyframeReached then
                    Config.OnKeyframeReached(p1, u110.Weapon)
                end
                if Config.CustomKF then
                    Config.CustomKF(p1, u110.Model, u110.Weapon.Config)
                end
            end)
            Janitor:Add(v4, "Disconnect")
            v6[v.Name] = v2
        end
    end
    if v6.Idle then
        v6.Idle:Play(0, 1, 1)
        v6.Idle.Priority = Enum.AnimationPriority.Idle
        v6.Idle.Looped = true
    else
        local v7
        if u110.Weapon.Config.IsMelee then
            v7 = v5.Swing1:Clone()
        elseif not u110.Weapon.Config.UsesLoadLoop then
            v7 = v5.Reload:Clone()
        else
            v7 = v5.LoadStart:Clone()
        end
        v7.Name = "Idle"
        local v8 = v1:LoadAnimation(v7)
        v8.Looped = true
        while true do
            task.wait()
            if 0 < v8.Length then
                break
            end
        end
        v8:Play(0, 1, 1)
        v8.TimePosition = v8.Length
        v8:AdjustSpeed(0)
        v6.Idle = v8
    end
    if v6.IdleLayer then
        v6.IdleLayer:Play(0, 1, 1)
    end
    return v6
end
function setupViewmodel(p1) -- Line: 1473 -- upvalues: Ignore (val), AttachmentSystem (val), DamageFalloffUtil (val), AnimatedTextures (val), ReplicatedStorage (val)
    local SurfaceGui, SurfaceGui_2, u3, v1, v2, v3
    u3, v1, v2 = createVM(p1.Weapon)
    p1.Model = u3
    p1.PrimaryPart = v1
    local KeyParts = u3:WaitForChild("KeyParts")
    local Barrel = KeyParts:FindFirstChild("Barrel")
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
    p1.Animator = v2
    u3.Parent = Ignore
    p1.Animations = loadAnimations(p1, v2, u3:WaitForChild("Animations"))
    p1.Animations.Idle.Priority = Enum.AnimationPriority.Core
    if p1.Weapon.Mods then
        AttachmentSystem.DressWeapon(u3.Name, p1.Weapon.Mods, p1.Weapon.Config.AttachmentNodeData, u3, function(a1, p2, p3) -- Line: 1499 -- upvalues: u3 (val), Ignore (upval), p1 (val), DamageFalloffUtil (upval)
            local Parent = u3.Parent
            u3.Parent = Ignore
            local v1 = nil
            if p3 then
                local SettingChanges
                v1 = require(p3).new(p2, p1.Weapon.Config, p1)
                if v1.SettingChanges then
                    local Handle, Lense, Shadow, Shadow_2, SurfaceGui, SurfaceGui_2, SurfaceGui_3, Weld, v2
                    SettingChanges = v1.SettingChanges
                    local v3 = nil
                    local v4 = nil
                    for i, j in SettingChanges, v3, v4 do
                        if i == "Aimpart" then
                            p1.Aimpart = j
                            Handle = p1.Model.KeyParts.Handle
                            v2 = j.CFrame:toObjectSpace(Handle.CFrame)
                            p1.Aimpart:BreakJoints()
                            Weld = Instance.new("Weld")
                            Weld.Name = Handle.Name .. ":" .. j.Name
                            Weld.Part0 = Handle
                            Weld.Part1 = j
                            Weld.C0 = CFrame.new()
                            Weld.C1 = v2
                            Weld.Parent = Handle
                        elseif i == "Lense" then
                            if p1.Weapon.Config.Lense then
                                Lense = p1.Model.KeyParts:WaitForChild("Lense")
                                SurfaceGui = Lense:FindFirstChildWhichIsA("SurfaceGui")
                                SurfaceGui.Enabled = false
                            end
                            if p1.Weapon.Config.Shadow and not v1.SettingChanges.Shadow then
                                p1.Weapon.Config.Shadow = false
                                Shadow = p1.Model.KeyParts:WaitForChild("Shadow")
                                SurfaceGui_2 = Shadow:FindFirstChildWhichIsA("SurfaceGui")
                                SurfaceGui_2.Enabled = false
                            end
                            v2 = j:GetAttribute("IsCircular") == true
                            p1.LenseIsCircular = v2
                            p1.Reticle = j:FindFirstChildWhichIsA("ImageLabel", true)
                        elseif i == "Shadow" then
                            p1.ShadowRing = j:FindFirstChild("Ring", true)
                            if p1.Weapon.Config.Shadow then
                                p1.Weapon.Config.Shadow = false
                                Shadow_2 = p1.Model.KeyParts:WaitForChild("Shadow")
                                SurfaceGui_3 = Shadow_2:FindFirstChildWhichIsA("SurfaceGui")
                                SurfaceGui_3.Enabled = false
                            end
                        elseif i == "BarrelAttachment" then
                            p1.BarrelAttachment = j
                        end
                        if i == "Damage" and p1.Weapon.Config.DamageDropoff and not v1.SettingChanges.DamageDropoff then
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
        SurfaceGui = p1.Weapon.Config.Lense:FindFirstChildWhichIsA("SurfaceGui")
        SurfaceGui.Enabled = true
        v3 = p1.Weapon.Config.Lense:GetAttribute("IsCircular") == true
        p1.LenseIsCircular = v3
        p1.Reticle = p1.Weapon.Config.Lense:FindFirstChildWhichIsA("ImageLabel", true)
    end
    if p1.Weapon.Config.Shadow == true then
        p1.Weapon.Config.Shadow = p1.Model.KeyParts:WaitForChild("Shadow")
        SurfaceGui_2 = p1.Weapon.Config.Shadow:FindFirstChildWhichIsA("SurfaceGui")
        SurfaceGui_2.Enabled = true
        p1.ShadowRing = p1.Weapon.Config.Shadow:FindFirstChildWhichIsA("ImageLabel", true)
    end
    if p1.Weapon.Config.MuzzleModule then
        v3 = ReplicatedStorage.common.SharedResources.MuzzleFlash[p1.Weapon.Config.MuzzleModule]
        local v4 = v3.Effects.MuzzleModuleFX:Clone()
        v4.Parent = p1.BarrelAttachment
        p1.MuzzleModule = require(v3)
    end
    p1.EjectionAttachment = p1.Model.KeyParts.Handle:FindFirstChild("BulletEjection")
    if p1.EjectionAttachment and not (p1.EjectionAttachment:IsA("Attachment")) then
        p1.EjectionAttachment = nil
    end
    u3.Parent = nil
    p1.ViewmodelLoaded = true
    p1.ConfigLoaded:Fire()
    p1:_resolveIdleAimCFrame()
end
function loadViewmodelPromise(p1) -- Line: 1603 -- upvalues: WepConfig (val)
    local v1 = WepConfig:StreamViewmodel(p1.Weapon.WeaponId)
    return v1:andThen(function(a1) -- Line: 1604 -- upvalues: p1 (val)
        p1.Weapon.Config.Viewmodel = a1
        if not p1.Weapon.IsDestroyed then
            setupViewmodel(p1)
        end
    end)
end
function Lerp(p1, p2, p3) -- Line: 1612
    return p1 * (1 - p3) + p2 * p3
end
return u183