local SoundService = game:GetService("SoundService")
local v1 = {}
local HitMarkLense = script:WaitForChild("HitMarkLense")
local Crosshair = HitMarkLense:WaitForChild("Crosshair")
local Hitmarker = Crosshair:WaitForChild("Hitmarker")
HitMarkLense.Parent = game.Players.LocalPlayer.PlayerGui
local SpriteClip = require(script:WaitForChild("SpriteClip"))
local TweenService = game:GetService("TweenService")
local u36 = SpriteClip.new()
u36.InheritSpriteSheet = true
u36.SpriteSizePixel = Vector2.new(341.3333333333333, 341.3333333333333)
u36.SpriteCountX = 3
u36.SpriteCount = 9
u36.FrameRate = 60
u36.CurrentFrame = 9
u36.Looped = false
local u47 = nil
local u48 = nil
function v1.Init(p1, p2) -- Line: 25 -- upvalues: u47 (ref), u36 (val), u48 (ref), TweenService (val)
    u47 = p2
    local Crosshair = u47:WaitForChild("Crosshair")
    u36.Adornee = Crosshair:WaitForChild("SpriteLabel")
    local v1 = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    u48 = TweenService:Create(u47.Crosshair.ArmorIcon, v1, {ImageTransparency = 1})
end
function v1.UpdateLense(p1, p2) -- Line: 31 -- upvalues: u36 (val), Hitmarker (val), HitMarkLense (val), u47 (ref)
    if not p2 or not p2.Parent then
        u36.Adornee.Parent = u47.Crosshair
        HitMarkLense.Enabled = false
        return
    end
    u36.Adornee.Parent = Hitmarker
    HitMarkLense.Enabled = true
    local Position = p2.Position
    local v1 = p2:FindFirstAncestorWhichIsA("Part")
    local v2 = Vector2.new(Position.X.Scale, Position.Y.Scale)
    local v3 = v1.CFrame * CFrame.new(-(v1.Size.X / 2) + v1.Size.X * v2.X, v1.Size.Y / 2 - v1.Size.Y * v2.Y, 0)
    local v4 = workspace.Camera:WorldToScreenPoint(v3.p)
    Hitmarker.Position = UDim2.new(0, v4.X, 0, v4.Y)
end
function v1.Emit(p1, p2, p3, p4) -- Line: 48 -- upvalues: u48 (ref), u47 (ref), SoundService (val), u36 (val)
    local v1 = p2
    if not v1 then
        v1 = Color3.new(1, 1, 1)
    end
    local v2 = v1
    if p3 == "HitArmor" then
        u48:Cancel()
        u47.Crosshair.ArmorIcon.Image = "rbxassetid://9021696258"
        u47.Crosshair.ArmorIcon.ImageTransparency = -2
        local ArmorIcon = u47.Crosshair.ArmorIcon
        ArmorIcon.ImageColor3 = Color3.new(1, 1, 1)
        u48:Play()
        local u44 = script.Parent.Parent.Resources.hitarmor:Clone()
        u44.TimePosition = 0.08
        u44.Parent = SoundService
        u44:Play()
        task.delay(5, function() -- Line: 62 -- upvalues: u44 (val)
            u44:Destroy()
        end)
    elseif p3 == "BrokeArmor" then
        u48:Cancel()
        u47.Crosshair.ArmorIcon.Image = "rbxassetid://9021696096"
        local ArmorIcon_2 = u47.Crosshair.ArmorIcon
        ArmorIcon_2.ImageColor3 = Color3.new(0, 0.65098, 1)
        u47.Crosshair.ArmorIcon.ImageTransparency = -2
        u48:Play()
        local u85 = script.Parent.Parent.Resources.breakarmor:Clone()
        u85.TimePosition = 0.08
        u85.Parent = SoundService
        u85:Play()
        task.delay(5, function() -- Line: 76 -- upvalues: u85 (val)
            u85:Destroy()
        end)
    else
        local u104
        if not p4 then
            u104 = script.Parent.Parent.Resources.hitmarker:Clone()
            u104.Parent = SoundService
            u104:Play()
            task.delay(5, function() -- Line: 84 -- upvalues: u104 (val)
                u104:Destroy()
            end)
        elseif not p4.dontDoSound then
            u104 = script.Parent.Parent.Resources.hitmarker:Clone()
            u104.Parent = SoundService
            u104:Play()
            task.delay(5, function() -- Line: 84 -- upvalues: u104 (val)
                u104:Destroy()
            end)
        end
    end
    if p3 ~= "HitArmor" then
        u36.Adornee.Visible = true
        u36.Adornee.ImageColor3 = v2
        u36:Play()
    end
end
return v1