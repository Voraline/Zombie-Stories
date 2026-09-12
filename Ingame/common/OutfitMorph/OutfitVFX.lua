local CollectionService = game:GetService("CollectionService")
local u5 = {}
local u9 = setmetatable({}, {__mode = "k"})

function u5.VfxTagFor(p1) -- Line: 7
    local Name
    if typeof(p1) ~= "Instance" then
        Name = tostring(p1)
    else
        Name = p1.Name
    end
    return Name .. "_OutfitVFX"
end

local function track(p1, p2) -- Line: 12 -- upvalues: u9 (val)
    local v1 = u9[p1]
    if not v1 then
        v1 = {}
        u9[p1] = v1
    end
    table.insert(v1, p2)
end

function u5.Cleanup(p1, p2) -- Line: 21 -- upvalues: u9 (val), CollectionService (val), u5 (val)
    local v1 = u9[p1]
    if v1 then
        for i, v in ipairs(v1) do
            if v.Parent then
                v:Destroy()
            end
        end
        u9[p1] = nil
    end
    local Player = p2
    if Player then
        Player = p2.Player
    end
    if Player then
        local v2 = ipairs
        local v3 = CollectionService
        local v4 = u5
        v4 = v4.VfxTagFor(Player)
        for i2, i3 in v2(v3:GetTagged(v4)) do
            if i3:IsDescendantOf(p1) then
                i3:Destroy()
            end
        end
    end
end

function u5.Apply(p1, p2, p3) -- Line: 42 -- upvalues: u5 (val), u9 (val), CollectionService (val)
    local HumanoidRootPart = p2
    if HumanoidRootPart then
        HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart")
    end
    local HumanoidRootPart_2 = p1:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart_2 and HumanoidRootPart:FindFirstChild("VFX_Attachment") then
        local Name, v1, v2, v3, v4, v5
        local v6 = false
        if p3.Player ~= nil then
            v6 = p3.Player.Character == p1
        end
        if not v6 then
            v5 = nil
        else
            v5 = u5.VfxTagFor(p3.Player)
            if not v5 then
                v5 = nil
            end
        end
        local v7 = p1
        for i, v in ipairs(HumanoidRootPart:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                v1 = nil
                if v.Parent == HumanoidRootPart then
                    v1 = HumanoidRootPart_2
                elseif v.Parent:IsA("Attachment") then
                    Name = v.Parent.Name
                    v1 = HumanoidRootPart_2:FindFirstChild(Name)
                    if not v1 or not v1:IsA("Attachment") then
                        v2 = Instance.fromExisting(v.Parent)
                        v2.Parent = HumanoidRootPart_2
                        v1 = v2
                        v4 = u9[v7]
                        if not v4 then
                            v4 = {}
                            u9[v7] = v4
                        end
                        table.insert(v4, v2)
                    end
                end
                if v1 then
                    v3 = v:Clone()
                    if v5 then
                        CollectionService:AddTag(v3, v5)
                    end
                    v3.Parent = v1
                    v4 = u9[v7]
                    if not v4 then
                        v4 = {}
                        u9[v7] = v4
                    end
                    table.insert(v4, v3)
                end
            end
        end
        return
    end
end

return u5