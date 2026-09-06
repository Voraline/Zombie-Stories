local Character, Humanoid, PropertyChangedSignal, v1
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.common.Settings)
local peek = require(ReplicatedStorage.Packages.Fusion).peek
local BindableEvent = Instance.new("BindableEvent")
local u28 = os.clock()
local u29 = nil
local u30 = true
local u31 = 100
local u34 = os.clock() + 0.75
local u36 = os.clock()
local u37 = 0
local u38 = 1
local u39 = {}
local u40 = nil
local u41 = 0
local u42 = nil
local u44 = CFrame.new()
local u46 = CFrame.new()
local u47 = 0
local u52 = CFrame.new(0, -0.25, 0)
local u53 = false
local u54 = Vector3.new(0, 0, 0)
local u55 = nil
local u56 = nil
local u57 = nil
local u61 = nil
local u62 = nil
local u63 = nil
local u64 = nil
local u65 = nil
local u66 = nil
local u71 = CFrame.new(0, 1.5, 0)
require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local SkillTreeData = require(ReplicatedStorage.common.skillTree.SkillTreeData)
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local v2 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
local u114 = CFrame.new(0, 0, 0, -1, 0, 0, 0, -0.1097783, 0.993956029, 0, 0.993956029, 0.1097783)
local v3 = CFrame.new(0, 0, 1.25) * u114
local v4 = CFrame.new(0, 0, -1.5) * u114
local v5 = CFrame.new(0, -0.5, 1.25)
local v6 = v5 * CFrame.Angles(0, 3.141592653589793, 0)
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local u144 = {Normal = v2, NormalFP = v4, Slide = v3, Prone = v6}
local u145 = 5
local u146 = 5
local u147 = 10
local u148 = 0.25
local u150 = os.clock()
local common = game.ReplicatedStorage.common
local LocalPlayerUtils = script:WaitForChild("LocalPlayerUtils")
local PlayerMovementUtil = LocalPlayerUtils:WaitForChild("PlayerMovementUtil")
LocalPlayerUtils:WaitForChild("PlayerStateUtil")
local Shared = script.Parent.Parent:WaitForChild("Shared")
local CurrentCamera = workspace.CurrentCamera
local Resources = script:WaitForChild("Resources")
local LocalPlayer = Players.LocalPlayer
Resources:WaitForChild("AlignPosition")
local SharedSprings = require(Shared:WaitForChild("SharedSprings"))
local PhysBallUtil = require(LocalPlayerUtils:WaitForChild("PhysBallUtil"))
local CharacterAnimator = require(script.Parent.Parent.Utils:WaitForChild("CharacterAnimator"))
local ViewmodelManager = require(script.Parent:WaitForChild("ViewmodelManager"))
local AddStamina = nil
local u217 = nil
local function getTurkeyWalkSpeedRemaining() -- Line: 110 -- upvalues: LocalPlayer (val)
    local v1
    local Attribute = LocalPlayer:GetAttribute("TurkeyHuntWalkSpeedBoostExpires")
    if typeof(Attribute) ~= "number" then
        return 0
    end
    if not workspace.GetServerTimeNow then
        v1 = os.clock()
    else
        v1 = workspace:GetServerTimeNow()
    end
    return Attribute - v1
end
local u219 = 0
local u220 = false
local u221 = 0
local function GetSafeFirstPersonOffset(p1, p2) -- Line: 129 -- upvalues: u221 (ref), u220 (ref), u114 (val), u217 (ref), u219 (ref)
    local v1
    local v2 = os.clock()
    local v3 = v2 - u221
    local v4 = 0.1 < v3
    u221 = v2
    if not u220 then
        local Unit
        v1 = workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)
        if 0.3 >= v1.Magnitude then
            local v5 = p1.CFrame.LookVector * Vector3.new(1, 0, 1)
            if 0.01 >= v5.Magnitude then
                Unit = Vector3.new(0, 0, -1)
            else
                Unit = v5.Unit
            end
        else
            Unit = v1.Unit
        end
        local v6 = u217.CustomRayDirection(p1.Position + Unit * 0.5, -Unit * 3, true)
        local v7 = u217.CustomRayDirection(p1.Position, -p1.CFrame.LookVector * 3, true)
        local v8 = 3
        if v6.Instance then
            v8 = math.min(v8, v6.Distance - 0.5)
        end
        if v7.Instance then
            v8 = math.min(v8, v7.Distance)
        end
        local v9 = math.min(1.25, (math.max(0, v8 - 1)))
        if not v4 then
            u219 = u219 + (v9 - u219) * 0.03
        else
            u219 = v9
            u220 = false
        end
        if 1.24 <= u219 then
            u219 = 1.25
            u220 = true
        end
        local v10 = CFrame.new(0, 0, u219)
        return v10 * u114
    elseif not v4 then
        v1 = CFrame.new(0, 0, 1.25)
        return v1 * u114
    end
end
local PlayerHandler = require(common.PlayerHandler)
local Signal = require(common.Signal)
local u231 = Enum.RenderPriority.Character.Value + 1
local u232 = {
    PlayerVelocity = 0,
    PlayerVelocityDT = 0,
    character = nil,
    head = nil,
    hrp = nil,
    humanoid = require(LocalPlayerUtils:WaitForChild("HumanoidUtil")),
    PlayerMovementUtil = require(PlayerMovementUtil),
    States = PlayerHandler:WaitForPlayerState(LocalPlayer),
    CharacterChanged = BindableEvent.Event,
    StaminaChanged = Signal.new(),
    ThirdPersonChanged = Signal.new(),
    MovementEnabled = true,
    LastForceTeleportClock = nil,
    FocusEnabled = false,
    SprintPressed = false,
    CrouchPressed = false,
    PronePressed = false,
    RequestSlideJump = false,
    RequestVault = false,
    RequestThirdPerson = false,
}
if peek(Settings.Camera.ThirdPersonSide) ~= 2 then
    v1 = 1
else
    v1 = -1
end
u232.ThirdPersonSide = v1
Settings.SettingsChanged:Connect(function(p1) -- Line: 235 -- upvalues: u232 (val), peek (val), Settings (val)
    if p1 and p1[1] == "Camera" and p1[2] == "ThirdPersonSide" then
        local v1
        if peek(Settings.Camera.ThirdPersonSide) ~= 2 then
            v1 = 1
        else
            v1 = -1
        end
        u232.ThirdPersonSide = v1
    end
    if p1 and p1[1] == "Graphics" and p1[2] == "ProceduralAnimations" and u232.Animator then
        u232.Animator:SetIKEnabled(peek(Settings.Graphics.ProceduralAnimations))
    end
end)
function u232.HPUpdated(p1, p2) -- Line: 246 -- upvalues: u232 (val)
    u232.HP = p2
    u232.humanoid:hpUpdated(p2)
