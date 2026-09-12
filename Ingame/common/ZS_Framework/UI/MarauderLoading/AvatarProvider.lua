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
        if v:IsA("LuaSourceContainer")
            or v:IsA("Tool")
            or v:IsA("Sound")
            or v:IsA("ParticleEmitter")
            or v:IsA("Trail")
            or v:IsA("Beam")
            or v:IsA("Smoke")
            or v:IsA("Fire")
            or v:IsA("Sparkles") then
            v:Destroy()
        elseif v:IsA("BasePart") then
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
    local success, result = pcall(function() -- Line: 62 -- upvalues: Players (upval), p1 (val)
        local v1 = Players
        local v2 = p1
        return v1:GetHumanoidDescriptionFromUserIdAsync(v2)
    end)
    if success and result then
        local success_2, result_2 = pcall(function() -- Line: 69 -- upvalues: Players (upval), result (val)
            local v1 = Players
            local v2 = result
            local R6 = Enum.HumanoidRigType.R6
            return v1:CreateHumanoidModelFromDescriptionAsync(v2, R6)
        end)
        if success_2 and result_2 and result_2:IsA("Model") then
            return (sanitizeModel(result_2))
        end
        return nil
    end
    return nil
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
    local v1
    if p1 <= 0 then
        return u10.GetFallbackR6Clone()
    end
    local v2 = u12[p1]
    local v3 = v2 and v2:Clone() or nil
    if v3 then
        return v3
    end
    v2 = u13[p1]
    if v2 then
        v2.Event:Wait()
        v1 = u12[p1]
        local v4 = v1 and v1:Clone() or nil
        return v4
    end
    local BindableEvent = Instance.new("BindableEvent")
    u13[p1] = BindableEvent
    v1 = createModel(p1)
    if v1 then
        v1.Name = "CachedAvatar"
        v1.Parent = nil
        u12[p1] = v1
    end
    u13[p1] = nil
    BindableEvent:Fire()
    task.defer(function() -- Line: 112 -- upvalues: BindableEvent (val)
        BindableEvent:Destroy()
    end)
    local v5 = u12[p1]
    local v6 = v5 and v5:Clone() or nil
    return v6
end

function u10.GetFallbackR6Clone() -- Line: 119 -- upvalues: u16 (ref), Players (val), sanitizeModel (val)
    if u16 then
        return u16:Clone()
    end
    local HumanoidDescription = Instance.new("HumanoidDescription")
    local success, result = pcall(function() -- Line: 125 -- upvalues: Players (upval), HumanoidDescription (val)
        local v1 = Players
        local v2 = HumanoidDescription
        local R6 = Enum.HumanoidRigType.R6
        return v1:CreateHumanoidModelFromDescriptionAsync(v2, R6)
    end)
    HumanoidDescription:Destroy()
    if success and result and result:IsA("Model") then
        u16 = sanitizeModel(result)
        u16.Name = "FallbackAvatar"
        u16.Parent = nil
        return u16:Clone()
    end
    return nil
end

function u10.GetHeadshot(p1) -- Line: 139 -- upvalues: u14 (val), u15 (val), Players (val), ContentProvider (val)
    if p1 <= 0 then
        return "rbxasset://textures/ui/GuiImagePlaceholder.png"
    end
    if u14[p1] then
        return u14[p1]
    end
    local v1 = u15[p1]
    if v1 then
        v1.Event:Wait()
        local v2 = u14[p1]
        if not v2 then
            if p1 <= 0 then
                return "rbxasset://textures/ui/GuiImagePlaceholder.png"
            end
            v2 = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", p1)
        end
        return v2
    end
    local BindableEvent = Instance.new("BindableEvent")
    u15[p1] = BindableEvent
    local success, result = pcall(function() -- Line: 155 -- upvalues: Players (upval), p1 (val)
        local v1 = Players
        local v2 = p1
        local HeadShot = Enum.ThumbnailType.HeadShot
        local Size150x150 = Enum.ThumbnailSize.Size150x150
        return (v1:GetUserThumbnailAsync(v2, HeadShot, Size150x150))
    end)
    if success and type(result) == "string" then
        pcall(function() -- Line: 161 -- upvalues: ContentProvider (upval), result (val)
            local v1 = ContentProvider
            local v2 = {result}
            v1:PreloadAsync(v2)
        end)
        u14[p1] = result
    end
    u15[p1] = nil
    BindableEvent:Fire()
    task.defer(function() -- Line: 169 -- upvalues: BindableEvent (val)
        BindableEvent:Destroy()
    end)
    local v3 = u14[p1]
    if not v3 then
        if p1 <= 0 then
            return "rbxasset://textures/ui/GuiImagePlaceholder.png"
        end
        v3 = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", p1)
    end
    return v3
end

return u10