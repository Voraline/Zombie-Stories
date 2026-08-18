game:GetService("ReplicatedStorage")
local v_u_1 = game:GetService("Debris")
require("@game/ReplicatedStorage/common/zap").RenderExplosionEvent.On(function(p2)
	-- upvalues: (copy) v_u_1
	local v3 = Instance.new("Explosion")
	v3.Position = p2.Position
	v3.BlastRadius = p2.BlastRadius or 10
	v3.BlastPressure = 0
	v3.DestroyJointRadiusPercent = 0
	v3.ExplosionType = Enum.ExplosionType.NoCraters
	local v4 = Instance.new("PointLight")
	v4.Color = Color3.fromRGB(255, 175, 100)
	v4.Range = p2.BlastRadius * 2
	v4.Brightness = 5
	v4.Parent = v3
	v3.Parent = workspace
	local v5 = Instance.new("Part")
	v5.Size = Vector3.new(0.1, 0.1, 0.1)
	v5.Transparency = 1
	v5.CanCollide = false
	v5.CanQuery = false
	v5.Anchored = true
	v5.Position = p2.Position
	local v6 = Instance.new("Sound")
	v6.SoundId = "rbxassetid://5153734048"
	v6.Volume = 2
	v6.RollOffMinDistance = 20
	v6.RollOffMaxDistance = 150
	v6.RollOffMode = Enum.RollOffMode.InverseTapered
	v6.Parent = v5
	v5.Parent = workspace
	v6:Play()
	v_u_1:AddItem(v5, 5)
	v_u_1:AddItem(v3, 5)
end)
return {}