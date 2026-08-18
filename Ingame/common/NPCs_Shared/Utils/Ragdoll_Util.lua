local v1 = {}
local v_u_2 = {
	["Neck"] = { CFrame.new(0, 1, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1), CFrame.new(0, -0.5, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1) },
	["Left Shoulder"] = { CFrame.new(-1.3, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1), CFrame.new(0.2, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1) },
	["Right Shoulder"] = { CFrame.new(1.3, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), CFrame.new(-0.2, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) },
	["Left Hip"] = { CFrame.new(-0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1), CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1) },
	["Right Hip"] = { CFrame.new(0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1), CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1) }
}
local v_u_3 = {
	["RagdollAttachment"] = true,
	["RagdollConstraint"] = true,
	["ColliderPart"] = true
}
local function v_u_7(p4) -- name: createColliderPart
	if p4 then
		local v5 = Instance.new("Part")
		v5.Name = "ColliderPart"
		v5.Size = p4.Size / 1.7
		v5.CustomPhysicalProperties = PhysicalProperties.new(Enum.Material.Metal)
		v5.CFrame = p4.CFrame
		v5.Transparency = 1
		v5.CollisionGroup = "NPCRagdoll"
		local v6 = Instance.new("WeldConstraint")
		v6.Part0 = v5
		v6.Part1 = p4
		v6.Parent = v5
		v5.Parent = p4
		return v5
	end
end
function replaceJoints(p8) -- name: replaceJoints
	-- upvalues: (copy) v_u_2, (copy) v_u_7
	for _, v9 in pairs(p8:GetDescendants()) do
		if v9:IsA("Motor6D") and v_u_2[v9.Name] then
			v9.Enabled = false
			local v10 = Instance.new("Attachment")
			local v11 = Instance.new("Attachment")
			v10.CFrame = v_u_2[v9.Name][1]
			v11.CFrame = v_u_2[v9.Name][2]
			v10.Name = "RagdollAttachment"
			v11.Name = "RagdollAttachment"
			v_u_7(v9.Part1)
			local v12 = Instance.new("BallSocketConstraint")
			v12.Attachment0 = v10
			v12.Attachment1 = v11
			v12.Name = "RagdollConstraint"
			v12.Radius = 0.15
			v12.LimitsEnabled = true
			v12.TwistLimitsEnabled = false
			v12.MaxFrictionTorque = 0
			v12.Restitution = 0
			v12.UpperAngle = 90
			v12.TwistLowerAngle = -45
			v12.TwistUpperAngle = 45
			if v9.Name == "Neck" then
				v12.TwistLimitsEnabled = true
				v12.UpperAngle = 45
				v12.TwistLowerAngle = -70
				v12.TwistUpperAngle = 70
			end
			v10.Parent = v9.Part0
			v11.Parent = v9.Part1
			v12.Parent = v9.Parent
		end
	end
end
function v1.Ragdoll(p13)
	replaceJoints(p13)
end
function v1.UnRagdoll(p14)
	-- upvalues: (copy) v_u_3
	for _, v15 in pairs(p14:GetDescendants()) do
		if v_u_3[v15.Name] then
			v15:Destroy()
		end
		if v15:IsA("Motor6D") then
			v15.Enabled = true
		end
	end
end
return v1