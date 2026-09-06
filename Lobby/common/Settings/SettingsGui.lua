local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
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
    local v4 = {}
    local v5 = p1:New("Frame")
    local v6 = {Name = "Panel", Visible = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(17, 37, 63)}
    if not p2 then
        v1 = 0.1
    else
        v1 = 0
    end
    v6.BackgroundTransparency = v1
    v6.Position = UDim2.fromScale(0.5, 0.5)
    v6.Size = UDim2.fromScale(1.2, 0.78)
    v6.SizeConstraint = Enum.SizeConstraint.RelativeYY
    local v7 = {}
    local v8 = p1:New("UICorner")
    v8 = v8({CornerRadius = UDim.new(0.015, 0)})
    local v9 = p1:New("Frame")
    v9 = v9({
        Name = "Background",
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 0,
        BackgroundColor3 = Color3.fromRGB(14, 33, 50),
        Size = UDim2.fromScale(1.538, 1),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
    })
    local v10 = p1:New("Frame")
    local v11 = {Name = "Header", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.065)}
    local v12 = {}
    local v13 = p1:New("UICorner")
    v13 = v13({CornerRadius = UDim.new(0.3, 0)})
    local v14 = p1:New("TextLabel")
    v14 = v14({
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
    local v15 = p1:New("TextButton")
    local v16 = {
        Name = "Exit",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 73, 73),
        Position = UDim2.fromScale(1, -0.15),
        Size = UDim2.fromScale(1, 1),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        AutoButtonColor = false,
        Text = "",
    }
    local v17 = {}
    local v18 = p1:New("UICorner")
    v18 = v18({CornerRadius = UDim.new(0.2, 0)})
    local v19 = p1:New("Frame")
    local v20 = {
        Name = "Fill",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(49, 49, 49),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.8, 0.8),
    }
    local v21 = {}
    local v22 = p1:New("UICorner")
    v21[1] = v22({CornerRadius = UDim.new(0.2, 0)})
    v20[Children] = v21
    v19 = v19(v20)
    v20 = p1:New("TextLabel")
    local v23 = {
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
    v17[1] = v18
    v17[2] = v19
    v17[3] = v20(v23)
    v16[Children] = v17
    v12[1] = v13
    v12[2] = v14
    v12[3] = v15(v16)
    v11[Children] = v12
    v10 = v10(v11)
    v11 = p1:New("Frame")
    local v24 = {
        Name = "Container",
        AnchorPoint = Vector2.new(1, 1),
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.995, 1),
        Size = UDim2.fromScale(0.695, 0.945),
    }
    v13 = {}
    v14 = p1:New("UICorner")
    v13[1] = v14({CornerRadius = UDim.new(0.016, 0)})
    v24[Children] = v13
    v11 = v11(v24)
    v24 = p1:New("Frame")
    v12 = {
        Name = "Tabs",
        AnchorPoint = Vector2.new(0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.fromScale(0.296, 1),
    }
    v14 = {}
    v15 = p1:New("UICorner")
    v15 = v15({CornerRadius = UDim.new(0.035, 0)})
    v16 = p1:New("ScrollingFrame")
    local v25 = {
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
    v18 = {}
    v19 = p1:New("UIListLayout")
    v18[1] = v19({SortOrder = Enum.SortOrder.LayoutOrder})
    v25[Children] = v18
    v16 = v16(v25)
    v25 = p1:New("Frame")
    v17 = {
        Name = "Background",
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 0,
    }
    v19 = {}
    v20 = p1:New("Frame")
    v23 = {Name = "CurvedFrame", BackgroundColor3 = Color3.new(), BackgroundTransparency = 0.9, Size = UDim2.fromScale(1.2, 1)}
    v22 = {}
    local v26 = p1:New("UICorner")
    v22[1] = v26({CornerRadius = UDim.new(0.028, 0)})
    v23[Children] = v22
    v19[1] = v20(v23)
    v17[Children] = v19
    v14[1] = v15
    v14[2] = v16
    v14[3] = v25(v17)
    v12[Children] = v14
    v24 = v24(v12)
    v12 = p1:New("UIGradient")
    v13 = {Rotation = 90}
    v15 = {}
    v16 = ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1))
    v15[1] = v16
    v15[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(95, 95, 95))
    v13.Color = ColorSequence.new(v15)
    v7[1] = v8
    v7[2] = v9
    v7[3] = v10
    v7[4] = v11
    v7[5] = v24
    v7[6] = v12(v13)
    v6[Children] = v7
    v4[1] = v5(v6)
    v3[Children] = v4
    return v2(v3)
end