local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local u13 = require("../Theme")
local u16 = require("./ScrollList")
local u20 = Vector2.new(404, 284)
local u24 = Vector2.new(36, 36)

local function shadeGradient(p1) -- Line: 60 -- upvalues: u13 (val)
    return p1:New("UIGradient")({Color = u13.Menu.Shade, Rotation = u13.Menu.ShadeRotation})
end

return function(p1) -- Line: 67 -- upvalues: u13 (val), OnEvent (val), peek (val), u20 (val), u24 (val), u16 (val)
    local Visible, v1
    local scope = p1.scope
    local Selected = p1.Selected
    if not Selected then
        local Default = p1.Default
        if not Default then
            Default = p1.Placeholder
            if not Default then
                Default = ""
            end
        end
        Selected = scope:Value(Default)
    end
    local u15 = scope:Value(false)
    local u19 = p1.RowHeight or 34
    local u21 = p1.MaxVisible or 5
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u13.ZIndex.Overlay
    end

    local function playSound() -- Line: 77 -- upvalues: p1 (val)
        if p1.ButtonSound then
            p1.ButtonSound:Play()
        end
    end

    local function optionButton(p1_2, p2, p3) -- Line: 84
        -- upvalues: u19 (val), u13 (upval), p1 (val), ZIndex (val), OnEvent (upval), Selected (val), u15 (val)
        local v1
        local v2 = p1_2:New("TextButton")
        local v3 = {
            Name = p2,
            Size = UDim2.new(1, 0, 0, u19),
            LayoutOrder = p3,
            AutoButtonColor = false,
            BackgroundColor3 = u13.Menu.PanelDeep,
            BackgroundTransparency = 0,
        }
        if not p1.DisplayName then
            v1 = p2
        else
            v1 = p1.DisplayName(p2)
        end
        v3.Text = v1
        v3.Font = u13.Menu.Fonts.Button
        v3.TextColor3 = u13.Menu.Text
        v3.TextScaled = true
        v3.ZIndex = ZIndex + 2
        local Activated = OnEvent("Activated")

        v3[Activated] = function() -- Line: 98 -- upvalues: p1 (upval), Selected (upval), p2 (val), u15 (upval)
            if p1.ButtonSound then
                p1.ButtonSound:Play()
            end
            local v1 = Selected
            local v2 = p2
            v1:set(v2)
            u15:set(false)
            if p1.OnChanged then
                p1.OnChanged(p2)
            end
        end

        local Children = p1_2.Children
        local v4 = {}
        local v5 = p1_2:New("UICorner")({CornerRadius = UDim.new(0, u13.Menu.CornerRadius)})
        local v6 = p1_2:New("UIGradient")({Color = u13.Menu.Shade, Rotation = u13.Menu.ShadeRotation})
        local v7 = p1_2:New("UIPadding")
        local v8 = {
            PaddingLeft = UDim.new(0, 6),
            PaddingRight = UDim.new(0, 6),
            PaddingTop = UDim.new(0, 4),
            PaddingBottom = UDim.new(0, 4),
        }
        v4[1] = v5
        v4[2] = v6
        v4[3] = v7(v8)
        v3[Children] = v4
        return v2(v3)
    end

    local Options = p1.Options
    local v2 = scope:ForPairs(Options, function(p1, p2, p3, p4) -- Line: 120 -- upvalues: optionButton (val)
        return p3, optionButton(p2, p4, p3)
    end)
    local v3 = scope:Computed(function(p1_2) -- Line: 124 -- upvalues: p1 (val), u21 (val), u19 (val)
        local v1 = p1
        local Options = v1.Options
        local v2 = #(p1_2(Options))
        v1 = math.max(v2, 1)
        local v3 = u21
        local v4 = math.min(v1, v3)
        return UDim2.new(1, 0, 0, v4 * (u19 + 4) + 8)
    end)
    local v4 = scope:Computed(function(p1) -- Line: 131 -- upvalues: u15 (val), u13 (upval)
        if p1(u15) then
            return u13.Menu.Accent
        end
        return u13.Menu.Border
    end)
    local v5 = scope:New("Frame")
    local v6 = {Name = p1.Name or "Dropdown"}
    local Size = p1.Size
    if not Size then
        Size = UDim2.new(1, 0, 0, u19)
    end
    v6.Size = Size
    local Position = p1.Position
    if not Position then
        Position = UDim2.fromScale(0, 0)
    end
    v6.Position = Position
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.new(0, 0)
    end
    v6.AnchorPoint = AnchorPoint
    v6.BackgroundTransparency = 1
    v6.LayoutOrder = p1.LayoutOrder or 0
    v6.ZIndex = ZIndex
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v6.Visible = Visible
    v6.Parent = p1.Parent
    local Children = scope.Children
    local v7 = {}
    local v8 = scope:New("TextButton")
    local v9 = {
        Name = "Header",
        Size = UDim2.fromScale(1, 1),
        AutoButtonColor = false,
        BackgroundColor3 = u13.Menu.Panel,
        BackgroundTransparency = 0,
        Text = "",
        ZIndex = ZIndex,
    }
    local Activated = OnEvent("Activated")

    v9[Activated] = function() -- Line: 157 -- upvalues: p1 (val), u15 (val), peek (upval)
        if p1.ButtonSound then
            p1.ButtonSound:Play()
        end
        local v1 = u15
        local v2 = peek
        local v3 = u15
        v2 = v2(v3)
        v1:set(not v2)
    end

    local Children_2 = scope.Children
    local v10 = {}
    local v11 = scope:New("UICorner")({CornerRadius = UDim.new(0, u13.Menu.CornerRadius)})
    local v12 = scope:New("UIStroke")({ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = v4, Thickness = u13.Menu.StrokeThickness})
    local v13 = scope:New("UIGradient")({Color = u13.Menu.Shade, Rotation = u13.Menu.ShadeRotation})
    local v14 = scope:New("TextLabel")
    local v15 = {
        Name = "Value",
        BackgroundTransparency = 1,
        TextScaled = true,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 10, 0.5, 0),
        Size = UDim2.new(1, -36, 0.7, 0),
    }
    if not p1.DisplayName then
        v1 = Selected
    else
        v1 = scope:Computed(function(p1_2) -- Line: 177 -- upvalues: p1 (val), Selected (val)
            return p1.DisplayName(p1_2(Selected))
        end)
    end
    v15.Text = v1
    v15.Font = u13.Menu.Fonts.Button
    v15.TextColor3 = u13.Menu.Text
    v15.TextXAlignment = Enum.TextXAlignment.Left
    v15.ZIndex = ZIndex + 1
    v14 = v14(v15)
    v15 = scope:New("ImageLabel")
    v1 = {
        Name = "Chevron",
        BackgroundTransparency = 1,
        Image = "rbxassetid://3926305904",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0),
        Size = UDim2.fromOffset(20, 20),
        ImageRectOffset = u20,
        ImageRectSize = u24,
        ImageColor3 = u13.Menu.Text,
        ZIndex = ZIndex + 1,
    }
    v10[1] = v11
    v10[2] = v12
    v10[3] = v13
    v10[4] = v14
    v10[5] = v15(v1)
    v9[Children_2] = v10
    v8 = v8(v9)
    v9 = scope:New("Frame")
    local v16 = {
        Name = "Popup",
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 1, 4),
        Size = v3,
        BackgroundColor3 = u13.Menu.PanelInset,
        BackgroundTransparency = 0,
        Visible = u15,
        ZIndex = ZIndex + 1,
    }
    local Children_3 = scope.Children
    v11 = {}
    v12 = scope:New("UICorner")({CornerRadius = UDim.new(0, u13.Menu.CornerRadius)})
    v13 = scope:New("UIStroke")({
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = u13.Menu.Accent,
        Thickness = u13.Menu.StrokeThickness,
    })
    v14 = scope:New("UIPadding")({
        PaddingTop = UDim.new(0, 4),
        PaddingBottom = UDim.new(0, 4),
        PaddingLeft = UDim.new(0, 4),
        PaddingRight = UDim.new(0, 4),
    })
    v15 = u16
    v1 = {
        scope = scope,
        Size = UDim2.fromScale(1, 1),
        Padding = UDim.new(0, 4),
        ZIndex = ZIndex + 2,
        Children = v2,
    }
    v11[1] = v12
    v11[2] = v13
    v11[3] = v14
    v11[4] = v15(v1)
    v16[Children_3] = v11
    v7[1] = v8
    v7[2] = v9(v16)
    v6[Children] = v7
    return v5(v6)
end