local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local u18 = require("../Theme")
local u21 = require("../MarauderLoading/AvatarProvider")
local Small = u18.Spacing.Small
local function toHex(p1) -- Line: 23
    local v1 = math.floor(p1.R * 255 + 0.5)
    local v2 = math.floor(p1.G * 255 + 0.5)
    return string.format("#%02X%02X%02X", v1, v2, (math.floor(p1.B * 255 + 0.5)))
end
local function escapeRichText(p1) -- Line: 32
    local v1 = {}
    v1["&"] = "&amp;"
    v1["<"] = "&lt;"
    v1[">"] = "&gt;"
    v1["\""] = "&quot;"
    v1["'"] = "&apos;"
    return p1:gsub("[&<>'\"]", v1)
end
return function(p1) -- Line: 42 -- upvalues: u18 (val), u21 (val), escapeRichText (val), Children (val), Small (val), UIKit (val)
    local scope = p1.scope
    local Tooltip = u18.ZIndex.Tooltip
    local v1 = scope:Spring(p1.Transparency, 20, 1)
    local u17 = scope:Value(string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", p1.UserId))
    task.spawn(function() -- Line: 48 -- upvalues: u17 (val), u21 (upval), p1 (val)
        u17:set(u21.GetHeadshot(p1.UserId))
    end)
    local Accent = u18.Menu.Accent
    local v2 = math.floor(Accent.R * 255 + 0.5)
    local v3 = math.floor(Accent.G * 255 + 0.5)
    local v4 = string.format("#%02X%02X%02X", v2, v3, (math.floor(Accent.B * 255 + 0.5)))
    local v5 = {}
    v5["&"] = "&amp;"
    v5["<"] = "&lt;"
    v5[">"] = "&gt;"
    v5["\""] = "&quot;"
    v5["'"] = "&apos;"
    local v6 = p1.Username:gsub("[&<>'\"]", v5)
    local v7 = string.format("<b><font color=\"%s\">%s:</font></b> %s", v4, v6, escapeRichText(p1.Message))
    local v8 = scope:New("Frame")
    v4 = {
        Name = "AnnouncementToast",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = p1.LayoutOrder or 0,
        ZIndex = Tooltip,
    }
    local v9 = {}
    local v10 = scope:New("UIListLayout")
    v10 = v10({FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Top, SortOrder = Enum.SortOrder.LayoutOrder})
    v2 = scope:New("Frame")
    v3 = {
        Name = "Content",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = 1,
    }
    local v11 = {}
    local v12 = scope:New("UIListLayout")
    v12 = v12({
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, Small),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    local v13 = UIKit.AvatarSlot({
        LayoutOrder = 1,
        scope = scope,
        Thumb = u17,
        CornerRadius = UDim.new(0.5, 0),
        BorderColor3 = u18.Menu.Accent,
        BorderThickness = u18.Stroke.Medium,
        Size = UDim2.fromOffset(40, 40),
        ImageTransparency = v1,
        BackgroundTransparency = v1,
        StrokeTransparency = v1,
        ZIndex = Tooltip + 1,
    })
    local v14 = scope:New("TextLabel")
    local v15 = {
        Name = "Line",
        Size = UDim2.new(1, -(40 + Small), 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Font = u18.Menu.Fonts.Header,
        RichText = true,
        Text = v7,
        TextColor3 = u18.Menu.Text,
        TextSize = u18.FontSizes.Large,
        TextStrokeColor3 = u18.Menu.HeaderStroke,
        TextStrokeTransparency = v1,
        TextTransparency = v1,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        LayoutOrder = 2,
        ZIndex = Tooltip + 1,
    }
    local v16 = {}
    local v17 = scope:New("UIPadding")
    v16[1] = v17({PaddingTop = UDim.new(0, 12)})
    v15[Children] = v16
    v11[1] = v12
    v11[2] = v13
    v11[3] = v14(v15)
    v3[Children] = v11
    v9[1] = v10
    v9[2] = v2(v3)
    v4[Children] = v9
    return v8(v4)
end