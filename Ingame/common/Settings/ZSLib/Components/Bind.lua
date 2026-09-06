local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
local u14 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p1) -- Line: 19 -- upvalues: Children (val), u14 (val)
    local Description, Visible, v1
    local scope = p1.scope
    local v2 = p1.Description ~= nil
    local v3 = scope:New("Frame")
    local v4 = {
        Name = "Bind",
        BackgroundTransparency = 1,
        LayoutOrder = p1.LayoutOrder or 1,
        Size = UDim2.fromScale(1, 0.16),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    }
    if p1.Visible == nil then
        Visible = true
    else
        Visible = p1.Visible
    end
    v4.Visible = Visible
    local v5 = {}
    local v6 = scope:New("Frame")
    local v7 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.85),
    }
    local v8 = {}
    local v9 = scope:New("UICorner")
    v9 = v9({})
    local v10 = scope:New("TextLabel")
    local v11 = {
        Name = "Label",
        BackgroundTransparency = 1,
        TextScaled = true,
        AnchorPoint = Vector2.new(0, 0.5),
        FontFace = u14,
    }
    if not v2 then
        v1 = UDim2.fromScale(0.01, 0.5)
    else
        v1 = UDim2.fromScale(0.01, 0.33)
    end
    v11.Position = v1
    v11.Size = UDim2.fromScale(0.62, 0.07)
    v11.SizeConstraint = Enum.SizeConstraint.RelativeXX
    v11.Text = p1.Text
    v11.TextColor3 = Color3.new(1, 1, 1)
    v11.TextXAlignment = Enum.TextXAlignment.Left
    v10 = v10(v11)
    v11 = scope:New("TextLabel")
    v1 = {
        Name = "DescriptionLabel",
        BackgroundTransparency = 1,
        TextScaled = true,
        TextTransparency = 0.5,
        AnchorPoint = Vector2.new(0, 1),
        FontFace = u14,
        Position = UDim2.fromScale(0.01, 0.83),
        Size = UDim2.fromScale(0.8, 0.04),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    }
    if not v2 then
        Description = ""
    else
        Description = p1.Description
    end
    v1.Text = Description
    v1.TextColor3 = Color3.new(1, 1, 1)
    v1.TextXAlignment = Enum.TextXAlignment.Left
    v1.Visible = v2
    v11 = v11(v1)
    v1 = scope:New("ImageButton")
    local v12 = {
        Name = "GamepadButton",
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Color3.fromRGB(107, 107, 107),
        BackgroundTransparency = 0.9,
        Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
        ImageTransparency = 1,
        Position = UDim2.fromScale(0.99, 0.5),
        Size = UDim2.fromScale(0.11, 0.11),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    }
    local v13 = {}
    local v14 = scope:New("UICorner")
    v14 = v14({CornerRadius = UDim.new(0.1, 0)})
    local v15 = scope:New("UIStroke")
    local v16 = {Color = Color3.fromRGB(255, 184, 84)}
    v13[1] = v14
    v13[2] = v15(v16)
    v12[Children] = v13
    v1 = v1(v12)
    v12 = scope:New("ImageButton")
    local v17 = {
        Name = "MouseButton",
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Color3.fromRGB(107, 107, 107),
        BackgroundTransparency = 0.9,
        Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
        ImageTransparency = 1,
        Position = UDim2.new(0.87, -2, 0.5, 0),
        Size = UDim2.fromScale(0.11, 0.11),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    }
    v14 = {}
    v15 = scope:New("UICorner")
    v15 = v15({CornerRadius = UDim.new(0.1, 0)})
    v16 = scope:New("UIStroke")
    local v18 = {Color = Color3.fromRGB(255, 184, 84)}
    v14[1] = v15
    v14[2] = v16(v18)
    v17[Children] = v14
    v12 = v12(v17)
    v17 = scope:New("ImageButton")
    v13 = {
        Name = "KeyboardButton",
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Color3.fromRGB(107, 107, 107),
        BackgroundTransparency = 0.9,
        Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
        ImageTransparency = 1,
        Position = UDim2.new(0.75, -4, 0.5, 0),
        Size = UDim2.fromScale(0.11, 0.11),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    }
    v15 = {}
    v16 = scope:New("UICorner")
    v16 = v16({CornerRadius = UDim.new(0.1, 0)})
    v18 = scope:New("UIStroke")
    local v19 = {Color = Color3.fromRGB(255, 184, 84)}
    v15[1] = v16
    v15[2] = v18(v19)
    v13[Children] = v15
    v8[1] = v9
    v8[2] = v10
    v8[3] = v11
    v8[4] = v1
    v8[5] = v12
    v8[6] = v17(v13)
    v7[Children] = v8
    v5[1] = v6(v7)
    v4[Children] = v5
    return v3(v4)
end