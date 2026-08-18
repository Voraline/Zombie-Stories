local v_u_1 = {}
local v2 = script.Parent.Parent.Parent:WaitForChild("Controllers")
local v3 = script.Parent.Parent.Parent:WaitForChild("Classes")
local v4 = script.Parent.Parent.Parent:WaitForChild("Shared")
local v_u_5 = require(v2:WaitForChild("LocalPlayerController"))
local v_u_6 = require(v3:WaitForChild("Viewmodel"):WaitForChild("ViewmodelUtils"):WaitForChild("PointRotationUtil"))
local v_u_7 = require(script.Parent:WaitForChild("bobCalculate"))
local v8 = require(script.Parent.Parent:WaitForChild("SpringUtil"))
local v_u_9 = require("../FootstepUtil")
local v_u_10 = require(v4:WaitForChild("SharedSprings"))
local v_u_11 = CFrame.new()
local v_u_12 = CFrame.new()
local v_u_13 = v8.new(0)
v_u_13.Target = 1
v_u_13.Speed = 15
v_u_13.Damper = 0.4
local v_u_14 = v8.new(0)
v_u_14.Target = 1
v_u_14.Speed = 15
v_u_14.Damper = 0.4
local v_u_15 = CFrame.new(0.588401794, -0.546500206, -4.0329895)
v_u_6.UpdateGlobalRotation("BobbingBounce", v_u_15, v_u_12)
local v_u_16 = 0.9
local v_u_34 = {
	["BobCycle"] = function(p17, p18) -- name: BobCycle
		-- upvalues: (ref) v_u_16, (copy) v_u_5, (copy) v_u_1, (ref) v_u_11, (copy) v_u_13, (copy) v_u_9, (copy) v_u_10
		local v19 = p17 * 0.65
		local v20 = math.sin(v19)
		if v_u_16 < v20 and v_u_16 > 0 or v20 < v_u_16 and v_u_16 < 0 then
			v_u_16 = -v_u_16
			if not (v_u_5.States.Proning or v_u_5.States.Sliding) then
				local v21 = v_u_5.PlayerVelocity / 13 * 2
				if v_u_1.Weapon and v_u_1.Weapon.Aiming then
					v21 = v21 * 0.2
				end
				local v22 = math.min(v21, 2.5)
				v_u_11 = CFrame.Angles(-0.01 * v22, 0, -0.02 * v22 * v_u_16) * CFrame.new(-0 * v22 * v_u_16, -0 * v22, 0)
				v_u_13.Position = 0
				v_u_9()
			end
		end
		local v23 = Lerp(2, 5, v_u_10.SprintSpring.Position)
		local v24 = Lerp(2, 14, v_u_10.SprintSpring.Position)
		local v25 = v19 * 2
		local v26 = -(math.sin(v25) * p18) * v23 * 0.2
		local v27 = -(math.sin(v19) * p18) * v24 * 0.3
		return Vector3.new(v26, v27, 0)
	end,
	["BobCycle2"] = function(p28, p29) -- name: BobCycle2
		-- upvalues: (copy) v_u_1, (copy) v_u_14
		local v30 = -p28 * 0.65
		if v_u_1.Weapon and v_u_1.Weapon.Aiming then
			v_u_14.Target = 0
		else
			v_u_14.Target = 1
		end
		local v31 = CFrame.new
		local v32 = -(math.sin(v30) * p29) * 0.005 * v_u_14.Position
		local v33 = v30 * 2
		return v31(v32, -(math.sin(v33) * p29) * 0.005 * v_u_14.Position, 0)
	end
}
local v_u_47 = {
	["BobCycle"] = function(p35, p36) -- name: BobCycle
		local v37 = p35 * 0.65
		local v38 = v37 * 2
		local v39 = -(math.sin(v38) * p36) * 2 * 0.05
		local v40 = -(math.sin(v37) * p36) * 2 * 0.06
		return Vector3.new(v39, v40, 0)
	end,
	["BobCycle2"] = function(p41, p42) -- name: BobCycle2
		local v43 = p41 * 1
		local v44 = CFrame.new
		local v45 = -(math.sin(v43) * p42) * 0.005
		local v46 = v43 * 2
		return v44(v45, -(math.sin(v46) * p42) * 0.005, 0)
	end
}
function v_u_1.Update(p48) -- name: Update
	-- upvalues: (copy) v_u_7, (copy) v_u_34, (copy) v_u_47, (ref) v_u_11, (copy) v_u_13, (ref) v_u_12, (copy) v_u_6, (copy) v_u_15
	local v49 = v_u_7(v_u_34)
	local v50 = v_u_7(v_u_47)
	local v51 = v_u_11:lerp(CFrame.new(), v_u_13.Position)
	local v52 = v_u_12
	local v53 = p48 * 15
	v_u_12 = v52:Lerp(v51, (math.min(1, v53)))
	local v54 = CFrame.new().LookVector:Dot(v_u_12.LookVector)
	local v55 = math.acos(v54)
	local v56
	if v55 <= 0.0001 then
		v56 = v55 >= -0.0001
	else
		v56 = false
	end
	if v56 then
		v_u_12 = CFrame.new()
	end
	v_u_6.UpdateGlobalRotation("BobbingBounce", v_u_15, v_u_12)
	return v49, v50
end
function Lerp(p57, p58, p59) -- name: Lerp
	return p57 * (1 - p59) + p58 * p59
end
return v_u_1