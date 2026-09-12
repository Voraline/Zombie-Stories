local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local Parent = script.Parent
local Janitor = require(ReplicatedStorage.common:WaitForChild("Janitor"))
local AttachmentSystem = require((ReplicatedStorage.common.SharedResources:WaitForChild("Attachments")):WaitForChild("AttachmentSystem"))
local DamageFalloffUtil = require(ReplicatedStorage.common.NPCs_Shared.Utils.DamageFalloffUtil)
local new = CFrame.new
local Angles = CFrame.Angles
local u39 = {}
u39.__index = u39

function u39.new(p1, p2) -- Line: 21 -- upvalues: u39 (val), Janitor (val)
    local v1 = {}
    local v2 = u39
    setmetatable(v1, v2)
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
    local v1, v2
    local v3 = {...}
    v1, v3, v2 = unpack(v3)
    if not p1.Animations[p2] then
        warn("[Viewmodel] Could not play animation " .. p2)
        return
    end
    p1.Animations[p2]:Play(v1 or 0, v3 or 1, v2 or 1)
end

function createVM(p1) -- Line: 69
    local Name = p1.Model.Name
    local Model = p1.Model
    if not Model then
        warn("[Viewmodel] Could not find viewmodel for weapon: " .. Name)
        return
    end
    local Barrel = (Model:WaitForChild("KeyParts")):FindFirstChild("Barrel")
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
    local Janitor, v1, v2, v3
    local v4 = {}
    local v5, v6 = p3, p2
    for k, v in pairs(p3:GetChildren()) do
        if v:IsA("Animation") then
            v3 = v6:LoadAnimation(v)
            v1 = v.Name == "Idle"
            v3.Looped = v1
            p1.Janitor:Add(v3, "Destroy")
            Janitor = p1.Janitor
            v2 = v3.KeyframeReached:Connect(function(p1_2) -- Line: 120 -- upvalues: p1 (val)
                if p1.Weapon.Config.KeyFrameSounds[p1_2] then
                    local Sound = Instance.new("Sound")
                    local SoundId = p1.Weapon.Config.KeyFrameSounds[p1_2][1]
                    if not SoundId then
                        SoundId = p1.Weapon.Config.KeyFrameSounds[p1_2].SoundId
                    end
                    Sound.SoundId = "rbxassetid://" .. SoundId
                    local Volume = p1.Weapon.Config.KeyFrameSounds[p1_2][2]
                    if not Volume then
                        Volume = p1.Weapon.Config.KeyFrameSounds[p1_2].Volume
                    end
                    Sound.Volume = Volume
                    Sound.Parent = p1.PrimaryPart
                    Sound:Play()
                    game.Debris:AddItem(Sound, 10)
                end
                if not p1.Weapon.LowPolyMode then
                    if p1.Weapon.Config.OnKeyframeReached then
                        p1.Weapon.Config.OnKeyframeReached(p1_2, p1.Weapon)
                    end
                    if p1.Weapon.Config.CustomKF then
                        p1.Weapon.Config.CustomKF(p1_2, p1.Model, p1.Weapon.Config)
                    end
                end
            end)
            Janitor:Add(v2, "Disconnect")
            v4[v.Name] = v3
        end
    end
    if v4.Idle then
        v4.Idle:Play()
    else
        local v7
        if p1.Weapon.Config.IsMelee then
            v7 = v5.Swing1:Clone()
            if not v7 then
                if not p1.Weapon.Config.UsesLoadLoop then
                    v7 = v5.Reload:Clone()
                else
                    v7 = v5.LoadStart:Clone()
                    if not v7 then
                        v7 = v5.Reload:Clone()
                    end
                end
            end
        elseif not p1.Weapon.Config.UsesLoadLoop then
            v7 = v5.Reload:Clone()
        else
            v7 = v5.LoadStart:Clone()
            if not v7 then
                v7 = v5.Reload:Clone()
            end
        end
        v7.Name = "Idle"
        local v8 = v6:LoadAnimation(v7)
        v8.Looped = true
        repeat
            task.wait()
        until 0 < v8.Length
        v8:Play()
        v8.TimePosition = v8.Length
        v8:AdjustSpeed(0)
        v4.Idle = v8
    end
    if v4.IdleLayer then
        v4.IdleLayer:Play()
    end
    return v4
end

function setupViewmodel(p1) -- Line: 164
    -- upvalues: ReplicatedStorage (val), AttachmentSystem (val), DamageFalloffUtil (val)
    local v1
    local v2, v3, v4 = createVM(p1)
    p1.Model = v2
    p1.PrimaryPart = v3
    local Barrel = (v2:WaitForChild("KeyParts")):FindFirstChild("Barrel")
    if not Barrel then
        Barrel = v2.KeyParts:FindFirstChild("Handle")
    end
    p1.Barrel = Barrel
    p1.BarrelAttachment = p1.Barrel:WaitForChild("BarrelAttachment", 5)
    if not p1.BarrelAttachment then
        v1 = error
        local WeaponId = p1.Weapon.WeaponId
        v1("[WorldViewmodel] Missing BarrelAttachment for weapon: " .. tostring(WeaponId))
    end
    p1.Aimpart = v2.KeyParts:FindFirstChild("Aimpart")
    p1.Animator = v4
    v2.Parent = workspace.Ignore
    p1.Animations = loadAnimations(p1, v4, v2:WaitForChild("Animations"))
    v2.Parent = nil
    p1.Animations.Idle.Priority = Enum.AnimationPriority.Core
    if p1.Weapon.Config.MuzzleModule then
        v1 = ReplicatedStorage.common.SharedResources.MuzzleFlash[p1.Weapon.Config.MuzzleModule]
        local v5 = v1.Effects.MuzzleModuleFX:Clone()
        v5.Parent = p1.BarrelAttachment
        p1.MuzzleModule = require(v1)
    end
    if p1.Weapon.Mods then
        v1 = AttachmentSystem
        v1.DressWeapon(v2.Name, p1.Weapon.Mods, p1.Weapon.Config.AttachmentNodeData, v2, function(p1_2, p2, p3) -- Line: 192 -- upvalues: p1 (val), DamageFalloffUtil (upval), ReplicatedStorage (upval)
            local v1 = nil
            if p3 then
                v1 = require(p3).new(p2, p1.Weapon.Config, p1)
                if v1.SettingChanges then
                    local v2, v3
                    local SettingChanges = v1.SettingChanges
                    local v4 = nil
                    local v5 = nil
                    for i, j in SettingChanges, v4, v5 do
                        if i == "Damage"
                            and p1.Weapon.Config.DamageDropoff
                            and not v1.SettingChanges.DamageDropoff then
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