game:GetService("RunService")
game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local QuickChatUI = script.QuickChatUI
QuickChatUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local CurrentCamera = workspace.CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local Net = (game.ReplicatedStorage.common:WaitForChild("Remotes")):WaitForChild("Net")
local Controllers = game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers
local Frame = QuickChatUI:WaitForChild("Frame")
Frame.Visible = false
Frame:WaitForChild("Buttons")
local Icons = Frame:WaitForChild("Icons")
Frame:WaitForChild("Circlerotatepart")
local buttonSelected = Frame:WaitForChild("buttonSelected")
local RBXSystem = (TextChatService:WaitForChild("TextChannels")):WaitForChild("RBXSystem")
local u91 = {
    ["8"] = {"Need Medic", "I need a medic!"},
    ["9"] = {"Need Ammo", "I'm out of rounds!"},
    ["10"] = {"Need Help", "Give me some help!"},
    ["1"] = {"Let's Move", "Let's move forward!"},
    ["2"] = {"Sorry", "Sorry"},
    ["3"] = {"Thanks", "Thanks. I owe you one."},
    ["11"] = {"Ping Location", "Look here."},
}
require(Controllers:WaitForChild("WeaponController"))
require(Controllers:WaitForChild("LocalPlayerController"))
require(Controllers.CameraController)
local u128 = {}

function u128.IsDisabled() -- Line: 56
    return true
end

local function color3ToHex(p1) -- Line: 60
    local v1 = p1.R * 255 + 0.5
    local v2 = math.floor(v1)
    local v3 = math.clamp(v2, 0, 255)
    local v4 = p1.G * 255 + 0.5
    v1 = math.floor(v4)
    v2 = math.clamp(v1, 0, 255)
    local v5 = p1.B * 255 + 0.5
    v4 = math.floor(v5)
    v1 = math.clamp(v4, 0, 255)
    return string.format("#%02X%02X%02X", v3, v2, v1)
end

