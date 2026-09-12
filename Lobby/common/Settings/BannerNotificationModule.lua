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
            local v2 = TweenService
            local Background = v1.Background
            local v3 = u22
            v2:Create(Background, v3, {ImageTransparency = 0.3}):Play()
            v2 = TweenService
            local Scale = v1.Background.Scale
            v3 = u22
            v2:Create(Scale, v3, {Scale = 1.2}):Play()
            task.wait(0.3)
            v1.Background.Image = "rbxassetid://11942813307"
            v2 = TweenService
            local Background_3 = v1.Background
            v3 = u22
            local v4 = {Size = UDim2.fromScale(1, 0.6)}
            v2:Create(Background_3, v3, v4):Play()
            v2 = TweenService
            local Scale_2 = v1.Background.Scale
            v3 = u22
            v2:Create(Scale_2, v3, {Scale = 1}):Play()
            task.wait(0.1)
            v2 = TweenService
            local Content = v1.Content
            v3 = u22
            v2:Create(Content, v3, {GroupTransparency = 0}):Play()
            task.wait(p5)
            v2 = TweenService
            local Content_2 = v1.Content
            v3 = u22
            v2:Create(Content_2, v3, {GroupTransparency = 1}):Play()
            task.wait(0.3)
            v1.Background.Image = "rbxassetid://11983017276"
            v2 = TweenService
            local Background_5 = v1.Background
            v3 = u22
            v4 = {Size = UDim2.fromScale(0.18, 0.6)}
            v2:Create(Background_5, v3, v4):Play()
            v2 = TweenService
            local Scale_3 = v1.Background.Scale
            v3 = u22
            v2:Create(Scale_3, v3, {Scale = 1.2}):Play()
            task.wait(0.3)
            v2 = TweenService
            local Background_7 = v1.Background
            v3 = u22
            v2:Create(Background_7, v3, {ImageTransparency = 1}):Play()
            v2 = TweenService
            local Scale_4 = v1.Background.Scale
            v3 = u22
            v2:Create(Scale_4, v3, {Scale = 0}):Play()
            task.wait(0.3)
            v1:Destroy()
        end
    end,
    NumberOfActiveNotifications = function(p1) -- Line: 84 -- upvalues: RunService (val)
        if RunService:IsClient() then
            local ActiveNotifications = (game.Players.LocalPlayer.PlayerGui:WaitForChild("BannerNotification")).ActiveNotifications
            for k, v in pairs(ActiveNotifications:GetChildren()) do
                return #v - 1
            end
        end
    end,
}