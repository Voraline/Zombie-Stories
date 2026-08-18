local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = v_u_1.common
local v_u_3 = require(script.Parent.SkinApplier)
local v_u_4 = require(script.Parent.SkinFormat)
local v_u_5 = require(v2:WaitForChild("SkinUtil"))
local v_u_6 = require(v2:WaitForChild("Promise"))
local v_u_7 = nil
local v_u_8 = nil
local v_u_10 = {
	["init"] = function(p9) -- name: init
		-- upvalues: (ref) v_u_7, (ref) v_u_8
		v_u_7 = p9.WepConfig
		v_u_8 = p9.streamOrFindVModel
	end
}
local function v_u_24(p11, p12, _) -- name: applySkinToViewmodel
	-- upvalues: (copy) v_u_1, (copy) v_u_10, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
	local v13 = v_u_1:FindFirstChild("ViewmodelOverride")
	if not (v13 and v13:GetAttribute("SkinSDKVersion")) then
		local v14 = v_u_4.classify(p11)
		if v14.type == "skinsdk_model" then
			local v15 = p12.BaseName or p12.WeaponName
			local v16 = v_u_10.loadViewmodel(v15, p12):expect():Clone()
			v16.Name = p11.Name
			v_u_3:ApplyCreatorSkin(v16, p11)
			v16:SetAttribute("GlobalPartsApplied", true)
			return v16, true
		end
		if not p11:IsA("ModuleScript") then
			if v14.type ~= "configuration" then
				if v14.type ~= "derived_model" then
					return p11, false
				end
				if p12 and (p12.BaseName and (p12.BaseName ~= p12.WeaponName and (p11.Name ~= p12.BaseName and not p11:GetAttribute("GlobalPartsApplied")))) then
					p11:SetAttribute("GlobalPartsApplied", true)
					v_u_3:AddGlobalParts(p11, (v_u_10.loadViewmodel(p12.BaseName, p12, true):expect()))
				end
				return p11, false
			end
			local v17 = v_u_10.loadViewmodel(p12.BaseName, p12):expect():Clone()
			v17.Name = p11.Name
			v_u_3:ApplyFolder(v17, p11)
			v17:SetAttribute("GlobalPartsApplied", true)
			return v17, true
		end
		local v18 = p12.BaseName or p12.WeaponName
		local v19 = v_u_10.loadViewmodel(v18, p12):expect():Clone()
		v19.Name = p11.Name
		local v20 = require(p11)
		v_u_3:DecodeSkin(v19, p11)
		if v20 then
			v20(v19, v_u_5)
		end
		v19:SetAttribute("GlobalPartsApplied", true)
		return v19, true
	end
	local v21 = v13:Clone()
	v13:Destroy()
	local v22 = v_u_1:FindFirstChild("SkinCreatorOverride")
	if v22 then
		v22:Destroy()
	end
	local v23 = v_u_10.loadViewmodel(p12.WeaponName, p12):expect():Clone()
	v23.Name = p11.Name
	v_u_3:ApplyCreatorSkin(v23, v21)
	v21:Destroy()
	v23:SetAttribute("GlobalPartsApplied", true)
	v23:SetAttribute("BaseWeaponName", p12.WeaponName)
	v23.Name = "SkinCreatorOverride"
	v23.Parent = v_u_1
	return v23, true
end
local function v_u_32(p25, p26) -- name: applyStockGlobalParts
	if not p25:GetAttribute("GlobalPartsApplied") and (not p26.BaseName or p26.BaseName == p26.WeaponName) then
		p25:SetAttribute("GlobalPartsApplied", true)
		if p25:FindFirstChild("GlobalParts") and p25.GlobalParts:FindFirstChild("ToWeapon") then
			local v27 = p25.GlobalParts.ToWeapon:Clone()
			local v28 = p25.KeyParts.Handle
			for _, v29 in v27:QueryDescendants("BasePart") do
				local v30 = Instance.new("Weld")
				v30.Name = v28.Name .. ":" .. v29.Name
				v30.Part0 = v28
				v30.Part1 = v29
				v30.C0 = CFrame.new()
				v30.C1 = v29.CFrame:toObjectSpace(v28.CFrame)
				v30.Parent = v28
			end
			for _, v31 in v27:GetChildren() do
				v31.Parent = p25.Weapon
			end
			v27:Destroy()
		end
	end
end
function v_u_10.loadViewmodel(p_u_33, p_u_34) -- name: loadViewmodel
	-- upvalues: (copy) v_u_6, (ref) v_u_7, (ref) v_u_8, (copy) v_u_24, (copy) v_u_32, (copy) v_u_1
	return v_u_6.new(function(p35, p36, _)
		-- upvalues: (ref) p_u_34, (ref) v_u_7, (ref) p_u_33, (ref) v_u_8, (ref) v_u_24, (ref) v_u_32, (ref) v_u_1
		if not p_u_34 then
			p_u_34 = v_u_7:GetWeaponConfig(p_u_33)
		end
		local v37 = p_u_34 ~= nil
		local v38 = "No config found for " .. p_u_33
		assert(v37, v38)
		p_u_33 = p_u_34.UseVModel or p_u_33
		local v39 = v_u_8(p_u_33)
		if v39 then
			local v40, v41 = v_u_24(v39, p_u_34, p_u_33)
			v_u_32(v40, p_u_34)
			if v40 and v40.PrimaryPart then
				v40.PrimaryPart.Anchored = true
			end
			local v42 = v_u_1:FindFirstChild("SkinCreatorOverride")
			if v42 then
				if v42:GetAttribute("BaseWeaponName") ~= p_u_34.WeaponName then
					v42 = v40
				end
			else
				v42 = v40
			end
			p35(v42, v41)
		else
			p36("Failed to load model: " .. p_u_33 .. " (timeout)")
		end
	end)
end
function v_u_10.setupGunGameListeners() -- name: setupGunGameListeners
	-- upvalues: (ref) v_u_7
	local v43 = require("@game/ReplicatedStorage/common/zap")
	local v_u_44 = {}
	v43.PreloadWeapons.On(function(p45)
		-- upvalues: (ref) v_u_7, (copy) v_u_44
		for _, v_u_46 in p45.Weapons do
			v_u_7:StreamViewmodel(v_u_46):andThen(function(p47)
				-- upvalues: (copy) v_u_46, (ref) v_u_44
				if p47:IsA("Model") then
					local v48 = p47:Clone()
					v48.Name = v_u_46
					v48:PivotTo(CFrame.new(0, -1000, 0))
					v48.Parent = workspace
					local v49 = v_u_44
					table.insert(v49, v48)
				end
			end)
		end
	end)
	v43.ClearPreloadedWeapons.On(function(_)
		-- upvalues: (copy) v_u_44, (ref) v_u_7
		for _, v50 in v_u_44 do
			v50:Destroy()
		end
		v_u_7:ClearCache()
	end)
end
return v_u_10