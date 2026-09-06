local ModResources = game:GetService("ReplicatedStorage").place:WaitForChild("ModResources")
local TweenService = require(ModResources.common:WaitForChild("TweenService"))
local Resources = game:GetService("ServerScriptService").place:WaitForChild("Resources")
local RippleTwo = Resources:WaitForChild("RippleTwo")
if not RippleTwo then
    local Resources_2 = game:GetService("ServerScriptService").place:WaitForChild("Resources")
    RippleTwo = Resources_2:WaitForChild("RippleOne")
end
return {
    ButtonAnimationClassic = function(p1) -- Line: 11 -- upvalues: RippleTwo (val), TweenService (val)
        p1.MouseButton1Down:Connect(function(a1, p2) -- Line: 12 -- upvalues: RippleTwo (upval), p1 (val), TweenService (upval)
            local u5 = RippleTwo:Clone()
            u5.Parent = p1
            u5.Position = UDim2.new(0, a1 - p1.AbsolutePosition.X, 0, p2 - p1.AbsolutePosition.Y - 36)
            u5.Visible = true
            TweenService:TweenAsync(u5, 0.4, "Quint", "Out", {Size = UDim2.new(3, 0, 3, 0)})
            coroutine.wrap(function() -- Line: 19 -- upvalues: TweenService (upval), u5 (val)
                task.wait(0.1)
                TweenService:Tween(u5, 1, "Quint", "Out", {ImageTransparency = 1})
                u5.ImageTransparency = 1
                u5:Destroy()
            end)()
        end)
    end,
    ButtonAnimation = function(p1) -- Line: 29 -- upvalues: RippleTwo (val), TweenService (val)
        p1.MouseButton1Down:Connect(function(a1, p2) -- Line: 30 -- upvalues: RippleTwo (upval), p1 (val), TweenService (upval)
            local RippleFrame
            local u5 = RippleTwo:Clone()
            u5.ZIndex = p1.ZIndex + 1
            if not (p1:FindFirstChild("RippleFrame")) then
                RippleFrame = p1
            else
                RippleFrame = p1.RippleFrame
                if not RippleFrame then
                    RippleFrame = p1
                end
            end
            u5.Parent = RippleFrame
            u5.Position = UDim2.new(0, a1 - p1.AbsolutePosition.X, 0, p2 - p1.AbsolutePosition.Y - 36)
            u5.Visible = true
            TweenService:SpringAsync(u5, 0.4, 1.5, {Size = UDim2.new(3, 0, 3, 0)})
            task.defer(function() -- Line: 38 -- upvalues: TweenService (upval), u5 (val)
                task.wait(0.1)
                TweenService:Spring(u5, 0.2, 1.5, {ImageTransparency = 1})
                u5.ImageTransparency = 1
                u5:Destroy()
            end)
        end)
    end,
    TextBoxAnimation = function(p1, p2) -- Line: 47
        p1.Focused:Connect(function() end)
    end,
}