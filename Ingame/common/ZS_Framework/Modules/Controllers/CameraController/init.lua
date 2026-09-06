local Remotes
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
    if not ThumbstickFrame then
        local DynamicThumbstickFrame = TouchControlFrame:FindFirstChild("DynamicThumbstickFrame")
        if not DynamicThumbstickFrame or not DynamicThumbstickFrame.Visible then
            return false
        end
        local AbsolutePosition_2 = DynamicThumbstickFrame.AbsolutePosition
        local v1 = AbsolutePosition_2 + DynamicThumbstickFrame.AbsoluteSize
        if AbsolutePosition_2.X > p1.X or AbsolutePosition_2.Y > p1.Y or p1.X > v1.X then
            return false
        end
        if p1.Y <= v1.Y then
            return true
        end
        return false
    elseif ThumbstickFrame.Visible then
        local AbsolutePosition = ThumbstickFrame.AbsolutePosition
        local v2 = AbsolutePosition + ThumbstickFrame.AbsoluteSize
        if AbsolutePosition.X <= p1.X and AbsolutePosition.Y <= p1.Y and p1.X <= v2.X and p1.Y <= v2.Y then
            return true
        end
    end
end
local u148 = 1
local u150 = CFrame.new()
CFrame.new()
CFrame.new()
local u155 = nil
local u156 = nil
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
local v3 = OutfitMorph.VfxTagFor(LocalPlayer)
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
    return (math.atan2(v1, -p1.LookVector.Z))
