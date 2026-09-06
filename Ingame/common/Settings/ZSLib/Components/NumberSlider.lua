local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
local SliderModule = require(script.Parent.Parent.SliderModule)
local u20 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p1) -- Line: 26 -- upvalues: Children (val), u20 (val), SliderModule (val)
    local Visible
    local scope = p1.scope
    local v1 = p1.Description ~= nil
    local v2 = scope:New("ImageLabel")
    v2 = v2({
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
    local v3 = scope:New("TextButton")
    v3 = v3({
        Name = "Button",
        BackgroundTransparency = 1,
        Text = "",
        TextSize = 14,
        TextTransparency = 1,
        ZIndex = 50,
        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
        Size = UDim2.fromScale(1, 1),
        TextColor3 = Color3.new(),
    })
    local v4 = scope:New("ImageLabel")
    local v5 = {
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
    v5[Children] = {v3}
    v4 = v4(v5)
    v5 = scope:New("Frame")
    local v6 = {
        Name = "Back",
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromScale(1, 0.75),
    }
    local v7 = {}
    local v8 = scope:New("UICorner")
    v7[1] = v8({CornerRadius = UDim.new(1, 0)})
    v6[Children] = v7
    v5 = v5(v6)
    v6 = scope:New("ImageLabel")
    local v9 = {
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
    v9[Children] = {v2, v4, v5}
    v6 = v6(v9)
    v9 = scope:New("ImageLabel")
    v7 = {
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
    v7[Children] = {v6}
    v9 = v9(v7)
    v7 = scope:New("TextBox")
    local u222 = v7({
        Name = "Label",
        BackgroundTransparency = 1,
        Text = "1",
        TextScaled = true,
        AnchorPoint = Vector2.new(0.5, 0.5),
        FontFace = u20,
        PlaceholderColor3 = Color3.new(1, 1, 1),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 0.7),
        TextColor3 = Color3.new(1, 1, 1),
    })
    v8 = scope:New("ImageLabel")
    local v10 = {
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
    local v11 = {}
    local v12 = scope:New("UICorner")
    local v13 = {CornerRadius = UDim.new(0.2, 0)}
    v11[1] = u222
    v11[2] = v12(v13)
    v10[Children] = v11
    v8 = v8(v10)
    v10 = scope:New("Frame")
    local v14 = {Name = "NumberSlider", BackgroundTransparency = 1, LayoutOrder = p1.LayoutOrder or 1}
    if not v1 then
        v11 = UDim2.fromScale(1, 0.11)
    else
        v11 = UDim2.fromScale(1, 0.14)
    end
    v14.Size = v11
    v14.SizeConstraint = Enum.SizeConstraint.RelativeXX
    if p1.Visible == nil then
        Visible = true
    else
        Visible = p1.Visible
    end
    v14.Visible = Visible
    local v15 = {}
    v12 = scope:New("Frame")
    v13 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.85),
    }
    local v16 = {}
    local v17 = scope:New("UICorner")
    v17 = v17({})
    local v18 = scope:New("TextLabel")
    local v19 = {
        Name = "Label",
        BackgroundTransparency = 1,
        TextScaled = true,
        FontFace = u20,
        Position = UDim2.fromScale(0.01, 0.04),
        Size = UDim2.fromScale(0.82, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        Text = p1.Text,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
    }
    v18 = v18(v19)
    if not v1 then
        v19 = nil
    else
        v19 = scope:New("TextLabel")
        v19 = v19({
            Name = "DescriptionLabel",
            BackgroundTransparency = 1,
            TextScaled = true,
            TextTransparency = 0.5,
            AnchorPoint = Vector2.new(0, 1),
            FontFace = u20,
            Position = UDim2.fromScale(0.01, 0.75),
            Size = UDim2.fromScale(0.82, 0.05),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            Text = p1.Description,
            TextColor3 = Color3.new(1, 1, 1),
            TextXAlignment = Enum.TextXAlignment.Left,
        })
    end
    v16[1] = v17
    v16[2] = v9
    v16[3] = v8
    v16[4] = v18
    v16[5] = v19
    v13[Children] = v16
    v15[1] = v12(v13)
    v14[Children] = v15
    v10 = v10(v14)
    v14 = SliderModule.new(v6, v4, v3, v2, {min = p1.Min, max = p1.Max, snapFactor = p1.SnapFactor}, {TextBox = u222})
    v11 = v14:Activate()
    v11(p1.Default)
    local PropertyChangedSignal = u222:GetPropertyChangedSignal("Text")
    PropertyChangedSignal:Connect(function() -- Line: 208 -- upvalues: u222 (val), p1 (val)
        if not (u222:IsFocused()) and p1.OnChanged then
            p1.OnChanged((tonumber(u222.Text)))
        end
    end)
    v14.InteractionEnded.Event:Connect(function(a1) -- Line: 216 -- upvalues: p1 (val)
        if p1.OnChanged then
            p1.OnChanged(a1, true)
        end
    end)
    return v10, v11
end