local function v_u_6(p1, p2) -- name: split
	local v3 = {}
	for v4 in p1:gmatch((("([^%s]+)"):format(p2))) do
		local v5 = tonumber(v4)
		table.insert(v3, v5)
	end
	return unpack(v3)
end
local v_u_7 = game:GetService("HttpService")
local v8 = {}
local function v_u_13(p9, p10) -- name: ApplyAttributes
	for v11, v12 in p9:GetAttributes() do
		if v11 ~= "Skin" then
			p10:SetAttribute(v11, v12)
		end
	end
end
function v8.ApplyFolder(_, p14, p15) -- name: ApplyFolder
	-- upvalues: (copy) v_u_13
	if not p15:GetAttribute("DontHideGun") then
		p14.Weapon:ClearAllChildren()
	end
	for _, v16 in p15:GetChildren() do
		if v16:IsA("Model") then
			local v17 = v16:Clone()
			if not v17:GetAttribute("CustomWelded") then
				for _, v18 in v17:QueryDescendants("BasePart") do
					if v18 ~= v17.PrimaryPart then
						local v19 = v17.PrimaryPart
						local v20 = Instance.new("Weld")
						v20.Name = v19.Name .. ":" .. v18.Name
						v20.Part0 = v19
						v20.Part1 = v18
						v20.C0 = CFrame.new()
						v20.C1 = v18.CFrame:toObjectSpace(v19.CFrame)
						v20.Parent = v19
					end
					v18.Anchored = false
					v18.CanCollide = false
					v18.CanTouch = false
					v18.CanQuery = false
				end
			end
			local v21 = p14.KeyParts[v17.Name]
			local v22 = v17.PrimaryPart
			local v23 = Instance.new("Weld")
			v23.Name = v22.Name .. ":" .. v21.Name
			v23.Part0 = v22
			v23.Part1 = v21
			v23.Parent = v22
			for _, v24 in v17:GetChildren() do
				if v24.Name == "Override" then
					v24.Name = v21.Name
					v21.Name = "Overidden"
					v24.Parent = v21.Parent
				elseif v24 ~= v17.PrimaryPart then
					v24.Parent = p14.Weapon
				end
			end
			v17.Parent = p14.Weapon
		end
	end
	v_u_13(p15, p14)
	if p14:FindFirstChild("Animations") and p15:FindFirstChild("Animations") then
		for _, v25 in p14.Animations:GetChildren() do
			local v26 = p15.Animations:FindFirstChild(v25.Name)
			if v26 then
				v26:Clone().Parent = v25.Parent
				v25:Destroy()
			end
		end
	end
	p14.Parent = workspace
	local v27 = p14:FindFirstChild("GlobalParts")
	local v28 = p15:FindFirstChild("GlobalParts")
	local v29 = p15:FindFirstChild("Handle")
	if v28 and (v27 and (v29 and v29.PrimaryPart)) then
		local v30 = v28:Clone()
		local v31 = v29.PrimaryPart:Clone()
		local v32 = Instance.new("Model")
		v31.Parent = v32
		v30.Parent = v32
		v32.PrimaryPart = v31
		local v33 = p14.KeyParts.Handle
		v32:PivotTo(v33.CFrame)
		v30.Parent = nil
		v32:Destroy()
		local v34 = {}
		for _, v35 in v27:QueryDescendants("BasePart") do
			for _, v36 in v35:GetJoints() do
				if v36:IsA("JointInstance") then
					local v37
					if v36.Part0 == v35 then
						v37 = v36.Part1
					else
						v37 = v36.Part0
					end
					if v37 then
						if v37.Name ~= "Handle" then
							v34[v35.Name] = v37
							break
						end
						if not v34[v35.Name] then
							v34[v35.Name] = v37
						end
					end
				end
			end
			local v38 = v30.BasePoints:FindFirstChild(v35.Name)
			if v38 then
				local v39
				if v34[v35.Name] then
					v39 = v34[v35.Name]
				else
					v39 = v33
				end
				local v40 = Instance.new("Weld")
				v40.Name = v39.Name .. ":" .. v38.Name
				v40.Part0 = v39
				v40.Part1 = v38
				v40.C0 = CFrame.new()
				v40.C1 = v38.CFrame:toObjectSpace(v39.CFrame)
				v40.Parent = v39
				v38.Parent = v35.Parent
				v35:Destroy()
			end
		end
	end
	p14.Parent = nil
