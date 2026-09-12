local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.common.Assets.assets)
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local scoped = Fusion.scoped
local peek = Fusion.peek
local Children = Fusion.Children
require("@game/ReplicatedStorage/common/HUDService")
local v1 = require("@game/ReplicatedStorage/common/PlayerHandler")
local SkillTreeData = require(ReplicatedStorage.common.skillTree.SkillTreeData)
local assets_2 = require(ReplicatedStorage.common.Assets.assets)
local v2 = scoped(Fusion)
local u44 = v2:Value(false)
local u48 = v2:Value(0)
local LocalPlayer = Players.LocalPlayer
local u52 = v1:WaitForPlayerState(LocalPlayer)
local v3 = v2:Computed(function(p1) -- Line: 29 -- upvalues: u48 (val)
    return UDim2.fromScale(p1(u48), 1)
end)
local v4 = v2:New("ScreenGui")
local v5 = {
    Name = "SecondWindUI",
    Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Enabled = u44,
}
local v6 = {}
local v7 = v2:New("Frame")
local v8 = {
    Name = "SecondWindFrame",
    AnchorPoint = Vector2.new(0.5, 0),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Position = UDim2.fromScale(0.5, 0.55),
    Size = UDim2.fromScale(0.2, 0.1),
}
local v9 = {}
local v10 = v2:New("UIListLayout")({
    Name = "UIListLayout",
    FillDirection = Enum.FillDirection.Horizontal,
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Center,
})
local v11 = v2:New("Frame")
local v12 = {
    Name = "ProgressBar",
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.5,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    LayoutOrder = 1,
    Size = UDim2.new(0.6, 0, 0, 10),
}
local v13 = {}
local v14 = v2:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0, 3)})
local v15 = v2:New("Frame")
local v16 = {
    Name = "Fill",
    BackgroundColor3 = Color3.fromRGB(80, 159, 255),
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Size = v3,
}
v16[Children] = {v2:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0, 3)})}
v13[1] = v14
v13[2] = v15(v16)
v12[Children] = v13
v11 = v11(v12)
v12 = v2:New("Frame")
v13 = {
    Name = "ImageContainer",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Size = UDim2.fromScale(1, 1),
}
v14 = {}
v15 = v2:New("UIAspectRatioConstraint")({Name = "UIAspectRatioConstraint"})
v16 = v2:New("ImageLabel")
local v17 = {
    Name = "ImageLabel",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.9,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Image = assets_2.Images.SkillTree.secondWind,
    ImageColor3 = Color3.fromRGB(124, 224, 255),
    Position = UDim2.fromScale(0.5, 0.5),
    ScaleType = Enum.ScaleType.Fit,
    Size = UDim2.fromScale(0.8, 0.8),
}
v17[Children] = {v2:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(1, 0)})}
v14[1] = v15
v14[2] = v16(v17)
v13[Children] = v14
v9[1] = v10
v9[2] = v11
v9[3] = v12(v13)
v8[Children] = v9
v6[1] = v7(v8)
v5[Children] = v6
v4(v5)
local u260 = {IsShowing = false}

function u260.Show(p1) -- Line: 138 -- upvalues: u44 (val), u260 (val)
    u44:set(true)
    u260.IsShowing = true
end

function u260.Hide(p1) -- Line: 143 -- upvalues: u44 (val), u260 (val)
    u44:set(false)
    u260.IsShowing = false
end

local function updateUI() -- Line: 149
    -- upvalues: peek (val), SkillTreeData (val), u52 (val), u44 (val), u260 (val), u48 (val)
    local v1 = peek(SkillTreeData.HasSecondWind)
    local v2 = u52
    local IsDowned = v2.IsDowned
    local v3 = u52
    local SecondWindUsed = v3.SecondWindUsed
    local v4 = IsDowned and v1 and not SecondWindUsed
    u44:set(v4)
    u260.IsShowing = v4
    if v4 then
        local v5 = u52.SecondWindDamage or 0
        local v6 = u52
        local v7 = v5 / (v6.SecondWindMaxDamage or 100)
        v6 = math.clamp(v7, 0, 1)
        u48:set(v6)
    end
end

;(u52:GetPropertyChangedSignal("IsDowned")):Connect(updateUI)
;(u52:GetPropertyChangedSignal("SecondWindDamage")):Connect(updateUI)
;(u52:GetPropertyChangedSignal("SecondWindMaxDamage")):Connect(updateUI)
local HasSecondWind = SkillTreeData.HasSecondWind
;(v2:Observer(HasSecondWind)):onChange(updateUI)
updateUI()
return u260