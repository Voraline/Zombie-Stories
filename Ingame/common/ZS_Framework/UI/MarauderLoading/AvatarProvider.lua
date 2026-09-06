local Players = game:GetService("Players")
local ContentProvider = game:GetService("ContentProvider")
local u10 = {}
local function fallbackHeadshot(p1) -- Line: 9
    if p1 <= 0 then
        return "rbxasset://textures/ui/GuiImagePlaceholder.png"
    end
    return string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", p1)
end
local u12 = {}
local u13 = {}
local u14 = {}
local u15 = {}
local u16 = nil
local function sanitizeModel(p1) -- Line: 22
    local v1 = p1
    for i, v in ipairs(p1:GetDescendants()) do
        if v:IsA("LuaSourceContainer") then
            v:Destroy()
        elseif not (v:IsA("Tool")) and not (v:IsA("Sound")) and not (v:IsA("ParticleEmitter")) and not (v:IsA("Trail")) and not (v:IsA("Beam")) and not (v:IsA("Smoke")) and not (v:IsA("Fire")) and not (v:IsA("Sparkles")) and v:IsA("BasePart") then
            v.CanCollide = false
            v.CanTouch = false
            v.CanQuery = false
            v.Massless = true
        end
    end
    local Humanoid = v1:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        Humanoid.AutoRotate = false
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        Humanoid.NameDisplayDistance = 0
    end
    local HumanoidRootPart = v1:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        v1.PrimaryPart = HumanoidRootPart
    end
    v1.Archivable = true
    return v1
end
local function createModel(p1) -- Line: 61 -- upvalues: Players (val), sanitizeModel (val)
    local u4, v1, v2, v3
    v1, u4 = pcall(function() -- Line: 62 -- upvalues: Players (upval), p1 (val)
        return Players:GetHumanoidDescriptionFromUserIdAsync(p1)
    end)
    if not v1 or not u4 then
        return nil
    end
    v2, v3 = pcall(function() -- Line: 69 -- upvalues: Players (upval), u4 (val)
        return Players:CreateHumanoidModelFromDescriptionAsync(u4, Enum.HumanoidRigType.R6)
    end)
    if not v2 or not v3 or not (v3:IsA("Model")) then
        return nil
    end
    return (sanitizeModel(v3))
end
local function getCachedClone(p1) -- Line: 79 -- upvalues: u12 (val)
    local v1
    local v2 = u12[p1]
    if not v2 then
        v1 = nil
    else
        v1 = v2:Clone()
        if not v1 then
            v1 = nil
        end
    end
    return v1
end
function u10.GetR6Clone(p1) -- Line: 84 -- upvalues: u10 (val), u12 (val), u13 (val), createModel (val)
    local v1, v2, v3
    if p1 <= 0 then
        return u10.GetFallbackR6Clone()
    end
    local v4 = u12[p1]
    if not v4 then
        v1 = nil
    else
        v1 = v4:Clone()
    end
    if v1 then
        return v1
    end
    v4 = u13[p1]
    if v4 then
        local v5
        v4.Event:Wait()
        v2 = u12[p1]
        if not v2 then
            v5 = nil
        else
            v5 = v2:Clone()
            if not v5 then
                v5 = nil
            end
        end
        return v5
    end
    local BindableEvent = Instance.new("BindableEvent")
    u13[p1] = BindableEvent
    v2 = createModel(p1)
    if v2 then
        v2.Name = "CachedAvatar"
        v2.Parent = nil
        u12[p1] = v2
    end
    u13[p1] = nil
    BindableEvent:Fire()
    task.defer(function() -- Line: 112 -- upvalues: BindableEvent (val)
        BindableEvent:Destroy()
    end)
    local v6 = u12[p1]
    if not v6 then
        v3 = nil
    else
        v3 = v6:Clone()
        if not v3 then
            v3 = nil
        end
    end
    return v3
end
function u10.GetFallbackR6Clone() -- Line: 119 -- upvalues: u16 (ref), Players (val), sanitizeModel (val)
    local v1, v2
    if u16 then
        return u16:Clone()
    end
    local HumanoidDescription = Instance.new("HumanoidDescription")
    v1, v2 = pcall(function() -- Line: 125 -- upvalues: Players (upval), HumanoidDescription (val)
        return Players:CreateHumanoidModelFromDescriptionAsync(HumanoidDescription, Enum.HumanoidRigType.R6)
    end)
    HumanoidDescription:Destroy()
    if not v1 or not v2 or not (v2:IsA("Model")) then
        return nil
    end
    u16 = sanitizeModel(v2)
    u16.Name = "FallbackAvatar"
    u16.Parent = nil
    return u16:Clone()
end
function u10.GetHeadshot(p1) -- Line: 139 -- upvalues: u14 (val), u15 (val), Players (val), ContentProvider (val)
    local u29, v1
    if p1 <= 0 then
        return "rbxasset://textures/ui/GuiImagePlaceholder.png"
    end
    if u14[p1] then
        return u14[p1]
    end
    local v2 = u15[p1]
    if v2 then
        v2.Event:Wait()
        local v3 = u14[p1]
        if v3 then
            return v3
        end
        if p1 <= 0 then
            return "rbxasset://textures/ui/GuiImagePlaceholder.png"
        end
        v3 = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", p1)
        return v3
    end
    local BindableEvent = Instance.new("BindableEvent")
    u15[p1] = BindableEvent
    v1, u29 = pcall(function() -- Line: 155 -- upvalues: Players (upval), p1 (val)
        return (Players:GetUserThumbnailAsync(p1, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150))
    end)
    if v1 and type(u29) == "string" then
        pcall(function() -- Line: 161 -- upvalues: ContentProvider (upval), u29 (val)
            ContentProvider:PreloadAsync({u29})
        end)
        u14[p1] = u29
    end
    u15[p1] = nil
    BindableEvent:Fire()
    task.defer(function() -- Line: 169 -- upvalues: BindableEvent (val)
        BindableEvent:Destroy()
    end)
    local v4 = u14[p1]
    if v4 then
        return v4
    end
    if p1 <= 0 then
        return "rbxasset://textures/ui/GuiImagePlaceholder.png"
    end
    v4 = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", p1)
    return v4
end
return u10