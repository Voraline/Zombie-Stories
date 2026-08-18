local v1 = require(script.Parent.Parent.Parent.Parent.Parent.Utils.SpringUtil)
local v_u_2 = require("../PointRotationUtil")
local v_u_3 = v1.new((Vector3.new()))
v_u_3.Target = Vector3.new()
v_u_3.Speed = 13
v_u_3.Damper = 0.45
local v_u_4 = nil
local v_u_5 = workspace.CurrentCamera.CFrame
local v_u_6 = CFrame.new()
local v_u_7 = CFrame.new()
local v_u_8 = CFrame.new()
return {
	["Update"] = function(p9, p10) -- name: Update
		-- upvalues: (ref) v_u_4, (ref) v_u_5, (copy) v_u_3, (ref) v_u_6, (ref) v_u_7, (ref) v_u_8, (copy) v_u_2
		if not v_u_4 or os.clock() - v_u_4 >= 0.016666666666666666 then
			local v11 = Vector2.new()
			if v_u_5 then
				local v12, v13 = v_u_5:ToObjectSpace(workspace.CurrentCamera.CFrame):ToEulerAnglesXYZ()
				local v14, v15 = workspace.CurrentCamera.CFrame:ToObjectSpace(workspace.CurrentCamera.CFrame):ToEulerAnglesXYZ()
				local v16 = Vector2.new
				local v17 = v15 - v13
				local v18 = math.deg(v17)
				local v19 = v14 - v12
				v11 = v16(v18, (math.deg(v19))) * (p10 and 0.0005 or 0.002)
			end
			local v20 = v_u_3
			local v21 = v_u_3.Position
			local v22 = -v11.X
			local v23 = v11.Y
			v20.Position = v21 + Vector3.new(v22, v23, 0)
			local v24 = v_u_3.Position.X
			if v24 >= 0.05 then
				local v25 = v_u_3
				local v26 = v_u_3.Position.Y
				v25.Position = Vector3.new(0.05, v26, 0)
			elseif v24 <= -0.05 then
				local v27 = v_u_3
				local v28 = v_u_3.Position.Y
				v27.Position = Vector3.new(-0.05, v28, 0)
			end
			local v29 = v_u_3.Position.Y
			if v29 >= 0.05 then
				local v30 = v_u_3
				local v31 = v_u_3.Position.X
				v30.Position = Vector3.new(v31, 0.05, 0)
			elseif v29 <= -0.05 then
				local v32 = v_u_3
				local v33 = v_u_3.Position.X
				v32.Position = Vector3.new(v33, -0.05, 0)
			end
			v_u_4 = os.clock()
			v_u_5 = workspace.CurrentCamera.CFrame
		end
		local v34 = p9 * 10
		local v35 = math.clamp(v34, 0, 1)
		local v36 = CFrame.Angles(-v_u_3.Position.Y, v_u_3.Position.X, 0)
		if p10 then
			v36 = CFrame.Angles(-v_u_3.Position.Y, v_u_3.Position.X, v_u_3.Position.X)
		end
		v_u_6 = v_u_6:Lerp(CFrame.Angles(-v_u_3.Position.Y, v_u_3.Position.X, v_u_3.Position.X) * CFrame.new(-v_u_3.Position.X, v_u_3.Position.Y * 5, 0), v35)
		v_u_7 = v_u_7:Lerp(v36, v35)
		if p10 then
			v_u_8 = v_u_8:Lerp(CFrame.new(), v35)
		else
			v_u_8 = v_u_7
		end
		if p10 then
			v_u_2.UpdateRotation("Inertia", "Barrel", v_u_7, true)
		else
			v_u_2.UpdateRotation("Inertia", nil, v_u_2.GetRotation("Inertia"):Lerp(CFrame.Angles(-v_u_3.Position.Y, 0, v_u_3.Position.X), v35), true)
		end
		return v_u_8, v_u_6
	end
}