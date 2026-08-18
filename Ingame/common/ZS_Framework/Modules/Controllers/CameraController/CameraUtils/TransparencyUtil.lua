local v_u_1 = game:GetService("Players").LocalPlayer
local v2 = script.Parent.Parent.Parent
local v_u_3 = {}
local v_u_4 = {}
local v_u_5 = {}
local v_u_6 = {
	"Left ArmMesh",
	"Right ArmMesh",
	"Left LegMesh",
	"Right LegMesh",
	"TorsoMesh"
}
local v_u_7 = require(v2:WaitForChild("LocalPlayerController"))
local v_u_9 = {
	["TransparencyModifier"] = 1,
	["CustomList"] = {
		["Left Arm"] = 0,
		["Right Arm"] = 0,
		["Left Leg"] = 0,
		["Right Leg"] = 0,
		["Torso"] = 0,
		["HumanoidRootPart"] = 0
	},
	["Init"] = function(_) -- name: Init
		-- upvalues: (copy) v_u_7
		v_u_7.CharacterChanged:Connect(function(p8)
			if p8 then
				SetupCharacter(p8)
			end
		end)
		if v_u_7.character then
			SetupCharacter(v_u_7.character)
		end
	end,
	["Update"] = function(_) -- name: Update
		UpdateTransparency()
	end
}
local function v_u_12(p10) -- name: isTurkeyRigPart
	-- upvalues: (copy) v_u_1
	if not p10 then
		return false
	end
	local v11 = p10.Parent
	while v11 and v11 ~= v_u_1.Character do
		if v11:IsA("Model") and string.find(v11.Name, "_TurkeyRig") then
			return true
		end
		v11 = v11.Parent
	end
	return false
end
function UpdateTransparency() -- name: UpdateTransparency
	-- upvalues: (copy) v_u_3, (copy) v_u_12, (copy) v_u_9, (copy) v_u_5
	for _, v13 in v_u_3 do
		v13.CastShadow = false
		if v13.Name == "Torso" and v_u_12(v13) then
			v13.LocalTransparencyModifier = v_u_9.TransparencyModifier
		else
			v13.LocalTransparencyModifier = v_u_9.CustomList[v13.Name] or v_u_9.TransparencyModifier
		end
	end
	for v14, v15 in v_u_5 do
		if v14 and v14.Parent then
			if v_u_9.TransparencyModifier == 1 then
				v14.Transparency = 1
			else
				v14.Transparency = v15
			end
		end
	end
end
function SetupCharacter(p_u_16) -- name: SetupCharacter
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_9
	table.clear(v_u_3)
	table.clear(v_u_4)
	table.clear(v_u_5)
	for _, v17 in p_u_16:QueryDescendants("BasePart") do
		local v18 = v_u_3
		table.insert(v18, v17)
		for _, v19 in v_u_6 do
			if p_u_16:FindFirstChild(v19) then
				v_u_9.CustomList[p_u_16:FindFirstChild(v19).Name] = 0
				if v17:IsDescendantOf(p_u_16:FindFirstChild(v19)) then
					v_u_9.CustomList[v17.Name] = 0
				end
			end
		end
	end
	for _, v20 in p_u_16:QueryDescendants("Decal, Texture") do
		local v21 = v_u_4
		table.insert(v21, v20)
		v_u_5[v20] = v20.Transparency
	end
	p_u_16.DescendantAdded:Connect(function(p22)
		-- upvalues: (ref) v_u_3, (ref) v_u_6, (ref) v_u_9, (copy) p_u_16, (ref) v_u_4, (ref) v_u_5
		if p22:IsA("BasePart") then
			local v23 = v_u_3
			table.insert(v23, p22)
			for _, v24 in v_u_6 do
				if p22.Name == v24 then
					v_u_9.CustomList[p22.Name] = 0
				elseif p_u_16:FindFirstChild(v24) and p22:IsDescendantOf(p_u_16:FindFirstChild(v24)) then
					v_u_9.CustomList[p22.Name] = 0
				end
			end
			UpdateTransparency()
		elseif p22:IsA("Decal") or p22:IsA("Texture") then
			local v25 = v_u_4
			table.insert(v25, p22)
			v_u_5[p22] = p22.Transparency
			UpdateTransparency()
		end
	end)
	UpdateTransparency()
end
return v_u_9