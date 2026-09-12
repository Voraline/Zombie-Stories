local v1 = require("@game/ReplicatedStorage/common/Fusion")
local New = v1.New
local Children = v1.Children
local OnEvent = v1.OnEvent
return function(p1) -- Line: 4 -- upvalues: New (val), Children (val), OnEvent (val)
    local Frame = New("Frame")
    local v1 = {
        Name = "DamageGraph",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Visible = p1.isOpen,
    }
    local v2 = Children
    local v3 = {}
    local TextButton = New("TextButton")
    local v4 = {
        Name = "Exit",
        Text = "",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(40, 49, 63),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.fromScale(0.935, -0.1),
        Size = UDim2.fromScale(0.3, 0.15),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        ZIndex = 5,
    }
    local MouseButton1Click = OnEvent("MouseButton1Click")
    v4[MouseButton1Click] = p1.onClose
    local v5 = Children
    local v6 = {}
    local Frame_2 = New("Frame")
    local v7 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(63, 22, 22),
        BackgroundTransparency = 0.2,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, 0, 1, -5),
        ZIndex = 3,
    }
    local v8 = Children
    local v9 = {}
    local v10 = New("Frame")({
        Name = "Point",
        BackgroundTransparency = 1,
        ZIndex = 4,
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = UDim2.fromScale(1, 0.5),
    })
    local v11 = New("TextLabel")({
        Name = "BottomLabel",
        Text = "CLOSE",
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
    local v12 = {Name = "UIGradient", Rotation = 90}
    local new = ColorSequence.new
    local v13 = {}
    local v14 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255))
    local v15 = ColorSequenceKeypoint.new(0.536, Color3.fromRGB(255, 255, 255))
    v13[1] = v14
    v13[2] = v15
    v13[3] = ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    v12.Color = new(v13)
    local v16 = UIGradient(v12)
    local UICorner = New("UICorner")
    v9[1] = v10
    v9[2] = v11
    v9[3] = v16
    v9[4] = UICorner({Name = "UICorner"})
    v7[v8] = v9
    v6[1] = Frame_2(v7)
    v4[v5] = v6
    v3[1] = TextButton(v4)
    v1[v2] = v3
    return Frame(v1)
end