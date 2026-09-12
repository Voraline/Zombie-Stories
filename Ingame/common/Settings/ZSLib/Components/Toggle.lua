local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local u16 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p1) -- Line: 24 -- upvalues: Children (val), OnEvent (val), peek (val), u16 (val)
    local Visible, v1
    local scope = p1.scope
    local Default = p1.Default
    local u5 = scope:Value(Default)
    local v2 = scope:Computed(function(p1) -- Line: 28 -- upvalues: u5 (val)
        if p1(u5) then
            return (UDim2.new(1, 0, 0.5, 0))
        end
        return (UDim2.new(0.4, 0, 0.5, 0))
    end)
    local v3 = scope:Spring(v2, 25, 1)
    local v4 = scope:Computed(function(p1) -- Line: 32 -- upvalues: u5 (val)
        if p1(u5) then
            return (UDim2.new(0.75, 0, 1, 0))
        end
        return (UDim2.new(0, 0, 1, 0))
    end)
    local v5 = scope:Spring(v4, 25, 1)
    v2 = p1.Description ~= nil
    v4 = scope:New("Frame")
    local v6 = {Name = "Toggle", BackgroundTransparency = 1, LayoutOrder = p1.LayoutOrder or 1}
    if not v2 then
        v1 = UDim2.fromScale(1, 0.08)
    else
        v1 = UDim2.fromScale(1, 0.11)
    end
    v6.Size = v1
    v6.SizeConstraint = Enum.SizeConstraint.RelativeXX
    if p1.Visible == nil then
        Visible = true
    else
        Visible = p1.Visible
    end
    v6.Visible = Visible
    v1 = Children
    local v7 = {}
    local v8 = scope:New("Frame")
    local v9 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.85),
    }
    local v10 = Children
    local v11 = {}
    local v12 = scope:New("UICorner")({})
    local v13 = scope:New("ImageButton")
    local v14 = {
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
    local MouseButton1Click = OnEvent("MouseButton1Click")

    v14[MouseButton1Click] = function() -- Line: 70 -- upvalues: p1 (val), peek (upval), u5 (val)
        if p1.ButtonSound then
            p1.ButtonSound:Play()
        end
        local v1 = not peek(u5)
        u5:set(v1)
        if p1.OnChanged then
            p1.OnChanged(v1)
        end
    end

    local v15 = Children
    local v16 = {}
    local v17 = scope:New("Frame")
    local v18 = {
        Name = "Back",
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 0.95,
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromScale(1, 1),
    }
    local v19 = Children
    v18[v19] = {scope:New("UICorner")({CornerRadius = UDim.new(0.17, 0)})}
    v17 = v17(v18)
    v18 = scope:New("Frame")
    v19 = {
        Name = "Fill",
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Position = UDim2.fromScale(0, 0.5),
        Size = v5,
        ZIndex = 2,
    }
    local v20 = Children
    local v21 = {}
    local v22 = scope:New("Frame")
    local v23 = {Name = "Frame", BackgroundColor3 = Color3.fromRGB(255, 184, 84), Size = UDim2.fromScale(100, 1)}
    local v24 = Children
    v23[v24] = {scope:New("UICorner")({CornerRadius = UDim.new(0.17, 0)})}
    v21[1] = v22(v23)
    v19[v20] = v21
    v18 = v18(v19)
    v19 = scope:New("Frame")
    v20 = {
        Name = "Slide",
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Color3.new(1, 1, 1),
        Position = v3,
        Size = UDim2.fromScale(0.4, 1),
        ZIndex = 3,
    }
    v21 = Children
    v20[v21] = {scope:New("UICorner")({CornerRadius = UDim.new(0.2, 0)})}
    v16[1] = v17
    v16[2] = v18
    v16[3] = v19(v20)
    v14[v15] = v16
    v13 = v13(v14)
    v14 = scope:New("TextLabel")
    v15 = {
        Name = "Label",
        BackgroundTransparency = 1,
        TextScaled = true,
        FontFace = u16,
        Position = UDim2.fromScale(0.01, 0),
        Size = UDim2.fromScale(0.8, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        Text = p1.Text,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
    }
    v14 = v14(v15)
    if not v2 then
        v15 = nil
    else
        v15 = scope:New("TextLabel")({
            Name = "DescriptionLabel",
            BackgroundTransparency = 1,
            TextScaled = true,
            TextTransparency = 0.5,
            AnchorPoint = Vector2.new(0, 1),
            FontFace = u16,
            Position = UDim2.fromScale(0.01, 0.96),
            Size = UDim2.fromScale(0.8, 0.05),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            Text = p1.Description,
            TextColor3 = Color3.new(1, 1, 1),
            TextXAlignment = Enum.TextXAlignment.Left,
        })
    end
    v11[1] = v12
    v11[2] = v13
    v11[3] = v14
    v11[4] = v15
    v9[v10] = v11
    v7[1] = v8(v9)
    v6[v1] = v7
    v4 = v4(v6)
    return v4, function(p1) -- Line: 160 -- upvalues: u5 (val)
        u5:set(p1)
    end
end