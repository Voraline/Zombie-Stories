local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local peek = Fusion.peek
local v1 = require("../../Data/PlayerDatabase")
local v2 = require("@game/ReplicatedStorage/common/zap")
local u20 = Fusion.scoped(Fusion)
local v3 = u20:New("Frame")
local v4 = {
    Size = UDim2.new(0.35, 0, 0.25, 0),
    Position = UDim2.new(0.5, 0, 0.15, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 1,
}
v4[Children] = {}
local u49 = v3(v4)
v4 = u20:New("ScreenGui")
local v5 = {Parent = v1.PlayerGui, DisplayOrder = 100, Name = "StatusMsg"}
v5[Children] = {u49}
v4(v5)
local u61 = {}
local u62 = {}
u62[0] = {TextColor3 = Color3.fromRGB(255, 0, 0)}
u62[1] = {TextColor3 = Color3.fromRGB(23, 255, 54)}
u62[2] = {TextColor3 = Color3.fromRGB(255, 255, 255)}
local u82 = 0
local function createMessagePrompt(p1, p2) -- Line: 48 -- upvalues: u20 (val), u82 (ref), u61 (val), peek (val), u49 (val), u62 (val)
    local u5 = u20:innerScope()
    local u10 = u5:Value(1)
    local u14 = u5:Value(1)
    local u19 = u5:Value(u82 + 1)
    u82 = u82 + 1
    local u22 = nil
    u22 = {prompt = nil, index = u19, durationTask = task.delay(3, function() -- Line: 63 -- upvalues: u61 (upval), peek (upval), u22 (ref), u82 (upval), u10 (val), u14 (val), u5 (val)
        local v1
        local v2 = u61
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            v1 = peek(j.index)
            if v1 ~= 0 then
                v1 = v1 - 1
            else
                v1 = v1 - 2
            end
            j.index:set(v1)
        end
        u61[u22] = nil
        u82 = u82 - 1
        u10:set(1)
        u14:set(1)
        task.wait(1)
        u5:doCleanup()
    end)}
    local v1 = u5:New("TextLabel")
    local v2 = {BackgroundTransparency = 1, TextScaled = true, Parent = u49, Size = UDim2.new(1, 0, 0.135, 0)}
    local v3 = u5:Computed(function(p1) -- Line: 89 -- upvalues: u19 (val)
        local v1 = 0.1 + p1(u19) * 0.16
        return UDim2.new(0.5, 0, v1, 0)
    end)
    v2.Position = u5:Spring(v3, 10, 1)
    v2.AnchorPoint = Vector2.new(0.5, 0)
    v2.Text = string.upper(p1)
    v2.Font = Enum.Font.GothamBold
    v2.TextColor3 = u62[p2].TextColor3
    v2.TextXAlignment = Enum.TextXAlignment.Center
    v2.TextStrokeTransparency = u5:Spring(u14, 10, 1)
    v2.TextTransparency = u5:Spring(u10, 10, 1)
    v2.TextStrokeColor3 = Color3.new(0, 0, 0)
    u10:set(0)
    u14:set(0.5)
    u19:set(peek(u19) - 1)
    u61[u22] = u22
end
v2.StatusMessage.On(function(p1) -- Line: 115 -- upvalues: createMessagePrompt (val)
    createMessagePrompt(p1.message, p1.type)
end)
v1.Signals.StatusMessage:Connect(function(p1, p2) -- Line: 119 -- upvalues: createMessagePrompt (val)
    createMessagePrompt(p1, p2)
end)
return {}