function u128.Init() -- Line: 67
    -- upvalues: u128 (val), Net (val), color3ToHex (val), RBXSystem (val), TweenService (val), Icons (val)
    u128.Connections = {}
    u128.Activated = false
    u128.Cooldown = false
    local v1 = Net
    v1.OnClientEvent:Connect(function(p1, p2, p3, p4, p5) -- Line: 74
        -- upvalues: color3ToHex (upval), RBXSystem (upval), TweenService (upval), Icons (upval)
        if p1 == "Quickchat" then
            local Character = p2.Character
            if not Character then
                return
            end
            local u11 = Character:FindFirstChild("HumanoidRootPart")
            if not u11 then
                return
            end
            local v1 = string.format(
                "<font face=\"SourceSansBold\" size=\"11\" color=\"%s\">%s says: %s</font>",
                color3ToHex(Color3.new(0, 0.97647, 0.521568)),
                p2.Name,
                p4
            )
            RBXSystem:DisplaySystemMessage(v1, "systemMessage")
            local v2 = script.beepclear:Clone()
            v2.Parent = workspace
            v2:Play()
            game.Debris:AddItem(v2, 5)
            if p2 == game.Players.LocalPlayer and p3 ~= "11" then
                return
            end
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
            local v3 = TweenService
            local UIScale = OnScreenPos.UIScale
            local v4 = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            v3:Create(UIScale, v4, {Scale = 0.9}):Play()
            local v5 = TweenService
            local UIScale_2 = OffScreenPos.UIScale
            local v6 = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            v5:Create(UIScale_2, v6, {Scale = 0.9}):Play()
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
                local v3 = lookVector.X * v2.X + lookVector.Y * v2.Y
                local v4 = v3 + lookVector.Z * v2.Z
                if not (v4 <= 0) then
                    v1 = p1
                else
                    v3 = lookVector * v4 * 1.01
                    v1 = CurrentCamera.CFrame.p + (v2 - v3)
                end
                return CurrentCamera:WorldToScreenPoint(v1)
            end

            local function ScreenPointEdgeClamp(p1, p2) -- Line: 139 -- upvalues: u53 (val)
                local v1 = Vector2.new(u53.AbsoluteSize.X / 2, u53.AbsoluteSize.Y / 2)
                local Unit = (p1 - v1).Unit
                local X = Unit.X
                local Y = Unit.Y
                local v2 = math.atan2(X, Y)
                local v3 = (v1.Y - p2) / (math.cos(v2))
                local v4 = math.abs(v3)
                local v5 = v1.X - p2
                local v6 = v2 + 1.5707963267948966
                local v7 = v5 / (math.cos(v6))
                v3 = math.abs(v7)
                v7 = math.min(v4, v3)
                v5 = -math.deg(v2)
                return v1 + Unit * v7, v5
            end

            local u120 = tick() + 8
            local u121 = false
            local u122 = nil
            local v7 = (game:GetService("RunService")).RenderStepped:Connect(function(p1) -- Line: 156
                -- upvalues: u120 (val), u121 (ref), OnScreenPos (val), OffScreenPos (val), TweenService (upval)
                -- upvalues: u122 (ref), u53 (val), u114 (ref), Alert (val), ImageLabel (val), u63 (ref)
                -- upvalues: CurrentCamera (val), ScreenPointEdgeClamp (val), p5 (val), u11 (ref)
                local v1, v2, v3, v4, v5
                local v6 = tick()
                if u120 < v6 then
                    if not u121 then
                        u121 = true
                        if OnScreenPos.Parent and OffScreenPos.Parent then
                            v6 = TweenService
                            v2 = OnScreenPos
                            local UIScale = v2.UIScale
                            v3 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
                            v6:Create(UIScale, v3, {Scale = 0}):Play()
                            v1 = TweenService
                            v3 = OffScreenPos
                            local UIScale_2 = v3.UIScale
                            v4 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
                            v1:Create(UIScale_2, v4, {Scale = 0}):Play()
                        end
                    elseif not OnScreenPos
                        or u121 and OnScreenPos and OnScreenPos.Parent and OnScreenPos.UIScale.Scale < 0.01 then
                        u122:Disconnect()
                        u53:Destroy()
                    end
                end
                if u114 ~= 1 then
                    if u114 == 2 and Alert.ImageTransparency == 0 then
                        v6 = TweenService
                        v2 = Alert
                        v3 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                        v6:Create(v2, v3, {ImageTransparency = 1}):Play()
                        v1 = TweenService
                        v3 = ImageLabel
                        v4 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                        v1:Create(v3, v4, {ImageTransparency = 0}):Play()
                        u114 = 1
                    end
                elseif Alert.ImageTransparency == 1 then
                    v6 = TweenService
                    v2 = Alert
                    v3 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                    v6:Create(v2, v3, {ImageTransparency = 0}):Play()
                    v1 = TweenService
                    v3 = ImageLabel
                    v4 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                    v1:Create(v3, v4, {ImageTransparency = 1}):Play()
                    u114 = 2
                elseif u114 == 2 and Alert.ImageTransparency == 0 then
                    v6 = TweenService
                    v2 = Alert
                    v3 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                    v6:Create(v2, v3, {ImageTransparency = 1}):Play()
                    v1 = TweenService
                    v3 = ImageLabel
                    v4 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                    v1:Create(v3, v4, {ImageTransparency = 0}):Play()
                    u114 = 1
                end
                v2 = u63
                local lookVector = CurrentCamera.CFrame.lookVector
                v4 = v2 - CurrentCamera.CFrame.p
                local v7 = lookVector.X * v4.X + lookVector.Y * v4.Y
                local v8 = v7 + lookVector.Z * v4.Z
                if v8 <= 0 then
                    v7 = lookVector * v8 * 1.01
                    v2 = CurrentCamera.CFrame.p + (v4 - v7)
                end
                v7, v5 = CurrentCamera:WorldToScreenPoint(v2)
                v6 = v7
                if v5 or not Alert.Parent then
                    if Alert.Parent and ImageLabel.Parent then
                        Alert.Parent = OnScreenPos
                        ImageLabel.Parent = OnScreenPos
                        OnScreenPos.Visible = true
                        OffScreenPos.Visible = false
                        v2 = v6.X - OnScreenPos.Size.X.Offset / 2
                        v3 = v6.Y - OnScreenPos.Size.Y.Offset / 2
                        OnScreenPos.Position = UDim2.new(0.25, v2, 0.25, v3)
                    end
                elseif ImageLabel.Parent then
                    OnScreenPos.Visible = false
                    OffScreenPos.Visible = true
                    v2 = ScreenPointEdgeClamp
                    v2 = v2(Vector2.new(v6.X, v6.Y), 30)
                    v4 = v2.X - OffScreenPos.Size.X.Offset / 2
                    v8 = v2.Y - OffScreenPos.Size.Y.Offset / 2
                    OffScreenPos.Position = UDim2.new(0.25, v4, 0.25, v8)
                    Alert.Parent = OffScreenPos
                    ImageLabel.Parent = OffScreenPos
                elseif Alert.Parent and ImageLabel.Parent then
                    Alert.Parent = OnScreenPos
                    ImageLabel.Parent = OnScreenPos
                    OnScreenPos.Visible = true
                    OffScreenPos.Visible = false
                    v2 = v6.X - OnScreenPos.Size.X.Offset / 2
                    v3 = v6.Y - OnScreenPos.Size.Y.Offset / 2
                    OnScreenPos.Position = UDim2.new(0.25, v2, 0.25, v3)
                end
                if OnScreenPos and OnScreenPos.Parent then
                    if not p5 and u11 and not u11.Parent then
                        u122:Disconnect()
                        u53:Destroy()
                        return
                    end
                    if not p5 and u11.Parent then
                        u63 = u11.Position + Vector3.new(0, 4, 0)
                    end
                    return
                end
                u122:Disconnect()
                u53:Destroy()
            end)
        end
    end)
