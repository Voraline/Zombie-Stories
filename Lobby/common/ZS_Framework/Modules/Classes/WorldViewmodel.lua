local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local Janitor = require(ReplicatedStorage.common:WaitForChild("Janitor"))
local Attachments = ReplicatedStorage.common.SharedResources:WaitForChild("Attachments")
local AttachmentSystem = require(Attachments:WaitForChild("AttachmentSystem"))
local DamageFalloffUtil = require(ReplicatedStorage.common.NPCs_Shared.Utils.DamageFalloffUtil)
local u39 = {}
u39.__index = u39
function u39.new(p1, p2) -- Line: 21 -- upvalues: u39 (val), Janitor (val)
    local v1 = {}
    setmetatable(v1, u39)
    v1.Model = p1
    v1.Weapon = p2
    v1.Janitor = Janitor.new()
    setupViewmodel(v1)
    return v1
end
function u39:Destroy() -- Line: 35
    self.Model:Destroy()
    local Janitor = self.Janitor
    if Janitor then
        Janitor:Destroy()
        self.Janitor = nil
    end
end
function u39.Shoot(p1) end
function u39.StopAnimation(p1, p2, p3) -- Line: 49
    if p1.Animations[p2] then
        p1.Animations[p2]:Stop(p3)
    end
end
function u39.PlayAnimation(p1, p2, ...) -- Line: 55
    local v1, v2, v3
    v1, v2, v3 = unpack({...})
    if not (p1.Animations[p2]) then
        warn("[Viewmodel] Could not play animation " .. p2)
        return
    end
    p1.Animations[p2]:Play(v1 or 0, v2 or 1, v3 or 1)
end
function createVM(p1) -- Line: 69
    local Name = p1.Model.Name
    local Model = p1.Model
    if not Model then
        warn("[Viewmodel] Could not find viewmodel for weapon: " .. Name)
        return
    end
    local KeyParts = Model:WaitForChild("KeyParts")
    local Barrel = KeyParts:FindFirstChild("Barrel")
    if not Barrel then
        Barrel = Model.KeyParts.Handle
    end
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "BarrelAttachment"
    Attachment.Parent = Barrel
    for i, j in Barrel:QueryDescendants("ParticleEmitter, Light, Attachment") do
        if j ~= Attachment then
            j.Parent = Attachment
        end
    end
    local HumanoidRootPart = Model:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        warn("[Viewmodel]: Could not find HumanoidRootPart for weapon: " .. Name)
        return
    end
    local AnimationController = Model:FindFirstChildWhichIsA("AnimationController")
    if not AnimationController then
        AnimationController = Instance.new("AnimationController")
        AnimationController.Parent = Model
    end
    local Animator = AnimationController:FindFirstChildOfClass("Animator")
    if not Animator then
        Animator = Instance.new("Animator")
        Animator.Parent = AnimationController
    end
    for k, n in Model:QueryDescendants("BasePart") do
        n.CastShadow = false
    end
    return Model, HumanoidRootPart, Animator
end
function loadAnimations(p1, p2, p3) -- Line: 111
    local Janitor, u95, v1, v2, v3, v4, v5
    local v6 = {}
    u95, v4, v1 = p1, p3, p2
    for k, v in pairs(p3:GetChildren()) do
        if v:IsA("Animation") then
            v5 = v1:LoadAnimation(v)
            v2 = v.Name == "Idle"
            v5.Looped = v2
            u95.Janitor:Add(v5, "Destroy")
            Janitor = u95.Janitor
            v3 = v5.KeyframeReached:Connect(function(p1) -- Line: 120 -- upvalues: u95 (val)
                if u95.Weapon.Config.KeyFrameSounds[p1] then
                    local Sound = Instance.new("Sound")
                    local SoundId = u95.Weapon.Config.KeyFrameSounds[p1][1]
                    if not SoundId then
                        SoundId = u95.Weapon.Config.KeyFrameSounds[p1].SoundId
                    end
                    Sound.SoundId = "rbxassetid://" .. SoundId
                    local Volume = u95.Weapon.Config.KeyFrameSounds[p1][2]
                    if not Volume then
                        Volume = u95.Weapon.Config.KeyFrameSounds[p1].Volume
                    end
                    Sound.Volume = Volume
                    Sound.Parent = u95.PrimaryPart
                    Sound:Play()
                    game.Debris:AddItem(Sound, 10)
                end
                if not u95.Weapon.LowPolyMode then
                    if u95.Weapon.Config.OnKeyframeReached then
                        u95.Weapon.Config.OnKeyframeReached(p1, u95.Weapon)
                    end
                    if u95.Weapon.Config.CustomKF then
                        u95.Weapon.Config.CustomKF(p1, u95.Model, u95.Weapon.Config)
                    end
                end
            end)
            Janitor:Add(v3, "Disconnect")
            v6[v.Name] = v5
        end
    end
    if v6.Idle then
        v6.Idle:Play()
    else
        local v7
        if u95.Weapon.Config.IsMelee then
            v7 = v4.Swing1:Clone()
        elseif not u95.Weapon.Config.UsesLoadLoop then
            v7 = v4.Reload:Clone()
        else
            v7 = v4.LoadStart:Clone()
        end
        v7.Name = "Idle"
        local v8 = v1:LoadAnimation(v7)
        v8.Looped = true
        while true do
            task.wait()
            if 0 < v8.Length then
                break
            end
        end
        v8:Play()
        v8.TimePosition = v8.Length
        v8:AdjustSpeed(0)
        v6.Idle = v8
    end
    if v6.IdleLayer then
        v6.IdleLayer:Play()
    end
    return v6
