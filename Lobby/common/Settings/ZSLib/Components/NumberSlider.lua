local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = (require(ReplicatedStorage.Packages.Fusion)).Children
local SliderModule = require(script.Parent.Parent.SliderModule)
local u20 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p1) -- Line: 26 -- upvalues: Children (val), u20 (val), SliderModule (val)
    local Visible
    local scope = p1.scope
    local v1 = p1.Description ~= nil
    local v2 = scope:New("ImageLabel")({
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
    local v3 = scope:New("TextButton")({
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
    local v6 = Children
    v5[v6] = {v3}
    v4 = v4(v5)
    v5 = scope:New("Frame")
    v6 = {
        Name = "Back",
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromScale(1, 0.75),
    }
    local v7 = Children
    v6[v7] = {scope:New("UICorner")({CornerRadius = UDim.new(1, 0)})}
    v5 = v5(v6)
    v6 = scope:New("ImageLabel")
    v7 = {
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
    local v8 = Children
    v7[v8] = {v2, v4, v5}
    v6 = v6(v7)
    v7 = scope:New("ImageLabel")
    v8 = {
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
    local v9 = Children
    v8[v9] = {v6}
    v7 = v7(v8)
    local u222 = scope:New("TextBox")({
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
    v9 = scope:New("ImageLabel")
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
    local v11 = Children
    local v12 = {}
    local v13 = scope:New("UICorner")
    local v14 = {CornerRadius = UDim.new(0.2, 0)}
    v12[1] = u222
    v12[2] = v13(v14)
    v10[v11] = v12
    v9 = v9(v10)
    v10 = scope:New("Frame")
    v11 = {Name = "NumberSlider", BackgroundTransparency = 1, LayoutOrder = p1.LayoutOrder or 1}
    if not v1 then
        v12 = UDim2.fromScale(1, 0.11)
    else
        v12 = UDim2.fromScale(1, 0.14)
    end
    v11.Size = v12
    v11.SizeConstraint = Enum.SizeConstraint.RelativeXX
    if p1.Visible == nil then
        Visible = true
    else
        Visible = p1.Visible
    end
    v11.Visible = Visible
    v12 = Children
    local v15 = {}
    v13 = scope:New("Frame")
    v14 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.85),
    }
    local v16 = Children
    local v17 = {}
    local v18 = scope:New("UICorner")({})
    local v19 = scope:New("TextLabel")
    local v20 = {
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
    v19 = v19(v20)
    if not v1 then
        v20 = nil
    else
        v20 = scope:New("TextLabel")({
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
    v17[1] = v18
    v17[2] = v7
    v17[3] = v9
    v17[4] = v19
    v17[5] = v20
    v14[v16] = v17
    v15[1] = v13(v14)
    v11[v12] = v15
    v10 = v10(v11)
    v11 = SliderModule
    v11 = v11.new(v6, v4, v3, v2, {min = p1.Min, max = p1.Max, snapFactor = p1.SnapFactor}, {TextBox = u222})
    v12 = v11:Activate()
    v12(p1.Default)
    ;(u222:GetPropertyChangedSignal("Text")):Connect(function() -- Line: 208 -- upvalues: u222 (val), p1 (val)
        if not u222:IsFocused() and p1.OnChanged then
            local v1 = p1
            local OnChanged = v1.OnChanged
            local v2 = u222
            local Text = v2.Text
            OnChanged((tonumber(Text)))
        end
    end)
    v11.InteractionEnded.Event:Connect(function(p1_2) -- Line: 216 -- upvalues: p1 (val)
        if p1.OnChanged then
            p1.OnChanged(p1_2, true)
        end
    end)
    return v10, v12
end