local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local u15 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p1) -- Line: 26 -- upvalues: Children (val), u15 (val), OnEvent (val)
    local Visible, v1
    local scope = p1.scope
    local v2 = p1.Description ~= nil
    local v3 = scope:New("Frame")
    local v4 = {Name = "Button", BackgroundTransparency = 1, LayoutOrder = p1.LayoutOrder or 1}
    if not v2 then
        v1 = UDim2.fromScale(1, 0.08)
    else
        v1 = UDim2.fromScale(1, 0.11)
    end
    v4.Size = v1
    v4.SizeConstraint = Enum.SizeConstraint.RelativeXX
    if p1.Visible == nil then
        Visible = true
    else
        Visible = p1.Visible
    end
    v4.Visible = Visible
    local v5 = {}
    local v6 = scope:New("Frame")
    local v7 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.85),
    }
    local v8 = {}
    local v9 = scope:New("TextLabel")
    v9 = v9({
        Name = "Label",
        BackgroundTransparency = 1,
        TextScaled = true,
        FontFace = u15,
        Position = UDim2.fromScale(0.01, 0.04),
        Size = UDim2.fromScale(0.82, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        Text = p1.Text,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    local v10 = scope:New("UICorner")
    v10 = v10({})
    local v11 = scope:New("Frame")
    local v12 = {Name = "Toggle", AnchorPoint = Vector2.new(1, 0.5)}
    local FillColor = p1.FillColor
    if not FillColor then
        FillColor = Color3.fromRGB(49, 49, 49)
    end
    v12.BackgroundColor3 = FillColor
    v12.BackgroundTransparency = 0.95
    v12.Position = UDim2.new(1, -3, 0.5, 0)
    v12.Size = UDim2.fromScale(0.15, 1)
    local v13 = {}
    local v14 = scope:New("UICorner")
    v14 = v14({CornerRadius = UDim.new(0.18, 0)})
    local v15 = scope:New("TextButton")
    local v16 = {Name = "Button", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), TextTransparency = 1}
    local MouseButton1Click = OnEvent("MouseButton1Click")
    v16[MouseButton1Click] = function() -- Line: 80 -- upvalues: p1 (val)
        if p1.ButtonSound then
            p1.ButtonSound:Play()
        end
        if p1.OnClick then
            p1.OnClick()
        end
    end
    local v17 = {}
    local v18 = scope:New("TextLabel")
    local v19 = {
        Name = "Label",
        BackgroundTransparency = 1,
        TextScaled = true,
        AnchorPoint = Vector2.new(0.5, 0.5),
        FontFace = u15,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.9, 0.9),
        Text = p1.ButtonText,
    }
    local TextColor = p1.TextColor
    if not TextColor then
        TextColor = Color3.fromRGB(255, 184, 84)
    end
    v19.TextColor3 = TextColor
    v17[1] = v18(v19)
    v16[Children] = v17
    v15 = v15(v16)
    v16 = scope:New("UIStroke")
    local v20 = {Thickness = 3}
    local OutlineColor = p1.OutlineColor
    if not OutlineColor then
        OutlineColor = Color3.fromRGB(255, 184, 84)
    end
    v20.Color = OutlineColor
    v13[1] = v14
    v13[2] = v15
    v13[3] = v16(v20)
    v12[Children] = v13
    v11 = v11(v12)
    if not v2 then
        v12 = nil
    else
        v12 = scope:New("TextLabel")
        v12 = v12({
            Name = "DescriptionLabel",
            BackgroundTransparency = 1,
            TextScaled = true,
            TextTransparency = 0.5,
            AnchorPoint = Vector2.new(0, 1),
            FontFace = u15,
            Position = UDim2.fromScale(0.01, 0.96),
            Size = UDim2.fromScale(0.82, 0.05),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            Text = p1.Description,
            TextColor3 = Color3.new(1, 1, 1),
            TextXAlignment = Enum.TextXAlignment.Left,
        })
    end
    v8[1] = v9
    v8[2] = v10
    v8[3] = v11
    v8[4] = v12
    v7[Children] = v8
    v5[1] = v6(v7)
    v4[Children] = v5
    return (v3(v4))
end