end
function u232.SetWalkSpeedOverride(p1, p2) -- Line: 251 -- upvalues: u232 (val)
    u232.WalkSpeedOverride = p2
end
function u232.GetWalkSpeed(p1) -- Line: 255
    return 13
end
function u232.GetWalkSpeedOverride(p1) -- Line: 259 -- upvalues: u232 (val)
    return u232.WalkSpeedOverride
end
local function correctedDelta(p1, p2) -- Line: 263
    return 1 - math.exp(-(p2 or 1) * p1)
end
function u232.InfiniteStamina(p1) -- Line: 267 -- upvalues: u145 (ref), u146 (ref), u147 (ref), u148 (ref)
    u145 = 0
    u146 = 0
    u147 = 0
    u148 = 0
    local SoundService = game:GetService("SoundService")
    SoundService:PlayLocalSound(workspace.Cola)
end
function u232.Init(p1) -- Line: 282 -- upvalues: u217 (ref), PlayerHandler (val), u232 (val), Fusion (val), SkillTreeData (val), AddStamina (ref), u42 (ref), LocalPlayer (val), BindableEvent (val), PhysBallUtil (val), SharedSprings (val), RunService (val), u231 (val), ViewmodelManager (val), u148 (ref), u31 (ref), u34 (ref), u150 (ref), u41 (ref), Resources (val), u40 (ref), GetSafeFirstPersonOffset (val), u144 (val), u46 (ref), u44 (ref), u56 (ref), u52 (val), u47 (ref), u53 (ref), u55 (ref), u54 (ref), u61 (ref), u64 (ref), u62 (ref), u63 (ref)
    local u3 = require("./CameraController")
    local u6 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/ClassMirror")
    u217 = require("../Utils/RaycastUtil")
    PlayerHandler.HealthChanged:Connect(function(p1, p2, p3) -- Line: 287 -- upvalues: u232 (upval), u3 (val), Fusion (upval), SkillTreeData (upval), AddStamina (upval), u6 (val), u42 (upval)
        u232:HPUpdated(p1)
        if 0 < p2 then
            u3.CameraShaker:ShakeOnce(7, 7, 0, 0.5, Vector3.new(), (Vector3.new(1, 1, 1)))
            local v1 = Fusion.peek(SkillTreeData.AdrenalineStamina) or 0
            if 0 < v1 then
                AddStamina(v1)
            end
            local LiveDamagePos = u6:GetLiveDamagePos(p3)
            if u232.CurrentWeapon and LiveDamagePos then
                local v2 = -(LiveDamagePos - u232.hrp.Position).unit
                local v3 = v2:Dot(u232.hrp.CFrame.lookVector)
                local v4 = v2:Dot(u232.hrp.CFrame.rightVector)
                u232.CurrentWeapon.Viewmodel:ApplyImpulse(CFrame.Angles(0.13962634015954636 * v3, -0.13962634015954636 * v4, -0.05235987755982989 * v4))
            end
        end
        if p1 <= 0 then
            u42 = true
            u232.CrouchPressed = false
            u232.RequestSlideJump = false
            u232.humanoid.HasLanded = true
            return
        end
        if u42 then
            u42 = false
            u232.CrouchPressed = false
            u232.RequestSlideJump = false
            u232.humanoid.HasLanded = true
            if not u232.PhysBall.chasis.Parent and u232.PhysBall.chasisLoaded and not u232.PhysBall.loadingChasis then
                PlayerRespawned()
            end
        end
    end)
    LocalPlayer.CharacterRemoving:Connect(function() -- Line: 332 -- upvalues: BindableEvent (upval)
        BindableEvent:Fire(nil)
    end)
    u232.PlayerMovementUtil:Init()
    u232.PhysBall = PhysBallUtil.new(game.Players.LocalPlayer)
    u232.humanoid:SetJumpPower(30)
    u232.humanoid.Landed:Connect(function() -- Line: 340 -- upvalues: SharedSprings (upval)
        SharedSprings.YawSpring.Position = SharedSprings.YawSpring.Position + 0.05
    end)
    u232.humanoid.Jumped:Connect(function() -- Line: 343 -- upvalues: SharedSprings (upval)
        SharedSprings.YawSpring.Position = SharedSprings.YawSpring.Position - 0.05
    end)
    RunService.Stepped:Connect(function(p1, p2) -- Line: 348 -- upvalues: u232 (upval)
        if u232.Animator and u232.character then
            u232.Animator:UpdateStepped(p2)
        end
    end)
    RunService:BindToRenderStep("LPC", u231, function(p1) -- Line: 354 -- upvalues: u232 (upval), ViewmodelManager (upval), Fusion (upval), SkillTreeData (upval), u148 (upval), LocalPlayer (upval), u31 (upval), u34 (upval), u150 (upval), u41 (upval), Resources (upval), u40 (upval), GetSafeFirstPersonOffset (upval), u144 (upval), u46 (upval), u217 (upval), u44 (upval), u56 (upval), u52 (upval), u47 (upval), u53 (upval), u55 (upval), u54 (upval), u61 (upval), u64 (upval), u62 (upval), u63 (upval)
        local character, v1, v2
        GetNewPlayerCharacter()
        if not u232.humanoid.Humanoid or not u232.character then
            return
        end
        StatesHandler()
        SlidingHandler(p1)
        VaultingHandler()
        local v3 = 1 - math.exp(-1 * (p1 * 10))
        local v4 = math.clamp(v3, 0.01, 1)
        if u232.Animator then
            u232.Animator:SetState(u232.States)
            u232.Animator:SetLocomotionSuspended(not u232.MovementEnabled)
            v2 = u232.CurrentWeapon ~= nil
            u232.Animator:SetWeaponEquipped(v2)
            if u232.CurrentWeapon then
                local Entry = ViewmodelManager:GetEntry(u232.CurrentWeapon)
                if Entry then
                    u232.Animator:SetArmControl(Entry.GrantedArms.Left, Entry.GrantedArms.Right)
                end
            end
            u232.Animator:UpdateRenderStepped(p1)
        end
        HandleHumanoid(v4)
        if not u232.States.Sprinting then
            v3 = LocalPlayer:GetAttribute("Skill_StaminaRegenMult") or 1
            v1 = 100 * (LocalPlayer:GetAttribute("Skill_StaminaMaxMult") or 1)
            if u31 < v1 and u34 < os.clock() and u150 < os.clock() then
                setStamina(u31 + v4 * 2 * v3, v1 / 100)
            end
        elseif not u232.States.Jogging then
            local v5
            v3 = Fusion.peek(SkillTreeData.DesperateSprintThreshold) or 0
            v1 = u232.States.HP or 100
            v2 = u232.States.MaxHP or 100
            if 0 >= v2 then
                v5 = 1
            else
                v5 = v1 / v2
            end
            if v3 <= 0 then
                DrainStamina(u148 * v4)
            elseif v3 >= v5 then
            end
        end
        if not u232.TPPressed then
            if u232.ThirdPerson and 0 < u41 then
                Resources.swapside:Play()
                if 0 >= u232.ThirdPersonSide then
                    u232.ThirdPersonSide = 1
                else
                    u232.ThirdPersonSide = -1
                end
            end
            u41 = 0
        else
            u41 = u41 + p1
            if 0.33 <= u41 then
                Resources.tp:Play()
                u41 = 0
                u232.TPPressed = false
                u232.RequestThirdPerson = not u232.RequestThirdPerson
            end
        end
        if not u232.RequestThirdPerson then
            updateThirdPerson(false)
            if u232.States.IsDead then
                u232.RequestThirdPerson = false
            end
        elseif not u232.States.IsDead then
            if not u232.CurrentWeapon then
                updateThirdPerson(true)
            elseif u232.CurrentWeapon.Config.AimFOVMultiplier and u232.CurrentWeapon.Config.AimFOVMultiplier <= 0.5 and u232.States.Aiming then
                updateThirdPerson(false)
            end
        end
        if u40 then
            local Proning, hrp, v6, v7, v8, v9, v10, v11
            if not u232.ThirdPerson then
                if u232.States.Proning then
                    v3 = "Prone"
                elseif not u232.States.Sliding then
                    v3 = "NormalFP"
                else
                    v3 = "Slide"
                end
                if u232.States.IsDowned then
                    v3 = "Normal"
                elseif not u232.States.IsDead then
                end
            elseif not u232.States.Proning then
                v3 = "Normal"
            else
                v3 = "Prone"
            end
            v2 = not u232.ThirdPerson
            if v3 ~= "NormalFP" then
                v1 = u144[v3]
            elseif u232.hrp then
                v1 = GetSafeFirstPersonOffset(u232.hrp, v2)
            end
            u46 = u46:Lerp(v1, v4)
            hrp = u232.hrp
            if u232.States.Proning then
                if not hrp then
                    u44 = u44:lerp(CFrame.new(), v4)
                elseif hrp.Parent then
                    v10 = hrp.CFrame.Position + Vector3.new(0, -5, 0)
                    v9 = u217.CustomRay(hrp.CFrame.Position, v10, true)
                    if not v9.Instance then
                        u44 = u44:lerp(CFrame.new(), v4)
                        if u56 then
                            u56.C0 = u56.C0:Lerp(u52, v4)
                        end
                    else
                        local Normal = v9.Normal
                        local Unit = Normal:Cross(hrp.CFrame.LookVector).Unit
                        local Unit_2 = Unit:Cross(Normal).Unit
                        v6 = CFrame.new(0, 0, 0, Unit.X, Normal.X, Unit_2.X, Unit.Y, Normal.Y, Unit_2.Y, Unit.Z, Normal.Z, Unit_2.Z)
                        v7 = hrp.CFrame.Rotation:ToObjectSpace(v6)
                        v8 = v7 * CFrame.Angles(0, -3.141592653589793, 0)
                        u44 = u44:lerp(v8, v4)
                        if u56 then
                            u56.C0 = u56.C0:Lerp(u52 * v7, v4)
                        end
                    end
                end
            elseif not u232.States.IsDowned then
            end
            v9 = u44 * u46
            if u232.ThirdPerson then
                u40.C0 = v9
            else
                local v12 = 0
                if u232.States.Proning then
                    v12 = 1
                elseif u232.States.Crouching then
                    v12 = 0.25
                end
                u47 = u47 + (v12 - u47) * v4
                v10 = math.abs(u47)
                if v10 < 0.01 then
                    u47 = 0
                end
                if not u232.States.Crouching then
                    if not u232.States.Sliding then
                        u40.C0 = v9 * CFrame.new(0, u47, 0)
                    else
                        u40.C0 = v9 * CFrame.new(0, 1, 0)
                    end
                elseif not u232.States.Sliding then
                    v11 = CFrame.new(0, u47, 0)
                    v10 = v11 * CFrame.Angles(-1.5707963267948966, 0, 0)
                    v11 = CFrame.new(0, 0, 1)
                    v6 = math.clamp((0.5 - u47) / 0.25, 0, 1)
                    u40.C0 = v9 * v10:Lerp(v11, v6)
                end
            end
            if hrp then
                hrp.Size = Vector3.new(2, 2, 1)
            end
            if hrp then
                character = u232.character
                if character then
                    character = u232.character:FindFirstChild("Torso")
                end
                if character then
                    character.CanCollide = false
                end
                Proning = u232.States.Proning
                if not Proning then
                    Proning = u232.States.Diving
                end
                if not Proning then
                    if not Proning and u53 then
                        u61()
                    end
                elseif u53 and u232.character then
                    for i, j in u232.character:GetChildren() do
                        if j:IsA("BasePart") and j.Name ~= "ProneCollider" and j.Name ~= "FPHeadCollider" and j.Name ~= "Vehicle" then
                            j.CanCollide = false
                        end
                    end
                    if not Proning then
                        u54 = Vector3.new(0, 0, 0)
                    elseif u55 and u55.Parent then
                        local v13
                        local Position = u55.Position
                        local Unit_3 = u232.hrp.CFrame.LookVector * Vector3.new(1, 0, 1)
                        if 0.01 < Unit_3.Magnitude then
                            Unit_3 = Unit_3.Unit
                        end
                        v7 = Vector3.new(0, 0, 0)
                        v8 = u217.CollisionRayDirection(Position, Unit_3 * 4)
                        if v8.Instance then
                            v13 = 4 - v8.Distance + 0.5
                            if 0 < v13 then
                                v7 = v7 - Unit_3 * v13
                            end
                        end
                        v13 = u217.CollisionRayDirection(Position, -Unit_3 * 4)
                        if v13.Instance then
                            local v14 = 4 - v13.Distance + 0.5
                            if 0 < v14 then
                                v7 = v7 + Unit_3 * v14
                            end
                        end
                        u54 = v7
                    end
                end
                v11 = not u232.ThirdPerson
                if v11 then
                    v11 = not Proning
                end
                if not v11 then
                    if not v11 and u64 then
                        u63()
                    end
                elseif not u64 then
                    u62()
                elseif not v11 and u64 then
                    u63()
                end
            end
        end
        u232.PlayerVelocityDT = u232.PlayerVelocityDT + u232.PlayerVelocity * p1
    end)
