local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = (require(ReplicatedStorage.Packages.Fusion)).Children
local u14 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p1) -- Line: 16 -- upvalues: Children (val), u14 (val)
    local scope = p1.scope
    local v1 = scope:New("Frame")
    local v2 = {
        Name = "BindsHeader",
        BackgroundTransparency = 1,
        LayoutOrder = p1.LayoutOrder or 1,
        Size = UDim2.fromScale(1, 0.09),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    }
    local v3 = Children
    local v4 = {}
    local v5 = scope:New("Frame")
    local v6 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.85),
    }
    local v7 = Children
    local v8 = {}
    local v9 = scope:New("UICorner")({})
    local v10 = scope:New("TextLabel")({
        Name = "Label",
        BackgroundTransparency = 1,
        Text = "PRESS TO BIND",
        TextScaled = true,
        AnchorPoint = Vector2.new(0, 0.5),
        FontFace = u14,
        Position = UDim2.fromScale(0.01, 0.5),
        Size = UDim2.fromScale(0.5, 0.9),
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    local v11 = scope:New("ImageLabel")({
        Name = "KeyboardLabel",
        BackgroundTransparency = 1,
        Image = "rbxassetid://13693390115",
        AnchorPoint = Vector2.new(0.5, 0.5),
        ImageColor3 = Color3.fromRGB(255, 184, 84),
        Position = UDim2.new(0.695, -4, 0.5, 0),
        Size = UDim2.fromScale(0.06, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    })
    local v12 = scope:New("ImageLabel")({
        Name = "MouseLabel",
        BackgroundTransparency = 1,
        Image = "rbxassetid://13693587767",
        AnchorPoint = Vector2.new(0.5, 0.5),
        ImageColor3 = Color3.fromRGB(255, 184, 84),
        Position = UDim2.new(0.815, -2, 0.5, 0),
        Size = UDim2.fromScale(0.06, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    })
    local v13 = scope:New("ImageLabel")
    local v14 = {
        Name = "GamepadLabel",
        BackgroundTransparency = 1,
        Image = "rbxassetid://13693666926",
        AnchorPoint = Vector2.new(0.5, 0.5),
        ImageColor3 = Color3.fromRGB(255, 184, 84),
        Position = UDim2.fromScale(0.935, 0.5),
        Size = UDim2.fromScale(0.06, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    }
    v8[1] = v9
    v8[2] = v10
    v8[3] = v11
    v8[4] = v12
    v8[5] = v13(v14)
    v6[v7] = v8
    v4[1] = v5(v6)
    v2[v3] = v4
    return v1(v2)
end