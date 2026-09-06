local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local u18 = require("../Theme")
local function defaultFormat(p1) -- Line: 66
    local v1 = math.round(p1)
    local v2 = math.abs(p1 - v1)
    if v2 < 1e-09 then
        return (tostring(v1))
    end
    return string.format("%.2f", p1)
end
return function(p1) -- Line: 76 -- upvalues: u18 (val), defaultFormat (val), peek (val), UserInputService (val), OnEvent (val)
    local ShowValue, Visible, v1
    local scope = p1.scope
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u18.ZIndex.Content
    end
    local Min = p1.Min
    local Max = p1.Max
    local u12 = math.max(Max - Min, 1e-09)
    local Format = p1.Format
    if not Format then
        Format = defaultFormat
    end
    local Value = p1.Value
    if not Value then
        v1 = p1.Default or Min
        Value = scope:Value((math.clamp(v1, Min, Max)))
    end
    local u38 = scope:Computed(function(p1) -- Line: 86 -- upvalues: Value (val), Min (val), u12 (val)
        local v1 = p1(Value)
        local v2 = (v1 - Min) / u12
        return (math.clamp(v2, 0, 1))
    end)
    local v2 = scope:Computed(function(p1) -- Line: 89 -- upvalues: u38 (val)
        local v1 = p1(u38)
        return UDim2.new(v1, 0, 1, 0)
    end)
    v1 = scope:Computed(function(p1) -- Line: 92 -- upvalues: u38 (val)
        local v1 = p1(u38)
        return UDim2.fromScale(v1, 0.5)
    end)
    local v3 = scope:Computed(function(p1) -- Line: 95 -- upvalues: Format (val), Value (val)
        return Format(p1(Value))
    end)
    local u53 = nil
    local u54 = false
    local function applyFromX(a1, p2) -- Line: 107 -- upvalues: u53 (ref), Min (val), u12 (val), p1 (val), Max (val), peek (upval), Value (val)
        if not u53 then
            return
        end
        local v1 = (a1 - u53.AbsolutePosition.X) / math.max(u53.AbsoluteSize.X, 1)
        local v2 = math.clamp(v1, 0, 1)
        v1 = Min + v2 * u12
        if p1.Step and 0 < p1.Step then
            local v3 = math.round((v1 - Min) / p1.Step)
            v1 = Min + v3 * p1.Step
        end
        local v4 = math.clamp(v1, Min, Max)
        if peek(Value) ~= v4 then
            Value:set(v4)
            if p1.OnChanged then
                p1.OnChanged(v4, p2)
            end
        elseif p2 then
            Value:set(v4)
            if p1.OnChanged then
                p1.OnChanged(v4, p2)
            end
        end
    end
    local v4 = UserInputService.InputChanged:Connect(function(p1) -- Line: 126 -- upvalues: u54 (ref), applyFromX (val)
        if not u54 then
            return
        end
        if p1.UserInputType == Enum.UserInputType.MouseMovement then
            applyFromX(p1.Position.X, false)
        elseif p1.UserInputType == Enum.UserInputType.Touch then
            applyFromX(p1.Position.X, false)
        end
    end)
    local v5 = UserInputService.InputEnded:Connect(function(p1) -- Line: 138 -- upvalues: u54 (ref), applyFromX (val)
        if not u54 then
            return
        end
        if p1.UserInputType == Enum.UserInputType.MouseButton1 then
            u54 = false
            applyFromX(p1.Position.X, true)
        elseif p1.UserInputType == Enum.UserInputType.Touch then
            u54 = false
            applyFromX(p1.Position.X, true)
        end
    end)
    table.insert(scope, v4)
    table.insert(scope, v5)
    local v6 = scope:New("Frame")
    local v7 = {
        Name = "Track",
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.new(1, 0, 0, 8),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.8,
        ZIndex = ZIndex + 1,
    }
    local Children = scope.Children
    local v8 = {}
    local v9 = scope:New("UICorner")
    v9 = v9({CornerRadius = UDim.new(1, 0)})
    local v10 = scope:New("Frame")
    local v11 = {Name = "Fill", Size = v2, BackgroundColor3 = u18.Menu.Accent, ZIndex = ZIndex + 1}
    local Children_2 = scope.Children
    local v12 = {}
    local v13 = scope:New("UICorner")
    v12[1] = v13({CornerRadius = UDim.new(1, 0)})
    v11[Children_2] = v12
    v10 = v10(v11)
    v11 = scope:New("Frame")
    local v14 = {
        Name = "Thumb",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = v1,
        Size = UDim2.fromOffset(18, 18),
        BackgroundColor3 = u18.Menu.Text,
        ZIndex = ZIndex + 2,
    }
    local Children_3 = scope.Children
    v13 = {}
    local v15 = scope:New("UICorner")
    v15 = v15({CornerRadius = UDim.new(1, 0)})
    local v16 = scope:New("UIStroke")
    local v17 = {ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = u18.Menu.Border, Thickness = u18.Menu.StrokeThickness}
    v13[1] = v15
    v13[2] = v16(v17)
    v14[Children_3] = v13
    v11 = v11(v14)
    v14 = scope:New("TextButton")
    v12 = {
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
    v12[InputBegan] = function(a1) -- Line: 205 -- upvalues: u54 (ref), p1 (val), applyFromX (val)
        if a1.UserInputType == Enum.UserInputType.MouseButton1 then
            u54 = true
            if p1.ButtonSound then
                p1.ButtonSound:Play()
            end
            applyFromX(a1.Position.X, false)
        elseif a1.UserInputType ~= Enum.UserInputType.Touch then
        end
    end
    v8[1] = v9
    v8[2] = v10
    v8[3] = v11
    v8[4] = v14(v12)
    v7[Children] = v8
    u53 = v6(v7)
    v6 = p1.Description ~= nil
    if p1.ShowValue ~= nil then
        ShowValue = p1.ShowValue
    else
        ShowValue = true
    end
    local v18 = scope:New("Frame")
    v8 = {Name = p1.Name or "Slider"}
    local Size = p1.Size
    if not Size then
        if not v6 then
            v12 = 56
        else
            v12 = 68
        end
        Size = UDim2.new(1, 0, 0, v12)
    end
    v8.Size = Size
    local Position = p1.Position
    if not Position then
        Position = UDim2.fromScale(0, 0)
    end
    v8.Position = Position
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.new(0, 0)
    end
    v8.AnchorPoint = AnchorPoint
    v8.LayoutOrder = p1.LayoutOrder or 0
    v8.ZIndex = ZIndex
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v8.Visible = Visible
    v8.BackgroundColor3 = u18.Menu.Panel
    v8.BackgroundTransparency = 0
    v8.Parent = p1.Parent
    v10 = {}
    v11 = scope:New("UICorner")
    v11 = v11({CornerRadius = UDim.new(0, u18.Menu.CornerRadius)})
    v14 = scope:New("UIStroke")
    v14 = v14({ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = u18.Menu.Border, Thickness = u18.Menu.StrokeThickness})
    v12 = scope:New("UIGradient")
    v12 = v12({Color = u18.Menu.Shade, Rotation = u18.Menu.ShadeRotation})
    v13 = scope:New("UIPadding")
    v13 = v13({PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 8)})
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
        local Children_4 = scope.Children
        local v19 = {}
        local v20 = scope:New("UICorner")
        v20 = v20({CornerRadius = UDim.new(0.2, 0)})
        local v21 = scope:New("TextLabel")
        local v22 = {
            Name = "Value",
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Text = v3,
            Font = u18.Menu.Fonts.Button,
            TextColor3 = u18.Menu.Text,
            TextScaled = true,
            TextXAlignment = Enum.TextXAlignment.Center,
            ZIndex = ZIndex + 2,
        }
        local Children_5 = scope.Children
        local v23 = {}
        local v24 = scope:New("UIPadding")
        v23[1] = v24({PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5)})
        v22[Children_5] = v23
        v19[1] = v20
        v19[2] = v21(v22)
        v17[Children_4] = v19
        v16 = v16(v17)
    end
    if not v6 then
        v17 = nil
    else
        v17 = scope:New("TextLabel")
        v17 = v17({
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
    v10[1] = v11
    v10[2] = v14
    v10[3] = v12
    v10[4] = v13
    v10[5] = v15
    v10[6] = v16
    v10[7] = v17
    v10[8] = u53
    v8[scope.Children] = v10
    return v18(v8)
end