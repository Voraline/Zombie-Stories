local v1 = scope:New("ScreenGui")
local v2 = {Name = "SettingsGui", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}
local v3 = Children
local v4 = {}
local v5 = scope:New("Frame")
local v6 = {
    Name = "Panel",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(17, 37, 63),
    BackgroundTransparency = 0.1,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(1.2, 0.78),
    SizeConstraint = Enum.SizeConstraint.RelativeYY,
}
local v7 = Children
local v8 = {}
local v9 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.015, 0)})
local v10 = scope:New("Frame")({
    Name = "Background",
    BorderSizePixel = 0,
    Visible = false,
    ZIndex = 0,
    BackgroundColor3 = Color3.fromRGB(14, 33, 50),
    BorderColor3 = Color3.fromRGB(27, 42, 53),
    Size = UDim2.fromScale(1.538, 1),
    SizeConstraint = Enum.SizeConstraint.RelativeYY,
})
local v11 = scope:New("Frame")
local v12 = {Name = "Header", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.065)}
local v13 = Children
local v14 = {}
local v15 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.3, 0)})
local v16 = scope:New("TextLabel")({
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
local v17 = scope:New("TextButton")
local v18 = {
    Name = "Exit",
    Active = false,
    AnchorPoint = Vector2.new(1, 1),
    BackgroundTransparency = 1,
    LayoutOrder = 1000,
    Position = UDim2.new(1, 5, 0, -10),
    Size = UDim2.fromOffset(35, 35),
    Visible = false,
}
local v19 = Children
local v20 = {}
local v21 = scope:New("ImageLabel")
local v22 = {
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
local v23 = Children
local v24 = {}
local v25 = scope:New("ImageLabel")({
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
local v26 = scope:New("TextLabel")
local v27 = {
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
local v28 = Children
v27[v28] = {scope:New("UITextSizeConstraint")({Name = "UITextSizeConstraint", MaxTextSize = 20})}
v24[1] = v25
v24[2] = v26(v27)
v22[v23] = v24
v20[1] = v21(v22)
v18[v19] = v20
v14[1] = v15
v14[2] = v16
v14[3] = v17(v18)
v12[v13] = v14
v11 = v11(v12)
v12 = scope:New("Frame")
v13 = {
    Name = "Container",
    AnchorPoint = Vector2.new(1, 1),
    BackgroundTransparency = 1,
    Position = UDim2.fromScale(0.995, 1),
    Size = UDim2.fromScale(0.695, 0.945),
}
v14 = Children
v13[v14] = {scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.016, 0)})}
v12 = v12(v13)
v13 = scope:New("Frame")
v14 = {
    Name = "Tabs",
    AnchorPoint = Vector2.new(0, 1),
    BackgroundTransparency = 1,
    Position = UDim2.fromScale(0, 1),
    Size = UDim2.fromScale(0.296, 1),
}
v15 = Children
v16 = {}
v17 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.035, 0)})
v18 = scope:New("ScrollingFrame")
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
v21 = {}
v22 = scope:New("UIListLayout")({Name = "UIListLayout", SortOrder = Enum.SortOrder.LayoutOrder})
v23 = scope:New("TextButton")
v24 = {
    Name = "Button",
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 0.3),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    Visible = false,
}
v25 = Children
v26 = {}
v27 = scope:New("Frame")
v28 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(),
    BackgroundTransparency = 0.8,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.95, -8, 0.85, -8),
}
local v29 = Children
local v30 = {}
local v31 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.2, 0)})
local v32 = scope:New("UIStroke")({Name = "UIStroke", Thickness = 4, Color = Color3.fromRGB(255, 184, 84)})
local v33 = scope:New("TextLabel")
local v34 = {
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
v30[1] = v31
v30[2] = v32
v30[3] = v33(v34)
v28[v29] = v30
v26[1] = v27(v28)
v24[v25] = v26
v23 = v23(v24)
v24 = scope:New("TextButton")
v25 = {
    Name = "Exit",
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 0.2),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    Visible = false,
}
v26 = Children
v27 = {}
v28 = scope:New("Frame")
v29 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(61, 0, 0),
    BackgroundTransparency = 0.8,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.95, -8, 0.85, -8),
}
v30 = Children
v31 = {}
v32 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.2, 0)})
v33 = scope:New("UIStroke")({Name = "UIStroke", Thickness = 4, Color = Color3.fromRGB(255, 73, 73)})
v34 = scope:New("TextLabel")
local v35 = {
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
v31[1] = v32
v31[2] = v33
v31[3] = v34(v35)
v29[v30] = v31
v27[1] = v28(v29)
v25[v26] = v27
v21[1] = v22
v21[2] = v23
v21[3] = v24(v25)
v19[v20] = v21
v18 = v18(v19)
v19 = scope:New("Frame")
v20 = {
    Name = "Background",
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    Size = UDim2.fromScale(1, 1),
    ZIndex = 0,
}
v21 = Children
v22 = {}
v23 = scope:New("Frame")
v24 = {
    Name = "CurvedFrame",
    BackgroundColor3 = Color3.new(),
    BackgroundTransparency = 0.9,
    Size = UDim2.fromScale(1.2, 1),
}
v25 = Children
v24[v25] = {scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.028, 0)})}
v22[1] = v23(v24)
v20[v21] = v22
v16[1] = v17
v16[2] = v18
v16[3] = v19(v20)
v14[v15] = v16
v13 = v13(v14)
v14 = scope:New("UIGradient")
v15 = {
    Name = "UIGradient",
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
v6[v7] = v8
v4[1] = v5(v6)
v2[v3] = v4
v1(v2)