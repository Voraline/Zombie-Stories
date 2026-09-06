local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local u14 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u19 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HintSystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 10
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
local Frame = Instance.new("Frame")
Frame.Name = "Messages"
Frame.AnchorPoint = Vector2.new(0.5, 0)
Frame.BackgroundTransparency = 1
Frame.Position = UDim2.fromScale(0.5, 0.15)
Frame.Size = UDim2.fromScale(0.7, 0.18)
Frame.Parent = ScreenGui
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)
UIListLayout.Parent = Frame
local Sound = Instance.new("Sound")
Sound.Name = "Bleep"
Sound.SoundId = "rbxassetid://9125938067"
Sound.Parent = ScreenGui
local Sound_2 = Instance.new("Sound")
Sound_2.Name = "Error"
Sound_2.SoundId = "rbxassetid://97329712338974"
Sound_2.Parent = ScreenGui
local u69 = {}
local u70 = {}
local function createMessageFrame(p1) -- Line: 57 -- upvalues: Frame (val), TweenService (val), u14 (val)
    local Frame_2 = Instance.new("Frame")
    Frame_2.BackgroundTransparency = 1
    Frame_2.Size = UDim2.new(1, 0, 0, 30)
    Frame_2.AutomaticSize = Enum.AutomaticSize.Y
    local TextLabel = Instance.new("TextLabel")
    TextLabel.AnchorPoint = Vector2.new(0.5, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold)
    TextLabel.Position = UDim2.fromScale(0.5, 0)
    TextLabel.RichText = true
    TextLabel.Size = UDim2.fromScale(1, 1)
    TextLabel.Text = p1
    TextLabel.TextColor3 = Color3.fromRGB(245, 245, 245)
    TextLabel.TextScaled = true
    TextLabel.TextTransparency = 1
    TextLabel.Parent = Frame_2
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 2
    UIStroke.Transparency = 1
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    UIStroke.Thickness = 0.05
    UIStroke.Parent = TextLabel
    Frame_2.Parent = Frame
    TweenService:Create(TextLabel, u14, {TextTransparency = 0}):Play()
    TweenService:Create(UIStroke, u14, {Transparency = 0.7}):Play()
    return {count = 1, frame = Frame_2, label = TextLabel, stroke = UIStroke}
end
local function fadeOutAndDestroy(p1) -- Line: 98 -- upvalues: TweenService (val), u19 (val)
    if p1.timerThread then
        task.cancel(p1.timerThread)
        p1.timerThread = nil
    end
    TweenService:Create(p1.label, u19, {TextTransparency = 1}):Play()
    TweenService:Create(p1.stroke, u19, {Transparency = 1}):Play()
    task.delay(0.5, function() -- Line: 107 -- upvalues: p1 (val)
        p1.frame:Destroy()
    end)
end
local u73 = {}
function u73.Show(p1, p2, p3) -- Line: 115 -- upvalues: u69 (val), u73 (val), Sound (val), Sound_2 (val), createMessageFrame (val)
    local v1, v2, v3
    local v4 = p3 or 3
    if u69[p2] then
        local u7 = u69[p2]
        u7.count = u7.count + 1
        u7.label.Text = p2 .. " x" .. u7.count
        if u7.timerThread then
            task.cancel(u7.timerThread)
        end
        u7.timerThread = task.delay(v4, function() -- Line: 128 -- upvalues: u7 (val), u73 (upval), p2 (val)
            u7.timerThread = nil
            u73:_remove(p2)
        end)
        Sound:Play()
        return
    end
    local v5 = false
    for i, j, k in p2:gmatch("rgb%((%d+)%s*,%s*(%d+)%s*,%s*(%d+)%)") do
        v1 = tonumber(i)
        v2 = tonumber(j)
        v3 = tonumber(k)
        if v1 and v2 and v3 and 150 < v1 and v2 + 50 < v1 and v3 + 50 < v1 then
            v5 = true
            break
        end
    end
    if not v5 then
        local v6
        for n in p2:gmatch("#(%x%x%x%x%x%x)") do
            v1 = n:sub(1, 2)
            v6 = tonumber(v1, 16)
            v2 = n:sub(3, 4)
            v1 = tonumber(v2, 16)
            v3 = n:sub(5, 6)
            v2 = tonumber(v3, 16)
            if v6 and v1 and v2 and 150 < v6 and v1 + 50 < v6 and v2 + 50 < v6 then
                v5 = true
                break
            end
        end
    end
    if not v5 then
        Sound:Play()
    else
        Sound_2:Play()
    end
    local u119 = createMessageFrame(p2)
    u119.timerThread = task.delay(v4, function() -- Line: 166 -- upvalues: u119 (val), u73 (upval), p2 (val)
        u119.timerThread = nil
        u73:_remove(p2)
    end)
    u69[p2] = u119
end
function u73._remove(p1, p2) -- Line: 174 -- upvalues: u69 (val), fadeOutAndDestroy (val)
    local v1 = u69[p2]
    if not v1 then
        return
    end
    u69[p2] = nil
    fadeOutAndDestroy(v1)
end
function u73.ShowKeyed(p1, p2, p3, p4) -- Line: 187 -- upvalues: u70 (val), u73 (val), createMessageFrame (val)
    local v1 = p4 or 3
    if not (u70[p2]) then
        local u25 = createMessageFrame(p3)
        if 0 < v1 then
            u25.timerThread = task.delay(v1, function() -- Line: 213 -- upvalues: u25 (val), u73 (upval), p2 (val)
                u25.timerThread = nil
                u73:RemoveKeyed(p2)
            end)
        end
        u70[p2] = u25
        return
    end
    local u8 = u70[p2]
    u8.label.Text = p3
    if u8.timerThread then
        task.cancel(u8.timerThread)
    end
    if 0 < v1 then
        u8.timerThread = task.delay(v1, function() -- Line: 200 -- upvalues: u8 (val), u73 (upval), p2 (val)
            u8.timerThread = nil
            u73:RemoveKeyed(p2)
        end)
        return
    end
    u8.timerThread = nil
end
function u73.RemoveKeyed(p1, p2) -- Line: 222 -- upvalues: u70 (val), fadeOutAndDestroy (val)
    local v1 = u70[p2]
    if not v1 then
        return
    end
    u70[p2] = nil
    fadeOutAndDestroy(v1)
end
return u73