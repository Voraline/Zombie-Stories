local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage.common
local WepConfig = require(common:WaitForChild("WepConfig"))
local Signal = require(common:WaitForChild("Signal"))
local v1 = {}
function v1.onClick(p1, p2, p3) -- Line: 26 -- upvalues: TweenService (val)
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "circle"
    ImageLabel.Image = "rbxassetid://4175209485"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.Position = UDim2.new(0, p2 - p1.AbsolutePosition.X, 0, p3 - p1.AbsolutePosition.Y - 36)
    ImageLabel.Size = UDim2.new(0, 0, 0, 0)
    ImageLabel.ZIndex = p1.ZIndex
    ImageLabel.ImageTransparency = 0.75
    ImageLabel.Parent = p1
    local v1 = math.max(p1.AbsoluteSize.X, p1.AbsoluteSize.Y) * 2.2
    local v2 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v3 = TweenService:Create(ImageLabel, v2, {ImageTransparency = 1, Size = UDim2.new(0, v1, 0, v1)})
    v3.Completed:Connect(function() -- Line: 40 -- upvalues: ImageLabel (val)
        ImageLabel:Destroy()
    end)
    v3:Play()
end
function v1.clickEvent(p1, p2, p3) -- Line: 46 -- upvalues: TweenService (val), Signal (val)
    local ZIndex = p2
    if not ZIndex then
        ZIndex = p1.ZIndex
    end
    local u6 = ZIndex
    p1.ClipsDescendants = true
    local u19 = Signal.new()
    local MouseEnter = p1.MouseEnter
    local MouseLeave = p1.MouseLeave
    local BindableEvent = Instance.new("BindableEvent")
    p1.MouseButton1Click:Connect(function() -- Line: 79 -- upvalues: u19 (val)
        u19:Fire()
    end)
    return u19, MouseEnter, MouseLeave, BindableEvent
end
function v1.drawLine(p1, p2, p3, p4) -- Line: 86
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
    v1.Rotation = math.atan2(v2.Y, v2.X) * 57.29577951308232
    v1.Position = UDim2.fromOffset((p2 + p1).X / 2, (p2 + p1).Y / 2)
    v1.Size = UDim2.fromOffset((v2.X ^ 2 + v2.Y ^ 2) ^ 0.5, 1)
    return v1
end
function v1.moddingFuncs() -- Line: 126 -- upvalues: WepConfig (val), TweenService (val)
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
            v1.PrimaryPart.PivotOffset = v1.PrimaryPart.CFrame:ToObjectSpace(Handle.CFrame)
        end
        return v1
    end, function(p1, p2, p3) -- Line: 151 -- upvalues: CurrentCamera (val)
        local v1 = math.atan2(-p1.Y, p1.X)
        return (CurrentCamera.CFrame.Rotation * CFrame.Angles(0, 0, v1 + 1.5707963267948966)).RightVector, p1.Magnitude * 0.015
    end, function(p1) -- Line: 163 -- upvalues: TweenService (upval), CurrentCamera (val), u8 (val)
        TweenService:Create(CurrentCamera, u8, {FieldOfView = 20 + 80 * p1}):Play()
    end
end
return v1