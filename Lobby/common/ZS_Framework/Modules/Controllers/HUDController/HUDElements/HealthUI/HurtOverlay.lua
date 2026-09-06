local LocalPlayer = game.Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local u7 = {}
local Overlay = script.Parent:WaitForChild("Overlay")
Overlay.Parent = PlayerGui
game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local u26 = require("@game/ReplicatedStorage/common/PlayerHandler")
u7.MaxHP = 100
local function OverlayHandler(p1) -- Line: 20 -- upvalues: TweenService (val), Overlay (val), u7 (val), u26 (val), LocalPlayer (val)
    local v1 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    if p1 > 99 then
        TweenService:Create(Overlay.HurtOverlay, v1, {ImageTransparency = 1}):Play()
    else
        TweenService:Create(Overlay.HurtOverlay, v1, {ImageTransparency = p1 / u7.MaxHP}):Play()
    end
    task.delay(8, function() -- Line: 33 -- upvalues: u26 (upval), LocalPlayer (upval), p1 (val), TweenService (upval), Overlay (upval)
        local v1
        local v2 = u26:GetHealth(LocalPlayer) or 0
        if v2 <= p1 then
            v1 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            TweenService:Create(Overlay.HurtOverlay, v1, {ImageTransparency = 1}):Play()
        elseif v2 == 100 then
            v1 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            TweenService:Create(Overlay.HurtOverlay, v1, {ImageTransparency = 1}):Play()
        elseif v2 == 0 then
            v1 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            TweenService:Create(Overlay.HurtOverlay, v1, {ImageTransparency = 1}):Play()
        end
    end)
end
function u7.Healed(p1) -- Line: 43 -- upvalues: OverlayHandler (val), Overlay (val), PlayerGui (val), TweenService (val)
    OverlayHandler(p1)
    local v1 = Overlay:Clone()
    v1.HealOverlay.ImageTransparency = 0
    v1.HealOverlay.Size = UDim2.new(1.2, 0, 1.2, 0)
    v1.HurtOverlay:Destroy()
    v1.Parent = PlayerGui
    local v2 = UDim2.new(1, 0, 1, 0)
    v1.HealOverlay:TweenSize(v2, "Out", "Quad", 0.75, true)
    local v3 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(v1.HealOverlay, v3, {ImageTransparency = 1}):Play()
    task.wait(1.1)
    v1:Destroy()
end
function u7.DamageTaken(p1, p2) -- Line: 66 -- upvalues: OverlayHandler (val), Overlay (val), PlayerGui (val), TweenService (val)
    OverlayHandler(p1)
    if p2 ~= "Bleed" then
        local v1 = Overlay:Clone()
        v1.HurtOverlay.ImageTransparency = 0
        v1.HurtOverlay.Size = UDim2.new(1.2, 0, 1.2, 0)
        Overlay.HurtOverlay.Size = UDim2.new(1.2, 0, 1.2, 0)
        v1.HealOverlay:Destroy()
        v1.Parent = PlayerGui
        local v2 = UDim2.new(1, 0, 1, 0)
        v1.HurtOverlay:TweenSize(v2, "Out", "Quad", 0.75, true)
        v2 = UDim2.new(1, 0, 1, 0)
        Overlay.HurtOverlay:TweenSize(v2, "Out", "Quad", 0.75, true)
        local v3 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(v1.HurtOverlay, v3, {ImageTransparency = 1}):Play()
        local Children = v1.sfx:GetChildren()
        Children[math.random(1, #Children)]:Play()
        task.wait(1.1)
        v1:Destroy()
    end
end
return u7