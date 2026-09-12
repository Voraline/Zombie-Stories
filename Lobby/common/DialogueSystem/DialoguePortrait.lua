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
        if v:IsA("Attachment") and not isAccessoryDescendant(v, p1) then
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
    if Head and Head:IsA("BasePart") then
        return Head
    end
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
    if Head_2 and Head_2:IsA("BasePart") then
        return Head_2
    end
    return nil
end

function v1.create(p1, p2, p3, p4, p5) -- Line: 68 -- upvalues: alignAccessories (val), findHead (val), Theme (val)
    if typeof(p3) == "Instance" and p3:IsA("Model") then
        local Archivable = p3.Archivable
        p3.Archivable = true
        local success, result = pcall(function() -- Line: 75 -- upvalues: p3 (val)
            return p3:Clone()
        end)
        p3.Archivable = Archivable
        if success and result then
            alignAccessories(result)
            local v1, v2, v3, v4 = p1, p2, p4, p5
            for i, v in ipairs(result:GetDescendants()) do
                if v:IsA("LuaSourceContainer") then
                    v:Destroy()
                elseif v:IsA("BasePart") then
                    v.Anchored = true
                    v.CanCollide = false
                    v.CanQuery = false
                    v.CanTouch = false
                    v.CastShadow = false
                    v.LocalTransparencyModifier = 0
                elseif v:IsA("ParticleEmitter") or v:IsA("Beam") or v:IsA("Trail") then
                    v.Enabled = false
                end
            end
            local v5 = findHead(result)
            if not v5 then
                result:Destroy()
                return false
            end
            local v6 = v1:New("Camera")({Name = "PortraitCamera", FieldOfView = 28})
            local v7 = v1:New("ViewportFrame")
            local v8 = {
                Name = "NpcPortrait",
                Parent = v2,
                Position = UDim2.fromOffset(8, 8),
                Size = UDim2.new(1, -16, 1, -16),
                BackgroundColor3 = Theme.Menu.PanelInset,
                BackgroundTransparency = 0,
                Ambient = Color3.fromRGB(150, 160, 180),
                LightColor = Color3.fromRGB(255, 232, 200),
                LightDirection = Vector3.new(-1, -0.5, -1),
                CurrentCamera = v6,
                Visible = v3,
                ZIndex = v4,
            }
            local Children = v1.Children
            local v9 = {}
            local v10 = v1:New("UICorner")
            local v11 = {}
            local new = UDim.new
            local v12 = Theme
            local v13 = v12.Menu.CornerRadius - 2
            v11.CornerRadius = new(0, (math.max(2, v13)))
            v9[1] = v10(v11)
            v8[Children] = v9
            v7 = v7(v8)
            v8 = v1:New("WorldModel")({Name = "PortraitWorld", Parent = v7})
            v6.Parent = v7
            result.Name = "NpcBust"
            result.Parent = v8
            local v14 = v5.Position - v5.CFrame.UpVector * 0.3
            v11 = v5.Size.Magnitude * 2.15
            v9 = math.max(4.5, v11)
            v10 = v14 + v5.CFrame.LookVector * v9 + v5.CFrame.UpVector * 0.12
            v6.CFrame = CFrame.lookAt(v10, v14, v5.CFrame.UpVector)
            return true
        end
        return false
    end
    return false
end

return v1