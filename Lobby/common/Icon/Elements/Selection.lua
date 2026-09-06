return function(p1) -- Line: 1
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "SelectionContainer"
    Frame_2.Visible = false
    local Frame = Instance.new("Frame")
    Frame.Name = "Selection"
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BackgroundTransparency = 1
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Parent = Frame_2
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Name = "UIStroke"
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Thickness = 3
    UIStroke.Parent = Frame
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Name = "SelectionGradient"
    UIGradient.Parent = UIStroke
    local UICorner = Instance.new("UICorner")
    UICorner:SetAttribute("Collective", "IconCorners")
    UICorner.Name = "UICorner"
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Frame
    local RunService = game:GetService("RunService")
    local GuiService = game:GetService("GuiService")
    local u60 = 1
    local AttributeChangedSignal = Frame:GetAttributeChangedSignal("RotationSpeed")
    AttributeChangedSignal:Connect(function() -- Line: 37 -- upvalues: u60 (ref), Frame (val)
        u60 = Frame:GetAttribute("RotationSpeed")
    end)
    RunService.Heartbeat:Connect(function() -- Line: 40 -- upvalues: GuiService (val), UIGradient (val), u60 (ref)
        if not GuiService.SelectedObject then
            return
        end
        UIGradient.Rotation = os.clock() * u60 * 100 % 360
    end)
    return Frame_2
end