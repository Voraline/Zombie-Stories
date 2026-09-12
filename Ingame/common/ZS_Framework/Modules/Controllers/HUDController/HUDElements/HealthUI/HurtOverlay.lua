local LocalPlayer = game.Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local u7 = {}
local Overlay = script.Parent:WaitForChild("Overlay")
Overlay.Parent = PlayerGui
game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local u26 = require("@game/ReplicatedStorage/common/PlayerHandler")
u7.MaxHP = 100

local function OverlayHandler(p1) -- Line: 20
    -- upvalues: TweenService (val), Overlay (val), u7 (val), u26 (val), LocalPlayer (val)
    local v1, v2
    local v3 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    if not (p1 <= 99) then
        v1 = TweenService
        v2 = Overlay
        local HurtOverlay_2 = v2.HurtOverlay
        v1:Create(HurtOverlay_2, v3, {ImageTransparency = 1}):Play()
    else
        v1 = TweenService
        v2 = Overlay
        local HurtOverlay = v2.HurtOverlay
        local v4 = {ImageTransparency = p1 / u7.MaxHP}
        v1:Create(HurtOverlay, v3, v4):Play()
    end
    task.delay(8, function() -- Line: 33 -- upvalues: u26 (upval), LocalPlayer (upval), p1 (val), TweenService (upval), Overlay (upval)
        local v1 = u26
        local v2 = LocalPlayer
        local v3 = v1:GetHealth(v2) or 0
        if v3 <= p1 or v3 == 100 or v3 == 0 then
            v1 = TweenService
            v2 = Overlay
            local HurtOverlay = v2.HurtOverlay
            local v4 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            v1:Create(HurtOverlay, v4, {ImageTransparency = 1}):Play()
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
    local HealOverlay = v1.HealOverlay
    local v2 = UDim2.new(1, 0, 1, 0)
    HealOverlay:TweenSize(v2, "Out", "Quad", 0.75, true)
    local v3 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v4 = TweenService
    local HealOverlay_2 = v1.HealOverlay
    v4:Create(HealOverlay_2, v3, {ImageTransparency = 1}):Play()
    task.wait(1.1)
    v1:Destroy()
end

function u7.DamageTaken(p1, p2) -- Line: 66
    -- upvalues: OverlayHandler (val), Overlay (val), PlayerGui (val), TweenService (val)
    OverlayHandler(p1)
    if p2 ~= "Bleed" then
        local v1 = Overlay:Clone()
        v1.HurtOverlay.ImageTransparency = 0
        v1.HurtOverlay.Size = UDim2.new(1.2, 0, 1.2, 0)
        Overlay.HurtOverlay.Size = UDim2.new(1.2, 0, 1.2, 0)
        v1.HealOverlay:Destroy()
        v1.Parent = PlayerGui
        local HurtOverlay = v1.HurtOverlay
        local v2 = UDim2.new(1, 0, 1, 0)
        HurtOverlay:TweenSize(v2, "Out", "Quad", 0.75, true)
        local v3 = Overlay
        local HurtOverlay_2 = v3.HurtOverlay
        v2 = UDim2.new(1, 0, 1, 0)
        HurtOverlay_2:TweenSize(v2, "Out", "Quad", 0.75, true)
        v3 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v4 = TweenService
        local HurtOverlay_3 = v1.HurtOverlay
        v4:Create(HurtOverlay_3, v3, {ImageTransparency = 1}):Play()
        local Children = v1.sfx:GetChildren()
        Children[math.random(1, #Children)]:Play()
        task.wait(1.1)
        v1:Destroy()
    end
end

return u7