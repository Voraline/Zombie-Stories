local v1 = require("@game/ReplicatedStorage/common/Fusion")
local New = v1.New
local Children = v1.Children
local OnEvent = v1.OnEvent
local Computed = v1.Computed
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
    local v2 = Children
    local v3 = {}
    local v4 = New("UIGridLayout")({
        Name = "UIGridLayout",
        CellPadding = UDim2.new(),
        CellSize = UDim2.fromScale(0.3, 1),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    local TextButton = New("TextButton")
    local v5 = {
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
    v5[MouseButton1Click] = p1.onFalloff
    local v6 = Children
    local v7 = {}
    local Frame_2 = New("Frame")
    local v8 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(63, 22, 22),
        BackgroundTransparency = 0.2,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, 0, 1, -5),
    }
    local v9 = Children
    local v10 = {}
    local v11 = New("Frame")({
        Name = "Point",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = UDim2.fromScale(1, 0.5),
    })
    local v12 = New("TextLabel")({
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
    local v13 = {Name = "UIGradient", Rotation = 90}
    local new = ColorSequence.new
    local v14 = {}
    local v15 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255))
    local v16 = ColorSequenceKeypoint.new(0.536, Color3.fromRGB(255, 255, 255))
    v14[1] = v15
    v14[2] = v16
    v14[3] = ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    v13.Color = new(v14)
    local v17 = UIGradient(v13)
    local UICorner = New("UICorner")
    v10[1] = v11
    v10[2] = v12
    v10[3] = v17
    v10[4] = UICorner({Name = "UICorner"})
    v8[v9] = v10
    v7[1] = Frame_2(v8)
    v5[v6] = v7
    v3[1] = v4
    v3[2] = TextButton(v5)
    v1[v2] = v3
    return Frame(v1)
end