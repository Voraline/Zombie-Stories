local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = v1.common:WaitForChild("SharedResources"):WaitForChild("Assets")
local v_u_4 = script.Parent.Parent.Parent.Parent.Controllers
local v_u_5 = nil
local v6 = {}
local function v_u_13() -- name: GetPlayerAppearance
	-- upvalues: (copy) v_u_2
	local v7 = v_u_2.LocalPlayer
	if v7 then
		v7 = v7.Character
	end
	local v8 = Color3.fromRGB(255, 204, 153)
	local v9 = nil
	if v7 then
		local v10 = v7:FindFirstChildOfClass("BodyColors")
		if v10 then
			v8 = v10.RightArmColor3 or (v10.LeftArmColor3 or v8)
		else
			local v11 = v7:FindFirstChild("Right Arm")
			if v11 then
				v8 = v11.Color
			end
		end
		local v12 = v7:FindFirstChildOfClass("Shirt")
		if v12 and (v12.ShirtTemplate and v12.ShirtTemplate ~= "") then
			v9 = v12.ShirtTemplate
		end
	end
	return v8, v9
end
local v_u_14 = {
	["RightHidden"] = false,
	["LeftHidden"] = false,
	["RightArm"] = nil,
	["LeftArm"] = nil
}
local function v_u_24(p15, p16) -- name: HideRealArms
	-- upvalues: (copy) v_u_2, (ref) v_u_5, (copy) v_u_4, (copy) v_u_14
	local v17 = v_u_2.LocalPlayer
	if v17 then
		v17 = v17.Character
	end
	if v17 then
		local v18
		if v_u_5 then
			v18 = v_u_5
		else
			local v19 = v_u_4:FindFirstChild("CameraController")
			if v19 then
				local v20 = v19:FindFirstChild("CameraUtils")
				local v21 = v20 and v20:FindFirstChild("TransparencyUtil")
				if v21 then
					v_u_5 = require(v21)
				end
			end
			v18 = v_u_5
		end
		local v22 = p15 and v17:FindFirstChild("Right Arm")
		if v22 then
			v22.LocalTransparencyModifier = 1
			v_u_14.RightArm = v22
			v_u_14.RightHidden = true
			if v18 and v18.CustomList then
				v18.CustomList["Right Arm"] = 1
			end
		end
		local v23 = p16 and v17:FindFirstChild("Left Arm")
		if v23 then
			v23.LocalTransparencyModifier = 1
			v_u_14.LeftArm = v23
			v_u_14.LeftHidden = true
			if v18 and v18.CustomList then
				v18.CustomList["Left Arm"] = 1
			end
		end
	end
end
local function v_u_31(p25, p26) -- name: ShowRealArms
	-- upvalues: (ref) v_u_5, (copy) v_u_4, (copy) v_u_14
	local v27
	if v_u_5 then
		v27 = v_u_5
	else
		local v28 = v_u_4:FindFirstChild("CameraController")
		if v28 then
			local v29 = v28:FindFirstChild("CameraUtils")
			local v30 = v29 and v29:FindFirstChild("TransparencyUtil")
			if v30 then
				v_u_5 = require(v30)
			end
		end
		v27 = v_u_5
	end
	if p25 and v_u_14.RightHidden then
		if v_u_14.RightArm and v_u_14.RightArm.Parent then
			v_u_14.RightArm.LocalTransparencyModifier = 0
		end
		v_u_14.RightHidden = false
		v_u_14.RightArm = nil
		if v27 and v27.CustomList then
			v27.CustomList["Right Arm"] = 0
		end
	end
	if p26 and v_u_14.LeftHidden then
		if v_u_14.LeftArm and v_u_14.LeftArm.Parent then
			v_u_14.LeftArm.LocalTransparencyModifier = 0
		end
		v_u_14.LeftHidden = false
		v_u_14.LeftArm = nil
		if v27 and v27.CustomList then
			v27.CustomList["Left Arm"] = 0
		end
	end
