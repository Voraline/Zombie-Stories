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
local u35 = {
    "HeadColor",
    "LeftArmColor",
    "LeftLegColor",
    "RightArmColor",
    "RightLegColor",
    "TorsoColor",
}
local function getPlayerDescription(p1) -- Line: 38 -- upvalues: u6 (val), Players (val)
    local v1, v2
    if not p1 then
        return nil, "player unavailable"
    end
    local v3 = u6[p1.UserId]
    if v3 then
        return v3:Clone()
    end
    v1, v2 = pcall(function() -- Line: 47 -- upvalues: Players (upval), p1 (val)
        return Players:GetHumanoidDescriptionFromUserId(p1.UserId)
    end)
    if not v1 then
        return nil, (tostring(v2))
    end
    u6[p1.UserId] = v2
    return v2:Clone()
end
Players.PlayerRemoving:Connect(function(p1) -- Line: 57 -- upvalues: u6 (val)
    local v1 = u6[p1.UserId]
    if v1 then
        v1:Destroy()
        u6[p1.UserId] = nil
    end
end)
local function applyDescription(p1, p2) -- Line: 65
    local v1, v2
    local Humanoid = p1:FindFirstChildOfClass("Humanoid")
    if not Humanoid then
        return false, "humanoid unavailable"
    end
    v1, v2 = pcall(function() -- Line: 71 -- upvalues: Humanoid (val), p2 (val)
        Humanoid:ApplyDescriptionReset(p2)
    end)
    if not v1 then
        return false, (tostring(v2))
    end
    return true
end
local function copyAccessoryDescriptions(p1, p2) -- Line: 80 -- upvalues: u16 (val)
    local v1 = false
    for i, v in ipairs(p1:GetChildren()) do
        if v:IsA("AccessoryDescription") and not (u16[v.AccessoryType]) then
            v1 = v1 or pcall(function() -- Line: 84 -- upvalues: v (val), p2 (val)
                local v1 = v:Clone()
                v1.Parent = p2
                return
            end)
        end
    end
    return v1
end
function v1.ApplyBaseAppearance(p1, p2) -- Line: 93 -- upvalues: getPlayerDescription (val), u35 (val), copyAccessoryDescriptions (val), u7 (val)
    local v1, v2, v3, v4
    v1, v2 = getPlayerDescription(p2.Player)
    if not v1 then
        return false, v2
    end
    local HumanoidDescription = Instance.new("HumanoidDescription")
    for i, v in ipairs(u35) do
        HumanoidDescription[v] = v1[v]
    end
    HumanoidDescription.Face = v1.Face
    HumanoidDescription.Shirt = 0
    HumanoidDescription.Pants = 0
    HumanoidDescription.GraphicTShirt = 0
    if not p2.UseOutfitHats and not (copyAccessoryDescriptions(v1, HumanoidDescription)) then
        for i2, i3 in ipairs(u7) do
            HumanoidDescription[i3] = v1[i3]
        end
    end
    local Humanoid = p1:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        local v5, v6
        v5, v6 = pcall(function() -- Line: 71 -- upvalues: Humanoid (val), HumanoidDescription (val)
            Humanoid:ApplyDescriptionReset(HumanoidDescription)
        end)
        if v5 then
            v3 = true
            v4 = nil
        else
            v3 = false
            v4 = tostring(v6)
        end
    else
        v3 = false
        v4 = "humanoid unavailable"
    end
    HumanoidDescription:Destroy()
    v1:Destroy()
    return v3, v4
end
function v1.ApplyPlayerAccessories() -- Line: 120
    return true
end
function v1.ApplyFullAvatar(p1, p2) -- Line: 126 -- upvalues: getPlayerDescription (val)
    local u4, v1, v2, v3
    u4, v1 = getPlayerDescription(p2.Player)
    if not u4 then
        return false, v1
    end
    local Humanoid = p1:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        local v4, v5
        v4, v5 = pcall(function() -- Line: 71 -- upvalues: Humanoid (val), u4 (val)
            Humanoid:ApplyDescriptionReset(u4)
        end)
        if v4 then
            v2 = true
            v3 = nil
        else
            v2 = false
            v3 = tostring(v5)
        end
    else
        v2 = false
        v3 = "humanoid unavailable"
    end
    u4:Destroy()
    return v2, v3
end
return v1