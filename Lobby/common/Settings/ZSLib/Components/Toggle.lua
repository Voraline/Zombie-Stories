local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local u16 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p1) -- Line: 24 -- upvalues: Children (val), OnEvent (val), peek (val), u16 (val)
    local Visible, v1
    local scope = p1.scope
    local u5 = scope:Value(p1.Default)
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
    local v10 = {}
    local v11 = scope:New("UICorner")
    v11 = v11({})
    local v12 = scope:New("ImageButton")
    local v13 = {
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
    v13[MouseButton1Click] = function() -- Line: 70 -- upvalues: p1 (val), peek (upval), u5 (val)
        if p1.ButtonSound then
            p1.ButtonSound:Play()
        end
        local v1 = not peek(u5)
        u5:set(v1)
        if p1.OnChanged then
            p1.OnChanged(v1)
        end
    end
    local v14 = {}
    local v15 = scope:New("Frame")
    local v16 = {
        Name = "Back",
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 0.95,
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromScale(1, 1),
    }
    local v17 = {}
    local v18 = scope:New("UICorner")
    v17[1] = v18({CornerRadius = UDim.new(0.17, 0)})
    v16[Children] = v17
    v15 = v15(v16)
    v16 = scope:New("Frame")
    local v19 = {
        Name = "Fill",
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Position = UDim2.fromScale(0, 0.5),
        Size = v5,
        ZIndex = 2,
    }
    v18 = {}
    local v20 = scope:New("Frame")
    local v21 = {Name = "Frame", BackgroundColor3 = Color3.fromRGB(255, 184, 84), Size = UDim2.fromScale(100, 1)}
    local v22 = {}
    local v23 = scope:New("UICorner")
    v22[1] = v23({CornerRadius = UDim.new(0.17, 0)})
    v21[Children] = v22
    v18[1] = v20(v21)
    v19[Children] = v18
    v16 = v16(v19)
    v19 = scope:New("Frame")
    v17 = {
        Name = "Slide",
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Color3.new(1, 1, 1),
        Position = v3,
        Size = UDim2.fromScale(0.4, 1),
        ZIndex = 3,
    }
    v20 = {}
    v21 = scope:New("UICorner")
    v20[1] = v21({CornerRadius = UDim.new(0.2, 0)})
    v17[Children] = v20
    v14[1] = v15
    v14[2] = v16
    v14[3] = v19(v17)
    v13[Children] = v14
    v12 = v12(v13)
    v13 = scope:New("TextLabel")
    local v24 = {
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
    v13 = v13(v24)
    if not v2 then
        v24 = nil
    else
        v24 = scope:New("TextLabel")
        v24 = v24({
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
    v10[1] = v11
    v10[2] = v12
    v10[3] = v13
    v10[4] = v24
    v9[Children] = v10
    v7[1] = v8(v9)
    v6[Children] = v7
    return v4(v6), function(p1) -- Line: 160 -- upvalues: u5 (val)
        u5:set(p1)
    end
end