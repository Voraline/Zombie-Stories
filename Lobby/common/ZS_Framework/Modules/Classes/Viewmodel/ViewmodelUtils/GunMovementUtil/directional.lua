local v1 = {}
local v2 = script.Parent.Parent.Parent.Parent.Parent
local v3 = v2:WaitForChild("Controllers"):WaitForChild("LocalPlayerController")
local v_u_4 = require(v3)
local v5 = require(v2:WaitForChild("Utils"):WaitForChild("SpringUtil"))
local v_u_6 = require(v3:WaitForChild("LocalPlayerUtils"):WaitForChild("PlayerMovementUtil"))
local v_u_7 = require(script.Parent.Parent:WaitForChild("PointRotationUtil"))
local v_u_8 = workspace.Camera
local v_u_9 = v5.new(0)
v_u_9.Target = 0
v_u_9.Speed = 6
v_u_9.Damper = 0.4
local v_u_10 = v5.new(0)
v_u_10.Target = 0
v_u_10.Speed = 6
v_u_10.Damper = 0.4
local v_u_11 = CFrame.new(0.588401794, -0.546500206, -4.0329895)
local v_u_12 = { v_u_10.Position / 2, v_u_9.Position / 2 }
function v1.Update(_) -- name: Update
	-- upvalues: (copy) v_u_4, (copy) v_u_8, (copy) v_u_6, (copy) v_u_9, (copy) v_u_10, (copy) v_u_12, (copy) v_u_7, (copy) v_u_11
	local v13 = v_u_4.Character
	if v13 then
		local v14 = v13.Humanoid
		local v15 = v14.MoveDirection:Dot(v_u_8.CFrame.RightVector)
		local v16 = v14.MoveDirection:Dot(v_u_8.CFrame.LookVector)
		if v_u_6.MoveVector.Magnitude > 0.75 then
			if v15 > 0.1 or v15 < 0.1 then
				v_u_9.Target = -5 * v15
			else
				v_u_9.Target = 0
			end
			if v16 > 0.1 or v16 < 0.1 then
				v_u_10.Target = -0.5 * v16
			else
				v_u_10.Target = 0
			end
		else
			v_u_9.Target = 0
			v_u_10.Target = 0
		end
		v_u_12[1] = v_u_10.Position / 2
		v_u_12[2] = v_u_9.Position / 2
		for v17, v18 in v_u_12 do
			if v18 <= 0.0001 and v18 >= -0.0001 then
				v_u_12[v17] = 0
			end
		end
		local v19 = CFrame.Angles
		local v20 = v_u_12[1]
		local v21 = math.rad(v20)
		local v22 = v_u_12[2]
		local v23 = v19(v21, 0, (math.rad(v22)))
		v_u_7.UpdateRotation("Directional", v_u_11, v23)
	end
end
return v1