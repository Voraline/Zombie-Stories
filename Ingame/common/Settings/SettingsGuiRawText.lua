local v1 = scope:New("ScreenGui")
local v2 = {Name = "SettingsGui", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}
local v3 = {}
local v4 = scope:New("Frame")
local v5 = {
    Name = "Panel",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(17, 37, 63),
    BackgroundTransparency = 0.1,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(1.2, 0.78),
    SizeConstraint = Enum.SizeConstraint.RelativeYY,
}
local v6 = {}
local v7 = scope:New("UICorner")
v7 = v7({Name = "UICorner", CornerRadius = UDim.new(0.015, 0)})
local v8 = scope:New("Frame")
v8 = v8({
    Name = "Background",
    BorderSizePixel = 0,
    Visible = false,
    ZIndex = 0,
    BackgroundColor3 = Color3.fromRGB(14, 33, 50),
    BorderColor3 = Color3.fromRGB(27, 42, 53),
    Size = UDim2.fromScale(1.538, 1),
    SizeConstraint = Enum.SizeConstraint.RelativeYY,
})
local v9 = scope:New("Frame")
local v10 = {Name = "Header", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.065)}
local v11 = {}
local v12 = scope:New("UICorner")
v12 = v12({Name = "UICorner", CornerRadius = UDim.new(0.3, 0)})
local v13 = scope:New("TextLabel")
v13 = v13({
    Name = "TextLabel",
    BackgroundTransparency = 1,
    Text = "SETTINGS",
    TextScaled = true,
    AnchorPoint = Vector2.new(1, 0),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.99, 0),
    Size = UDim2.fromScale(0.15, 1),
    TextColor3 = Color3.fromRGB(255, 184, 84),
})
local v14 = scope:New("TextButton")
local v15 = {
    Name = "Exit",
    Active = false,
    AnchorPoint = Vector2.new(1, 1),
    BackgroundTransparency = 1,
    LayoutOrder = 1000,
    Position = UDim2.new(1, 5, 0, -10),
    Size = UDim2.fromOffset(35, 35),
    Visible = false,
}
local v16 = {}
local v17 = scope:New("ImageLabel")
local v18 = {
    Name = "WeaponStats",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2851926732",
    ImageColor3 = Color3.fromRGB(255, 73, 73),
    LayoutOrder = -1,
    Position = UDim2.fromScale(0.5, 0.5),
    ScaleType = Enum.ScaleType.Slice,
    Selectable = true,
    Size = UDim2.fromScale(1, 1),
    SliceCenter = Rect.new(12, 12, 12, 12),
}
local v19 = {}
local v20 = scope:New("ImageLabel")
v20 = v20({
    Name = "Fill",
    BackgroundTransparency = 1,
    Image = "rbxassetid://2851928361",
    AnchorPoint = Vector2.new(0.5, 0.5),
    ImageColor3 = Color3.fromRGB(49, 49, 49),
    Position = UDim2.fromScale(0.5, 0.5),
    ScaleType = Enum.ScaleType.Slice,
    Size = UDim2.new(1, -10, 1, -10),
    SliceCenter = Rect.new(7, 7, 7, 7),
})
local v21 = scope:New("TextLabel")
local v22 = {
    Name = "Label",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.525, 0.5),
    Size = UDim2.fromScale(0.85, 0.8),
    Text = "X",
    TextColor3 = Color3.fromRGB(255, 73, 73),
    TextScaled = true,
}
local v23 = {}
local v24 = scope:New("UITextSizeConstraint")
v23[1] = v24({Name = "UITextSizeConstraint", MaxTextSize = 20})
v22[Children] = v23
v19[1] = v20
v19[2] = v21(v22)
v18[Children] = v19
v16[1] = v17(v18)
v15[Children] = v16
v11[1] = v12
v11[2] = v13
v11[3] = v14(v15)
v10[Children] = v11
v9 = v9(v10)
v10 = scope:New("Frame")
local v25 = {
    Name = "Container",
    AnchorPoint = Vector2.new(1, 1),
    BackgroundTransparency = 1,
    Position = UDim2.fromScale(0.995, 1),
    Size = UDim2.fromScale(0.695, 0.945),
}
v12 = {}
v13 = scope:New("UICorner")
v12[1] = v13({Name = "UICorner", CornerRadius = UDim.new(0.016, 0)})
v25[Children] = v12
v10 = v10(v25)
v25 = scope:New("Frame")
v11 = {
    Name = "Tabs",
    AnchorPoint = Vector2.new(0, 1),
    BackgroundTransparency = 1,
    Position = UDim2.fromScale(0, 1),
    Size = UDim2.fromScale(0.296, 1),
}
v13 = {}
v14 = scope:New("UICorner")
v14 = v14({Name = "UICorner", CornerRadius = UDim.new(0.035, 0)})
v15 = scope:New("ScrollingFrame")
local v26 = {
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
v17 = {}
v18 = scope:New("UIListLayout")
v18 = v18({Name = "UIListLayout", SortOrder = Enum.SortOrder.LayoutOrder})
local v27 = scope:New("TextButton")
v19 = {
    Name = "Button",
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 0.3),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    Visible = false,
}
v21 = {}
v22 = scope:New("Frame")
local v28 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(),
    BackgroundTransparency = 0.8,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.95, -8, 0.85, -8),
}
v24 = {}
local v29 = scope:New("UICorner")
v29 = v29({Name = "UICorner", CornerRadius = UDim.new(0.2, 0)})
local v30 = scope:New("UIStroke")
v30 = v30({Name = "UIStroke", Thickness = 4, Color = Color3.fromRGB(255, 184, 84)})
local v31 = scope:New("TextLabel")
local v32 = {
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "GRAPHICS",
    TextScaled = true,
    AnchorPoint = Vector2.new(0.5, 0.5),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.9, 0.85),
    TextColor3 = Color3.new(1, 1, 1),
}
v24[1] = v29
v24[2] = v30
v24[3] = v31(v32)
v28[Children] = v24
v21[1] = v22(v28)
v19[Children] = v21
v27 = v27(v19)
v19 = scope:New("TextButton")
v20 = {
    Name = "Exit",
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 0.2),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    Visible = false,
}
v22 = {}
v28 = scope:New("Frame")
v23 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(61, 0, 0),
    BackgroundTransparency = 0.8,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.95, -8, 0.85, -8),
}
v29 = {}
v30 = scope:New("UICorner")
v30 = v30({Name = "UICorner", CornerRadius = UDim.new(0.2, 0)})
v31 = scope:New("UIStroke")
v31 = v31({Name = "UIStroke", Thickness = 4, Color = Color3.fromRGB(255, 73, 73)})
v32 = scope:New("TextLabel")
local v33 = {
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "EXIT",
    TextScaled = true,
    AnchorPoint = Vector2.new(0.5, 0.5),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.9, 0.85),
    TextColor3 = Color3.fromRGB(255, 73, 73),
}
v29[1] = v30
v29[2] = v31
v29[3] = v32(v33)
v23[Children] = v29
v22[1] = v28(v23)
v20[Children] = v22
v17[1] = v18
v17[2] = v27
v17[3] = v19(v20)
v26[Children] = v17
v15 = v15(v26)
v26 = scope:New("Frame")
v16 = {
    Name = "Background",
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    Size = UDim2.fromScale(1, 1),
    ZIndex = 0,
}
v18 = {}
v27 = scope:New("Frame")
v19 = {Name = "CurvedFrame", BackgroundColor3 = Color3.new(), BackgroundTransparency = 0.9, Size = UDim2.fromScale(1.2, 1)}
v21 = {}
v22 = scope:New("UICorner")
v21[1] = v22({Name = "UICorner", CornerRadius = UDim.new(0.028, 0)})
v19[Children] = v21
v18[1] = v27(v19)
v16[Children] = v18
v13[1] = v14
v13[2] = v15
v13[3] = v26(v16)
v11[Children] = v13
v25 = v25(v11)
v11 = scope:New("UIGradient")
v12 = {Name = "UIGradient", Rotation = 90}
v14 = {}
v15 = ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1))
v14[1] = v15
v14[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(95, 95, 95))
v12.Color = ColorSequence.new(v14)
v6[1] = v7
v6[2] = v8
v6[3] = v9
v6[4] = v10
v6[5] = v25
v6[6] = v11(v12)
v5[Children] = v6
v3[1] = v4(v5)
v2[Children] = v3
v1(v2)