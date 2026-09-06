local v1 = {
    Colors = {
        MainBackgroundTransparency = 0.5,
        ButtonFrameTransparency = 0.3,
        MainBackground = Color3.fromRGB(8, 15, 21),
        FrameBack = Color3.fromRGB(32, 65, 90),
        FrameFill = Color3.fromRGB(16, 32, 45),
        InfoFrame = Color3.fromRGB(16, 33, 45),
        ButtonFrame = Color3.fromRGB(17, 34, 47),
        HeaderBackground = Color3.fromRGB(24, 46, 65),
        SectionTitle = Color3.fromRGB(198, 236, 240),
        ItemCard = Color3.fromRGB(32, 45, 49),
        ItemBorder = Color3.fromRGB(58, 147, 255),
        ItemBorderGray = Color3.fromRGB(186, 186, 186),
        TextPrimary = Color3.fromRGB(255, 255, 255),
        TextHeader = Color3.fromRGB(198, 236, 240),
        TextSecondary = Color3.fromRGB(255, 255, 255),
        TextMuted = Color3.fromRGB(200, 200, 200),
        ZBucksGreen = Color3.fromRGB(113, 194, 118),
        ZBucksTitle = Color3.fromRGB(150, 255, 134),
        RobuxPrice = Color3.fromRGB(113, 211, 113),
        InsufficientFunds = Color3.fromRGB(255, 93, 93),
        Rarity = {
            Stock = Color3.fromRGB(186, 186, 186),
            Typical = Color3.fromRGB(102, 216, 111),
            Unique = Color3.fromRGB(58, 147, 255),
            Rare = Color3.fromRGB(255, 153, 51),
            Mythical = Color3.fromRGB(144, 47, 255),
        },
        CloseButton = Color3.fromRGB(255, 73, 73),
        CloseButtonText = Color3.fromRGB(255, 255, 255),
        GamepassTitle = Color3.fromRGB(170, 0, 255),
        GamepassBackground = Color3.fromRGB(216, 255, 241),
        BonusText = Color3.fromRGB(17, 255, 0),
        AccentHighlight = Color3.fromRGB(216, 255, 241),
    },
    Fonts = {
        Title = Enum.Font.SourceSansBold,
        Header = Enum.Font.SourceSansBold,
        Body = Enum.Font.SourceSans,
        Button = Enum.Font.SourceSansBold,
        Caption = Enum.Font.SourceSansItalic,
        Price = Enum.Font.SourceSansBold,
    },
    FontSizes = {
        ExtraLarge = 28,
        Large = 20,
        Medium = 14,
        Small = 12,
        Caption = 10,
    },
    Spacing = {
        XSmall = 5,
        Small = 10,
        Medium = 15,
        Large = 20,
        ExtraLarge = 30,
    },
    Radius = {Small = 8, Medium = 12, Large = 16},
    Stroke = {Thin = 1, Medium = 2, Thick = 4},
    Transparency = {
        None = 0,
        Light = 0,
        Medium = 0.3,
        High = 0.5,
        VeryHigh = 1,
    },
    Animations = {
        Fast = 0.15,
        Medium = 0.25,
        Slow = 0.5,
        EasingStyle = Enum.EasingStyle.Quad,
        EasingDirection = Enum.EasingDirection.Out,
    },
    ZIndex = {
        Background = 1,
        Content = 2,
        Overlay = 3,
        Header = 4,
        Buttons = 5,
        Modal = 10,
        Tooltip = 15,
    },
}
local v2 = {
    ShadeRotation = 90,
    CornerRadius = 6,
    StrokeThickness = 4,
    SectionHeaderTransparency = 0.8,
    Panel = Color3.fromRGB(17, 37, 63),
    PanelDeep = Color3.fromRGB(14, 33, 50),
    PanelInset = Color3.fromRGB(6, 14, 24),
}
local v3 = {}
local v4 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255))
v3[1] = v4
v3[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147))
v2.Shade = ColorSequence.new(v3)
v3 = {}
v4 = ColorSequenceKeypoint.new(0, Color3.fromRGB(43, 71, 98))
v3[1] = v4
v3[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 24, 40))
v2.ButtonGradient = ColorSequence.new(v3)
v2.Text = Color3.fromRGB(255, 255, 255)
v2.TextMuted = Color3.fromRGB(200, 205, 215)
v2.HeaderStroke = Color3.fromRGB(0, 0, 0)
v2.Accent = Color3.fromRGB(255, 184, 84)
v2.AccentSoft = Color3.fromRGB(102, 216, 111)
v2.AccentCyan = Color3.fromRGB(143, 231, 255)
v2.Positive = Color3.fromRGB(152, 255, 161)
v2.Selected = Color3.fromRGB(86, 62, 28)
local v5 = {}
v3 = {Accent = Color3.fromRGB(102, 216, 111), Fill = Color3.fromRGB(42, 112, 60)}
local v6 = {}
local v7 = ColorSequenceKeypoint.new(0, Color3.fromRGB(72, 157, 82))
v6[1] = v7
v6[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 79, 43))
v3.Gradient = ColorSequence.new(v6)
v5.Play = v3
v3 = {Accent = Color3.fromRGB(255, 154, 73), Fill = Color3.fromRGB(75, 48, 29)}
v6 = {}
v7 = ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 73, 38))
v6[1] = v7
v6[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 31, 24))
v3.Gradient = ColorSequence.new(v6)
v5.Loadout = v3
v3 = {Accent = Color3.fromRGB(183, 95, 255), Fill = Color3.fromRGB(54, 32, 79)}
v6 = {}
v7 = ColorSequenceKeypoint.new(0, Color3.fromRGB(86, 48, 126))
v6[1] = v7
v6[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 24, 62))
v3.Gradient = ColorSequence.new(v6)
v5.Shop = v3
v3 = {Accent = Color3.fromRGB(93, 205, 214), Fill = Color3.fromRGB(22, 62, 70)}
v6 = {}
v7 = ColorSequenceKeypoint.new(0, Color3.fromRGB(36, 91, 100))
v6[1] = v7
v6[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 45, 52))
v3.Gradient = ColorSequence.new(v6)
v5.Map = v3
v3 = {Accent = Color3.fromRGB(111, 170, 190), Fill = Color3.fromRGB(28, 50, 62)}
v6 = {}
v7 = ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 82, 97))
v6[1] = v7
v6[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 37, 49))
v3.Gradient = ColorSequence.new(v6)
v5.More = v3
v3 = {Accent = v1.Colors.CloseButton, Fill = Color3.fromRGB(120, 30, 40)}
v6 = {}
v7 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255))
v6[1] = v7
v6[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 70, 75))
v3.Gradient = ColorSequence.new(v6)
v5.Cancel = v3
v2.NavigationColors = v5
v5 = {}
v3 = Color3.fromRGB(255, 213, 79)
v4 = Color3.fromRGB(102, 216, 111)
v6 = Color3.fromRGB(111, 170, 190)
v5[1] = v3
v5[2] = v4
v5[3] = v6
v5[4] = Color3.fromRGB(183, 95, 255)
v2.MoreColors = v5
v5 = {}
v3 = Color3.fromRGB(102, 216, 111)
v4 = Color3.fromRGB(255, 213, 79)
v6 = Color3.fromRGB(255, 78, 78)
v5[1] = v3
v5[2] = v4
v5[3] = v6
v5[4] = Color3.fromRGB(183, 95, 255)
v2.DifficultyColors = v5
v2.Border = Color3.fromRGB(70, 96, 122)
v2.BorderUnselected = Color3.fromRGB(144, 144, 144)
v2.CornerScale = UDim.new(0.2, 0)
v2.Fonts = {Title = Enum.Font.GothamBlack, Header = Enum.Font.GothamBold, Body = Enum.Font.Gotham, Button = Enum.Font.GothamBold}
v1.Menu = v2
return v1