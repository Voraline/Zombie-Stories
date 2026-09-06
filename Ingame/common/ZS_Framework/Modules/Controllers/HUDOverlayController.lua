game:GetService("UserInputService")
local Players = game:GetService("Players")
local common = game.ReplicatedStorage.common
local HUDOverlay = script:WaitForChild("HUDOverlay")
local ModalButton = HUDOverlay:WaitForChild("ModalButton")
local Scoreboard = HUDOverlay:WaitForChild("Scoreboard")
local ScrollingFrame = Scoreboard:WaitForChild("ScrollingFrame")
local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts")
local FrameworkEvent = PlayerScripts:WaitForChild("FrameworkEvent")
local Remotes = game.ReplicatedStorage.common:WaitForChild("Remotes")
local Net = Remotes:WaitForChild("Net")
local CameraController = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.CameraController)
local u67 = workspace:GetAttribute("IsArcade") or false
local AttributeChangedSignal = workspace:GetAttributeChangedSignal("IsArcade")
AttributeChangedSignal:Connect(function() -- Line: 16 -- upvalues: u67 (ref)
    u67 = workspace:GetAttribute("IsArcade") or false
end)
local Icon = require(common.Icon)
local PlayerRoles = require(common.ZS_Shared.Data.PlayerRoles)
local u85 = false
local u86 = true
local u87 = true
local u88 = {}
local u89 = nil
HUDOverlay.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local u97 = {
    SetVisible = function(p1, p2) -- Line: 37 -- upvalues: u86 (ref), u85 (ref), HUDOverlay (val), ModalButton (val), CameraController (val)
        if not u86 then
            u85 = false
            HUDOverlay.Enabled = false
            ModalButton.Modal = false
            CameraController:SetMouseUnlocked("Leaderboard", false)
            CameraController:MouseIconEnabled("Leaderboard", false)
            return
        end
        u85 = p2
        HUDOverlay.Enabled = p2
        ModalButton.Modal = p2
        CameraController:SetMouseUnlocked("Leaderboard", p2)
        CameraController:MouseIconEnabled("Leaderboard", p2)
    end,
}
function u97.SetEnabled(p1, p2) -- Line: 55 -- upvalues: u86 (ref), u89 (ref), u97 (val)
    u86 = p2
    if u89 then
        u89:setEnabled(p2)
    end
    if not p2 then
        u97:SetVisible(false)
    end
end
function u97.IsVisible(p1) -- Line: 66 -- upvalues: u85 (ref)
    return u85
end
local v1 = Icon.new():setImage(2246486837)
v1 = v1:bindEvent("selected", function(p1) -- Line: 91 -- upvalues: u97 (val)
    u97:SetVisible(true)
end)
FrameworkEvent.Event:Connect(function(p1, p2, p3) -- Line: 99 -- upvalues: u87 (ref)
    if p1 == "SettingsUpdated" and p3 and type(p3) == "table" and p3.HUDOverlayToggleMode ~= nil then
        u87 = p3.HUDOverlayToggleMode
    end
end)
local u123 = {
    Assault = "rbxassetid://4458718282",
    Medic = "rbxassetid://2706886795",
    Sniper = "rbxassetid://4458692655",
    Support = "rbxassetid://2706886028",
    Unknown = "rbxassetid://4458718282",
    Arcade = "rbxassetid://112766246588072",
}
local function countPlayerListItems() -- Line: 115 -- upvalues: ScrollingFrame (val)
    local v1
    local v2 = 0
    for k, v in pairs(ScrollingFrame:GetChildren()) do
        if v:IsA("Frame") then
            if not v.Visible then
                v1 = 0
            else
                v1 = 1
            end
            v2 = v2 + v1
        end
    end
    return v2
