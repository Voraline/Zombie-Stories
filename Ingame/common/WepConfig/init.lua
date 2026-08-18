local v1 = game:GetService("RunService")
local v_u_2 = v1:IsClient()
local v_u_3 = v1:IsServer()
local v_u_4 = pcall(v1.IsEdit, v1)
if v1:IsStudio() and (v_u_4 and (v1:IsRunning() ~= true and not v1:IsRunMode())) then
	v_u_3 = true
	v_u_2 = false
	v_u_4 = true
end
local v5 = game:GetService("ReplicatedStorage")
if v_u_3 then
	local v6 = game:GetService("ServerStorage")
end
local v7 = game:GetService("HttpService")
local v_u_8 = workspace:WaitForChild("Values"):WaitForChild("IsLobby")
local v9 = v5.common.RedEvents
local v_u_10 = v5.common:WaitForChild("SharedResources")
local v11 = v5.common
local v_u_12 = v_u_3 and v6.common.ServerResources.Configs or v_u_10:WaitForChild("Configs")
local v_u_13 = v_u_3 and v6.common.ServerResources.VModels or v_u_10:WaitForChild("VModels")
local v_u_14 = require(v11:WaitForChild("ItemData"))
if v_u_2 then
	local v15 = require(v11:WaitForChild("ChunkReceiver"))
end
local v16
if v_u_3 and not v_u_4 then
	v16 = require("@game/ServerStorage/common/ChunkSender")
else
	v16 = nil
end
local v_u_17 = require(script.SkinFormat)
if v_u_2 then
	if v_u_12:GetAttribute("NonExisting") == "" then
		v_u_12:GetAttributeChangedSignal("NonExisting"):Wait()
	end
	if v_u_12:GetAttribute("NonExistingVMs") == "" then
		v_u_12:GetAttributeChangedSignal("NonExistingVMs"):Wait()
	end
end
if v_u_2 then
	local v_u_18 = v7:JSONDecode(v_u_12:GetAttribute("NonExisting"))
end
if v_u_2 then
	local v_u_19 = v7:JSONDecode(v_u_12:GetAttribute("NonExistingVMs"))
end
local v_u_20 = {}
local v_u_21 = {
	["Configs"] = {},
	["VModels"] = {}
}
local v_u_22 = {}
local v_u_23
if v_u_2 then
	v_u_23 = require(v9.Framework.StreamItemEvent) or nil
else
	v_u_23 = nil
end
local v_u_24 = not v_u_4
if v_u_24 then
	v_u_24 = require(v9.Framework.GetAttFolder)
end
local v_u_25 = nil
local v_u_26 = {}
local function v_u_30(p27, p28) -- name: streamOrFindVModel
	-- upvalues: (copy) v_u_13, (ref) v_u_2, (copy) v_u_21, (copy) v_u_23
	local v29 = v_u_13:FindFirstChild(p27, p28)
	if not v29 and v_u_2 then
		if not v_u_21.VModels[p27] then
			v_u_21.VModels[p27] = true
			v_u_23:FireServer({ "VModels", p27 })
		end
		v29 = v_u_13:WaitForChild(p27, 15)
		if not v29 then
			v_u_21.VModels[p27] = nil
		end
	end
	return v29
end
local v_u_31
if v_u_2 then
	v15.Main()
	local v32 = require(script.ViewmodelClient)
	v32.init({
		["WepConfig"] = v_u_26,
		["streamOrFindVModel"] = v_u_30
	})
	v_u_31 = v32.loadViewmodel
	v32.setupGunGameListeners()
else
	local v33 = require(script.ViewmodelServer)
	v33.init({
		["VModels"] = v_u_13,
		["Configs"] = v_u_12,
		["SharedResources"] = v_u_10,
		["ChunkSender"] = v16,
		["GetAttFolder"] = v_u_24,
		["attCache"] = v_u_22,
		["IsInEdit"] = v_u_4
	})
	v_u_31 = v33.loadViewmodel
	v_u_26.GetViewmodels = v33.GetViewmodels
	v_u_26.GetViewmodel = v33.GetViewmodel
