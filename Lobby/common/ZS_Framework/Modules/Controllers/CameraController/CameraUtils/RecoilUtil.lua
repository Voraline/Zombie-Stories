local v1 = script.Parent.Parent.Parent
local v2 = v1.Parent:WaitForChild("Utils")
local v_u_3 = require(v2:WaitForChild("SpringUtil"))
local v_u_4 = require(v1:WaitForChild("LocalPlayerController"))
local v_u_5 = {}
v_u_5.__index = v_u_5
function v_u_5.new(p6) -- name: new
	-- upvalues: (copy) v_u_3, (copy) v_u_5
	local v7 = p6.Config
	local v8 = {
		["Weapon"] = p6,
		["ImpulsePitch"] = v_u_3.new(0)
	}
	v8.ImpulsePitch.Target = 0
	v8.ImpulsePitch.Speed = v7.RecoilPitchSpeed or (v7.angularFrequency or 8)
	v8.ImpulsePitch.Damper = v7.RecoilPitchDamp or (v7.dampingRatio or 0.6)
	v8.ImpulseYaw = v_u_3.new(0)
	v8.ImpulseYaw.Target = 0
	v8.ImpulseYaw.Speed = v7.RecoilYawSpeed or (v7.angularFrequency or 7)
	v8.ImpulseYaw.Damper = v7.RecoilYawDamp or (v7.dampingRatio or 0.6)
	v8.ImpulseRoll = v_u_3.new(0)
	v8.ImpulseRoll.Target = 0
	v8.ImpulseRoll.Speed = v7.RecoilRollSpeed or (v7.angularFrequency or 15)
	v8.ImpulseRoll.Damper = v7.RecoilRollDamp or (v7.dampingRatio or 0.6)
	v8.CameraPush = { 0, 0 }
	local v9 = v_u_5
	return setmetatable(v8, v9)
end
function v_u_5.RecoilImpulse(p10, p11, p12, p13, p14) -- name: RecoilImpulse
	local v15 = math.random() - 0.5
	return p10 + 0.03 * p13, p11 + 0.02 * p14 * v15, p12 + math.random(500, 1000) * 0.00008 * v15
end
function v_u_5.Impulse(p16) -- name: Impulse
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local v17 = p16.Weapon.Config
	local v18, v19, v20
	if v17.RecoilImpulse then
		local v21 = v17.VerticalRecoil or 3
		local v22 = v17.HorizontalRecoil or 3
		v18, v19, v20 = v17.RecoilImpulse(p16.Weapon, v_u_4, p16.ImpulsePitch.p, p16.ImpulseYaw.p, p16.ImpulseRoll.p, v21, v22)
	else
		local v23 = v17.VerticalRecoil or 3
		local v24 = v17.HorizontalRecoil or 3
		v18, v19, v20 = v_u_5.RecoilImpulse(p16.ImpulsePitch.p, p16.ImpulseYaw.p, p16.ImpulseRoll.p, v23, v24)
	end
	if v17.RecoilMultiplier then
		local v25 = v17.RecoilMultiplier
		if type(v25) == "number" then
			v18 = v18 * v17.RecoilMultiplier
			v19 = v19 * v17.RecoilMultiplier
			v20 = v20 * v17.RecoilMultiplier
		else
			local v26 = v17.RecoilMultiplier
			if type(v26) == "table" then
				v18 = v18 * v17.RecoilMultiplier[1]
				v19 = v19 * v17.RecoilMultiplier[2]
				v20 = v20 * v17.RecoilMultiplier[3]
			end
		end
	end
	local v27
	if v_u_4.States.Crouching or v_u_4.States.Sliding then
		v27 = p16.Weapon.Config.CrouchRecoilMultiplier or 0.92
	elseif v_u_4.States.Proning then
		v27 = p16.Weapon.Config.ProneRecoilMultiplier or 0.85
	else
		v27 = p16.Weapon.Config.StandardRecoilMultiplier or 1
	end
	local v28 = v18 * v27
	local v29 = v19 * v27
	local v30 = v20 * v27
	p16.ImpulsePitch.p = v28 or p16.ImpulsePitch.p
	p16.ImpulseYaw.p = v29 or p16.ImpulseYaw.p
	p16.ImpulseRoll.p = v30 or p16.ImpulseRoll.p + math.random(-1000, 1000) * 0.00007
end
return v_u_5