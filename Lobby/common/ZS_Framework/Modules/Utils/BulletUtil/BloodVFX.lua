return function()
	local v1 = Instance.new("Attachment")
	v1.Name = "BloodVFX"
	local v2 = Instance.new("ParticleEmitter")
	v2.Name = "Dots"
	v2.Acceleration = Vector3.new(0, -25, 0)
	v2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 15)), ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15)) })
	v2.Drag = 1
	v2.EmissionDirection = Enum.NormalId.Front
	v2.Enabled = false
	v2.Lifetime = NumberRange.new(0.5, 1.5)
	v2.LightEmission = 0.2
	v2.LightInfluence = 1
	v2.Rate = 30
	v2.RotSpeed = NumberRange.new(-100, 100)
	v2.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5, 0.125), NumberSequenceKeypoint.new(1, 0) })
	v2.Speed = NumberRange.new(8, 16)
	v2.SpreadAngle = Vector2.new(360, 360)
	v2.Squash = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.502, 0.0932, 0.298), NumberSequenceKeypoint.new(1, 0) })
	v2.Texture = "rbxassetid://13632303835"
	v2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 0.6) })
	v2.VelocityInheritance = 1
	v2.ZOffset = 5
	v2.Parent = v1
	local v3 = Instance.new("ParticleEmitter")
	v3.Name = "Smoke"
	v3.Acceleration = Vector3.new(0, -50, 0)
	v3.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(111, 111, 111)), ColorSequenceKeypoint.new(1, Color3.fromRGB(111, 111, 111)) })
	v3.EmissionDirection = Enum.NormalId.Front
	v3.Enabled = false
	v3.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
	v3.Lifetime = NumberRange.new(0.4, 1)
	v3.LightInfluence = 1
	v3.Rate = 10
	v3.RotSpeed = NumberRange.new(-40, 270)
	v3.Rotation = NumberRange.new(-360, 360)
	v3.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.31, 2.5, 0.807), NumberSequenceKeypoint.new(1, 4.66) })
	v3.Speed = NumberRange.new(15, 20)
	v3.SpreadAngle = Vector2.new(360, 360)
	v3.Texture = "rbxassetid://15265619203"
	v3.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.75, 0.1),
		NumberSequenceKeypoint.new(0.0556, 0.789, 0.1),
		NumberSequenceKeypoint.new(0.111, 0.824, 0.1),
		NumberSequenceKeypoint.new(0.167, 0.855, 0.1),
		NumberSequenceKeypoint.new(0.222, 0.882, 0.1),
		NumberSequenceKeypoint.new(0.278, 0.906, 0.1),
		NumberSequenceKeypoint.new(0.333, 0.926, 0.1),
		NumberSequenceKeypoint.new(0.389, 0.943, 0.1),
		NumberSequenceKeypoint.new(0.444, 0.957, 0.1),
		NumberSequenceKeypoint.new(0.5, 0.969, 0.1),
		NumberSequenceKeypoint.new(0.556, 0.978, 0.1),
		NumberSequenceKeypoint.new(0.611, 0.985, 0.1),
		NumberSequenceKeypoint.new(0.667, 0.991, 0.1),
		NumberSequenceKeypoint.new(0.722, 0.995, 0.1),
		NumberSequenceKeypoint.new(0.778, 0.997, 0.1),
		NumberSequenceKeypoint.new(0.833, 0.999, 0.1),
		NumberSequenceKeypoint.new(0.889, 1, 0.1),
		NumberSequenceKeypoint.new(0.944, 1, 0.1),
		NumberSequenceKeypoint.new(1, 1, 0.1)
	})
	v3.VelocityInheritance = 1
	v3.ZOffset = 5
	v3.Parent = v1
	v1:AddTag("_BloodVFX")
	return v1
end