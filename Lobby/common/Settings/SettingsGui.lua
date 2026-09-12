local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = (require(ReplicatedStorage.Packages.Fusion)).Children
local u14 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p1, p2) -- Line: 11 -- upvalues: Children (val), u14 (val)
    local v1
    local v2 = p1:New("ScreenGui")
    local v3 = {
        Name = "SettingsGui",
        Enabled = false,
        ResetOnSpawn = false,
        DisplayOrder = 400,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }
    local v4 = Children
    local v5 = {}
    local v6 = p1:New("Frame")
    local v7 = {
        Name = "Panel",
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(17, 37, 63),
    }
    if not p2 then
        v1 = 0.1
    else
        v1 = 0
    end
    v7.BackgroundTransparency = v1
    v7.Position = UDim2.fromScale(0.5, 0.5)
    v7.Size = UDim2.fromScale(1.2, 0.78)
    v7.SizeConstraint = Enum.SizeConstraint.RelativeYY
    v1 = Children
    local v8 = {}
    local v9 = p1:New("UICorner")({CornerRadius = UDim.new(0.015, 0)})
    local v10 = p1:New("Frame")({
        Name = "Background",
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 0,
        BackgroundColor3 = Color3.fromRGB(14, 33, 50),
        Size = UDim2.fromScale(1.538, 1),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
    })
    local v11 = p1:New("Frame")
    local v12 = {Name = "Header", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.065)}
    local v13 = Children
    local v14 = {}
    local v15 = p1:New("UICorner")({CornerRadius = UDim.new(0.3, 0)})
    local v16 = p1:New("TextLabel")({
        Name = "TextLabel",
        BackgroundTransparency = 1,
        Text = "SETTINGS",
        TextScaled = true,
        AnchorPoint = Vector2.new(1, 0),
        FontFace = u14,
        Position = UDim2.fromScale(0.99, 0),
        Size = UDim2.fromScale(0.15, 1),
        TextColor3 = Color3.fromRGB(255, 184, 84),
    })
    local v17 = p1:New("TextButton")
    local v18 = {
        Name = "Exit",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 73, 73),
        Position = UDim2.fromScale(1, -0.15),
        Size = UDim2.fromScale(1, 1),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        AutoButtonColor = false,
        Text = "",
    }
    local v19 = Children
    local v20 = {}
    local v21 = p1:New("UICorner")({CornerRadius = UDim.new(0.2, 0)})
    local v22 = p1:New("Frame")
    local v23 = {
        Name = "Fill",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(49, 49, 49),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.8, 0.8),
    }
    local v24 = Children
    v23[v24] = {p1:New("UICorner")({CornerRadius = UDim.new(0.2, 0)})}
    v22 = v22(v23)
    v23 = p1:New("TextLabel")
    v24 = {
        Name = "Label",
        BackgroundTransparency = 1,
        Text = "X",
        TextScaled = true,
        AnchorPoint = Vector2.new(0.5, 0.5),
        FontFace = u14,
        TextColor3 = Color3.fromRGB(255, 73, 73),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
    }
    v20[1] = v21
    v20[2] = v22
    v20[3] = v23(v24)
    v18[v19] = v20
    v14[1] = v15
    v14[2] = v16
    v14[3] = v17(v18)
    v12[v13] = v14
    v11 = v11(v12)
    v12 = p1:New("Frame")
    v13 = {
        Name = "Container",
        AnchorPoint = Vector2.new(1, 1),
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.995, 1),
        Size = UDim2.fromScale(0.695, 0.945),
    }
    v14 = Children
    v13[v14] = {p1:New("UICorner")({CornerRadius = UDim.new(0.016, 0)})}
    v12 = v12(v13)
    v13 = p1:New("Frame")
    v14 = {
        Name = "Tabs",
        AnchorPoint = Vector2.new(0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.fromScale(0.296, 1),
    }
    v15 = Children
    v16 = {}
    v17 = p1:New("UICorner")({CornerRadius = UDim.new(0.035, 0)})
    v18 = p1:New("ScrollingFrame")
    v19 = {
        Name = "Frame",
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        CanvasSize = UDim2.new(),
        ScrollBarImageColor3 = Color3.fromRGB(16, 16, 16),
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Selectable = false,
        Size = UDim2.fromScale(1, 1),
    }
    v20 = Children
    v19[v20] = {p1:New("UIListLayout")({SortOrder = Enum.SortOrder.LayoutOrder})}
    v18 = v18(v19)
    v19 = p1:New("Frame")
    v20 = {
        Name = "Background",
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 0,
    }
    v21 = Children
    v22 = {}
    v23 = p1:New("Frame")
    v24 = {
        Name = "CurvedFrame",
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.9,
        Size = UDim2.fromScale(1.2, 1),
    }
    local v25 = Children
    v24[v25] = {p1:New("UICorner")({CornerRadius = UDim.new(0.028, 0)})}
    v22[1] = v23(v24)
    v20[v21] = v22
    v16[1] = v17
    v16[2] = v18
    v16[3] = v19(v20)
    v14[v15] = v16
    v13 = v13(v14)
    v14 = p1:New("UIGradient")
    v15 = {
        Rotation = 90,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(95, 95, 95)),
        }),
    }
    v8[1] = v9
    v8[2] = v10
    v8[3] = v11
    v8[4] = v12
    v8[5] = v13
    v8[6] = v14(v15)
    v7[v1] = v8
    v5[1] = v6(v7)
    v3[v4] = v5
    return v2(v3)
end