end
function v8.DecodeSkin(_, p41, p42) -- name: DecodeSkin
	-- upvalues: (copy) v_u_13, (copy) v_u_7, (copy) v_u_6
	v_u_13(p42, p41)
	local v43 = p42:GetAttribute("Skin")
	if not v43 then
		return
	end
	local v44 = {}
	for v45, v46 in pairs(v_u_7:JSONDecode(v43)) do
		for _, v47 in p41.Weapon:QueryDescendants("BasePart") do
			if v47:GetAttribute("uid") == v45 then
				v44[v47:GetAttribute("uid")] = true
				if v46.Color then
					v47.Color = Color3.new(v_u_6(v46.Color, ","))
				end
				if v46.Material then
					v47.Material = Enum.Material[v46.Material]
				end
				if v46.Reflectance then
					v47.Reflectance = v46.Reflectance
				end
				if v46.Transparency then
					v47.Transparency = v46.Transparency
				end
				if v47:IsA("UnionOperation") and v46.UsePartColor then
					v47.UsePartColor = v46.UsePartColor
				end
				break
			end
		end
	end
end
function v8.AddGlobalParts(_, p48, p49) -- name: AddGlobalParts
	local v50 = p49:Clone()
	v50.Parent = workspace.Ignore
	local v51 = not p48.KeyParts:FindFirstChild("BulletEjection", true) and v50.KeyParts:FindFirstChild("BulletEjection", true)
	if v51 then
		v51:Clone().Parent = p48.KeyParts.Handle
	end
	if p48:FindFirstChild("Animations") then
		if p48:FindFirstChild("Animations") then
			for _, v52 in v50:WaitForChild("Animations"):GetChildren() do
				if v52.Name ~= "3P" and (v52.Name ~= "Idle" and (v52.Name ~= "Shoot" and not p48.Animations:FindFirstChild(v52.Name))) then
					v52:Clone().Parent = p48.Animations
				end
			end
		end
	else
		v50.Animations:Clone().Parent = p48
	end
	local v53 = v50:FindFirstChild("GlobalParts")
	local v54 = p48:FindFirstChild("GlobalParts")
	if v53 then
		p48:PivotTo(v50.PrimaryPart.CFrame)
		local v55 = v53:Clone()
		local v56 = {}
		if v54 then
			if v55:FindFirstChild("BasePoints") and v54:FindFirstChild("BasePoints") then
				for _, v57 in v54.BasePoints:GetChildren() do
					if v55.BasePoints:FindFirstChild(v57.Name) then
						v56[v57.Name] = false
						v55.BasePoints[v57.Name]:Destroy()
					end
					v57.Parent = v55.BasePoints
				end
			end
			for _, v58 in v55:GetChildren() do
				if v58.Name ~= "BasePoints" and (v58:IsA("Folder") and v54:FindFirstChild(v58.Name)) then
					v58:Destroy()
				end
			end
		end
		for _, v59 in v53:QueryDescendants("BasePart") do
			if v56[v59.Name] ~= false then
				local v60 = nil
				for _, v61 in v59:GetJoints() do
					if v61:IsA("JointInstance") then
						local v62
						if v61.Part0 == v59 then
							v62 = v61.Part1
						else
							v62 = v61.Part0
						end
						if v62 then
							if v62.Name ~= "Handle" then
								v60 = v62.Name
								break
							end
							if not v60 then
								v60 = v62.Name
							end
						end
					end
				end
				if v60 then
					v56[v59.Name] = v60
				end
			end
		end
		for _, v63 in v55:QueryDescendants("BasePart") do
			v63:BreakJoints()
			if v56[v63.Name] then
				local v64 = p48.KeyParts:FindFirstChild(v56[v63.Name]) or p48.KeyParts.Handle
				local v65 = Instance.new("Weld")
				v65.Name = v64.Name .. ":" .. v63.Name
				v65.Part0 = v64
				v65.Part1 = v63
				v65.C0 = CFrame.new()
				v65.C1 = v63.CFrame:toObjectSpace(v64.CFrame)
				v65.Parent = v64
			end
		end
		if v54 then
			for _, v66 in v55:GetChildren() do
				if v66.Name == "BasePoints" then
					for _, v67 in v66:GetChildren() do
						v67.Parent = v54.BasePoints
					end
				else
					v66.Parent = v54
				end
			end
			v55:Destroy()
		else
			v55.Parent = p48
			v54 = v55
		end
		if v54 and v54:FindFirstChild("ToWeapon") then
			for _, v68 in v54.ToWeapon:QueryDescendants("BasePart") do
				local v69 = p48.KeyParts.Handle
				local v70 = Instance.new("Weld")
				v70.Name = v69.Name .. ":" .. v68.Name
				v70.Part0 = v69
				v70.Part1 = v68
				v70.C0 = CFrame.new()
				v70.C1 = v68.CFrame:toObjectSpace(v69.CFrame)
				v70.Parent = v69
			end
			for _, v71 in v54.ToWeapon:GetChildren() do
				if p48.Weapon:FindFirstChild(v71.Name) then
					for _, v72 in v71:GetChildren() do
						v72.Parent = p48.Weapon[v71.Name]
					end
					v71:Destroy()
				else
					v71.Parent = p48.Weapon
				end
			end
		end
	end
	v50:Destroy()
