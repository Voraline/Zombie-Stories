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
    v1 = Children
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
    local v8 = Children
    local v9 = {}
    local v10 = scope:New("TextLabel")({
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
    local v11 = scope:New("UICorner")({})
    local v12 = scope:New("Frame")
    local v13 = {Name = "Toggle", AnchorPoint = Vector2.new(1, 0.5)}
    local FillColor = p1.FillColor
    if not FillColor then
        FillColor = Color3.fromRGB(49, 49, 49)
    end
    v13.BackgroundColor3 = FillColor
    v13.BackgroundTransparency = 0.95
    v13.Position = UDim2.new(1, -3, 0.5, 0)
    v13.Size = UDim2.fromScale(0.15, 1)
    local v14 = Children
    local v15 = {}
    local v16 = scope:New("UICorner")({CornerRadius = UDim.new(0.18, 0)})
    local v17 = scope:New("TextButton")
    local v18 = {Name = "Button", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), TextTransparency = 1}
    local MouseButton1Click = OnEvent("MouseButton1Click")

    v18[MouseButton1Click] = function() -- Line: 80 -- upvalues: p1 (val)
        if p1.ButtonSound then
            p1.ButtonSound:Play()
        end
        if p1.OnClick then
            p1.OnClick()
        end
    end

    local v19 = Children
    local v20 = {}
    local v21 = scope:New("TextLabel")
    local v22 = {
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
    v22.TextColor3 = TextColor
    v20[1] = v21(v22)
    v18[v19] = v20
    v17 = v17(v18)
    v18 = scope:New("UIStroke")
    v19 = {Thickness = 3}
    local OutlineColor = p1.OutlineColor
    if not OutlineColor then
        OutlineColor = Color3.fromRGB(255, 184, 84)
    end
    v19.Color = OutlineColor
    v15[1] = v16
    v15[2] = v17
    v15[3] = v18(v19)
    v13[v14] = v15
    v12 = v12(v13)
    if not v2 then
        v13 = nil
    else
        v13 = scope:New("TextLabel")({
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
    v9[1] = v10
    v9[2] = v11
    v9[3] = v12
    v9[4] = v13
    v7[v8] = v9
    v5[1] = v6(v7)
    v4[v1] = v5
    return (v3(v4))
end