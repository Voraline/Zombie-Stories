local v1 = game:GetService("RunService")
local v_u_2 = game:GetService("Debris")
local v_u_3 = v1:IsServer()
local v_u_4 = nil
local v_u_5 = Instance.new("Sound")
v_u_5.Name = "Catch"
v_u_5.SoundId = "rbxassetid://4841638029"
local v_u_6 = Instance.new("Sound")
v_u_6.Name = "BurnLoop"
v_u_6.Looped = true
v_u_6.SoundId = "rbxassetid://158853971"
local v_u_7 = Instance.new("Sound")
v_u_7.Name = "BurnEnd"
v_u_7.PlaybackSpeed = 1.2
v_u_7.SoundId = "rbxassetid://7102029389"
v_u_7.Volume = 0.25
local function v_u_9() -- name: createFireVFX
	local v8 = Instance.new("ParticleEmitter")
	v8.Name = "FireParticle"
	v8.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
	v8.Lifetime = NumberRange.new(0.5)
	v8.LightEmission = 0.75
	v8.Rate = 25
	v8.RotSpeed = NumberRange.new(-360)
	v8.Rotation = NumberRange.new(100000)
	v8.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 2.44, 0.5),
		NumberSequenceKeypoint.new(0.557, 0.75, 0.75),
		NumberSequenceKeypoint.new(0.841, 0.385, 0.385),
		NumberSequenceKeypoint.new(1, 0)
	})
	v8.Speed = NumberRange.new(11)
	v8.SpreadAngle = Vector2.new(4, 4)
	v8.Texture = "rbxasset://textures/particles/explosion01_implosion_main.dds"
	return v8
end
return function(p_u_10, p_u_11)
	-- upvalues: (copy) v_u_3, (ref) v_u_4, (copy) v_u_9, (copy) v_u_5, (copy) v_u_6, (copy) v_u_2, (copy) v_u_7
	p_u_11._Name = script.Name
	p_u_11.Potency = p_u_10.Potency or 1
	p_u_11.Count = p_u_10.Count or 1
	p_u_11.DamagePerPotency = p_u_10.DamagePerPotency or 1
	p_u_11.TickRate = 0.5
	p_u_11._LastTick = os.clock() + p_u_11.TickRate
	p_u_11.Icon = "100977356535196"
	if v_u_3 then
		if not v_u_4 then
			v_u_4 = require("@game/ServerStorage/common/WepHandler")
		end
		function p_u_11.update(_)
			-- upvalues: (copy) p_u_11, (copy) p_u_10
			if not p_u_11._Destroyed then
				if p_u_11.canTick() then
					local v12 = p_u_11.getNPC()
					local v13 = p_u_11.Potency * p_u_11.DamagePerPotency
					v12:DealDamage(p_u_10.Owner, v13, p_u_10.wepID)
					local v14 = p_u_11
					v14.Count = v14.Count - 1
					if p_u_11.Count <= 0 then
						p_u_11:Destroy()
						return
					end
					p_u_11:UpdateIcon()
				end
			end
		end
	end
	if not v_u_3 then
		local v_u_15 = p_u_11.getNPC()
		local v_u_16 = v_u_15.HRP
		local v_u_17 = v_u_9()
		v_u_17.Parent = v_u_16
		local v18 = v_u_5:Clone()
		v18.Parent = v_u_16
		v18:Play()
		local v19 = v_u_6:Clone()
		v19.Parent = v_u_16
		v19:Play()
		v19.Looped = true
		v_u_2:AddItem(v18, 5)
		p_u_11.AddConnection(function()
			-- upvalues: (copy) v_u_17, (ref) v_u_2, (ref) v_u_6, (ref) v_u_7, (copy) v_u_16, (copy) v_u_15, (copy) p_u_11
			v_u_17.Enabled = false
			v_u_2:AddItem(v_u_17, 5)
			v_u_6:Destroy()
			local v20 = v_u_7:Clone()
			v20.Parent = v_u_16
			v20:Play()
			if v_u_15.Model then
				local _ = p_u_11.Count <= 0
			end
		end)
	end
	return p_u_11
end