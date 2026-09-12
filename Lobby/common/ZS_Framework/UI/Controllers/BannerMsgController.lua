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
local v5 = {Parent = v1.PlayerGui, DisplayOrder = 10}
v5[Children] = {u49}
v4(v5)
local u60 = {}
local u61 = {}
local v6 = {TextColor3 = Color3.fromRGB(255, 0, 0)}
u61[0] = v6
local v7 = {TextColor3 = Color3.fromRGB(23, 255, 54)}
u61[1] = v7
v7 = {TextColor3 = Color3.fromRGB(255, 255, 255)}
u61[2] = v7
local u81 = 0

local function createMessagePrompt(p1, p2, p3) -- Line: 47
    -- upvalues: u20 (val), u81 (ref), u60 (val), peek (val), u49 (val), u61 (val)
    local u6 = u20:innerScope()
    local u11 = u6:Value(1)
    local u15 = u6:Value(1)
    local v1 = u81
    local v2 = v1 + 1
    local u20_2 = u6:Value(v2)
    u81 = u81 + 1
    local u23 = nil
    u23 = {
        prompt = nil,
        index = u20_2,
        durationTask = task.delay(3, function() -- Line: 62 -- upvalues: u60 (upval), peek (upval), u23 (ref), u81 (upval), u11 (val), u15 (val), u6 (val)
            local v1
            local v2 = u60
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
            u60[u23] = nil
            u81 = u81 - 1
            u11:set(1)
            u15:set(1)
            task.wait(1)
            u6:doCleanup()
        end),
    }
    v2 = u6:New("TextLabel")
    v1 = {Parent = u49, Size = UDim2.new(1, 0, 0.275, 0)}
    local v3 = u6:Computed(function(p1) -- Line: 88 -- upvalues: u20_2 (val)
        return UDim2.new(0.5, 0, 0.1 + p1(u20_2) * 0.16, 0)
    end)
    v1.Position = u6:Spring(v3, 10, 1)
    v1.AnchorPoint = Vector2.new(0.5, 0)
    v1.BackgroundTransparency = 1
    v1.Text = string.upper(p1)
    v1.Font = Enum.Font.GothamBlack
    v1.TextScaled = true
    v1.TextColor3 = u61[p3].TextColor3
    v1.TextXAlignment = Enum.TextXAlignment.Center
    v1.TextStrokeTransparency = u6:Spring(u15, 10, 1)
    v1.TextTransparency = u6:Spring(u11, 10, 1)
    v1.TextStrokeColor3 = Color3.new(0, 0, 0)
    local Children = u6.Children
    v1[Children] = {
        u6:New("TextLabel")({
            BackgroundTransparency = 1,
            TextScaled = true,
            Size = UDim2.new(1, 0, 0.33, 0),
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 0),
            Text = string.upper(p2),
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextStrokeTransparency = u6:Spring(u15, 10, 1),
            TextTransparency = u6:Spring(u11, 10, 1),
            TextStrokeColor3 = Color3.new(0, 0, 0),
            TextColor3 = u61[p3].TextColor3,
        }),
    }
    v2 = v2(v1)
    u11:set(0)
    u15:set(0.5)
    local v4 = peek
    v4 = v4(u20_2)
    local v5 = v4 - 1
    u20_2:set(v5)
    u60[u23] = u23
end

v2.BannerMessage.On(function(p1) -- Line: 131 -- upvalues: createMessagePrompt (val)
    createMessagePrompt(p1.header, p1.message, p1.type)
end)
v1.Signals.BannerMessage:Connect(function(p1, p2, p3) -- Line: 135 -- upvalues: createMessagePrompt (val)
    createMessagePrompt(p1, p2, p3)
end)
return {}