local ModResources = game:GetService("ReplicatedStorage").place:WaitForChild("ModResources")
local TweenService = require(ModResources.common:WaitForChild("TweenService"))
local RippleTwo = (game:GetService("ServerScriptService").place:WaitForChild("Resources")):WaitForChild("RippleTwo")
if not RippleTwo then
    RippleTwo = (game:GetService("ServerScriptService").place:WaitForChild("Resources")):WaitForChild("RippleOne")
end
return {
    ButtonAnimationClassic = function(p1) -- Line: 11 -- upvalues: RippleTwo (val), TweenService (val)
        p1.MouseButton1Down:Connect(function(p1_2, p2) -- Line: 12 -- upvalues: RippleTwo (upval), p1 (val), TweenService (upval)
            local u5 = RippleTwo:Clone()
            u5.Parent = p1
            local new = UDim2.new
            local v1 = p1_2 - p1.AbsolutePosition.X
            u5.Position = new(0, v1, 0, p2 - p1.AbsolutePosition.Y - 36)
            u5.Visible = true
            local v2 = TweenService
            local v3 = {Size = UDim2.new(3, 0, 3, 0)}
            v2:TweenAsync(u5, 0.4, "Quint", "Out", v3)
            coroutine.wrap(function() -- Line: 19 -- upvalues: TweenService (upval), u5 (val)
                task.wait(0.1)
                local v1 = TweenService
                local v2 = u5
                v1:Tween(v2, 1, "Quint", "Out", {ImageTransparency = 1})
                u5.ImageTransparency = 1
                u5:Destroy()
            end)()
        end)
    end,
    ButtonAnimation = function(p1) -- Line: 29 -- upvalues: RippleTwo (val), TweenService (val)
        p1.MouseButton1Down:Connect(function(p1_2, p2) -- Line: 30 -- upvalues: RippleTwo (upval), p1 (val), TweenService (upval)
            local RippleFrame
            local u5 = RippleTwo:Clone()
            u5.ZIndex = p1.ZIndex + 1
            if not p1:FindFirstChild("RippleFrame") then
                RippleFrame = p1
            else
                RippleFrame = p1.RippleFrame
                if not RippleFrame then
                    RippleFrame = p1
                end
            end
            u5.Parent = RippleFrame
            local new = UDim2.new
            local v1 = p1_2 - p1.AbsolutePosition.X
            u5.Position = new(0, v1, 0, p2 - p1.AbsolutePosition.Y - 36)
            u5.Visible = true
            local v2 = TweenService
            local v3 = {Size = UDim2.new(3, 0, 3, 0)}
            v2:SpringAsync(u5, 0.4, 1.5, v3)
            task.defer(function() -- Line: 38 -- upvalues: TweenService (upval), u5 (val)
                task.wait(0.1)
                local v1 = TweenService
                local v2 = u5
                v1:Spring(v2, 0.2, 1.5, {ImageTransparency = 1})
                u5.ImageTransparency = 1
                u5:Destroy()
            end)
        end)
    end,
    TextBoxAnimation = function(p1, p2) -- Line: 47
        p1.Focused:Connect(function() end)
    end,
}