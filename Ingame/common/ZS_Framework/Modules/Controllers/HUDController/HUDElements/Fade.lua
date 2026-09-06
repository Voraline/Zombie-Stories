require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local TweenService = game:GetService("TweenService")
local Fade = script:WaitForChild("Fade")
local Frame = Fade:WaitForChild("Frame")
Fade.Parent = game.Players.LocalPlayer.PlayerGui
local u27 = {IsShowing = false}
function u27.Show(p1, p2) -- Line: 15 -- upvalues: u27 (val)
    u27.IsShowing = true
    u27:TweenTransparency(0, p2)
end
function u27.Hide(p1, p2) -- Line: 21 -- upvalues: u27 (val)
    u27.IsShowing = false
    u27:TweenTransparency(1, p2)
end
function u27.TweenTransparency(p1, p2, p3) -- Line: 27 -- upvalues: TweenService (val), Frame (val)
    local v1 = TweenInfo.new(p3 or 1, Enum.EasingStyle.Linear)
    TweenService:Create(Frame, v1, {BackgroundTransparency = p2}):Play()
end
function u27.SetColor(p1, p2) -- Line: 38 -- upvalues: Frame (val)
    Frame.BackgroundColor3 = p2
end
function u27.SetDisplayOrder(p1, p2) -- Line: 43 -- upvalues: Fade (val)
    Fade.DisplayOrder = p2
end
return u27