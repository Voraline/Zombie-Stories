local u100, u101, u99
local common = game.ReplicatedStorage.common
game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local WeaponCenter = script.WeaponModding.WeaponCenter
local UserInputService = game:GetService("UserInputService")
local SharedResources = game.ReplicatedStorage.common:WaitForChild("SharedResources")
local place = game.ReplicatedStorage:FindFirstChild("place")
local RedEvents = place
if RedEvents then
    RedEvents = place:FindFirstChild("RedEvents")
end
local MiscFunctions = require(script:WaitForChild("MiscFunctions"))
local ModdingGui = require(script:WaitForChild("ModdingGui"))
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local AttachmentsRoot = require(SharedResources.Attachments.AttachmentSystem.AttachmentsRoot)
local WepConfig = require(common.WepConfig)
local ItemData = require(common.ItemData)
local ModificationEvent = RedEvents
if ModificationEvent then
    ModificationEvent = RedEvents:FindFirstChild("ModificationEvent")
    if ModificationEvent then
        ModificationEvent = require(RedEvents.ModificationEvent)
    end
end
local u87 = false
local u88 = 0.3
local u90 = CFrame.new()
local u91 = 0
local u92 = 0
local u93 = false
local u94 = nil
local u95 = nil
local u96 = nil
u99, u100, u101 = MiscFunctions.moddingFuncs()
local function cancelDrag() -- Line: 43 -- upvalues: u87 (ref), u95 (ref)
    if u87 then
        u87 = false
    end
end
script.WeaponModding.Parent = workspace
local u106 = {
    ExitPressed = ModdingGui.ExitPressed,
    OptionGroupChanged = ModdingGui.OptionGroupChanged,
    getAttached = function() -- Line: 65 -- upvalues: ModdingGui (val)
        return ModdingGui.getAttached()
    end,
}
function u106.saveMods() -- Line: 69 -- upvalues: ModificationEvent (val), u106 (val)
    local v1, v2
    if not ModificationEvent then
        return
    end
    v1, v2 = u106.getAttached()
    ModificationEvent:FireServer({Type = "SetMods", ID = v2, SerializedMods = v1})
end
function u106.exitMod() -- Line: 79 -- upvalues: ModdingGui (val), u94 (ref), CurrentCamera (val)
    ModdingGui.exitMod()
    if u94 then
        u94:Destroy()
    end
    u94 = nil
    local TweenService = game:GetService("TweenService")
    local v1 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    TweenService:Create(CurrentCamera, v1, {FieldOfView = 70}):Play()
