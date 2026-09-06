local v1 = {
    Debug = false,
    Map = {Image = "rbxassetid://128754659205466", LabelGlowImage = "rbxassetid://76150694119616", AspectRatio = 1.7777777777777777},
}
local v2 = {}
local v3 = {
    id = "runway",
    name = "RUNWAY",
    anchor = Vector3.new(-279.99700927734375, 74.75, 88.88999938964844),
    yaw = 0,
    labelPosition = Vector2.new(0.24, 0.42),
}
local v4 = {}
local v5 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 251, 213))
v4[1] = v5
v4[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 221, 106))
v3.labelGradient = ColorSequence.new(v4)
v3.labelGlowColor = Color3.fromRGB(255, 206, 85)
v3.hitRegions = {
    {position = Vector2.new(0.018, 0.218), size = Vector2.new(0.447, 0.397)},
}
local v6 = {
    id = "range",
    name = "SHOOTING RANGE",
    anchor = Vector3.new(-151.11300659179688, 74.2750015258789, 164.86199951171875),
    yaw = 180,
    labelPosition = Vector2.new(0.82, 0.84),
}
v5 = {}
local v7 = ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 248, 255))
v5[1] = v7
v5[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(132, 210, 255))
v6.labelGradient = ColorSequence.new(v5)
v6.labelGlowColor = Color3.fromRGB(86, 175, 255)
v6.hitRegions = {
    {position = Vector2.new(0.627, 0.703), size = Vector2.new(0.363, 0.283)},
}
v4 = {
    id = "loadout",
    name = "LOADOUT",
    anchor = Vector3.new(-199, 78, 221),
    yaw = 0,
    labelPosition = Vector2.new(0.565, 0.81),
}
v7 = {}
local v8 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 239, 234))
v7[1] = v8
v7[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 159, 143))
v4.labelGradient = ColorSequence.new(v7)
v4.labelGlowColor = Color3.fromRGB(255, 107, 95)
v4.hitRegions = {
    {position = Vector2.new(0.503, 0.651), size = Vector2.new(0.124, 0.296)},
}
v5 = {
    id = "cargo",
    name = "CARGO",
    anchor = Vector3.new(-182, 61, 88),
    yaw = 0,
    labelPosition = Vector2.new(0.6, 0.45),
}
v8 = {}
local v9 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255))
v8[1] = v9
v8[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(194, 219, 235))
v5.labelGradient = ColorSequence.new(v8)
v5.labelGlowColor = Color3.fromRGB(147, 201, 237)
v5.hitRegions = {
    {position = Vector2.new(0.466, 0.26), size = Vector2.new(0.276, 0.39)},
}
v7 = {
    id = "shop",
    name = "SHOP",
    anchor = Vector3.new(-199.11300659179688, 74.2750015258789, 14.362000465393066),
    yaw = 0,
    labelPosition = Vector2.new(0.565, 0.185),
}
v9 = {}
local v10 = ColorSequenceKeypoint.new(0, Color3.fromRGB(238, 255, 232))
v9[1] = v10
v9[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(151, 255, 139))
v7.labelGradient = ColorSequence.new(v9)
v7.labelGlowColor = Color3.fromRGB(91, 236, 102)
v7.hitRegions = {
    {position = Vector2.new(0.511, 0.058), size = Vector2.new(0.11, 0.205)},
}
v8 = {
    id = "training",
    name = "TRAINING",
    anchor = Vector3.new(-151.11300659179688, 74.2750015258789, 14.362000465393066),
    yaw = 0,
    labelPosition = Vector2.new(0.66, 0.214),
}
v10 = {}
local v11 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 250, 229))
v10[1] = v11
v10[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 218, 151))
v8.labelGradient = ColorSequence.new(v10)
v8.labelGlowColor = Color3.fromRGB(255, 196, 113)
v8.hitRegions = {
    {position = Vector2.new(0.62, 0.01), size = Vector2.new(0.125, 0.25)},
}
v9 = {
    id = "trading",
    name = "TRADING HUB",
    anchor = Vector3.new(-18, 60, 90),
    yaw = 0,
    labelPosition = Vector2.new(0.82, 0.456),
}
v11 = {}
local v12 = ColorSequenceKeypoint.new(0, Color3.fromRGB(228, 255, 252))
v11[1] = v12
v11[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(116, 246, 238))
v9.labelGradient = ColorSequence.new(v11)
v9.labelGlowColor = Color3.fromRGB(86, 229, 222)
v9.hitRegions = {
    {position = Vector2.new(0.78, 0.351), size = Vector2.new(0.182, 0.209)},
}
v2[1] = v3
v2[2] = v6
v2[3] = v4
v2[4] = v5
v2[5] = v7
v2[6] = v8
v2[7] = v9
v1.Nodes = v2
return v1