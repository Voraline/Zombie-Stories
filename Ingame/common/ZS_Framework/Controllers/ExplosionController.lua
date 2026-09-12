game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
;(require("@game/ReplicatedStorage/common/zap")).RenderExplosionEvent.On(function(p1) -- Line: 8 -- upvalues: Debris (val)
    local Explosion = Instance.new("Explosion")
    Explosion.Position = p1.Position
    Explosion.BlastRadius = p1.BlastRadius or 10
    Explosion.BlastPressure = 0
    Explosion.DestroyJointRadiusPercent = 0
    Explosion.ExplosionType = Enum.ExplosionType.NoCraters
    local PointLight = Instance.new("PointLight")
    PointLight.Color = Color3.fromRGB(255, 175, 100)
    PointLight.Range = p1.BlastRadius * 2
    PointLight.Brightness = 5
    PointLight.Parent = Explosion
    Explosion.Parent = workspace
    local Part = Instance.new("Part")
    Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
    Part.Transparency = 1
    Part.CanCollide = false
    Part.CanQuery = false
    Part.Anchored = true
    Part.Position = p1.Position
    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://5153734048"
    Sound.Volume = 2
    Sound.RollOffMinDistance = 20
    Sound.RollOffMaxDistance = 150
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered
    Sound.Parent = Part
    Part.Parent = workspace
    Sound:Play()
    Debris:AddItem(Part, 5)
    Debris:AddItem(Explosion, 5)
end)
return {}