local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = (require(ReplicatedStorage.Packages.Fusion)).Children
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local EconomyConfig = require(ReplicatedStorage.common.skillTree.config.EconomyConfig)
local fusion_utils = require(ReplicatedStorage.common.fusion_utils)
local u40 = Vector2.new(1280, 720)
local u41 = {}
u41.Accent = Theme.Menu.Accent
u41.Fill = Color3.fromRGB(48, 36, 22)
local new = ColorSequence.new
local v1 = {
    ColorSequenceKeypoint.new(0, Color3.fromRGB(92, 68, 34)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(48, 36, 22)),
}
u41.Gradient = new(v1)

local function commaFormat(p1) -- Line: 25
    local v1 = math.floor(p1)
    return tostring(v1):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

local function actionButton(p1, p2) -- Line: 51 -- upvalues: UIKit (val), Theme (val)
    local v1 = UIKit
    return v1.CategoryButton({
        Selected = true,
        TextMaxSize = 15,
        scope = p1,
        Name = p2.Name,
        Size = UDim2.new(1, 0, 0, 42),
        LayoutOrder = p2.LayoutOrder,
        Visible = p2.Visible,
        Text = p2.Text,
        AccentColor3 = p2.Colors.Accent,
        SelectedBackgroundColor3 = p2.Colors.Fill,
        SelectedTextColor3 = Theme.Menu.Text,
        SelectedStrokeColor3 = p2.Colors.Accent,
        GradientColor = p2.Colors.Gradient,
        OnClick = p2.OnClick,
    })
end

