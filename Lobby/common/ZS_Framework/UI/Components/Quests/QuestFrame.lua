local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local u17 = require("../../Theme")
local u20 = require("./RewardFrame")
local u23 = require("./QuestUIComputed")
return function(p1) -- Line: 33 -- upvalues: u23 (val), u17 (val), UIKit (val), u20 (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = p1.scope:innerScope()
    v1, v2, v3, v4 = u23({scope = v7, Quest = p1.Quest})
    local v8 = v7:Computed(function(a1) -- Line: 39 -- upvalues: p1 (val)
        if a1(p1.Quest.IsCompleted) then
            return 0.25
        end
        return 0
    end)
    if not p1.Quest.IsCompleted then
        local Goal = p1.Quest.Progress.Goal
        if 0 >= Goal then
            v6 = 0
        else
            v6 = p1.Quest.Progress.Current / Goal * 100
        end
        v5 = -v6
    else
        v5 = 1000
    end
    if p1.Quest.IsBonus then
        v5 = v5 + 1
    end
    local v9 = v7:Computed(function(a1) -- Line: 55 -- upvalues: p1 (val)
        if a1(p1.Quest.IsCompleted) then
            return "COMPLETED"
        end
        return "BONUS"
    end)
    v6 = v7:Computed(function(a1) -- Line: 61 -- upvalues: p1 (val), u17 (upval)
        if a1(p1.Quest.IsCompleted) then
            return u17.Menu.Positive
        end
        return u17.Menu.Accent
    end)
    local v10 = {
        Name = "QuestFrame",
        scope = v7,
        Size = UDim2.new(1, 0, 0, 104),
        LayoutOrder = v5,
        Parent = p1.Parent,
        BackgroundColor3 = v3,
        BackgroundTransparency = v8,
        StrokeColor3 = v1,
        StrokeThickness = u17.Stroke.Medium,
    }
    local v11 = {}
    local v12 = v7:New("UIPadding")
    v12 = v12({PaddingTop = UDim.new(0, u17.Spacing.Small), PaddingBottom = UDim.new(0, u17.Spacing.Small), PaddingLeft = UDim.new(0, u17.Spacing.Small), PaddingRight = UDim.new(0, u17.Spacing.Small)})
    local v13 = v7:New("TextLabel")
    v13 = v13({
        Name = "Title",
        BackgroundTransparency = 1,
        TextSize = 18,
        Text = p1.Quest.Title,
        TextColor3 = v4,
        Font = u17.Menu.Fonts.Header,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        Size = UDim2.new(0.58, 0, 0, 22),
    })
    local v14 = v7:New("TextLabel")
    v14 = v14({
        Name = "Description",
        BackgroundTransparency = 1,
        TextSize = 14,
        TextWrapped = true,
        Text = p1.Quest.Description,
        TextColor3 = u17.Menu.TextMuted,
        Font = u17.Menu.Fonts.Body,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        Size = UDim2.new(0.58, 0, 0, 30),
        Position = UDim2.fromOffset(0, 24),
    })
    local v15 = UIKit.Badge({
        Name = "QuestState",
        scope = v7,
        Visible = v7:Computed(function(a1) -- Line: 111 -- upvalues: p1 (val)
            local v1 = a1(p1.Quest.IsCompleted)
            if not v1 then
                v1 = a1(p1.Quest.IsBonus or false)
            end
            return v1
        end),
        Size = UDim2.fromOffset(96, 20),
        Position = UDim2.new(0.58, -2, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = v6,
        ZIndex = u17.ZIndex.Overlay,
        Text = v9,
    })
    local v16 = v7:New("Frame")
    local v17 = {
        Name = "RewardFrame",
        Size = UDim2.new(0.37, 0, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
    }
    v17[v7.Children] = {u20({Size = UDim2.fromScale(1, 1), Rewards = p1.Quest.Rewards, scope = v7})}
    v16 = v16(v17)
    local v18 = {
        Name = "ProgressFrame",
        scope = v7,
        Size = UDim2.new(0.58, 0, 0, 24),
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1),
        Value = p1.Quest.Progress.Current,
        Max = p1.Quest.Progress.Goal,
        FillColor3 = v2,
        Text = p1.Quest.Progress.Current .. " / " .. p1.Quest.Progress.Goal,
    }
    v11[1] = v12
    v11[2] = v13
    v11[3] = v14
    v11[4] = v15
    v11[5] = v16
    v11[6] = UIKit.ProgressBar(v18)
    v10.Children = v11
    return UIKit.Card(v10)
end