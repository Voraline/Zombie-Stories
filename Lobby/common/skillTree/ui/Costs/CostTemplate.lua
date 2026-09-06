local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local function commaFormat(p1) -- Line: 18
    local v1 = tostring((math.floor(p1)))
    local v2 = #v1
    if v2 <= 3 then
        return v1
    end
    local v3 = ""
    local v4 = v2
    local v5 = 1
    for i = 1, v4, v5 do
        if 1 < i and (v2 - i + 1) % 3 == 0 then
            v3 = v3 .. ","
        end
        v3 = v3 .. v1:sub(i, i)
    end
    return v3
end
local u17 = {
    SP = {label = "SP", useImage = false, enabled = true, color = Theme.Menu.AccentCyan},
    ZBucks = {label = "Z$", useImage = false, enabled = true, color = Theme.Colors.ZBucksTitle},
    Gems = {label = "GM", useImage = false, enabled = false, color = Color3.fromRGB(255, 80, 80)},
    ClassLevel = {
        label = "",
        useImage = true,
        image = "rbxassetid://3187426822",
        enabled = true,
        color = Color3.fromRGB(255, 255, 255),
    },
}
return function(p1) -- Line: 73 -- upvalues: u17 (val), commaFormat (val), Children (val), Theme (val)
    local scope = p1.scope
    local u5 = scope:Computed(function(a1) -- Line: 77 -- upvalues: p1 (val), u17 (upval)
        local SP = u17[a1(p1.CostType)]
        if not SP then
            SP = u17.SP
        end
        return SP
    end)
    local v1 = scope:Computed(function(p1) -- Line: 82 -- upvalues: u5 (val)
        return not p1(u5).useImage
    end)
    local v2 = scope:Computed(function(p1) -- Line: 86 -- upvalues: u5 (val)
        return p1(u5).useImage
    end)
    local v3 = scope:Computed(function(p1) -- Line: 90 -- upvalues: u5 (val)
        return p1(u5).label
    end)
    local v4 = scope:Computed(function(p1) -- Line: 94 -- upvalues: u5 (val)
        return p1(u5).color
    end)
    local v5 = scope:Computed(function(p1) -- Line: 98 -- upvalues: u5 (val)
        return p1(u5).image or ""
    end)
    local v6 = scope:Computed(function(a1) -- Line: 102 -- upvalues: commaFormat (upval), p1 (val)
        return (commaFormat(a1(p1.Amount)))
    end)
    local v7 = scope:Computed(function(p1) -- Line: 106 -- upvalues: u5 (val)
        local v1 = p1(u5).enabled ~= false
        return v1
    end)
    local v8 = scope:New("Frame")
    local v9 = {
        Name = "CostTemplate",
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(0, 1),
        LayoutOrder = p1.LayoutOrder or 0,
        Visible = v7,
    }
    local v10 = {}
    local v11 = scope:New("UIListLayout")
    v11 = v11({
        Name = "UIListLayout",
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    })
    local v12 = scope:New("TextLabel")
    local v13 = {
        Name = "Cost",
        AnchorPoint = Vector2.new(0.5, 0.5),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Font = Theme.Menu.Fonts.Header,
        LayoutOrder = 1,
        Position = UDim2.fromScale(0.5, 0.5),
        RichText = true,
        Size = UDim2.fromScale(0, 0.5),
        Text = v6,
        TextColor3 = Theme.Menu.Text,
        TextScaled = true,
        ZIndex = 2,
    }
    local v14 = {}
    local v15 = scope:New("UIStroke")
    v14[1] = v15({Name = "UIStroke", StrokeSizingMode = "ScaledSize", Thickness = 0.06})
    v13[Children] = v14
    v12 = v12(v13)
    v13 = scope:New("Frame")
    local v16 = {
        Name = "TypeFrame",
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 2,
        Size = UDim2.fromScale(0.8, 0.8),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
    }
    v15 = {}
    local v17 = scope:New("TextLabel")
    local v18 = {
        Name = "Label",
        AnchorPoint = Vector2.new(0.5, 0.5),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Font = Theme.Menu.Fonts.Header,
        Position = UDim2.fromScale(0.5, 0.5),
        RichText = true,
        Size = UDim2.fromScale(0.8, 0.8),
        Text = v3,
        TextColor3 = v4,
        TextScaled = true,
        Visible = v1,
        ZIndex = 2,
    }
    local v19 = {}
    local v20 = scope:New("UIStroke")
    v19[1] = v20({Name = "UIStroke", StrokeSizingMode = "ScaledSize", Thickness = 0.06})
    v18[Children] = v19
    v17 = v17(v18)
    v18 = scope:New("ImageLabel")
    local v21 = {
        Name = "ImageLabel",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = v5,
        Position = UDim2.fromScale(0.5, 0.5),
        ScaleType = Enum.ScaleType.Fit,
        Size = UDim2.fromScale(0.8, 0.8),
        Visible = v2,
    }
    v15[1] = v17
    v15[2] = v18(v21)
    v16[Children] = v15
    v10[1] = v11
    v10[2] = v12
    v10[3] = v13(v16)
    v9[Children] = v10
    return v8(v9)
end