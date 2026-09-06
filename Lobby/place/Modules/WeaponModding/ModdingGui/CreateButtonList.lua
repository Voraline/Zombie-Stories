local v1 = require("@game/ReplicatedStorage/common/Fusion")
local New = v1.New
local Children = v1.Children
local OnEvent = v1.OnEvent
return function(p1) -- Line: 4 -- upvalues: New (val), Children (val), OnEvent (val)
    local Frame = New("Frame")
    local v1 = {
        Name = "Buttons",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0, -0.4),
        Size = UDim2.fromScale(1, 0.2),
    }
    local v2 = {}
    local UIGridLayout = New("UIGridLayout")
    local v3 = UIGridLayout({Name = "UIGridLayout", CellPadding = UDim2.new(), CellSize = UDim2.fromScale(0.3, 1), SortOrder = Enum.SortOrder.LayoutOrder})
    local TextButton = New("TextButton")
    local v4 = {
        Name = "Falloff",
        Text = "",
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Color3.fromRGB(40, 49, 63),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.fromScale(0.01, 0.99),
        Size = UDim2.fromScale(0.17, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        Visible = p1.ButtonVisibility.Falloff,
        ZIndex = 5,
    }
    local MouseButton1Click = OnEvent("MouseButton1Click")
    v4[MouseButton1Click] = p1.onFalloff
    local v5 = {}
    local Frame_2 = New("Frame")
    local v6 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(63, 22, 22),
        BackgroundTransparency = 0.2,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, 0, 1, -5),
    }
    local v7 = {}
    local Frame_3 = New("Frame")
    local v8 = Frame_3({
        Name = "Point",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = UDim2.fromScale(1, 0.5),
    })
    local TextLabel = New("TextLabel")
    local v9 = TextLabel({
        Name = "BottomLabel",
        Text = "FALLOFF",
        TextScaled = true,
        TextSize = 14,
        TextWrapped = true,
        BackgroundTransparency = 1,
        ZIndex = 6,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
        TextColor3 = Color3.fromRGB(255, 169, 169),
        TextXAlignment = Enum.TextXAlignment.Left,
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = UDim2.fromScale(0.08, 0.5),
        Size = UDim2.fromScale(0.88, 0.9),
    })
    local UIGradient = New("UIGradient")
    local v10 = {Name = "UIGradient", Rotation = 90}
    local v11 = {}
    local v12 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255))
    local v13 = ColorSequenceKeypoint.new(0.536, Color3.fromRGB(255, 255, 255))
    v11[1] = v12
    v11[2] = v13
    v11[3] = ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    v10.Color = ColorSequence.new(v11)
    local v14 = UIGradient(v10)
    local UICorner = New("UICorner")
    v7[1] = v8
    v7[2] = v9
    v7[3] = v14
    v7[4] = UICorner({Name = "UICorner"})
    v6[Children] = v7
    v5[1] = Frame_2(v6)
    v4[Children] = v5
    v2[1] = v3
    v2[2] = TextButton(v4)
    v1[Children] = v2
    return Frame(v1)
end