end

function u128.ToggleActivate(p1, p2) end

function angleDifference(p1, p2) -- Line: 337
    local v1
    local v2 = p1 % 360
    local v3 = p2 % 360 - v2
    if 180 < v3 then
        v1 = -360
    elseif not (v3 < -180) then
        v1 = 0
    else
        v1 = 360
    end
    return v3 + v1
end

function findClosestPart(p1) -- Line: 344
    local v1, v2, v3, v4, v5
    local v6 = p1
    for i = 1, 10 do
        v2 = i
        v3 = ((v2 - 1) * 36 + 90) % 360
        v4 = v3 + 36
        v5 = angleDifference(v3, v6)
        if v5 < 36 and 0 <= v5 then
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
    local v1 = {}
    if p2 then
        local v2
        for k, v in pairs(p2) do
            v2 = #v1 + 1
            table.insert(v1, v2, v)
        end
    end
    local v3 = CurrentCamera
    local v4 = Mouse
    local X = v4.X
    local v5 = Mouse
    local Y = v5.Y
    v3 = v3:ScreenPointToRay(X, Y)
    local v6 = Ray.new(v3.Origin, v3.Direction * 5000)
    v4 = workspace
    local v7 = {game.Players.LocalPlayer.Character, CurrentCamera, workspace.Ignore}
    _, v5 = v4:FindPartOnRayWithIgnoreList(v6, v7)
    return (v5 - p1).Unit, v5
end

function visibleButton(p1, p2) -- Line: 388
    if not p1:IsA("Folder") then
        p1.Visible = p2
        return
    end
    for k, v in pairs(p1:GetChildren()) do
        v.Visible = p2
    end
end

return u128