end
function u232.DrainStamina(p1, p2, p3) -- Line: 616 -- upvalues: LocalPlayer (val), u150 (ref)
    DrainStamina(p2)
    u150 = os.clock() + (p3 or 0) * (LocalPlayer:GetAttribute("Skill_StaminaCooldownMult") or 1)
end
function u232.GetStamina(p1) -- Line: 622 -- upvalues: u31 (ref)
    return u31
end
function u232.RestoreStamina(p1) -- Line: 628 -- upvalues: LocalPlayer (val), u34 (ref), u150 (ref)
    setStamina(100 * (LocalPlayer:GetAttribute("Skill_StaminaMaxMult") or 1))
    u34 = 0
    u150 = 0
end
function u232.UpdateInventory(p1, p2) -- Line: 634 -- upvalues: u39 (ref)
    RefreshWalkspeedChanges()
    u39 = p2
end
function u232.UpdateCurrentWeapon(p1) -- Line: 639
    RefreshWalkspeedChanges()
end
local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("TurkeyHuntWalkSpeedBoostExpires")
AttributeChangedSignal:Connect(function() -- Line: 643
    RefreshWalkspeedChanges()
end)
local AttributeChangedSignal_2 = LocalPlayer:GetAttributeChangedSignal("Skill_StaminaMaxMult")
AttributeChangedSignal_2:Connect(function() -- Line: 647 -- upvalues: LocalPlayer (val)
    local v1 = LocalPlayer:GetAttribute("Skill_StaminaMaxMult") or 1
    setStamina(100 * v1, v1)
end)
function u232.SetMovementEnabled(p1, p2) -- Line: 653 -- upvalues: u232 (val)
    u232.MovementEnabled = p2
