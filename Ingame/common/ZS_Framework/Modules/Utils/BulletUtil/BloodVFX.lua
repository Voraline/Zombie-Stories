return function() -- Line: 3
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "BloodVFX"
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "Dots"
    ParticleEmitter.Acceleration = Vector3.new(0, -25, 0)
    ParticleEmitter.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 15)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15)),
    })
    ParticleEmitter.Drag = 1
    ParticleEmitter.EmissionDirection = Enum.NormalId.Front
    ParticleEmitter.Enabled = false
    ParticleEmitter.Lifetime = NumberRange.new(0.5, 1.5)
    ParticleEmitter.LightEmission = 0.2
    ParticleEmitter.LightInfluence = 1
    ParticleEmitter.Rate = 30
    ParticleEmitter.RotSpeed = NumberRange.new(-100, 100)
    ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5, 0.125), NumberSequenceKeypoint.new(1, 0)})
    ParticleEmitter.Speed = NumberRange.new(8, 16)
    ParticleEmitter.SpreadAngle = Vector2.new(360, 360)
    local new_3 = NumberSequence.new
    local v1 = {}
    local v2 = NumberSequenceKeypoint.new(0, 0)
    local v3 = NumberSequenceKeypoint.new(0.502, 0.0932, 0.298)
    v1[1] = v2
    v1[2] = v3
    v1[3] = NumberSequenceKeypoint.new(1, 0)
    ParticleEmitter.Squash = new_3(v1)
    ParticleEmitter.Texture = "rbxassetid://13632303835"
    ParticleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 0.6)})
    ParticleEmitter.VelocityInheritance = 1
    ParticleEmitter.ZOffset = 5
    ParticleEmitter.Parent = Attachment
    local ParticleEmitter_2 = Instance.new("ParticleEmitter")
    ParticleEmitter_2.Name = "Smoke"
    ParticleEmitter_2.Acceleration = Vector3.new(0, -50, 0)
    ParticleEmitter_2.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(111, 111, 111)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(111, 111, 111)),
    })
    ParticleEmitter_2.EmissionDirection = Enum.NormalId.Front
    ParticleEmitter_2.Enabled = false
    ParticleEmitter_2.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    ParticleEmitter_2.Lifetime = NumberRange.new(0.4, 1)
    ParticleEmitter_2.LightInfluence = 1
    ParticleEmitter_2.Rate = 10
    ParticleEmitter_2.RotSpeed = NumberRange.new(-40, 270)
    ParticleEmitter_2.Rotation = NumberRange.new(-360, 360)
    local new_6 = NumberSequence.new
    v2 = {}
    v3 = NumberSequenceKeypoint.new(0, 0)
    local v4 = NumberSequenceKeypoint.new(0.31, 2.5, 0.807)
    v2[1] = v3
    v2[2] = v4
    v2[3] = NumberSequenceKeypoint.new(1, 4.66)
    ParticleEmitter_2.Size = new_6(v2)
    ParticleEmitter_2.Speed = NumberRange.new(15, 20)
    ParticleEmitter_2.SpreadAngle = Vector2.new(360, 360)
    ParticleEmitter_2.Texture = "rbxassetid://15265619203"
    local new_7 = NumberSequence.new
    v2 = {}
    v3 = NumberSequenceKeypoint.new(0, 0.75, 0.1)
    v4 = NumberSequenceKeypoint.new(0.0556, 0.789, 0.1)
    local v5 = NumberSequenceKeypoint.new(0.111, 0.824, 0.1)
    local v6 = NumberSequenceKeypoint.new(0.167, 0.855, 0.1)
    local v7 = NumberSequenceKeypoint.new(0.222, 0.882, 0.1)
    local v8 = NumberSequenceKeypoint.new(0.278, 0.906, 0.1)
    local v9 = NumberSequenceKeypoint.new(0.333, 0.926, 0.1)
    local v10 = NumberSequenceKeypoint.new(0.389, 0.943, 0.1)
    local v11 = NumberSequenceKeypoint.new(0.444, 0.957, 0.1)
    local v12 = NumberSequenceKeypoint.new(0.5, 0.969, 0.1)
    local v13 = NumberSequenceKeypoint.new(0.556, 0.978, 0.1)
    local v14 = NumberSequenceKeypoint.new(0.611, 0.985, 0.1)
    local v15 = NumberSequenceKeypoint.new(0.667, 0.991, 0.1)
    local v16 = NumberSequenceKeypoint.new(0.722, 0.995, 0.1)
    local v17 = NumberSequenceKeypoint.new(0.778, 0.997, 0.1)
    v2[1] = v3
    v2[2] = v4
    v2[3] = v5
    v2[4] = v6
    v2[5] = v7
    v2[6] = v8
    v2[7] = v9
    v2[8] = v10
    v2[9] = v11
    v2[10] = v12
    v2[11] = v13
    v2[12] = v14
    v2[13] = v15
    v2[14] = v16
    v2[15] = v17
    v2[16] = (NumberSequenceKeypoint.new(0.833, 0.999, 0.1))
    v3 = NumberSequenceKeypoint.new(0.889, 1, 0.1)
    v4 = NumberSequenceKeypoint.new(0.944, 1, 0.1)
    v2[17] = v3
    v2[18] = v4
    v2[19] = NumberSequenceKeypoint.new(1, 1, 0.1)
    ParticleEmitter_2.Transparency = new_7(v2)
    ParticleEmitter_2.VelocityInheritance = 1
    ParticleEmitter_2.ZOffset = 5
    ParticleEmitter_2.Parent = Attachment
    Attachment:AddTag("_BloodVFX")
    return Attachment
end