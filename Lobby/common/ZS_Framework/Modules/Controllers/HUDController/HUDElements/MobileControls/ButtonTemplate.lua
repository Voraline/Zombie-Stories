local Fusion = require(game.ReplicatedStorage.Packages.Fusion)
local v1 = Fusion.scoped(Fusion)
local Children = Fusion.Children
local v2 = v1:New("ImageButton")
local v3 = {
    Name = "ButtonTemplate",
    Active = false,
    BackgroundTransparency = 1,
    BorderColor3 = Color3.fromRGB(27, 42, 53),
    Image = "rbxasset://textures/ui/TouchControlsSheet.png",
    ImageRectSize = Vector2.new(220, 220),
    Position = UDim2.new(0.5, -35, 0.5, -35),
    Selectable = false,
    Size = UDim2.fromOffset(70, 70),
}
local v4 = {}
local v5 = v1:New("TextLabel")({
    Name = "TextLabel",
    BackgroundTransparency = 1,
    Text = "AIM",
    TextScaled = true,
    TextSize = 14,
    TextStrokeTransparency = 0.8,
    TextWrapped = true,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BorderColor3 = Color3.fromRGB(27, 42, 53),
    FontFace = Font.new("rbxasset://fonts/families/Zekton.json"),
    Position = UDim2.fromScale(0.15, 0.307),
    Size = UDim2.fromScale(0.7, 0.386),
    TextColor3 = Color3.fromRGB(182, 182, 182),
})
local v6 = v1:New("ImageLabel")({
    Name = "ImageLabel",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BorderColor3 = Color3.fromRGB(27, 42, 53),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.7, 0.7),
})
local v7 = v1:New("UIScale")
v4[1] = v5
v4[2] = v6
v4[3] = v7({Name = "UIScale"})
v3[Children] = v4
return v2(v3)