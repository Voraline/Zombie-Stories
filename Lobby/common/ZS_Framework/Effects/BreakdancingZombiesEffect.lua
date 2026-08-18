local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require(v1.common.ZS_Shared.Data.GameState)
local v_u_4, v_u_5 = require(v1.Packages.Bin)()
local function v21() -- name: toggleBreakdancingZombies
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_4, (copy) v_u_2
	local v6 = v_u_3.Data.Variables.BreakdancingZombiesEnabled
	v_u_5()
	if v6 then
		v_u_4(v_u_2.Heartbeat:Connect(function(p7)
			-- upvalues: (ref) v_u_3
			local v8 = v_u_3.LocalState.RotationAxis
			v8.X = v8.X + p7 * 60
			local v9 = v_u_3.LocalState.RotationAxis
			v9.Y = v9.Y + p7 * 200
			local v10 = v_u_3.LocalState.RotationAxis
			v10.Z = v10.Z + p7 * 30
			if v_u_3.LocalState.RotationAxis.X > 360 then
				local v11 = v_u_3.LocalState.RotationAxis
				v11.X = v11.X - 360
			end
			if v_u_3.LocalState.RotationAxis.Y > 360 then
				local v12 = v_u_3.LocalState.RotationAxis
				v12.Y = v12.Y - 360
			end
			if v_u_3.LocalState.RotationAxis.Z > 360 then
				local v13 = v_u_3.LocalState.RotationAxis
				v13.Z = v13.Z - 360
			end
			local v14 = v_u_3.LocalState
			local v15 = CFrame.Angles
			local v16 = v_u_3.LocalState.RotationAxis.X
			local v17 = math.rad(v16)
			local v18 = v_u_3.LocalState.RotationAxis.Y
			local v19 = math.rad(v18)
			local v20 = v_u_3.LocalState.RotationAxis.Z
			v14.NPCRotation = v15(v17, v19, (math.rad(v20)))
		end))
	else
		v_u_3.LocalState.NPCRotation = CFrame.Angles(0, 0, 0)
		v_u_3.LocalState.RotationAxis = {
			["X"] = 0,
			["Y"] = 0,
			["Z"] = 0
		}
	end
end
v21()
v_u_3.Signals.Variables.BreakdancingZombiesEnabled:Connect(v21)
return {}