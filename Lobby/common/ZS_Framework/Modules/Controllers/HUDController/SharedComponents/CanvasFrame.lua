local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
return function(p1) -- Line: 17 -- upvalues: Children (val)
    local v1, v2
    local scope = p1.scope
    local isLeft = p1.isLeft
    local v3 = scope:New("CanvasGroup")
    local v4 = {}
    if not isLeft then
        v1 = "RightCanvas"
    else
        v1 = "LeftCanvas"
    end
    v4.Name = v1
    v4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v4.BackgroundTransparency = 1
    v4.BorderColor3 = Color3.fromRGB(27, 42, 53)
    local groupColor3 = p1.groupColor3
    if not groupColor3 then
        groupColor3 = Color3.fromRGB(255, 255, 255)
    end
    v4.GroupColor3 = groupColor3
    v4.GroupTransparency = p1.groupTransparency
    if not isLeft then
        v1 = UDim2.fromScale(0.5, 0)
    else
        v1 = UDim2.fromScale(0, 0)
    end
    v4.Position = v1
    v4.Size = UDim2.fromScale(0.5, 1)
    v4.Visible = p1.visible
    v1 = Children
    local v5 = {}
    local v6 = scope:New("ImageLabel")
    local v7 = {Name = "RedGlowImage"}
    if not isLeft then
        v2 = Vector2.new(1, 0)
    else
        v2 = Vector2.new(0, 0)
    end
    v7.AnchorPoint = v2
    v7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v7.BackgroundTransparency = 1
    v7.BorderColor3 = Color3.fromRGB(27, 42, 53)
    v7.Image = "rbxassetid://12799025513"
    if not isLeft then
        v2 = UDim2.fromScale(1, 0)
    else
        v2 = UDim2.fromScale(0, 0)
    end
    v7.Position = v2
    v7.Rotation = p1.rotation
    v7.Size = UDim2.fromScale(2, 1)
    v7.ZIndex = 2
    v2 = Children
    local v8 = {}
    local v9 = scope:New("UIGradient")
    local v10 = {Name = "UIGradient", Rotation = p1.gradientRotation}
    local new = NumberSequence.new
    local v11 = {}
    local v12 = NumberSequenceKeypoint.new(0, 0)
    local v13 = NumberSequenceKeypoint.new(0.5, 0)
    local v14 = NumberSequenceKeypoint.new(0.502, 1)
    v11[1] = v12
    v11[2] = v13
    v11[3] = v14
    v11[4] = NumberSequenceKeypoint.new(1, 1)
    v10.Transparency = new(v11)
    v8[1] = v9(v10)
    v7[v2] = v8
    v5[1] = v6(v7)
    v4[v1] = v5
    return v3(v4)
end