local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local v1 = {}
local function isAccessoryDescendant(p1, p2) -- Line: 7
    local Parent = p1.Parent
    while Parent do
        if Parent == p2 then
            break
        end
        if Parent:IsA("Accessory") then
            return true
        end
        Parent = Parent.Parent
    end
    return false
end
local function alignAccessories(p1) -- Line: 18 -- upvalues: isAccessoryDescendant (val)
    local Handle, v1
    local v2 = {}
    for i, v in ipairs(p1:GetDescendants()) do
        if v:IsA("Attachment") and not (isAccessoryDescendant(v, p1)) then
            v2[v.Name] = v2[v.Name] or v
        end
    end
    for i2, i3 in ipairs(p1:GetChildren()) do
        if i3:IsA("Accessory") then
            Handle = i3:FindFirstChild("Handle")
            if Handle and Handle:IsA("BasePart") then
                for i4, j in ipairs(Handle:GetChildren()) do
                    if j:IsA("Attachment") then
                        v1 = v2[j.Name]
                        if v1 then
                            Handle.CFrame = v1.WorldCFrame * j.CFrame:Inverse()
                            break
                        end
                    end
                end
            end
        end
    end
end
local function findHead(p1) -- Line: 44
    local Head = p1:FindFirstChild("Head")
    if not Head then
        for i, v in ipairs(p1:GetDescendants()) do
            if v.Name == "Head" and v:IsA("BasePart") then
                return v
            end
        end
        local Humanoid = p1:FindFirstChildWhichIsA("Humanoid", true)
        local Parent = Humanoid
        if Parent then
            Parent = Humanoid.Parent
        end
        local Head_2 = Parent
        if Head_2 then
            Head_2 = Parent:IsA("Model")
            if Head_2 then
                Head_2 = Parent:FindFirstChild("Head")
            end
        end
        if not Head_2 then
            return nil
        end
        if Head_2:IsA("BasePart") then
            return Head_2
        end
        return nil
    elseif Head:IsA("BasePart") then
        return Head
    end
end
function v1.create(p1, p2, p3, p4, p5) -- Line: 68 -- upvalues: alignAccessories (val), findHead (val), Theme (val)
    local v1, v2, v3, v4, v5, v6
    if typeof(p3) ~= "Instance" or not (p3:IsA("Model")) then
        return false
    end
    local Archivable = p3.Archivable
    p3.Archivable = true
    v5, v6 = pcall(function() -- Line: 75 -- upvalues: p3 (val)
        return p3:Clone()
    end)
    p3.Archivable = Archivable
    if not v5 or not v6 then
        return false
    end
    alignAccessories(v6)
    v1, v2, v3, v4 = p1, p2, p4, p5
    for i, v in ipairs(v6:GetDescendants()) do
        if v:IsA("LuaSourceContainer") then
            v:Destroy()
        elseif v:IsA("BasePart") then
            v.Anchored = true
            v.CanCollide = false
            v.CanQuery = false
            v.CanTouch = false
            v.CastShadow = false
            v.LocalTransparencyModifier = 0
        elseif v:IsA("ParticleEmitter") then
            v.Enabled = false
        elseif not (v:IsA("Beam")) and not (v:IsA("Trail")) then
        end
    end
    local v7 = findHead(v6)
    if not v7 then
        v6:Destroy()
        return false
    end
    local v8 = v1:New("Camera")
    v8 = v8({Name = "PortraitCamera", FieldOfView = 28})
    local v9 = v1:New("ViewportFrame")
    local v10 = {
        Name = "NpcPortrait",
        Parent = v2,
        Position = UDim2.fromOffset(8, 8),
        Size = UDim2.new(1, -16, 1, -16),
        BackgroundColor3 = Theme.Menu.PanelInset,
        BackgroundTransparency = 0,
        Ambient = Color3.fromRGB(150, 160, 180),
        LightColor = Color3.fromRGB(255, 232, 200),
        LightDirection = Vector3.new(-1, -0.5, -1),
        CurrentCamera = v8,
        Visible = v3,
        ZIndex = v4,
    }
    local Children = v1.Children
    local v11 = {}
    local v12 = v1:New("UICorner")
    v11[1] = v12({CornerRadius = UDim.new(0, (math.max(2, Theme.Menu.CornerRadius - 2)))})
    v10[Children] = v11
    v9 = v9(v10)
    v10 = v1:New("WorldModel")
    v10 = v10({Name = "PortraitWorld", Parent = v9})
    v8.Parent = v9
    v6.Name = "NpcBust"
    v6.Parent = v10
    local v13 = v7.Position - v7.CFrame.UpVector * 0.3
    local v14 = v13 + v7.CFrame.LookVector * math.max(4.5, v7.Size.Magnitude * 2.15)
    v8.CFrame = CFrame.lookAt(v14 + v7.CFrame.UpVector * 0.12, v13, v7.CFrame.UpVector)
    return true
end
return v1