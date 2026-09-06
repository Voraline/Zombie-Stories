local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local u22 = require("../../Theme")
local u25 = require("./QuestFrame")
local function defaultCategory(p1) -- Line: 43
    local v1 = ""
    local LayoutOrder = (1 / 0)
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if j.LayoutOrder < LayoutOrder then
            LayoutOrder = j.LayoutOrder
            v1 = i
        end
    end
    return v1
end
return function(p1) -- Line: 55 -- upvalues: Fusion (val), u22 (val), RunService (val), u25 (val), UIKit (val)
    local scope = p1.scope
    local QuestCategories = p1.QuestCategories
    local v1 = Fusion.peek(QuestCategories)
    local v2 = ""
    local LayoutOrder = (1 / 0)
    local v3 = v1
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        if j.LayoutOrder < LayoutOrder then
            LayoutOrder = j.LayoutOrder
            v2 = i
        end
    end
    local u24 = scope:Value(v2)
    local ReferenceSize = p1.ReferenceSize
    if not ReferenceSize then
        ReferenceSize = Vector2.new(1152, 640)
    end
    local AccentColor3 = p1.AccentColor3
    if not AccentColor3 then
        AccentColor3 = u22.Menu.Accent
    end
    local u44 = scope:Value(Vector2.new(0, 0))
    v2 = scope:Computed(function(p1) -- Line: 62 -- upvalues: u44 (val), ReferenceSize (val)
        local v1 = p1(u44)
        if v1.X <= 0 or v1.Y <= 0 then
            return 1
        end
        local v2 = v1.X * 0.9 / ReferenceSize.X
        local v3 = v1.Y * 0.9
        return (math.min(1, v2, v3 / ReferenceSize.Y))
    end)
    local u59 = scope:Computed(function(p1) -- Line: 70 -- upvalues: QuestCategories (val), u24 (val)
        local v1 = p1(QuestCategories)[p1(u24)]
        if not v1 then
            v1 = {}
        end
        return v1
    end)
    local u63 = scope:Computed(function(p1) -- Line: 74 -- upvalues: u59 (val)
        local List = p1(u59).List
        if not List then
            List = {}
        end
        return List
    end)
    local u67 = scope:Computed(function(p1) -- Line: 77 -- upvalues: u63 (val)
        local v1 = 0
        for i in p1(u63) do
            v1 = v1 + 1
        end
        return v1
    end)
    local u71 = scope:Computed(function(p1) -- Line: 84 -- upvalues: u59 (val)
        return p1(u59).NextReset or 0
    end)
    local u75 = scope:Value(0)
    local function updateResetTimer() -- Line: 89 -- upvalues: Fusion (upval), u71 (val), u75 (val)
        local v1 = Fusion.peek(u71)
        local v2 = math.max(0, v1 - os.time())
        u75:set(v2)
    end
    local v6 = Fusion.peek(u71)
    u75:set((math.max(0, v6 - os.time())))
    local u92 = os.time()
    local v7 = RunService.Heartbeat:Connect(function() -- Line: 96 -- upvalues: u92 (ref), Fusion (upval), u71 (val), u75 (val)
        local v1 = os.time()
        if v1 ~= u92 then
            u92 = v1
            local v2 = Fusion.peek(u71)
            local v3 = math.max(0, v2 - os.time())
            u75:set(v3)
        end
    end)
    table.insert(scope, v7)
    local v8 = scope:ForPairs(u63, function(p1, p2, p3, p4) -- Line: 105 -- upvalues: u25 (upval)
        return p3, u25({Quest = p1(p4), QuestKey = p3, scope = p2})
    end)
    v6 = scope:ForPairs(QuestCategories, function(p1, p2, p3, p4) -- Line: 112 -- upvalues: UIKit (upval), AccentColor3 (val), u24 (val), Fusion (upval), u71 (val), u75 (val)
        local v1 = p1(p4)
        return p3, UIKit.CategoryButton({
            scope = p2,
            Text = p3:upper(),
            Size = UDim2.new(1, 0, 0, 44),
            LayoutOrder = v1.LayoutOrder,
            AccentColor3 = AccentColor3,
            Selected = p2:Computed(function(p1) -- Line: 121 -- upvalues: u24 (upval), p3 (val)
                local v1 = p1(u24)
                local v2 = v1 == p3
                return v2
            end),
            OnClick = function() -- Line: 124 -- upvalues: u24 (upval), p3 (val), Fusion (upval), u71 (upval), u75 (upval)
                u24:set(p3)
                local v1 = Fusion.peek(u71)
                local v2 = math.max(0, v1 - os.time())
                u75:set(v2)
            end,
        })
    end)
    local Title = p1.Title
    if not Title then
        Title = scope:Computed(function(p1) -- Line: 131 -- upvalues: u24 (val)
            local v1 = p1(u24)
            return (v1 .. " QUESTS"):upper()
        end)
    end
    local v9 = scope:Computed(function(p1) -- Line: 134 -- upvalues: u75 (val)
        local v1 = p1(u75)
        local v2 = math.floor(v1 / 86400)
        local v3 = math.floor(v1 % 86400 / 3600)
        local v4 = math.floor(v1 % 3600 / 60)
        local v5 = v1 % 60
        if 0 < v2 then
            return string.format("RESETS IN %dd %02d:%02d:%02d", v2, v3, v4, v5)
        end
        return string.format("RESETS IN %02d:%02d:%02d", v3, v4, v5)
    end)
    local v10 = scope:New("Frame")
    local v11 = {Name = "Header", Size = UDim2.new(1, 0, 0, 52), BackgroundTransparency = 1, ZIndex = u22.ZIndex.Buttons}
    local Children = scope.Children
    local v12 = {}
    local v13 = scope:New("TextLabel")
    local v14 = {
        Name = "Title",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 14, 0.5, 0),
        Size = UDim2.new(0.56, 0, 0.46, 0),
        BackgroundTransparency = 1,
        Text = Title,
        Font = u22.Menu.Fonts.Title,
        TextColor3 = u22.Menu.Text,
        TextScaled = true,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = u22.ZIndex.Buttons,
    }
    local Children_2 = scope.Children
    local v15 = {}
    local v16 = scope:New("UIStroke")
    v16 = v16({Color = u22.Menu.HeaderStroke, Thickness = u22.Stroke.Medium})
    local v17 = scope:New("UIGradient")
    local v18 = {Color = u22.Menu.Shade, Rotation = u22.Menu.ShadeRotation}
    v15[1] = v16
    v15[2] = v17(v18)
    v14[Children_2] = v15
    v13 = v13(v14)
    v14 = scope:New("TextLabel")
    v14 = v14({
        Name = "Timer",
        BackgroundTransparency = 1,
        TextSize = 16,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -56, 0.5, 0),
        Size = UDim2.new(0.36, 0, 0, 22),
        Text = v9,
        Font = u22.Menu.Fonts.Header,
        TextColor3 = u22.Menu.TextMuted,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = u22.ZIndex.Buttons,
    })
    v15 = {
        scope = scope,
        Size = UDim2.fromOffset(36, 36),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        ZIndex = u22.ZIndex.Buttons,
        OnClick = p1.OnClickClose,
    }
    v16 = {}
    v17 = scope:New("UICorner")
    v16[1] = v17({CornerRadius = UDim.new(0, u22.Menu.CornerRadius)})
    v15.Children = v16
    local v19 = UIKit.CloseButton(v15)
    v15 = scope:New("Frame")
    v16 = {
        Name = "AccentLine",
        BorderSizePixel = 0,
        BackgroundColor3 = AccentColor3,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, 0),
        Size = UDim2.new(1, -24, 0, 2),
        ZIndex = u22.ZIndex.Buttons,
    }
    v12[1] = v13
    v12[2] = v14
    v12[3] = v19
    v12[4] = v15(v16)
    v11[Children] = v12
    v10 = v10(v11)
    v11 = scope:New("Frame")
    local v20 = {
        Name = "QuestsRoot",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Visible = scope:Computed(function(p1) -- Line: 215 -- upvalues: u44 (val)
            local v1 = p1(u44)
            local v2 = if 0 < v1.X then 0 < v1.Y else false
            return v2
        end),
        Parent = p1.Parent,
    }
    v20[scope.Out("AbsoluteSize")] = u44
    local Children_3 = scope.Children
    v13 = {}
    v14 = scope:New("Frame")
    v19 = {
        Name = "ReferenceBounds",
        Size = UDim2.fromOffset(ReferenceSize.X, ReferenceSize.Y),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
    }
    local Children_4 = scope.Children
    v16 = {}
    v17 = scope:New("UIScale")
    v17 = v17({Scale = v2})
    local v21 = {Name = "QuestsPanel", scope = scope, Size = UDim2.fromScale(1, 1)}
    local v22 = {}
    local v23 = scope:New("Frame")
    local v24 = {Name = "Body", Position = UDim2.fromOffset(0, 52), Size = UDim2.new(1, 0, 1, -52), BackgroundTransparency = 1}
    local Children_5 = scope.Children
    local v25 = {}
    local v26 = scope:New("UIPadding")
    v26 = v26({PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10)})
    local v27 = scope:New("UIListLayout")
    v27 = v27({FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder})
    local v28 = scope:New("Frame")
    local v29 = {Name = "Rail", Size = UDim2.new(0, 248, 1, 0), LayoutOrder = 1, BackgroundTransparency = 1}
    local Children_6 = scope.Children
    local v30 = {}
    local v31 = scope:New("UIListLayout")
    v31 = v31({Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder})
    v30[1] = v31
    v30[2] = v6
    v29[Children_6] = v30
    v28 = v28(v29)
    v29 = scope:New("Frame")
    local v32 = {Name = "QuestListContainer", Size = UDim2.new(1, -258, 1, 0), LayoutOrder = 2, BackgroundTransparency = 1}
    local Children_7 = scope.Children
    v31 = {}
    local v33 = UIKit.ScrollList({
        Name = "QuestList",
        scope = scope,
        Size = UDim2.fromScale(1, 1),
        Padding = UDim.new(0, 8),
        ContentPadding = u22.Menu.StrokeThickness,
        Scale = v2,
        Visible = scope:Computed(function(p1) -- Line: 285 -- upvalues: u67 (val)
            local v1 = p1(u67)
            local v2 = 0 < v1
            return v2
        end),
        Children = {v8},
    })
    local v34 = scope:New("TextLabel")
    local v35 = {
        Name = "EmptyState",
        BackgroundTransparency = 1,
        Text = "NO QUESTS AVAILABLE",
        TextSize = 18,
        Size = UDim2.fromScale(1, 1),
        Font = u22.Menu.Fonts.Header,
        TextColor3 = u22.Menu.TextMuted,
        Visible = scope:Computed(function(p1) -- Line: 298 -- upvalues: u67 (val)
            local v1 = p1(u67) == 0
            return v1
        end),
    }
    v31[1] = v33
    v31[2] = v34(v35)
    v32[Children_7] = v31
    v25[1] = v26
    v25[2] = v27
    v25[3] = v28
    v25[4] = v29(v32)
    v24[Children_5] = v25
    v22[1] = v10
    v22[2] = v23(v24)
    v21.Children = v22
    v16[1] = v17
    v16[2] = UIKit.Card(v21)
    v19[Children_4] = v16
    v13[1] = v14(v19)
    v20[Children_3] = v13
    return v11(v20)
end