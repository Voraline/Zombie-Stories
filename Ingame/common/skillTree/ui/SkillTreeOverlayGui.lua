local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local EconomyConfig = require(ReplicatedStorage.common.skillTree.config.EconomyConfig)
local fusion_utils = require(ReplicatedStorage.common.fusion_utils)
local u40 = Vector2.new(1280, 720)
local u41 = {Accent = Theme.Menu.Accent, Fill = Color3.fromRGB(48, 36, 22)}
local v1 = {}
local v2 = ColorSequenceKeypoint.new(0, Color3.fromRGB(92, 68, 34))
v1[1] = v2
v1[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(48, 36, 22))
u41.Gradient = ColorSequence.new(v1)
local function commaFormat(p1) -- Line: 25
    return tostring((math.floor(p1))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end
local function actionButton(p1, p2) -- Line: 51 -- upvalues: UIKit (val), Theme (val)
    return UIKit.CategoryButton({
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
return function(p1) -- Line: 80 -- upvalues: fusion_utils (val), u40 (val), EconomyConfig (val), Players (val), Children (val), Theme (val), UIKit (val), actionButton (val), u41 (val)
    local v1
    local scope = p1.scope
    local u5 = scope:Value(false)
    local u8 = fusion_utils.useViewport()
    local u12 = scope:Computed(function(p1) -- Line: 84 -- upvalues: u8 (val), u40 (upval)
        local v1 = p1(u8)
        if v1.X <= 0 or v1.Y <= 0 then
            return 1
        end
        local v2 = v1.X / u40.X
        return (math.max(0.55, (math.min(1, v2, v1.Y / u40.Y))))
    end)
    local u16 = scope:Computed(function(p1) -- Line: 91 -- upvalues: u8 (val)
        local v1 = p1(u8)
        local v2 = if v1.X > 900 then v1.Y <= 500 else true
        return v2
    end)
    v1 = scope:Computed(function(a1) -- Line: 95 -- upvalues: p1 (val)
        return (("SKILL POINTS: %*"):format((tostring((math.floor((a1(p1.SP))))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))))
    end)
    local v2 = scope:Computed(function(a1) -- Line: 98 -- upvalues: p1 (val)
        local v1 = tostring((math.floor((a1(p1.SPSpent))))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        return (("INVESTED: %* / %*"):format(v1, (tostring((math.floor((a1(p1.SPCap))))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))))
    end)
    local v3 = scope:Computed(function(a1) -- Line: 101 -- upvalues: p1 (val), EconomyConfig (upval)
        local v1 = a1(p1.PrestigeLevel)
        return (("Prestige (%* Z$)"):format((tostring((math.floor((EconomyConfig.getPrestigeZBucksCost(v1))))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))))
    end)
    local v4 = scope:Computed(function(a1) -- Line: 105 -- upvalues: p1 (val), EconomyConfig (upval)
        local v1
        local v2 = a1(p1.PrestigeLevel)
        local v3 = math.floor(math.min(v2 * EconomyConfig.XP_BOOST_PER_PRESTIGE, EconomyConfig.MAX_XP_BOOST) * 100 + 0.5)
        local v4 = math.floor((a1(p1.XPBonusMult) - 1) * 100 + 0.5)
        if v2 ~= 0 then
            v1 = ("Prestige: %* (+%*%% XP)"):format(v2, v3)
        else
            v1 = ("Prestige: None (%*%% XP)"):format(v3)
        end
        if 0 < v4 then
            v1 = v1 .. (" (+%*%%)"):format(v4)
        end
        return v1
    end)
    local v5 = scope:Computed(function(a1) -- Line: 116 -- upvalues: p1 (val), EconomyConfig (upval)
        local v1
        if a1(p1.AtSPCap) then
            v1 = " (Max)"
        elseif not (a1(p1.AtDailyCap)) then
            v1 = ""
        else
            v1 = " (Daily Max)"
        end
        local v2 = tostring((math.floor((a1(p1.XPBar))))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        return (("Skill XP: %* / %*%*"):format(v2, tostring((math.floor(EconomyConfig.SP_XP_PER_SP))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), v1))
    end)
    local v6 = scope:Computed(function(a1) -- Line: 120 -- upvalues: p1 (val)
        local v1 = tostring((math.floor((a1(p1.DailyEarned))))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        return (("Daily: %* / %* SP"):format(v1, (tostring((math.floor((a1(p1.DailyEarnCap))))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))))
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
    local v9 = {}
    local v10 = scope:New("Frame")
    local v11 = {
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
    local v12 = {}
    local v13 = scope:New("UIScale")
    v13 = v13({Scale = u12})
    local v14 = scope:New("Frame")
    local v15 = {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 58),
        Position = UDim2.fromOffset(0, 0),
        BackgroundColor3 = Theme.Menu.Panel,
        BorderSizePixel = 0,
        ZIndex = Theme.ZIndex.Header,
    }
    local v16 = {}
    local v17 = scope:New("UIStroke")
    v17 = v17({Color = Theme.Menu.HeaderStroke, Thickness = Theme.Stroke.Medium})
    local v18 = scope:New("UIGradient")
    v18 = v18({Color = Theme.Menu.Shade, Rotation = Theme.Menu.ShadeRotation})
    local v19 = scope:New("Frame")
    v19 = v19({BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 2), Position = UDim2.new(0, 0, 1, -2), BackgroundColor3 = Theme.Menu.Accent})
    local v20 = scope:New("TextLabel")
    v20 = v20({
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
    local v21 = UIKit.Badge({
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
    local v22 = {
        Name = "Close",
        scope = scope,
        Position = UDim2.new(1, -20, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        Size = UDim2.fromOffset(34, 34),
        ZIndex = Theme.ZIndex.Header + 2,
        OnClick = p1.OnExit,
    }
    v16[1] = v17
    v16[2] = v18
    v16[3] = v19
    v16[4] = v20
    v16[5] = v21
    v16[6] = UIKit.CloseButton(v22)
    v15[Children] = v16
    v14 = v14(v15)
    local v23 = {
        Name = "EconomyPanel",
        scope = scope,
        Position = UDim2.fromOffset(20, 76),
        Size = UDim2.fromOffset(400, 274),
        BackgroundColor3 = Theme.Menu.Panel,
        ZIndex = Theme.ZIndex.Content,
    }
    v16 = {}
    v17 = scope:New("UIPadding")
    v17 = v17({PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12), PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14)})
    v18 = scope:New("UIListLayout")
    v18 = v18({Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder})
    v19 = scope:New("TextLabel")
    v19 = v19({
        LayoutOrder = 1,
        BackgroundTransparency = 1,
        TextSize = 18,
        Size = UDim2.new(1, 0, 0, 24),
        Text = v4,
        Font = Theme.Menu.Fonts.Header,
        TextColor3 = Theme.Colors.Rarity.Mythical,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    v20 = scope:New("TextLabel")
    v20 = v20({
        LayoutOrder = 2,
        BackgroundTransparency = 1,
        TextSize = 18,
        Size = UDim2.new(1, 0, 0, 24),
        Text = v1,
        Font = Theme.Menu.Fonts.Header,
        TextColor3 = Theme.Menu.AccentCyan,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    v21 = scope:New("TextLabel")
    v21 = v21({
        LayoutOrder = 3,
        BackgroundTransparency = 1,
        TextSize = 16,
        Size = UDim2.new(1, 0, 0, 22),
        Text = v2,
        Font = Theme.Menu.Fonts.Header,
        TextColor3 = Theme.Menu.TextMuted,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    local v24 = UIKit.ProgressBar({
        LayoutOrder = 4,
        scope = scope,
        Size = UDim2.new(1, 0, 0, 28),
        Value = p1.XPBar,
        Max = EconomyConfig.SP_XP_PER_SP,
        Text = v5,
    })
    v22 = scope:New("TextLabel")
    v22 = v22({
        LayoutOrder = 5,
        BackgroundTransparency = 1,
        TextSize = 16,
        Size = UDim2.new(1, 0, 0, 22),
        Text = v6,
        Font = Theme.Menu.Fonts.Body,
        TextColor3 = Theme.Menu.TextMuted,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    local v25 = {
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
    v16[1] = v17
    v16[2] = v18
    v16[3] = v19
    v16[4] = v20
    v16[5] = v21
    v16[6] = v24
    v16[7] = v22
    v16[8] = UIKit.Currency(v25)
    v23.Children = v16
    v15 = UIKit.Card(v23)
    v23 = scope:New("Frame")
    v16 = {
        Name = "ActionButtons",
        Position = UDim2.new(1, -20, 0, 76),
        AnchorPoint = Vector2.new(1, 0),
        Size = UDim2.fromOffset(210, 156),
        BackgroundTransparency = 1,
    }
    v18 = {}
    v19 = scope:New("UIListLayout")
    v19 = v19({Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder})
    v20 = actionButton(scope, {
        Name = "Respec",
        LayoutOrder = 1,
        Text = ("Respec (%* Z$)"):format((tostring((math.floor(EconomyConfig.RESPEC_ZBUCKS_COST))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))),
        Visible = p1.RespecVisible,
        Colors = Theme.Menu.NavigationColors.Loadout,
        OnClick = p1.OnRespec,
    })
    v21 = actionButton(scope, {
        Name = "Prestige",
        LayoutOrder = 2,
        Text = v3,
        Visible = p1.CanPrestige,
        Colors = Theme.Menu.NavigationColors.Shop,
        OnClick = p1.OnPrestige,
    })
    v22 = {
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
    v18[1] = v19
    v18[2] = v20
    v18[3] = v21
    v18[4] = UIKit.CategoryButton(v22)
    v16[Children] = v18
    v12[1] = v13
    v12[2] = v14
    v12[3] = v15
    v12[4] = v23(v16)
    v11[Children] = v12
    v9[1] = v10(v11)
    v8[Children] = v9
    local u502 = v7(v8)
    UIKit.Modal({
        Name = "SkillTreeHelp",
        Dismissable = true,
        Title = "HOW TO EARN SKILL POINTS",
        Text = "• Play games to earn Skill XP based on your combat score. There is a daily cap.\n• Some daily and weekly quests award SP.\n• Quests don't count towards the daily cap.\n• Prestige increases your SP cap and XP bonus.\n• Reach max SP and spend it all to unlock Prestige.",
        scope = scope,
        Parent = u502,
        Open = u5,
        TextColor = Theme.Menu.TextMuted,
        Buttons = {
            {Text = "GOT IT", Color = Theme.Menu.NavigationColors.Map.Accent, BackgroundColor = Theme.Menu.NavigationColors.Map.Fill, GradientColor = Theme.Menu.NavigationColors.Map.Gradient},
        },
    })
    local PropertyChangedSignal = u502:GetPropertyChangedSignal("Enabled")
    PropertyChangedSignal:Connect(function() -- Line: 355 -- upvalues: u502 (val), u5 (val)
        if not u502.Enabled then
            u5:set(false)
        end
    end)
    return u502
end