end
function u232.FocusActivated(p1, p2) -- Line: 657 -- upvalues: u232 (val)
    u232.FocusEnabled = p2
end
function setStamina(p1, p2) -- Line: 662 -- upvalues: LocalPlayer (val), u31 (ref), u232 (val)
    local Attribute = p2
    if not Attribute then
        Attribute = LocalPlayer:GetAttribute("Skill_StaminaMaxMult")
        if not Attribute then
            Attribute = 1
        end
    end
    local v1 = math.clamp(p1, 0, 100 * Attribute)
    if v1 ~= u31 then
        u232.StaminaChanged:Fire(v1)
    end
    u31 = v1
end
function DrainStamina(p1) -- Line: 671 -- upvalues: u232 (val), LocalPlayer (val), u31 (ref), u34 (ref)
    local v1
    local v2 = p1 * (LocalPlayer:GetAttribute("Skill_StaminaCostMult") or 1)
    if not u232.States.IsFocused then
        v1 = 1
    elseif 0 >= p1 then
        v1 = 1
    else
        v1 = 0.5
    end
    setStamina(u31 - v2 * v1)
    if u31 < 0 then
        setStamina(0)
    end
    u34 = os.clock() + 0.75
end
function AddStamina(p1) -- Line: 682 -- upvalues: u31 (ref)
    setStamina(u31 + p1)
end
function Lerp(p1, p2, p3) -- Line: 686
    return p1 * (1 - p3) + p2 * p3
end
function PlayerRespawned() -- Line: 690 -- upvalues: u30 (ref), u232 (val), PhysBallUtil (val), u57 (ref), u56 (ref), u55 (ref), u53 (ref), u66 (ref), u65 (ref), u64 (ref)
    if u30 then
        u30 = false
    else
        if u232.PhysBall then
            u232.PhysBall:setActive(false)
            u232.PhysBall:Destroy()
        end
        u232.PhysBall = PhysBallUtil.new(game.Players.LocalPlayer)
    end
    u232.CrouchPressed = false
    u232.PronePressed = false
    u232.RequestSlideJump = false
    if u57 then
        u57:Disconnect()
        u57 = nil
    end
    if u56 then
        u56:Destroy()
        u56 = nil
    end
    if u55 then
        u55:Destroy()
        u55 = nil
    end
    u53 = false
    if u66 then
        u66:Disconnect()
        u66 = nil
    end
    if u65 then
        u65:Destroy()
        u65 = nil
    end
    if u64 then
        u64:Destroy()
        u64 = nil
    end
end
local function u357() -- Line: 732 -- upvalues: u232 (val), u55 (ref), u56 (ref), u52 (val), u57 (ref)
    local NoCollisionConstraint
    if not u232.hrp or u55 then
        return
    end
    u55 = Instance.new("Part")
    u55.Name = "ProneCollider"
    u55.Size = Vector3.new(2, 1, 1)
    u55.Transparency = 1
    u55.CanCollide = true
    u55.CanQuery = false
    u55.CanTouch = false
    u55.Massless = true
    u55.CollisionGroup = "Player"
    u55.Parent = u232.character
    u56 = Instance.new("Weld")
    u56.Part0 = u232.hrp
    u56.Part1 = u55
    u56.C0 = u52
    u56.Parent = u232.hrp
    local function addVehicleNoCollision(p1) -- Line: 753 -- upvalues: u55 (upval)
        if not u55 or not u55.Parent or u55:FindFirstChild("VehicleNoCollision") then
            return
        end
        local NoCollisionConstraint = Instance.new("NoCollisionConstraint")
        NoCollisionConstraint.Name = "VehicleNoCollision"
        NoCollisionConstraint.Part0 = u55
        NoCollisionConstraint.Part1 = p1
        NoCollisionConstraint.Parent = u55
    end
    local Vehicle = u232.character:FindFirstChild("Vehicle")
    if Vehicle and u55 and u55.Parent and not (u55:FindFirstChild("VehicleNoCollision")) then
        NoCollisionConstraint = Instance.new("NoCollisionConstraint")
        NoCollisionConstraint.Name = "VehicleNoCollision"
        NoCollisionConstraint.Part0 = u55
        NoCollisionConstraint.Part1 = Vehicle
        NoCollisionConstraint.Parent = u55
    end
    u57 = u232.character.ChildAdded:Connect(function(p1) -- Line: 772 -- upvalues: u55 (upval)
        if p1.Name ~= "Vehicle" or not (p1:IsA("BasePart")) or not u55 or not u55.Parent or u55:FindFirstChild("VehicleNoCollision") then
            return
        end
        local NoCollisionConstraint = Instance.new("NoCollisionConstraint")
        NoCollisionConstraint.Name = "VehicleNoCollision"
        NoCollisionConstraint.Part0 = u55
        NoCollisionConstraint.Part1 = p1
        NoCollisionConstraint.Parent = u55
    end)
end
local function u358() -- Line: 779 -- upvalues: u57 (ref), u56 (ref), u55 (ref)
    if u57 then
        u57:Disconnect()
        u57 = nil
    end
    if u56 then
        u56:Destroy()
        u56 = nil
    end
    if u55 then
        u55.CanCollide = false
        u55:Destroy()
        u55 = nil
    end
