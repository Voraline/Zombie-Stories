local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
return function(p1) -- Line: 13 -- upvalues: Children (val)
    local v1, v2
    local scope = p1.scope
    local isLeft = p1.isLeft
    local v3 = scope:Computed(function(a1) -- Line: 17 -- upvalues: p1 (val), isLeft (val)
        local v1 = a1(p1.rotation)
        if isLeft then
            return (math.max(180, v1))
        end
        return (math.min(180, v1))
    end)
    local v4 = scope:New("Frame")
    local v5 = {}
    if not isLeft then
        v2 = "RightFrame"
    else
        v2 = "LeftFrame"
    end
    v5.Name = v2
    v5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v5.BackgroundTransparency = 1
    v5.BorderColor3 = Color3.fromRGB(27, 42, 53)
    v5.ClipsDescendants = true
    if not isLeft then
        v2 = UDim2.fromScale(0.5, 0)
    else
        v2 = UDim2.fromScale(0, 0)
    end
    v5.Position = v2
    v5.Size = UDim2.fromScale(0.5, 1)
    v5.ZIndex = 2
    local v6 = {}
    local v7 = scope:New("ImageLabel")
    local v8 = {Name = "WheelImage"}
    if not isLeft then
        v1 = Vector2.new(1, 0)
    else
        v1 = Vector2.new(0, 0)
    end
    v8.AnchorPoint = v1
    v8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v8.BackgroundTransparency = 1
    v8.BorderColor3 = Color3.fromRGB(27, 42, 53)
    v8.Image = "rbxassetid://13676717187"
    v8.ImageColor3 = Color3.fromRGB(101, 206, 255)
    if not isLeft then
        v1 = UDim2.fromScale(1, 0)
    else
        v1 = UDim2.fromScale(0, 0)
    end
    v8.Position = v1
    v8.Size = UDim2.fromScale(2, 1)
    local v9 = {}
    local v10 = scope:New("UIGradient")
    local v11 = {Name = "UIGradient", Rotation = v3}
    local v12 = {}
    local v13 = NumberSequenceKeypoint.new(0, 1)
    local v14 = NumberSequenceKeypoint.new(0.5, 1)
    local v15 = NumberSequenceKeypoint.new(0.501, 0)
    v12[1] = v13
    v12[2] = v14
    v12[3] = v15
    v12[4] = NumberSequenceKeypoint.new(1, 0)
    v11.Transparency = NumberSequence.new(v12)
    v9[1] = v10(v11)
    v8[Children] = v9
    v6[1] = v7(v8)
    v5[Children] = v6
    return v4(v5)
end