end
local function ShiftLeaderboard() -- Line: 125 -- upvalues: u88 (val), u123 (val), countPlayerListItems (val), ScrollingFrame (val), Scoreboard (val)
    local PaddedFrame
    for k, v in pairs(u88) do
        PaddedFrame = v.UI.PaddedFrame
        v.UI.LayoutOrder = -math.floor(v.Score) - 2
        PaddedFrame.Header.ClassLevelLabel.Text = v.Level
        PaddedFrame.Stats.ScoreLabel.Text = string.format("%.0f", v.Score)
        PaddedFrame.Stats.KillsLabel.Text = v.Kills
        PaddedFrame.Stats.DownsLabel.Text = v.Downs
        PaddedFrame.Header.ClassIcon.Image = u123[v.Class]
    end
    local v1 = countPlayerListItems()
    local v2 = math.min(v1, 6)
    ScrollingFrame.Size = UDim2.new(1, 0, v2 * 0.1, 0)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, v1 * 0.1, 0)
    Scoreboard.Header.Position = UDim2.new(0, 0, (6 - v2) * 0.0491666666666667 + 0.225, 0)
end
local function CreateNewTemplate(p1, p2) -- Line: 144 -- upvalues: u88 (val), ScrollingFrame (val), u123 (val), ShiftLeaderboard (val), Players (val), PlayerRoles (val)
    local DisplayName, v1
    if not (workspace:FindFirstChild("LoadingStatus")) or u88[p1] then
        return
    end
    local v2 = ScrollingFrame.Template:Clone()
    if p2 then
        v1 = p2
    else
        v1 = {}
    end
    u88[p1] = {
        Class = "Assault",
        UI = v2,
        Level = v1.Level or 0,
        Score = v1.Score or 0,
        Kills = v1.Kills or 0,
        Downs = v1.Downs or 0,
    }
    local PaddedFrame = v2:WaitForChild("PaddedFrame")
    local v3 = workspace.LoadingStatus.Players:WaitForChild(p1.Name)
    local Class = v3:WaitForChild("Class")
    local Level = v3:WaitForChild("Level")
    local function updateClassAndLevel() -- Line: 169 -- upvalues: u88 (upval), p1 (val), Class (val), Level (val), PaddedFrame (val), u123 (upval), ShiftLeaderboard (upval)
        local v1 = u88[p1]
        v1.Class = Class.Value
        v1 = u88[p1]
        v1.Level = Level.Value
        PaddedFrame.Header.ClassIcon.Image = u123[Class.Value]
        ShiftLeaderboard()
    end
    local v4 = u88[p1]
    v4.Class = Class.Value
    v4 = u88[p1]
    v4.Level = Level.Value
    PaddedFrame.Header.ClassIcon.Image = u123[Class.Value]
    ShiftLeaderboard()
    Class.Changed:Connect(updateClassAndLevel)
    Level.Changed:Connect(updateClassAndLevel)
    v2.Visible = true
    v2.Name = p1.Name
    local u77 = Players:FindFirstChild(p1.Name)
    if not u77 then
        DisplayName = p1.Name
    else
        DisplayName = u77.DisplayName
    end
    local DisplayNameLabel = PaddedFrame:WaitForChild("DisplayNameLabel")
    local RoleIcon = DisplayNameLabel:FindFirstChild("RoleIcon")
    if not RoleIcon then
        RoleIcon = Instance.new("ImageLabel")
        RoleIcon.Name = "RoleIcon"
        RoleIcon.AnchorPoint = Vector2.new(0, 0.5)
        RoleIcon.Position = UDim2.new(1, 3, 0.5, 0)
        RoleIcon.Size = UDim2.fromOffset(14, 14)
        RoleIcon.BackgroundTransparency = 1
        RoleIcon.ZIndex = DisplayNameLabel.ZIndex + 1
        RoleIcon.Parent = DisplayNameLabel
    end
    local function applyRole() -- Line: 197 -- upvalues: PlayerRoles (upval), u77 (val), DisplayNameLabel (val), RoleIcon (ref)
        local Color, Image
        local Attribute = u77
        if Attribute then
            Attribute = u77:GetAttribute("ZSRoleId")
        end
        local UI = PlayerRoles.Get(Attribute).UI
        if not UI then
            UI = PlayerRoles.Default
        end
        local Attribute_2 = u77
        if Attribute_2 then
            Attribute_2 = u77:GetAttribute("ZSRoleId")
        end
        local v1 = u77
        if v1 then
            v1 = u77:GetAttribute("ZSVerified") == true
        end
        local v2 = u77
        if v2 then
            v2 = u77:GetAttribute("ZSPremium") == true
        end
        local v3 = PlayerRoles.ResolveDisplayIcon(Attribute_2, v1, v2)
        DisplayNameLabel.TextColor3 = UI.Name
        local v4 = RoleIcon
        if not v3 then
            Image = ""
        else
            Image = v3.Image
        end
        v4.Image = Image
        v4 = RoleIcon
        if not v3 then
            if not v3 then
                Color = UI.Name
            else
                Color = v3.Color
                if not Color then
                    Color = UI.Name
                end
            end
        elseif v3.Tint == false then
            Color = Color3.new(1, 1, 1)
        end
        v4.ImageColor3 = Color
        v1 = v3 ~= nil
        RoleIcon.Visible = v1
    end
    PaddedFrame.NameLabel.Text = "@" .. p1.Name
    DisplayNameLabel.Text = DisplayName
    PaddedFrame.Header.ClassIcon.Image = u123[Class.Value]
    if not u77 then
        PaddedFrame.Header.HeadshotLabel.Image = "rbxassetid://5650877971"
    else
        PaddedFrame.Header.HeadshotLabel.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. u77.UserId .. "&width=420&height=420&format=png"
    end
    applyRole()
    if u77 then
        local AttributeChangedSignal = u77:GetAttributeChangedSignal("ZSRoleId")
        AttributeChangedSignal:Connect(applyRole)
        local AttributeChangedSignal_2 = u77:GetAttributeChangedSignal("ZSVerified")
        AttributeChangedSignal_2:Connect(applyRole)
        local AttributeChangedSignal_3 = u77:GetAttributeChangedSignal("ZSPremium")
        AttributeChangedSignal_3:Connect(applyRole)
    end
    v2.Parent = ScrollingFrame
    ShiftLeaderboard()
