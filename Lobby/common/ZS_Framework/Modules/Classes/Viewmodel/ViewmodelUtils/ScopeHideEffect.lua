local v_u_1 = {}
local v_u_2 = {}
local v_u_3 = {}
local v4 = {}
function easeInQuart(p5) -- name: easeInQuart
	return p5 * p5 * p5 * p5
end
local function v_u_14(p6) -- name: initialize
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v7 = {}
	v_u_1[p6] = v7
	local v8 = {}
	v_u_2[p6] = v8
	local v9 = Instance.new("Folder")
	v9.Name = "GlassParts"
	v9.Parent = p6
	for _, v10 in p6:QueryDescendants("BasePart[$HideScope]") do
		table.insert(v7, v10)
		v10:SetAttribute("OriginalTransparency", v10.Transparency)
		if v10.Material ~= Enum.Material.Glass and not v10:GetAttribute("NoGlass") then
			local v11 = v10:Clone()
			v11.Material = "Glass"
			v11.Transparency = v11.Transparency * 0.5
			v11:SetAttribute("OriginalTransparency", v11.Transparency)
			table.insert(v8, v11)
			local v12 = Instance.new("Weld")
			v12.Part0 = v10
			v12.Part1 = v11
			v12.Parent = v11
			v11.Parent = v9
		end
	end
	for _, v13 in p6:QueryDescendants("Texture") do
		if v13.Parent:GetAttribute("HideScope") then
			v13:SetAttribute("OriginalTransparency", v13.Transparency)
			table.insert(v7, v13)
		end
	end
end
function v4.Update(_, p15, p16) -- name: Update
	-- upvalues: (copy) v_u_1, (copy) v_u_14, (copy) v_u_2, (copy) v_u_3
	if not v_u_1[p15] then
		v_u_14(p15)
	end
	local v17 = v_u_1[p15]
	local v18 = v_u_2[p15]
	local v19 = easeInQuart(p16.Position)
	local v20 = math.min(v19, 0.5) * 2
	for _, v21 in v17 do
		local v22 = v21:GetAttribute("OriginalTransparency") or 0
		v21.Transparency = v22 + (1 - v22) * v20
		if v21:IsA("BasePart") and v21.Material == Enum.Material.Glass then
			local v23 = v21.Transparency ~= 1
			if v23 or v21.Parent == nil then
				if v23 and v21.Parent == nil then
					v21.Parent = v_u_3[v21]
				end
			else
				v_u_3[v21] = v21.Parent
				v21.Parent = nil
			end
		end
	end
	local v24 = v19 - 0.45
	local v25 = math.max(v24, 0) * 2
	local v26 = math.min(v25, 1)
	for _, v27 in v18 do
		local v28 = v27:GetAttribute("OriginalTransparency")
		v27.Transparency = v28 + (1 - v28) * v26
		if v26 == 0 then
			if v27.Parent ~= nil then
				v_u_3[v27] = v27.Parent
				v27.Parent = nil
			end
		else
			local v29 = v27.Transparency ~= 1
			if v29 or v27.Parent == nil then
				if v29 and v27.Parent == nil then
					v27.Parent = v_u_3[v27]
				end
			else
				v_u_3[v27] = v27.Parent
				v27.Parent = nil
			end
		end
	end
end
return v4