end
local function u359() -- Line: 796 -- upvalues: u232 (val), u357 (ref), u53 (ref)
    if not u232.character then
        return
    end
    for i, j in u232.character:GetChildren() do
        if j:IsA("BasePart") and j.Name ~= "ProneCollider" and j.Name ~= "Vehicle" then
            j.CanCollide = false
        end
    end
    u357()
    u53 = true
end
function u61() -- Line: 809 -- upvalues: u232 (val), u358 (ref), u53 (ref)
    if not u232.character then
        return
    end
    u358()
    if u232.hrp then
        u232.hrp.CanCollide = true
    end
    u53 = false
    if u232.head then
        u232.head.CanCollide = true
    end
end
function u62() -- Line: 823 -- upvalues: u232 (val), u64 (ref), u65 (ref), u71 (val), u66 (ref)
    local NoCollisionConstraint
    if not u232.hrp or u64 then
        return
    end
    u64 = Instance.new("Part")
    u64.Name = "FPHeadCollider"
    u64.Size = Vector3.new(2, 1, 1)
    u64.Transparency = 1
    u64.CanCollide = true
    u64.CanQuery = false
    u64.CanTouch = false
    u64.Massless = true
    u64.CollisionGroup = "Player"
    u64.Parent = u232.character
    u65 = Instance.new("Weld")
    u65.Part0 = u232.hrp
    u65.Part1 = u64
    u65.C0 = u71
    u65.Parent = u232.hrp
    local function addFPHeadVehicleNoCollision(p1) -- Line: 844 -- upvalues: u64 (upval)
        if not u64 or not u64.Parent or u64:FindFirstChild("FPHeadVehicleNoCollision") then
            return
        end
        local NoCollisionConstraint = Instance.new("NoCollisionConstraint")
        NoCollisionConstraint.Name = "FPHeadVehicleNoCollision"
        NoCollisionConstraint.Part0 = u64
        NoCollisionConstraint.Part1 = p1
        NoCollisionConstraint.Parent = u64
    end
    local Vehicle = u232.character:FindFirstChild("Vehicle")
    if Vehicle and u64 and u64.Parent and not (u64:FindFirstChild("FPHeadVehicleNoCollision")) then
        NoCollisionConstraint = Instance.new("NoCollisionConstraint")
        NoCollisionConstraint.Name = "FPHeadVehicleNoCollision"
        NoCollisionConstraint.Part0 = u64
        NoCollisionConstraint.Part1 = Vehicle
        NoCollisionConstraint.Parent = u64
    end
    u66 = u232.character.ChildAdded:Connect(function(p1) -- Line: 863 -- upvalues: u64 (upval)
        if p1.Name ~= "Vehicle" or not (p1:IsA("BasePart")) or not u64 or not u64.Parent or u64:FindFirstChild("FPHeadVehicleNoCollision") then
            return
        end
        local NoCollisionConstraint = Instance.new("NoCollisionConstraint")
        NoCollisionConstraint.Name = "FPHeadVehicleNoCollision"
        NoCollisionConstraint.Part0 = u64
        NoCollisionConstraint.Part1 = p1
        NoCollisionConstraint.Parent = u64
    end)
end
function u63() -- Line: 870 -- upvalues: u66 (ref), u65 (ref), u64 (ref)
    if u66 then
        u66:Disconnect()
        u66 = nil
    end
    if u65 then
        u65:Destroy()
        u65 = nil
    end
    if u64 then
        u64.CanCollide = false
        u64:Destroy()
        u64 = nil
    end
end
function GetNewPlayerCharacter() -- Line: 891 -- upvalues: u232 (val), BindableEvent (val), CharacterAnimator (val), u217 (ref), peek (val), Settings (val), u40 (ref)
    if not u232.character then
        if u232.character then
            u232.character:Destroy()
        end
        if u232.Animator then
            u232.Animator:Destroy()
            u232.Animator = nil
        end
        if not game.Players.LocalPlayer.Character then
            u232.hrp = nil
            u232.head = nil
            u232.character = nil
        elseif game.Players.LocalPlayer.Character.Parent then
            u232.character = game.Players.LocalPlayer.Character
            u232.hrp = u232.character:FindFirstChild("HumanoidRootPart")
            u232.head = u232.character:FindFirstChild("Head")
            BindableEvent:Fire(u232.character)
            PlayerRespawned()
            u232.Animator = CharacterAnimator.new(u232.character, true)
            if u232.Animator then
                u232.Animator:SetRaycastParams(u217:GetAltRaycastParams())
                u232.Animator:SetIKEnabled(peek(Settings.Graphics.ProceduralAnimations))
            end
        end
    elseif u232.character and u232.character.Parent ~= nil then
    end
    if not u232.hrp then
        if u232.character then
            u232.hrp = u232.character:FindFirstChild("HumanoidRootPart")
            u232.head = u232.character:FindFirstChild("Head")
        end
    elseif u232.hrp.Parent == u232.character then
    end
    if not u40 then
        if u232.character and u232.hrp then
            u232.hrp.CanCollide = true
            u40 = u232.hrp:FindFirstChild("RootJoint")
        end
    elseif u232.hrp and u40.Parent == u232.hrp then
    end
    if u232.hrp and u232.character then
        local Vehicle = u232.character:FindFirstChild("Vehicle")
        if Vehicle and not (u232.hrp:FindFirstChild("HRPVehicleNoCollision")) then
            local NoCollisionConstraint = Instance.new("NoCollisionConstraint")
            NoCollisionConstraint.Name = "HRPVehicleNoCollision"
            NoCollisionConstraint.Part0 = u232.hrp
            NoCollisionConstraint.Part1 = Vehicle
            NoCollisionConstraint.Parent = u232.hrp
        end
    end
