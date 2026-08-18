local v_u_1 = game:GetService("RunService")
local v_u_2 = {}
v_u_2.__index = v_u_2
function v_u_2.new(p3, p4, p5) -- name: new
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v6 = v_u_2
	local v_u_7 = setmetatable({}, v6)
	v_u_7.Instance = p3
	local v8
	if p5 then
		v8 = p5.Velocity
	else
		v8 = p5
	end
	v_u_7.Velocity = v8
	v_u_7.AngularDisplacement = 0
	v_u_7.CollisionIgnoreList = p4 or {}
	v_u_7.Parameters = p5 or {}
	local v9 = v_u_7.CollisionIgnoreList
	table.insert(v9, p3)
	v_u_1.Heartbeat:Connect(function(p10)
		-- upvalues: (copy) v_u_7
		v_u_7:step(p10)
	end)
	return v_u_7
end
function v_u_2.reflect(p11, p12) -- name: reflect
	local v13 = p11.Parameters.Direction
	p11.Velocity = p11.Velocity / 2
	return v13 - 2 * v13:Dot(p12) * p12
end
function v_u_2.detectCollision(p14, p15) -- name: detectCollision
	local v16 = RaycastParams.new()
	v16.FilterDescendantsInstances = p14.CollisionIgnoreList
	v16.FilterType = Enum.RaycastFilterType.Blacklist
	local v17 = workspace:Raycast(p14.Instance.Position + p14.Parameters.Direction * p14.Instance.Size.Y / 2, p14.Parameters.Direction * p14.Velocity * p15, v16)
	if not v17 then
		local v18 = workspace
		local v19 = p14.Instance.Position
		local v20 = -p14.Instance.Size.Y / 2
		v17 = v18:Raycast(v19, Vector3.new(0, v20, 0), v16)
	end
	if v17 and v17.Instance then
		return v17.Instance, v17.Position, v17.Normal
	end
end
function v_u_2.applyGravity(p21, p22) -- name: applyGravity
	local v23 = p21.Parameters.Mass * workspace.Gravity * p21.Parameters.GravityRate * p22
	p21.AngularDisplacement = p21.AngularDisplacement - v23
end
function v_u_2.step(p24, p25) -- name: step
	local _ = p24.Instance.Position
	if p24.Velocity > 5 then
		local v26, _, v27 = p24:detectCollision(p25)
		if v26 then
			p24.Instance.CFrame = CFrame.new(p24.Instance.Position, p24.Instance.Position + p24:reflect(v27))
		else
			p24:applyGravity(p25)
		end
		p24.Instance.CFrame = p24.Instance.CFrame * CFrame.new(0, 0, -p24.Velocity * p25)
		if p24.Instance.CFrame.LookVector.Y > -0.95 then
			local v28 = p24.Instance
			local v29 = p24.Instance.CFrame
			local v30 = CFrame.Angles
			local v31 = p24.AngularDisplacement
			v28.CFrame = v29 * v30(math.rad(v31), 0, 0)
		end
	end
end
function v_u_2.__init(_) -- name: __init end
return v_u_2