end
local v_u_32 = {
	["Right"] = nil,
	["Left"] = nil
}
v6.ViewmodelArms = {}
function v6.AttachArms(p33, p34, p35, p36, p37) -- name: AttachArms
	-- upvalues: (copy) v_u_24, (copy) v_u_32, (copy) v_u_3, (copy) v_u_13
	print(string.format("[ArmModelUtil-DEBUG] AttachArms called: viewmodel=%s, attachRight=%s, attachLeft=%s, mirrorLeft=%s", p34 and (p34.Name or "nil") or "nil", tostring(p35), tostring(p36), (tostring(p37))))
	if not p34 then
		warn("[ArmModelUtil] Cannot attach arms - viewmodel is nil")
		return {}
	end
	p33:DetachArms(p34)
	v_u_24(p35, p36)
	local v38 = {
		["Right"] = nil,
		["Left"] = nil,
		["RightWeld"] = nil,
		["LeftWeld"] = nil
	}
	local v39 = p35 and p34:FindFirstChild("Right Arm")
	if v39 then
		local v40
		if v_u_32.Right then
			v40 = v_u_32.Right
		else
			v40 = v_u_3:FindFirstChild("RightArm")
			if v40 then
				v_u_32.Right = v40
			else
				warn("[ArmModelUtil] Could not find arm template: RightArm")
				v40 = nil
			end
		end
		if v40 then
			local v41 = v40:Clone()
			v41.Name = "ArmModel_Right"
			v41.CanCollide = false
			v41.Anchored = false
			local v42, v43 = v_u_13()
			v41.Color = v42
			local v44 = v41:FindFirstChild("Clothing")
			if v44 and v44:IsA("Decal") then
				if v43 then
					v44.Texture = v43
				else
					v44.Transparency = 1
				end
			end
			local v45 = Instance.new("Motor6D")
			v45.Name = "ArmModelWeld"
			v45.Part0 = v39
			v45.Part1 = v41
			v45.C0 = CFrame.new(0, 0, 0)
			v45.C1 = CFrame.new(0, 0, 0)
			v45.Parent = v41
			v41.Parent = p34
			v38.Right = v41
			v38.RightWeld = v45
		end
	end
	if p36 then
		local v46, v47
		if p37 then
			v46 = p34:FindFirstChild("Right Arm")
			if v_u_32.Right then
				v47 = v_u_32.Right
			else
				v47 = v_u_3:FindFirstChild("RightArm")
				if v47 then
					v_u_32.Right = v47
				else
					warn("[ArmModelUtil] Could not find arm template: RightArm")
					v47 = nil
				end
			end
		else
			v46 = p34:FindFirstChild("Left Arm")
			if v_u_32.Left then
				v47 = v_u_32.Left
			else
				v47 = v_u_3:FindFirstChild("LeftArm")
				if v47 then
					v_u_32.Left = v47
				else
					warn("[ArmModelUtil] Could not find arm template: LeftArm")
					v47 = nil
				end
			end
		end
		if v46 and v47 then
			local v48 = v47:Clone()
			v48.Name = "ArmModel_Left"
			v48.CanCollide = false
			v48.Anchored = false
			local v49 = p37 and (v48:FindFirstChildOfClass("FileMesh") or v48:FindFirstChildOfClass("SpecialMesh"))
			if v49 then
				v49.Scale = Vector3.new(-1, 1, 1)
			end
			local v50, v51 = v_u_13()
			v48.Color = v50
			local v52 = v48:FindFirstChild("Clothing")
			if v52 and v52:IsA("Decal") then
				if v51 then
					v52.Texture = v51
				else
					v52.Transparency = 1
				end
			end
			local v53 = Instance.new("Motor6D")
			v53.Name = "ArmModelWeld"
			v53.Part0 = v46
			v53.Part1 = v48
			if p37 then
				v53.C0 = CFrame.Angles(0, -3.141592653589793, 0)
			else
				v53.C0 = CFrame.new(0, 0, 0)
			end
			v53.C1 = CFrame.new(0, 0, 0)
			v53.Parent = v48
			v48.Parent = p34
			v38.Left = v48
			v38.LeftWeld = v53
		end
	end
	p33.ViewmodelArms[p34] = v38
	print(string.format("[ArmModelUtil-DEBUG] AttachArms complete: Right=%s, Left=%s", v38.Right and "attached" or "none", v38.Left and "attached" or "none"))
	return v38
end
function v6.DetachArms(p54, p55) -- name: DetachArms
	-- upvalues: (copy) v_u_31
	local v56 = p54.ViewmodelArms[p55]
	if v56 then
		local v57 = v56.Right ~= nil
		local v58 = v56.Left ~= nil
		if v56.Right then
			v56.Right:Destroy()
		end
		if v56.Left then
			v56.Left:Destroy()
		end
		p54.ViewmodelArms[p55] = nil
		v_u_31(v57, v58)
	end
end
function v6.GetArms(p59, p60) -- name: GetArms
	return p59.ViewmodelArms[p60]
end
function v6.HasArms(p61, p62) -- name: HasArms
	local v63 = p61.ViewmodelArms[p62]
	local v64
	if v63 == nil then
		v64 = false
	else
		v64 = v63.Right ~= nil and true or v63.Left ~= nil
	end
	return v64
end
function v6.SetArmVisibility(p65, p66, p67, p68) -- name: SetArmVisibility
	local v69 = p65.ViewmodelArms[p66]
	if v69 then
		if v69.Right then
			v69.Right.Transparency = p67 and 0 or 1
		end
		if v69.Left then
			v69.Left.Transparency = p68 and 0 or 1
		end
	end
end
return v6