end
function VaultingHandler() -- Line: 946 -- upvalues: u232 (val), CurrentCamera (val), u217 (ref), Resources (val)
    local v1
    if u232.humanoid.Humanoid.Jump ~= true or u232.Vaulted then
        if not u232.humanoid.Humanoid.Jump then
            u232.Vaulted = false
        end
        return
    end
    local v2 = u232.humanoid.Humanoid.MoveDirection:Dot(CurrentCamera.CFrame.LookVector)
    if 0.1 >= v2 or not u232.hrp or not u232.hrp.Parent then
        return
    end
    local v3 = nil
    local v4 = nil
    local v5 = nil
    local CFrame = u232.hrp.CFrame
    local v6 = CFrame.Position - Vector3.new(0, 2.5, 0)
    local v7 = u217.CustomRayDirection(v6, CFrame.LookVector * 3, true)
    if v7.Instance then
        v1 = math.acos((v7.Normal:Dot((Vector3.new(0, 1, 0)))))
        if 1.37 < v1 and v1 < 1.77 then
            v3 = true
        end
    end
    v1 = CFrame.Position - Vector3.new(0, 0, 0)
    local v8 = CFrame.LookVector * 3
    if u217.CustomRayDirection(v1, v8, true).Instance then
        v4 = true
    end
    local v9 = CFrame.Position + Vector3.new(0, 3, 0)
    local v10 = CFrame.LookVector * 4
    if u217.CustomRayDirection(v9, v10, true).Instance then
        v5 = true
    end
    if u232.States.Crouching or u232.States.Proning or not v3 then
        return
    end
    if not v4 then
        if u232.hrp:FindFirstChild("RootAttachment") then
            Resources.slide_in1:Play()
            u232.humanoid.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            u232.humanoid.Animations.Vault:Play()
            v10 = CFrame.LookVector + Vector3.new(0, 200, 0)
            u232.hrp:ApplyImpulse(v10)
            u232.Vaulted = true
            return
        end
        return
    end
    if v5 or not (u232.hrp:FindFirstChild("RootAttachment")) then
        return
    end
    Resources.slide_in1:Play()
    u232.humanoid.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    u232.humanoid.Animations.Vault:Play()
    v10 = CFrame.LookVector + Vector3.new(0, 200, 0)
    u232.hrp:ApplyImpulse(v10)
    u232.Vaulted = true
end
function SlidingHandler(p1) -- Line: 1001 -- upvalues: GameState (val), u232 (val), u31 (ref), u145 (ref), u29 (ref), u28 (ref), Resources (val), SharedSprings (val), u36 (ref), u147 (ref)
    local AssemblyLinearVelocity, Magnitude, v1
    if not GameState.Data.Variables.SlidingEnabled then
        return
    end
    local WaterSensor = u232.humanoid.WaterSensor
    if WaterSensor then
        WaterSensor = u232.humanoid.WaterSensor.TouchingSurface
    end
    if not u232.hrp then
        AssemblyLinearVelocity = 0
    else
        AssemblyLinearVelocity = u232.hrp.AssemblyLinearVelocity
    end
    if u232.States.Sliding then
        v1 = false
        local isGrounded = u232.PhysBall.isGrounded
        if isGrounded then
            u36 = os.clock() + 0.15
        elseif not isGrounded then
            isGrounded = os.clock() < u36
        end
        if u232.RequestSlideJump and not u29 then
            u232.RequestSlideJump = false
            if not u232.States.Sliding then
                u232.CrouchPressed = false
                v1 = true
            elseif u147 <= u31 and isGrounded then
                DrainStamina(u147)
                u232.CrouchPressed = false
                u29 = true
                u28 = os.clock() + 0.2
                u232.humanoid.Animations.Slide:Stop()
                Resources.crouch_out:Play()
                u232.PhysBall:jump()
            end
        end
        if u232.RequestCancel then
            u232.RequestCancel = false
            v1 = true
        end
        if not u232.States.Sliding then
            return
        else
            if u232.States.Crouching and isGrounded and u28 < os.clock() then
                u29 = false
                if not u232.humanoid.Animations.Slide.IsPlaying then
                    u232.humanoid.Animations.Slide:Play()
                end
            end
            Magnitude = u232.PhysBall.chasis.AssemblyLinearVelocity.Magnitude
            if WaterSensor then
                u232.States.Sliding = false
                u232.RequestCancel = false
                if u29 and not u232.States.Diving then
                    Resources.prone_dive_landing:Play()
                end
                u29 = false
            elseif u232.States.Crouching then
                if Magnitude >= 7 then
                    if not u232.States.Proning and not u232.States.Diving and not v1 then
                        if not u232.HP then
                            if u232.hrp then end
                        elseif u232.HP <= 0 then
                        end
                    end
                elseif isGrounded and u28 < os.clock() then
                end
            elseif u28 < os.clock() then
            end
            if u232.States.Sliding then
                local v2
                local v3 = (Magnitude - 7) / 7
                local slide_loop = Resources.slide_loop
                if not isGrounded then
                    v2 = 0
                else
                    v2 = math.clamp(v3, 0, 1)
                    if not v2 then
                        v2 = 0
                    end
                end
                slide_loop.Volume = v2
                Resources.slide_loop.PlaybackSpeed = math.clamp(v3, 0.5, 1)
                return
            elseif u232.PhysBall.isActive then
                u232.PhysBall:setActive(false)
                u232.humanoid.Animations.Slide:Stop()
                Resources.slide_loop:Stop()
                u29 = false
                return
            end
        end
    elseif not WaterSensor and not u232.States.Proning and u232.States.Crouching and u232.States.Sprinting and 10 < AssemblyLinearVelocity.Magnitude and u145 <= u31 then
        DrainStamina(u145)
        u232.States.Sliding = true
        u29 = false
        u232.RequestSlide = false
        u28 = os.clock() + 0.2
        Resources["slide_in" .. math.random(1, 2)]:Play()
        u232.humanoid.Animations.Slide:Play()
        SharedSprings.YawSpring.Position = SharedSprings.YawSpring.Position - 0.1
        v1 = AssemblyLinearVelocity - Vector3.new(0, AssemblyLinearVelocity.Y, 0)
        u232.PhysBall:setActive(true, 2)
        u232.PhysBall.chasis:ApplyImpulse(v1 * 1.5 + Vector3.new(0, -5, 0))
        Resources.slide_loop:Play()
        return
    end
end
function RefreshWalkspeedChanges() -- Line: 1118 -- upvalues: u37 (ref), u38 (ref), u39 (ref), u232 (val), LocalPlayer (val)
    local v1
    u37 = 0
    u38 = 1
    local v2 = u39
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if j and j.Config then
            if j ~= u232.CurrentWeapon then
                u37 = u37 + (j.Config.HolsteredWalkspeedChange or 0)
                u38 = u38 * (j.Config.HolsteredWalkspeedMultiplier or 1)
            else
                u37 = u37 + (j.Config.EquippedWalkspeedChange or 0)
                u38 = u38 * (j.Config.EquippedWalkspeedMultiplier or 1)
            end
        end
    end
    local EffectObjects = u232.States.StatusEffects.EffectObjects
    if EffectObjects then
        v3 = EffectObjects
        v4 = nil
        v1 = nil
        for k, n in v3, v4, v1 do
            if n.SpeedMult then
                u38 = u38 + n.SpeedMult
            end
        end
    end
    local Attribute = LocalPlayer:GetAttribute("TurkeyHuntWalkSpeedBoostExpires")
    if typeof(Attribute) ~= "number" then
        v3 = 0
    else
        if not workspace.GetServerTimeNow then
            v1 = os.clock()
        else
            v1 = workspace:GetServerTimeNow()
        end
        v3 = Attribute - v1
    end
    if 0 < v3 then
        u38 = u38 + 1
    end
