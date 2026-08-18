local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = debug.profilebegin
local v_u_3 = debug.profileend
local v4 = Vector3.new
local v_u_5 = CFrame.new
local v_u_6 = CFrame.Angles
local v_u_7 = math.rad
local v_u_8 = v4()
local v_u_9 = require(script:WaitForChild("CameraShakeInstance"))
local v_u_10 = v_u_9.CameraShakeState
v_u_1.CameraShakeInstance = v_u_9
v_u_1.Presets = require("@self/CameraShakePresets")
function v_u_1.new(p11, p12) -- name: new
	-- upvalues: (copy) v_u_8, (copy) v_u_1
	local v13 = type(p11) == "number"
	assert(v13, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
	local v14 = {
		["_running"] = false,
		["_renderName"] = nil,
		["_renderPriority"] = nil,
		["_posAddShake"] = nil,
		["_rotAddShake"] = nil,
		["_camShakeInstances"] = nil,
		["_removeInstances"] = nil,
		["_renderName"] = p12 or "EZCameraShake",
		["_renderPriority"] = p11,
		["_posAddShake"] = v_u_8,
		["_rotAddShake"] = v_u_8,
		["_camShakeInstances"] = {},
		["_removeInstances"] = {}
	}
	local v15 = v_u_1
	return setmetatable(v14, v15)
end
function v_u_1.Start(p_u_16) -- name: Start
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	if not p_u_16._running then
		p_u_16._running = true
		game:GetService("RunService"):BindToRenderStep(p_u_16._renderName, p_u_16._renderPriority, function(p17)
			-- upvalues: (ref) v_u_2, (copy) p_u_16, (ref) v_u_3
			v_u_2("CameraShakerUpdate")
			p_u_16:Update(p17)
			v_u_3()
		end)
	end
end
function v_u_1.Stop(p18) -- name: Stop
	if p18._running then
		game:GetService("RunService"):UnbindFromRenderStep(p18._renderName)
		p18._running = false
	end
end
function v_u_1.StopSustained(p19, p20) -- name: StopSustained
	for _, v21 in pairs(p19._camShakeInstances) do
		if v21.fadeOutDuration == 0 then
			v21:StartFadeOut(p20 or v21.fadeInDuration)
		end
	end
end
function v_u_1.Update(p22, p23) -- name: Update
	-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7
	local v24 = v_u_8
	local v25 = v_u_8
	local v26 = p22._camShakeInstances
	for v27 = 1, #v26 do
		local v28 = v26[v27]
		local v29 = v28:GetState()
		if v29 == v_u_10.Inactive and v28.DeleteOnInactive then
			p22._removeInstances[#p22._removeInstances + 1] = v27
		elseif v29 ~= v_u_10.Inactive then
			local v30 = v28:UpdateShake(p23)
			v24 = v24 + v30 * v28.PositionInfluence
			v25 = v25 + v30 * v28.RotationInfluence
		end
	end
	for v31 = #p22._removeInstances, 1, -1 do
		local v32 = p22._removeInstances[v31]
		table.remove(v26, v32)
		p22._removeInstances[v31] = nil
	end
	return v_u_5(v24) * v_u_6(0, v_u_7(v25.Y), 0) * v_u_6(v_u_7(v25.X), 0, (v_u_7(v25.Z)))
end
function v_u_1.Shake(p33, p34) -- name: Shake
	local v35
	if type(p34) == "table" then
		v35 = p34._camShakeInstance
	else
		v35 = false
	end
	assert(v35, "ShakeInstance must be of type CameraShakeInstance")
	p33._camShakeInstances[#p33._camShakeInstances + 1] = p34
	return p34
end
function v_u_1.ShakeSustain(p36, p37) -- name: ShakeSustain
	local v38
	if type(p37) == "table" then
		v38 = p37._camShakeInstance
	else
		v38 = false
	end
	assert(v38, "ShakeInstance must be of type CameraShakeInstance")
	p36._camShakeInstances[#p36._camShakeInstances + 1] = p37
	p37:StartFadeIn(p37.fadeInDuration)
	return p37
end
function v_u_1.ShakeOnce(p39, p40, p41, p42, p43, p44, p45) -- name: ShakeOnce
	-- upvalues: (copy) v_u_9
	local v46 = v_u_9.new(p40, p41, p42, p43)
	v46.PositionInfluence = typeof(p44) == "Vector3" and p44 and p44 or Vector3.new(0.15, 0.15, 0.15)
	v46.RotationInfluence = typeof(p45) == "Vector3" and p45 and p45 or Vector3.new(1, 1, 1)
	p39._camShakeInstances[#p39._camShakeInstances + 1] = v46
	return v46
end
function v_u_1.StartShake(p47, p48, p49, p50, p51, p52) -- name: StartShake
	-- upvalues: (copy) v_u_9
	local v53 = v_u_9.new(p48, p49, p50)
	v53.PositionInfluence = typeof(p51) == "Vector3" and p51 and p51 or Vector3.new(0.15, 0.15, 0.15)
	v53.RotationInfluence = typeof(p52) == "Vector3" and p52 and p52 or Vector3.new(1, 1, 1)
	v53:StartFadeIn(p50)
	p47._camShakeInstances[#p47._camShakeInstances + 1] = v53
	return v53
end
return v_u_1