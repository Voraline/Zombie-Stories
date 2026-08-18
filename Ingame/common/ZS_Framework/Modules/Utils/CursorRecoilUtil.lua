local v1 = {
	["crosshairRecoil"] = Vector3.new(0, 0, 0),
	["crosshairRecoilGoal"] = Vector3.new(0, 0, 0)
}
local v_u_2 = 0
function v1.OnShoot(p3, p4) -- name: OnShoot
	-- upvalues: (ref) v_u_2
	if p4.Aiming then
		local v5 = p4.Config.CursorHorizontalRecoil or 0.03
		local v6 = p4.Config.CursorVerticalRecoil or 0.03
		local v7 = p3.crosshairRecoilGoal.X + (math.random() - 0.5) * v5
		local v8 = p3.crosshairRecoilGoal.Y + math.random() * v6
		p3.crosshairRecoilGoal = Vector3.new(v7, v8, 0)
		v_u_2 = workspace:GetServerTimeNow()
	end
end
function v1.Update(p9, p10, p11) -- name: Update
	-- upvalues: (ref) v_u_2
	if workspace:GetServerTimeNow() - v_u_2 >= 0.15 or not p11 then
		local v12 = p9.crosshairRecoilGoal
		local v13 = p10 * 30
		p9.crosshairRecoilGoal = v12:Lerp(Vector3.new(0, 0, 0), (math.clamp(v13, 0, 1)))
	end
	local v14 = p9.crosshairRecoilGoal.X
	local v15 = math.clamp(v14, -0, 0)
	local v16 = p9.crosshairRecoilGoal.Y
	local v17 = math.clamp(v16, 0, 0)
	p9.crosshairRecoilGoal = Vector3.new(v15, v17, 0)
	local v18 = p9.crosshairRecoil
	local v19 = p9.crosshairRecoilGoal
	local v20 = p10 * 30
	p9.crosshairRecoil = v18:Lerp(v19, (math.clamp(v20, 0, 1)))
end
function v1.Reset(p21) -- name: Reset
	p21.crosshairRecoil = Vector3.new(0, 0, 0)
	p21.crosshairRecoilGoal = Vector3.new(0, 0, 0)
end
return v1