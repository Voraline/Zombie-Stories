local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
return function(p1) -- Line: 14 -- upvalues: Children (val)
    local v1, v2
    local scope = p1.scope
    local isLeft = p1.isLeft
    local v3 = scope:Computed(function(p1_2) -- Line: 18 -- upvalues: p1 (val), isLeft (val)
        local v1 = p1_2(p1.rotation)
        if isLeft then
            return (math.max(180, v1))
        end
        return (math.min(180, v1))
    end)
    local v4 = scope:Computed(function(p1_2) -- Line: 27 -- upvalues: p1 (val)
        if p1.wheelColor then
            return p1_2(p1.wheelColor)
        end
        return Color3.fromRGB(101, 206, 255)
    end)
    local v5 = scope:New("Frame")
    local v6 = {}
    if not isLeft then
        v2 = "RightFrame"
    else
        v2 = "LeftFrame"
    end
    v6.Name = v2
    v6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v6.BackgroundTransparency = 1
    v6.BorderColor3 = Color3.fromRGB(27, 42, 53)
    v6.ClipsDescendants = true
    if not isLeft then
        v2 = UDim2.fromScale(0.5, 0)
    else
        v2 = UDim2.fromScale(0, 0)
    end
    v6.Position = v2
    v6.Size = UDim2.fromScale(0.5, 1)
    v6.ZIndex = 2
    v2 = Children
    local v7 = {}
    local v8 = scope:New("ImageLabel")
    local v9 = {Name = "WheelImage"}
    if not isLeft then
        v1 = Vector2.new(1, 0)
    else
        v1 = Vector2.new(0, 0)
    end
    v9.AnchorPoint = v1
    v9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v9.BackgroundTransparency = 1
    v9.BorderColor3 = Color3.fromRGB(27, 42, 53)
    v9.Image = "rbxassetid://13676717187"
    v9.ImageColor3 = v4
    if not isLeft then
        v1 = UDim2.fromScale(1, 0)
    else
        v1 = UDim2.fromScale(0, 0)
    end
    v9.Position = v1
    v9.Size = UDim2.fromScale(2, 1)
    v1 = Children
    local v10 = {}
    local v11 = scope:New("UIGradient")
    local v12 = {Name = "UIGradient", Rotation = v3}
    local new = NumberSequence.new
    local v13 = {}
    local v14 = NumberSequenceKeypoint.new(0, 1)
    local v15 = NumberSequenceKeypoint.new(0.5, 1)
    local v16 = NumberSequenceKeypoint.new(0.501, 0)
    v13[1] = v14
    v13[2] = v15
    v13[3] = v16
    v13[4] = NumberSequenceKeypoint.new(1, 0)
    v12.Transparency = new(v13)
    v10[1] = v11(v12)
    v9[v1] = v10
    v7[1] = v8(v9)
    v6[v2] = v7
    return v5(v6)
end