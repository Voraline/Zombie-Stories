local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local v1 = require("../../Data/PlayerDatabase")
local v2 = require("@game/ReplicatedStorage/common/skillTree/SkillTreeData")
local v3 = require("@game/ReplicatedStorage/common/skillTree/config/EconomyConfig")
local v4 = {}
local SP_XP_PER_SP = v3.SP_XP_PER_SP
local u31 = UDim2.new(0, -280, 0.45, 0)
local u37 = UDim2.new(0, 16, 0.45, 0)
local v5 = Color3.fromRGB(20, 20, 30)
local v6 = Color3.fromRGB(40, 40, 50)
local v7 = Color3.fromRGB(38, 175, 255)
local v8 = Color3.fromRGB(180, 180, 200)
local v9 = Color3.fromRGB(38, 175, 255)
local v10 = Color3.fromRGB(100, 210, 255)
local v11 = Color3.fromRGB(255, 200, 100)
local v12 = Fusion.scoped(Fusion)
local u76 = {}
local u77 = false
local u85 = v12:Value((("0 / %*"):format(SP_XP_PER_SP)))
local u89 = v12:Value(0)
local u93 = v12:Value("")
local u97 = v12:Value(false)
local u101 = v12:Value("")
local u105 = v12:Value(false)
local u111 = v12:Spring(u89, 20, 1)
local v13 = v12:New("Frame")
local v14 = {
    Name = "SkillXPPopup",
    Size = UDim2.new(0, 250, 0, 76),
    Position = u31,
    AnchorPoint = Vector2.new(0, 0.5),
    BackgroundColor3 = v5,
    BackgroundTransparency = 0.15,
    BorderSizePixel = 0,
}
local v15 = {}
local v16 = v12:New("UICorner")
v16 = v16({CornerRadius = UDim.new(0, 8)})
local v17 = v12:New("UIPadding")
v17 = v17({PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)})
local v18 = v12:New("Frame")
local v19 = {Name = "HeaderRow", Size = UDim2.new(1, 0, 0, 16), Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}
local v20 = {}
local v21 = v12:New("TextLabel")
v21 = v21({
    Name = "Header",
    BackgroundTransparency = 1,
    Text = "SKILL XP",
    TextSize = 12,
    Size = UDim2.new(0.5, 0, 1, 0),
    Font = Enum.Font.GothamBold,
    TextColor3 = v8,
    TextXAlignment = Enum.TextXAlignment.Left,
})
local v22 = v12:New("TextLabel")
local v23 = {
    Name = "GainLabel",
    BackgroundTransparency = 1,
    TextSize = 12,
    Size = UDim2.new(0.5, 0, 1, 0),
    Position = UDim2.new(0.5, 0, 0, 0),
    Font = Enum.Font.GothamBold,
    Text = u93,
    TextColor3 = v10,
    TextXAlignment = Enum.TextXAlignment.Right,
    Visible = u97,
}
v20[1] = v21
v20[2] = v22(v23)
v19[Children] = v20
v18 = v18(v19)
v19 = v12:New("TextLabel")
v19 = v19({
    Name = "Counter",
    BackgroundTransparency = 1,
    TextSize = 16,
    Size = UDim2.new(1, 0, 0, 18),
    Position = UDim2.new(0, 0, 0, 18),
    Font = Enum.Font.GothamBold,
    Text = u85,
    TextColor3 = v9,
    TextXAlignment = Enum.TextXAlignment.Left,
})
v20 = v12:New("Frame")
v21 = {
    Name = "BarBG",
    Size = UDim2.new(1, 0, 0, 8),
    Position = UDim2.new(0, 0, 0, 40),
    BackgroundColor3 = v6,
    BorderSizePixel = 0,
}
v22 = {}
v23 = v12:New("UICorner")
v23 = v23({CornerRadius = UDim.new(0.5, 0)})
local v24 = v12:New("Frame")
local v25 = {Name = "Fill", Size = v12:Computed(function(p1) -- Line: 139 -- upvalues: u111 (val)
    local v1 = p1(u111)
    return UDim2.new(v1, 0, 1, 0)
end), BackgroundColor3 = v7, BorderSizePixel = 0}
local v26 = {}
local v27 = v12:New("UICorner")
v26[1] = v27({CornerRadius = UDim.new(0.5, 0)})
v25[Children] = v26
v22[1] = v23
v22[2] = v24(v25)
v21[Children] = v22
v20 = v20(v21)
v21 = v12:New("TextLabel")
v22 = {
    Name = "SPLabel",
    BackgroundTransparency = 1,
    TextSize = 14,
    Size = UDim2.new(1, 0, 0, 16),
    Position = UDim2.new(0, 0, 0, 52),
    Font = Enum.Font.GothamBlack,
    Text = u101,
    TextColor3 = v11,
    TextXAlignment = Enum.TextXAlignment.Center,
    Visible = u105,
}
v15[1] = v16
v15[2] = v17
v15[3] = v18
v15[4] = v19
v15[5] = v20
v15[6] = v21(v22)
v14[Children] = v15
local u312 = v13(v14)
v14 = v12:New("ScreenGui")
v15 = {
    Parent = v1.PlayerGui,
    Name = "SkillXPPopupGui",
    DisplayOrder = 8,
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
}
v15[Children] = {u312}
v14(v15)
local function tweenPosition(p1, p2, p3) -- Line: 180 -- upvalues: TweenService (val), u312 (val)
    local v1 = TweenInfo.new(p2, Enum.EasingStyle.Quad, p3)
    local v2 = TweenService:Create(u312, v1, {Position = p1})
    v2:Play()
    v2.Completed:Wait()
