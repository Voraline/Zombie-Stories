local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local v1 = require("../../Data/PlayerDatabase")
local v2 = require("@game/ReplicatedStorage/common/skillTree/SkillTreeData")
local SP_XP_PER_SP = (require("@game/ReplicatedStorage/common/skillTree/config/EconomyConfig")).SP_XP_PER_SP
local u31 = UDim2.new(0, -280, 0.45, 0)
local u37 = UDim2.new(0, 16, 0.45, 0)
local v3 = Color3.fromRGB(20, 20, 30)
local v4 = Color3.fromRGB(40, 40, 50)
local v5 = Color3.fromRGB(38, 175, 255)
local v6 = Color3.fromRGB(180, 180, 200)
local v7 = Color3.fromRGB(38, 175, 255)
local v8 = Color3.fromRGB(100, 210, 255)
local v9 = Color3.fromRGB(255, 200, 100)
local v10 = Fusion.scoped(Fusion)
local u76 = {}
local u77 = false
local v11 = ("0 / %*"):format(SP_XP_PER_SP)
local u85 = v10:Value(v11)
local u89 = v10:Value(0)
local u93 = v10:Value("")
local u97 = v10:Value(false)
local u101 = v10:Value("")
local u105 = v10:Value(false)
local u111 = v10:Spring(u89, 20, 1)
local v12 = v10:New("Frame")
local v13 = {
    Name = "SkillXPPopup",
    Size = UDim2.new(0, 250, 0, 76),
    Position = u31,
    AnchorPoint = Vector2.new(0, 0.5),
    BackgroundColor3 = v3,
    BackgroundTransparency = 0.15,
    BorderSizePixel = 0,
}
local v14 = {}
local v15 = v10:New("UICorner")({CornerRadius = UDim.new(0, 8)})
local v16 = v10:New("UIPadding")({
    PaddingTop = UDim.new(0, 8),
    PaddingBottom = UDim.new(0, 8),
    PaddingLeft = UDim.new(0, 12),
    PaddingRight = UDim.new(0, 12),
})
local v17 = v10:New("Frame")
local v18 = {
    Name = "HeaderRow",
    Size = UDim2.new(1, 0, 0, 16),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundTransparency = 1,
}
local v19 = {}
local v20 = v10:New("TextLabel")({
    Name = "Header",
    BackgroundTransparency = 1,
    Text = "SKILL XP",
    TextSize = 12,
    Size = UDim2.new(0.5, 0, 1, 0),
    Font = Enum.Font.GothamBold,
    TextColor3 = v6,
    TextXAlignment = Enum.TextXAlignment.Left,
})
local v21 = v10:New("TextLabel")
local v22 = {
    Name = "GainLabel",
    BackgroundTransparency = 1,
    TextSize = 12,
    Size = UDim2.new(0.5, 0, 1, 0),
    Position = UDim2.new(0.5, 0, 0, 0),
    Font = Enum.Font.GothamBold,
    Text = u93,
    TextColor3 = v8,
    TextXAlignment = Enum.TextXAlignment.Right,
    Visible = u97,
}
v19[1] = v20
v19[2] = v21(v22)
v18[Children] = v19
v17 = v17(v18)
v18 = v10:New("TextLabel")({
    Name = "Counter",
    BackgroundTransparency = 1,
    TextSize = 16,
    Size = UDim2.new(1, 0, 0, 18),
    Position = UDim2.new(0, 0, 0, 18),
    Font = Enum.Font.GothamBold,
    Text = u85,
    TextColor3 = v7,
    TextXAlignment = Enum.TextXAlignment.Left,
})
v19 = v10:New("Frame")
v20 = {
    Name = "BarBG",
    Size = UDim2.new(1, 0, 0, 8),
    Position = UDim2.new(0, 0, 0, 40),
    BackgroundColor3 = v4,
    BorderSizePixel = 0,
}
v21 = {}
v22 = v10:New("UICorner")({CornerRadius = UDim.new(0.5, 0)})
local v23 = v10:New("Frame")
local v24 = {
    Name = "Fill",
    Size = v10:Computed(function(p1) -- Line: 139 -- upvalues: u111 (val)
        return UDim2.new(p1(u111), 0, 1, 0)
    end),
    BackgroundColor3 = v5,
    BorderSizePixel = 0,
}
v24[Children] = {v10:New("UICorner")({CornerRadius = UDim.new(0.5, 0)})}
v21[1] = v22
v21[2] = v23(v24)
v20[Children] = v21
v19 = v19(v20)
v20 = v10:New("TextLabel")
v21 = {
    Name = "SPLabel",
    BackgroundTransparency = 1,
    TextSize = 14,
    Size = UDim2.new(1, 0, 0, 16),
    Position = UDim2.new(0, 0, 0, 52),
    Font = Enum.Font.GothamBlack,
    Text = u101,
    TextColor3 = v9,
    TextXAlignment = Enum.TextXAlignment.Center,
    Visible = u105,
}
v14[1] = v15
v14[2] = v16
v14[3] = v17
v14[4] = v18
v14[5] = v19
v14[6] = v20(v21)
v13[Children] = v14
local u312 = v12(v13)
v13 = v10:New("ScreenGui")
v14 = {
    Parent = v1.PlayerGui,
    Name = "SkillXPPopupGui",
    DisplayOrder = 8,
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
}
v14[Children] = {u312}
v13(v14)