end
function u106.enterMod(p1, p2, p3, p4, p5, p6) -- Line: 94 -- upvalues: ItemData (val), u94 (ref), u106 (val), WepConfig (val), AttachmentsRoot (val), u99 (val), WeaponCenter (val), ModdingGui (val), CurrentCamera (val), u88 (ref), u101 (val), u96 (ref), u87 (ref), Mouse (val), u93 (ref), u100 (val), u90 (val)
    local BoundingBox_2
    local Name = ItemData.List[p1].Name
    if u94 then
        u106.exitMod()
    end
    local v1 = nil
    if p2 then
        local WeaponConfig = WepConfig:GetWeaponConfig(p1)
        if WeaponConfig then
            v1 = AttachmentsRoot.new(WeaponConfig, p2)
        end
    end
    if not p5 then
        u94 = u99(Name):Clone()
    else
        u94 = p5
    end
    u94.PrimaryPart.Anchored = true
    u94:PivotTo(WeaponCenter.CFrame)
    u94.Parent = workspace
    ModdingGui.loadGui(Name, u94, v1, p3, p4, p6)
    _, BoundingBox_2 = u94:WaitForChild("Weapon"):GetBoundingBox()
    local v2 = CFrame.Angles(0, 0, 0)
    local v3 = v2:VectorToObjectSpace(BoundingBox_2)
    local v4 = math.abs(v3.X)
    local v5 = math.abs(v3.Y) * 0.35
    local v6 = math.abs(v3.Z) * 0.35
    local v7 = CurrentCamera.ViewportSize.X * 0.85
    local v8 = v5 / (math.tan((math.rad(CurrentCamera.FieldOfView / 2))) * 2)
    if v5 < v4 then end
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    u88 = 0.3
    u101(u88)
    local v9 = WeaponCenter.Position + Vector3.new(0, 0, -5)
    local v10 = CFrame.new(v9, WeaponCenter.Position)
    CurrentCamera.CFrame = v10 * CFrame.new(0, 0, v8 + v6 / 2)
    local u145 = 0
    local u146 = 0
    local u147 = nil
    local u148 = nil
    if u96 then
        u96:Disconnect()
        u96 = nil
    end
    u96 = game:GetService("RunService").RenderStepped:connect(function() -- Line: 143 -- upvalues: u87 (upval), u94 (upval), Mouse (upval), u145 (ref), u146 (ref), u93 (upval), u147 (ref), u148 (ref), u100 (upval), u90 (upval), WeaponCenter (upval)
        local v1, v2
        if u87 and u94 then
            local v3
            v1 = Vector2.new(Mouse.X - u145, Mouse.Y - u146)
            u145 = Mouse.X
            u146 = Mouse.Y
            if u93 then
                v1 = Vector2.new()
                u93 = false
            end
            v2, v3 = u100(v1)
            u147 = v2
            u148 = v3
        end
        if u94 and u147 and u148 then
            local Pivot = u94:GetPivot()
            local v4 = CFrame.fromAxisAngle(u147, u148 * 0.1)
            u94:PivotTo(v4 * Pivot.Rotation + Pivot.Position)
            u148 = u148 * 0.9
        end
        v1 = (os.clock() - 0) / 0.4
        if u94 and u90 and v1 <= 1 then
            v2 = u90:lerp(WeaponCenter.CFrame, v1)
            u94:PivotTo(v2)
        end
    end)
end
function init() -- Line: 168 -- upvalues: Mouse (val), u94 (ref), u88 (ref), u101 (val), UserInputService (val), u93 (ref), u91 (ref), u92 (ref), u87 (ref), u95 (ref), ModdingGui (val)
    Mouse.WheelForward:connect(function() -- Line: 169 -- upvalues: u94 (upval), u88 (upval), u101 (upval)
        if u94 then
            u88 = math.max(0, u88 - 0.1)
            u101(u88)
        end
    end)
    Mouse.WheelBackward:connect(function() -- Line: 175 -- upvalues: u94 (upval), u88 (upval), u101 (upval)
        if u94 then
            u88 = math.min(1, u88 + 0.1)
            u101(u88)
        end
    end)
    UserInputService.InputBegan:Connect(function(p1, p2) -- Line: 188 -- upvalues: u93 (upval), u91 (upval), u92 (upval), u94 (upval), u87 (upval), u95 (upval)
        if p2 then
            return
        end
        if p1.UserInputType == Enum.UserInputType.MouseButton2 then
            u93 = true
            if p1.UserInputType == Enum.UserInputType.Touch then
                u91 = p1.Position.X
                u92 = p1.Position.Y
            end
            if u94 then
                u87 = true
                u95 = math.floor(os.clock() * 100)
            end
        elseif p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Touch then
        end
    end)
    UserInputService.InputEnded:Connect(function(p1, p2) -- Line: 203 -- upvalues: u87 (upval), u95 (upval)
        if p1.UserInputType == Enum.UserInputType.MouseButton2 then
            if u87 then
                u87 = false
            end
        elseif p1.UserInputType == Enum.UserInputType.MouseButton1 then
            if u87 then
                u87 = false
            end
        elseif p1.UserInputType == Enum.UserInputType.Touch and u87 then
            u87 = false
        end
    end)
    ModdingGui.init()
end
init()
return u106