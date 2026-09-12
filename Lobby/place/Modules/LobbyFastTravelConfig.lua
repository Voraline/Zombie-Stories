local v1 = {
    Debug = false,
    Map = {
        Image = "rbxassetid://128754659205466",
        LabelGlowImage = "rbxassetid://76150694119616",
        AspectRatio = 1.7777777777777777,
    },
}
local v2 = {}
local v3 = {
    id = "runway",
    name = "RUNWAY",
    anchor = Vector3.new(-279.99700927734375, 74.75, 88.88999938964844),
    yaw = 0,
    labelPosition = Vector2.new(0.24, 0.42),
    labelGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 251, 213)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 221, 106)),
    }),
    labelGlowColor = Color3.fromRGB(255, 206, 85),
    hitRegions = {
        {position = Vector2.new(0.018, 0.218), size = Vector2.new(0.447, 0.397)},
    },
}
local v4 = {
    id = "range",
    name = "SHOOTING RANGE",
    anchor = Vector3.new(-151.11300659179688, 74.2750015258789, 164.86199951171875),
    yaw = 180,
    labelPosition = Vector2.new(0.82, 0.84),
    labelGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 248, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(132, 210, 255)),
    }),
    labelGlowColor = Color3.fromRGB(86, 175, 255),
    hitRegions = {
        {position = Vector2.new(0.627, 0.703), size = Vector2.new(0.363, 0.283)},
    },
}
local v5 = {
    id = "loadout",
    name = "LOADOUT",
    anchor = Vector3.new(-199, 78, 221),
    yaw = 0,
    labelPosition = Vector2.new(0.565, 0.81),
    labelGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 239, 234)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 159, 143)),
    }),
    labelGlowColor = Color3.fromRGB(255, 107, 95),
    hitRegions = {
        {position = Vector2.new(0.503, 0.651), size = Vector2.new(0.124, 0.296)},
    },
}
local v6 = {
    id = "cargo",
    name = "CARGO",
    anchor = Vector3.new(-182, 61, 88),
    yaw = 0,
    labelPosition = Vector2.new(0.6, 0.45),
    labelGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(194, 219, 235)),
    }),
    labelGlowColor = Color3.fromRGB(147, 201, 237),
    hitRegions = {
        {position = Vector2.new(0.466, 0.26), size = Vector2.new(0.276, 0.39)},
    },
}
local v7 = {
    id = "shop",
    name = "SHOP",
    anchor = Vector3.new(-199.11300659179688, 74.2750015258789, 14.362000465393066),
    yaw = 0,
    labelPosition = Vector2.new(0.565, 0.185),
    labelGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(238, 255, 232)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(151, 255, 139)),
    }),
    labelGlowColor = Color3.fromRGB(91, 236, 102),
    hitRegions = {
        {position = Vector2.new(0.511, 0.058), size = Vector2.new(0.11, 0.205)},
    },
}
local v8 = {
    id = "training",
    name = "TRAINING",
    anchor = Vector3.new(-151.11300659179688, 74.2750015258789, 14.362000465393066),
    yaw = 0,
    labelPosition = Vector2.new(0.66, 0.214),
    labelGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 250, 229)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 218, 151)),
    }),
    labelGlowColor = Color3.fromRGB(255, 196, 113),
    hitRegions = {
        {position = Vector2.new(0.62, 0.01), size = Vector2.new(0.125, 0.25)},
    },
}
local v9 = {
    id = "trading",
    name = "TRADING HUB",
    anchor = Vector3.new(-18, 60, 90),
    yaw = 0,
    labelPosition = Vector2.new(0.82, 0.456),
    labelGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(228, 255, 252)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(116, 246, 238)),
    }),
    labelGlowColor = Color3.fromRGB(86, 229, 222),
    hitRegions = {
        {position = Vector2.new(0.78, 0.351), size = Vector2.new(0.182, 0.209)},
    },
}
v2[1] = v3
v2[2] = v4
v2[3] = v5
v2[4] = v6
v2[5] = v7
v2[6] = v8
v2[7] = v9
v1.Nodes = v2
return v1