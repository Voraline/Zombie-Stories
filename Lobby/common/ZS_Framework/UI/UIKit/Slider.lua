local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local u18 = require("../Theme")

local function defaultFormat(p1) -- Line: 66
    local v1 = math.round(p1)
    local v2 = p1 - v1
    if (math.abs(v2)) < 1e-09 then
        return (tostring(v1))
    end
    return string.format("%.2f", p1)
end

return function(p1) -- Line: 76 -- upvalues: u18 (val), defaultFormat (val), peek (val), UserInputService (val), OnEvent (val)
    local ShowValue, Visible, v1, v2
    local scope = p1.scope
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u18.ZIndex.Content
    end
    local Min = p1.Min
    local Max = p1.Max
    local v3 = Max - Min
    local u12 = math.max(v3, 1e-09)
    local Format = p1.Format
    if not Format then
        Format = defaultFormat
    end
    local Value = p1.Value
    if not Value then
        v1 = p1.Default or Min
        v2 = math.clamp(v1, Min, Max)
        Value = scope:Value(v2)
    end
    local u38 = scope:Computed(function(p1) -- Line: 86 -- upvalues: Value (val), Min (val), u12 (val)
        local v1 = ((p1(Value)) - Min) / u12
        return (math.clamp(v1, 0, 1))
    end)
    v2 = scope:Computed(function(p1) -- Line: 89 -- upvalues: u38 (val)
        return UDim2.new(p1(u38), 0, 1, 0)
    end)
    v1 = scope:Computed(function(p1) -- Line: 92 -- upvalues: u38 (val)
        return UDim2.fromScale(p1(u38), 0.5)
    end)
    local v4 = scope:Computed(function(p1) -- Line: 95 -- upvalues: Format (val), Value (val)
        return Format(p1(Value))
    end)
    local u53 = nil
    local u54 = false

    local function applyFromX(p1_2, p2) -- Line: 107
        -- upvalues: u53 (ref), Min (val), u12 (val), p1 (val), Max (val), peek (upval), Value (val)
        local v1, v2
        if not u53 then
            return
        end
        local v3 = u53
        local X = v3.AbsoluteSize.X
        local v4 = math.max(X, 1)
        local v5 = (p1_2 - u53.AbsolutePosition.X) / v4
        v3 = math.clamp(v5, 0, 1)
        v5 = Min + v3 * u12
        if p1.Step and 0 < p1.Step then
            v1 = Min
            local v6 = v5 - Min
            local v7 = p1
            v2 = v6 / v7.Step
            v5 = v1 + (math.round(v2)) * p1.Step
        end
        local v8 = Min
        v2 = Max
        v1 = math.clamp(v5, v8, v2)
        if peek(Value) ~= v1 or p2 then
            Value:set(v1)
            if p1.OnChanged then
                p1.OnChanged(v1, p2)
            end
        end
    end

    local v5 = UserInputService
    v5 = v5.InputChanged:Connect(function(p1) -- Line: 126 -- upvalues: u54 (ref), applyFromX (val)
        if not u54 then
            return
        end
        if p1.UserInputType == Enum.UserInputType.MouseMovement or p1.UserInputType == Enum.UserInputType.Touch then
            applyFromX(p1.Position.X, false)
        end
    end)
    local v6 = UserInputService
    v6 = v6.InputEnded:Connect(function(p1) -- Line: 138 -- upvalues: u54 (ref), applyFromX (val)
        if not u54 then
            return
        end
        if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then
            u54 = false
            applyFromX(p1.Position.X, true)
        end
    end)
    table.insert(scope, v5)
    table.insert(scope, v6)
    local v7 = scope:New("Frame")
    local v8 = {
        Name = "Track",
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.new(1, 0, 0, 8),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.8,
        ZIndex = ZIndex + 1,
    }
    local Children = scope.Children
    local v9 = {}
    local v10 = scope:New("UICorner")({CornerRadius = UDim.new(1, 0)})
    local v11 = scope:New("Frame")
    local v12 = {Name = "Fill", Size = v2, BackgroundColor3 = u18.Menu.Accent, ZIndex = ZIndex + 1}
    local Children_2 = scope.Children
    v12[Children_2] = {scope:New("UICorner")({CornerRadius = UDim.new(1, 0)})}
    v11 = v11(v12)
    v12 = scope:New("Frame")
    local v13 = {
        Name = "Thumb",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = v1,
        Size = UDim2.fromOffset(18, 18),
        BackgroundColor3 = u18.Menu.Text,
        ZIndex = ZIndex + 2,
    }
    local Children_3 = scope.Children
    local v14 = {}
    local v15 = scope:New("UICorner")({CornerRadius = UDim.new(1, 0)})
    local v16 = scope:New("UIStroke")
    local v17 = {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = u18.Menu.Border,
        Thickness = u18.Menu.StrokeThickness,
    }
    v14[1] = v15
    v14[2] = v16(v17)
    v13[Children_3] = v14
    v12 = v12(v13)
    v13 = scope:New("TextButton")
    local v18 = {
        Name = "Hit",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, 12, 0, 28),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        ZIndex = ZIndex + 3,
    }
    local InputBegan = OnEvent("InputBegan")

    v18[InputBegan] = function(p1_2) -- Line: 205 -- upvalues: u54 (ref), p1 (val), applyFromX (val)
        if p1_2.UserInputType == Enum.UserInputType.MouseButton1
            or p1_2.UserInputType == Enum.UserInputType.Touch then
            u54 = true
            if p1.ButtonSound then
                p1.ButtonSound:Play()
            end
            applyFromX(p1_2.Position.X, false)
        end
    end

    v9[1] = v10
    v9[2] = v11
    v9[3] = v12
    v9[4] = v13(v18)
    v8[Children] = v9
    u53 = v7(v8)
    v7 = p1.Description ~= nil
    if p1.ShowValue ~= nil then
        ShowValue = p1.ShowValue
    else
        ShowValue = true
    end
    local v19 = scope:New("Frame")
    v9 = {}
    v9.Name = p1.Name or "Slider"
    local Size = p1.Size
    if not Size then
        local new = UDim2.new
        if not v7 then
            v18 = 56
        else
            v18 = 68
        end
        Size = new(1, 0, 0, v18)
    end
    v9.Size = Size
    local Position = p1.Position
    if not Position then
        Position = UDim2.fromScale(0, 0)
    end
    v9.Position = Position
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.new(0, 0)
    end
    v9.AnchorPoint = AnchorPoint
    v9.LayoutOrder = p1.LayoutOrder or 0
    v9.ZIndex = ZIndex
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v9.Visible = Visible
    v9.BackgroundColor3 = u18.Menu.Panel
    v9.BackgroundTransparency = 0
    v9.Parent = p1.Parent
    local Children_4 = scope.Children
    v11 = {}
    v12 = scope:New("UICorner")({CornerRadius = UDim.new(0, u18.Menu.CornerRadius)})
    v13 = scope:New("UIStroke")({
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = u18.Menu.Border,
        Thickness = u18.Menu.StrokeThickness,
    })
    v18 = scope:New("UIGradient")({Color = u18.Menu.Shade, Rotation = u18.Menu.ShadeRotation})
    v14 = scope:New("UIPadding")({
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
        PaddingTop = UDim.new(0, 6),
        PaddingBottom = UDim.new(0, 8),
    })
    v15 = scope:New("TextLabel")
    v16 = {
        Name = "Label",
        BackgroundTransparency = 1,
        TextScaled = true,
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.fromScale(0, 0),
        Size = UDim2.new(1, -64, 0, 18),
        Text = p1.Text or "",
        Font = u18.Menu.Fonts.Button,
        TextColor3 = u18.Menu.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = ZIndex + 1,
    }
    v15 = v15(v16)
    if not ShowValue then
        v16 = nil
    else
        v16 = scope:New("Frame")
        v17 = {
            Name = "ValueBox",
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.fromScale(1, 0),
            Size = UDim2.new(0, 60, 0, 20),
            BackgroundColor3 = u18.Menu.Text,
            BackgroundTransparency = 0.9,
            ZIndex = ZIndex + 1,
        }
        local Children_5 = scope.Children
        local v20 = {}
        local v21 = scope:New("UICorner")({CornerRadius = UDim.new(0.2, 0)})
        local v22 = scope:New("TextLabel")
        local v23 = {
            Name = "Value",
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Text = v4,
            Font = u18.Menu.Fonts.Button,
            TextColor3 = u18.Menu.Text,
            TextScaled = true,
            TextXAlignment = Enum.TextXAlignment.Center,
            ZIndex = ZIndex + 2,
        }
        local Children_6 = scope.Children
        v23[Children_6] = {scope:New("UIPadding")({PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5)})}
        v20[1] = v21
        v20[2] = v22(v23)
        v17[Children_5] = v20
        v16 = v16(v17)
    end
    if not v7 then
        v17 = nil
    else
        v17 = scope:New("TextLabel")({
            Name = "Description",
            BackgroundTransparency = 1,
            TextScaled = true,
            AnchorPoint = Vector2.new(0, 0),
            Position = UDim2.fromOffset(0, 20),
            Size = UDim2.new(1, -64, 0, 14),
            Text = p1.Description,
            Font = u18.Menu.Fonts.Body,
            TextColor3 = u18.Menu.TextMuted,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = ZIndex + 1,
        })
    end
    v11[1] = v12
    v11[2] = v13
    v11[3] = v18
    v11[4] = v14
    v11[5] = v15
    v11[6] = v16
    v11[7] = v17
    v11[8] = u53
    v9[Children_4] = v11
    v19 = v19(v9)
    return v19
end