end
function v_u_26.PreloadWeapon(_, p34) -- name: PreloadWeapon
	-- upvalues: (copy) v_u_14, (ref) v_u_31, (ref) v_u_25
	if v_u_14.List[p34] then
		p34 = v_u_14.List[p34].Name
	end
	v_u_31(p34, require(v_u_25(p34)))
end
function v_u_26.StreamViewmodel(_, p35) -- name: StreamViewmodel
	-- upvalues: (copy) v_u_14, (ref) v_u_31
	if v_u_14.List[p35] then
		p35 = v_u_14.List[p35].Name
	end
	return v_u_31(p35)
end
function v_u_26.GetAttachmentFolder(_, p36) -- name: GetAttachmentFolder
	-- upvalues: (ref) v_u_2, (copy) v_u_22, (copy) v_u_24, (copy) v_u_10
	if v_u_2 then
		if v_u_22[p36] then
			if v_u_22[p36] ~= "nil" then
				return v_u_22[p36]
			end
			return
		else
			local _, v37 = v_u_24:Call({ p36 }):Await()
			local v38 = v37[1]
			if v38 then
				v_u_22[p36] = v_u_10.Attachments[v38]:WaitForChild(p36, 10)
				if v_u_22[p36] then
					return v_u_22[p36]
				end
				warn("Failed to load attachment: " .. p36 .. " from parent: " .. v38)
				v_u_22[p36] = "nil"
			else
				v_u_22[p36] = "nil"
			end
		end
	else
		return v_u_22[p36]
	end
end
function v_u_26.IsStock(_, p39) -- name: IsStock
	-- upvalues: (copy) v_u_14
	local v40 = v_u_14.List[p39] or v_u_14.List[v_u_14:GetItemIdFromName(p39)]
	if v40 then
		local v41 = v40.Rarity
		if v41 then
			v41 = v40.Rarity == "Stock"
		end
		return v41
	end
