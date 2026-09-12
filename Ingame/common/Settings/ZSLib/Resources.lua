local v1 = scope:New("Folder")
local v2 = {Name = "Resources"}
local v3 = Children
local v4 = {}
local v5 = scope:New("ImageButton")
local v6 = {
    Name = "Dropdownold",
    AnchorPoint = Vector2.new(1, 1),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    Image = "rbxassetid://2851928361",
    ImageColor3 = Color3.new(),
    ImageTransparency = 0.25,
    Position = UDim2.fromScale(1, 1),
    ScaleType = Enum.ScaleType.Slice,
    Selectable = false,
    Size = UDim2.fromScale(1, 1),
    SliceCenter = Rect.new(7, 7, 7, 7),
    Visible = false,
}
local v7 = Children
local v8 = {}
local v9 = scope:New("ScrollingFrame")
local v10 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    CanvasSize = UDim2.new(),
    ClipsDescendants = false,
    Position = UDim2.fromScale(0.5, 0.5),
    ScrollBarImageColor3 = Color3.fromRGB(16, 16, 16),
    ScrollBarThickness = 0,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    Selectable = false,
    Size = UDim2.new(1, -5, 1, -5),
}
local v11 = Children
local v12 = {}
local v13 = scope:New("UIGridLayout")({
    Name = "UIGridLayout",
    CellPadding = UDim2.fromOffset(0, -5),
    CellSize = UDim2.new(1, 0, 0, 45),
    FillDirection = Enum.FillDirection.Vertical,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Center,
})
local v14 = scope:New("TextButton")
local v15 = {
    Name = "Exit",
    Active = false,
    BackgroundTransparency = 1,
    LayoutOrder = 1000,
    Size = UDim2.fromOffset(100, 100),
    Visible = false,
}
local v16 = Children
local v17 = {}
local v18 = scope:New("ImageLabel")
local v19 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2851926732",
    ImageColor3 = Color3.fromRGB(255, 73, 73),
    LayoutOrder = -1,
    Position = UDim2.fromScale(0.5, 0.5),
    ScaleType = Enum.ScaleType.Slice,
    Selectable = true,
    Size = UDim2.new(1, -10, 1, -10),
    SliceCenter = Rect.new(12, 12, 12, 12),
}
local v20 = Children
local v21 = {}
local v22 = scope:New("ImageLabel")({
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
local v23 = scope:New("TextLabel")
local v24 = {
    Name = "Label",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.9, 0.8),
    Text = "EXIT",
    TextColor3 = Color3.fromRGB(255, 73, 73),
    TextScaled = true,
}
local v25 = Children
v24[v25] = {scope:New("UITextSizeConstraint")({Name = "UITextSizeConstraint", MaxTextSize = 20})}
v21[1] = v22
v21[2] = v23(v24)
v19[v20] = v21
v18 = v18(v19)
v19 = scope:New("UISizeConstraint")
v20 = {Name = "UISizeConstraint", MaxSize = Vector2.new(300, 0)}
v17[1] = v18
v17[2] = v19(v20)
v15[v16] = v17
v14 = v14(v15)
v15 = scope:New("TextButton")
v16 = {Name = "Button", BackgroundTransparency = 1, Size = UDim2.fromOffset(100, 100), Visible = false}
v17 = Children
v18 = {}
v19 = scope:New("ImageLabel")
v20 = {
    Name = "Frame",
    Active = true,
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2851926732",
    ImageColor3 = Color3.fromRGB(34, 34, 34),
    LayoutOrder = -1,
    Position = UDim2.fromScale(0.5, 0.5),
    ScaleType = Enum.ScaleType.Slice,
    Selectable = true,
    Size = UDim2.new(1, -10, 1, -10),
    SliceCenter = Rect.new(12, 12, 12, 12),
}
v21 = Children
v22 = {}
v23 = scope:New("ImageLabel")({
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
v24 = scope:New("TextLabel")
v25 = {
    Name = "Label",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.9, 0.8),
    Text = "AUTOMATIC",
    TextColor3 = Color3.fromRGB(216, 216, 216),
    TextScaled = true,
}
local v26 = Children
v25[v26] = {scope:New("UITextSizeConstraint")({Name = "UITextSizeConstraint", MaxTextSize = 20})}
v22[1] = v23
v22[2] = v24(v25)
v20[v21] = v22
v19 = v19(v20)
v20 = scope:New("UISizeConstraint")
v21 = {Name = "UISizeConstraint", MaxSize = Vector2.new(300, 0)}
v18[1] = v19
v18[2] = v20(v21)
v16[v17] = v18
v12[1] = v13
v12[2] = v14
v12[3] = v15(v16)
v10[v11] = v12
v9 = v9(v10)
v10 = scope:New("TextButton")
v11 = {
    Name = "Exit",
    AnchorPoint = Vector2.new(1, 0),
    BackgroundTransparency = 1,
    LayoutOrder = 1000,
    Position = UDim2.new(1, -10, 0, 10),
    Size = UDim2.fromOffset(35, 35),
    Text = "X",
}
v12 = Children
v13 = {}
v14 = scope:New("ImageLabel")
v15 = {
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
v16 = Children
v17 = {}
v18 = scope:New("ImageLabel")({
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
v19 = scope:New("TextLabel")
v20 = {
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
v21 = Children
v20[v21] = {scope:New("UITextSizeConstraint")({Name = "UITextSizeConstraint", MaxTextSize = 20})}
v17[1] = v18
v17[2] = v19(v20)
v15[v16] = v17
v13[1] = v14(v15)
v11[v12] = v13
v8[1] = v9
v8[2] = v10(v11)
v6[v7] = v8
v5 = v5(v6)
v6 = scope:New("ScrollingFrame")
v7 = {
    Name = "ContainerTemplate",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    BottomImage = "",
    CanvasSize = UDim2.fromOffset(0, 346),
    Position = UDim2.fromScale(0.5, 0.5),
    ScrollBarImageColor3 = Color3.fromRGB(16, 16, 16),
    ScrollBarThickness = 3,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    Selectable = false,
    Size = UDim2.new(1, -5, 1, -5),
    TopImage = "",
    Visible = false,
}
v8 = Children
v7[v8] = {scope:New("UIListLayout")({Name = "UIListLayout", SortOrder = Enum.SortOrder.LayoutOrder})}
v6 = v6(v7)
v7 = scope:New("Sound")({Name = "button", SoundId = "rbxassetid://129190194679291"})
v8 = scope:New("Sound")({Name = "close", SoundId = "rbxassetid://92617871621489"})
v9 = scope:New("Folder")
v10 = {Name = "Templates"}
v11 = Children
v12 = {}
v13 = scope:New("Frame")
v14 = {
    Name = "Toggle",
    BackgroundTransparency = 1,
    LayoutOrder = 1,
    Size = UDim2.fromScale(1, 0.08),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
}
v15 = Children
v16 = {}
v17 = scope:New("Frame")
v18 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(),
    BackgroundTransparency = 0.8,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.99, 0.85),
}
v19 = Children
v20 = {}
v21 = scope:New("UICorner")({Name = "UICorner"})
v22 = scope:New("ImageButton")
v23 = {
    Name = "Toggle",
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2851928361",
    ImageColor3 = Color3.fromRGB(33, 33, 33),
    ImageTransparency = 1,
    Position = UDim2.fromScale(1, 0.5),
    ScaleType = Enum.ScaleType.Slice,
    Size = UDim2.fromScale(0.18, 1),
    SliceCenter = Rect.new(7, 7, 7, 7),
}
v24 = Children
v25 = {}
v26 = scope:New("Frame")
local v27 = {
    Name = "Back",
    AnchorPoint = Vector2.new(0, 0.5),
    BackgroundColor3 = Color3.new(1, 1, 1),
    BackgroundTransparency = 0.95,
    Position = UDim2.fromScale(0, 0.5),
    Size = UDim2.fromScale(1, 1),
}
local v28 = Children
v27[v28] = {scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.17, 0)})}
v26 = v26(v27)
v27 = scope:New("Frame")
v28 = {
    Name = "Fill",
    AnchorPoint = Vector2.new(0, 0.5),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    Position = UDim2.fromScale(0, 0.5),
    Size = UDim2.fromScale(0.75, 1),
    ZIndex = 2,
}
local v29 = Children
local v30 = {}
local v31 = scope:New("Frame")
local v32 = {Name = "Frame", BackgroundColor3 = Color3.fromRGB(255, 184, 84), Size = UDim2.fromScale(100, 1)}
local v33 = Children
v32[v33] = {scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.17, 0)})}
v30[1] = v31(v32)
v28[v29] = v30
v27 = v27(v28)
v28 = scope:New("Frame")
v29 = {
    Name = "Slide",
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundColor3 = Color3.new(1, 1, 1),
    Position = UDim2.fromScale(1, 0.5),
    Size = UDim2.fromScale(0.4, 1),
    ZIndex = 3,
}
v30 = Children
v29[v30] = {scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.2, 0)})}
v25[1] = v26
v25[2] = v27
v25[3] = v28(v29)
v23[v24] = v25
v22 = v22(v23)
v23 = scope:New("TextLabel")({
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "ANIMATED SKINS",
    TextScaled = true,
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.01, 0),
    Size = UDim2.fromScale(0.8, 0.06),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
})
v24 = scope:New("TextLabel")
v25 = {
    Name = "DescriptionLabel",
    BackgroundTransparency = 1,
    Text = "ANIMATED SKINS",
    TextScaled = true,
    TextTransparency = 0.5,
    Visible = false,
    AnchorPoint = Vector2.new(0, 1),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.01, 0.96),
    Size = UDim2.fromScale(0.8, 0.05),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
}
v20[1] = v21
v20[2] = v22
v20[3] = v23
v20[4] = v24(v25)
v18[v19] = v20
v16[1] = v17(v18)
v14[v15] = v16
v13 = v13(v14)
v14 = scope:New("Frame")
v15 = {
    Name = "NumberSlider",
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 0.11),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
}
v16 = Children
v17 = {}
v18 = scope:New("Frame")
v19 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(),
    BackgroundTransparency = 0.8,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.99, 0.85),
}
v20 = Children
v21 = {}
v22 = scope:New("UICorner")({Name = "UICorner"})
v23 = scope:New("ImageLabel")
v24 = {
    Name = "Slide",
    AnchorPoint = Vector2.new(0.5, 1),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2851928361",
    ImageColor3 = Color3.fromRGB(33, 33, 33),
    ImageTransparency = 1,
    Position = UDim2.fromScale(0.5, 0.85),
    ScaleType = Enum.ScaleType.Slice,
    Size = UDim2.fromScale(0.97, 0.01),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    SliceCenter = Rect.new(7, 7, 7, 7),
}
v25 = Children
v26 = {}
v27 = scope:New("ImageLabel")
v28 = {
    Name = "SlidingBase",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2851928361",
    ImageColor3 = Color3.fromRGB(33, 33, 33),
    ImageTransparency = 1,
    Position = UDim2.fromScale(0.5, 0.5),
    ScaleType = Enum.ScaleType.Slice,
    Size = UDim2.fromScale(1, 1),
    SliceCenter = Rect.new(7, 7, 7, 7),
}
v29 = Children
v30 = {}
v31 = scope:New("ImageLabel")({
    Name = "Fill",
    BackgroundTransparency = 1,
    Image = "rbxassetid://2851928361",
    SliceScale = 2,
    AnchorPoint = Vector2.new(0, 0.5),
    ImageColor3 = Color3.fromRGB(255, 184, 84),
    Position = UDim2.fromScale(0, 0.5),
    ScaleType = Enum.ScaleType.Slice,
    Size = UDim2.fromScale(0.3, 0.75),
    SliceCenter = Rect.new(7, 7, 7, 7),
})
v32 = scope:New("ImageLabel")
v33 = {
    Name = "Slide",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    Image = "rbxassetid://4175209485",
    Position = UDim2.fromScale(0.3, 0.5),
    Size = UDim2.fromScale(0.016, 0.016),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    SliceCenter = Rect.new(7, 7, 7, 7),
    ZIndex = 3,
}
local v34 = Children
v33[v34] = {
    scope:New("TextButton")({
        Name = "Button",
        BackgroundTransparency = 1,
        Text = "",
        TextSize = 14,
        TextTransparency = 1,
        ZIndex = 50,
        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
        Size = UDim2.fromScale(1, 1),
        TextColor3 = Color3.new(),
    }),
}
v32 = v32(v33)
v33 = scope:New("Frame")
v34 = {
    Name = "Back",
    AnchorPoint = Vector2.new(0, 0.5),
    BackgroundColor3 = Color3.new(),
    BackgroundTransparency = 0.8,
    Position = UDim2.fromScale(0, 0.5),
    Size = UDim2.fromScale(1, 0.75),
}
local v35 = Children
v34[v35] = {scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(1, 0)})}
v30[1] = v31
v30[2] = v32
v30[3] = v33(v34)
v28[v29] = v30
v26[1] = v27(v28)
v24[v25] = v26
v23 = v23(v24)
v24 = scope:New("ImageLabel")
v25 = {
    Name = "TextBox",
    AnchorPoint = Vector2.new(1, 0),
    BackgroundColor3 = Color3.new(1, 1, 1),
    BackgroundTransparency = 0.9,
    Image = "rbxassetid://2851928361",
    ImageColor3 = Color3.fromRGB(33, 33, 33),
    ImageTransparency = 1,
    Position = UDim2.fromScale(1, 0),
    ScaleType = Enum.ScaleType.Slice,
    Size = UDim2.fromScale(0.16, 0.6),
    SliceCenter = Rect.new(7, 7, 7, 7),
}
v26 = Children
v27 = {}
v28 = scope:New("TextBox")({
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "1",
    TextScaled = true,
    AnchorPoint = Vector2.new(0.5, 0.5),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    PlaceholderColor3 = Color3.new(1, 1, 1),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(1, 0.7),
    TextColor3 = Color3.new(1, 1, 1),
})
v29 = scope:New("UICorner")
v30 = {Name = "UICorner", CornerRadius = UDim.new(0.2, 0)}
v27[1] = v28
v27[2] = v29(v30)
v25[v26] = v27
v24 = v24(v25)
v25 = scope:New("TextLabel")({
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "MUSIC VOLUME",
    TextScaled = true,
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.01, 0.04),
    Size = UDim2.fromScale(0.82, 0.06),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
})
v26 = scope:New("TextLabel")
v27 = {
    Name = "DescriptionLabel",
    BackgroundTransparency = 1,
    Text = "ANIMATED SKINS",
    TextScaled = true,
    TextTransparency = 0.5,
    Visible = false,
    AnchorPoint = Vector2.new(0, 1),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.01, 0.75),
    Size = UDim2.fromScale(0.82, 0.05),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
}
v21[1] = v22
v21[2] = v23
v21[3] = v24
v21[4] = v25
v21[5] = v26(v27)
v19[v20] = v21
v17[1] = v18(v19)
v15[v16] = v17
v14 = v14(v15)
v15 = scope:New("Frame")
v16 = {
    Name = "Number",
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 0.08),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
}
v17 = Children
v18 = {}
v19 = scope:New("Frame")
v20 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(),
    BackgroundTransparency = 0.8,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.99, 0.85),
}
v21 = Children
v22 = {}
v23 = scope:New("ImageLabel")
v24 = {
    Name = "Toggle",
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundColor3 = Color3.new(1, 1, 1),
    BackgroundTransparency = 0.9,
    Image = "rbxassetid://2851928361",
    ImageColor3 = Color3.fromRGB(33, 33, 33),
    ImageTransparency = 1,
    Position = UDim2.fromScale(1, 0.5),
    ScaleType = Enum.ScaleType.Slice,
    Size = UDim2.fromScale(0.16, 1),
    SliceCenter = Rect.new(7, 7, 7, 7),
}
v25 = Children
v26 = {}
v27 = scope:New("TextBox")({
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "1",
    TextScaled = true,
    AnchorPoint = Vector2.new(0.5, 0.5),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    PlaceholderColor3 = Color3.new(1, 1, 1),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(1, 0.7),
    TextColor3 = Color3.new(1, 1, 1),
})
v28 = scope:New("UICorner")
v29 = {Name = "UICorner", CornerRadius = UDim.new(0.15, 0)}
v26[1] = v27
v26[2] = v28(v29)
v24[v25] = v26
v23 = v23(v24)
v24 = scope:New("TextLabel")({
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "MUSIC VOLUME",
    TextScaled = true,
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.01, 0),
    Size = UDim2.fromScale(0.82, 0.06),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
})
v25 = scope:New("UICorner")({Name = "UICorner"})
v26 = scope:New("TextLabel")
v27 = {
    Name = "DescriptionLabel",
    BackgroundTransparency = 1,
    Text = "ANIMATED SKINS",
    TextScaled = true,
    TextTransparency = 0.5,
    Visible = false,
    AnchorPoint = Vector2.new(0, 1),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.01, 0.96),
    Size = UDim2.fromScale(0.82, 0.05),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
}
v22[1] = v23
v22[2] = v24
v22[3] = v25
v22[4] = v26(v27)
v20[v21] = v22
v18[1] = v19(v20)
v16[v17] = v18
v15 = v15(v16)
v16 = scope:New("Frame")
v17 = {
    Name = "BindsHeader",
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 0.09),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
}
v18 = Children
v19 = {}
v20 = scope:New("Frame")
v21 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(),
    BackgroundTransparency = 0.8,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.99, 0.85),
}
v22 = Children
v23 = {}
v24 = scope:New("UICorner")({Name = "UICorner"})
v25 = scope:New("TextLabel")({
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "PRESS TO BIND",
    TextScaled = true,
    AnchorPoint = Vector2.new(0, 0.5),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.01, 0.5),
    Size = UDim2.fromScale(0.5, 0.9),
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
})
v26 = scope:New("ImageLabel")({
    Name = "KeyboardLabel",
    BackgroundTransparency = 1,
    Image = "rbxassetid://13693390115",
    AnchorPoint = Vector2.new(0.5, 0.5),
    ImageColor3 = Color3.fromRGB(255, 184, 84),
    Position = UDim2.new(0.695, -4, 0.5, 0),
    Size = UDim2.fromScale(0.06, 0.06),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
})
v27 = scope:New("ImageLabel")({
    Name = "MouseLabel",
    BackgroundTransparency = 1,
    Image = "rbxassetid://13693587767",
    AnchorPoint = Vector2.new(0.5, 0.5),
    ImageColor3 = Color3.fromRGB(255, 184, 84),
    Position = UDim2.new(0.815, -2, 0.5, 0),
    Size = UDim2.fromScale(0.06, 0.06),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
})
v28 = scope:New("ImageLabel")
v29 = {
    Name = "GamepadLabel",
    BackgroundTransparency = 1,
    Image = "rbxassetid://13693666926",
    AnchorPoint = Vector2.new(0.5, 0.5),
    ImageColor3 = Color3.fromRGB(255, 184, 84),
    Position = UDim2.fromScale(0.935, 0.5),
    Size = UDim2.fromScale(0.06, 0.06),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
}
v23[1] = v24
v23[2] = v25
v23[3] = v26
v23[4] = v27
v23[5] = v28(v29)
v21[v22] = v23
v19[1] = v20(v21)
v17[v18] = v19
v16 = v16(v17)
v17 = scope:New("Frame")
v18 = {
    Name = "Header",
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 0.09),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
}
v19 = Children
v20 = {}
v21 = scope:New("Frame")
v22 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(),
    BackgroundTransparency = 0.8,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.99, 0.85),
}
v23 = Children
v24 = {}
v25 = scope:New("UICorner")({Name = "UICorner"})
v26 = scope:New("TextLabel")
v27 = {
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "GRAPHICS",
    TextScaled = true,
    AnchorPoint = Vector2.new(0.5, 0.5),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.9, 0.9),
    TextColor3 = Color3.new(1, 1, 1),
}
v24[1] = v25
v24[2] = v26(v27)
v22[v23] = v24
v20[1] = v21(v22)
v18[v19] = v20
v17 = v17(v18)
v18 = scope:New("Frame")
v19 = {
    Name = "Dropdown",
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 0.08),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
}
v20 = Children
v21 = {}
v22 = scope:New("Frame")
v23 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(),
    BackgroundTransparency = 0.8,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.99, 0.85),
}
v24 = Children
v25 = {}
v26 = scope:New("UICorner")({Name = "UICorner"})
v27 = scope:New("ImageButton")
v28 = {
    Name = "Toggle",
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundColor3 = Color3.new(1, 1, 1),
    BackgroundTransparency = 0.9,
    Image = "rbxassetid://2851928361",
    ImageColor3 = Color3.fromRGB(33, 33, 33),
    ImageTransparency = 1,
    Position = UDim2.fromScale(1, 0.5),
    ScaleType = Enum.ScaleType.Slice,
    Size = UDim2.fromScale(0.22, 1),
    SliceCenter = Rect.new(7, 7, 7, 7),
}
v29 = Children
v30 = {}
v31 = scope:New("TextLabel")({
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "AUTOMATIC",
    TextScaled = true,
    AnchorPoint = Vector2.new(0, 0.5),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.05, 0.5),
    Size = UDim2.fromScale(0.78, 0.6),
    TextColor3 = Color3.new(1, 1, 1),
})
v32 = scope:New("ImageLabel")({
    Name = "keyboard_arrow_down",
    BackgroundTransparency = 1,
    Image = "rbxassetid://3926305904",
    LayoutOrder = 19,
    Selectable = true,
    ZIndex = 2,
    AnchorPoint = Vector2.new(1, 0.5),
    ImageRectOffset = Vector2.new(404, 284),
    ImageRectSize = Vector2.new(36, 36),
    Position = UDim2.fromScale(1, 0.5),
    Size = UDim2.fromScale(0.2, 0.2),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
})
v33 = scope:New("UICorner")
v34 = {Name = "UICorner", CornerRadius = UDim.new(0.15, 0)}
v30[1] = v31
v30[2] = v32
v30[3] = v33(v34)
v28[v29] = v30
v27 = v27(v28)
v28 = scope:New("TextLabel")({
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "ZOMBIE DETAIL",
    TextScaled = true,
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.01, 0.04),
    Size = UDim2.fromScale(0.76, 0.06),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
})
v29 = scope:New("TextLabel")
v30 = {
    Name = "DescriptionLabel",
    BackgroundTransparency = 1,
    Text = "ANIMATED SKINS",
    TextScaled = true,
    TextTransparency = 0.5,
    Visible = false,
    AnchorPoint = Vector2.new(0, 1),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.01, 0.96),
    Size = UDim2.fromScale(0.76, 0.05),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
}
v25[1] = v26
v25[2] = v27
v25[3] = v28
v25[4] = v29(v30)
v23[v24] = v25
v21[1] = v22(v23)
v19[v20] = v21
v18 = v18(v19)
v19 = scope:New("Frame")
v20 = {
    Name = "Button",
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 0.08),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
}
v21 = Children
v22 = {}
v23 = scope:New("Frame")
v24 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(),
    BackgroundTransparency = 0.8,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.99, 0.85),
}
v25 = Children
v26 = {}
v27 = scope:New("TextLabel")({
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "MUSIC VOLUME",
    TextScaled = true,
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.01, 0.04),
    Size = UDim2.fromScale(0.82, 0.06),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
})
v28 = scope:New("UICorner")({Name = "UICorner"})
v29 = scope:New("Frame")
v30 = {
    Name = "Toggle",
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundColor3 = Color3.new(1, 1, 1),
    BackgroundTransparency = 0.95,
    Position = UDim2.new(1, -3, 0.5, 0),
    Size = UDim2.fromScale(0.15, 1),
}
v31 = Children
v32 = {}
v33 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.18, 0)})
v34 = scope:New("TextButton")
v35 = {Name = "Button", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), TextTransparency = 1}
local v36 = Children
v35[v36] = {
    scope:New("TextLabel")({
        Name = "Label",
        BackgroundTransparency = 1,
        Text = "OPEN",
        TextScaled = true,
        AnchorPoint = Vector2.new(0.5, 0.5),
        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.9, 0.9),
        TextColor3 = Color3.fromRGB(255, 184, 84),
    }),
}
v34 = v34(v35)
v35 = scope:New("UIStroke")
v36 = {Name = "UIStroke", Thickness = 3, Color = Color3.fromRGB(255, 184, 84)}
v32[1] = v33
v32[2] = v34
v32[3] = v35(v36)
v30[v31] = v32
v29 = v29(v30)
v30 = scope:New("TextLabel")
v31 = {
    Name = "DescriptionLabel",
    BackgroundTransparency = 1,
    Text = "ANIMATED SKINS",
    TextScaled = true,
    TextTransparency = 0.5,
    Visible = false,
    AnchorPoint = Vector2.new(0, 1),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.01, 0.96),
    Size = UDim2.fromScale(0.82, 0.05),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
}
v26[1] = v27
v26[2] = v28
v26[3] = v29
v26[4] = v30(v31)
v24[v25] = v26
v22[1] = v23(v24)
v20[v21] = v22
v19 = v19(v20)
v20 = scope:New("Frame")
v21 = {
    Name = "Bind",
    BackgroundTransparency = 1,
    LayoutOrder = 1,
    Size = UDim2.fromScale(1, 0.16),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
}
v22 = Children
v23 = {}
v24 = scope:New("Frame")
v25 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(),
    BackgroundTransparency = 0.8,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.99, 0.85),
}
v26 = Children
v27 = {}
v28 = scope:New("UICorner")({Name = "UICorner"})
v29 = scope:New("TextLabel")({
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "JUMP",
    TextScaled = true,
    AnchorPoint = Vector2.new(0, 0.5),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.01, 0.5),
    Size = UDim2.fromScale(0.62, 0.07),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
})
v30 = scope:New("TextLabel")({
    Name = "DescriptionLabel",
    BackgroundTransparency = 1,
    Text = "ANIMATED SKINS",
    TextScaled = true,
    TextTransparency = 0.5,
    Visible = false,
    AnchorPoint = Vector2.new(0, 1),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.01, 0.83),
    Size = UDim2.fromScale(0.8, 0.04),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    TextColor3 = Color3.new(1, 1, 1),
    TextXAlignment = Enum.TextXAlignment.Left,
})
v31 = scope:New("ImageButton")
v32 = {
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
v33 = Children
v34 = {}
v35 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.1, 0)})
v36 = scope:New("UIStroke")
local v37 = {Name = "UIStroke", Color = Color3.fromRGB(255, 184, 84)}
v34[1] = v35
v34[2] = v36(v37)
v32[v33] = v34
v31 = v31(v32)
v32 = scope:New("ImageButton")
v33 = {
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
v34 = Children
v35 = {}
v36 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.1, 0)})
v37 = scope:New("UIStroke")
local v38 = {Name = "UIStroke", Color = Color3.fromRGB(255, 184, 84)}
v35[1] = v36
v35[2] = v37(v38)
v33[v34] = v35
v32 = v32(v33)
v33 = scope:New("ImageButton")
v34 = {
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
v35 = Children
v36 = {}
v37 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.1, 0)})
v38 = scope:New("UIStroke")
local v39 = {Name = "UIStroke", Color = Color3.fromRGB(255, 184, 84)}
v36[1] = v37
v36[2] = v38(v39)
v34[v35] = v36
v27[1] = v28
v27[2] = v29
v27[3] = v30
v27[4] = v31
v27[5] = v32
v27[6] = v33(v34)
v25[v26] = v27
v23[1] = v24(v25)
v21[v22] = v23
v12[1] = v13
v12[2] = v14
v12[3] = v15
v12[4] = v16
v12[5] = v17
v12[6] = v18
v12[7] = v19
v12[8] = v20(v21)
v10[v11] = v12
v9 = v9(v10)
v10 = scope:New("ImageButton")
v11 = {
    Name = "Dropdown",
    AnchorPoint = Vector2.new(1, 1),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    Image = "rbxassetid://2851928361",
    ImageColor3 = Color3.fromRGB(6, 14, 24),
    ImageTransparency = 0.2,
    Position = UDim2.fromScale(1, 1),
    ScaleType = Enum.ScaleType.Slice,
    Selectable = false,
    Size = UDim2.fromScale(1, 1),
    SliceCenter = Rect.new(7, 7, 7, 7),
    Visible = false,
    ZIndex = 2,
}
v12 = Children
v13 = {}
v14 = scope:New("ScrollingFrame")
v15 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    CanvasSize = UDim2.new(),
    ClipsDescendants = false,
    Position = UDim2.fromScale(0.5, 0.5),
    ScrollBarImageColor3 = Color3.fromRGB(16, 16, 16),
    ScrollBarThickness = 0,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    Selectable = false,
    Size = UDim2.new(1, -5, 1, -5),
}
v16 = Children
v17 = {}
v18 = scope:New("TextButton")
v19 = {
    Name = "Exit",
    Active = false,
    BackgroundTransparency = 1,
    LayoutOrder = 1000,
    Size = UDim2.fromOffset(100, 100),
    Visible = false,
}
v20 = Children
v21 = {}
v22 = scope:New("ImageLabel")
v23 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    Image = "rbxassetid://2851926732",
    ImageColor3 = Color3.fromRGB(255, 73, 73),
    LayoutOrder = -1,
    Position = UDim2.fromScale(0.5, 0.5),
    ScaleType = Enum.ScaleType.Slice,
    Selectable = true,
    Size = UDim2.new(1, -10, 1, -10),
    SliceCenter = Rect.new(12, 12, 12, 12),
}
v24 = Children
v25 = {}
v26 = scope:New("ImageLabel")({
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
v27 = scope:New("TextLabel")
v28 = {
    Name = "Label",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.9, 0.8),
    Text = "EXIT",
    TextColor3 = Color3.fromRGB(255, 73, 73),
    TextScaled = true,
}
v29 = Children
v28[v29] = {scope:New("UITextSizeConstraint")({Name = "UITextSizeConstraint", MaxTextSize = 20})}
v25[1] = v26
v25[2] = v27(v28)
v23[v24] = v25
v22 = v22(v23)
v23 = scope:New("UISizeConstraint")
v24 = {Name = "UISizeConstraint", MaxSize = Vector2.new(300, 0)}
v21[1] = v22
v21[2] = v23(v24)
v19[v20] = v21
v18 = v18(v19)
v19 = scope:New("TextButton")
v20 = {
    Name = "Button",
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(0.5, 0.14),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    Visible = false,
}
v21 = Children
v22 = {}
v23 = scope:New("Frame")
v24 = {
    Name = "Frame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(1, 1, 1),
    BackgroundTransparency = 0.95,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(1, 0, 0.8, -6),
}
v25 = Children
v26 = {}
v27 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.2, 0)})
v28 = scope:New("UIStroke")({Name = "UIStroke", Thickness = 3, Color = Color3.fromRGB(255, 184, 84)})
v29 = scope:New("TextLabel")
v30 = {
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "AUTOMATIC",
    TextScaled = true,
    AnchorPoint = Vector2.new(0.5, 0.5),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.9, 0.8),
    TextColor3 = Color3.fromRGB(255, 184, 84),
}
v26[1] = v27
v26[2] = v28
v26[3] = v29(v30)
v24[v25] = v26
v22[1] = v23(v24)
v20[v21] = v22
v19 = v19(v20)
v20 = scope:New("UIListLayout")
v21 = {
    Name = "UIListLayout",
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Center,
}
v17[1] = v18
v17[2] = v19
v17[3] = v20(v21)
v15[v16] = v17
v14 = v14(v15)
v15 = scope:New("TextButton")
v16 = {
    Name = "Exit",
    AnchorPoint = Vector2.new(1, 0),
    BackgroundColor3 = Color3.fromRGB(50, 17, 17),
    BackgroundTransparency = 0.5,
    LayoutOrder = 1000,
    Position = UDim2.fromScale(0.98, 0.02),
    Size = UDim2.fromScale(0.1, 0.1),
    SizeConstraint = Enum.SizeConstraint.RelativeXX,
    Text = "X",
    TextColor3 = Color3.fromRGB(255, 73, 73),
    TextScaled = true,
    TextTransparency = 1,
}
v17 = Children
v18 = {}
v19 = scope:New("UIStroke")({
    Name = "UIStroke",
    Thickness = 3,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Color = Color3.fromRGB(255, 73, 73),
})
v20 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.2, 0)})
v21 = scope:New("TextLabel")
v22 = {
    Name = "Label",
    BackgroundTransparency = 1,
    Text = "X",
    TextScaled = true,
    AnchorPoint = Vector2.new(0.5, 0.5),
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Position = UDim2.fromScale(0.525, 0.5),
    Size = UDim2.fromScale(0.85, 0.8),
    TextColor3 = Color3.fromRGB(255, 73, 73),
}
v18[1] = v19
v18[2] = v20
v18[3] = v21(v22)
v16[v17] = v18
v13[1] = v14
v13[2] = v15(v16)
v11[v12] = v13
v4[1] = v5
v4[2] = v6
v4[3] = v7
v4[4] = v8
v4[5] = v9
v4[6] = v10(v11)
v2[v3] = v4
v1(v2)