end
local function animateSegment(p1, p2, p3) -- Line: 192 -- upvalues: u85 (val), SP_XP_PER_SP (val), u89 (val)
    local v1
    local v2 = p1
    while v2 < p2 do
        v2 = math.min(v2 + p3, p2)
        v1 = math.floor(v2)
        u85:set((("%* / %*"):format(v1, SP_XP_PER_SP)))
        u89:set(v2 / SP_XP_PER_SP)
        task.wait(0.03)
    end
end
local function animateXP(p1, p2, p3) -- Line: 206 -- upvalues: SP_XP_PER_SP (val), animateSegment (val), u101 (val), u105 (val), u89 (val), u85 (val)
    local v1, v2, v3
    if 0 >= p3 then
        v3 = p2 - p1
    else
        v3 = SP_XP_PER_SP - p1 + p2 + (p3 - 1) * SP_XP_PER_SP
    end
    local v4 = math.max(1, v3 / 40)
    if 0 >= p3 then
        animateSegment(p1, p2, v4)
        return
    end
    local v5 = p1
    local v6 = p3
    local v7 = 1
    local v8 = p3
    for i = 1, v6, v7 do
        animateSegment(v5, SP_XP_PER_SP, v4)
        if v8 ~= 1 then
            v2 = ("+%* SP!"):format(i)
        else
            v2 = "+1 SP!"
        end
        u101:set(v2)
        u105:set(true)
        task.wait(0.6)
        u105:set(false)
        v5 = 0
        u89:set(0)
        u85:set((("0 / %*"):format(SP_XP_PER_SP)))
    end
    if 0 >= v1 then
        return
    end
    animateSegment(0, v1, v4)
end
local function showPopup(p1, p2, p3, p4) -- Line: 249 -- upvalues: SP_XP_PER_SP (val), u85 (val), u89 (val), u93 (val), u97 (val), u105 (val), tweenPosition (val), u37 (val), animateXP (val), u31 (val)
    local v1
    local v2 = p4 - p3
    if 0 >= v2 then
        v1 = p2 - p1
    else
        v1 = SP_XP_PER_SP - p1 + p2 + (v2 - 1) * SP_XP_PER_SP
    end
    if v1 <= 0 then
        return
    end
    u85:set((("%* / %*"):format(p1, SP_XP_PER_SP)))
    u89:set(p1 / SP_XP_PER_SP)
    u93:set((("+%* XP"):format(v1)))
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
    local v1, v2
    if u77 then
        return
    end
    u77 = true
    while true do
        v1 = #u76
        if 0 >= v1 then
            break
        end
        v1 = table.remove(u76, 1)
        showPopup(v1.oldXP, v1.newXP, v1.oldSP, v1.newSP)
        v2 = #u76
        if 0 < v2 then
            task.wait(0.3)
        end
    end
    u77 = false
end
v2.XPChanged:Connect(function(p1, p2, p3, p4) -- Line: 310 -- upvalues: u76 (val), processQueue (val)
    table.insert(u76, {oldXP = p1, newXP = p2, oldSP = p3, newSP = p4})
    task.spawn(processQueue)
end)
return v4