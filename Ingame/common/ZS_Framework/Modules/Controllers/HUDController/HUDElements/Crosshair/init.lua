local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local CrosshairUI = script:WaitForChild("CrosshairUI")
local HitMarkLense = script:WaitForChild("HitMarkLense")
local Crosshair = HitMarkLense:WaitForChild("Crosshair")
local Hitmarker = Crosshair:WaitForChild("Hitmarker")
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local SpriteClip = require(script:WaitForChild("SpriteClip"))
local LocalPlayerController = require(script.Parent.Parent.Parent:WaitForChild("LocalPlayerController"))
local Utils = script.Parent.Parent.Parent.Parent:WaitForChild("Utils")
local CursorRecoilUtil = require(Utils:WaitForChild("CursorRecoilUtil"))
local ArmorIcon = CrosshairUI.Crosshair.ArmorIcon
local v1 = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local u79 = TweenService:Create(ArmorIcon, v1, {ImageTransparency = 1})
local u80 = {}
local Crosshair_2 = CrosshairUI:WaitForChild("Crosshair")
local A = Crosshair_2:WaitForChild("A")
u80[A] = Vector2.new(0, -1)
local B = CrosshairUI.Crosshair:WaitForChild("B")
u80[B] = Vector2.new(0, 1)
local C = CrosshairUI.Crosshair:WaitForChild("C")
u80[C] = Vector2.new(-1, 0)
local D = CrosshairUI.Crosshair:WaitForChild("D")
u80[D] = Vector2.new(1, 0)
local u121 = SpriteClip.new()
u121.InheritSpriteSheet = true
u121.SpriteSizePixel = Vector2.new(341.3333333333333, 341.3333333333333)
u121.SpriteCountX = 3
u121.SpriteCount = 9
u121.FrameRate = 60
u121.CurrentFrame = 9
u121.Looped = false
CrosshairUI.Parent = game.Players.LocalPlayer.PlayerGui
HitMarkLense.Parent = game.Players.LocalPlayer.PlayerGui
local Crosshair_3 = CrosshairUI:WaitForChild("Crosshair")
u121.Adornee = Crosshair_3:WaitForChild("SpriteLabel")
CrosshairUI.Crosshair.Visible = false
CrosshairUI.NoWeaponCursor.Visible = false
local u152 = {IsShowing = true}
local u154 = "dot"
function u152.Show(p1) -- Line: 51 -- upvalues: u152 (val), CrosshairUI (val)
    u152.IsShowing = true
    CrosshairUI.Enabled = true
end
function u152.Hide(p1) -- Line: 56 -- upvalues: u152 (val), CrosshairUI (val)
    u152.IsShowing = false
    CrosshairUI.Enabled = false
end
function u152.SetType(p1, p2) -- Line: 61 -- upvalues: u154 (ref), CrosshairUI (val), LocalPlayerController (val)
    u154 = p2
    if p2 == "cross" then
        CrosshairUI.Crosshair.Visible = true
        CrosshairUI.NoWeaponCursor.Visible = false
        return
    end
    if p2 == "dot" then
        CrosshairUI.Crosshair.Visible = false
        CrosshairUI.NoWeaponCursor.Visible = not LocalPlayerController.ThirdPerson
    end
end
function u152.SetCrossVisible(p1, p2) -- Line: 73 -- upvalues: u80 (val)
    local v1 = u80
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        i.Visible = p2
    end
end
function u152.UpdateCrosshairColor(p1, p2) -- Line: 79 -- upvalues: u80 (val)
    local v1 = u80
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        i.Frame.BackgroundColor3 = p2
    end
end
function u152.UpdateCrosshair(p1, p2, p3) -- Line: 85 -- upvalues: CursorRecoilUtil (val), CrosshairUI (val), u80 (val)
    local v1 = true
    local crosshairRecoil = CursorRecoilUtil.crosshairRecoil
    local ViewportSize = workspace.CurrentCamera.ViewportSize
    CrosshairUI.Crosshair.Position = UDim2.new(0.5, p3.X + crosshairRecoil.X * ViewportSize.X, 0.5, p3.Y + -crosshairRecoil.Y * ViewportSize.Y)
    if not p2.ReloadingTime then
        CrosshairUI.Crosshair.ReloadIcon.Visible = false
    elseif not p2.Reloaded then
        v1 = false
        CrosshairUI.Crosshair.ReloadIcon.Visible = true
        CrosshairUI.Crosshair.ReloadIcon.ImageTransparency = math.sin(os.clock() * 10) / 2.5 + 0.4
    end
    local v2 = u80
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        i.Visible = v1
    end
    local Inaccuracy = p2.Inaccuracy
    v3 = u80
    v4 = nil
    local v5 = nil
    for k, n in v3, v4, v5 do
        k.Position = UDim2.new(0, n.X * Inaccuracy, 0, n.Y * Inaccuracy)
    end
