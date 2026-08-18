local v1 = require("../../../Utils/SpringUtil")
local v_u_2 = CFrame.new
local v_u_3 = v1.new(0)
v_u_3.Target = 0
v_u_3.Speed = 24
v_u_3.Damper = 0.8
local v_u_4 = {
	["Inspect"] = true,
	["ReloadEmpty"] = true,
	["Reload"] = true,
	["LoadStart"] = true,
	["LoadLoop"] = true,
	["Equip"] = true,
	["LoadStop"] = true,
	["LoadIdle"] = true
}
local function v_u_7(p5) -- name: checkAnimations
	-- upvalues: (copy) v_u_4
	for v6, _ in v_u_4 do
		if p5.Viewmodel.Animations[v6] and p5.Viewmodel.Animations[v6].IsPlaying then
			return false
		end
	end
	return true
end
local v_u_8 = nil
return function(p9, p10)
	-- upvalues: (ref) v_u_8, (copy) v_u_3, (copy) v_u_7, (copy) v_u_2
	local v11 = p9.LeftWeld.Part0.CFrame:Inverse() * p10.Config.LeftArmGrip.CFrame
	local v12 = false
	if p9.OGLArmWeld ~= v_u_8 then
		v_u_8 = p9.OGLArmWeld
		p9.OGLArmWeld_BaseTransform = nil
		p9.OGLArmWeld_OldTransform = nil
		v_u_3.Position = 0
		v_u_3.Target = 0
	end
	local v13 = not p10.Reloading
	if v13 then
		v13 = v_u_7(p10)
	end
	if v13 then
		if p9.OGLArmWeld_OldTransform and p9.OGLArmWeld.Transform == p9.OGLArmWeld_OldTransform then
			p9.OGLArmWeld_BaseTransform = p9.OGLArmWeld.Transform
		end
		p9.OGLArmWeld_OldTransform = p9.OGLArmWeld.Transform
	end
	if p9.OGLArmWeld_BaseTransform and v13 then
		local v14 = (p9.OGLArmWeld_BaseTransform.p - p9.OGLArmWeld.Transform.Position).Magnitude <= 0.17
		local v15 = p9.OGLArmWeld_BaseTransform.LookVector:Dot(p9.OGLArmWeld.Transform.LookVector)
		local v16 = math.acos(v15)
		local v17 = math.deg(v16)
		local v18
		if v17 == v17 then
			v18 = v17 <= 0.04
		else
			v18 = false
		end
		v12 = (v14 or v18) and true or v12
	end
	v_u_3.Target = v12 and 1 or 0
	if p9.MoveCF then
		local v19 = p9.LeftWeld
		local v20 = v_u_2()
		local v21 = v_u_2(0, 1, 0)
		local v22 = v_u_3.Position
		v19.C1 = v20:Lerp(v21, 1 * (1 - v22) + 0 * v22)
	end
	p9.LeftWeld.C0 = v_u_2():Lerp(v11, v_u_3.Position)
	return p9.LeftWeld.C0
end