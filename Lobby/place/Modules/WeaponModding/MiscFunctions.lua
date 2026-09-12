local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage.common
local WepConfig = require(common:WaitForChild("WepConfig"))
local Signal = require(common:WaitForChild("Signal"))
return {
    onClick = function(p1, p2, p3) -- Line: 26 -- upvalues: TweenService (val)
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "circle"
        ImageLabel.Image = "rbxassetid://4175209485"
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        local new = UDim2.new
        local v1 = p2 - p1.AbsolutePosition.X
        ImageLabel.Position = new(0, v1, 0, p3 - p1.AbsolutePosition.Y - 36)
        ImageLabel.Size = UDim2.new(0, 0, 0, 0)
        ImageLabel.ZIndex = p1.ZIndex
        ImageLabel.ImageTransparency = 0.75
        ImageLabel.Parent = p1
        local X = p1.AbsoluteSize.X
        local Y = p1.AbsoluteSize.Y
        local v2 = math.max(X, Y) * 2.2
        local v3 = TweenService
        local v4 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v5 = {ImageTransparency = 1, Size = UDim2.new(0, v2, 0, v2)}
        v3 = v3:Create(ImageLabel, v4, v5)
        v3.Completed:Connect(function() -- Line: 40 -- upvalues: ImageLabel (val)
            ImageLabel:Destroy()
        end)
        v3:Play()
    end,
    clickEvent = function(p1, p2, p3) -- Line: 46 -- upvalues: TweenService (val), Signal (val)
        local ZIndex = p2
        if not ZIndex then
            ZIndex = p1.ZIndex
        end
        local u6 = ZIndex
        p1.ClipsDescendants = true
        if not p3 then
            local v1 = p1.MouseButton1Down:Connect(function(p1_2, p2) -- Line: 53 -- upvalues: p1 (val), u6 (ref), TweenService (upval)
                local ImageLabel = Instance.new("ImageLabel")
                ImageLabel.Name = "circle"
                ImageLabel.Image = "rbxassetid://4175209485"
                ImageLabel.BackgroundTransparency = 1
                ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                local new = UDim2.new
                local v1 = p1_2 - p1.AbsolutePosition.X
                ImageLabel.Position = new(0, v1, 0, p2 - p1.AbsolutePosition.Y - 36)
                ImageLabel.Size = UDim2.new(0, 0, 0, 0)
                ImageLabel.ZIndex = u6
                ImageLabel.ImageTransparency = 0.75
                ImageLabel.Parent = p1
                v1 = p1
                local X = v1.AbsoluteSize.X
                local v2 = p1
                local Y = v2.AbsoluteSize.Y
                local v3 = math.max(X, Y) * 2.2
                local v4 = TweenService
                local v5 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v6 = {ImageTransparency = 1, Size = UDim2.new(0, v3, 0, v3)}
                v4 = v4:Create(ImageLabel, v5, v6)
                v4.Completed:Connect(function() -- Line: 67 -- upvalues: ImageLabel (val)
                    ImageLabel:Destroy()
                end)
                v4:Play()
            end)
        end
        local u19 = Signal.new()
        local MouseEnter = p1.MouseEnter
        local MouseLeave = p1.MouseLeave
        local BindableEvent = Instance.new("BindableEvent")
        p1.MouseButton1Click:Connect(function() -- Line: 79 -- upvalues: u19 (val)
            u19:Fire()
        end)
        return u19, MouseEnter, MouseLeave, BindableEvent
    end,
    drawLine = function(p1, p2, p3, p4) -- Line: 86
        local v1
        local v2 = p2 - p1
        if p4 then
            v1 = p4
        else
            v1 = Instance.new("Frame", p3)
            v1.Name = "Line"
        end
        v1.AnchorPoint = Vector2.new(0.5, 0.5)
        v1.BackgroundColor3 = Color3.fromRGB(255, 145, 35)
        v1.BorderSizePixel = 0
        v1.ZIndex = -1
        local Y = v2.Y
        local X = v2.X
        v1.Rotation = math.atan2(Y, X) * 57.29577951308232
        v1.Position = UDim2.fromOffset((p2 + p1).X / 2, (p2 + p1).Y / 2)
        v1.Size = UDim2.fromOffset((v2.X ^ 2 + v2.Y ^ 2) ^ 0.5, 1)
        return v1
    end,
    moddingFuncs = function() -- Line: 126 -- upvalues: WepConfig (val), TweenService (val)
        local CurrentCamera = workspace.CurrentCamera
        local u8 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        return function(p1) -- Line: 129 -- upvalues: WepConfig (upval)
            local v1 = WepConfig:StreamViewmodel(p1):expect():Clone()
            if not v1.PrimaryPart then
                v1.PrimaryPart = v1:WaitForChild("HumanoidRootPart")
            end
            local KeyParts = v1:WaitForChild("KeyParts", 5)
            local ViewCenter = KeyParts
            if ViewCenter then
                ViewCenter = KeyParts:WaitForChild("ViewCenter", 5)
            end
            local Handle = ViewCenter
            if not Handle then
                Handle = KeyParts
                if Handle then
                    Handle = KeyParts:WaitForChild("Handle", 5)
                end
            end
            if Handle then
                local CFrame = Handle.CFrame
                v1.PrimaryPart.PivotOffset = v1.PrimaryPart.CFrame:ToObjectSpace(CFrame)
            end
            return v1
        end, function(p1, p2, p3) -- Line: 151 -- upvalues: CurrentCamera (val)
            local v1 = CurrentCamera
            local Rotation = v1.CFrame.Rotation
            local v2 = -p1.Y
            local X = p1.X
            local v3 = math.atan2(v2, X)
            return (Rotation * CFrame.Angles(0, 0, v3 + 1.5707963267948966)).RightVector, p1.Magnitude * 0.015
        end, function(p1) -- Line: 163 -- upvalues: TweenService (upval), CurrentCamera (val), u8 (val)
            local v1 = TweenService
            local v2 = CurrentCamera
            local v3 = u8
            local v4 = {FieldOfView = 20 + 80 * p1}
            v1:Create(v2, v3, v4):Play()
        end
    end,
}