local Players = game:GetService("Players")
local v1 = {}
local u6 = {}
local u7 = {
    "HatAccessory",
    "HairAccessory",
    "ShouldersAccessory",
    "FaceAccessory",
    "NeckAccessory",
    "FrontAccessory",
    "BackAccessory",
    "WaistAccessory",
}
local u16 = {}
u16[Enum.AccessoryType.Shirt] = true
u16[Enum.AccessoryType.Pants] = true
u16[Enum.AccessoryType.TShirt] = true
u16[Enum.AccessoryType.Jacket] = true
u16[Enum.AccessoryType.Sweater] = true
u16[Enum.AccessoryType.Shorts] = true
u16[Enum.AccessoryType.DressSkirt] = true
u16[Enum.AccessoryType.LeftShoe] = true
u16[Enum.AccessoryType.RightShoe] = true
local u35 = {"HeadColor", "LeftArmColor", "LeftLegColor", "RightArmColor", "RightLegColor", "TorsoColor"}

local function getPlayerDescription(p1) -- Line: 38 -- upvalues: u6 (val), Players (val)
    if not p1 then
        return nil, "player unavailable"
    end
    local v1 = u6[p1.UserId]
    if v1 then
        return v1:Clone()
    end
    local success, result = pcall(function() -- Line: 47 -- upvalues: Players (upval), p1 (val)
        local v1 = Players
        local v2 = p1
        local UserId = v2.UserId
        return v1:GetHumanoidDescriptionFromUserId(UserId)
    end)
    if not success then
        return nil, (tostring(result))
    end
    u6[p1.UserId] = result
    return result:Clone()
end

Players.PlayerRemoving:Connect(function(p1) -- Line: 57 -- upvalues: u6 (val)
    local v1 = u6[p1.UserId]
    if v1 then
        v1:Destroy()
        u6[p1.UserId] = nil
    end
end)

local function applyDescription(p1, p2) -- Line: 65
    local Humanoid = p1:FindFirstChildOfClass("Humanoid")
    if not Humanoid then
        return false, "humanoid unavailable"
    end
    local success, result = pcall(function() -- Line: 71 -- upvalues: Humanoid (val), p2 (val)
        local v1 = Humanoid
        local v2 = p2
        v1:ApplyDescriptionReset(v2)
    end)
    if not success then
        return false, (tostring(result))
    end
    return true
end

local function copyAccessoryDescriptions(p1, p2) -- Line: 80 -- upvalues: u16 (val)
    local v1
    local v2 = false
    for i, v in ipairs(p1:GetChildren()) do
        if v:IsA("AccessoryDescription") and not u16[v.AccessoryType] then
            v1 = pcall(function() -- Line: 84 -- upvalues: v (val), p2 (val)
                local v1 = v:Clone()
                v1.Parent = p2
            end)
            v2 = v2 or v1
        end
    end
    return v2
end

function v1.ApplyBaseAppearance(p1, p2) -- Line: 93
    -- upvalues: getPlayerDescription (val), u35 (val), copyAccessoryDescriptions (val), u7 (val)
    local v1, v2
    local v3, v4 = getPlayerDescription(p2.Player)
    if not v3 then
        return false, v4
    end
    local HumanoidDescription = Instance.new("HumanoidDescription")
    for i, v in ipairs(u35) do
        HumanoidDescription[v] = v3[v]
    end
    HumanoidDescription.Face = v3.Face
    HumanoidDescription.Shirt = 0
    HumanoidDescription.Pants = 0
    HumanoidDescription.GraphicTShirt = 0
    if not p2.UseOutfitHats and not copyAccessoryDescriptions(v3, HumanoidDescription) then
        for i2, i3 in ipairs(u7) do
            HumanoidDescription[i3] = v3[i3]
        end
    end
    local Humanoid = p1:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        local success, result = pcall(function() -- Line: 71 -- upvalues: Humanoid (val), HumanoidDescription (val)
            local v1 = Humanoid
            local v2 = HumanoidDescription
            v1:ApplyDescriptionReset(v2)
        end)
        if success then
            v1 = true
            v2 = nil
        else
            v1 = false
            v2 = tostring(result)
        end
    else
        v1 = false
        v2 = "humanoid unavailable"
    end
    HumanoidDescription:Destroy()
    v3:Destroy()
    return v1, v2
end

function v1.ApplyPlayerAccessories() -- Line: 120
    return true
end

function v1.ApplyFullAvatar(p1, p2) -- Line: 126 -- upvalues: getPlayerDescription (val)
    local v1, v2
    local u4, v3 = getPlayerDescription(p2.Player)
    if not u4 then
        return false, v3
    end
    local Humanoid = p1:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        local success, result = pcall(function() -- Line: 71 -- upvalues: Humanoid (val), u4 (val)
            local v1 = Humanoid
            local v2 = u4
            v1:ApplyDescriptionReset(v2)
        end)
        if success then
            v1 = true
            v2 = nil
        else
            v1 = false
            v2 = tostring(result)
        end
    else
        v1 = false
        v2 = "humanoid unavailable"
    end
    u4:Destroy()
    return v1, v2
end

return v1