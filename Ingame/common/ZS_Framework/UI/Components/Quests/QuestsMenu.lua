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
    local v6 = Vector2.new(0, 0)
    local u44 = scope:Value(v6)
    v2 = scope:Computed(function(p1) -- Line: 62 -- upvalues: u44 (val), ReferenceSize (val)
        local v1 = p1(u44)
        if not (v1.X <= 0) and not (v1.Y <= 0) then
            local v2 = v1.X * 0.9 / ReferenceSize.X
            local v3 = v1.Y * 0.9
            local v4 = ReferenceSize
            local v5 = v3 / v4.Y
            return (math.min(1, v2, v5))
        end
        return 1
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
        local v1 = (Fusion.peek(u71)) - (os.time())
        local v2 = math.max(0, v1)
        u75:set(v2)
    end

    local v7 = (Fusion.peek(u71)) - (os.time())
    local v8 = (math.max(0, v7))
    u75:set(v8)
    local u92 = os.time()
    local v9 = RunService
    v9 = v9.Heartbeat:Connect(function() -- Line: 96 -- upvalues: u92 (ref), Fusion (upval), u71 (val), u75 (val)
        local v1 = os.time()
        if v1 ~= u92 then
            u92 = v1
            local v2 = (Fusion.peek(u71)) - (os.time())
            local v3 = math.max(0, v2)
            u75:set(v3)
        end
    end)
    table.insert(scope, v9)
    v7 = scope:ForPairs(u63, function(p1, p2, p3, p4) -- Line: 105 -- upvalues: u25 (upval)
        local v1 = u25
        local v2 = {Quest = p1(p4), QuestKey = p3, scope = p2}
        return p3, v1(v2)
    end)
    v8 = scope:ForPairs(QuestCategories, function(p1, p2, p3, p4) -- Line: 112
        -- upvalues: UIKit (upval), AccentColor3 (val), u24 (val), Fusion (upval), u71 (val), u75 (val)
        local v1 = p1(p4)
        local v2 = UIKit
        local CategoryButton = v2.CategoryButton
        local v3 = {
            scope = p2,
            Text = p3:upper(),
            Size = UDim2.new(1, 0, 0, 44),
            LayoutOrder = v1.LayoutOrder,
            AccentColor3 = AccentColor3,
            Selected = p2:Computed(function(p1) -- Line: 121 -- upvalues: u24 (upval), p3 (val)
                local v1 = (p1(u24)) == p3
                return v1
            end),
            OnClick = function() -- Line: 124 -- upvalues: u24 (upval), p3 (val), Fusion (upval), u71 (upval), u75 (upval)
                local v1 = u24
                local v2 = p3
                v1:set(v2)
                v2 = (Fusion.peek(u71)) - (os.time())
                v1 = math.max(0, v2)
                u75:set(v1)
            end,
        }
        return p3, CategoryButton(v3)
    end)
    local Title = p1.Title
    if not Title then
        Title = scope:Computed(function(p1) -- Line: 131 -- upvalues: u24 (val)
            return ((p1(u24)) .. " QUESTS"):upper()
        end)
    end
    local v10 = scope:Computed(function(p1) -- Line: 134 -- upvalues: u75 (val)
        local v1 = p1(u75)
        local v2 = v1 / 86400
        local v3 = math.floor(v2)
        local v4 = v1 % 86400 / 3600
        v2 = math.floor(v4)
        local v5 = v1 % 3600 / 60
        v4 = math.floor(v5)
        v5 = v1 % 60
        if 0 < v3 then
            return string.format("RESETS IN %dd %02d:%02d:%02d", v3, v2, v4, v5)
        end
        return string.format("RESETS IN %02d:%02d:%02d", v2, v4, v5)
    end)
    local v11 = scope:New("Frame")
    local v12 = {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 52),
        BackgroundTransparency = 1,
        ZIndex = u22.ZIndex.Buttons,
    }
    local Children = scope.Children
    local v13 = {}
    local v14 = scope:New("TextLabel")
    local v15 = {
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
    local v16 = {}
    local v17 = scope:New("UIStroke")({Color = u22.Menu.HeaderStroke, Thickness = u22.Stroke.Medium})
    local v18 = scope:New("UIGradient")
    local v19 = {Color = u22.Menu.Shade, Rotation = u22.Menu.ShadeRotation}
    v16[1] = v17
    v16[2] = v18(v19)
    v15[Children_2] = v16
    v14 = v14(v15)
    v15 = scope:New("TextLabel")({
        Name = "Timer",
        BackgroundTransparency = 1,
        TextSize = 16,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -56, 0.5, 0),
        Size = UDim2.new(0.36, 0, 0, 22),
        Text = v10,
        Font = u22.Menu.Fonts.Header,
        TextColor3 = u22.Menu.TextMuted,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = u22.ZIndex.Buttons,
    })
    local v20 = UIKit
    v20 = v20.CloseButton({
        scope = scope,
        Size = UDim2.fromOffset(36, 36),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        ZIndex = u22.ZIndex.Buttons,
        OnClick = p1.OnClickClose,
        Children = {scope:New("UICorner")({CornerRadius = UDim.new(0, u22.Menu.CornerRadius)})},
    })
    v16 = scope:New("Frame")
    v17 = {
        Name = "AccentLine",
        BorderSizePixel = 0,
        BackgroundColor3 = AccentColor3,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, 0),
        Size = UDim2.new(1, -24, 0, 2),
        ZIndex = u22.ZIndex.Buttons,
    }
    v13[1] = v14
    v13[2] = v15
    v13[3] = v20
    v13[4] = v16(v17)
    v12[Children] = v13
    v11 = v11(v12)
    v12 = scope:New("Frame")
    local v21 = {
        Name = "QuestsRoot",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Visible = scope:Computed(function(p1) -- Line: 215 -- upvalues: u44 (val)
            local v1 = p1(u44)
            local v2 = false
            if 0 < v1.X then
                v2 = 0 < v1.Y
            end
            return v2
        end),
        Parent = p1.Parent,
    }
    v21[scope.Out("AbsoluteSize")] = u44
    local Children_3 = scope.Children
    v14 = {}
    v15 = scope:New("Frame")
    v20 = {
        Name = "ReferenceBounds",
        Size = UDim2.fromOffset(ReferenceSize.X, ReferenceSize.Y),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
    }
    local Children_4 = scope.Children
    v17 = {}
    v18 = scope:New("UIScale")({Scale = v2})
    v19 = UIKit
    local Card = v19.Card
    local v22 = {Name = "QuestsPanel", scope = scope, Size = UDim2.fromScale(1, 1)}
    local v23 = {}
    local v24 = scope:New("Frame")
    local v25 = {
        Name = "Body",
        Position = UDim2.fromOffset(0, 52),
        Size = UDim2.new(1, 0, 1, -52),
        BackgroundTransparency = 1,
    }
    local Children_5 = scope.Children
    local v26 = {}
    local v27 = scope:New("UIPadding")({
        PaddingTop = UDim.new(0, 6),
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
    })
    local v28 = scope:New("UIListLayout")({
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    local v29 = scope:New("Frame")
    local v30 = {Name = "Rail", Size = UDim2.new(0, 248, 1, 0), LayoutOrder = 1, BackgroundTransparency = 1}
    local Children_6 = scope.Children
    v30[Children_6] = {scope:New("UIListLayout")({Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}), v8}
    v29 = v29(v30)
    v30 = scope:New("Frame")
    local v31 = {
        Name = "QuestListContainer",
        Size = UDim2.new(1, -258, 1, 0),
        LayoutOrder = 2,
        BackgroundTransparency = 1,
    }
    local Children_7 = scope.Children
    local v32 = {}
    local v33 = UIKit
    v33 = v33.ScrollList({
        Name = "QuestList",
        scope = scope,
        Size = UDim2.fromScale(1, 1),
        Padding = UDim.new(0, 8),
        ContentPadding = u22.Menu.StrokeThickness,
        Scale = v2,
        Visible = scope:Computed(function(p1) -- Line: 285 -- upvalues: u67 (val)
            local v1 = 0 < (p1(u67))
            return v1
        end),
        Children = {v7},
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
    v32[1] = v33
    v32[2] = v34(v35)
    v31[Children_7] = v32
    v26[1] = v27
    v26[2] = v28
    v26[3] = v29
    v26[4] = v30(v31)
    v25[Children_5] = v26
    v23[1] = v11
    v23[2] = v24(v25)
    v22.Children = v23
    v17[1] = v18
    v17[2] = Card(v22)
    v20[Children_4] = v17
    v14[1] = v15(v20)
    v21[Children_3] = v14
    v12 = v12(v21)
    return v12
end