local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local UISounds = require(script.Parent.UISounds)
local u20 = {}

local function getOverlay(p1) -- Line: 8
    local v1 = p1:FindFirstAncestorWhichIsA("ScreenGui")
    if not v1 then
        return nil, nil
    end
    local ButtonRippleOverlay = v1:FindFirstChild("ButtonRippleOverlay")
    if ButtonRippleOverlay and ButtonRippleOverlay:IsA("Frame") then
        return ButtonRippleOverlay, v1
    end
    local v2 = Instance.new("Frame")
    v2.Name = "ButtonRippleOverlay"
    v2.Size = UDim2.fromScale(1, 1)
    v2.BackgroundTransparency = 1
    v2.BorderSizePixel = 0
    v2.ClipsDescendants = false
    v2.Active = false
    v2.ZIndex = 1000
    v2.Parent = v1
    return v2, v1
end

local function getOverlayOrigin(p1, p2) -- Line: 31 -- upvalues: GuiService (val)
    if 0 < p2.AbsoluteSize.X then
        return p2.AbsolutePosition
    end
    if p1.IgnoreGuiInset then
        return -GuiService:GetGuiInset()
    end
    return Vector2.zero
end

local function screenToAbsolute(p1) -- Line: 40 -- upvalues: GuiService (val)
    return p1 - GuiService:GetGuiInset()
end

function u20.PointerPoint() -- Line: 45 -- upvalues: UserInputService (val), GuiService (val)
    return (UserInputService:GetMouseLocation()) - GuiService:GetGuiInset()
end

function u20.PointFromMouseEvent(p1, p2) -- Line: 49 -- upvalues: GuiService (val)
    local v1 = tonumber(p1)
    local v2 = tonumber(p2)
    if v1 and v2 then
        return (Vector2.new(v1, v2)) - GuiService:GetGuiInset()
    end
    return nil
end

function u20.Ripple(p1, p2, p3, p4) -- Line: 55
    -- upvalues: getOverlay (val), u20 (val), GuiService (val), TweenService (val)
    local u6, v1 = getOverlay(p1)
    if u6 and v1 then
        local AbsolutePosition_2
        local v2 = p2
        if not v2 then
            v2 = u20.PointerPoint()
        end
        local AbsolutePosition = p1.AbsolutePosition
        local AbsoluteSize = p1.AbsoluteSize
        if v2.X < AbsolutePosition.X or v2.Y < AbsolutePosition.Y then
            v2 = AbsolutePosition + AbsoluteSize / 2
        else
            local X = v2.X
            if AbsolutePosition.X + AbsoluteSize.X < X then
                v2 = AbsolutePosition + AbsoluteSize / 2
            else
                local Y = v2.Y
                if AbsolutePosition.Y + AbsoluteSize.Y < Y then
                    v2 = AbsolutePosition + AbsoluteSize / 2
                end
            end
        end
        if 0 < u6.AbsoluteSize.X then
            AbsolutePosition_2 = u6.AbsolutePosition
        elseif not v1.IgnoreGuiInset then
            AbsolutePosition_2 = Vector2.zero
        else
            AbsolutePosition_2 = -GuiService:GetGuiInset()
        end
        local u52 = v2 - AbsolutePosition_2
        local u62 = p3
        if not u62 then
            u62 = Color3.new(1, 1, 1)
        end
        local v3 = p4 or 0.52

        local function createRing(p1_2, p2, p3, p4, p5) -- Line: 76
            -- upvalues: u52 (val), p1 (val), u6 (val), u62 (val), TweenService (upval)
            local Frame = Instance.new("Frame")
            Frame.Name = p1_2
            Frame.AnchorPoint = Vector2.new(0.5, 0.5)
            Frame.Position = UDim2.fromOffset(u52.X, u52.Y)
            Frame.Size = UDim2.fromOffset(p2, p2)
            Frame.BackgroundTransparency = 1
            Frame.BorderSizePixel = 0
            Frame.ZIndex = p1.ZIndex + 4
            Frame.Parent = u6
            local UIStroke = Instance.new("UIStroke")
            UIStroke.Color = u62
            UIStroke.Thickness = 1
            UIStroke.Transparency = p4
            UIStroke.Parent = Frame
            local v1 = Instance.new("UICorner", Frame)
            v1.CornerRadius = UDim.new(1, 0)
            v1 = TweenInfo.new(p5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v2 = TweenService
            local v3 = {Size = UDim2.fromOffset(p3, p3)}
            v2 = v2:Create(Frame, v1, v3)
            local v4 = TweenService:Create(UIStroke, v1, {Transparency = 1})
            v2.Completed:Connect(function() -- Line: 107 -- upvalues: Frame (val)
                Frame:Destroy()
            end)
            v4:Play()
            v2:Play()
        end

        createRing("ClickRippleOuter", 8, 56, 0.52, v3)
        createRing("ClickRippleInner", 4, 38, 0.68, v3 * 0.82)
        return
    end
end

function u20.BindTree(p1) -- Line: 118 -- upvalues: u20 (val), UISounds (val)
    local function bind(p1) -- Line: 119 -- upvalues: u20 (upval), UISounds (upval)
        if p1:IsA("GuiButton") and not p1:GetAttribute("UIKitFeedback") then
            if p1:GetAttribute("ButtonFeedbackBound") then
                return
            end
            p1:SetAttribute("ButtonFeedbackBound", true)
            p1.MouseButton1Down:Connect(function() -- Line: 127 -- upvalues: u20 (upval), p1 (val)
                u20.Ripple(p1)
            end)
            local MouseEnter = p1.MouseEnter
            local v1 = UISounds
            local Hover = v1.Hover
            MouseEnter:Connect(Hover)
            return
        end
    end

    for i, v in ipairs(p1:GetDescendants()) do
        bind(v)
    end
    return p1.DescendantAdded:Connect(bind)
end

return u20