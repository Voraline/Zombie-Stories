local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("./GenericExitButton")
local u14 = require("./GenericButton")
local UISounds = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit.UISounds)
return function(p1) -- Line: 37 -- upvalues: u14 (val), u11 (val), UISounds (val)
    local v1, v2, v3, v4, v5
    local scope = p1.scope
    local u7 = scope:usePx()(1)
    local u11_2 = scope:Computed(function(p1) -- Line: 43 -- upvalues: u7 (val)
        local v1 = p1(u7)
        return UDim.new(0, v1 * 8)
    end)
    local Width = 0
    local u18 = scope:New("Sound")({SoundId = "rbxassetid://129190194679291", Volume = 0.5})
    local v6 = nil
    if p1.NavigationBar then
        local u24 = scope:Computed(function(p1) -- Line: 61 -- upvalues: u7 (val)
            local v1 = p1(u7) * 2 * 2
            return UDim2.new(1, -v1, 0.125, -v1)
        end)
        local List = p1.NavigationBar.List
        v5 = scope:ForPairs(List, function(p1_2, p2, p3, p4) -- Line: 66 -- upvalues: p1 (val), u14 (upval), u24 (val), u18 (val), u11_2 (val)
            local u7 = p2:Computed(function(p1_2) -- Line: 67 -- upvalues: p1 (upval), p3 (val)
                local v1 = (p1_2(p1.NavigationBar.Selected)) == p3
                return v1
            end)
            local v1 = u14
            local v2 = {
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
            local v3 = {}
            local v4 = p2:New("TextLabel")({
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
            local v5 = p2:New("UIGradient")({
                Rotation = 90,
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 7, 112)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 0, 70)),
                }),
            })
            local v6 = p2:New("UICorner")({CornerRadius = u11_2})
            local v7 = p2:New("UIStroke")
            local v8 = {}
            local v9 = p2:Computed(function(p1) -- Line: 121 -- upvalues: u7 (val)
                if p1(u7) then
                    return Color3.fromRGB(211, 211, 211)
                end
                return Color3.fromRGB(134, 134, 134)
            end)
            v8.Color = p2:Spring(v9, 30, 1)
            v8.Thickness = 2
            v8.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            local Children = p2.Children
            v8[Children] = {
                p2:New("UIGradient")({
                    Rotation = 90,
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 7, 112)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 0, 70)),
                    }),
                }),
            }
            v3[1] = v4
            v3[2] = v5
            v3[3] = v6
            v3[4] = v7(v8)
            v2.Children = v3
            return p3, v1(v2)
        end)
        local v7 = scope:Computed(function(p1) -- Line: 145 -- upvalues: u7 (val)
            return UDim.new(0, p1(u7) * 2)
        end)
        Width = p1.NavigationBar.Width
        v1 = scope:New("Frame")
        local v8 = {
            Size = UDim2.new(p1.NavigationBar.Width, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            LayoutOrder = 1,
        }
        local Children = scope.Children
        v2 = {}
        v3 = scope:New("UIPadding")({PaddingTop = v7, PaddingLeft = v7, PaddingRight = v7, PaddingBottom = v7})
        v4 = scope:New("UIListLayout")({
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = scope:Computed(function(p1) -- Line: 168 -- upvalues: u7 (val)
                local v1 = p1(u7)
                return UDim.new(0, v1 * 7.5 + p1(u7) * 2 * 4)
            end),
        })
        v2[1] = v3
        v2[2] = v4
        v2[3] = v5
        v8[Children] = v2
        v6 = v1(v8)
    end
    local v9 = scope:New("Frame")
    v5 = {
        Parent = p1.Parent,
        Size = p1.Size,
        Position = p1.Position,
        AnchorPoint = p1.AnchorPoint,
        BackgroundTransparency = 1,
    }
    local Children_2 = scope.Children
    v1 = {}
    local v10 = scope:New("UIAspectRatioConstraint")({AspectRatio = p1.AspectRatio})
    v2 = scope:New("UIListLayout")({})
    v3 = scope:New("Frame")
    v4 = {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), LayoutOrder = 2}
    local Children_3 = scope.Children
    local v11 = {}
    local v12 = scope:New("UIListLayout")({
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalFlex = Enum.UIFlexAlignment.SpaceBetween,
    })
    local v13 = scope:New("Frame")
    local v14 = {
        Name = "TitleFrame",
        Size = scope:Computed(function(p1) -- Line: 208 -- upvalues: u7 (val)
            local v1 = p1(u7)
            return UDim2.new(1, 0, 0, v1 * 80)
        end),
        LayoutOrder = 1,
    }
    local Children_4 = scope.Children
    local v15 = {}
    local v16 = u11
    v16 = v16({
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
        Children = {scope:New("UICorner")({CornerRadius = u11_2})},
    })
    local v17 = scope:New("TextLabel")({
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
    local v18 = scope:New("UIGradient")({
        Rotation = 90,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 7, 112)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 0, 70)),
        }),
    })
    local v19 = scope:New("UICorner")
    v15[1] = v16
    v15[2] = v17
    v15[3] = v18
    v15[4] = v19({CornerRadius = u11_2})
    v14[Children_4] = v15
    v13 = v13(v14)
    v14 = scope:New("Frame")
    local v20 = {
        Name = "BottomFrame",
        Size = scope:Computed(function(p1) -- Line: 262 -- upvalues: u7 (val)
            local v1 = p1(u7)
            return UDim2.new(1, 0, 1, -v1 * 90)
        end),
        LayoutOrder = 2,
        BackgroundTransparency = 1,
    }
    local Children_5 = scope.Children
    v16 = {}
    v17 = scope:New("UIListLayout")({
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
    })
    v19 = scope:New("Frame")
    local v21 = {
        Name = "ContentFrame",
        Size = scope:Computed(function(p1) -- Line: 278 -- upvalues: u7 (val), Width (ref)
            local v1 = p1(u7)
            local v2 = 0
            if Width ~= 0 then
                v2 = v1 * 7.5
            end
            return UDim2.new(1 - Width, -v2, 1, 0)
        end),
        LayoutOrder = 2,
        BackgroundTransparency = 0,
    }
    local Children_6 = scope.Children
    local v22 = {}
    local ContentChildren = p1.ContentChildren
    local v23 = scope:New("UIGradient")({
        Rotation = 90,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 7, 112)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 0, 70)),
        }),
    })
    local v24 = scope:New("UICorner")
    v22[1] = ContentChildren
    v22[2] = v23
    v22[3] = v24({CornerRadius = u11_2})
    v21[Children_6] = v22
    v16[1] = v17
    v16[2] = v6
    v16[3] = v19(v21)
    v20[Children_5] = v16
    v11[1] = v12
    v11[2] = v13
    v11[3] = v14(v20)
    v4[Children_3] = v11
    v1[1] = u18
    v1[2] = v10
    v1[3] = v2
    v1[4] = v3(v4)
    v5[Children_2] = v1
    v9 = v9(v5)
    return v9
end