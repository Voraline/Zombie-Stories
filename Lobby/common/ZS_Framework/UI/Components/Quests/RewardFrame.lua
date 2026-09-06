local v1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Packages.Fusion)
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local u22 = require("../../Theme")
local RewardsData = require(ReplicatedStorage.common.ZS_Shared.Data.RewardsData)
local u40 = nil
if RunService:IsClient() then
    local v2
    v1, v2 = pcall(require, ReplicatedStorage.common.skillTree.SkillTreeData)
    if v1 then
        u40 = v2
    end
end
local function getZBucksImage(p1, p2) -- Line: 31
    if p2.Tier3.Amount <= p1 then
        return p2.Tier3
    end
    if p2.Tier2.Amount <= p1 then
        return p2.Tier2
    end
    return p2.Tier1
end
return function(p1) -- Line: 41 -- upvalues: RewardsData (val), u40 (ref), u22 (val), UIKit (val)
    local v1 = p1.scope:innerScope()
    local v2 = v1:ForPairs(p1.Rewards, function(p1, p2, p3, p4) -- Line: 44 -- upvalues: RewardsData (upval), u40 (upval), u22 (upval)
        local v1, v2
        local Tier3 = RewardsData[p3]
        if p3 == "ZBucks" then
            local Amount = p4.Amount
            local v3 = Tier3
            if v3.Tier3.Amount <= Amount then
                Tier3 = v3.Tier3
            elseif v3.Tier2.Amount > Amount then
                Tier3 = v3.Tier1
            else
                Tier3 = v3.Tier2
            end
        end
        if p4.Type then
            Tier3 = Tier3[p4.Type]
        end
        local v4 = nil
        if p3 == "SP" and u40 and u40.AtSPCap then
            local v5 = p2:New("TextLabel")
            v1 = {
                Name = "SPCapX",
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Font = u22.Menu.Fonts.Header,
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromScale(0.8, 0.8),
                Text = "X",
                TextColor3 = u22.Colors.CloseButton,
                TextSize = 34,
                Visible = u40.AtSPCap,
                ZIndex = u22.ZIndex.Modal,
            }
            local Children = p2.Children
            local v6 = {}
            v2 = p2:New("UIStroke")
            v6[1] = v2({Thickness = u22.Stroke.Medium, Color = u22.Menu.HeaderStroke})
            v1[Children] = v6
            v4 = v5(v1)
        end
        v1 = p2:New("Frame")
        local v7 = {Size = UDim2.new(0.33, 0, 0.85, 0), BackgroundTransparency = 1, LayoutOrder = Tier3.LayoutOrder}
        local Children_2 = p2.Children
        v2 = {}
        local v8 = p2:New("ImageLabel")
        v8 = v8({BackgroundTransparency = 1, Image = Tier3.Image, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Fit})
        local v9 = p2:New("TextLabel")
        local v10 = {
            Text = Tier3.Text or "",
            TextColor3 = u22.Menu.Text,
            BackgroundTransparency = 1,
            Font = u22.Menu.Fonts.Header,
            TextSize = 14,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Left,
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, 0, 0.4 + (Tier3.TextOffset or 0), 0),
            Size = UDim2.new(1, 0, 0.4, 0),
            ZIndex = u22.ZIndex.Overlay,
            Rotation = Tier3.TextRotation or 0,
        }
        local Children_3 = p2.Children
        local v11 = {}
        local v12 = p2:New("UIStroke")
        v11[1] = v12({Thickness = u22.Stroke.Medium, Color = u22.Menu.HeaderStroke})
        v10[Children_3] = v11
        v9 = v9(v10)
        v10 = p2:New("TextLabel")
        local v13 = {
            Text = "+" .. p4.Amount,
            TextColor3 = u22.Menu.Accent,
            BackgroundTransparency = 1,
            Font = u22.Menu.Fonts.Header,
            TextSize = 16,
            TextXAlignment = Enum.TextXAlignment.Right,
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.fromScale(1, 1),
            Size = UDim2.new(1, 0, 0.4, 0),
            ZIndex = u22.ZIndex.Overlay,
        }
        local Children_4 = p2.Children
        v12 = {}
        local v14 = p2:New("UIStroke")
        v12[1] = v14({Thickness = u22.Stroke.Medium, Color = u22.Menu.HeaderStroke})
        v13[Children_4] = v12
        v2[1] = v8
        v2[2] = v4
        v2[3] = v9
        v2[4] = v10(v13)
        v7[Children_2] = v2
        return p3, v1(v7)
    end)
    local v3 = {
        Name = "RewardFrame",
        Shade = false,
        StrokeTransparency = 1,
        scope = v1,
        Size = p1.Size,
        Parent = p1.Parent,
        BackgroundColor3 = u22.Menu.PanelInset,
    }
    local v4 = {}
    local v5 = v1:New("UIListLayout")
    v5 = v5({
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    v4[1] = v5
    v4[2] = v2
    v3.Children = v4
    return UIKit.Card(v3)
end