end
function v8.ApplyCreatorSkin(_, p73, p74) -- name: ApplyCreatorSkin
	if not p74:GetAttribute("DontHideGun") then
		p73.Weapon:ClearAllChildren()
	end
	p73.Parent = workspace
	local v75 = p74:FindFirstChild("Geometry")
	if v75 then
		for _, v76 in v75:GetChildren() do
			if v76:IsA("Model") then
				local v77 = v76:Clone()
				local v78 = v77:GetAttribute("WeldTarget") or "Handle"
				local v79 = p73.KeyParts:FindFirstChild(v78) or p73.KeyParts.Handle
				local v80 = v77:FindFirstChild("AttachmentWeld", true)
				if v80 and v80:IsA("BasePart") then
					v77.PrimaryPart = v80
				elseif not v77.PrimaryPart then
					for _, v81 in v77:GetDescendants() do
						if v81:IsA("BasePart") then
							v77.PrimaryPart = v81
							break
						end
					end
				end
				local v82 = v77:GetAttribute("VisibilityRule")
				local v83 = v82 == "Replace"
				if v83 then
					if v77.PrimaryPart then
						v77:PivotTo(v79.CFrame)
					end
				elseif v77.PrimaryPart then
					v77:PivotTo(v79.CFrame * v77:GetPivot())
				end
				if v77.PrimaryPart and not v77:GetAttribute("CustomWelded") then
					for _, v84 in v77:GetDescendants() do
						if v84:IsA("BasePart") then
							if v84 ~= v77.PrimaryPart then
								local v85 = v77.PrimaryPart
								local v86 = Instance.new("Weld")
								v86.Name = v85.Name .. ":" .. v84.Name
								v86.Part0 = v85
								v86.Part1 = v84
								v86.C0 = CFrame.new()
								v86.C1 = v84.CFrame:toObjectSpace(v85.CFrame)
								v86.Parent = v85
							end
							if not v83 or v84 ~= v77.PrimaryPart then
								v84.Anchored = false
							end
							v84.CanCollide = false
							v84.CanTouch = false
							v84.CanQuery = false
						end
					end
				end
				if not v83 and v77.PrimaryPart then
					local v87 = v77.PrimaryPart
					local v88 = Instance.new("Weld")
					v88.Name = v79.Name .. ":" .. v87.Name
					v88.Part0 = v79
					v88.Part1 = v87
					v88.C0 = CFrame.new()
					v88.C1 = v87.CFrame:toObjectSpace(v79.CFrame)
					v88.Parent = v79
				end
				v77.Parent = p73.Weapon
				if v82 == "Show" or v83 then
					for _, v89 in v77:GetDescendants() do
						if v89:IsA("BasePart") or (v89:IsA("Decal") or v89:IsA("Texture")) then
							v89:SetAttribute("VisibilityOrigTransparency", v89.Transparency)
							v89.Transparency = 1
						elseif v89:IsA("Beam") or v89:IsA("ParticleEmitter") then
							v89:SetAttribute("VisibilityOrigEnabled", v89.Enabled)
							v89.Enabled = false
						end
					end
				end
			end
		end
	end
	local v90 = p74:FindFirstChild("BasePoints")
	local v91 = p73:FindFirstChild("GlobalParts")
	if v90 and v91 then
		local v92 = v91:FindFirstChild("BasePoints")
		if v92 then
			for _, v93 in v90:GetChildren() do
				if v93:IsA("BasePart") then
					local v94 = v92:FindFirstChild(v93.Name)
					local v95 = v93:GetAttribute("WeldTarget") or "Handle"
					local v96 = p73.KeyParts:FindFirstChild(v95) or p73.KeyParts.Handle
					local v97 = v93:FindFirstChildWhichIsA("Weld")
					local v98 = v97 and v97.C0 or CFrame.new()
					local v99 = v93:Clone()
					v99.Anchored = false
					v99.CanCollide = false
					v99.CanTouch = false
					v99.CanQuery = false
					local v100 = v99:FindFirstChildWhichIsA("Weld")
					if v100 then
						v100:Destroy()
					end
					v99.CFrame = v96.CFrame * v98
					local v101 = Instance.new("Weld")
					v101.Name = v96.Name .. ":" .. v99.Name
					v101.Part0 = v96
					v101.Part1 = v99
					v101.C0 = CFrame.new()
					v101.C1 = v99.CFrame:toObjectSpace(v96.CFrame)
					v101.Parent = v96
					v99.Parent = v92
					if v94 then
						v94:BreakJoints()
						v94:Destroy()
					end
				end
			end
		end
	end
	local v102 = p74:FindFirstChild("Animations")
	if v102 and p73:FindFirstChild("Animations") then
		for _, v103 in v102:GetChildren() do
			if v103:IsA("Animation") then
				local v104 = p73.Animations:FindFirstChild(v103.Name)
				if v104 then
					v104:Destroy()
				end
				v103:Clone().Parent = p73.Animations
			end
		end
	end
	local v105 = {
		["SkinSDKVersion"] = true,
		["BaseWeapon"] = true,
		["DontHideGun"] = true,
		["Author"] = true,
		["Category"] = true
	}
	for v106, v107 in p74:GetAttributes() do
		if not v105[v106] then
			p73:SetAttribute(v106, v107)
		end
	end
	local v108 = p74:FindFirstChild("KeyPartOverrides")
	if v108 then
		local v109 = v108:GetAttribute("BarrelOffset")
		local v110 = v108:GetAttribute("BarrelSize")
		local v111 = (v109 or v110) and p73.KeyParts:FindFirstChild("Barrel")
		if v111 then
			local v112 = v111:FindFirstChild("BulletEjection")
			local v113
			if v112 and v112:IsA("BasePart") then
				v113 = v112.CFrame or nil
			else
				v113 = nil
			end
			if v109 then
				v111.CFrame = v111.CFrame * v109
			end
			if v110 then
				v111.Size = v110
			end
			if v112 and v113 then
				v112:BreakJoints()
				v112.CFrame = v113
				local v114 = Instance.new("Weld")
				v114.Name = v111.Name .. ":" .. v112.Name
				v114.Part0 = v111
				v114.Part1 = v112
				v114.C0 = CFrame.new()
				v114.C1 = v112.CFrame:toObjectSpace(v111.CFrame)
				v114.Parent = v111
			end
		end
		local v115 = v108:GetAttribute("AimPartOffset")
		if v115 then
			p73:SetAttribute("SkinAimPartOffset", v115)
		end
	end
	if v75 then
		local v116 = {}
		for _, v117 in v75:GetChildren() do
			if v117:IsA("Model") then
				local v118 = v117:GetAttribute("OptionGroup")
				if v118 and v118 ~= "" then
					if not v116[v118] then
						v116[v118] = {}
					end
					local v119 = v116[v118]
					local v120 = {
						["name"] = v117.Name,
						["isDefault"] = v117:GetAttribute("OptionGroupDefault") or false
					}
					table.insert(v119, v120)
				end
			end
		end
		for _, v121 in v116 do
			local v122 = false
			for _, v123 in v121 do
				if v123.isDefault then
					v122 = true
					break
				end
			end
			for v124, v125 in v121 do
				local v126
				if v122 then
					v126 = v125.isDefault
				else
					v126 = v124 == 1
				end
				if not v126 then
					local v127 = p73:FindFirstChild("Weapon")
					if v127 then
						v127 = v127:FindFirstChild(v125.name)
					end
					if v127 then
						for _, v128 in v127:GetDescendants() do
							if v128:IsA("BasePart") or (v128:IsA("Decal") or v128:IsA("Texture")) then
								v128:SetAttribute("OptionGroupHidden", true)
								v128:SetAttribute("OrigTransparency", v128.Transparency)
								v128.Transparency = 1
							elseif v128:IsA("Beam") or v128:IsA("ParticleEmitter") then
								v128:SetAttribute("OptionGroupHidden", true)
								v128:SetAttribute("OrigEnabled", v128.Enabled)
								v128.Enabled = false
							end
						end
					end
				end
			end
		end
	end
	if not v75 then
		::l140::
		if v75 then
			local v129 = p73:FindFirstChild("GlobalParts")
			if v129 then
				v129 = v129:FindFirstChild("BasePoints")
			end
			if v129 then
				local v130 = {}
				for _, v131 in v75:GetChildren() do
					if v131:IsA("Model") then
						local v132 = p73:FindFirstChild("Weapon")
						if v132 then
							v132 = v132:FindFirstChild(v131.Name)
						end
						if v132 then
							local v133 = v132:FindFirstChildWhichIsA("BasePart", true)
							if not (v133 and v133:GetAttribute("OptionGroupHidden")) then
								goto l171
							end
						else
							::l171::
							for v134, v135 in v131:GetAttributes() do
								if string.sub(v134, 1, 13) == "NodeOverride_" then
									local v136 = string.sub(v134, 14)
									local v137 = string.split(tostring(v135), ",")
									if #v137 == 3 then
										local v138 = v137[1]
										local v139 = tonumber(v138) or 0
										local v140 = v137[2]
										local v141 = tonumber(v140) or 0
										local v142 = v137[3]
										local v143 = tonumber(v142) or 0
										v130[v136] = Vector3.new(v139, v141, v143)
									end
								end
							end
						end
					end
				end
				local v144 = p73:FindFirstChild("Handle") or p73.PrimaryPart
				for v145, v148 in v130 do
					local v147 = v129:FindFirstChild(v145)
					if v147 and v147:IsA("BasePart") then
						if v144 then
							local v148 = v144.CFrame:VectorToWorldSpace(v148)
						end
						v147.CFrame = CFrame.new(v147.CFrame.Position + v148) * v147.CFrame.Rotation
					end
				end
				goto l161
			end
		end
		::l161::
		p73.Parent = nil
		return
	end
	local v149 = p73:FindFirstChild("Weapon")
	local v150 = {}
	for _, v151 in v75:GetChildren() do
		if v151:IsA("Model") then
			local v152
			if v149 then
				v152 = v149:FindFirstChild(v151.Name)
			else
				v152 = v149
			end
			if v152 then
				local v153 = v152:FindFirstChildWhichIsA("BasePart", true)
				if not (v153 and v153:GetAttribute("OptionGroupHidden")) then
					goto l147
				end
			else
				::l147::
				local v154 = v151:GetAttribute("LockedNodes")
				if v154 and v154 ~= "" then
					for _, v155 in string.split(v154, ",") do
						v150[v155] = true
					end
				end
			end
		end
	end
	if next(v150) then
		local v156 = {}
		for v157 in v150 do
			table.insert(v156, v157)
		end
		p73:SetAttribute("SkinLockedNodes", table.concat(v156, ","))
	else
		p73:SetAttribute("SkinLockedNodes", nil)
	end
	goto l140
end
return v8