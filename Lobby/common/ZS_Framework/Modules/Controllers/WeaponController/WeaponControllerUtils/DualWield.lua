local v1 = {}
local v_u_2 = false
local v_u_3 = nil
local v_u_4 = nil
local v_u_5 = "Right"
local v_u_6 = false
local v_u_7 = false
local v_u_8 = nil
local v_u_9 = nil
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local function v_u_23() -- name: lazyLoad
	-- upvalues: (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_19
	if not v_u_15 then
		local v20 = game:GetService("ReplicatedStorage")
		local v21 = script.Parent.Parent.Parent
		local v22 = v21.Parent:WaitForChild("Classes")
		v_u_15 = require(v21.ViewmodelManager)
		v_u_16 = require(v22.Viewmodel.ViewmodelUtils.FakeArmUtil)
		v_u_17 = require(v22.Viewmodel.ViewmodelUtils.ArmModelUtil)
		v_u_18 = require(v20.common:WaitForChild("PlayerHandler"))
		v_u_19 = require(v22.Weapon)
	end
end
function v1.Init(_, p24) -- name: Init
	-- upvalues: (ref) v_u_8, (ref) v_u_9, (ref) v_u_10, (ref) v_u_11, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14
	v_u_8 = p24.LPC
	v_u_9 = p24.Inventory
	v_u_10 = p24.CurrentWeaponGetter
	v_u_11 = p24.CurrentWeaponSetter
	v_u_12 = p24.WeaponEquippedSignal
	v_u_13 = p24.AmmoChangedSignal
	v_u_14 = p24.QuickSwapModule
end
function v1.IsActive(_) -- name: IsActive
	-- upvalues: (ref) v_u_2
	return v_u_2
end
function v1.GetWeapons(_) -- name: GetWeapons
	-- upvalues: (ref) v_u_2, (ref) v_u_4, (ref) v_u_3
	if v_u_2 then
		return v_u_4, v_u_3
	else
		return nil, nil
	end
end
function v1.GetRightWeapon(_) -- name: GetRightWeapon
	-- upvalues: (ref) v_u_4
	return v_u_4
end
function v1.GetLeftWeapon(_) -- name: GetLeftWeapon
	-- upvalues: (ref) v_u_3
	return v_u_3
end
function v1.IsRightReloading(_) -- name: IsRightReloading
	-- upvalues: (ref) v_u_6
	return v_u_6
end
function v1.IsLeftReloading(_) -- name: IsLeftReloading
	-- upvalues: (ref) v_u_7
	return v_u_7
end
function v1.GetActiveWeapons(_) -- name: GetActiveWeapons
	-- upvalues: (ref) v_u_2, (ref) v_u_4, (ref) v_u_3, (ref) v_u_10
	local v25 = {}
	if v_u_2 then
		if v_u_4 then
			local v26 = v_u_4
			table.insert(v25, v26)
		end
		if v_u_3 then
			local v27 = v_u_3
			table.insert(v25, v27)
			return v25
		end
	elseif v_u_10() then
		local v28 = v_u_10
		table.insert(v25, v28())
	end
	return v25
end
function v1.Start(_, p29) -- name: Start
	-- upvalues: (ref) v_u_2, (copy) v_u_23, (ref) v_u_9, (ref) v_u_14, (ref) v_u_10, (ref) v_u_15, (ref) v_u_19, (ref) v_u_5, (ref) v_u_6, (ref) v_u_7, (ref) v_u_4, (ref) v_u_3, (ref) v_u_11, (ref) v_u_8, (ref) v_u_12, (ref) v_u_13, (ref) v_u_18
	if v_u_2 then
		return false
	end
	v_u_23()
	local v30 = v_u_9[p29]
	if not v30 then
		return false
	end
	if not v30.Config.CanDualWield then
		return false
	end
	if v30.Config.IsMelee then
		return false
	end
	if v_u_14 and v_u_14:IsActive() then
		v_u_14:Cancel()
	end
	local v31 = v_u_10()
	if v31 and v31 ~= v30 then
		v_u_15:Unequip(v31)
		v31:ForceUnequip()
	end
	local v32 = v_u_19.new
	local v33 = v30.WeaponId
	local v34 = v30.Mods
	if v34 then
		v34 = v30.Mods:Serialize()
	end
	local v35 = v32(v33, v34)
	if not v35 then
		warn("[DualWield] Failed to create left weapon for dual wield")
		return false
	end
	v35.Slot = v30.Slot
	v35.Ammo = v30.Ammo
	v35.StoredAmmo = v30.StoredAmmo
	v_u_2 = true
	v_u_5 = "Right"
	v_u_6 = v30.Reloading or false
	v_u_7 = false
	v_u_4 = v30
	v_u_3 = v35
	v_u_4.IsDualWieldRight = true
	if v_u_4.Viewmodel then
		v_u_4.Viewmodel.ForceOneHanded = true
		v_u_4.Viewmodel.RightArmOnly = true
		v_u_4.Viewmodel.UseArmModels = true
		v_u_4.Viewmodel.IsDualWieldRight = true
	end
	v_u_4:Equip()
	v_u_15:Equip(v_u_4, "Right", 10)
	v_u_3.IsDualWieldLeft = true
	if v_u_3.Viewmodel then
		v_u_3.Viewmodel.ForceOneHanded = true
		v_u_3.Viewmodel.LeftArmOnly = true
		v_u_3.Viewmodel.IsMirrored = true
		v_u_3.Viewmodel.UseArmModels = true
	end
	v_u_3:Equip()
	v_u_15:Equip(v_u_3, "Left", 10)
	v_u_4.MouseReleased = true
	v_u_3.MouseReleased = true
	v_u_4.ShootingInaccuracy = v_u_4.ShootingInaccuracy or 0
	v_u_3.ShootingInaccuracy = v_u_3.ShootingInaccuracy or 0
	v_u_4.Inaccuracy = v_u_4.Inaccuracy or 0
	v_u_3.Inaccuracy = v_u_3.Inaccuracy or 0
	v_u_11(v_u_4)
	v_u_8.CurrentWeapon = v_u_4
	v_u_8:UpdateCurrentWeapon()
	v_u_12:Fire(v_u_4)
	v_u_13:Fire(true)
	v_u_8.States.DualWieldActive = true
	local v36 = v_u_18:GetPlayerState(game.Players.LocalPlayer)
	if v36 then
		v36.SecondaryEquipped = v35.WeaponId or false
		v36.SecondaryWepId = v35.WepId or false
	end
	return true
end
function v1.StartWithWeapons(_, p37, p38) -- name: StartWithWeapons
	-- upvalues: (ref) v_u_2, (copy) v_u_23, (ref) v_u_14, (ref) v_u_5, (ref) v_u_6, (ref) v_u_7, (ref) v_u_4, (ref) v_u_3, (ref) v_u_16, (ref) v_u_17, (ref) v_u_15, (ref) v_u_11, (ref) v_u_8, (ref) v_u_12, (ref) v_u_13, (ref) v_u_18
	if v_u_2 then
		return false
	end
	if not (p37 and p38) then
		return false
	end
	if not (p37.Config.CanDualWield and p38.Config.CanDualWield) then
		return false
	end
	if p37.Config.IsMelee or p38.Config.IsMelee then
		return false
	end
	v_u_23()
	if v_u_14 and v_u_14:IsActive() then
		v_u_14:Cancel()
	end
	v_u_2 = true
	v_u_5 = "Right"
	v_u_6 = p37.Reloading or false
	v_u_7 = p38.Reloading or false
	v_u_4 = p37
	v_u_3 = p38
	v_u_4.IsDualWieldRight = true
	if v_u_4.Viewmodel then
		v_u_4.Viewmodel.ForceOneHanded = true
		v_u_4.Viewmodel.RightArmOnly = true
		v_u_4.Viewmodel.UseArmModels = true
		v_u_4.Viewmodel.IsDualWieldRight = true
		v_u_16:Hide(v_u_4.Viewmodel.Model)
		v_u_17:AttachArms(v_u_4.Viewmodel.Model, true, false, false)
	end
	v_u_15:SetArmRequest(v_u_4, "Right")
	v_u_3.IsDualWieldLeft = true
	v_u_3.IsDualWieldFromInventory = true
	if v_u_3.Viewmodel then
		v_u_3.Viewmodel.ForceOneHanded = true
		v_u_3.Viewmodel.LeftArmOnly = true
		v_u_3.Viewmodel.IsMirrored = true
		v_u_3.Viewmodel.UseArmModels = true
	end
	v_u_3:Equip()
	v_u_15:Equip(v_u_3, "Left", 10)
	v_u_4.MouseReleased = true
	v_u_3.MouseReleased = true
	v_u_4.ShootingInaccuracy = v_u_4.ShootingInaccuracy or 0
	v_u_3.ShootingInaccuracy = v_u_3.ShootingInaccuracy or 0
	v_u_4.Inaccuracy = v_u_4.Inaccuracy or 0
	v_u_3.Inaccuracy = v_u_3.Inaccuracy or 0
	v_u_11(v_u_4)
	v_u_8.CurrentWeapon = v_u_4
	v_u_8:UpdateCurrentWeapon()
	v_u_12:Fire(v_u_4)
	v_u_13:Fire(true)
	v_u_8.States.DualWieldActive = true
	local v39 = v_u_18:GetPlayerState(game.Players.LocalPlayer)
	if v39 then
		v39.SecondaryEquipped = p38.WeaponId or false
		v39.SecondaryWepId = p38.WepId or false
	end
	return true
end
function v1.Stop(_) -- name: Stop
	-- upvalues: (ref) v_u_2, (copy) v_u_23, (ref) v_u_3, (ref) v_u_17, (ref) v_u_15, (ref) v_u_4, (ref) v_u_16, (ref) v_u_11, (ref) v_u_8, (ref) v_u_5, (ref) v_u_6, (ref) v_u_7, (ref) v_u_13, (ref) v_u_18
	if not v_u_2 then
		return false
	end
	v_u_23()
	if v_u_3 then
		if v_u_3.Viewmodel then
			v_u_17:DetachArms(v_u_3.Viewmodel.Model)
			v_u_3.Viewmodel.ForceOneHanded = false
			v_u_3.Viewmodel.LeftArmOnly = false
			v_u_3.Viewmodel.IsMirrored = false
			v_u_3.Viewmodel.UseArmModels = false
		end
		v_u_15:Unequip(v_u_3)
		v_u_3:ForceUnequip()
		local _ = v_u_3.IsDualWieldFromInventory
		v_u_3.IsDualWieldLeft = nil
		v_u_3.IsDualWieldFromInventory = nil
		v_u_3 = nil
	end
	if v_u_4 then
		v_u_4.IsDualWieldRight = nil
		if v_u_4.Viewmodel then
			v_u_4.Viewmodel.ForceOneHanded = false
			v_u_4.Viewmodel.RightArmOnly = false
			v_u_4.Viewmodel.UseArmModels = false
			v_u_4.Viewmodel.IsDualWieldRight = false
			v_u_17:DetachArms(v_u_4.Viewmodel.Model)
		end
		v_u_15:SetArmRequest(v_u_4, "Both")
		v_u_16:Show(v_u_4.Viewmodel.Model)
		v_u_11(v_u_4)
		v_u_8.CurrentWeapon = v_u_4
		v_u_8:UpdateCurrentWeapon()
	end
	v_u_2 = false
	v_u_4 = nil
	v_u_5 = "Right"
	v_u_6 = false
	v_u_7 = false
	v_u_13:Fire(true)
	v_u_8.States.DualWieldActive = false
	local v40 = v_u_18:GetPlayerState(game.Players.LocalPlayer)
	if v40 then
		v40.SecondaryEquipped = false
		v40.SecondaryWepId = false
	end
	return true
end
function v1.Fire(_) -- name: Fire
	-- upvalues: (ref) v_u_2, (ref) v_u_6, (ref) v_u_7, (ref) v_u_4, (ref) v_u_3, (ref) v_u_5, (ref) v_u_11
	if not v_u_2 then
		return false
	end
	if v_u_6 and v_u_7 then
		return false
	end
	local v41 = v_u_4
	if v41 then
		v41 = v_u_4.FireMode == "Auto"
	end
	local v42 = v_u_3
	if v42 then
		v42 = v_u_3.FireMode == "Auto"
	end
	local v43 = nil
	if v41 and v42 then
		local v44 = v_u_4 and v_u_4.IsEquipped
		if v44 then
			v44 = not v_u_6
		end
		local v45 = v_u_3 and v_u_3.IsEquipped
		if v45 then
			v45 = not v_u_7
		end
		if v44 and v45 then
			v43 = (v_u_4.LastShot or 0) <= (v_u_3.LastShot or 0) and v_u_4 or v_u_3
		elseif v44 then
			v43 = v_u_4
		elseif v45 then
			v43 = v_u_3
		end
	else
		v43 = v_u_5 == "Right" and v_u_4 or v_u_3
		local v46 = v43 == v_u_4 and v_u_6
		if not v46 then
			if v43 == v_u_3 then
				v46 = v_u_7
			else
				v46 = false
			end
		end
		if v46 then
			v43 = v_u_5 == "Right" and v_u_3 or v_u_4
			local v47 = v43 == v_u_4 and v_u_6
			if not v47 then
				if v43 == v_u_3 then
					v47 = v_u_7
				else
					v47 = false
				end
			end
			if v47 then
				return false
			end
		end
	end
	if not (v43 and v43.IsEquipped) then
		return false
	end
	v_u_11(v43)
	return true, v43
end
function v1.Alternate(_) -- name: Alternate
	-- upvalues: (ref) v_u_2, (ref) v_u_5
	if v_u_2 then
		if v_u_5 == "Right" then
			v_u_5 = "Left"
		else
			v_u_5 = "Right"
		end
	else
		return
	end
end
function v1.IsAutoMode(_) -- name: IsAutoMode
	-- upvalues: (ref) v_u_2, (ref) v_u_4, (ref) v_u_3
	if not v_u_2 then
		return false
	end
	local v48 = v_u_4
	if v48 then
		v48 = v_u_4.FireMode == "Auto"
	end
	local v49 = v_u_3
	if v49 then
		v49 = v_u_3.FireMode == "Auto"
	end
	return v48 and v49
end
function v1.FireBoth(_, p50, p51) -- name: FireBoth
	-- upvalues: (ref) v_u_2, (ref) v_u_4, (ref) v_u_6, (ref) v_u_3, (ref) v_u_7
	if not v_u_2 then
		return false, false
	end
	local v52 = false
	local v53 = false
	if v_u_4 and (v_u_4.IsEquipped and not v_u_6) then
		local v54 = os.clock() - p50 >= (v_u_4.LastShot or 0) and v_u_4.MouseReleased
		if v54 then
			if v_u_4.Ammo > 0 and (not v_u_4.ReloadingTime or v_u_4.ReloadingTime <= 0) then
				v54 = not v_u_4.Busy
			else
				v54 = false
			end
		end
		v52 = v54 and true or v52
	end
	if v_u_3 and (v_u_3.IsEquipped and not v_u_7) then
		local v55 = os.clock() - p51 >= (v_u_3.LastShot or 0) and v_u_3.MouseReleased
		if v55 then
			if v_u_3.Ammo > 0 and (not v_u_3.ReloadingTime or v_u_3.ReloadingTime <= 0) then
				v55 = not v_u_3.Busy
			else
				v55 = false
			end
		end
		v53 = v55 and true or v53
	end
	return v52, v53
end
function v1.Reload(_, p56) -- name: Reload
	-- upvalues: (ref) v_u_2, (ref) v_u_4, (ref) v_u_6, (ref) v_u_3, (ref) v_u_7
	if v_u_2 then
		local v57 = v_u_4
		if v57 then
			if v_u_4.Ammo < (v_u_4.Config.Ammo or 30) then
				v57 = not v_u_6
			else
				v57 = false
			end
		end
		local v58 = v_u_3
		if v58 then
			if v_u_3.Ammo < (v_u_3.Config.Ammo or 30) then
				v58 = not v_u_7
			else
				v58 = false
			end
		end
		if p56 == "Right" and v57 then
			v_u_6 = true
			v_u_4:Reload()
			return true, v_u_4
		elseif p56 == "Left" and v58 then
			v_u_7 = true
			v_u_3:Reload()
			return true, v_u_3
		else
			local v59
			if v57 then
				v_u_6 = true
				v_u_4:Reload()
				v59 = true
			else
				v59 = false
			end
			if v58 then
				v_u_7 = true
				v_u_3:Reload()
				v59 = true
			end
			if v57 and v58 then
				return v59, "Both"
			else
				return v59, v57 and v_u_4 or v_u_3
			end
		end
	else
		return false
	end
end
function v1.AutoReload(_, p60) -- name: AutoReload
	-- upvalues: (ref) v_u_2, (ref) v_u_4, (ref) v_u_6, (ref) v_u_3, (ref) v_u_7
	if not v_u_2 then
		return false
	end
	if p60 == v_u_4 and not v_u_6 then
		if p60.Ammo <= 0 and p60.StoredAmmo > 0 then
			v_u_6 = true
			p60:Reload()
			return true
		end
	elseif p60 == v_u_3 and (not v_u_7 and (p60.Ammo <= 0 and p60.StoredAmmo > 0)) then
		v_u_7 = true
		p60:Reload()
		return true
	end
	return false
end
function v1.ReloadComplete(_, p61) -- name: ReloadComplete
	-- upvalues: (ref) v_u_4, (ref) v_u_6, (ref) v_u_3, (ref) v_u_7
	if p61 == v_u_4 then
		v_u_6 = false
		return
	elseif p61 == v_u_3 then
		v_u_7 = false
	else
		v_u_6 = false
		v_u_7 = false
	end
end
function v1.Cleanup(_) -- name: Cleanup
	-- upvalues: (ref) v_u_2, (copy) v_u_23, (ref) v_u_17, (ref) v_u_3, (ref) v_u_4, (ref) v_u_15, (ref) v_u_6, (ref) v_u_7
	if v_u_2 then
		v_u_23()
		local v_u_62 = game:GetService("RunService")
		local function v65(p63) -- name: ForceDisableViewmodel
			-- upvalues: (copy) v_u_62, (ref) v_u_17
			if p63 and p63.Viewmodel then
				local v_u_64 = p63.Viewmodel
				pcall(function()
					-- upvalues: (ref) v_u_62, (copy) v_u_64
					v_u_62:UnbindFromRenderStep(v_u_64.Name)
				end)
				if v_u_64.Model then
					v_u_64.Model.Parent = nil
				end
				if v_u_64.UseArmModels then
					v_u_17:DetachArms(v_u_64.Model)
				end
				v_u_64.Enabled = false
			end
		end
		v65(v_u_3)
		v65(v_u_4)
		if v_u_3 then
			v_u_15:Unequip(v_u_3)
		end
		if v_u_4 then
			v_u_15:Unequip(v_u_4)
		end
		if v_u_3 then
			v_u_3.IsDualWieldLeft = nil
			v_u_3.IsEquipped = false
			if v_u_3.Config.OnUnequipped then
				task.spawn(v_u_3.Config.OnUnequipped, v_u_3)
			end
			if v_u_3.Viewmodel then
				v_u_3.Viewmodel.ForceOneHanded = false
				v_u_3.Viewmodel.LeftArmOnly = false
				v_u_3.Viewmodel.IsMirrored = false
				v_u_3.Viewmodel.UseArmModels = false
			end
		end
		if v_u_4 then
			v_u_4.IsDualWieldRight = nil
			v_u_4.IsEquipped = false
			if v_u_4.Config.OnUnequipped then
				task.spawn(v_u_4.Config.OnUnequipped, v_u_4)
			end
			if v_u_4.Viewmodel then
				v_u_4.Viewmodel.ForceOneHanded = false
				v_u_4.Viewmodel.RightArmOnly = false
				v_u_4.Viewmodel.UseArmModels = false
				v_u_4.Viewmodel.IsDualWieldRight = false
			end
		end
		v_u_2 = false
		v_u_3 = nil
		v_u_4 = nil
		v_u_6 = false
		v_u_7 = false
	end
end
return v1