end
local v7 = OverlapParams.new()
v7.CollisionGroup = "NPCCollision"
v7.RespectCanCollide = false
local function getSpeedMultiplier(p1) -- Line: 1157 -- upvalues: GameState (val)
    return 1 / (1 + 0.5 * p1 * GameState.Data.Variables.ZombieSlowdown)
end
function HandleHumanoid(p1) -- Line: 1161 -- upvalues: u232 (val), LocalPlayer (val), u37 (ref), u38 (ref), GameState (val), u29 (ref)
    local v1
    local Humanoid = u232.humanoid.Humanoid
    if not Humanoid then
        return
    end
    if u232.States.IsDowned then
        v1 = 3
    elseif u232.States.Crouching then
        v1 = 5
    elseif u232.States.Proning then
        v1 = 4
    elseif u232.States.Aiming then
        local CurrentWeapon = u232.CurrentWeapon
        if not CurrentWeapon then
            v1 = 9
        elseif CurrentWeapon.Config then
            v1 = 9 * (CurrentWeapon.Config.AimWalkSpeedMultiplier or 1)
        end
    elseif u232.States.Blocking then
        v1 = 5
    elseif not u232.States.Sprinting then
        v1 = 13
    else
        local v2
        if u232.States.Jogging then
            v2 = 15
        else
            v2 = 19
        end
        v1 = v2
    end
    local Attribute = LocalPlayer:GetAttribute("Skill_MoveSpeedMult")
    if typeof(Attribute) ~= "number" then
        Attribute = 1
    elseif Attribute > 0 then
    end
    local v3 = v1 + u37
    v1 = math.max(1, v3 * u38 * Attribute * GameState.Data.Variables.PlayerSpeed)
    local WalkSpeedOverride = u232.WalkSpeedOverride
    if not WalkSpeedOverride then
        WalkSpeedOverride = Lerp(Humanoid.WalkSpeed, v1, p1 / 2)
    end
    Humanoid.WalkSpeed = WalkSpeedOverride
    local v4 = if u232.States.Proning then -1.8 else 0
    if u232.States.Crouching then
        v4 = -1.5
    elseif not u232.States.Sliding then
    end
    if u232.States.IsDowned then
        v4 = -1.8
    end
    Humanoid.HipHeight = Lerp(Humanoid.HipHeight, v4, p1 * 0.5)
    if not Humanoid or u232.humanoid.HasLanded ~= true or Humanoid.SeatPart ~= nil or not u232.hrp or Humanoid.MoveDirection == Vector3.new() or 0.1 >= u232.PlayerMovementUtil.MoveVector.Magnitude or u232.States.Sliding or u29 or u232.PlayerMovementUtil.Diving then
        u232.PlayerVelocity = Lerp(u232.PlayerVelocity, 0, p1)
        return
    end
    v3 = u232.PlayerVelocity * 0.92 + (u232.hrp.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).magnitude * 0.075
    u232.PlayerVelocity = math.min(20, (math.max(v3, -20)))
