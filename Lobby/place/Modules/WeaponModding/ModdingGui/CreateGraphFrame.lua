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
    local v2 = {}
    local TextButton = New("TextButton")
    local v3 = {
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
    v3[MouseButton1Click] = p1.onClose
    local v4 = {}
    local Frame_2 = New("Frame")
    local v5 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(63, 22, 22),
        BackgroundTransparency = 0.2,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, 0, 1, -5),
        ZIndex = 3,
    }
    local v6 = {}
    local Frame_3 = New("Frame")
    local v7 = Frame_3({
        Name = "Point",
        BackgroundTransparency = 1,
        ZIndex = 4,
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = UDim2.fromScale(1, 0.5),
    })
    local TextLabel = New("TextLabel")
    local v8 = TextLabel({
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
    local v9 = {Name = "UIGradient", Rotation = 90}
    local v10 = {}
    local v11 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255))
    local v12 = ColorSequenceKeypoint.new(0.536, Color3.fromRGB(255, 255, 255))
    v10[1] = v11
    v10[2] = v12
    v10[3] = ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    v9.Color = ColorSequence.new(v10)
    local v13 = UIGradient(v9)
    local UICorner = New("UICorner")
    v6[1] = v7
    v6[2] = v8
    v6[3] = v13
    v6[4] = UICorner({Name = "UICorner"})
    v5[Children] = v6
    v4[1] = Frame_2(v5)
    v3[Children] = v4
    v2[1] = TextButton(v3)
    v1[Children] = v2
    return Frame(v1)
end