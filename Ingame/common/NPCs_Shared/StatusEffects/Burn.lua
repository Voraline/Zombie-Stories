local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local u12 = RunService:IsServer()
local u13 = nil
local Sound = Instance.new("Sound")
Sound.Name = "Catch"
Sound.SoundId = "rbxassetid://4841638029"
local Sound_2 = Instance.new("Sound")
Sound_2.Name = "BurnLoop"
Sound_2.Looped = true
Sound_2.SoundId = "rbxassetid://158853971"
local Sound_3 = Instance.new("Sound")
Sound_3.Name = "BurnEnd"
Sound_3.PlaybackSpeed = 1.2
Sound_3.SoundId = "rbxassetid://7102029389"
Sound_3.Volume = 0.25
local function createFireVFX() -- Line: 23
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "FireParticle"
    local v1 = {}
    local v2 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 0))
    v1[1] = v2
    v1[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    ParticleEmitter.Color = ColorSequence.new(v1)
    ParticleEmitter.Lifetime = NumberRange.new(0.5)
    ParticleEmitter.LightEmission = 0.75
    ParticleEmitter.Rate = 25
    ParticleEmitter.RotSpeed = NumberRange.new(-360)
    ParticleEmitter.Rotation = NumberRange.new(100000)
    v1 = {}
    v2 = NumberSequenceKeypoint.new(0, 2.44, 0.5)
    local v3 = NumberSequenceKeypoint.new(0.557, 0.75, 0.75)
    local v4 = NumberSequenceKeypoint.new(0.841, 0.385, 0.385)
    v1[1] = v2
    v1[2] = v3
    v1[3] = v4
    v1[4] = NumberSequenceKeypoint.new(1, 0)
    ParticleEmitter.Size = NumberSequence.new(v1)
    ParticleEmitter.Speed = NumberRange.new(11)
    ParticleEmitter.SpreadAngle = Vector2.new(4, 4)
    ParticleEmitter.Texture = "rbxasset://textures/particles/explosion01_implosion_main.dds"
    return ParticleEmitter
end
return function(p1, p2) -- Line: 48 -- upvalues: u12 (val), u13 (ref), createFireVFX (val), Sound (val), Sound_2 (val), Debris (val), Sound_3 (val)
    p2._Name = script.Name
    p2.Potency = p1.Potency or 1
    p2.Count = p1.Count or 1
    p2.DamagePerPotency = p1.DamagePerPotency or 1
    p2.TickRate = 0.5
    p2._LastTick = os.clock() + p2.TickRate
    p2.Icon = "100977356535196"
    if u12 then
        if not u13 then
            u13 = require("@game/ServerStorage/common/WepHandler")
        end
        function p2.update(a1) -- Line: 65 -- upvalues: p2 (val), p1 (val)
            if p2._Destroyed or not (p2.canTick()) then
                return
            end
            p2.getNPC():DealDamage(p1.Owner, p2.Potency * p2.DamagePerPotency, p1.wepID)
            local v1 = p2
            v1.Count = v1.Count - 1
            if p2.Count <= 0 then
                p2:Destroy()
                return
            end
            p2:UpdateIcon()
        end
    end
    if not u12 then
        local u27 = p2.getNPC()
        local HRP = u27.HRP
        local u30 = createFireVFX()
        u30.Parent = HRP
        local v1 = Sound:Clone()
        v1.Parent = HRP
        v1:Play()
        local v2 = Sound_2:Clone()
        v2.Parent = HRP
        v2:Play()
        v2.Looped = true
        Debris:AddItem(v1, 5)
        p2.AddConnection(function() -- Line: 109 -- upvalues: u30 (val), Debris (upval), Sound_2 (upval), Sound_3 (upval), HRP (val), u27 (val), p2 (val)
            u30.Enabled = false
            Debris:AddItem(u30, 5)
            Sound_2:Destroy()
            local v1 = Sound_3:Clone()
            v1.Parent = HRP
            v1:Play()
            if not u27.Model then end
        end)
    end
    return p2
end