local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Packages.Fusion)
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local u22 = require("../../Theme")
local RewardsData = require(ReplicatedStorage.common.ZS_Shared.Data.RewardsData)
local u40 = nil
if RunService:IsClient() then
    local success, result = pcall(require, ReplicatedStorage.common.skillTree.SkillTreeData)
    if success then
        u40 = result
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
    local Rewards = p1.Rewards
    local v2 = v1:ForPairs(Rewards, function(p1, p2, p3, p4) -- Line: 44 -- upvalues: RewardsData (upval), u40 (upval), u22 (upval)
        local v1, v2
        local Tier3 = RewardsData[p3]
        local LayoutOrder = Tier3.LayoutOrder
        if p3 == "ZBucks" then
            local Amount = p4.Amount
            v2 = Tier3
            if v2.Tier3.Amount <= Amount then
                Tier3 = v2.Tier3
            elseif not (v2.Tier2.Amount <= Amount) then
                Tier3 = v2.Tier1
            else
                Tier3 = v2.Tier2
            end
        end
        if p4.Type then
            Tier3 = Tier3[p4.Type]
        end
        local Image = Tier3.Image
        v2 = Tier3.Text or ""
        local v3 = Tier3.TextRotation or 0
        local v4 = Tier3.TextOffset or 0
        local v5 = nil
        if p3 == "SP" and u40 and u40.AtSPCap then
            local v6 = p2:New("TextLabel")
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
            v1[Children] = {p2:New("UIStroke")({Thickness = u22.Stroke.Medium, Color = u22.Menu.HeaderStroke})}
            v5 = v6(v1)
        end
        v1 = p2:New("Frame")
        local v7 = {Size = UDim2.new(0.33, 0, 0.85, 0), BackgroundTransparency = 1, LayoutOrder = LayoutOrder}
        local Children_2 = p2.Children
        local v8 = {}
        local v9 = p2:New("ImageLabel")({
            BackgroundTransparency = 1,
            Image = Image,
            Size = UDim2.fromScale(1, 1),
            ScaleType = Enum.ScaleType.Fit,
        })
        local v10 = p2:New("TextLabel")
        local v11 = {
            Text = v2,
            TextColor3 = u22.Menu.Text,
            BackgroundTransparency = 1,
            Font = u22.Menu.Fonts.Header,
            TextSize = 14,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Left,
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, 0, 0.4 + v4, 0),
            Size = UDim2.new(1, 0, 0.4, 0),
            ZIndex = u22.ZIndex.Overlay,
            Rotation = v3,
        }
        local Children_3 = p2.Children
        v11[Children_3] = {p2:New("UIStroke")({Thickness = u22.Stroke.Medium, Color = u22.Menu.HeaderStroke})}
        v10 = v10(v11)
        v11 = p2:New("TextLabel")
        local v12 = {
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
        v12[Children_4] = {p2:New("UIStroke")({Thickness = u22.Stroke.Medium, Color = u22.Menu.HeaderStroke})}
        v8[1] = v9
        v8[2] = v5
        v8[3] = v10
        v8[4] = v11(v12)
        v7[Children_2] = v8
        return p3, v1(v7)
    end)
    local v3 = UIKit
    return v3.Card({
        Name = "RewardFrame",
        Shade = false,
        StrokeTransparency = 1,
        scope = v1,
        Size = p1.Size,
        Parent = p1.Parent,
        BackgroundColor3 = u22.Menu.PanelInset,
        Children = {
            v1:New("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
                SortOrder = Enum.SortOrder.LayoutOrder,
            }),
            v2,
        },
    })
end