return function(p1) -- Line: 80
    -- upvalues: fusion_utils (val), u40 (val), EconomyConfig (val), Players (val), Children (val), Theme (val)
    -- upvalues: UIKit (val), actionButton (val), u41 (val)
    local scope = p1.scope
    local u5 = scope:Value(false)
    local u8 = fusion_utils.useViewport()
    local u12 = scope:Computed(function(p1) -- Line: 84 -- upvalues: u8 (val), u40 (upval)
        local v1 = p1(u8)
        if not (v1.X <= 0) and not (v1.Y <= 0) then
            local v2 = v1.X / u40.X
            local Y = v1.Y
            local v3 = u40
            local v4 = Y / v3.Y
            local v5 = math.min(1, v2, v4)
            return (math.max(0.55, v5))
        end
        return 1
    end)
    local u16 = scope:Computed(function(p1) -- Line: 91 -- upvalues: u8 (val)
        local v1 = p1(u8)
        local v2 = true
        if not (v1.X <= 900) then
            v2 = v1.Y <= 500
        end
        return v2
    end)
    local v1 = scope:Computed(function(p1_2) -- Line: 95 -- upvalues: p1 (val)
        local v1 = p1
        local SP = v1.SP
        local v2 = p1_2(SP)
        local v3 = math.floor(v2)
        v3 = tostring(v3):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        return (("SKILL POINTS: %*"):format(v3))
    end)
    local v2 = scope:Computed(function(p1_2) -- Line: 98 -- upvalues: p1 (val)
        local v1 = p1
        local SPSpent = v1.SPSpent
        local v2 = p1_2(SPSpent)
        local v3 = math.floor(v2)
        local v4 = tostring(v3):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        v3 = p1
        local SPCap = v3.SPCap
        v1 = p1_2(SPCap)
        local v5 = math.floor(v1)
        v5 = tostring(v5):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        return (("INVESTED: %* / %*"):format(v4, v5))
    end)
    local v3 = scope:Computed(function(p1_2) -- Line: 101 -- upvalues: p1 (val), EconomyConfig (upval)
        local v1 = p1_2(p1.PrestigeLevel)
        local v2 = EconomyConfig
        v2 = v2.getPrestigeZBucksCost(v1)
        local v3 = math.floor(v2)
        v3 = tostring(v3):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        return (("Prestige (%* Z$)"):format(v3))
    end)
    local v4 = scope:Computed(function(p1_2) -- Line: 105 -- upvalues: p1 (val), EconomyConfig (upval)
        local v1 = p1_2(p1.PrestigeLevel)
        local v2 = v1 * EconomyConfig.XP_BOOST_PER_PRESTIGE
        local v3 = EconomyConfig
        local MAX_XP_BOOST = v3.MAX_XP_BOOST
        local v4 = (math.min(v2, MAX_XP_BOOST)) * 100 + 0.5
        local v5 = math.floor(v4)
        local v6 = p1
        local XPBonusMult = v6.XPBonusMult
        local v7 = ((p1_2(XPBonusMult)) - 1) * 100 + 0.5
        v4 = math.floor(v7)
        if v1 ~= 0 then
            v7 = ("Prestige: %* (+%*%% XP)"):format(v1, v5)
        else
            v7 = ("Prestige: None (%*%% XP)"):format(v5)
        end
        if 0 < v4 then
            v7 = v7 .. (" (+%*%%)"):format(v4)
        end
        return v7
    end)
    local v5 = scope:Computed(function(p1_2) -- Line: 116 -- upvalues: p1 (val), EconomyConfig (upval)
        local v1
        if p1_2(p1.AtSPCap) then
            v1 = " (Max)"
        elseif not p1_2(p1.AtDailyCap) then
            v1 = ""
        else
            v1 = " (Daily Max)"
        end
        local v2 = p1
        local XPBar = v2.XPBar
        local v3 = p1_2(XPBar)
        local v4 = math.floor(v3)
        local v5 = tostring(v4):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        v2 = EconomyConfig
        local SP_XP_PER_SP = v2.SP_XP_PER_SP
        local v6 = math.floor(SP_XP_PER_SP)
        v6 = tostring(v6):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        return (("Skill XP: %* / %*%*"):format(v5, v6, v1))
    end)
    local v6 = scope:Computed(function(p1_2) -- Line: 120 -- upvalues: p1 (val)
        local v1 = p1
        local DailyEarned = v1.DailyEarned
        local v2 = p1_2(DailyEarned)
        local v3 = math.floor(v2)
        local v4 = tostring(v3):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        v3 = p1
        local DailyEarnCap = v3.DailyEarnCap
        v1 = p1_2(DailyEarnCap)
        local v5 = math.floor(v1)
        v5 = tostring(v5):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        return (("Daily: %* / %* SP"):format(v4, v5))
    end)
    local v7 = scope:New("ScreenGui")
    local v8 = {
        Name = "SkillTreeButtonsGui",
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
        ResetOnSpawn = false,
        IgnoreGuiInset = false,
        DisplayOrder = 24,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Enabled = false,
    }
    local v9 = Children
    local v10 = {}
    local v11 = scope:New("Frame")
    local v12 = {
        Name = "ReferenceSurface",
        AnchorPoint = Vector2.zero,
        Position = UDim2.fromScale(0, 0),
        Size = scope:Computed(function(p1) -- Line: 140 -- upvalues: u12 (val)
            local v1 = p1(u12)
            return UDim2.fromScale(1 / v1, 1 / v1)
        end),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
    }
    local v13 = Children
    local v14 = {}
    local v15 = scope:New("UIScale")({Scale = u12})
    local v16 = scope:New("Frame")
    local v17 = {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 58),
        Position = UDim2.fromOffset(0, 0),
        BackgroundColor3 = Theme.Menu.Panel,
        BorderSizePixel = 0,
        ZIndex = Theme.ZIndex.Header,
    }
    local v18 = Children
    local v19 = {}
    local v20 = scope:New("UIStroke")({Color = Theme.Menu.HeaderStroke, Thickness = Theme.Stroke.Medium})
    local v21 = scope:New("UIGradient")({Color = Theme.Menu.Shade, Rotation = Theme.Menu.ShadeRotation})
    local v22 = scope:New("Frame")({
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = Theme.Menu.Accent,
    })
    local v23 = scope:New("TextLabel")({
        Name = "Title",
        BackgroundTransparency = 1,
        Text = "SKILL TREE",
        TextSize = 30,
        Position = UDim2.fromOffset(20, 0),
        Size = UDim2.new(0, 320, 1, 0),
        Font = Theme.Menu.Fonts.Title,
        TextColor3 = Theme.Menu.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = Theme.ZIndex.Header + 1,
    })
    local v24 = UIKit
    v24 = v24.Badge({
        Name = "BetaLabel",
        TextSize = 14,
        scope = scope,
        Position = scope:Computed(function(p1) -- Line: 179 -- upvalues: u16 (val)
            if p1(u16) then
                return (UDim2.new(1, -150, 0, 14))
            end
            return (UDim2.fromOffset(290, 14))
        end),
        Size = scope:Computed(function(p1) -- Line: 182 -- upvalues: u16 (val)
            if p1(u16) then
                return (UDim2.fromOffset(72, 30))
            end
            return (UDim2.fromOffset(480, 30))
        end),
        Visible = EconomyConfig.IS_BETA,
        BackgroundColor3 = Theme.Colors.CloseButton,
        Text = scope:Computed(function(p1) -- Line: 187 -- upvalues: u16 (val)
            if p1(u16) then
                return "BETA"
            end
            return "BETA — Progress and Z$ will be refunded on release."
        end),
        TextColor3 = Theme.Menu.Text,
        ZIndex = Theme.ZIndex.Header + 1,
    })
    local v25 = UIKit
    local CloseButton = v25.CloseButton
    local v26 = {
        Name = "Close",
        scope = scope,
        Position = UDim2.new(1, -20, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        Size = UDim2.fromOffset(34, 34),
        ZIndex = Theme.ZIndex.Header + 2,
        OnClick = p1.OnExit,
    }
    v19[1] = v20
    v19[2] = v21
    v19[3] = v22
    v19[4] = v23
    v19[5] = v24
    v19[6] = CloseButton(v26)
    v17[v18] = v19
    v16 = v16(v17)
    v17 = UIKit
    local Card = v17.Card
    v18 = {
        Name = "EconomyPanel",
        scope = scope,
        Position = UDim2.fromOffset(20, 76),
        Size = UDim2.fromOffset(400, 274),
        BackgroundColor3 = Theme.Menu.Panel,
        ZIndex = Theme.ZIndex.Content,
    }
    v19 = {}
    v20 = scope:New("UIPadding")({
        PaddingTop = UDim.new(0, 12),
        PaddingBottom = UDim.new(0, 12),
        PaddingLeft = UDim.new(0, 14),
        PaddingRight = UDim.new(0, 14),
    })
    v21 = scope:New("UIListLayout")({Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder})
    v22 = scope:New("TextLabel")({
        LayoutOrder = 1,
        BackgroundTransparency = 1,
        TextSize = 18,
        Size = UDim2.new(1, 0, 0, 24),
        Text = v4,
        Font = Theme.Menu.Fonts.Header,
        TextColor3 = Theme.Colors.Rarity.Mythical,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    v23 = scope:New("TextLabel")({
        LayoutOrder = 2,
        BackgroundTransparency = 1,
        TextSize = 18,
        Size = UDim2.new(1, 0, 0, 24),
        Text = v1,
        Font = Theme.Menu.Fonts.Header,
        TextColor3 = Theme.Menu.AccentCyan,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    v24 = scope:New("TextLabel")({
        LayoutOrder = 3,
        BackgroundTransparency = 1,
        TextSize = 16,
        Size = UDim2.new(1, 0, 0, 22),
        Text = v2,
        Font = Theme.Menu.Fonts.Header,
        TextColor3 = Theme.Menu.TextMuted,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    v25 = UIKit
    v25 = v25.ProgressBar({
        LayoutOrder = 4,
        scope = scope,
        Size = UDim2.new(1, 0, 0, 28),
        Value = p1.XPBar,
        Max = EconomyConfig.SP_XP_PER_SP,
        Text = v5,
    })
    v26 = scope:New("TextLabel")({
        LayoutOrder = 5,
        BackgroundTransparency = 1,
        TextSize = 16,
        Size = UDim2.new(1, 0, 0, 22),
        Text = v6,
        Font = Theme.Menu.Fonts.Body,
        TextColor3 = Theme.Menu.TextMuted,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    local v27 = UIKit
    local Currency = v27.Currency
    local v28 = {
        LayoutOrder = 6,
        ShowPlus = true,
        PaddingLeft = 10,
        PaddingRight = 5,
        scope = scope,
        Amount = p1.ZBucks,
        Size = UDim2.fromOffset(0, 38),
        StrokeColor3 = Theme.Menu.NavigationColors.Play.Accent,
        OnClick = p1.OnZBucks,
    }
    v19[1] = v20
    v19[2] = v21
    v19[3] = v22
    v19[4] = v23
    v19[5] = v24
    v19[6] = v25
    v19[7] = v26
    v19[8] = Currency(v28)
    v18.Children = v19
    v17 = Card(v18)
    v18 = scope:New("Frame")
    v19 = {
        Name = "ActionButtons",
        Position = UDim2.new(1, -20, 0, 76),
        AnchorPoint = Vector2.new(1, 0),
        Size = UDim2.fromOffset(210, 156),
        BackgroundTransparency = 1,
    }
    v20 = Children
    v21 = {}
    v22 = scope:New("UIListLayout")({Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder})
    v23 = actionButton
    v25 = {Name = "Respec", LayoutOrder = 1}
    local v29 = EconomyConfig
    local RESPEC_ZBUCKS_COST = v29.RESPEC_ZBUCKS_COST
    local v30 = math.floor(RESPEC_ZBUCKS_COST)
    v30 = tostring(v30):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    v25.Text = ("Respec (%* Z$)"):format(v30)
    v25.Visible = p1.RespecVisible
    v25.Colors = Theme.Menu.NavigationColors.Loadout
    v25.OnClick = p1.OnRespec
    v23 = v23(scope, v25)
    v24 = actionButton
    v24 = v24(scope, {
        Name = "Prestige",
        LayoutOrder = 2,
        Text = v3,
        Visible = p1.CanPrestige,
        Colors = Theme.Menu.NavigationColors.Shop,
        OnClick = p1.OnPrestige,
    })
    v25 = UIKit
    local CategoryButton = v25.CategoryButton
    v26 = {
        Name = "Help",
        LayoutOrder = 3,
        Text = "?  HOW TO EARN SP",
        Selected = true,
        TextMaxSize = 16,
        scope = scope,
        Size = UDim2.new(1, 0, 0, 42),
        AccentColor3 = u41.Accent,
        SelectedBackgroundColor3 = u41.Fill,
        SelectedTextColor3 = Theme.Menu.Text,
        SelectedStrokeColor3 = u41.Accent,
        GradientColor = u41.Gradient,
        OnClick = function() -- Line: 326 -- upvalues: u5 (val)
            u5:set(true)
        end,
    }
    v21[1] = v22
    v21[2] = v23
    v21[3] = v24
    v21[4] = CategoryButton(v26)
    v19[v20] = v21
    v14[1] = v15
    v14[2] = v16
    v14[3] = v17
    v14[4] = v18(v19)
    v12[v13] = v14
    v10[1] = v11(v12)
    v8[v9] = v10
    local u502 = v7(v8)
    v8 = UIKit
    v8.Modal({
        Name = "SkillTreeHelp",
        Dismissable = true,
        Title = "HOW TO EARN SKILL POINTS",
        Text = "• Play games to earn Skill XP based on your combat score. There is a daily cap.\n• Some daily and weekly quests award SP.\n• Quests don't count towards the daily cap.\n• Prestige increases your SP cap and XP bonus.\n• Reach max SP and spend it all to unlock Prestige.",
        scope = scope,
        Parent = u502,
        Open = u5,
        TextColor = Theme.Menu.TextMuted,
        Buttons = {
            {
                Text = "GOT IT",
                Color = Theme.Menu.NavigationColors.Map.Accent,
                BackgroundColor = Theme.Menu.NavigationColors.Map.Fill,
                GradientColor = Theme.Menu.NavigationColors.Map.Gradient,
            },
        },
    })
    ;(u502:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 355 -- upvalues: u502 (val), u5 (val)
        if not u502.Enabled then
            u5:set(false)
        end
    end)
    return u502
end