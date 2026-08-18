local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = debug.profilebegin
local v_u_3 = debug.profileend
local v4 = Vector3.new
local v_u_5 = CFrame.new
local v_u_6 = CFrame.Angles
local v_u_7 = math.rad
local v_u_8 = v4()
local v_u_9 = require("@self/CameraShakeInstance")
local v_u_10 = v_u_9.CameraShakeState
v_u_1.CameraShakeInstance = v_u_9
v_u_1.Presets = require("@self/CameraShakePresets")
function v_u_1.new(p11, p12) -- name: new
	-- upvalues: (copy) v_u_8, (copy) v_u_1
	local v13 = type(p11) == "number"
	assert(v13, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
	local v14 = type(p12) == "function"
	assert(v14, "Callback must be a function")
	local v15 = {
		["_running"] = false,
		["_renderName"] = "CameraShakerCS",
		["_renderPriority"] = nil,
		["_posAddShake"] = nil,
		["_rotAddShake"] = nil,
		["_camShakeInstances"] = nil,
		["_removeInstances"] = nil,
		["_callback"] = nil,
		["_renderPriority"] = p11,
		["_posAddShake"] = v_u_8,
		["_rotAddShake"] = v_u_8,
		["_camShakeInstances"] = {},
		["_removeInstances"] = {},
		["_callback"] = p12
	}
	local v16 = v_u_1
	return setmetatable(v15, v16)
end
function v_u_1.Start(p_u_17) -- name: Start
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	if not p_u_17._running then
		p_u_17._running = true
		local v_u_18 = p_u_17._callback
		game:GetService("RunService"):BindToRenderStep(p_u_17._renderName, p_u_17._renderPriority, function(p19)
			-- upvalues: (ref) v_u_2, (copy) p_u_17, (ref) v_u_3, (copy) v_u_18
			v_u_2("CameraShakerUpdate")
			local v20 = p_u_17:Update(p19)
			v_u_3()
			v_u_18(v20)
		end)
	end
end
function v_u_1.Stop(p21) -- name: Stop
	if p21._running then
		game:GetService("RunService"):UnbindFromRenderStep(p21._renderName)
		p21._running = false
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
			v24 = v24 + v28:UpdateShake(p23) * v28.PositionInfluence
			v25 = v25 + v28:UpdateShake(p23) * v28.RotationInfluence
		end
	end
	for v30 = #p22._removeInstances, 1, -1 do
		local v31 = p22._removeInstances[v30]
		table.remove(v26, v31)
		p22._removeInstances[v30] = nil
	end
	return v_u_5(v24) * v_u_6(0, v_u_7(v25.Y), 0) * v_u_6(v_u_7(v25.X), 0, (v_u_7(v25.Z)))
end
function v_u_1.Shake(p32, p33) -- name: Shake
	local v34
	if type(p33) == "table" then
		v34 = p33._camShakeInstance
	else
		v34 = false
	end
	assert(v34, "ShakeInstance must be of type CameraShakeInstance")
	p32._camShakeInstances[#p32._camShakeInstances + 1] = p33
	return p33
end
function v_u_1.ShakeSustain(p35, p36) -- name: ShakeSustain
	local v37
	if type(p36) == "table" then
		v37 = p36._camShakeInstance
	else
		v37 = false
	end
	assert(v37, "ShakeInstance must be of type CameraShakeInstance")
	p35._camShakeInstances[#p35._camShakeInstances + 1] = p36
	p36:StartFadeIn(p36.fadeInDuration)
	return p36
end
function v_u_1.ShakeOnce(p38, p39, p40, p41, p42, p43, p44) -- name: ShakeOnce
	-- upvalues: (copy) v_u_9
	local v45 = v_u_9.new(p39, p40, p41, p42)
	v45.PositionInfluence = typeof(p43) == "Vector3" and p43 and p43 or Vector3.new(0.15, 0.15, 0.15)
	v45.RotationInfluence = typeof(p44) == "Vector3" and p44 and p44 or Vector3.new(1, 1, 1)
	p38._camShakeInstances[#p38._camShakeInstances + 1] = v45
	return v45
end
function v_u_1.StartShake(p46, p47, p48, p49, p50, p51) -- name: StartShake
	-- upvalues: (copy) v_u_9
	local v52 = v_u_9.new(p47, p48, p49)
	v52.PositionInfluence = typeof(p50) == "Vector3" and p50 and p50 or Vector3.new(0.15, 0.15, 0.15)
	v52.RotationInfluence = typeof(p51) == "Vector3" and p51 and p51 or Vector3.new(1, 1, 1)
	v52:StartFadeIn(p49)
	p46._camShakeInstances[#p46._camShakeInstances + 1] = v52
	return v52
end
return v_u_1