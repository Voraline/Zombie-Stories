local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local Children = Fusion.Children
return function(p1) -- Line: 28 -- upvalues: Children (val), Theme (val)
    local ShowLockIcon
    local scope = p1.scope
    local v1 = p1.CornerRadius or 128
    local v2 = p1.StrokeThickness or 50
    local v3 = p1.LockImage or "rbxassetid://6031082533"
    if p1.ShowLockIcon ~= nil then
        ShowLockIcon = p1.ShowLockIcon
    else
        ShowLockIcon = true
    end
    local v4 = p1.ZOffset or 0
    local TextMaxSize = p1.TextMaxSize
    if not TextMaxSize then
        TextMaxSize = Vector2.new(2000, 514)
    end
    local u25 = scope:Computed(function(p1_2) -- Line: 38 -- upvalues: p1 (val)
        local Locked = p1.Locked
        if Locked == nil then
            return true
        end
        return p1_2(Locked)
    end)
    local v5 = scope:Computed(function(p1_2) -- Line: 46 -- upvalues: p1 (val)
        local RequiresText = p1.RequiresText
        if RequiresText == nil then
            return ""
        end
        return p1_2(RequiresText)
    end)
    local v6 = scope:Computed(function(p1_2) -- Line: 55 -- upvalues: p1 (val), u25 (val)
        if p1.AlwaysOnTop ~= nil then
            return p1_2(p1.AlwaysOnTop)
        end
        return p1_2(u25)
    end)
    local v7 = scope:Computed(function(p1) -- Line: 63 -- upvalues: ShowLockIcon (val), u25 (val)
        if not ShowLockIcon then
            return false
        end
        return p1(u25)
    end)
    local v8 = scope:Computed(function(p1) -- Line: 74 -- upvalues: u25 (val)
        if p1(u25) then
            return 0.3
        end
        return 0.7
    end)
    local v9 = scope:New("SurfaceGui")
    local v10 = {
        Name = "LockOverlay",
        Face = Enum.NormalId.Top,
        ResetOnSpawn = false,
        SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        AlwaysOnTop = v6,
        ZOffset = v4,
        Adornee = p1.Adornee,
    }
    local v11 = Children
    local v12 = {}
    local v13 = scope:New("Frame")
    local v14 = {
        Name = "Frame",
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = v8,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
    }
    local v15 = Children
    local v16 = {}
    local v17 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0, v1)})
    local v18 = scope:New("UIStroke")({Name = "UIStroke", Thickness = v2})
    local v19 = scope:New("UIPadding")({Name = "UIPadding", PaddingLeft = UDim.new(0, 15), PaddingRight = UDim.new(0, 15)})
    local v20 = scope:New("UIListLayout")({
        Name = "UIListLayout",
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    })
    local v21 = scope:New("ImageLabel")
    local v22 = {
        Name = "LockIcon",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Image = v3,
        LayoutOrder = 1,
        ScaleType = Enum.ScaleType.Fit,
        Size = UDim2.fromScale(1, 0.5),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        Visible = v7,
    }
    local v23 = Children
    v22[v23] = {scope:New("UISizeConstraint")({Name = "UISizeConstraint", MaxSize = Vector2.new(1500, 1280)})}
    v21 = v21(v22)
    v22 = scope:New("TextLabel")
    v23 = {
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
        Text = v5,
        TextColor3 = Theme.Menu.Text,
        TextScaled = true,
        TextSize = 14,
        TextWrapped = true,
        Visible = u25,
        ZIndex = 2,
    }
    local v24 = Children
    local v25 = {}
    local v26 = scope:New("UIStroke")({Name = "UIStroke", Thickness = 0.06})
    local v27 = scope:New("UISizeConstraint")
    v25[1] = v26
    v25[2] = v27({Name = "UISizeConstraint", MaxSize = TextMaxSize})
    v23[v24] = v25
    v16[1] = v17
    v16[2] = v18
    v16[3] = v19
    v16[4] = v20
    v16[5] = v21
    v16[6] = v22(v23)
    v14[v15] = v16
    v12[1] = v13(v14)
    v10[v11] = v12
    return v9(v10)
end