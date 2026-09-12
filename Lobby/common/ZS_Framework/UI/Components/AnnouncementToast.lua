local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = (require(ReplicatedStorage.Packages.Fusion)).Children
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local u18 = require("../Theme")
local u21 = require("../MarauderLoading/AvatarProvider")
local Small = u18.Spacing.Small

local function toHex(p1) -- Line: 23
    local format = string.format
    local v1 = p1.R * 255 + 0.5
    local v2 = math.floor(v1)
    local v3 = p1.G * 255 + 0.5
    v1 = math.floor(v3)
    local v4 = p1.B * 255 + 0.5
    return format("#%02X%02X%02X", v2, v1, (math.floor(v4)))
end

local function escapeRichText(p1) -- Line: 32
    return p1:gsub("[&<>'\"]", {
        ["&"] = "&amp;",
        ["<"] = "&lt;",
        [">"] = "&gt;",
        ["\""] = "&quot;",
        ["'"] = "&apos;",
    })
end

return function(p1) -- Line: 42
    -- upvalues: u18 (val), u21 (val), escapeRichText (val), Children (val), Small (val), UIKit (val)
    local scope = p1.scope
    local Tooltip = u18.ZIndex.Tooltip
    local Transparency = p1.Transparency
    local v1 = scope:Spring(Transparency, 20, 1)
    local v2 = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", p1.UserId)
    local u17 = scope:Value(v2)
    task.spawn(function() -- Line: 48 -- upvalues: u17 (val), u21 (upval), p1 (val)
        local v1 = u17
        local v2 = u21
        local GetHeadshot = v2.GetHeadshot
        local v3 = p1
        v2 = GetHeadshot(v3.UserId)
        v1:set(v2)
    end)
    local format_2 = string.format
    local Accent = u18.Menu.Accent
    local format_3 = string.format
    local v3 = Accent.R * 255 + 0.5
    local v4 = math.floor(v3)
    local v5 = Accent.G * 255 + 0.5
    v3 = math.floor(v5)
    local v6 = Accent.B * 255 + 0.5
    local v7 = format_3("#%02X%02X%02X", v4, v3, (math.floor(v6)))
    local v8 = p1.Username:gsub("[&<>'\"]", {
        ["&"] = "&amp;",
        ["<"] = "&lt;",
        [">"] = "&gt;",
        ["\""] = "&quot;",
        ["'"] = "&apos;",
    })
    local v9 = format_2("<b><font color=\"%s\">%s:</font></b> %s", v7, v8, escapeRichText(p1.Message))
    v2 = scope:New("Frame")
    v7 = {
        Name = "AnnouncementToast",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = p1.LayoutOrder or 0,
        ZIndex = Tooltip,
    }
    v8 = Children
    local v10 = {}
    local v11 = scope:New("UIListLayout")({
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    v4 = scope:New("Frame")
    v3 = {
        Name = "Content",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = 1,
    }
    v5 = Children
    v6 = {}
    local v12 = scope:New("UIListLayout")({
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, Small),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    local v13 = UIKit
    v13 = v13.AvatarSlot({
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
        Text = v9,
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
    local v16 = Children
    v15[v16] = {scope:New("UIPadding")({PaddingTop = UDim.new(0, 12)})}
    v6[1] = v12
    v6[2] = v13
    v6[3] = v14(v15)
    v3[v5] = v6
    v10[1] = v11
    v10[2] = v4(v3)
    v7[v8] = v10
    return v2(v7)
end