end
local function UpdateStats(p1, p2, p3) -- Line: 235 -- upvalues: u88 (val), Net (val), ShiftLeaderboard (val)
    if not (u88[p1]) then
        Net:FireServer("GetLDB")
        return
    end
    u88[p1][p2] = p3
    ShiftLeaderboard()
end
Net.OnClientEvent:Connect(function(p1, ...) -- Line: 244 -- upvalues: u88 (val), Net (val), ShiftLeaderboard (val), CreateNewTemplate (val)
    local v1
    local v2 = {...}
    if p1 == "UpdLDB" then
        v1 = v2[1]
        if not (u88[v1]) then
            Net:FireServer("GetLDB")
            return
        end
        u88[v1][v2[2]] = v2[3]
        ShiftLeaderboard()
        return
    end
    if p1 == "NewLDB" then
        CreateNewTemplate(v2[1])
        return
    end
    if p1 == "GetLDB" then
        local v3
        v1 = v2[1]
        local v4 = nil
        local v5 = nil
        for i, j in v1, v4, v5 do
            v3 = game.Players:FindFirstChild(i)
            if v3 then
                CreateNewTemplate(v3, j)
            end
        end
    end
end)
Net:FireServer("GetLDB")
game.Players.PlayerRemoving:Connect(function(p1) -- Line: 262 -- upvalues: u88 (val), u67 (ref)
    if not (u88[p1]) then
        return
    end
    local UI = u88[p1].UI
    UI.PaddedFrame.Left.Visible = true
    if not u67 then
        task.delay(180, function() -- Line: 271 -- upvalues: UI (val)
            if UI.PaddedFrame.Left.Visible then
                UI.Visible = false
            end
        end)
        return
    end
    u88[p1].UI:Destroy()
    u88[p1] = nil
end)
game.Players.PlayerAdded:Connect(function(p1) -- Line: 280 -- upvalues: u88 (val), ShiftLeaderboard (val)
    if u88[p1] then
        local UI = u88[p1].UI
        UI.PaddedFrame.Left.Visible = false
        UI.Visible = true
        ShiftLeaderboard()
    end
end)
ShiftLeaderboard()
return u97