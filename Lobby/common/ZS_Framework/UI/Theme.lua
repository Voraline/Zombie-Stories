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
    Shade = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    }),
    ButtonGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(43, 71, 98)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 24, 40)),
    }),
    Text = Color3.fromRGB(255, 255, 255),
    TextMuted = Color3.fromRGB(200, 205, 215),
    HeaderStroke = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(255, 184, 84),
    AccentSoft = Color3.fromRGB(102, 216, 111),
    AccentCyan = Color3.fromRGB(143, 231, 255),
    Positive = Color3.fromRGB(152, 255, 161),
    Selected = Color3.fromRGB(86, 62, 28),
    NavigationColors = {
        Play = {
            Accent = Color3.fromRGB(102, 216, 111),
            Fill = Color3.fromRGB(42, 112, 60),
            Gradient = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(72, 157, 82)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 79, 43)),
            }),
        },
        Loadout = {
            Accent = Color3.fromRGB(255, 154, 73),
            Fill = Color3.fromRGB(75, 48, 29),
            Gradient = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 73, 38)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 31, 24)),
            }),
        },
        Shop = {
            Accent = Color3.fromRGB(183, 95, 255),
            Fill = Color3.fromRGB(54, 32, 79),
            Gradient = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(86, 48, 126)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 24, 62)),
            }),
        },
        Map = {
            Accent = Color3.fromRGB(93, 205, 214),
            Fill = Color3.fromRGB(22, 62, 70),
            Gradient = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(36, 91, 100)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 45, 52)),
            }),
        },
        More = {
            Accent = Color3.fromRGB(111, 170, 190),
            Fill = Color3.fromRGB(28, 50, 62),
            Gradient = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 82, 97)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 37, 49)),
            }),
        },
        Cancel = {
            Accent = v1.Colors.CloseButton,
            Fill = Color3.fromRGB(120, 30, 40),
            Gradient = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 70, 75)),
            }),
        },
    },
}
local v3 = {}
local v4 = Color3.fromRGB(255, 213, 79)
local v5 = Color3.fromRGB(102, 216, 111)
local v6 = Color3.fromRGB(111, 170, 190)
v3[1] = v4
v3[2] = v5
v3[3] = v6
v3[4] = Color3.fromRGB(183, 95, 255)
v2.MoreColors = v3
v3 = {}
v4 = Color3.fromRGB(102, 216, 111)
v5 = Color3.fromRGB(255, 213, 79)
v6 = Color3.fromRGB(255, 78, 78)
v3[1] = v4
v3[2] = v5
v3[3] = v6
v3[4] = Color3.fromRGB(183, 95, 255)
v2.DifficultyColors = v3
v2.Border = Color3.fromRGB(70, 96, 122)
v2.BorderUnselected = Color3.fromRGB(144, 144, 144)
v2.CornerScale = UDim.new(0.2, 0)
v2.Fonts = {
    Title = Enum.Font.GothamBlack,
    Header = Enum.Font.GothamBold,
    Body = Enum.Font.Gotham,
    Button = Enum.Font.GothamBold,
}
v1.Menu = v2
return v1