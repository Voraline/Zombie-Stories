local UserGameSettings = UserSettings():GetService("UserGameSettings")
local ContextActionService = game:GetService("ContextActionService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Resources = script.Resources
workspace:WaitForChild("Ignore")
ReplicatedStorage.common:WaitForChild("Remotes")
local CameraUtils = script:WaitForChild("CameraUtils")
local Parent = script.Parent
Parent.Parent:WaitForChild("Classes")
local Utils = Parent.Parent:WaitForChild("Utils")
local Shared = Parent.Parent:WaitForChild("Shared")
local RedEvents = game.ReplicatedStorage.common.RedEvents
local SpringUtil = require(Utils:WaitForChild("SpringUtil"))
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local SkillTreeData = require(ReplicatedStorage.common.skillTree.SkillTreeData)
local SkillTreeMain = require(ReplicatedStorage.common.skillTree.SkillTreeMain)
local unseatCharacter = require(ReplicatedStorage.common.ZS_Shared.Util.unseatCharacter)
local u104 = CFrame.new()
local u107 = SpringUtil.new(0)
u107.Target = 0
u107.Speed = 15
u107.Damper = 0.9
local v1 = SpringUtil.new(0)
v1.Target = 0
v1.Speed = 12
v1.Damper = 0.9
local v2 = SpringUtil.new((Vector3.new()))
v2.Target = Vector3.new(0.009999999776482582, 0.009999999776482582, 0.009999999776482582)
v2.Speed = 12
v2.Damper = 0.9
local u124 = 0
local u125 = nil
CFrame.new()
local u128 = {}
local u129 = {}
local u131 = CFrame.new()
local u132 = nil
local u133 = nil
local u135 = CFrame.new()
local u137 = CFrame.new()
local u139 = CFrame.new()
local u141 = CFrame.new()
local u142 = {}
local u143 = false
local u144 = {}
local u145 = nil
local u146 = 0

local function IsInThumbstickArea(p1) -- Line: 91 -- upvalues: LocalPlayer (val)
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local TouchGui = PlayerGui
    if TouchGui then
        TouchGui = PlayerGui:FindFirstChild("TouchGui")
    end
    local TouchControlFrame = TouchGui
    if TouchControlFrame then
        TouchControlFrame = TouchGui:FindFirstChild("TouchControlFrame")
    end
    if not TouchControlFrame then
        return false
    end
    local ThumbstickFrame = TouchControlFrame:FindFirstChild("ThumbstickFrame")
    if ThumbstickFrame and ThumbstickFrame.Visible then
        local AbsolutePosition = ThumbstickFrame.AbsolutePosition
        local v1 = AbsolutePosition + ThumbstickFrame.AbsoluteSize
        local X = p1.X
        if AbsolutePosition.X <= X then
            local Y = p1.Y
            if AbsolutePosition.Y <= Y and p1.X <= v1.X and p1.Y <= v1.Y then
                return true
            end
        end
    end
    local DynamicThumbstickFrame = TouchControlFrame:FindFirstChild("DynamicThumbstickFrame")
    if DynamicThumbstickFrame and DynamicThumbstickFrame.Visible then
        local AbsolutePosition_2 = DynamicThumbstickFrame.AbsolutePosition
        local v2 = AbsolutePosition_2 + DynamicThumbstickFrame.AbsoluteSize
        local X_2 = p1.X
        if AbsolutePosition_2.X <= X_2 then
            local Y_2 = p1.Y
            if AbsolutePosition_2.Y <= Y_2 and p1.X <= v2.X and p1.Y <= v2.Y then
                return true
            end
        end
    end
    return false
end

local u148 = 1
local u150 = CFrame.new()
CFrame.new()
CFrame.new()
local u155 = nil
local u156 = nil
local v3 = Vector2.new(1, 0.77) * 0.06981317007977318
local RecoilUtil = require(CameraUtils:WaitForChild("RecoilUtil"))
local TransparencyUtil = require(CameraUtils:WaitForChild("TransparencyUtil"))
local LocalPlayerController = require(Parent:WaitForChild("LocalPlayerController"))
local BobbingUtil = require(Utils:WaitForChild("BobbingUtil"))
local SharedSprings = require(Shared:WaitForChild("SharedSprings"))
local RaycastUtil = require(Utils:WaitForChild("RaycastUtil"))
local CursorRecoilUtil = require(Utils:WaitForChild("CursorRecoilUtil"))
local CameraShaker = require(CameraUtils:WaitForChild("CameraShaker"))
local u212 = require("@game/ReplicatedStorage/common/Settings")
local OutfitMorph = require(ReplicatedStorage.common:WaitForChild("OutfitMorph"))
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local peek = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local CameraShakePresets = require(Parent.CameraController.CameraUtils.CameraShaker.CameraShakePresets)
local CameraEvent = require(RedEvents.Framework.CameraEvent)
local CameraShakeEvent = require(RedEvents.Framework.CameraShakeEvent)
local u250 = {}
local u251 = 0
local u252 = {}
local u253 = 0
local u254 = {}
local u255 = 0
local u256 = false
local u257 = {}
local u262 = Vector2.new(0, 0)
local u266 = Vector2.new(0, 0)
local u281 = CFrame.new(3, 1.5, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1)
local u286 = CFrame.new(3, 1.5, 3)
local u287 = u281
local u288 = {}
local u289 = {}
local u290 = {}
local v4 = OutfitMorph.VfxTagFor(LocalPlayer)
local u294 = 0
local u295 = false

local function getMaxZoom() -- Line: 185 -- upvalues: peek (val), u212 (val), GameState (val)
    local v1 = peek(u212.Camera.MaxCameraDistance)
    if GameState.Data.IsLobby then
        return v1 * 1.3
    end
    return v1
end

local u297 = 0
local u298 = 0
local u299 = false
local u302 = Enum.RenderPriority.Camera.Value + 1
local u307 = CFrame.new(0, 1.5, 0)

local function LerpAngle(p1, p2, p3) -- Line: 209
    return p1 + ((p2 - p1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * p3
end

local function GetYAngle(p1) -- Line: 215
    local v1 = -p1.LookVector.X
    local v2 = -p1.LookVector.Z
    return (math.atan2(v1, v2))
end

local function UpdateDirectionCircular(p1, p2, p3, p4) -- Line: 221
    local Z = p1.Z
    local X = p1.X
    local v1 = math.atan2(Z, X)
    local Z_2 = p2.Z
    local X_2 = p2.X
    local v2 = (v1 + ((math.atan2(Z_2, X_2) - v1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * p3 * p4 + 6.283185307179586) % 6.283185307179586
    local v3 = math.cos(v2)
    local v4 = math.sin(v2)
    return (Vector3.new(v3, 0, v4))
end

local u311 = Vector3.new(0, 0, 1)
local u312 = {X = 0, Y = 0, FOV = 70, Enabled = false}
u312.AimCFrame = CFrame.new()
u312.CameraShaker = CameraShaker.new(Enum.RenderPriority.Camera.Value, "shakeOne")
u312.CameraShakerAlt = CameraShaker.new(Enum.RenderPriority.Camera.Value, "shakeTwo")

function u312.Init(p1) -- Line: 259 -- upvalues: TransparencyUtil (val), Parent (val), u297 (ref)
    TransparencyUtil:Init()
    MakeConnections()
    task.defer(function() -- Line: 264 -- upvalues: Parent (upval), u297 (upval)
        local v1 = require
        local WeaponController = Parent:WaitForChild("WeaponController")
        ;(v1(WeaponController)).GunFired:Connect(function() -- Line: 266 -- upvalues: u297 (upval)
            u297 = os.clock()
        end)
    end)
end

function u312.GetCameraShakeCF(p1) -- Line: 272 -- upvalues: u137 (ref)
    return u137
end

function u312.GetCameraBoneAngle(p1) -- Line: 276 -- upvalues: u135 (ref)
    return u135
end

function u312.NewRecoil(p1, p2) -- Line: 280 -- upvalues: u129 (val), RecoilUtil (val)
    u129[p2] = (RecoilUtil.new(p2))
    return u129[p2]
end

function u312.SetCameraBone(p1, p2, p3) -- Line: 285 -- upvalues: u132 (ref), u133 (ref)
    u132 = p2
    u133 = p3
end

function u312.ForceTeleport(p1, p2) -- Line: 290
    -- upvalues: unseatCharacter (val), LocalPlayerController (val), u142 (val)
    unseatCharacter(LocalPlayerController.character)
    LocalPlayerController.LastForceTeleportClock = os.clock()
    local v1 = u142
    table.insert(v1, p2)
end

function u312.GetZoomDistance(p1) -- Line: 297 -- upvalues: u294 (ref)
    return u294
end

function u312.GetMaxZoomDistance(p1) -- Line: 301 -- upvalues: peek (val), u212 (val), GameState (val)
    local v1 = peek(u212.Camera.MaxCameraDistance)
    if GameState.Data.IsLobby then
        return v1 * 1.3
    end
    return v1
end

function u312.SetZoomDistance(p1, p2) -- Line: 305
    -- upvalues: u294 (ref), peek (val), u212 (val), GameState (val), LocalPlayerController (val)
    local v1
    local v2 = peek(u212.Camera.MaxCameraDistance)
    if not GameState.Data.IsLobby then
        v1 = v2
    else
        v1 = v2 * 1.3
    end
    u294 = math.clamp(p2, 0, v1)
    local v3 = LocalPlayerController
    local v4 = 1 <= u294
    v3.RequestThirdPerson = v4
end

function u312.SetMouseUnlocked(p1, p2, p3) -- Line: 310 -- upvalues: u252 (val), u253 (ref)
    local v1 = table.find(u252, p2)
    if p3 and not v1 then
        local v2 = u252
        table.insert(v2, p2)
        u253 = u253 + 1
        return
    end
    if not p3 and v1 then
        table.remove(u252, v1)
        u253 = u253 - 1
    end
end

function u312.SetMouseLockPosition(p1, p2, p3) -- Line: 321 -- upvalues: u254 (val), u255 (ref)
    local v1 = table.find(u254, p2)
    if p3 and not v1 then
        local v2 = u254
        table.insert(v2, p2)
        u255 = u255 + 1
        return
    end
    if not p3 and v1 then
        table.remove(u254, v1)
        u255 = u255 - 1
    end
end

function u312.MouseIconEnabled(p1, p2, p3, p4) -- Line: 332
    -- upvalues: u250 (val), u257 (val), UserInputService (val), u251 (ref)
    local v1 = table.find(u250, p2)
    if p3 and not v1 then
        u257[p2] = p4
        UserInputService.MouseIcon = p4 or ""
        local v2 = u250
        table.insert(v2, p2)
        u251 = u251 + 1
        return
    end
    if not p3 and v1 then
        table.remove(u250, v1)
        u251 = u251 - 1
        local v3 = u257[p2]
        if v3 ~= nil and UserInputService.MouseIcon == v3 then
            local v4, v5
            local v6 = false
            for i = #u250, 1, -1 do
                v4 = u250
                v5 = v4[i]
                v4 = u257[v5]
                if v4 then
                    UserInputService.MouseIcon = v4
                    v6 = true
                    break
                end
            end
            if not v6 then
                UserInputService.MouseIcon = ""
            end
        end
    end
end

function u312.SetMagnificationSensitivity(p1, p2) -- Line: 364 -- upvalues: u148 (ref)
    u148 = p2
end

function u312.GetMagnificationSensitivity(p1) -- Line: 368 -- upvalues: LocalPlayerController (val), u148 (ref)
    local CurrentWeapon = LocalPlayerController.CurrentWeapon
    if CurrentWeapon and CurrentWeapon.Aiming then
        return u148
    end
    return 1
end

function u312.GetSensitivity(p1) -- Line: 373 -- upvalues: LocalPlayerController (val), peek (val), u212 (val)
    local CurrentWeapon = LocalPlayerController.CurrentWeapon
    if CurrentWeapon and CurrentWeapon.Aiming then
        return peek(u212.Controls.AimingSensitivity)
    end
    return peek(u212.Controls.Sensitivity)
end

function u312.ShouldGunRest(p1) -- Line: 385 -- upvalues: LocalPlayerController (val), u297 (ref), u298 (ref)
    if not LocalPlayerController.ThirdPerson then
        return false
    end
    local CurrentWeapon = LocalPlayerController.CurrentWeapon
    if not CurrentWeapon or CurrentWeapon.Aiming then
        return false
    end
    local v1 = os.clock()
    local v2 = v1 - u297 < 2
    local v3 = v1 - u298 < 2
    local v4 = not v2 and not v3
    return v4
end

local function adjustTouchPitchSensitivity(p1) -- Line: 409
    local CurrentCamera = workspace.CurrentCamera
    if not CurrentCamera then
        return p1
    end
    local v1 = CurrentCamera.CFrame:ToEulerAnglesYXZ()
    if 0 <= p1.Y * v1 then
        return p1
    end
    local v2 = (1 - ((math.abs(v1)) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25
    return Vector2.new(1, v2) * p1
end

function u312.LookAt(p1, p2) -- Line: 435 -- upvalues: u312 (val)
    local v1
    if p2 ~= "s" then
        v1 = p2
    else
        v1 = nil
    end
    u312.Tracking = v1
    u312.TrackingEnd = os.clock() + 1
end

RunService.Heartbeat:Connect(function(p1) -- Line: 445
    -- upvalues: LocalPlayerController (val), u143 (ref), u312 (val), u253 (ref), UserInputService (val), u251 (ref)
    -- upvalues: u256 (ref), u255 (ref), SkillTreeMain (val), Fusion (val)
    local v1, v2
    local ThirdPerson = LocalPlayerController.ThirdPerson
    if ThirdPerson then
        ThirdPerson = not LocalPlayerController.CurrentWeapon
    end
    local v3 = ThirdPerson
    if v3 then
        v3 = u143
    end
    if not u312.Enabled then
        if 0 < u253 then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            v1 = UserInputService
            v2 = 0 < u251
            v1.MouseIconEnabled = v2
            u256 = true
            return
        end
        if u256 then
            local Default
            v1 = UserInputService
            if not ThirdPerson then
                Default = Enum.MouseBehavior.LockCenter
            else
                Default = Enum.MouseBehavior.Default
            end
            v1.MouseBehavior = Default
            v1 = UserInputService
            v2 = true
            if not (0 < u251) then
                v2 = ThirdPerson
            end
            v1.MouseIconEnabled = v2
            u256 = false
        end
        return
    end
    u256 = false
    if 0 < u255 then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
    elseif not v3 then
        if not (u253 <= 0) or ThirdPerson then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        else
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        end
    elseif not SkillTreeMain.isSkillTreeOpen or not Fusion.peek(SkillTreeMain.isSkillTreeOpen) then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
    elseif not (u253 <= 0) or ThirdPerson then
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    else
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    end
    v1 = UserInputService
    v2 = true
    if not (0 < u251) then
        v2 = ThirdPerson
    end
    v1.MouseIconEnabled = v2
end)

function u312.SetEnabled(p1, p2) -- Line: 483
    -- upvalues: u312 (val), RunService (val), u302 (val), LocalPlayerController (val), CurrentCamera (val), u148 (ref)
    -- upvalues: peek (val), u212 (val), u262 (ref), UserGameSettings (val), u266 (ref), u137 (ref), u139 (ref)
    -- upvalues: CursorRecoilUtil (val), BobbingUtil (val), u124 (ref), u107 (val), u131 (ref), u135 (ref), u141 (ref)
    -- upvalues: u104 (ref), u295 (ref), SharedSprings (val), u311 (ref), TransparencyUtil (val), u290 (val), u287 (ref)
    -- upvalues: RaycastUtil (val), u307 (val), u155 (ref), u156 (ref), Resources (val), u142 (val), u299 (ref)
    -- upvalues: u298 (ref), u297 (ref), u150 (ref), u125 (ref), u294 (ref), GameState (val), u286 (val), u281 (val)
    u312.Enabled = p2
    if not p2 then
        RunService:UnbindFromRenderStep("CameraController")
        return
    end
    local v1 = RunService
    local v2 = u302
    v1:BindToRenderStep("CameraController", v2, function(p1) -- Line: 486
        -- upvalues: LocalPlayerController (upval), CurrentCamera (upval), u148 (upval), peek (upval), u212 (upval)
        -- upvalues: u262 (upval), UserGameSettings (upval), u266 (upval), u312 (upval), u137 (upval), u139 (upval)
        -- upvalues: CursorRecoilUtil (upval), BobbingUtil (upval), u124 (upval), u107 (upval), u131 (upval)
        -- upvalues: u135 (upval), u141 (upval), u104 (upval), u295 (upval), SharedSprings (upval), u311 (upval)
        -- upvalues: TransparencyUtil (upval), u290 (upval), u287 (upval), RaycastUtil (upval), u307 (upval)
        -- upvalues: u155 (upval), u156 (upval), Resources (upval), u142 (upval), u299 (upval), u298 (upval)
        -- upvalues: u297 (upval), u150 (upval), u125 (upval), u294 (upval), GameState (upval), u286 (upval)
        -- upvalues: u281 (upval)
        local v1
        if not LocalPlayerController.States.IsDead then
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
        end
        local CurrentWeapon = LocalPlayerController.CurrentWeapon
        local v2 = 1
        if not CurrentWeapon or not CurrentWeapon.Aiming then
            v1 = peek(u212.Controls.Sensitivity)
        else
            v2 = u148
            v1 = peek(u212.Controls.AimingSensitivity)
        end
        local v3 = u262
        local v4 = v3.X * UserGameSettings.MouseSensitivity * 9 + u266.X * v2
        local v5 = v3.Y * UserGameSettings.MouseSensitivity * 9
        local v6 = (v5 + u266.Y) * v2 * (UserGameSettings:GetCameraYInvertValue())
        v4 = v4 * v1
        v6 = v6 * v1
        u266 = Vector2.new()

        local function normalizeAngle(p1) -- Line: 512
            return (p1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
        end

        u312.X = ((u312.X - v4 / 150 * 1) % 6.283185307179586 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
        local v7 = u312
        local v8 = u312.Y - v6 / 150 * 1
        v7.Y = math.clamp(v8, -1.4, 1.4)
        if LocalPlayerController.humanoid.Humanoid then
            LocalPlayerController.humanoid.Humanoid.AutoRotate = false
        end
        if LocalPlayerController.character
            and LocalPlayerController.hrp
            and LocalPlayerController.PhysBall._fullyInitialized then
            local v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25
            v5 = p1 * 10
            v7 = math.clamp(v5, 0.01, 1)
            local Humanoid = LocalPlayerController.humanoid.Humanoid
            local Sit = Humanoid
            if Sit then
                Sit = Humanoid.Sit
                if not Sit then
                    Sit = Humanoid.SeatPart ~= nil
                end
            end
            local Position = LocalPlayerController.hrp.Position
            if LocalPlayerController.PhysBall.isActive and not Sit then
                Position = LocalPlayerController.PhysBall.chasis.CFrame.p
            end
            CalculateAngles(Position, v7)
            u137 = u312.CameraShaker:Update(p1)
            u139 = u312.CameraShakerAlt:Update(p1)
            local v26 = CursorRecoilUtil
            local Aiming = CurrentWeapon
            if Aiming then
                Aiming = CurrentWeapon.Aiming
            end
            v26:Update(p1, Aiming)
            local v27 = BobbingUtil.cameraBobCF * CFrame.Angles(u124, 0, u107.Position) * u131 * u137
            local v28 = u139
            if not v28 then
                v28 = CFrame.new()
            end
            v26 = v27 * v28
            v27 = u135 * CFrame.new() * u141
            v28 = u104
            if not LocalPlayerController.States.Proning then
                v9 = CFrame.new()
            else
                v9 = CFrame.new(0, -1, 0)
                if not v9 then
                    v9 = CFrame.new()
                end
            end
            u104 = v28:Lerp(v9, v7)
            if not LocalPlayerController.ThirdPerson or not LocalPlayerController.hrp then
                v28 = 0
            else
                v28 = 1
            end
            local v29 = v28 == 1
            v9 = v29 ~= u295
            SharedSprings.TPSpring.Target = v28
            if v9 then
                SharedSprings.TPSpring.Position = v28
                if v29 then
                    local LookVector = CFrame.Angles(0, u312.X, 0).LookVector
                    local X = LookVector.X
                    local Z = LookVector.Z
                    u311 = Vector3.new(X, 0, Z).Unit
                end
            end
            u295 = v29
            local v30 = false
            if not (0.05 < SharedSprings.TPSpring.Position) then
                if TransparencyUtil.TransparencyModifier == 0 then
                    TransparencyUtil.TransparencyModifier = 1
                    TransparencyUtil:Update()
                    v10 = u290
                    v11 = nil
                    v12 = nil
                    for i, j in v10, v11, v12 do
                        i.Parent = game.ReplicatedStorage
                    end
                end
                if not LocalPlayerController.States.IsDead then
                    v10 = u312
                    v13 = (CFrame.new(Position)) * u307 * u104 * CFrame.Angles(0, u312.X, 0) * CFrame.Angles(u312.Y, 0, 0)
                    v14 = CFrame.new(0, 0, 0)
                    v15 = u287 * CFrame.new(0, -1.5, 0)
                    v16 = SharedSprings
                    local Position_3 = v16.TPSpring.Position
                    v10.AimCFrame = v13 * v14:Lerp(v15, Position_3) * v26
                    CurrentCamera.CFrame = u312.AimCFrame * v27
                end
            else
                if TransparencyUtil.TransparencyModifier == 1 then
                    TransparencyUtil.TransparencyModifier = 0
                    TransparencyUtil:Update()
                    v10 = u290
                    v11 = nil
                    v12 = nil
                    for k, n in v10, v11, v12 do
                        k.Parent = n
                    end
                end
                v30 = true
                if not LocalPlayerController.States.IsDead then
                    v10 = u312
                    v13 = (CFrame.new(Position)) * CFrame.Angles(0, u312.X, 0) * CFrame.Angles(u312.Y, 0, 0)
                    v14 = CFrame.new(0, 1.5, 0)
                    v15 = u287
                    v16 = SharedSprings
                    local Position_2 = v16.TPSpring.Position
                    v10.AimCFrame = v13 * v14:Lerp(v15, Position_2) * v26
                    CurrentCamera.CFrame = u312.AimCFrame * v27
                end
                v10 = LocalPlayerController.hrp.Position + Vector3.new(0, 1.5, 0)
                v11 = RaycastUtil.CustomRay(v10, CurrentCamera.CFrame.Position, true)
                if v11.Instance and not LocalPlayerController.States.IsDead then
                    v12 = CurrentCamera
                    v12.CFrame = CurrentCamera.CFrame - (CurrentCamera.CFrame.Position - v11.Position) + (v10 - CurrentCamera.CFrame.Position).Unit
                end
            end
            if LocalPlayerController.ThirdPerson
                or not LocalPlayerController.hrp
                or not LocalPlayerController.hrp.Parent then
                if u155 then
                    u155.Parent = Resources
                end
            elseif not LocalPlayerController.States.Proning then
                if not u155 or not u155.Parent or not u156.Parent or not u156.Parent.Parent then
                    if u156 and u156.Parent and not u156.Parent.Parent then
                        u156.Parent:Destroy()
                    end
                    if u155 then
                        u155:Destroy()
                    end
                    if u156 then
                        u156:Destroy()
                    end
                    u155 = Resources.Collision:Clone()
                    u156 = Instance.new("Weld")
                    u156.Part0 = LocalPlayerController.hrp.Parent.Head
                    u156.Part1 = u155
                    u156.Parent = u156.Part0
                    u156.C0 = u156.C0 * CFrame.new(0, -1, -1.5)
                    u155.Name = "HeadCol"
                    u155.Parent = workspace.Ignore
                end
                if u155.Parent == Resources then
                    u155.Parent = workspace.Ignore
                end
            elseif u155 then
                u155.Parent = Resources
            end
            v10 = #u142
            if 0 < v10 then
                v10 = u142[1]
                v11 = nil
                if typeof(v10) == "Vector3" then
                    v11 = (CFrame.new(v10)) * LocalPlayerController.PhysBall.chasis.CFrame.Rotation
                elseif typeof(v10) == "CFrame" then
                    v11 = v10
                    local LookVector_2 = v11.LookVector
                    local X_2 = LookVector_2.X
                    local Z_2 = LookVector_2.Z
                    v13 = Vector3.new(X_2, 0, Z_2)
                    if 0.0001 < v13.Magnitude then
                        local Unit = v13.Unit
                        v14 = u312
                        v15 = -Unit.X
                        v16 = -Unit.Z
                        v14.X = math.atan2(v15, v16)
                        u311 = Unit
                    end
                end
                Position = v11.Position
                LocalPlayerController.PhysBall.chasis.Velocity = Vector3.new()
                LocalPlayerController.PhysBall.chasis.CFrame = v11
                LocalPlayerController.character:PivotTo(v11)
                table.remove(u142, 1)
            end
            local MoveDirection = Vector3.new()
            if LocalPlayerController.humanoid.Humanoid then
                MoveDirection = LocalPlayerController.humanoid.Humanoid.MoveDirection
            end
            local Aiming_2 = CurrentWeapon
            if Aiming_2 then
                Aiming_2 = CurrentWeapon.Aiming
            end
            if u299 and not Aiming_2 then
                u298 = os.clock()
            end
            u299 = Aiming_2
            v12 = os.clock()
            v13 = v12 - u297 < 1.5
            v14 = v12 - u298 < 1.5
            local v31 = Aiming_2 or v13 or v14
            local Sprinting = v30
            if Sprinting then
                Sprinting = LocalPlayerController.States.Sprinting
                if not Sprinting then
                    Sprinting = LocalPlayerController.States.Jogging
                    if not Sprinting then
                        Sprinting = not LocalPlayerController.CurrentWeapon or not v31
                    end
                end
            end
            local Unit_2 = nil
            local v32 = 5
            if v30 then
                if not Sprinting then
                    local LookVector_3 = CFrame.Angles(0, u312.X, 0).LookVector
                    local X_3 = LookVector_3.X
                    local Z_4 = LookVector_3.Z
                    Unit_2 = Vector3.new(X_3, 0, Z_4).Unit
                    v32 = 10
                elseif 0.1 < MoveDirection.Magnitude then
                    Unit_2 = MoveDirection.Unit
                end
                if Unit_2 then
                    v18 = u311
                    v19 = Unit_2
                    local Z_5 = v18.Z
                    local X_4 = v18.X
                    v21 = math.atan2(Z_5, X_4)
                    local Z_6 = v19.Z
                    local X_5 = v19.X
                    v23 = (v21 + ((math.atan2(Z_6, X_5) - v21 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * p1 * v32 + 6.283185307179586) % 6.283185307179586
                    v24 = math.cos(v23)
                    v25 = math.sin(v23)
                    u311 = Vector3.new(v24, 0, v25)
                end
                u150 = CFrame.new(Vector3.new(0, 0, 0), u311)
            else
                u150 = CFrame.Angles(0, u312.X, 0)
            end
            if not Sit then
                local hrp = LocalPlayerController.hrp
                v20 = (CFrame.new(Position)) * u150
                local slideVector = LocalPlayerController.PhysBall.slideVector
                if not slideVector then
                    slideVector = CFrame.new()
                end
                v19 = v20 * slideVector
                local ProneCF = LocalPlayerController.ProneCF
                if not ProneCF then
                    ProneCF = CFrame.new()
                end
                hrp.CFrame = v19 * ProneCF
            end
            if LocalPlayerController.PhysBall then
                LocalPlayerController.PhysBall:update(p1)
            end
            u125 = Position
            if not peek(u212.Camera.ScrollWheelZoom) then
                v19 = peek(u212.Camera.MaxCameraDistance)
                if not GameState.Data.IsLobby then
                    v18 = v19
                else
                    v18 = v19 * 1.3
                end
            else
                v18 = u294
            end
            if not (1 <= v18) then
                if not CurrentWeapon or not CurrentWeapon.Aiming then
                    v19 = u281
                else
                    v19 = u286
                    if not v19 then
                        v19 = u281
                    end
                end
                v17 = v19
                if CurrentWeapon and LocalPlayerController.ThirdPersonSide < 0 then
                    v17 = v17 * CFrame.new(-4, 0, 0)
                end
            else
                v22 = peek(u212.Camera.MaxCameraDistance)
                if not GameState.Data.IsLobby then
                    v21 = v22
                else
                    v21 = v22 * 1.3
                end
                v20 = v18 / v21
                v19 = math.clamp(v20, 0, 1)
                v20 = 0
                if CurrentWeapon then
                    v20 = (1 - v19 * 0.1) * 2
                    if LocalPlayerController.ThirdPersonSide < 0 then
                        v20 = -v20
                    end
                end
                if not CurrentWeapon or not CurrentWeapon.Aiming then
                    v21 = v18
                else
                    v22 = v18 * 0.5
                    v21 = math.max(v22, 1)
                    if not v21 then
                        v21 = v18
                    end
                end
                v17 = CFrame.new(v20, 1.5, v21)
            end
            if not v9 then
                u287 = u287:Lerp(v17, v7)
            else
                u287 = v17
            end
            v19 = peek(u212.Graphics.BaseFOV) * 0.8
            if CurrentWeapon and CurrentWeapon.Config and CurrentWeapon.Config.AimFOVMultiplier then
                v19 = v19 * CurrentWeapon.Config.AimFOVMultiplier
            end
            if not CurrentWeapon or not CurrentWeapon.Aiming then
                v20 = peek(u212.Graphics.BaseFOV)
            else
                v20 = v19
                if not v20 then
                    v20 = peek(u212.Graphics.BaseFOV)
                end
            end
            CurrentCamera.FieldOfView = Lerp(CurrentCamera.FieldOfView, v20, v7)
            if u312.Tracking then
                local Position_4
                local v33 = u312
                local Tracking = v33.Tracking
                if type(Tracking) ~= "userdata" or not u312.Tracking:IsA("BasePart") then
                    Position_4 = u312.Tracking
                else
                    Position_4 = u312.Tracking.Position
                end
                v22 = CurrentCamera.CFrame.Position - Position_4
                local X_6 = v22.X
                local Z_7 = v22.Z
                v33 = math.atan2(X_6, Z_7)
                local v34 = v22.Y / v22.Magnitude
                local v35 = -math.asin(v34)
                v23 = math.clamp(v35, -1.4, 1.4)
                v35 = u312.TrackingEnd - os.clock()
                v24 = Lerp
                v25 = v7 * 5
                local v36 = 1 - v35 / 1
                v24 = v24(v7, v25, (math.clamp(v36, 0, 1)))
                u312.X = Lerp(u312.X, v33, v24)
                u312.Y = Lerp(u312.Y, v23, v24)
            end
        end
    end)
end

function u312.Shake(p1, ...) -- Line: 835 -- upvalues: CameraShakePresets (val), u288 (val), u312 (val), u289 (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = {...}
    local v8 = v7[1]
    if v8 == "Sustained" then
        v1 = v7[2]
        v2 = v7[4] or 0.3
        if v7[3] then
            v3 = CameraShakePresets[v1]
            u288[v1] = v3
            v3.fadeInDuration = v2
            u312.CameraShakerAlt:ShakeSustain(v3)
            return
        end
        if not u288[v1] then
            return
        end
        u288[v1]:StartFadeOut(v2)
        u288[v1] = nil
        return
    end
    if v8 == "Duration" then
        v1 = CameraShakePresets[v7[2]]
        v2 = v7[3] or 1
        v1.fadeInDuration = v7[4] or 0.3
        u312.CameraShakerAlt:ShakeSustain(v1)
        task.wait(v2)
        v6 = v7[5]
        v1:StartFadeOut(v6 or 0.3)
        return
    end
    if v8 == "Single" then
        v1 = CameraShakePresets[v7[2]]
        u312.CameraShakerAlt:Shake(v1)
        return
    end
    if v8 == "SingleCustom" then
        v1 = v7[2] or 1
        v2 = v7[3] or 1
        v3 = v7[4]
        v4 = v7[5]
        v5 = v7[6]
        v6 = v7[7]
        u312.CameraShakerAlt:ShakeOnce(v1, v2, v3, v4, v5, v6)
        return
    end
    if v8 == "SustainedCustom" then
        local v9
        v1 = v7[2] or "custom"
        v2 = v7[4] or 1
        v3 = v7[5] or 1
        v4 = v7[6]
        v5 = v7[7]
        v6 = v7[8]
        local v10 = v7[9]
        if v7[3] and not u289[v1] then
            v9 = u312.CameraShakerAlt:StartShake(v2, v3, v4, v6, v10)
            local v11 = u289
            v11[v1] = {v9, v5}
            return
        end
        if u289[v1] then
            local v12 = u289
            v9 = v12[v1][1]
            local v13 = u289
            v12 = v13[v1][2]
            v9:StartFadeOut(v12)
            u289[v1] = nil
        end
    end
end

function CalculateAngles(p1, p2) -- Line: 893
    -- upvalues: u125 (ref), CurrentCamera (val), u107 (val), u124 (ref), SharedSprings (val), u129 (val), Fusion (val)
    -- upvalues: SkillTreeData (val), u131 (ref), u132 (ref), u133 (ref), u135 (ref), LocalPlayerController (val)
    -- upvalues: u141 (ref)
    local v1 = p1 - (u125 or p1)
    if 1 < v1.Magnitude then
        v1 = p1 - p1
    end
    local v2 = CurrentCamera
    local RightVector = v2.CFrame.RightVector
    local v3 = v1:Dot(RightVector)
    if 0.1 < v3 then
        u107.Target = -0.1 * v3
    elseif not (v3 < 0.1) then
        u107.Target = 0
    else
        u107.Target = -0.1 * v3
    end
    u124 = Lerp(u124, SharedSprings.YawSpring.Position, p2)
    v1 = 0
    v3 = 0
    local v4 = 0
    v2 = u129
    local v5 = nil
    local v6 = nil
    for i, j in v2, v5, v6 do
        v1 = v1 + j.ImpulsePitch.p
        v3 = v3 + j.ImpulseYaw.p
        v4 = v4 + j.ImpulseRoll.p
        if i.IsDestroyed then
            u129[i] = nil
        end
    end
    v1 = math.clamp(v1, -100, 100)
    v3 = math.clamp(v3, -100, 100)
    v4 = math.clamp(v4, -100, 100)
    v2 = Fusion.peek(SkillTreeData.RecoilMult)
    v5 = u131
    local Angles = CFrame.Angles
    local v7 = v1 * 0.5 * v2
    local v8 = v3 * 0.15 * v2
    local v9 = Angles(v7, v8, v4)
    u131 = v5:lerp(v9, p2)
    if not u132 or not u133 then
        v1 = u135
        v4 = CFrame.new()
        u135 = v1:lerp(v4, p2)
    else
        v1 = u133
        local Transform = v1.Transform
        v4 = CFrame.new()
        v2 = SharedSprings
        local Position = v2.EquipSpring.Position
        u135 = Transform:Lerp(v4, Position)
        if u133.Name ~= "Camera" then
            v1, v3, v4 = u135:toEulerAnglesXYZ()
            v2 = CFrame.Angles(v1 * 0.05, v3 * 0.03, v4 * 0.015)
            v6 = CFrame.new()
            v9 = SharedSprings
            local Position_2 = v9.EquipSpring.Position
            u135 = v2:Lerp(v6, Position_2)
        end
    end
    local CurrentWeapon = LocalPlayerController.CurrentWeapon
    if CurrentWeapon and CurrentWeapon.Reloading and CurrentWeapon.Viewmodel then
        local Viewmodel = CurrentWeapon.Viewmodel
        if Viewmodel.HRPADSAttachment and Viewmodel._idleAimRelCF then
            local v10
            v4 = Viewmodel.PrimaryPart.CFrame * Viewmodel._idleAimRelCF:Inverse()
            local CFrame_3 = Viewmodel.Aimpart.CFrame
            v5 = v4:ToObjectSpace(CFrame_3)
            if not u133 then
                v6 = 0.02
            else
                v6 = 0
            end
            v9 = CurrentWeapon.Config.ReloadCameraMultiplier or v6
            v7, v8, v10 = v5:ToEulerAnglesYXZ()
            local v11 = -v10
            local v12 = Vector3.new(v8, v7, v11) * v9
            local v13 = u141
            local v14 = CFrame.Angles(v12.Y, v12.X, v12.Z)
            u141 = v13:Lerp(v14, p2)
            return
        end
        v4 = u141
        v5 = CFrame.new()
        u141 = v4:Lerp(v5, p2)
        return
    end
    v3 = u141
    v2 = CFrame.new()
    u141 = v3:Lerp(v2, p2)
end

function Lerp(p1, p2, p3) -- Line: 970
    return p1 * (1 - p3) + p2 * p3
end

local function thumbstickCurve(p1) -- Line: 979
    local v1 = ((math.abs(p1)) - 0.1) / 0.9 * 2
    local v2 = ((math.exp(v1)) - 1) / 6.38905609893065
    return (math.sign(p1)) * math.clamp(v2, 0, 1)
end

local Value = Enum.ContextActionPriority.High.Value
local Thumbstick2 = Enum.KeyCode.Thumbstick2
ContextActionService:BindActionAtPriority("Testzsd", function(p1, p2, p3) -- Line: 991 -- upvalues: u262 (ref), thumbstickCurve (ref)
    local Position = p3.Position
    u262 = Vector2.new(thumbstickCurve(Position.X), -thumbstickCurve(Position.Y))
    return Enum.ContextActionResult.Pass
end, false, Value, Thumbstick2)

function MakeConnections() -- Line: 1005
    -- upvalues: u128 (val), UserInputService (val), u312 (val), u266 (ref), u107 (val), peek (val), u212 (val)
    -- upvalues: u294 (ref), GameState (val), LocalPlayerController (val), IsInThumbstickArea (val), u144 (val)
    -- upvalues: u145 (ref), u146 (ref), u143 (ref), u262 (ref)
    CleanConnections()
    local v1 = u128
    local v2 = UserInputService
    v2 = v2.InputChanged:connect(function(p1, p2) -- Line: 1009
        -- upvalues: u312 (upval), u266 (upval), u107 (upval), peek (upval), u212 (upval), u294 (upval)
        -- upvalues: GameState (upval), LocalPlayerController (upval), IsInThumbstickArea (upval), u144 (upval)
        -- upvalues: u145 (upval), u146 (upval)
        local v1, v2, v3, v4
        if not u312.Enabled then
            return
        end
        if p1.UserInputType == Enum.UserInputType.MouseMovement then
            u266 = Vector2.new(p1.Delta.X, p1.Delta.Y)
            u107.Position = u107.Position - p1.Delta.X * 0.0002
            return
        end
        if p1.UserInputType == Enum.UserInputType.MouseWheel then
            if peek(u212.Camera.ScrollWheelZoom) and not p2 then
                local Z = p1.Position.Z
                v2 = u294 - Z * 1.5
                v4 = peek(u212.Camera.MaxCameraDistance)
                if not GameState.Data.IsLobby then
                    v3 = v4
                else
                    v3 = v4 * 1.3
                end
                u294 = math.clamp(v2, 0, v3)
                v1 = LocalPlayerController
                v2 = 1 <= u294
                v1.RequestThirdPerson = v2
                return
            end
            return
        end
        if p1.UserInputType == Enum.UserInputType.Touch then
            if IsInThumbstickArea(p1.Position) then
                if u144[p1] then
                    u144[p1] = nil
                    u145 = nil
                    u146 = 0
                end
                return
            end
            if u144[p1] then
                u144[p1] = p1.Position
            end
            local v5 = 0
            v1 = {}
            v2 = u144
            local v6 = nil
            v3 = nil
            for i, j in v2, v6, v3 do
                v5 = v5 + 1
                table.insert(v1, j)
            end
            if v5 == 2 and peek(u212.Camera.PinchToZoom) then
                local Magnitude = (v1[1] - v1[2]).Magnitude
                if u145 then
                    local v7, v8
                    v6 = u145 - Magnitude
                    u146 = u146 + v6
                    while true do
                        v4 = u146
                        if not (50 <= (math.abs(v4))) then
                            break
                        end
                        if not (0 < u146) then
                            v4 = u294 - 1.5
                            v7 = peek(u212.Camera.MaxCameraDistance)
                            if not GameState.Data.IsLobby then
                                v8 = v7
                            else
                                v8 = v7 * 1.3
                            end
                            u294 = math.clamp(v4, 0, v8)
                            u146 = u146 + 50
                        else
                            v4 = u294 + 1.5
                            v7 = peek(u212.Camera.MaxCameraDistance)
                            if not GameState.Data.IsLobby then
                                v8 = v7
                            else
                                v8 = v7 * 1.3
                            end
                            u294 = math.clamp(v4, 0, v8)
                            u146 = u146 - 50
                        end
                        v3 = LocalPlayerController
                        v4 = 1 <= u294
                        v3.RequestThirdPerson = v4
                    end
                end
                u145 = Magnitude
            end
        end
    end)
    table.insert(v1, v2)
    v1 = u128
    v2 = UserInputService
    v2 = v2.InputBegan:connect(function(p1, p2) -- Line: 1082
        -- upvalues: u143 (upval), peek (upval), u212 (upval), u294 (upval), GameState (upval)
        -- upvalues: LocalPlayerController (upval), IsInThumbstickArea (upval), u144 (upval)
        if p1.UserInputType == Enum.UserInputType.MouseButton2 then
            u143 = true
        end
        if not p2 and peek(u212.Camera.ScrollWheelZoom) then
            local v1, v2, v3, v4
            if p1.KeyCode == Enum.KeyCode.I then
                v2 = u294 - 1.5
                v4 = peek(u212.Camera.MaxCameraDistance)
                if not GameState.Data.IsLobby then
                    v3 = v4
                else
                    v3 = v4 * 1.3
                end
                u294 = math.clamp(v2, 0, v3)
                v1 = LocalPlayerController
                v2 = 1 <= u294
                v1.RequestThirdPerson = v2
            elseif p1.KeyCode == Enum.KeyCode.O then
                v2 = u294 + 1.5
                v4 = peek(u212.Camera.MaxCameraDistance)
                if not GameState.Data.IsLobby then
                    v3 = v4
                else
                    v3 = v4 * 1.3
                end
                u294 = math.clamp(v2, 0, v3)
                v1 = LocalPlayerController
                v2 = 1 <= u294
                v1.RequestThirdPerson = v2
            end
        end
        if p1.UserInputType == Enum.UserInputType.Touch and not IsInThumbstickArea(p1.Position) then
            u144[p1] = p1.Position
        end
    end)
    table.insert(v1, v2)
    v1 = u128
    v2 = UserInputService
    v2 = v2.InputEnded:connect(function(p1, p2) -- Line: 1109 -- upvalues: u262 (upval), u143 (upval), u144 (upval), u145 (upval), u146 (upval)
        if p1.KeyCode == Enum.KeyCode.Thumbstick2 then
            u262 = Vector2.new()
        end
        if p1.UserInputType == Enum.UserInputType.MouseButton2 then
            u143 = false
        end
        if p1.UserInputType == Enum.UserInputType.Touch then
            u144[p1] = nil
            u145 = nil
            u146 = 0
        end
    end)
    table.insert(v1, v2)
end

function CleanConnections() -- Line: 1128 -- upvalues: u128 (val)
    local v1 = u128
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        j:Disconnect()
    end
    table.clear(u128)
end

u212.OpenChanged:Connect(function(p1) -- Line: 1135 -- upvalues: u312 (val)
    u312:MouseIconEnabled("Settings", p1)
    u312:SetMouseUnlocked("Settings", p1)
end)
LocalPlayerController.CharacterChanged:Connect(function(p1) -- Line: 1142 -- upvalues: u312 (val), u311 (ref)
    if p1 then
        local LookVector = CFrame.Angles(0, u312.X, 0).LookVector
        local X = LookVector.X
        local Z = LookVector.Z
        u311 = Vector3.new(X, 0, Z).Unit
    end
end)
LocalPlayerController.ThirdPersonChanged:Connect(function(p1) -- Line: 1151 -- upvalues: u294 (ref), peek (val), u212 (val), GameState (val)
    if p1 and u294 < 1 then
        local v1
        local v2 = peek(u212.Camera.MaxCameraDistance)
        if not GameState.Data.IsLobby then
            v1 = v2
        else
            v1 = v2 * 1.3
        end
        u294 = v1
        return
    end
    if not p1 and 1 <= u294 then
        u294 = 0
    end
end)
CameraEvent:SetClientListener(function(p1) -- Line: 1159 -- upvalues: u312 (val)
    if p1 and p1.Type == "SetEnabled" then
        local v1 = u312
        local Enabled = p1.Enabled
        v1:SetEnabled(Enabled)
    end
end)
;(CollectionService:GetInstanceAddedSignal(v4)):Connect(function(p1) -- Line: 1165 -- upvalues: u290 (val)
    local v1 = 10
    repeat
        v1 = v1 - task.wait()
    until p1.Parent or v1 <= 0
    if p1.Parent then
        print(p1.Parent)
    else
        print("cannot resolve vfx parent of", p1)
    end
    u290[p1] = p1.Parent
end)
;(CollectionService:GetInstanceRemovedSignal(v4)):Connect(function(p1) -- Line: 1178 -- upvalues: u290 (val)
    u290[p1] = nil
end)
if game.ReplicatedStorage:FindFirstChild("Remotes")
    and game.ReplicatedStorage.common.Remotes:FindFirstChild("CameraShake") then
    game.ReplicatedStorage.common.Remotes.CameraShake.OnClientEvent:Connect(function(...) -- Line: 1186 -- upvalues: u312 (val)
        u312:Shake(...)
    end)
end
CameraShakeEvent:SetClientListener(function(p1) -- Line: 1191 -- upvalues: u312 (val)
    local v1 = u312
    local v2 = unpack(p1)
    v1:Shake(v2)
end)
return u312