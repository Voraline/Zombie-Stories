local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
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
    local v3 = {}
    local v4 = scope:New("Frame")
    local v5 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.85),
    }
    local v6 = {}
    local v7 = scope:New("UICorner")
    v7 = v7({})
    local v8 = scope:New("TextLabel")
    v8 = v8({
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
    local v9 = scope:New("ImageLabel")
    v9 = v9({
        Name = "KeyboardLabel",
        BackgroundTransparency = 1,
        Image = "rbxassetid://13693390115",
        AnchorPoint = Vector2.new(0.5, 0.5),
        ImageColor3 = Color3.fromRGB(255, 184, 84),
        Position = UDim2.new(0.695, -4, 0.5, 0),
        Size = UDim2.fromScale(0.06, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    })
    local v10 = scope:New("ImageLabel")
    v10 = v10({
        Name = "MouseLabel",
        BackgroundTransparency = 1,
        Image = "rbxassetid://13693587767",
        AnchorPoint = Vector2.new(0.5, 0.5),
        ImageColor3 = Color3.fromRGB(255, 184, 84),
        Position = UDim2.new(0.815, -2, 0.5, 0),
        Size = UDim2.fromScale(0.06, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    })
    local v11 = scope:New("ImageLabel")
    local v12 = {
        Name = "GamepadLabel",
        BackgroundTransparency = 1,
        Image = "rbxassetid://13693666926",
        AnchorPoint = Vector2.new(0.5, 0.5),
        ImageColor3 = Color3.fromRGB(255, 184, 84),
        Position = UDim2.fromScale(0.935, 0.5),
        Size = UDim2.fromScale(0.06, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    }
    v6[1] = v7
    v6[2] = v8
    v6[3] = v9
    v6[4] = v10
    v6[5] = v11(v12)
    v5[Children] = v6
    v3[1] = v4(v5)
    v2[Children] = v3
    return v1(v2)
end