end
function setupViewmodel(p1) -- Line: 164 -- upvalues: ReplicatedStorage (val), AttachmentSystem (val), DamageFalloffUtil (val)
    local v1, v2, v3, v4
    v1, v2, v3 = createVM(p1)
    p1.Model = v1
    p1.PrimaryPart = v2
    local KeyParts = v1:WaitForChild("KeyParts")
    local Barrel = KeyParts:FindFirstChild("Barrel")
    if not Barrel then
        Barrel = v1.KeyParts:FindFirstChild("Handle")
    end
    p1.Barrel = Barrel
    p1.BarrelAttachment = p1.Barrel:WaitForChild("BarrelAttachment", 5)
    if not p1.BarrelAttachment then
        error("[WorldViewmodel] Missing BarrelAttachment for weapon: " .. tostring(p1.Weapon.WeaponId))
    end
    p1.Aimpart = v1.KeyParts:FindFirstChild("Aimpart")
    p1.Animator = v3
    v1.Parent = workspace.Ignore
    p1.Animations = loadAnimations(p1, v3, v1:WaitForChild("Animations"))
    v1.Parent = nil
    p1.Animations.Idle.Priority = Enum.AnimationPriority.Core
    if p1.Weapon.Config.MuzzleModule then
        local v5 = ReplicatedStorage.common.SharedResources.MuzzleFlash[p1.Weapon.Config.MuzzleModule]
        v4 = v5.Effects.MuzzleModuleFX:Clone()
        v4.Parent = p1.BarrelAttachment
        p1.MuzzleModule = require(v5)
    end
    if p1.Weapon.Mods then
        AttachmentSystem.DressWeapon(v1.Name, p1.Weapon.Mods, p1.Weapon.Config.AttachmentNodeData, v1, function(a1, p2, p3) -- Line: 192 -- upvalues: p1 (val), DamageFalloffUtil (upval), ReplicatedStorage (upval)
            local v1 = nil
            if p3 then
                local SettingChanges
                v1 = require(p3).new(p2, p1.Weapon.Config, p1)
                if v1.SettingChanges then
                    local v2, v3
                    SettingChanges = v1.SettingChanges
                    local v4 = nil
                    local v5 = nil
                    for i, j in SettingChanges, v4, v5 do
                        if i == "Damage" and p1.Weapon.Config.DamageDropoff and not v1.SettingChanges.DamageDropoff then
                            p1.Weapon.Config.DamageDropoff = DamageFalloffUtil.RescaleDropoff(p1.Weapon.Config.DamageDropoff, p1.Weapon.Config.Damage, j)
                        end
                        p1.Weapon.Config[i] = j
                        if i == "BarrelAttachment" then
                            for k, n in p1.BarrelAttachment:GetChildren() do
                                n.Parent = j
                            end
                            p1.BarrelAttachment = j
                        elseif i == "MuzzleModule" then
                            p1.BarrelAttachment:ClearAllChildren()
                            v3 = ReplicatedStorage.common.SharedResources.MuzzleFlash[p1.Weapon.Config.MuzzleModule]
                            v2 = v3.Effects.MuzzleModuleFX:Clone()
                            v2.Parent = p1.BarrelAttachment
                            p1.MuzzleModule = require(v3)
                        end
                    end
                end
            end
            return v1
        end, true):expect()
    end
    p1.ViewmodelLoaded = true
end
return u39