end
function v_u_26.GetWeaponConfig(_, p42, p43) -- name: GetWeaponConfig
	-- upvalues: (copy) v_u_20, (copy) v_u_14, (copy) v_u_30, (copy) v_u_17, (ref) v_u_25, (copy) v_u_26, (copy) v_u_8, (ref) v_u_4, (ref) v_u_2, (copy) v_u_19, (ref) v_u_31, (copy) v_u_10
	if v_u_20[p42] then
		if v_u_20[p42] ~= "nil" then
			return v_u_20[p42]
		end
	else
		local v44 = v_u_14.List[p42] or v_u_14.List[v_u_14:GetItemIdFromName(p42)]
		local v45, v46
		if v44 then
			v45 = v44.BaseWeaponId
			v46 = v44.Name
		else
			v46 = p42
			v45 = nil
		end
		if not v44 then
			local v47 = v_u_30(v46, true)
			if v47 then
				local v48 = v_u_17.getBaseWeapon(v47)
				if v48 then
					v45 = v_u_14:GetItemIdFromName(v48) or (v_u_14.List[v48] and v48 or nil)
				end
			end
		end
		local v_u_49 = nil
		local v50
		if v44 or not v45 then
			v50 = v_u_25(v46)
			if v50 then
				if p43 then
					v_u_49 = require(v50:Clone())
				else
					v_u_49 = require(v50)
				end
				if v_u_49.BaseConfig then
					v45 = v_u_14:GetItemIdFromName(v_u_49.BaseConfig)
					if not v45 then
						if v_u_14.List[v_u_49.BaseConfig] then
							v45 = v_u_49.BaseConfig or nil
						else
							v45 = nil
						end
					end
				end
			end
		else
			v50 = nil
		end
		local v_u_51 = nil
		if v45 then
			local v52 = v_u_26:GetWeaponConfig(v45, p43)
			if v52 then
				v_u_51 = {}
				for v53, v54 in pairs(v52) do
					v_u_51[v53] = v54
				end
				if v_u_49 then
					for v55, v56 in v_u_49 do
						v_u_51[v55] = v56
					end
				end
				v_u_51.WeaponName = v46
				v_u_51.WeaponId = p42
				v_u_51.BaseName = v_u_14.List[v45].Name
				if not (v_u_8.Value or v_u_4) then
					if v_u_2 then
						if v_u_19[v46] then
							v_u_51.UseVModel = v_u_51.BaseName
						end
						v_u_31(v46, v_u_51):andThen(function(p57)
							-- upvalues: (copy) v_u_51
							v_u_51.Viewmodel = p57
						end)
					else
						v_u_51.Viewmodel = v_u_31(v46)
						if not v_u_51.Viewmodel then
							v_u_51.UseVModel = v45
						end
					end
				end
				v_u_20[p42] = v_u_51
			else
				warn("[WepConfig] Base config not found for: " .. tostring(v45))
				v_u_20[p42] = v_u_49 or "nil"
				v_u_51 = v_u_49
			end
		elseif v_u_49 then
			v_u_49.WeaponName = v46
			v_u_49.WeaponId = p42
			v_u_49.DelayPerShot = v_u_49.DelayPerShot or 0
			if not (v_u_8.Value or v_u_4) then
				if v_u_2 then
					v_u_31(v46, v_u_49):andThen(function(p58)
						-- upvalues: (ref) v_u_49
						v_u_49.Viewmodel = p58
					end)
				else
					v_u_49.Viewmodel = v_u_31(v46)
				end
			end
			v_u_20[p42] = v_u_49 or "nil"
			v_u_51 = v_u_49
		end
		if v_u_51 then
			if v50 then
				v50 = v50:GetAttribute("SuperClass")
			end
			if v50 then
				local v59 = v_u_10.Configs.SuperClass:FindFirstChild(v50)
				if v59 then
					for v60, v61 in require(v59) do
						if not v_u_51[v60] then
							v_u_51[v60] = v61
						end
					end
				end
			end
			if v_u_51 then
				for v62, v63 in require(v_u_10.Configs.SuperClass.BaseConfig) do
					if not v_u_51[v62] then
						v_u_51[v62] = v63
					end
				end
			end
			return v_u_51
		end
	end
end
function v_u_26.GetWeaponAttachmentProperties(p64) -- name: GetWeaponAttachmentProperties
	-- upvalues: (copy) v_u_26
	local v65 = v_u_26:GetWeaponConfig(p64)
	if not v65 then
		return nil
	end
	local v66 = {}
	for _, v67 in v65.AttachmentNodeData do
		for _, v68 in v67.PotentialAttachments do
			v66[v68.ID] = v68
		end
	end
	return v66
end
function v_u_26.ClearCache(_) -- name: ClearCache
	-- upvalues: (copy) v_u_20
	table.clear(v_u_20)
end
function v_u_26.ClearModels(_) -- name: ClearModels
	-- upvalues: (copy) v_u_10
	for _, v69 in v_u_10.VModels:GetChildren() do
		v69:Destroy()
	end
end
local function _(p70)
	-- upvalues: (copy) v_u_14, (ref) v_u_3, (copy) v_u_12, (ref) v_u_2, (copy) v_u_18, (copy) v_u_21, (copy) v_u_23
	if v_u_14:GetItemFromName(p70) and v_u_14:GetItemFromName(p70).Slot == "Outfit" then
		return nil
	end
	if v_u_3 then
		return v_u_12:FindFirstChild(p70, true)
	end
	if v_u_2 then
		if v_u_18[p70] then
			return v_u_12:FindFirstChild(p70)
		end
		if not v_u_21.Configs[p70] then
			v_u_21.Configs[p70] = true
			v_u_23:FireServer({ "Configs", p70 })
		end
		local v71 = v_u_12:WaitForChild(p70, 15)
		if not v71 then
			v_u_21.Configs[p70] = nil
			error("Failed to load config: " .. p70)
		end
		return v71
	end
end
return v_u_26