end
function u152.HitmarkerUpdateLense(p1, p2) -- Line: 108 -- upvalues: u121 (val), Hitmarker (val), HitMarkLense (val), CrosshairUI (val)
    if not p2 or not p2.Parent then
        u121.Adornee.Parent = CrosshairUI.Crosshair
        HitMarkLense.Enabled = false
        return
    end
    u121.Adornee.Parent = Hitmarker
    HitMarkLense.Enabled = true
    local Position = p2.Position
    local v1 = p2:FindFirstAncestorWhichIsA("Part")
    local v2 = Vector2.new(Position.X.Scale, Position.Y.Scale)
    local v3 = v1.CFrame * CFrame.new(-(v1.Size.X / 2) + v1.Size.X * v2.X, v1.Size.Y / 2 - v1.Size.Y * v2.Y, 0)
    local v4 = workspace.Camera:WorldToScreenPoint(v3.p)
    Hitmarker.Position = UDim2.new(0, v4.X, 0, v4.Y)
end
local function playSoundRandom(p1) -- Line: 125 -- upvalues: SoundService (val)
    local v1 = p1.PlaybackSpeed * 100
    p1.PlaybackSpeed = math.random(v1 - 5, v1 + 5) / 100
    p1.Parent = SoundService
    p1:Play()
    task.delay(5, function() -- Line: 132 -- upvalues: p1 (val)
        p1:Destroy()
    end)
end
function u152.EmitHitmarker(p1, p2, p3, p4) -- Line: 137 -- upvalues: u79 (val), CrosshairUI (val), playSoundRandom (val), SoundService (val), u121 (val)
    local v1 = p2
    if not v1 then
        v1 = Color3.new(1, 1, 1)
    end
    local v2 = v1
    if p3 == "HitArmor" then
        u79:Cancel()
        CrosshairUI.Crosshair.ArmorIcon.Image = "rbxassetid://9021696258"
        CrosshairUI.Crosshair.ArmorIcon.ImageTransparency = -2
        local ArmorIcon = CrosshairUI.Crosshair.ArmorIcon
        ArmorIcon.ImageColor3 = Color3.new(1, 1, 1)
        u79:Play()
        v1 = script.Parent.Parent.Resources.hitarmor:Clone()
        v1.Volume = 1
        playSoundRandom(v1)
    elseif p3 == "BrokeArmor" then
        u79:Cancel()
        CrosshairUI.Crosshair.ArmorIcon.Image = "rbxassetid://9021696096"
        local ArmorIcon_2 = CrosshairUI.Crosshair.ArmorIcon
        ArmorIcon_2.ImageColor3 = Color3.new(0, 0.65098, 1)
        CrosshairUI.Crosshair.ArmorIcon.ImageTransparency = -2
        u79:Play()
        v1 = script.Parent.Parent.Resources.breakarmor:Clone()
        v1.Volume = 4.5
        playSoundRandom(v1)
    else
        local u94
        if not p4 then
            u94 = script.Parent.Parent.Resources.hitmarker:Clone()
            u94.Parent = SoundService
            u94:Play()
            task.delay(5, function() -- Line: 166 -- upvalues: u94 (val)
                u94:Destroy()
            end)
        elseif not p4.dontDoSound then
            u94 = script.Parent.Parent.Resources.hitmarker:Clone()
            u94.Parent = SoundService
            u94:Play()
            task.delay(5, function() -- Line: 166 -- upvalues: u94 (val)
                u94:Destroy()
            end)
        end
    end
    if p3 ~= "HitArmor" then
        u121.Adornee.Visible = true
        u121.Adornee.ImageColor3 = v2
        u121:Play()
    end
end
LocalPlayerController.ThirdPersonChanged:Connect(function(p1) -- Line: 179 -- upvalues: u152 (val), u154 (ref)
    u152:SetType(u154)
end)
task.defer(function() -- Line: 186 -- upvalues: LocalPlayerController (val), u152 (val)
    if LocalPlayerController.CurrentWeapon then
        u152:SetType("cross")
        return
    end
    u152:SetType("dot")
end)
return u152