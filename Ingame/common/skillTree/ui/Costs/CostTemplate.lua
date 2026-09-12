local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Children = (require(Packages.Fusion)).Children
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)

local function commaFormat(p1) -- Line: 18
    local v1 = math.floor(p1)
    local v2 = tostring(v1)
    v1 = #v2
    if v1 <= 3 then
        return v2
    end
    local v3 = ""
    local v4 = v1
    for i = 1, v4 do
        if 1 < i and (v1 - i + 1) % 3 == 0 then
            v3 = v3 .. ","
        end
        v3 = v3 .. v2:sub(i, i)
    end
    return v3
end

local u17 = {}
local v1 = {label = "SP", useImage = false, enabled = true, color = Theme.Menu.AccentCyan}
u17.SP = v1
v1 = {label = "Z$", useImage = false, enabled = true, color = Theme.Colors.ZBucksTitle}
u17.ZBucks = v1
v1 = {label = "GM", useImage = false, enabled = false, color = Color3.fromRGB(255, 80, 80)}
u17.Gems = v1
v1 = {
    label = "",
    useImage = true,
    image = "rbxassetid://3187426822",
    enabled = true,
    color = Color3.fromRGB(255, 255, 255),
}
u17.ClassLevel = v1
return function(p1) -- Line: 73 -- upvalues: u17 (val), commaFormat (val), Children (val), Theme (val)
    local scope = p1.scope
    local u5 = scope:Computed(function(p1_2) -- Line: 77 -- upvalues: p1 (val), u17 (upval)
        local v1 = p1
        local CostType = v1.CostType
        local v2 = p1_2(CostType)
        local SP = u17[v2]
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
    local v6 = scope:Computed(function(p1_2) -- Line: 102 -- upvalues: commaFormat (upval), p1 (val)
        return (commaFormat(p1_2(p1.Amount)))
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
    local v10 = Children
    local v11 = {}
    local v12 = scope:New("UIListLayout")({
        Name = "UIListLayout",
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    })
    local v13 = scope:New("TextLabel")
    local v14 = {
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
    local v15 = Children
    v14[v15] = {scope:New("UIStroke")({Name = "UIStroke", StrokeSizingMode = "ScaledSize", Thickness = 0.06})}
    v13 = v13(v14)
    v14 = scope:New("Frame")
    v15 = {
        Name = "TypeFrame",
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 2,
        Size = UDim2.fromScale(0.8, 0.8),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
    }
    local v16 = Children
    local v17 = {}
    local v18 = scope:New("TextLabel")
    local v19 = {
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
    local v20 = Children
    v19[v20] = {scope:New("UIStroke")({Name = "UIStroke", StrokeSizingMode = "ScaledSize", Thickness = 0.06})}
    v18 = v18(v19)
    v19 = scope:New("ImageLabel")
    v20 = {
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
    v17[1] = v18
    v17[2] = v19(v20)
    v15[v16] = v17
    v11[1] = v12
    v11[2] = v13
    v11[3] = v14(v15)
    v9[v10] = v11
    return v8(v9)
end