end
function StatesHandler() -- Line: 1247 -- upvalues: u232 (val), CurrentCamera (val), u359 (ref), u217 (ref), u31 (ref), u146 (ref), Resources (val), u54 (ref)
    local Aiming, AssemblyLinearVelocity, Blocking, Crouch, DoCharging, Downed, Prone, States, v1, v2, v3, v4
    if not u232.CurrentWeapon then
        Aiming = false
    else
        Aiming = u232.CurrentWeapon.Aiming
    end
    local Humanoid = u232.humanoid.Humanoid
    local v5 = Humanoid.MoveDirection:Dot(CurrentCamera.CFrame.LookVector)
    if not u232.hrp then
        v2 = 0
    else
        v2 = Humanoid.MoveDirection:Dot(u232.hrp.CFrame.lookVector)
    end
    local IsDowned = u232.States.IsDowned
    if not IsDowned then
        IsDowned = u232.States.IsDead
    end
    if not u232.SprintPressed then
        v3 = false
    elseif 0.1 < u232.PlayerMovementUtil.Direction.Target.Magnitude and u232.hrp and u232.hrp.Parent and 5 < u232.hrp.AssemblyLinearVelocity.Magnitude and not u232.States.Sliding and not Aiming and not u232.PlayerMovementUtil.Diving and not u232.States.Proning and not u232.States.Crouching and not IsDowned and u232.MovementEnabled then
        v3 = true
    end
    if u232.PronePressed and not u232.States.Proning and not u232.States.Diving and u232.hrp and not IsDowned then
        u232.CrouchPressed = false
        u232.States.Proning = true
        u359()
        v4 = true
        if u232.hrp then
            local MoveDirection = u232.humanoid.Humanoid.MoveDirection
            if 0.1 < MoveDirection.Magnitude then
                local v6 = MoveDirection.Unit * 3
                if u217.CustomRayDirection(u232.hrp.Position, v6, true).Instance then
                    v4 = false
                end
            end
        end
        if not v4 then
            if v4 then
                Resources.prone_in:Play()
            end
        elseif v3 then
            if u146 <= u31 then
                DrainStamina(u146)
                Resources.prone_dive_start:Play()
                u232.humanoid:SetJumpPower(30)
                u232.humanoid.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                u232.States.Diving = true
                AssemblyLinearVelocity = u232.hrp.AssemblyLinearVelocity
                local v7 = AssemblyLinearVelocity - Vector3.new(0, AssemblyLinearVelocity.Y, 0)
                if u232.States.Sliding and u232.humanoid.HasLanded then
                    local AssemblyLinearVelocity_2 = u232.PhysBall.chasis.AssemblyLinearVelocity
                    v7 = AssemblyLinearVelocity_2 - Vector3.new(0, AssemblyLinearVelocity_2.Y, 0)
                end
                u232.humanoid.HasLanded = false
                u232.hrp:ApplyImpulse(v7 * 25)
            end
        elseif not u232.States.Sliding then
        end
    end
    if u232.States.Diving then
        if u232.humanoid.HasLanded then
            if u232.hrp then
                Resources.prone_dive_landing:Play()
            else
                u232.humanoid.HasLanded = true
            end
            u232.States.Diving = false
            u232.humanoid:SetJumpPower(30)
        elseif u232.hrp and not u232.humanoid.Climbing and not IsDowned then
        end
    end
    if u232.States.Diving then
        u232.PronePressed = true
        u232.CrouchPressed = false
    end
    if v3 and u232.States.Proning then
        v3 = false
    end
    if not u232.States.Proning then
        if Resources.prone_move.Playing then
            Resources.prone_move:Stop()
        elseif u232.humanoid.Animations.Prone.IsPlaying then
            u232.humanoid.Animations.Prone:Stop(0.0001)
        end
    elseif not u232.States.Diving then
        Prone = u232.humanoid.Animations.Prone
        if 0.5 >= v2 then
            v1 = -1
        else
            v1 = 1
        end
        Prone:AdjustSpeed(u232.PlayerVelocity * v1 / Humanoid.WalkSpeed)
        if not Prone.IsPlaying then
            Prone:Play(0.2, 1, 1)
        end
        if not u232.hrp then
            if Resources.prone_move.Playing and u232.hrp.AssemblyLinearVelocity.Magnitude < 3 then
                Prone:AdjustSpeed(1e-07)
                Resources.prone_move:Stop()
            end
        elseif 3 < u232.hrp.AssemblyLinearVelocity.Magnitude and not Resources.prone_move.Playing then
            Resources.prone_move:Play()
        end
    end
    if IsDowned then
        u232.CrouchPressed = false
    end
    if not u232.States.Proning then
        if u232.PronePressed then
            if u232.States.Proning and IsDowned then
                if u232.States.Proning then
                    if StanceLocked() then
                        u232.PronePressed = true
                        u232.CrouchPressed = false
                    else
                        u232.PronePressed = false
                        u232.States.Proning = false
                        if u232.hrp and 0.1 < u54.Magnitude then
                            u232.hrp.CFrame = u232.hrp.CFrame + u54
                        end
                    end
                end
                if not u232.States.Proning and not u232.States.Sliding and not u232.CrouchPressed then
                    Resources.prone_out:Play()
                end
            end
        elseif u232.States.Proning then
        end
    elseif not u232.States.Diving and u232.CrouchPressed then
    end
    if u232.States.Crouching and not u232.CrouchPressed and not u232.States.Proning and StanceLocked(3) then
        u232.CrouchPressed = true
    end
    if u232.States.Crouching then
        if u232.States.Crouching and not u232.CrouchPressed then
            Resources.crouch_out:Play()
        end
    elseif u232.CrouchPressed then
        Resources.crouch_in:Play()
    end
    if not u232.States.Crouching then
        if u232.humanoid.Animations.Crouch.IsPlaying then
            u232.humanoid.Animations.Crouch:Stop()
        end
    elseif not u232.States.Diving and not IsDowned then
        Crouch = u232.humanoid.Animations.Crouch
        if 0.5 >= v2 then
            v1 = -1
        else
            v1 = 1
        end
        Crouch:AdjustSpeed(u232.PlayerVelocity * v1 / Humanoid.WalkSpeed)
        if not Crouch.IsPlaying then
            Crouch:Play()
        end
    end
    if u232.States.IsDowned then
        Downed = u232.humanoid.Animations.Downed
        if 0.5 >= v2 then
            v1 = -1
        else
            v1 = 1
        end
        Downed:AdjustSpeed(-u232.PlayerVelocity * v1 / Humanoid.WalkSpeed)
        if not Downed.IsPlaying then
            Downed:Play()
        end
    elseif u232.humanoid.Animations.Downed.IsPlaying then
        u232.humanoid.Animations.Downed:Stop()
    end
    if not u232.States.IsDead then
        if u232.humanoid.Animations.Death.IsPlaying then
            u232.humanoid.Animations.Death:Stop()
        end
    elseif not u232.humanoid.Animations.Death.IsPlaying then
        u232.humanoid.Animations.Death.Priority = Enum.AnimationPriority.Action4
        u232.humanoid.Animations.Death:Play()
    end
    u232.States.Sprinting = v3
    v4 = not u232.ThirdPerson
    if v4 then
        v4 = if v5 < -0.1 then not u232.FocusEnabled else false
    end
    local v8 = v3
    if v8 then
        v8 = if u31 > 0 then v4 else true
    end
    u232.States.Jogging = v8
    u232.States.Crouching = u232.CrouchPressed
    u232.States.Aiming = Aiming
    v8 = not (not u232.CurrentWeapon)
    u232.States.EquippedGun = v8
    States = u232.States
    if not u232.CurrentWeapon then
        Blocking = false
    else
        Blocking = u232.CurrentWeapon.Blocking
    end
    States.Blocking = Blocking
    local States_2 = u232.States
    if not u232.CurrentWeapon then
        DoCharging = false
    else
        DoCharging = u232.CurrentWeapon.DoCharging
        if not DoCharging then
            DoCharging = false
        end
    end
    States_2.Charging = DoCharging
end
function updateThirdPerson(p1) -- Line: 1495 -- upvalues: u232 (val)
    u232.ThirdPerson = p1
    if p1 ~= u232.ThirdPerson then
        u232.ThirdPersonChanged:Fire(p1)
    end
end
function StanceLocked(p1) -- Line: 1503 -- upvalues: u232 (val), u217 (ref)
    if not u232.hrp then
        return
    end
    local CFrame = u232.hrp.CFrame
    local v1 = p1
    if not v1 then
        if not u232.CrouchPressed then
            v1 = 4
        else
            v1 = 2
        end
    end
    local v2 = CFrame.UpVector * v1
    if u217.CustomRayDirection(CFrame.Position, v2, true).Instance then
        return true
    end
    local v3 = CFrame.Position + CFrame.LookVector * 1
    local v4 = CFrame.UpVector * v1
    if u217.CustomRayDirection(v3, v4, true).Instance then
        return true
    end
    v3 = CFrame.Position + CFrame.LookVector * -1
    v4 = CFrame.UpVector * v1
    if u217.CustomRayDirection(v3, v4, true).Instance then
        return true
    end
end
local function setupJumpChanged(p1) -- Line: 1526 -- upvalues: u232 (val)
    local PropertyChangedSignal = p1:GetPropertyChangedSignal("Jump")
    PropertyChangedSignal:Connect(function() -- Line: 1527 -- upvalues: u232 (upval), p1 (val)
        if not u232.MovementEnabled then
            p1.Jump = false
        end
    end)
end
Character = game.Players.LocalPlayer.Character
if Character then
    Humanoid = Character:WaitForChild("Humanoid")
    PropertyChangedSignal = Humanoid:GetPropertyChangedSignal("Jump")
    PropertyChangedSignal:Connect(function() -- Line: 1527 -- upvalues: u232 (val), Humanoid (val)
        if not u232.MovementEnabled then
            Humanoid.Jump = false
        end
    end)
end
game.Players.LocalPlayer.CharacterAdded:Connect(function(p1) -- Line: 1538 -- upvalues: u232 (val)
    local Humanoid = p1:WaitForChild("Humanoid")
    local PropertyChangedSignal = Humanoid:GetPropertyChangedSignal("Jump")
    PropertyChangedSignal:Connect(function() -- Line: 1527 -- upvalues: u232 (upval), Humanoid (val)
        if not u232.MovementEnabled then
            Humanoid.Jump = false
        end
    end)
end)
return u232