local function tweenPosition(p1, p2, p3) -- Line: 180 -- upvalues: TweenService (val), u312 (val)
    local v1 = TweenService
    local v2 = u312
    local v3 = TweenInfo.new(p2, Enum.EasingStyle.Quad, p3)
    local v4 = {Position = p1}
    v1 = v1:Create(v2, v3, v4)
    v1:Play()
    v1.Completed:Wait()
end

local function animateSegment(p1, p2, p3) -- Line: 192 -- upvalues: u85 (val), SP_XP_PER_SP (val), u89 (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = p1
    while v7 < p2 do
        v2 = v7 + p3
        v7 = math.min(v2, p2)
        v1 = u85
        v5 = math.floor(v7)
        v6 = SP_XP_PER_SP
        v3 = ("%* / %*"):format(v5, v6)
        v1:set(v3)
        v1 = u89
        v4 = SP_XP_PER_SP
        v3 = v7 / v4
        v1:set(v3)
        task.wait(0.03)
    end
end

local function animateXP(p1, p2, p3) -- Line: 206
    -- upvalues: SP_XP_PER_SP (val), animateSegment (val), u101 (val), u105 (val), u89 (val), u85 (val)
    local v1, v2, v3, v4, v5
    if not (0 < p3) then
        v4 = p2 - p1
    else
        v4 = SP_XP_PER_SP - p1 + p2 + (p3 - 1) * SP_XP_PER_SP
    end
    local v6 = v4 / 40
    local v7 = math.max(1, v6)
    if not (0 < p3) then
        animateSegment(p1, p2, v7)
        return
    end
    local v8 = p1
    v6 = p3
    local v9 = p3
    for i = 1, v6 do
        animateSegment(v8, SP_XP_PER_SP, v7)
        v5 = u101
        if v9 ~= 1 then
            v2 = ("+%* SP!"):format(i)
        else
            v2 = "+1 SP!"
        end
        v5:set(v2)
        u105:set(true)
        task.wait(0.6)
        u105:set(false)
        v8 = 0
        u89:set(0)
        v5 = u85
        v3 = SP_XP_PER_SP
        v2 = ("0 / %*"):format(v3)
        v5:set(v2)
    end
    if not (0 < v1) then
        return
    end
    animateSegment(0, v1, v7)
end

local function showPopup(p1, p2, p3, p4) -- Line: 249
    -- upvalues: SP_XP_PER_SP (val), u85 (val), u89 (val), u93 (val), u97 (val), u105 (val), tweenPosition (val)
    -- upvalues: u37 (val), animateXP (val), u31 (val)
    local v1
    local v2 = p4 - p3
    if not (0 < v2) then
        v1 = p2 - p1
    else
        v1 = SP_XP_PER_SP - p1 + p2 + (v2 - 1) * SP_XP_PER_SP
    end
    if v1 <= 0 then
        return
    end
    local v3 = u85
    local v4 = SP_XP_PER_SP
    local v5 = ("%* / %*"):format(p1, v4)
    v3:set(v5)
    v3 = u89
    local v6 = SP_XP_PER_SP
    v5 = p1 / v6
    v3:set(v5)
    v3 = u93
    v5 = ("+%* XP"):format(v1)
    v3:set(v5)
    u97:set(true)
    u105:set(false)
    tweenPosition(u37, 0.35, Enum.EasingDirection.Out)
    task.wait(0.2)
    animateXP(p1, p2, v2)
    task.wait(1.5)
    u97:set(false)
    u105:set(false)
    tweenPosition(u31, 0.3, Enum.EasingDirection.In)
end

local function processQueue() -- Line: 290 -- upvalues: u77 (ref), u76 (val), showPopup (val)
    local v1
    if u77 then
        return
    end
    u77 = true
    while true do
        if not (0 < #u76) then
            break
        end
        v1 = table.remove(u76, 1)
        showPopup(v1.oldXP, v1.newXP, v1.oldSP, v1.newSP)
        if 0 < #u76 then
            task.wait(0.3)
        end
    end
    u77 = false
end

v2.XPChanged:Connect(function(p1, p2, p3, p4) -- Line: 310 -- upvalues: u76 (val), processQueue (val)
    local v1 = u76
    local v2 = {oldXP = p1, newXP = p2, oldSP = p3, newSP = p4}
    table.insert(v1, v2)
    task.spawn(processQueue)
end)
return {}