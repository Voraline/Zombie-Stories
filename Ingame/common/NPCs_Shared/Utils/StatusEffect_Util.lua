local RunService = game:GetService("RunService")
local u8 = RunService:IsServer()
RunService:IsClient()
local StatusEffects = script.Parent.Parent.StatusEffects
local u16 = {}
local u17 = {}

local function createIconLabel(p1) -- Line: 14
    if p1.Label then
        return p1.Label
    end
    local Icon = p1.Icon
    local ShowPotency = p1.ShowPotency
    local ShowCount = p1.ShowCount
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "ImageLabel"
    ImageLabel.Image = "rbxassetid://" .. Icon
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Size = UDim2.fromScale(0.65, 0.65)
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
    UIAspectRatioConstraint.Parent = ImageLabel
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "Count"
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    TextLabel.Text = p1.Count
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14
    TextLabel.TextStrokeTransparency = 0
    TextLabel.TextWrapped = true
    TextLabel.AnchorPoint = Vector2.new(1, 1)
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Position = UDim2.fromScale(1, 1.15)
    TextLabel.Size = UDim2.fromScale(0.45, 0.45)
    TextLabel.Visible = ShowCount
    TextLabel.Parent = ImageLabel
    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.Name = "Potency"
    TextLabel_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    TextLabel_2.Text = p1.Potency
    TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_2.TextScaled = true
    TextLabel_2.TextSize = 14
    TextLabel_2.TextStrokeTransparency = 0
    TextLabel_2.TextWrapped = true
    TextLabel_2.AnchorPoint = Vector2.new(0, 1)
    TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_2.BackgroundTransparency = 1
    TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel_2.BorderSizePixel = 0
    TextLabel_2.Position = UDim2.fromScale(0, 1.15)
    TextLabel_2.Size = UDim2.fromScale(0.45, 0.45)
    TextLabel_2.Visible = ShowPotency
    TextLabel_2.Parent = ImageLabel
    p1.Label = ImageLabel
    p1.AddConnection(ImageLabel, "Destroy")
    return ImageLabel
end

function u16.GetIconLabel(p1) -- Line: 81 -- upvalues: createIconLabel (val)
    return (createIconLabel(p1))
end

function u16.GetStatusEffect(p1) -- Line: 85 -- upvalues: u17 (val)
    return u17[p1]
end

function u16.ConstructEffect(p1, p2, p3) -- Line: 89 -- upvalues: u16 (val)
    local v1 = u16.GetStatusEffect(p1)
    local v2 = u16.GetStatusEffect("BaseEffect")(p3, p2)
    return (v1(p3, v2))
end

function u16.ApplyEffect(p1, p2, p3) -- Line: 97 -- upvalues: u16 (val), u8 (val)
    if not p1.CurrentEffects then
        p1.CurrentEffects = {}
        p1.Died:Once(function() -- Line: 100 -- upvalues: p1 (val)
            local CurrentEffects = p1.CurrentEffects
            local v1 = nil
            local v2 = nil
            for i, j in CurrentEffects, v1, v2 do
                j:Destroy()
            end
            p1.CurrentEffects = nil
        end)
    end
    local v1 = p1.CurrentEffects[p2]
    if not p1.CurrentEffects[p2] then
        local v2 = u16.ConstructEffect(p2, p1, p3)
        local StartPotency = p3.StartPotency
        if not StartPotency then
            StartPotency = v2.Potency
        end
        v2.Potency = StartPotency
        local StartCount = p3.StartCount
        if not StartCount then
            StartCount = v2.Count
        end
        v2.Count = StartCount

        function v2.clearFunc() -- Line: 116 -- upvalues: p1 (val), p2 (val)
            if p1.CurrentEffects and not p1.IsDead then
                local v1 = p1
                local v2 = p2
                v1:RemoveEffect(v2)
            end
        end

        p1.CurrentEffects[p2] = v2
        p1.StatusUpdated:Fire("Apply", v2)
    elseif u8 then
        local v3
        if p3.Count then
            v3 = p1.CurrentEffects[p2].Count + (p3.Count or 1)
            local CountCeiling = v1.CountCeiling
            v1.Count = math.clamp(v3, 0, CountCeiling or 99)
        end
        if p3.Potency then
            v3 = p1.CurrentEffects[p2].Potency + (p3.Potency or 1)
            local PotencyCeiling = v1.PotencyCeiling
            v1.Potency = math.clamp(v3, 0, PotencyCeiling or 99)
        end
    end
    if v1 and u8 then
        v1:UpdateIcon()
    end
end

function u16:RemoveEffect(p2) -- Line: 140
    if self.CurrentEffects then
        local v1 = self.CurrentEffects[p2]
        if v1 then
            self.StatusUpdated:Fire("Remove", v1)
            self.CurrentEffects[p2] = nil
            v1:Destroy()
        end
    end
end

for i, j in StatusEffects:GetChildren() do
    u17[j.Name] = (require(j))
end
return u16