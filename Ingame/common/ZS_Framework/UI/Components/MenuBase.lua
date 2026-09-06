local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("./GenericExitButton")
local u14 = require("./GenericButton")
local UISounds = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit.UISounds)
return function(p1) -- Line: 37 -- upvalues: u14 (val), u11 (val), UISounds (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    local scope = p1.scope
    local u7 = scope:usePx()(1)
    local u11 = scope:Computed(function(p1) -- Line: 43 -- upvalues: u7 (val)
        local v1 = p1(u7)
        return UDim.new(0, v1 * 8)
    end)
    local Width = 0
    local v10 = scope:New("Sound")
    local u18 = v10({SoundId = "rbxassetid://129190194679291", Volume = 0.5})
    local v11 = nil
    if p1.NavigationBar then
        local Children, v12, v13
        local u24 = scope:Computed(function(p1) -- Line: 61 -- upvalues: u7 (val)
            local v1 = p1(u7) * 2 * 2
            return UDim2.new(1, -v1, 0.125, -v1)
        end)
        v9 = scope:ForPairs(p1.NavigationBar.List, function(a1, p2, p3, p4) -- Line: 66 -- upvalues: p1 (val), u14 (upval), u24 (val), u18 (val), u11 (val)
            local u7 = p2:Computed(function(a1) -- Line: 67 -- upvalues: p1 (upval), p3 (val)
                local v1 = a1(p1.NavigationBar.Selected)
                local v2 = v1 == p3
                return v2
            end)
            local v1 = {
                BackgroundTransparency = 0,
                Text = "",
                TextScaled = true,
                scope = p2,
                Size = u24,
                LayoutOrder = p4.LayoutOrder,
                Font = Enum.Font.GothamBold,
                BackgroundColor3 = p2:Computed(function(p1) -- Line: 80 -- upvalues: u7 (val)
                    if p1(u7) then
                        return Color3.fromRGB(255, 255, 255)
                    end
                    return Color3.fromRGB(126, 126, 126)
                end),
                OnClick = function() -- Line: 88 -- upvalues: u18 (upval), p1 (upval), p3 (val)
                    u18:Play()
                    p1.NavigationBar.OnClick(p3)
                end,
            }
            local v2 = {}
            local v3 = p2:New("TextLabel")
            v3 = v3({
                BackgroundTransparency = 1,
                TextScaled = true,
                Text = p3:upper(),
                TextColor3 = p2:Computed(function(p1) -- Line: 96 -- upvalues: u7 (val)
                    if p1(u7) then
                        return Color3.fromRGB(255, 255, 255)
                    end
                    return Color3.fromRGB(172, 172, 172)
                end),
                Size = UDim2.new(0.85, 0, 0.8, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Font = Enum.Font.GothamBold,
            })
            local v4 = p2:New("UIGradient")
            local v5 = {Rotation = 90}
            local v6 = {}
            local v7 = ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 7, 112))
            v6[1] = v7
            v6[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 0, 70))
            v5.Color = ColorSequence.new(v6)
            v4 = v4(v5)
            v5 = p2:New("UICorner")
            v5 = v5({CornerRadius = u11})
            local v8 = p2:New("UIStroke")
            v6 = {}
            local v9 = p2:Computed(function(p1) -- Line: 121 -- upvalues: u7 (val)
                if p1(u7) then
                    return Color3.fromRGB(211, 211, 211)
                end
                return Color3.fromRGB(134, 134, 134)
            end)
            v6.Color = p2:Spring(v9, 30, 1)
            v6.Thickness = 2
            v6.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            local Children = p2.Children
            local v10 = {}
            v9 = p2:New("UIGradient")
            local v11 = {Rotation = 90}
            local v12 = {}
            local v13 = ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 7, 112))
            v12[1] = v13
            v12[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 0, 70))
            v11.Color = ColorSequence.new(v12)
            v10[1] = v9(v11)
            v6[Children] = v10
            v2[1] = v3
            v2[2] = v4
            v2[3] = v5
            v2[4] = v8(v6)
            v1.Children = v2
            return p3, u14(v1)
        end)
        v12 = scope:Computed(function(p1) -- Line: 145 -- upvalues: u7 (val)
            return UDim.new(0, p1(u7) * 2)
        end)
        Width = p1.NavigationBar.Width
        v1 = scope:New("Frame")
        v13 = {Size = UDim2.new(p1.NavigationBar.Width, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, LayoutOrder = 1}
        Children = scope.Children
        v3 = {}
        v4 = scope:New("UIPadding")
        v4 = v4({PaddingTop = v12, PaddingLeft = v12, PaddingRight = v12, PaddingBottom = v12})
        v5 = scope:New("UIListLayout")
        v5 = v5({
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = scope:Computed(function(p1) -- Line: 168 -- upvalues: u7 (val)
                local v1 = p1(u7)
                return UDim.new(0, v1 * 7.5 + p1(u7) * 2 * 4)
            end),
        })
        v3[1] = v4
        v3[2] = v5
        v3[3] = v9
        v13[Children] = v3
        v11 = v1(v13)
    end
    v8 = scope:New("Frame")
    v9 = {
        Parent = p1.Parent,
        Size = p1.Size,
        Position = p1.Position,
        AnchorPoint = p1.AnchorPoint,
        BackgroundTransparency = 1,
    }
    local Children_2 = scope.Children
    v1 = {}
    v2 = scope:New("UIAspectRatioConstraint")
    v2 = v2({AspectRatio = p1.AspectRatio})
    v3 = scope:New("UIListLayout")
    v3 = v3({})
    v4 = scope:New("Frame")
    v5 = {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), LayoutOrder = 2}
    local Children_3 = scope.Children
    local v14 = {}
    v6 = scope:New("UIListLayout")
    v6 = v6({FillDirection = Enum.FillDirection.Vertical, SortOrder = Enum.SortOrder.LayoutOrder, VerticalFlex = Enum.UIFlexAlignment.SpaceBetween})
    v7 = scope:New("Frame")
    local v15 = {Name = "TitleFrame", Size = scope:Computed(function(p1) -- Line: 208 -- upvalues: u7 (val)
        local v1 = p1(u7)
        return UDim2.new(1, 0, 0, v1 * 80)
    end), LayoutOrder = 1}
    local Children_4 = scope.Children
    local v16 = {}
    local v17 = {
        BackgroundTransparency = 0,
        scope = scope,
        OnClick = p1.OnClickClose,
        ButtonSound = UISounds.CloseSound,
        HoverSound = UISounds.HoverSound,
        Position = scope:Computed(function(p1) -- Line: 221 -- upvalues: u7 (val)
            local v1 = p1(u7)
            return UDim2.new(1, -v1 * 7.5, 0.5, 0)
        end),
        AnchorPoint = Vector2.new(1, 0.5),
        Size = scope:Computed(function(p1) -- Line: 226 -- upvalues: u7 (val)
            local v1 = p1(u7)
            return UDim2.new(0.1, 0, 1, -v1 * 7.5 * 2)
        end),
    }
    local v18 = {}
    local v19 = scope:New("UICorner")
    v18[1] = v19({CornerRadius = u11})
    v17.Children = v18
    local v20 = u11(v17)
    v17 = scope:New("TextLabel")
    v17 = v17({
        BackgroundTransparency = 1,
        TextScaled = true,
        Text = p1.Title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(0.45, 0, 0.75, 0),
        Position = UDim2.new(0.02, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBlack,
    })
    v18 = scope:New("UIGradient")
    v19 = {Rotation = 90}
    local v21 = {}
    local v22 = ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 7, 112))
    v21[1] = v22
    v21[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 0, 70))
    v19.Color = ColorSequence.new(v21)
    v18 = v18(v19)
    v19 = scope:New("UICorner")
    v16[1] = v20
    v16[2] = v17
    v16[3] = v18
    v16[4] = v19({CornerRadius = u11})
    v15[Children_4] = v16
    v7 = v7(v15)
    v15 = scope:New("Frame")
    local v23 = {Name = "BottomFrame", Size = scope:Computed(function(p1) -- Line: 262 -- upvalues: u7 (val)
        local v1 = p1(u7)
        return UDim2.new(1, 0, 1, -v1 * 90)
    end), LayoutOrder = 2, BackgroundTransparency = 1}
    local Children_5 = scope.Children
    v20 = {}
    v17 = scope:New("UIListLayout")
    v17 = v17({FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween})
    v19 = scope:New("Frame")
    local v24 = {Name = "ContentFrame", Size = scope:Computed(function(p1) -- Line: 278 -- upvalues: u7 (val), Width (ref)
        local v1 = p1(u7)
        local v2 = if Width ~= 0 then v1 * 7.5 else 0
        return UDim2.new(1 - Width, -v2, 1, 0)
    end), LayoutOrder = 2, BackgroundTransparency = 0}
    local Children_6 = scope.Children
    v22 = {}
    local ContentChildren = p1.ContentChildren
    local v25 = scope:New("UIGradient")
    local v26 = {Rotation = 90}
    local v27 = {}
    local v28 = ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 7, 112))
    v27[1] = v28
    v27[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 0, 70))
    v26.Color = ColorSequence.new(v27)
    v25 = v25(v26)
    v26 = scope:New("UICorner")
    v22[1] = ContentChildren
    v22[2] = v25
    v22[3] = v26({CornerRadius = u11})
    v24[Children_6] = v22
    v20[1] = v17
    v20[2] = v11
    v20[3] = v19(v24)
    v23[Children_5] = v20
    v14[1] = v6
    v14[2] = v7
    v14[3] = v15(v23)
    v5[Children_3] = v14
    v1[1] = u18
    v1[2] = v2
    v1[3] = v3
    v1[4] = v4(v5)
    v9[Children_2] = v1
    return v8(v9)
end