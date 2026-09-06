game:GetService("RunService")
game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local QuickChatUI = script.QuickChatUI
QuickChatUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local CurrentCamera = workspace.CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local Remotes = game.ReplicatedStorage.common:WaitForChild("Remotes")
local Net = Remotes:WaitForChild("Net")
local Controllers = game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers
local Frame = QuickChatUI:WaitForChild("Frame")
Frame.Visible = false
Frame:WaitForChild("Buttons")
local Icons = Frame:WaitForChild("Icons")
Frame:WaitForChild("Circlerotatepart")
local buttonSelected = Frame:WaitForChild("buttonSelected")
local TextChannels = TextChatService:WaitForChild("TextChannels")
local RBXSystem = TextChannels:WaitForChild("RBXSystem")
local u91 = {}
u91["8"] = {"Need Medic", "I need a medic!"}
u91["9"] = {"Need Ammo", "I'm out of rounds!"}
u91["10"] = {"Need Help", "Give me some help!"}
u91["1"] = {"Let's Move", "Let's move forward!"}
u91["2"] = {"Sorry", "Sorry"}
u91["3"] = {"Thanks", "Thanks. I owe you one."}
u91["11"] = {"Ping Location", "Look here."}
require(Controllers:WaitForChild("WeaponController"))
require(Controllers:WaitForChild("LocalPlayerController"))
require(Controllers.CameraController)
local u128 = {
    IsDisabled = function() -- Line: 56
        return true
    end,
}
local function color3ToHex(p1) -- Line: 60
    local v1 = math.floor(p1.R * 255 + 0.5)
    local v2 = math.clamp(v1, 0, 255)
    local v3 = math.floor(p1.G * 255 + 0.5)
    v1 = math.clamp(v3, 0, 255)
    local v4 = math.floor(p1.B * 255 + 0.5)
    v3 = math.clamp(v4, 0, 255)
    return string.format("#%02X%02X%02X", v2, v1, v3)
end
function u128.Init() -- Line: 67 -- upvalues: u128 (val), Net (val), color3ToHex (val), RBXSystem (val), TweenService (val), Icons (val)
    u128.Connections = {}
    u128.Activated = false
    u128.Cooldown = false
    Net.OnClientEvent:Connect(function(p1, p2, p3, p4, p5) -- Line: 74 -- upvalues: color3ToHex (upval), RBXSystem (upval), TweenService (upval), Icons (upval)
        if p1 ~= "Quickchat" then
            return
        else
            local Character = p2.Character
            if not Character then
                return
            end
            local u11 = Character:FindFirstChild("HumanoidRootPart")
            if not u11 then
                return
            end
            local v1 = color3ToHex(Color3.new(0, 0.97647, 0.521568))
            local v2 = string.format("<font face=\"SourceSansBold\" size=\"11\" color=\"%s\">%s says: %s</font>", v1, p2.Name, p4)
            RBXSystem:DisplaySystemMessage(v2, "systemMessage")
            local v3 = script.beepclear:Clone()
            v3.Parent = workspace
            v3:Play()
            game.Debris:AddItem(v3, 5)
            if p2 ~= game.Players.LocalPlayer then
                local u53 = script.ScreenMarker:Clone()
                u53.Parent = game.Players.LocalPlayer.PlayerGui
                local u63 = p5
                if not u63 then
                    u63 = u11.Position + Vector3.new(0, 5, 0)
                end
                local CurrentCamera = workspace.CurrentCamera
                local Frame = u53:WaitForChild("Frame")
                local OnScreenPos = Frame:WaitForChild("OnScreenPos")
                local OffScreenPos = Frame:WaitForChild("OffScreenPos")
                local UIScale = OnScreenPos.UIScale
                local v4 = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                TweenService:Create(UIScale, v4, {Scale = 0.9}):Play()
                local UIScale_2 = OffScreenPos.UIScale
                local v5 = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                TweenService:Create(UIScale_2, v5, {Scale = 0.9}):Play()
                local Alert = OnScreenPos.Alert
                local ImageLabel = OnScreenPos.ImageLabel
                ImageLabel.Image = Icons[p3].Image
                local u114 = 1
                local function Dot(p1, p2) -- Line: 123
                    return p1.X * p2.X + p1.Y * p2.Y + p1.Z * p2.Z
                end
                local function WorldToScreenPointProjected(p1) -- Line: 127 -- upvalues: CurrentCamera (val)
                    local v1
                    local lookVector = CurrentCamera.CFrame.lookVector
                    local v2 = p1 - CurrentCamera.CFrame.p
                    local v3 = lookVector.X * v2.X + lookVector.Y * v2.Y + lookVector.Z * v2.Z
                    if v3 > 0 then
                        v1 = p1
                    else
                        v1 = CurrentCamera.CFrame.p + (v2 - lookVector * v3 * 1.01)
                    end
                    return CurrentCamera:WorldToScreenPoint(v1)
                end
                local function ScreenPointEdgeClamp(p1, p2) -- Line: 139 -- upvalues: u53 (val)
                    local v1 = Vector2.new(u53.AbsoluteSize.X / 2, u53.AbsoluteSize.Y / 2)
                    local Unit = (p1 - v1).Unit
                    local v2 = math.atan2(Unit.X, Unit.Y)
                    local v3 = math.abs((v1.Y - p2) / math.cos(v2))
                    local v4 = v1.X - p2
                    local v5 = math.min(v3, (math.abs(v4 / math.cos(v2 + 1.5707963267948966))))
                    v4 = -math.deg(v2)
                    return v1 + Unit * v5, v4
                end
                local u120 = tick() + 8
                local u121 = false
                local u122 = nil
                return
            elseif p3 ~= "11" then
                return
            end
        end
    end)
end
function u128.ToggleActivate(p1, p2) end
function angleDifference(p1, p2) -- Line: 337
    local v1
    local v2 = p2 % 360 - p1 % 360
    if 180 < v2 then
        v1 = -360
    elseif v2 >= -180 then
        v1 = 0
    else
        v1 = 360
    end
    return v2 + v1
end
function findClosestPart(p1) -- Line: 344
    local v1, v2, v3
    local v4 = 10
    local v5 = 1
    local v6 = p1
    for i = 1, v4, v5 do
        v2 = i
        v3 = angleDifference(((v2 - 1) * 36 + 90) % 360, v6)
        if v3 < 36 and 0 <= v3 then
            if 4 <= v2 and v2 < 8 then
                v2 = 11
            end
            v1 = tostring(v2)
            if v1 ~= nil then
                return v1
            end
        end
    end
end
function changeText(p1) -- Line: 362 -- upvalues: u91 (val), buttonSelected (val)
    if u91[p1] then
        buttonSelected.Text = u91[p1][1]
    end
end
function GetMouseDirection(p1, p2) -- Line: 369 -- upvalues: CurrentCamera (val), Mouse (val)
    local v1
    local v2 = {}
    if p2 then
        for k, v in pairs(p2) do
            table.insert(v2, #v2 + 1, v)
        end
    end
    local v3 = CurrentCamera:ScreenPointToRay(Mouse.X, Mouse.Y)
    local v4 = Ray.new(v3.Origin, v3.Direction * 5000)
    _, v1 = workspace:FindPartOnRayWithIgnoreList(v4, {game.Players.LocalPlayer.Character, CurrentCamera, workspace.Ignore})
    return (v1 - p1).Unit, v1
end
function visibleButton(p1, p2) -- Line: 388
    if not (p1:IsA("Folder")) then
        p1.Visible = p2
        return
    end
    for k, v in pairs(p1:GetChildren()) do
        v.Visible = p2
    end
end
return u128