local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local u22 = TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)
return {
    Notify = function(p1, p2, p3, p4, p5) -- Line: 13 -- upvalues: RunService (val), TweenService (val), u22 (val)
        if RunService:IsClient() then
            local BannerNotification = game.Players.LocalPlayer.PlayerGui:WaitForChild("BannerNotification")
            local ActiveNotifications = BannerNotification.ActiveNotifications
            local Canvas = BannerNotification.Canvas
            BannerNotification.Enabled = true
            Canvas.Background.Size = UDim2.fromScale(0.18, 0.6)
            Canvas.Background.ImageTransparency = 1
            Canvas.Background.Scale.Scale = 0
            Canvas.Content.GroupTransparency = 1
            local v1 = Canvas:Clone()
            v1.Name = p2
            v1.Parent = ActiveNotifications
            v1.Content.Header.Text = p2
            v1.Content.Message.Text = p3
            v1.Content.Icon.Image = p4
            v1.Visible = true
            v1.Background.Image = "rbxassetid://11983017276"
            TweenService:Create(v1.Background, u22, {ImageTransparency = 0.3}):Play()
            TweenService:Create(v1.Background.Scale, u22, {Scale = 1.2}):Play()
            task.wait(0.3)
            v1.Background.Image = "rbxassetid://11942813307"
            TweenService:Create(v1.Background, u22, {Size = UDim2.fromScale(1, 0.6)}):Play()
            TweenService:Create(v1.Background.Scale, u22, {Scale = 1}):Play()
            task.wait(0.1)
            TweenService:Create(v1.Content, u22, {GroupTransparency = 0}):Play()
            task.wait(p5)
            TweenService:Create(v1.Content, u22, {GroupTransparency = 1}):Play()
            task.wait(0.3)
            v1.Background.Image = "rbxassetid://11983017276"
            TweenService:Create(v1.Background, u22, {Size = UDim2.fromScale(0.18, 0.6)}):Play()
            TweenService:Create(v1.Background.Scale, u22, {Scale = 1.2}):Play()
            task.wait(0.3)
            TweenService:Create(v1.Background, u22, {ImageTransparency = 1}):Play()
            TweenService:Create(v1.Background.Scale, u22, {Scale = 0}):Play()
            task.wait(0.3)
            v1:Destroy()
        end
    end,
    NumberOfActiveNotifications = function(p1) -- Line: 84 -- upvalues: RunService (val)
        if not (RunService:IsClient()) then
            return
        end
        for k, v in pairs(game.Players.LocalPlayer.PlayerGui:WaitForChild("BannerNotification").ActiveNotifications:GetChildren()) do
            return #v - 1
        end
    end,
}