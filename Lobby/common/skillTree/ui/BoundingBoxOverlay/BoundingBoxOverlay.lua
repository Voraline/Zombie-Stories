local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local Children = Fusion.Children
return function(p1) -- Line: 28 -- upvalues: Children (val), Theme (val)
    local ShowLockIcon
    local scope = p1.scope
    if p1.ShowLockIcon ~= nil then
        ShowLockIcon = p1.ShowLockIcon
    else
        ShowLockIcon = true
    end
    local TextMaxSize = p1.TextMaxSize
    if not TextMaxSize then
        TextMaxSize = Vector2.new(2000, 514)
    end
    local u25 = scope:Computed(function(a1) -- Line: 38 -- upvalues: p1 (val)
        local Locked = p1.Locked
        if Locked == nil then
            return true
        end
        return a1(Locked)
    end)
    local v1 = scope:Computed(function(a1) -- Line: 46 -- upvalues: p1 (val)
        local RequiresText = p1.RequiresText
        if RequiresText == nil then
            return ""
        end
        return a1(RequiresText)
    end)
    local v2 = scope:Computed(function(a1) -- Line: 55 -- upvalues: p1 (val), u25 (val)
        if p1.AlwaysOnTop ~= nil then
            return a1(p1.AlwaysOnTop)
        end
        return a1(u25)
    end)
    local v3 = scope:Computed(function(p1) -- Line: 63 -- upvalues: ShowLockIcon (val), u25 (val)
        if not ShowLockIcon then
            return false
        end
        return p1(u25)
    end)
    local v4 = scope:Computed(function(p1) -- Line: 74 -- upvalues: u25 (val)
        if p1(u25) then
            return 0.3
        end
        return 0.7
    end)
    local v5 = scope:New("SurfaceGui")
    local v6 = {
        Name = "LockOverlay",
        Face = Enum.NormalId.Top,
        ResetOnSpawn = false,
        SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        AlwaysOnTop = v2,
        ZOffset = p1.ZOffset or 0,
        Adornee = p1.Adornee,
    }
    local v7 = {}
    local v8 = scope:New("Frame")
    local v9 = {
        Name = "Frame",
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = v4,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
    }
    local v10 = {}
    local v11 = scope:New("UICorner")
    v11 = v11({Name = "UICorner", CornerRadius = UDim.new(0, p1.CornerRadius or 128)})
    local v12 = scope:New("UIStroke")
    v12 = v12({Name = "UIStroke", Thickness = p1.StrokeThickness or 50})
    local v13 = scope:New("UIPadding")
    v13 = v13({Name = "UIPadding", PaddingLeft = UDim.new(0, 15), PaddingRight = UDim.new(0, 15)})
    local v14 = scope:New("UIListLayout")
    v14 = v14({Name = "UIListLayout", HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center})
    local v15 = scope:New("ImageLabel")
    local v16 = {
        Name = "LockIcon",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Image = p1.LockImage or "rbxassetid://6031082533",
        LayoutOrder = 1,
        ScaleType = Enum.ScaleType.Fit,
        Size = UDim2.fromScale(1, 0.5),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        Visible = v3,
    }
    local v17 = {}
    local v18 = scope:New("UISizeConstraint")
    v17[1] = v18({Name = "UISizeConstraint", MaxSize = Vector2.new(1500, 1280)})
    v16[Children] = v17
    v15 = v15(v16)
    v16 = scope:New("TextLabel")
    local v19 = {
        Name = "Requires",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Font = Theme.Menu.Fonts.Header,
        LayoutOrder = 2,
        Position = UDim2.fromScale(0.5, 0.7),
        RichText = true,
        Size = UDim2.fromScale(1, 0.2),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        Text = v1,
        TextColor3 = Theme.Menu.Text,
        TextScaled = true,
        TextSize = 14,
        TextWrapped = true,
        Visible = u25,
        ZIndex = 2,
    }
    v18 = {}
    local v20 = scope:New("UIStroke")
    v20 = v20({Name = "UIStroke", Thickness = 0.06})
    local v21 = scope:New("UISizeConstraint")
    v18[1] = v20
    v18[2] = v21({Name = "UISizeConstraint", MaxSize = TextMaxSize})
    v19[Children] = v18
    v10[1] = v11
    v10[2] = v12
    v10[3] = v13
    v10[4] = v14
    v10[5] = v15
    v10[6] = v16(v19)
    v9[Children] = v10
    v7[1] = v8(v9)
    v6[Children] = v7
    return v5(v6)
end