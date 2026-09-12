local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = (require(ReplicatedStorage.Packages.Fusion)).Children
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
    local v5 = Children
    local v6 = {}
    local v7 = scope:New("Frame")
    local v8 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.85),
    }
    local v9 = Children
    local v10 = {}
    local v11 = scope:New("UICorner")({})
    local v12 = scope:New("TextLabel")
    local v13 = {
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
    v13.Position = v1
    v13.Size = UDim2.fromScale(0.62, 0.07)
    v13.SizeConstraint = Enum.SizeConstraint.RelativeXX
    v13.Text = p1.Text
    v13.TextColor3 = Color3.new(1, 1, 1)
    v13.TextXAlignment = Enum.TextXAlignment.Left
    v12 = v12(v13)
    v13 = scope:New("TextLabel")
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
    v13 = v13(v1)
    v1 = scope:New("ImageButton")
    local v14 = {
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
    local v15 = Children
    local v16 = {}
    local v17 = scope:New("UICorner")({CornerRadius = UDim.new(0.1, 0)})
    local v18 = scope:New("UIStroke")
    local v19 = {Color = Color3.fromRGB(255, 184, 84)}
    v16[1] = v17
    v16[2] = v18(v19)
    v14[v15] = v16
    v1 = v1(v14)
    v14 = scope:New("ImageButton")
    v15 = {
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
    v16 = Children
    v17 = {}
    v18 = scope:New("UICorner")({CornerRadius = UDim.new(0.1, 0)})
    v19 = scope:New("UIStroke")
    local v20 = {Color = Color3.fromRGB(255, 184, 84)}
    v17[1] = v18
    v17[2] = v19(v20)
    v15[v16] = v17
    v14 = v14(v15)
    v15 = scope:New("ImageButton")
    v16 = {
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
    v17 = Children
    v18 = {}
    v19 = scope:New("UICorner")({CornerRadius = UDim.new(0.1, 0)})
    v20 = scope:New("UIStroke")
    local v21 = {Color = Color3.fromRGB(255, 184, 84)}
    v18[1] = v19
    v18[2] = v20(v21)
    v16[v17] = v18
    v10[1] = v11
    v10[2] = v12
    v10[3] = v13
    v10[4] = v1
    v10[5] = v14
    v10[6] = v15(v16)
    v8[v9] = v10
    v6[1] = v7(v8)
    v4[v5] = v6
    return v3(v4)
end