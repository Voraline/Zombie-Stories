local Theme = require(script.Parent.Theme)
local GenericButton = require(script.Parent.Components.GenericButton)
local GenericExitButton = require(script.Parent.Components.GenericExitButton)
local MenuBase = require(script.Parent.Components.MenuBase)
local Panel = require(script.Panel)
local ScrollList = require(script.ScrollList)
local Card = require(script.Card)
local Dropdown = require(script.Dropdown)
local Toggle = require(script.Toggle)
local Slider = require(script.Slider)
local AvatarSlot = require(script.AvatarSlot)
local Modal = require(script.Modal)
local Currency = require(script.Currency)
local PriceTag = require(script.PriceTag)
local ItemTile = require(script.ItemTile)
local CategoryButton = require(script.CategoryButton)
local SectionHeader = require(script.SectionHeader)
local GradientOutline = require(script.GradientOutline)
local UISounds = require(script.UISounds)
local FadeGroup = require(script.FadeGroup)
local ProgressBar = require(script.ProgressBar)
local Badge = require(script.Badge)
local function withDefaults(p1, p2) -- Line: 41
    local v1 = table.clone(p1)
    local v2 = p2
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if v1[i] == nil then
            v1[i] = j
        end
    end
    return v1
end
return {
    Theme = Theme,
    Button = function(p1) -- Line: 56 -- upvalues: GenericButton (val), Theme (val), UISounds (val)
        local v1 = {
            Font = Theme.Fonts.Button,
            TextColor3 = Theme.Colors.TextPrimary,
            TextSize = Theme.FontSizes.Medium,
            ButtonSound = UISounds.ClickSound,
            HoverSound = UISounds.HoverSound,
        }
        local v2 = table.clone(p1)
        local v3 = v1
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            if v2[i] == nil then
                v2[i] = j
            end
        end
        return GenericButton(v2)
    end,
    CloseButton = function(p1) -- Line: 67 -- upvalues: Theme (val), UISounds (val), GenericExitButton (val)
        local BackgroundColor3
        local v1 = {
            Text = "X",
            TextScaled = false,
            TextSize = 20,
            BackgroundTransparency = 0,
            OutlineEnabled = true,
            OutlineThickness = 2,
            Font = Theme.Menu.Fonts.Button,
            TextColor3 = Theme.Colors.CloseButtonText,
            OutlineColor3 = Color3.fromRGB(255, 111, 111),
            ButtonSound = UISounds.CloseSound,
            HoverSound = UISounds.HoverSound,
        }
        local v2 = table.clone(p1)
        local v3 = v1
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            if v2[i] == nil then
                v2[i] = j
            end
        end
        local v6 = v2
        local Text = v6.Text
        local Font = v6.Font
        local TextScaled = v6.TextScaled
        local TextSize = v6.TextSize
        local TextColor3 = v6.TextColor3
        local TextStrokeTransparency = v6.TextStrokeTransparency
        local TextStrokeColor3 = v6.TextStrokeColor3
        v6.Text = ""
        local v7 = {}
        local v8 = p1.scope:New("UICorner")
        v8 = v8({CornerRadius = UDim.new(0, 6)})
        local v9 = p1.scope:New("UIGradient")
        local v10 = {Rotation = 90}
        local v11 = {}
        local v12 = ColorSequenceKeypoint.new(0, Color3.fromRGB(126, 42, 48))
        v11[1] = v12
        v11[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(62, 24, 29))
        v10.Color = ColorSequence.new(v11)
        v9 = v9(v10)
        v10 = p1.scope:New("TextLabel")
        v10 = v10({
            Name = "CloseGlyph",
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Text = Text,
            Font = Font,
            TextScaled = TextScaled,
            TextSize = TextSize,
            TextColor3 = TextColor3,
            TextStrokeTransparency = TextStrokeTransparency,
            TextStrokeColor3 = TextStrokeColor3,
            ZIndex = (p1.ZIndex or 1) + 2,
        })
        v7[1] = v8
        v7[2] = v9
        v7[3] = v10
        v7[4] = p1.Children
        v6.Children = v7
        if p1.BackgroundColor3 ~= nil then
            BackgroundColor3 = p1.BackgroundColor3
        else
            BackgroundColor3 = Color3.new(1, 1, 1)
        end
        v6.BackgroundColor3 = BackgroundColor3
        return GenericExitButton(v6)
    end,
    Window = function(p1) -- Line: 121 -- upvalues: MenuBase (val)
        return MenuBase(p1)
    end,
    Panel = Panel,
    ScrollList = ScrollList,
    Card = Card,
    Dropdown = Dropdown,
    Toggle = Toggle,
    Slider = Slider,
    AvatarSlot = AvatarSlot,
    Modal = Modal,
    Currency = Currency,
    PriceTag = PriceTag,
    ItemTile = ItemTile,
    CategoryButton = CategoryButton,
    SectionHeader = SectionHeader,
    GradientOutline = GradientOutline,
    UISounds = UISounds,
    FadeGroup = FadeGroup,
    ProgressBar = ProgressBar,
    Badge = Badge,
}