end
local function UpdateDirectionCircular(p1, p2, p3, p4) -- Line: 221
    local v1 = math.atan2(p1.Z, p1.X)
    local v2 = (v1 + ((math.atan2(p2.Z, p2.X) - v1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * p3 * p4 + 6.283185307179586) % 6.283185307179586
    local v3 = math.cos(v2)
    return (Vector3.new(v3, 0, (math.sin(v2))))
end
local u311 = Vector3.new(0, 0, 1)
local u312 = {
    X = 0,
    Y = 0,
    FOV = 70,
    Enabled = false,
    AimCFrame = CFrame.new(),
    CameraShaker = CameraShaker.new(Enum.RenderPriority.Camera.Value, "shakeOne"),
    CameraShakerAlt = CameraShaker.new(Enum.RenderPriority.Camera.Value, "shakeTwo"),
    Init = function(p1) -- Line: 259 -- upvalues: TransparencyUtil (val), Parent (val), u297 (ref)
        TransparencyUtil:Init()
        MakeConnections()
        task.defer(function() -- Line: 264 -- upvalues: Parent (upval), u297 (upval)
            require(Parent:WaitForChild("WeaponController")).GunFired:Connect(function() -- Line: 266 -- upvalues: u297 (upval)
                u297 = os.clock()
            end)
        end)
    end,
    GetCameraShakeCF = function(p1) -- Line: 272 -- upvalues: u137 (ref)
        return u137
    end,
    GetCameraBoneAngle = function(p1) -- Line: 276 -- upvalues: u135 (ref)
        return u135
    end,
    NewRecoil = function(p1, p2) -- Line: 280 -- upvalues: u129 (val), RecoilUtil (val)
        u129[p2] = RecoilUtil.new(p2)
        return u129[p2]
    end,
    SetCameraBone = function(p1, p2, p3) -- Line: 285 -- upvalues: u132 (ref), u133 (ref)
        u132 = p2
        u133 = p3
    end,
    ForceTeleport = function(p1, p2) -- Line: 290 -- upvalues: unseatCharacter (val), LocalPlayerController (val), u142 (val)
        unseatCharacter(LocalPlayerController.character)
        LocalPlayerController.LastForceTeleportClock = os.clock()
        table.insert(u142, p2)
    end,
    GetZoomDistance = function(p1) -- Line: 297 -- upvalues: u294 (ref)
        return u294
    end,
    GetMaxZoomDistance = function(p1) -- Line: 301 -- upvalues: peek (val), u212 (val), GameState (val)
        local v1 = peek(u212.Camera.MaxCameraDistance)
        if GameState.Data.IsLobby then
            return v1 * 1.3
        end
        return v1
    end,
    SetZoomDistance = function(p1, p2) -- Line: 305 -- upvalues: u294 (ref), peek (val), u212 (val), GameState (val), LocalPlayerController (val)
        local v1
        local v2 = peek(u212.Camera.MaxCameraDistance)
        if not GameState.Data.IsLobby then
            v1 = v2
        else
            v1 = v2 * 1.3
        end
        u294 = math.clamp(p2, 0, v1)
        local v3 = 1 <= u294
        LocalPlayerController.RequestThirdPerson = v3
    end,
    SetMouseUnlocked = function(p1, p2, p3) -- Line: 310 -- upvalues: u252 (val), u253 (ref)
        local v1 = table.find(u252, p2)
        if not p3 then
            if not p3 and v1 then
                table.remove(u252, v1)
                u253 = u253 - 1
            end
            return
        end
        if not v1 then
            table.insert(u252, p2)
            u253 = u253 + 1
            return
        end
        if not p3 and v1 then
            table.remove(u252, v1)
            u253 = u253 - 1
        end
    end,
    SetMouseLockPosition = function(p1, p2, p3) -- Line: 321 -- upvalues: u254 (val), u255 (ref)
        local v1 = table.find(u254, p2)
        if not p3 then
            if not p3 and v1 then
                table.remove(u254, v1)
                u255 = u255 - 1
            end
            return
        end
        if not v1 then
            table.insert(u254, p2)
            u255 = u255 + 1
            return
        end
        if not p3 and v1 then
            table.remove(u254, v1)
            u255 = u255 - 1
        end
    end,
    MouseIconEnabled = function(p1, p2, p3, p4) -- Line: 332 -- upvalues: u250 (val), u257 (val), UserInputService (val), u251 (ref)
        local v1 = table.find(u250, p2)
        if not p3 then
            if not p3 and v1 then
                table.remove(u250, v1)
                u251 = u251 - 1
                local v2 = u257[p2]
                if v2 ~= nil and UserInputService.MouseIcon == v2 then
                    local v3
                    local v4 = false
                    local v5 = 1
                    local v6 = -1
                    for i = #u250, v5, v6 do
                        v3 = u257[u250[i]]
                        if v3 then
                            UserInputService.MouseIcon = v3
                            v4 = true
                            break
                        end
                    end
                    if not v4 then
                        UserInputService.MouseIcon = ""
                    end
                end
            end
            return
        elseif not v1 then
            u257[p2] = p4
            UserInputService.MouseIcon = p4 or ""
            table.insert(u250, p2)
            u251 = u251 + 1
            return
        end
    end,
    SetMagnificationSensitivity = function(p1, p2) -- Line: 364 -- upvalues: u148 (ref)
        u148 = p2
    end,
    GetMagnificationSensitivity = function(p1) -- Line: 368 -- upvalues: LocalPlayerController (val), u148 (ref)
        local CurrentWeapon = LocalPlayerController.CurrentWeapon
        if not CurrentWeapon then
            return 1
        end
        if CurrentWeapon.Aiming then
            return u148
        end
        return 1
    end,
    GetSensitivity = function(p1) -- Line: 373 -- upvalues: LocalPlayerController (val), peek (val), u212 (val)
        local CurrentWeapon = LocalPlayerController.CurrentWeapon
        if not CurrentWeapon then
            return peek(u212.Controls.Sensitivity)
        end
        if CurrentWeapon.Aiming then
            return peek(u212.Controls.AimingSensitivity)
        end
        return peek(u212.Controls.Sensitivity)
    end,
    ShouldGunRest = function(p1) -- Line: 385 -- upvalues: LocalPlayerController (val), u297 (ref), u298 (ref)
        if not LocalPlayerController.ThirdPerson then
            return false
        end
        local CurrentWeapon = LocalPlayerController.CurrentWeapon
        if not CurrentWeapon or CurrentWeapon.Aiming then
            return false
        end
        local v1 = os.clock()
        local v2 = v1 - u297
        local v3 = v2 < 2
        local v4 = v1 - u298
        v2 = v4 < 2
        v4 = not v3
        if v4 then
            v4 = not v2
        end
        return v4
    end,
}
local function adjustTouchPitchSensitivity(p1) -- Line: 409
    local CurrentCamera = workspace.CurrentCamera
    if not CurrentCamera then
        return p1
    end
    local v1 = CurrentCamera.CFrame:ToEulerAnglesYXZ()
    local v2 = p1.Y * v1
    if 0 <= v2 then
        return p1
    end
    return Vector2.new(1, (1 - (math.abs(v1) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25) * p1
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
RunService.Heartbeat:Connect(function(p1) -- Line: 445 -- upvalues: LocalPlayerController (val), u143 (ref), u312 (val), u253 (ref), UserInputService (val), u251 (ref), u256 (ref), u255 (ref), SkillTreeMain (val), Fusion (val)
    local v1
    local ThirdPerson = LocalPlayerController.ThirdPerson
    if ThirdPerson then
        ThirdPerson = not LocalPlayerController.CurrentWeapon
    end
    local v2 = ThirdPerson
    if v2 then
        v2 = u143
    end
    if not u312.Enabled then
        if 0 < u253 then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            v1 = 0 < u251
            UserInputService.MouseIconEnabled = v1
            u256 = true
            return
        end
        if u256 then
            local Default
            if not ThirdPerson then
                Default = Enum.MouseBehavior.LockCenter
            else
                Default = Enum.MouseBehavior.Default
            end
            UserInputService.MouseBehavior = Default
            v1 = if 0 >= u251 then ThirdPerson else true
            UserInputService.MouseIconEnabled = v1
            u256 = false
        end
        return
    end
    u256 = false
    if 0 < u255 then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
    elseif not v2 then
        if u253 > 0 then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        elseif ThirdPerson then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        else
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        end
    elseif not SkillTreeMain.isSkillTreeOpen then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
    elseif not (Fusion.peek(SkillTreeMain.isSkillTreeOpen)) then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
    end
    v1 = if 0 >= u251 then ThirdPerson else true
    UserInputService.MouseIconEnabled = v1
end)
function u312.SetEnabled(p1, p2) -- Line: 483 -- upvalues: u312 (val), RunService (val), u302 (val), LocalPlayerController (val), CurrentCamera (val), u148 (ref), peek (val), u212 (val), u262 (ref), UserGameSettings (val), u266 (ref), u137 (ref), u139 (ref), CursorRecoilUtil (val), BobbingUtil (val), u124 (ref), u107 (val), u131 (ref), u135 (ref), u141 (ref), u104 (ref), u295 (ref), SharedSprings (val), u311 (ref), TransparencyUtil (val), u290 (val), u287 (ref), RaycastUtil (val), u307 (val), u155 (ref), u156 (ref), Resources (val), u142 (val), u299 (ref), u298 (ref), u297 (ref), u150 (ref), u125 (ref), u294 (ref), GameState (val), u286 (val), u281 (val)
    u312.Enabled = p2
    if p2 then
        RunService:BindToRenderStep("CameraController", u302, function(p1) -- Line: 486 -- upvalues: LocalPlayerController (upval), CurrentCamera (upval), u148 (upval), peek (upval), u212 (upval), u262 (upval), UserGameSettings (upval), u266 (upval), u312 (upval), u137 (upval), u139 (upval), CursorRecoilUtil (upval), BobbingUtil (upval), u124 (upval), u107 (upval), u131 (upval), u135 (upval), u141 (upval), u104 (upval), u295 (upval), SharedSprings (upval), u311 (upval), TransparencyUtil (upval), u290 (upval), u287 (upval), RaycastUtil (upval), u307 (upval), u155 (upval), u156 (upval), Resources (upval), u142 (upval), u299 (upval), u298 (upval), u297 (upval), u150 (upval), u125 (upval), u294 (upval), GameState (upval), u286 (upval), u281 (upval)
            local Aiming, Humanoid, v1
            if not LocalPlayerController.States.IsDead then
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
            end
            local CurrentWeapon = LocalPlayerController.CurrentWeapon
            local v2 = 1
            if not CurrentWeapon then
                v1 = peek(u212.Controls.Sensitivity)
            elseif CurrentWeapon.Aiming then
                v2 = u148
                v1 = peek(u212.Controls.AimingSensitivity)
            end
            local v3 = u262
            local v4 = v3.X * UserGameSettings.MouseSensitivity * 9 + u266.X * v2
            local v5 = (v3.Y * UserGameSettings.MouseSensitivity * 9 + u266.Y) * v2
            u266 = Vector2.new()
            local function normalizeAngle(p1) -- Line: 512
                return (p1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
            end
            u312.X = ((u312.X - v4 * v1 / 150 * 1) % 6.283185307179586 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
            local v6 = u312.Y - v5 * UserGameSettings:GetCameraYInvertValue() * v1 / 150 * 1
            u312.Y = math.clamp(v6, -1.4, 1.4)
            if LocalPlayerController.humanoid.Humanoid then
                LocalPlayerController.humanoid.Humanoid.AutoRotate = false
            end
            if LocalPlayerController.character and LocalPlayerController.hrp and LocalPlayerController.PhysBall._fullyInitialized then
                local MoveDirection, Position, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21
                local v22 = math.clamp(p1 * 10, 0.01, 1)
                Humanoid = LocalPlayerController.humanoid.Humanoid
                local Sit = Humanoid
                if Sit then
                    Sit = Humanoid.Sit
                    if not Sit then
                        Sit = Humanoid.SeatPart ~= nil
                    end
                end
                Position = if LocalPlayerController.PhysBall.isActive and not Sit then LocalPlayerController.PhysBall.chasis.CFrame.p else LocalPlayerController.hrp.Position
                CalculateAngles(Position, v22)
                u137 = u312.CameraShaker:Update(p1)
                u139 = u312.CameraShakerAlt:Update(p1)
                Aiming = CurrentWeapon
                if Aiming then
                    Aiming = CurrentWeapon.Aiming
                end
                CursorRecoilUtil:Update(p1, Aiming)
                local v23 = BobbingUtil.cameraBobCF * CFrame.Angles(u124, 0, u107.Position)
                local v24 = v23 * u131
                v24 = u139
                if not v24 then
                    v24 = CFrame.new()
                end
                local v25 = v24 * u137 * v24
                v24 = u135 * CFrame.new()
                local v26 = v24 * u141
                v24 = u104
                if not LocalPlayerController.States.Proning then
                    v7 = CFrame.new()
                else
                    v7 = CFrame.new(0, -1, 0)
                end
                u104 = v24:Lerp(v7, v22)
                if not LocalPlayerController.ThirdPerson then
                    v24 = 0
                elseif LocalPlayerController.hrp then
                    v24 = 1
                end
                v23 = v24 == 1
                v7 = v23 ~= u295
                SharedSprings.TPSpring.Target = v24
                if v7 then
                    SharedSprings.TPSpring.Position = v24
                    if v23 then
                        local LookVector = CFrame.Angles(0, u312.X, 0).LookVector
                        u311 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit
                    end
                end
                u295 = v23
                local v27 = false
                if 0.05 >= SharedSprings.TPSpring.Position then
                    if TransparencyUtil.TransparencyModifier == 0 then
                        TransparencyUtil.TransparencyModifier = 1
                        TransparencyUtil:Update()
                        v8 = u290
                        v9 = nil
                        v10 = nil
                        for i, j in v8, v9, v10 do
                            i.Parent = game.ReplicatedStorage
                        end
                    end
                    if not LocalPlayerController.States.IsDead then
                        local v28 = CFrame.new(Position)
                        v12 = v28 * u307 * u104 * CFrame.Angles(0, u312.X, 0)
                        v11 = v12 * CFrame.Angles(u312.Y, 0, 0)
                        v12 = CFrame.new(0, 0, 0)
                        local v29 = u287 * CFrame.new(0, -1.5, 0)
                        u312.AimCFrame = v11 * v12:Lerp(v29, SharedSprings.TPSpring.Position) * v25
                        CurrentCamera.CFrame = u312.AimCFrame * v26
                    end
                else
                    if TransparencyUtil.TransparencyModifier == 1 then
                        TransparencyUtil.TransparencyModifier = 0
                        TransparencyUtil:Update()
                        v8 = u290
                        v9 = nil
                        v10 = nil
                        for k, n in v8, v9, v10 do
                            k.Parent = n
                        end
                    end
                    v27 = true
                    if not LocalPlayerController.States.IsDead then
                        v13 = CFrame.new(Position)
                        v12 = v13 * CFrame.Angles(0, u312.X, 0)
                        v11 = v12 * CFrame.Angles(u312.Y, 0, 0)
                        v12 = CFrame.new(0, 1.5, 0)
                        u312.AimCFrame = v11 * v12:Lerp(u287, SharedSprings.TPSpring.Position) * v25
                        CurrentCamera.CFrame = u312.AimCFrame * v26
                    end
                    v8 = LocalPlayerController.hrp.Position + Vector3.new(0, 1.5, 0)
                    v9 = RaycastUtil.CustomRay(v8, CurrentCamera.CFrame.Position, true)
                    if v9.Instance and not LocalPlayerController.States.IsDead then
                        CurrentCamera.CFrame = CurrentCamera.CFrame - (CurrentCamera.CFrame.Position - v9.Position) + (v8 - CurrentCamera.CFrame.Position).Unit
                    end
                end
                if LocalPlayerController.ThirdPerson then
                    if u155 then
                        u155.Parent = Resources
                    end
                elseif LocalPlayerController.hrp and LocalPlayerController.hrp.Parent and not LocalPlayerController.States.Proning then
                    if not u155 then
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
                    elseif u155.Parent and u156.Parent and u156.Parent.Parent then
                    end
                    if u155.Parent == Resources then
                        u155.Parent = workspace.Ignore
                    end
                end
                v8 = #u142
                if 0 < v8 then
                    v8 = u142[1]
                    v9 = nil
                    if typeof(v8) == "Vector3" then
                        v10 = CFrame.new(v8)
                        v9 = v10 * LocalPlayerController.PhysBall.chasis.CFrame.Rotation
                    elseif typeof(v8) == "CFrame" then
                        local LookVector_2 = v8.LookVector
                        v11 = Vector3.new(LookVector_2.X, 0, LookVector_2.Z)
                        if 0.0001 < v11.Magnitude then
                            local Unit = v11.Unit
                            u312.X = math.atan2(-Unit.X, -Unit.Z)
                            u311 = Unit
                        end
                    end
                    Position = v9.Position
                    LocalPlayerController.PhysBall.chasis.Velocity = Vector3.new()
                    LocalPlayerController.PhysBall.chasis.CFrame = v9
                    LocalPlayerController.character:PivotTo(v9)
                    table.remove(u142, 1)
                end
                MoveDirection = if LocalPlayerController.humanoid.Humanoid then LocalPlayerController.humanoid.Humanoid.MoveDirection else Vector3.new()
                local Aiming_2 = CurrentWeapon
                if Aiming_2 then
                    Aiming_2 = CurrentWeapon.Aiming
                end
                if u299 and not Aiming_2 then
                    u298 = os.clock()
                end
                u299 = Aiming_2
                v10 = os.clock()
                v12 = v10 - u297
                v11 = v12 < 1.5
                v13 = v10 - u298
                v12 = v13 < 1.5
                v13 = Aiming_2
                if not v13 then
                    v13 = v11
                    if not v13 then
                        v13 = v12
                    end
                end
                local Sprinting = v27
                if Sprinting then
                    Sprinting = LocalPlayerController.States.Sprinting
                    if not Sprinting then
                        Sprinting = LocalPlayerController.States.Jogging
                        if not Sprinting then
                            Sprinting = not LocalPlayerController.CurrentWeapon
                            if not Sprinting then
                                Sprinting = not v13
                            end
                        end
                    end
                end
                local Unit_2 = nil
                local v30 = 5
                if v27 then
                    if not Sprinting then
                        local LookVector_3 = CFrame.Angles(0, u312.X, 0).LookVector
                        Unit_2 = Vector3.new(LookVector_3.X, 0, LookVector_3.Z).Unit
                        v30 = 10
                    elseif 0.1 < MoveDirection.Magnitude then
                        Unit_2 = MoveDirection.Unit
                    end
                    if Unit_2 then
                        v15 = u311
                        v16 = Unit_2
                        v18 = math.atan2(v15.Z, v15.X)
                        v20 = (v18 + ((math.atan2(v16.Z, v16.X) - v18 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * p1 * v30 + 6.283185307179586) % 6.283185307179586
                        v21 = math.cos(v20)
                        u311 = Vector3.new(v21, 0, (math.sin(v20)))
                    end
                    u150 = CFrame.new(Vector3.new(0, 0, 0), u311)
                else
                    u150 = CFrame.Angles(0, u312.X, 0)
                end
                if not Sit then
                    v18 = CFrame.new(Position)
                    local slideVector = LocalPlayerController.PhysBall.slideVector
                    if not slideVector then
                        slideVector = CFrame.new()
                    end
                    local ProneCF = LocalPlayerController.ProneCF
                    if not ProneCF then
                        ProneCF = CFrame.new()
                    end
                    LocalPlayerController.hrp.CFrame = v18 * u150 * slideVector * ProneCF
                end
                if LocalPlayerController.PhysBall then
                    LocalPlayerController.PhysBall:update(p1)
                end
                u125 = Position
                if not (peek(u212.Camera.ScrollWheelZoom)) then
                    v16 = peek(u212.Camera.MaxCameraDistance)
                    if not GameState.Data.IsLobby then
                        v15 = v16
                    else
                        v15 = v16 * 1.3
                    end
                else
                    v15 = u294
                end
                if 1 > v15 then
                    if not CurrentWeapon then
                        v16 = u281
                    elseif CurrentWeapon.Aiming then
                        v16 = u286
                    end
                    v14 = v16
                    if CurrentWeapon and LocalPlayerController.ThirdPersonSide < 0 then
                        v14 = v14 * CFrame.new(-4, 0, 0)
                    end
                else
                    v19 = peek(u212.Camera.MaxCameraDistance)
                    if not GameState.Data.IsLobby then
                        v18 = v19
                    else
                        v18 = v19 * 1.3
                    end
                    v16 = math.clamp(v15 / v18, 0, 1)
                    v17 = 0
                    if CurrentWeapon then
                        v17 = (1 - v16 * 0.1) * 2
                        if LocalPlayerController.ThirdPersonSide < 0 then
                            v17 = -v17
                        end
                    end
                    if not CurrentWeapon then
                        v18 = v15
                    elseif CurrentWeapon.Aiming then
                        v18 = math.max(v15 * 0.5, 1)
                    end
                    v14 = CFrame.new(v17, 1.5, v18)
                end
                if not v7 then
                    u287 = u287:Lerp(v14, v22)
                else
                    u287 = v14
                end
                v16 = peek(u212.Graphics.BaseFOV) * 0.8
                if CurrentWeapon and CurrentWeapon.Config and CurrentWeapon.Config.AimFOVMultiplier then
                    v16 = v16 * CurrentWeapon.Config.AimFOVMultiplier
                end
                if not CurrentWeapon then
                    v17 = peek(u212.Graphics.BaseFOV)
                elseif CurrentWeapon.Aiming then
                    v17 = v16
                end
                CurrentCamera.FieldOfView = Lerp(CurrentCamera.FieldOfView, v17, v22)
                if u312.Tracking then
                    local Position_2
                    if type(u312.Tracking) ~= "userdata" then
                        Position_2 = u312.Tracking
                    elseif not (u312.Tracking:IsA("BasePart")) then
                        Position_2 = u312.Tracking
                    else
                        Position_2 = u312.Tracking.Position
                    end
                    v19 = CurrentCamera.CFrame.Position - Position_2
                    local v31 = math.atan2(v19.X, v19.Z)
                    local v32 = -math.asin(v19.Y / v19.Magnitude)
                    v20 = math.clamp(v32, -1.4, 1.4)
                    v32 = u312.TrackingEnd - os.clock()
                    local v33 = 1 - v32 / 1
                    v21 = Lerp(v22, v22 * 5, (math.clamp(v33, 0, 1)))
                    u312.X = Lerp(u312.X, v31, v21)
                    u312.Y = Lerp(u312.Y, v20, v21)
                end
            end
        end)
        return
    end
    RunService:UnbindFromRenderStep("CameraController")
end
function u312.Shake(p1, ...) -- Line: 835 -- upvalues: CameraShakePresets (val), u288 (val), u312 (val), u289 (val)
    local v1, v2, v3
    local v4 = {...}
    local v5 = v4[1]
    if v5 == "Sustained" then
        v1 = v4[2]
        v2 = v4[4] or 0.3
        if v4[3] then
            v3 = CameraShakePresets[v1]
            u288[v1] = v3
            v3.fadeInDuration = v2
            u312.CameraShakerAlt:ShakeSustain(v3)
            return
        end
        if not (u288[v1]) then
            return
        end
        u288[v1]:StartFadeOut(v2)
        u288[v1] = nil
        return
    end
    if v5 == "Duration" then
        v1 = CameraShakePresets[v4[2]]
        v2 = v4[3] or 1
        v1.fadeInDuration = v4[4] or 0.3
        u312.CameraShakerAlt:ShakeSustain(v1)
        task.wait(v2)
        v1:StartFadeOut(v4[5] or 0.3)
        return
    end
    if v5 == "Single" then
        u312.CameraShakerAlt:Shake(CameraShakePresets[v4[2]])
        return
    end
    if v5 == "SingleCustom" then
        u312.CameraShakerAlt:ShakeOnce(v4[2] or 1, v4[3] or 1, v4[4], v4[5], v4[6], v4[7])
        return
    end
    if v5 ~= "SustainedCustom" then
        return
    end
    v1 = v4[2] or "custom"
    v2 = v4[4] or 1
    v3 = v4[5] or 1
    if not (v4[3]) then
        if u289[v1] then
            u289[v1][1]:StartFadeOut(u289[v1][2])
            u289[v1] = nil
        end
        return
    end
    if not (u289[v1]) then
        local v6 = u312.CameraShakerAlt:StartShake(v2, v3, v4[6], v4[8], v4[9])
        u289[v1] = {v6, v4[7]}
        return
    end
    if u289[v1] then
        u289[v1][1]:StartFadeOut(u289[v1][2])
        u289[v1] = nil
    end
end
function CalculateAngles(p1, p2) -- Line: 893 -- upvalues: u125 (ref), CurrentCamera (val), u107 (val), u124 (ref), SharedSprings (val), u129 (val), Fusion (val), SkillTreeData (val), u131 (ref), u132 (ref), u133 (ref), u135 (ref), LocalPlayerController (val), u141 (ref)
    local Viewmodel, v1
    local v2 = p1 - (u125 or p1)
    if 1 < v2.Magnitude then
        v2 = p1 - p1
    end
    local v3 = v2:Dot(CurrentCamera.CFrame.RightVector)
    if 0.1 < v3 then
        u107.Target = -0.1 * v3
    elseif v3 >= 0.1 then
        u107.Target = 0
    end
    u124 = Lerp(u124, SharedSprings.YawSpring.Position, p2)
    v2 = 0
    v3 = 0
    local v4 = 0
    local v5 = u129
    local v6 = nil
    local v7 = nil
    for i, j in v5, v6, v7 do
        v2 = v2 + j.ImpulsePitch.p
        v3 = v3 + j.ImpulseYaw.p
        v4 = v4 + j.ImpulseRoll.p
        if i.IsDestroyed then
            u129[i] = nil
        end
    end
    v2 = math.clamp(v2, -100, 100)
    v3 = math.clamp(v3, -100, 100)
    v4 = math.clamp(v4, -100, 100)
    v5 = Fusion.peek(SkillTreeData.RecoilMult)
    local v8 = v2 * 0.5 * v5
    local v9 = v3 * 0.15 * v5
    local v10 = CFrame.Angles(v8, v9, v4)
    u131 = u131:lerp(v10, p2)
    if not u132 then
        u135 = u135:lerp(CFrame.new(), p2)
    elseif u133 then
        u135 = u133.Transform:Lerp(CFrame.new(), SharedSprings.EquipSpring.Position)
        if u133.Name ~= "Camera" then
            v2, v3, v4 = u135:toEulerAnglesXYZ()
            v5 = CFrame.Angles(v2 * 0.05, v3 * 0.03, v4 * 0.015)
            u135 = v5:Lerp(CFrame.new(), SharedSprings.EquipSpring.Position)
        end
    end
    local CurrentWeapon = LocalPlayerController.CurrentWeapon
    if not CurrentWeapon or not CurrentWeapon.Reloading or not CurrentWeapon.Viewmodel then
        u141 = u141:Lerp(CFrame.new(), p2)
        return
    end
    Viewmodel = CurrentWeapon.Viewmodel
    if not Viewmodel.HRPADSAttachment or not Viewmodel._idleAimRelCF then
        u141 = u141:Lerp(CFrame.new(), p2)
        return
    end
    v4 = Viewmodel.PrimaryPart.CFrame * Viewmodel._idleAimRelCF:Inverse()
    v6 = v4:ToObjectSpace(Viewmodel.Aimpart.CFrame)
    if not u133 then
        v7 = 0.02
    else
        v7 = 0
    end
    v10 = CurrentWeapon.Config.ReloadCameraMultiplier or v7
    v8, v9, v1 = v6:ToEulerAnglesYXZ()
    local v11 = Vector3.new(v9, v8, -v1) * v10
    local v12 = CFrame.Angles(v11.Y, v11.X, v11.Z)
    u141 = u141:Lerp(v12, p2)
end
function Lerp(p1, p2, p3) -- Line: 970
    return p1 * (1 - p3) + p2 * p3
end
local function thumbstickCurve(p1) -- Line: 979
    local v1 = math.sign(p1)
    return v1 * math.clamp((math.exp((math.abs(p1) - 0.1) / 0.9 * 2) - 1) / 6.38905609893065, 0, 1)
end
ContextActionService:BindActionAtPriority("Testzsd", function(p1, p2, p3) -- Line: 991 -- upvalues: u262 (ref), thumbstickCurve (ref)
    local Position = p3.Position
    local v1 = thumbstickCurve(Position.X)
    u262 = Vector2.new(v1, -thumbstickCurve(Position.Y))
    return Enum.ContextActionResult.Pass
end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick2)
function MakeConnections() -- Line: 1005 -- upvalues: u128 (val), UserInputService (val), u312 (val), u266 (ref), u107 (val), peek (val), u212 (val), u294 (ref), GameState (val), LocalPlayerController (val), IsInThumbstickArea (val), u144 (val), u145 (ref), u146 (ref), u143 (ref), u262 (ref)
    CleanConnections()
    table.insert(u128, UserInputService.InputChanged:connect(function(p1, p2) -- Line: 1009 -- upvalues: u312 (upval), u266 (upval), u107 (upval), peek (upval), u212 (upval), u294 (upval), GameState (upval), LocalPlayerController (upval), IsInThumbstickArea (upval), u144 (upval), u145 (upval), u146 (upval)
        local v1, v2, v3
        if not u312.Enabled then
            return
        end
        if p1.UserInputType == Enum.UserInputType.MouseMovement then
            u266 = Vector2.new(p1.Delta.X, p1.Delta.Y)
            u107.Position = u107.Position - p1.Delta.X * 0.0002
            return
        end
        if p1.UserInputType == Enum.UserInputType.MouseWheel then
            if not (peek(u212.Camera.ScrollWheelZoom)) or p2 then
                return
            end
            v3 = peek(u212.Camera.MaxCameraDistance)
            if not GameState.Data.IsLobby then
                v2 = v3
            else
                v2 = v3 * 1.3
            end
            u294 = math.clamp(u294 - p1.Position.Z * 1.5, 0, v2)
            v1 = 1 <= u294
            LocalPlayerController.RequestThirdPerson = v1
            return
        end
        if p1.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
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
        local v4 = 0
        local v5 = {}
        v1 = u144
        local v6 = nil
        v2 = nil
        for i, j in v1, v6, v2 do
            v4 = v4 + 1
            table.insert(v5, j)
        end
        if v4 == 2 and peek(u212.Camera.PinchToZoom) then
            local Magnitude = (v5[1] - v5[2]).Magnitude
            if u145 then
                local v7, v8
                u146 = u146 + (u145 - Magnitude)
                while true do
                    v2 = math.abs(u146)
                    if 50 > v2 then
                        break
                    end
                    if 0 >= u146 then
                        v7 = peek(u212.Camera.MaxCameraDistance)
                        if not GameState.Data.IsLobby then
                            v8 = v7
                        else
                            v8 = v7 * 1.3
                        end
                        u294 = math.clamp(u294 - 1.5, 0, v8)
                        u146 = u146 + 50
                    else
                        v7 = peek(u212.Camera.MaxCameraDistance)
                        if not GameState.Data.IsLobby then
                            v8 = v7
                        else
                            v8 = v7 * 1.3
                        end
                        u294 = math.clamp(u294 + 1.5, 0, v8)
                        u146 = u146 - 50
                    end
                    v3 = 1 <= u294
                    LocalPlayerController.RequestThirdPerson = v3
                end
            end
            u145 = Magnitude
        end
    end))
    table.insert(u128, UserInputService.InputBegan:connect(function(p1, p2) -- Line: 1082 -- upvalues: u143 (upval), peek (upval), u212 (upval), u294 (upval), GameState (upval), LocalPlayerController (upval), IsInThumbstickArea (upval), u144 (upval)
        if p1.UserInputType == Enum.UserInputType.MouseButton2 then
            u143 = true
        end
        if not p2 and peek(u212.Camera.ScrollWheelZoom) then
            local v1, v2, v3
            if p1.KeyCode == Enum.KeyCode.I then
                v3 = peek(u212.Camera.MaxCameraDistance)
                if not GameState.Data.IsLobby then
                    v2 = v3
                else
                    v2 = v3 * 1.3
                end
                u294 = math.clamp(u294 - 1.5, 0, v2)
                v1 = 1 <= u294
                LocalPlayerController.RequestThirdPerson = v1
            elseif p1.KeyCode == Enum.KeyCode.O then
                v3 = peek(u212.Camera.MaxCameraDistance)
                if not GameState.Data.IsLobby then
                    v2 = v3
                else
                    v2 = v3 * 1.3
                end
                u294 = math.clamp(u294 + 1.5, 0, v2)
                v1 = 1 <= u294
                LocalPlayerController.RequestThirdPerson = v1
            end
        end
        if p1.UserInputType == Enum.UserInputType.Touch and not (IsInThumbstickArea(p1.Position)) then
            u144[p1] = p1.Position
        end
    end))
    table.insert(u128, UserInputService.InputEnded:connect(function(p1, p2) -- Line: 1109 -- upvalues: u262 (upval), u143 (upval), u144 (upval), u145 (upval), u146 (upval)
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
    end))
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
        u311 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit
    end
end)
LocalPlayerController.ThirdPersonChanged:Connect(function(p1) -- Line: 1151 -- upvalues: u294 (ref), peek (val), u212 (val), GameState (val)
    local v1
    if not p1 or u294 >= 1 then
        if not p1 and 1 <= u294 then
            u294 = 0
        end
        return
    end
    local v2 = peek(u212.Camera.MaxCameraDistance)
    if not GameState.Data.IsLobby then
        v1 = v2
    else
        v1 = v2 * 1.3
    end
    u294 = v1
end)
CameraEvent:SetClientListener(function(p1) -- Line: 1159 -- upvalues: u312 (val)
    if p1 and p1.Type == "SetEnabled" then
        u312:SetEnabled(p1.Enabled)
    end
end)
local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal(v3)
InstanceAddedSignal:Connect(function(p1) -- Line: 1165 -- upvalues: u290 (val)
    local v1 = 10
    while true do
        v1 = v1 - task.wait()
        if p1.Parent or v1 <= 0 then
            break
        end
    end
    if p1.Parent then
        print(p1.Parent)
    else
        print("cannot resolve vfx parent of", p1)
    end
    u290[p1] = p1.Parent
end)
local InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal(v3)
InstanceRemovedSignal:Connect(function(p1) -- Line: 1178 -- upvalues: u290 (val)
    u290[p1] = nil
end)
if game.ReplicatedStorage:FindFirstChild("Remotes") and game.ReplicatedStorage.common.Remotes:FindFirstChild("CameraShake") then
    game.ReplicatedStorage.common.Remotes.CameraShake.OnClientEvent:Connect(function(...) -- Line: 1186 -- upvalues: u312 (val)
        u312:Shake(...)
    end)
end
CameraShakeEvent:SetClientListener(function(p1) -- Line: 1191 -- upvalues: u312 (val)
    u312:Shake(unpack(p1))
end)
return u312