local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Packages.Fusion)
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local u22 = require("../../Theme")
local u25 = require("./RewardFrame")
local u28 = require("./QuestUIComputed")
local u31 = require("./ModifierIconRow")
return function(p1) -- Line: 47 -- upvalues: u28 (val), RunService (val), u22 (val), UIKit (val), u31 (val), u25 (val)
    local Modifiers, v1, v2, v3, v4
    local v5 = p1.scope:innerScope()
    local v6 = u28
    v6, v1, v2, v3 = v6({scope = v5, Quest = p1.Quest})
    local v7 = v5:Computed(function(p1_2) -- Line: 53 -- upvalues: p1 (val)
        if p1_2(p1.Quest.IsCompleted) then
            return 0.25
        end
        return 0
    end)
    if not p1.Quest.IsCompleted then
        local v8
        local Goal = p1.Quest.Progress.Goal
        if not (0 < Goal) then
            v8 = 0
        else
            v8 = p1.Quest.Progress.Current / Goal * 100
        end
        v4 = -v8
    else
        v4 = 1000
    end
    if p1.Quest.IsBonus then
        v4 = v4 + 1
    end
    local Props = p1.Quest.Props
    if not Props then
        Modifiers = nil
    else
        Modifiers = Props.Modifiers
    end
    local v9 = false
    if Modifiers ~= nil then
        v9 = RunService:IsClient()
    end
    local v10 = v5:Computed(function(p1_2) -- Line: 76 -- upvalues: p1 (val)
        if p1_2(p1.Quest.IsCompleted) then
            return "COMPLETED"
        end
        return "BONUS"
    end)
    local v11 = v5:Computed(function(p1_2) -- Line: 82 -- upvalues: p1 (val), u22 (upval)
        if p1_2(p1.Quest.IsCompleted) then
            return u22.Menu.Positive
        end
        return u22.Menu.Accent
    end)
    local Card = UIKit.Card
    local v12 = {
        Name = "QuestFrame",
        scope = v5,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = v4,
        Parent = p1.Parent,
        BackgroundColor3 = v2,
        BackgroundTransparency = v7,
        StrokeColor3 = v6,
        StrokeThickness = u22.Stroke.Medium,
    }
    local v13 = {}
    local v14 = v5:New("UIPadding")({
        PaddingTop = UDim.new(0, u22.Spacing.Small),
        PaddingBottom = UDim.new(0, u22.Spacing.Small),
        PaddingLeft = UDim.new(0, u22.Spacing.Small),
        PaddingRight = UDim.new(0, u22.Spacing.Small),
    })
    local v15 = v5:New("Frame")
    local v16 = {
        Name = "Info",
        Size = UDim2.new(0.58, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    }
    local Children = v5.Children
    local v17 = {}
    local v18 = v5:New("UIListLayout")({SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4)})
    local v19 = v5:New("TextLabel")
    local v20 = {
        Name = "Title",
        LayoutOrder = 1,
        BackgroundTransparency = 1,
        TextSize = 18,
        Text = p1.Quest.Title,
        TextColor3 = v3,
        Font = u22.Menu.Fonts.Header,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        Size = UDim2.new(1, 0, 0, 24),
    }
    v19 = v19(v20)
    if not v9 then
        v20 = v5:New("TextLabel")({
            Name = "Description",
            LayoutOrder = 2,
            BackgroundTransparency = 1,
            TextSize = 14,
            TextWrapped = true,
            Text = p1.Quest.Description,
            TextColor3 = u22.Menu.TextMuted,
            Font = u22.Menu.Fonts.Body,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            Size = UDim2.new(1, 0, 0, 32),
            AutomaticSize = Enum.AutomaticSize.Y,
        })
    else
        v20 = u31
        v20 = v20({LayoutOrder = 2, scope = v5, Modifiers = Modifiers, Size = UDim2.new(1, 0, 0, 32)})
    end
    local v21 = UIKit
    local ProgressBar = v21.ProgressBar
    local v22 = {
        Name = "ProgressFrame",
        LayoutOrder = 3,
        scope = v5,
        Size = UDim2.new(1, 0, 0, 24),
        Value = p1.Quest.Progress.Current,
        Max = p1.Quest.Progress.Goal,
        FillColor3 = v1,
        Text = p1.Quest.Progress.Current .. " / " .. p1.Quest.Progress.Goal,
    }
    v17[1] = v18
    v17[2] = v19
    v17[3] = v20
    v17[4] = ProgressBar(v22)
    v16[Children] = v17
    v15 = v15(v16)
    v16 = UIKit
    v16 = v16.Badge({
        Name = "QuestState",
        scope = v5,
        Visible = v5:Computed(function(p1_2) -- Line: 167 -- upvalues: p1 (val)
            local v1 = p1_2(p1.Quest.IsCompleted)
            if not v1 then
                v1 = p1_2(p1.Quest.IsBonus or false)
            end
            return v1
        end),
        Size = UDim2.fromOffset(96, 20),
        Position = UDim2.new(0.58, -2, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = v11,
        ZIndex = u22.ZIndex.Overlay,
        Text = v10,
    })
    local v23 = v5:New("Frame")
    v17 = {
        Name = "RewardFrame",
        Size = UDim2.new(0.37, 0, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
    }
    local Children_2 = v5.Children
    v19 = {}
    v20 = u25
    v19[1] = v20({Size = UDim2.fromScale(1, 1), Rewards = p1.Quest.Rewards, scope = v5})
    v17[Children_2] = v19
    v13[1] = v14
    v13[2] = v15
    v13[3] = v16
    v13[4] = v23(v17)
    v12.Children = v13
    return Card(v12)
end