local v1 = {}
local v_u_2 = false
local v_u_3 = nil
local v_u_4 = nil
local v_u_5 = nil
local v_u_6 = nil
local v_u_7 = nil
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
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = nil
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = nil
local function v_u_31() -- name: lazyLoad
	-- upvalues: (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_19, (ref) v_u_20, (ref) v_u_21, (ref) v_u_22, (ref) v_u_23, (ref) v_u_24, (ref) v_u_25
	if not v_u_16 then
		local v26 = game:GetService("ReplicatedStorage")
		local v27 = script.Parent.Parent.Parent
		local v28 = v27.Parent:WaitForChild("Classes")
		local v29 = v27.Parent:WaitForChild("Shared")
		local v30 = v27.Parent:WaitForChild("Utils")
		v_u_16 = require(v29:WaitForChild("SharedSprings"))
		v_u_17 = require(v28.Viewmodel.ViewmodelUtils.FakeArmUtil)
		v_u_18 = require(v27.ViewmodelManager)
		v_u_19 = require(v28.Viewmodel.ViewmodelUtils.PointRotationUtil)
		v_u_20 = require(v28.Viewmodel.ViewmodelUtils.RecoilUtil)
		v_u_21 = require(v30.BobbingUtil)
		v_u_22 = require(v26.common:WaitForChild("PlayerHandler"))
		v_u_23 = require(script.Parent:WaitForChild("LoopSFX"))
		v_u_24 = require(v26.Packages.Fusion)
		v_u_25 = require(v26.common.skillTree.SkillTreeData)
	end
end
function v1.Init(_, p32) -- name: Init
	-- upvalues: (ref) v_u_8, (ref) v_u_9, (ref) v_u_10, (ref) v_u_11, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14, (ref) v_u_15
	v_u_8 = p32.LPC
	v_u_9 = p32.Inventory
	v_u_10 = p32.CurrentWeaponGetter
	v_u_11 = p32.CurrentWeaponSetter
	v_u_12 = p32.EquippedEvent
	v_u_13 = p32.WeaponEquippedSignal
	v_u_14 = p32.AmmoChangedSignal
	v_u_15 = p32.OffHand
end
function v1.IsActive(_) -- name: IsActive
	-- upvalues: (ref) v_u_2
	return v_u_2
end
function v1.GetPrimaryWeapon(_) -- name: GetPrimaryWeapon
	-- upvalues: (ref) v_u_3
	return v_u_3
end
function v1.GetPrimarySlot(_) -- name: GetPrimarySlot
	-- upvalues: (ref) v_u_4
	return v_u_4
end
function v1.GetSecondaryWeapon(_) -- name: GetSecondaryWeapon
	-- upvalues: (ref) v_u_6
	return v_u_6
end
function v1.Start(_, p33) -- name: Start
	-- upvalues: (copy) v_u_31, (ref) v_u_25, (ref) v_u_24, (ref) v_u_15, (ref) v_u_10, (ref) v_u_9, (ref) v_u_23, (ref) v_u_7, (ref) v_u_3, (ref) v_u_4, (ref) v_u_5, (ref) v_u_6, (ref) v_u_2, (ref) v_u_18, (ref) v_u_11, (ref) v_u_8, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14, (ref) v_u_22
	v_u_31()
	local v34
	if v_u_25 and v_u_25.HasQuickDraw then
		v34 = v_u_24.peek(v_u_25.HasQuickDraw)
	else
		v34 = false
	end
	if not v34 then
		return false
	end
	if v_u_15 and v_u_15:IsActive() then
		v_u_15:Cancel()
	end
	local v35 = v_u_10()
	if not (v35 and v_u_9[p33]) then
		return false
	end
	local v36 = v_u_9[p33]
	if v36.Config.IsMelee or v36 == v35 then
		return false
	end
	if v35.Config.IsMelee then
		return false
	end
	if v35.Config.IsDualWieldedWeapon then
		return false
	end
	if v36.Config.IsDualWieldedWeapon then
		return false
	end
	if v35.Config.IsTwoHandedAbility then
		return false
	end
	for _, v37 in v_u_9 do
		if v37.Config and (v37.Config.IsTwoHandedAbility and (v37.Config.IsActivating and v37.Config:IsActivating())) then
			return false
		end
	end
	if v36.Reloading then
		return false
	end
	if v35.LoopSFX_Playing then
		v_u_23:Stop(v35)
	end
	if v35.Reloading then
		local v38 = nil
		local v39 = nil
		local v40 = nil
		if v35.Viewmodel and v35.Viewmodel.Animations then
			local v41 = v35.Viewmodel.Animations
			if v41.Reload and v41.Reload.IsPlaying then
				v38 = v41.Reload.TimePosition
				v40 = v41.Reload.Speed
				v39 = "Reload"
			elseif v41.ReloadEmpty and v41.ReloadEmpty.IsPlaying then
				v38 = v41.ReloadEmpty.TimePosition
				v40 = v41.ReloadEmpty.Speed
				v39 = "ReloadEmpty"
			elseif v41.LoadStart and v41.LoadStart.IsPlaying then
				v38 = v41.LoadStart.TimePosition
				v40 = v41.LoadStart.Speed
				v39 = "LoadStart"
			elseif v41.LoadStartEmpty and v41.LoadStartEmpty.IsPlaying then
				v38 = v41.LoadStartEmpty.TimePosition
				v40 = v41.LoadStartEmpty.Speed
				v39 = "LoadStartEmpty"
			elseif v41.LoadLoop and v41.LoadLoop.IsPlaying then
				v38 = v41.LoadLoop.TimePosition
				v40 = v41.LoadLoop.Speed
				v39 = "LoadLoop"
			elseif v41.LoadIdle and v41.LoadIdle.IsPlaying then
				v38 = v41.LoadIdle.TimePosition
				v40 = v41.LoadIdle.Speed
				v39 = "LoadIdle"
			end
		end
		v_u_7 = {
			["ReloadingTime"] = v35.ReloadingTime,
			["LoopStage"] = v35.LoopStage,
			["IncreasedAmmo"] = v35.IncreasedAmmo,
			["Reloaded"] = v35.Reloaded,
			["AnimTimePosition"] = v38,
			["AnimName"] = v39,
			["AnimSpeed"] = v40
		}
		if v35.Viewmodel then
			v35.Viewmodel:StopAnimation("Reload", 0)
			v35.Viewmodel:StopAnimation("ReloadEmpty", 0)
			v35.Viewmodel:StopAnimation("LoadStart", 0)
			v35.Viewmodel:StopAnimation("LoadStartEmpty", 0)
			v35.Viewmodel:StopAnimation("LoadLoop", 0)
			v35.Viewmodel:StopAnimation("LoadIdle", 0)
			v35.Viewmodel:StopAnimation("LoadStop", 0)
		end
		v35.ReloadPaused = true
		v35.PausedReloadingTime = v35.ReloadingTime
		v35.PausedLoopStage = v35.LoopStage
		v35.PausedIncreasedAmmo = v35.IncreasedAmmo
		v35.PausedReloaded = v35.Reloaded
		v35.PausedAnimName = v39
		v35.PausedAnimTimePosition = v38
		v35.PausedAnimSpeed = v40
		v35.ReloadingTime = nil
	else
		v_u_7 = nil
	end
	v_u_3 = v35
	v_u_4 = nil
	for v42, v43 in v_u_9 do
		if v43 == v35 then
			v_u_4 = v42
			break
		end
	end
	if not v_u_4 then
		return false
	end
	v_u_5 = v35.WeaponId
	v_u_6 = v36
	v_u_2 = true
	if v_u_3.Viewmodel then
		v_u_3.Viewmodel.ForceLoweredPosition = true
	end
	if v_u_6.Viewmodel then
		v_u_6.Viewmodel.RightArmOnly = true
		v_u_6.Viewmodel.ForceOneHanded = true
	end
	local v44 = (v_u_6.Config.QuickSwapDrawBonus or 1.5) * v_u_24.peek(v_u_25.SwapSpeedMult) * 3
	v_u_6.QuickDrawActive = true
	v_u_6.QuickSwapBonus = v44
	v_u_6.QuickEquip = true
	v_u_6:Equip()
	v_u_18:Equip(v_u_6, "Right", 20)
	v_u_11(v_u_6)
	v_u_8.CurrentWeapon = v_u_6
	v_u_8:UpdateCurrentWeapon()
	v_u_12:FireServer(p33)
	v_u_13:Fire(v_u_6)
	v_u_14:Fire(true)
	v_u_8.States.QuickSwapActive = true
	local v45 = v_u_22:GetPlayerState(game.Players.LocalPlayer)
	if v45 then
		v45.QuickSwapActive = true
		v45.SecondaryEquipped = v_u_3.WeaponId or false
		v45.SecondaryWepId = v_u_3.WepId or false
	end
	return true
end
function v1.Complete(_) -- name: Complete
	-- upvalues: (ref) v_u_2, (copy) v_u_31, (ref) v_u_7, (ref) v_u_3, (ref) v_u_6, (ref) v_u_17, (ref) v_u_18, (ref) v_u_10, (ref) v_u_4, (ref) v_u_5, (ref) v_u_8, (ref) v_u_22
	if not v_u_2 then
		return false
	end
	v_u_31()
	v_u_7 = nil
	if v_u_3 and v_u_3.Viewmodel then
		v_u_3.Viewmodel.ForceLoweredPosition = false
	end
	if v_u_6 and v_u_6.Viewmodel then
		v_u_17:SetArmOwner("Left", v_u_6.Viewmodel.Model)
	end
	if v_u_3 then
		v_u_18:Unequip(v_u_3)
		v_u_3:ForceUnequip()
	end
	if v_u_6 and v_u_10() == v_u_6 then
		v_u_18:SetArmRequest(v_u_6, "Both")
		v_u_18:SetPriority(v_u_6, 10)
		if v_u_6.Viewmodel then
			v_u_6.Viewmodel.ForceOneHanded = false
			v_u_6.Viewmodel.RightArmOnly = false
		end
		v_u_6.QuickDrawActive = nil
	end
	v_u_2 = false
	v_u_3 = nil
	v_u_4 = nil
	v_u_5 = nil
	v_u_6 = nil
	v_u_8.States.QuickSwapActive = false
	local v46 = v_u_22:GetPlayerState(game.Players.LocalPlayer)
	if v46 then
		v46.QuickSwapActive = false
		v46.SecondaryEquipped = false
		v46.SecondaryWepId = false
	end
	return true
end
function v1.Cancel(_, p47) -- name: Cancel
	-- upvalues: (ref) v_u_2, (copy) v_u_31, (ref) v_u_6, (ref) v_u_18, (ref) v_u_16, (ref) v_u_3, (ref) v_u_17, (ref) v_u_19, (ref) v_u_20, (ref) v_u_21, (ref) v_u_11, (ref) v_u_8, (ref) v_u_7, (ref) v_u_13, (ref) v_u_14, (ref) v_u_4, (ref) v_u_12, (ref) v_u_5, (ref) v_u_22
	if not v_u_2 then
		return false
	end
	v_u_31()
	if p47 == nil and v_u_6 then
		p47 = v_u_6.Config.QuickSwapHolsterSpeed
		if p47 then
			p47 = p47 > 0
		end
	end
	if v_u_6 and v_u_6.Viewmodel then
		v_u_6.Viewmodel.ForceOneHanded = false
		v_u_6.Viewmodel.RightArmOnly = false
	end
	if v_u_6 then
		v_u_6.QuickDrawActive = nil
	end
	if v_u_6 then
		v_u_18:Unequip(v_u_6)
		if p47 then
			local v_u_48 = v_u_6.Config.QuickSwapHolsterSpeed or 2
			v_u_6.QuickSwapHolster = v_u_48
			task.spawn(function()
				-- upvalues: (ref) v_u_6, (ref) v_u_16, (copy) v_u_48
				local v49 = v_u_6
				if v49 then
					v_u_16.EquipSpring.Target = 1.5
					v_u_16.EquipSpring.Speed = 12 * v_u_48
					task.wait(0.15 / v_u_48)
					if v49.Viewmodel then
						v49:ForceUnequip()
					end
				end
			end)
		else
			v_u_6:ForceUnequip()
		end
	end
	if v_u_3 then
		if v_u_3.Viewmodel then
			v_u_3.Viewmodel.ForceLoweredPosition = false
			v_u_17:Show(v_u_3.Viewmodel.Model)
			v_u_19.NewWeapon(v_u_3.Viewmodel)
			v_u_20.CurrentWeapon = v_u_3
			v_u_21.CurrentWeapon = v_u_3
		end
		v_u_11(v_u_3)
		v_u_8.CurrentWeapon = v_u_3
		v_u_8:UpdateCurrentWeapon()
		if v_u_7 and v_u_3.ReloadPaused then
			v_u_3.ReloadPaused = nil
			local v50 = v_u_3.PausedReloadingTime or v_u_7.ReloadingTime
			v_u_3.PausedReloadingTime = nil
			v_u_3.LoopStage = v_u_7.LoopStage
			v_u_3.IncreasedAmmo = v_u_7.IncreasedAmmo
			v_u_3.Reloaded = v_u_7.Reloaded
			local v51 = v_u_3.ReloadFocusActive or false
			local v52 = v_u_8.FocusEnabled and true or false
			local v53
			if v51 == v52 then
				v53 = 1
			else
				v53 = v52 and 0.5 or 2
				v_u_3.ReloadFocusActive = v52
				if v_u_3.ReloadCancelTime then
					v_u_3.ReloadCancelTime = v_u_3.ReloadCancelTime * v53
				end
			end
			v_u_3.ReloadingTime = v50 * v53
			if v_u_3.Viewmodel and v_u_7.AnimName then
				local v54 = (v_u_7.AnimSpeed or 1) * (1 / v53)
				v_u_3.Viewmodel:PlayAnimation(v_u_7.AnimName, 0, 1, v54)
				local v55 = v_u_3.Viewmodel.Animations[v_u_7.AnimName]
				if v55 and v_u_7.AnimTimePosition then
					v55.TimePosition = v_u_7.AnimTimePosition
				end
			end
			v_u_7 = nil
		end
		v_u_13:Fire(v_u_3)
		v_u_14:Fire(true)
	end
	if v_u_4 then
		v_u_12:FireServer(v_u_4)
	end
	v_u_2 = false
	v_u_3 = nil
	v_u_4 = nil
	v_u_5 = nil
	v_u_6 = nil
	v_u_7 = nil
	v_u_8.States.QuickSwapActive = false
	local v56 = v_u_22:GetPlayerState(game.Players.LocalPlayer)
	if v56 then
		v56.QuickSwapActive = false
		v56.SecondaryEquipped = false
		v56.SecondaryWepId = false
	end
	return true
end
function v1.Cleanup(_) -- name: Cleanup
	-- upvalues: (ref) v_u_2, (copy) v_u_31, (ref) v_u_3, (ref) v_u_18, (ref) v_u_7, (ref) v_u_6
	if v_u_2 then
		v_u_31()
		if v_u_3 then
			if v_u_3.Viewmodel then
				v_u_3.Viewmodel.ForceLoweredPosition = false
			end
			v_u_18:Unequip(v_u_3)
		end
		v_u_7 = nil
		if v_u_6 then
			if v_u_6.Viewmodel then
				v_u_6.Viewmodel.ForceOneHanded = false
				v_u_6.Viewmodel.RightArmOnly = false
			end
			v_u_6.QuickDrawActive = nil
			v_u_18:Unequip(v_u_6)
		end
		v_u_2 = false
		v_u_3 = nil
		v_u_6 = nil
	end
end
function v1.ResumePausedReload(_, p57) -- name: ResumePausedReload
	-- upvalues: (ref) v_u_8
	if not (p57 and p57.ReloadPaused) then
		return false
	end
	p57.ReloadPaused = nil
	p57.Reloading = true
	p57.LoopStage = p57.PausedLoopStage
	p57.IncreasedAmmo = p57.PausedIncreasedAmmo
	p57.Reloaded = p57.PausedReloaded
	local v58 = p57.ReloadFocusActive or false
	local v59 = v_u_8.FocusEnabled and true or false
	local v60
	if v58 == v59 then
		v60 = 1
	else
		v60 = v59 and 0.5 or 2
		p57.ReloadFocusActive = v59
		if p57.ReloadCancelTime then
			p57.ReloadCancelTime = p57.ReloadCancelTime * v60
		end
	end
	p57.ReloadingTime = (p57.PausedReloadingTime or 0) * v60
	p57.PausedReloadingTime = nil
	p57.PausedLoopStage = nil
	p57.PausedIncreasedAmmo = nil
	p57.PausedReloaded = nil
	if p57.Viewmodel and p57.PausedAnimName then
		local v61 = (p57.PausedAnimSpeed or 1) * (1 / v60)
		p57.Viewmodel:PlayAnimation(p57.PausedAnimName, 0, 1, v61)
		local v62 = p57.Viewmodel.Animations[p57.PausedAnimName]
		if v62 and p57.PausedAnimTimePosition then
			v62.TimePosition = p57.PausedAnimTimePosition
		end
	end
	p57.PausedAnimName = nil
	p57.PausedAnimTimePosition = nil
	p57.PausedAnimSpeed = nil
	return true
end
return v1