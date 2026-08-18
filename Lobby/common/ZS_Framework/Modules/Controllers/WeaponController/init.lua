local v1 = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local v2 = game:GetService("RunService")
local v_u_3 = game:GetService("SoundService")
local v4 = v1.common
local v5 = v1.common.SharedResources
local v6 = v1.common.RedEvents
local v_u_7 = require(v1.common.ZS_Shared.Data.GameState)
workspace:WaitForChild("Ignore")
local v8 = script.Parent
local v9 = v8.Parent:WaitForChild("Classes")
local v10 = v8.Parent:WaitForChild("Utils")
local v11 = v8.Parent:WaitForChild("Shared")
local v_u_12 = script:WaitForChild("Resources")
local v_u_13 = v_u_12:FindFirstChild("Dry")
local v14 = script:WaitForChild("WeaponControllerUtils")
v1.common:WaitForChild("Remotes"):WaitForChild("Net")
local v_u_15 = require(v8:WaitForChild("LocalPlayerController"))
local v_u_16 = require(v8:WaitForChild("CameraController"))
local v17 = require("@game/ReplicatedStorage/common/Signal")
local v_u_18 = require(v4:WaitForChild("HUDService"))
local v_u_19 = require(v9:WaitForChild("Weapon"))
local v20 = require(v4:WaitForChild("BindUtil"))
local v_u_21 = require(v10:WaitForChild("SoundUtil"))
local v_u_22 = require(v11:WaitForChild("SharedSprings"))
local v_u_23 = require(v14:WaitForChild("Melee"))
local v_u_24 = require(v14.AutoShoot)
local v_u_25 = require(v4.Settings)
local v_u_26 = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local v_u_27 = require(v14.LoopSFX)
require(v5.Attachments.AttachmentSystem.AttachmentsRoot)
local v_u_28 = require(v9.Viewmodel.ViewmodelUtils.ShellSystem)
local v_u_29 = require(v8.ViewmodelManager)
local v_u_30 = require(v14.QuickSwap)
local v_u_31 = require(v14.DualWield)
local v_u_32 = require(v14.OffHand)
local v_u_33 = require(v14.OffHandChecks)
local v_u_34 = require(v1.Packages.Fusion)
local v_u_35 = require(v1.common.skillTree.SkillTreeData)
local v_u_36 = require(v6.Framework.FrameworkEvents)
local _ = v_u_15.humanoid
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = nil
local v_u_41 = nil
local v_u_42 = nil
local v_u_43 = nil
local v_u_44 = nil
local v_u_45 = nil
local v_u_46 = nil
local v_u_47 = {}
local v_u_48 = {}
local v_u_49 = {
	["X"] = 0,
	["Y"] = 0
}
local v_u_50 = v_u_36.CancelReload
local v_u_51 = v_u_36.Equipped
local v_u_52 = v_u_36.WeaponUse
local v_u_53 = {}
local v_u_54 = nil
local v_u_55 = nil
local v_u_56 = nil
local v_u_57 = nil
local v_u_58 = nil
local v_u_59 = nil
local v_u_60 = nil
local v_u_61 = false
local v_u_62 = nil
local v63 = Enum.RenderPriority.Input.Value + 1
local v_u_64 = {
	["EquippedSlot"] = v17.new(),
	["FireModeChanged"] = v17.new(),
	["WeaponEquipped"] = v17.new(),
	["WeaponUnequipped"] = v17.new(),
	["XPChanged"] = v17.new(),
	["AmmoChanged"] = v17.new(),
	["InventoryChanged"] = v17.new(),
	["Reloaded"] = v17.new(),
	["TargetChanged"] = v17.new(),
	["InaccuracyUpdated"] = v17.new(),
	["GunFired"] = v17.new()
}
local function v68() -- name: initializeModules
	-- upvalues: (copy) v_u_15, (copy) v_u_47, (ref) v_u_37, (copy) v_u_51, (copy) v_u_64, (ref) v_u_40, (copy) v_u_32, (copy) v_u_30, (copy) v_u_31
	local v67 = {
		["LPC"] = v_u_15,
		["Inventory"] = v_u_47,
		["CurrentWeaponGetter"] = function() -- name: CurrentWeaponGetter
			-- upvalues: (ref) v_u_37
			return v_u_37
		end,
		["CurrentWeaponSetter"] = function(p65) -- name: CurrentWeaponSetter
			-- upvalues: (ref) v_u_37
			v_u_37 = p65
		end,
		["EquippedEvent"] = v_u_51,
		["WeaponEquippedSignal"] = v_u_64.WeaponEquipped,
		["AmmoChangedSignal"] = v_u_64.AmmoChanged,
		["SetSwappingDisabled"] = function(p66) -- name: SetSwappingDisabled
			-- upvalues: (ref) v_u_40
			v_u_40 = p66
		end,
		["OffHand"] = v_u_32
	}
	v_u_30:Init(v67)
	v67.QuickSwapModule = v_u_30
	v_u_31:Init(v67)
	v67.DualWieldModule = v_u_31
	v_u_32:Init(v67)
end
function v_u_64.Parried(_) -- name: Parried
	-- upvalues: (ref) v_u_37, (copy) v_u_34, (copy) v_u_35, (copy) v_u_16
	if v_u_37 then
		v_u_37.Parried = true
		local v69 = v_u_34.peek(v_u_35.ParryWindowBonus) or 0
		v_u_37.ParryTime = os.clock() + (v_u_37.Config.ParryWindow * 2 or 0) + v69
		if v_u_37.Config.Parried then
			v_u_37.Config.Parried(v_u_37)
		end
		v_u_16.CameraShaker:ShakeOnce(7, 7, 0, 1, Vector3.new(), Vector3.new(1, 1, 1))
	end
end
function v_u_64.Blocked(_) -- name: Blocked
	-- upvalues: (ref) v_u_37, (copy) v_u_21, (copy) v_u_16
	if v_u_37 then
		if v_u_37.Config.Blocked then
			v_u_37.Config.Blocked(v_u_37)
		end
		v_u_21:PlaySound(v_u_37.Config.BlockSFX or {
			["SoundId"] = "7058511525"
		})
		v_u_16.CameraShaker:ShakeOnce(7, 7, 0, 1, Vector3.new(), Vector3.new(1, 1, 1))
	end
end
function v_u_64.GetTotalHotbarSlots(_) -- name: GetTotalHotbarSlots
	-- upvalues: (copy) v_u_48
	return v_u_48 and #v_u_48 or 0
end
function v_u_64.GetEquippedSlot(_) -- name: GetEquippedSlot
	-- upvalues: (copy) v_u_49
	return not v_u_49 and 0 or v_u_49.X
end
function v_u_64.SwapWeaponXbox(_, p70) -- name: SwapWeaponXbox
	-- upvalues: (copy) v_u_15, (copy) v_u_34, (copy) v_u_35, (copy) v_u_48, (ref) v_u_39, (copy) v_u_64, (copy) v_u_49
	if v_u_15.States.IsDead then
		return
	end
	local v71 = v_u_15.States.IsDowned
	if v71 then
		v71 = v_u_34.peek(v_u_35.HasLastStand)
	end
	if v_u_15.States.IsDowned and not v71 then
		return
	end
	local v72 = {}
	for v73 = 1, v71 and 2 or 5 do
		if v_u_48[v73] and #v_u_48[v73] > 0 then
			for v74, v75 in ipairs(v_u_48[v73]) do
				local v76
				if v75.Config and v75.Config.CannotSwapTo then
					local v77 = v75.Config.CannotSwapTo
					if type(v77) == "function" then
						v76 = v75.Config:CannotSwapTo(v75)
					else
						v76 = v75.Config.CannotSwapTo
					end
				else
					v76 = false
				end
				if not v76 then
					table.insert(v72, {
						["weapon"] = v75,
						["slotX"] = v73,
						["slotY"] = v74
					})
				end
			end
		end
	end
	if #v72 == 0 then
		v_u_39 = nil
		v_u_64.EquippedSlot:Fire(nil)
		v_u_49.X = 0
		v_u_49.Y = 0
		v_u_15.BlockPressed = false
		return
	end
	local v78 = nil
	for v79, v80 in ipairs(v72) do
		if v80.slotX == v_u_49.X and v80.slotY == v_u_49.Y then
			v78 = v79
			break
		end
	end
	local v81
	if v78 then
		local v82 = v78 + p70
		v81 = #v72 < v82 and 1 or (v82 < 1 and #v72 or v82)
	else
		v81 = 1
	end
	local v83 = v72[v81]
	v_u_49.X = v83.slotX
	v_u_49.Y = v83.slotY
	v_u_39 = v83.weapon.Slot
	v_u_64.EquippedSlot:Fire(v_u_39)
	v_u_15.BlockPressed = false
end
function v_u_64.SwapWeapon(_, p84) -- name: SwapWeapon
	-- upvalues: (copy) v_u_15, (copy) v_u_34, (copy) v_u_35, (copy) v_u_48, (ref) v_u_39, (copy) v_u_64, (copy) v_u_49
	if v_u_15.States.IsDead then
		return
	else
		if v_u_15.States.IsDowned then
			if not v_u_34.peek(v_u_35.HasLastStand) then
				return
			end
			local v85 = tostring(p84)
			if v85 ~= "1" and v85 ~= "2" then
				return
			end
		end
		local v86 = v_u_48[p84]
		if v86 and #v86 ~= 0 then
			local v87 = #v86
			local v88 = v_u_49.X == p84
			local v89 = not v88 and 1 or v_u_49.Y + 1
			for v90 = 0, v87 - 1 do
				local v91 = v89 + v90
				if v87 < v91 then
					if v88 then
						v_u_39 = nil
						v_u_64.EquippedSlot:Fire(nil)
						v_u_49.X = 0
						v_u_49.Y = 0
						v_u_15.BlockPressed = false
						return
					end
					v91 = (v91 - 1) % v87 + 1
				end
				local v92 = v86[v91]
				if v92 then
					local v93
					if v92.Config and v92.Config.CannotSwapTo then
						local v94 = v92.Config.CannotSwapTo
						if type(v94) == "function" then
							v93 = v92.Config:CannotSwapTo(v92)
						else
							v93 = v92.Config.CannotSwapTo
						end
					else
						v93 = false
					end
					if not v93 then
						v_u_49.X = p84
						v_u_49.Y = v91
						v_u_39 = v92.Slot
						v_u_64.EquippedSlot:Fire(v_u_39)
						v_u_15.BlockPressed = false
						return
					end
				end
			end
			v_u_15.BlockPressed = false
		else
			v_u_39 = nil
			v_u_64.EquippedSlot:Fire(nil)
			v_u_49.X = 0
			v_u_49.Y = 0
			v_u_15.BlockPressed = false
		end
	end
end
function v_u_64.ClassicWeaponSwap(_, p95) -- name: ClassicWeaponSwap
	-- upvalues: (ref) v_u_45, (ref) v_u_39, (copy) v_u_47, (copy) v_u_64
	if not v_u_45 then
		v_u_45 = 1
	end
	if v_u_39 then
		v_u_45 = v_u_45 + 1 * (p95 or 1)
	end
	local v96 = #v_u_47 + 1
	local v97 = 0
	while v97 < v96 do
		if not v_u_47[v_u_45] then
			v_u_45 = 1
		end
		if not v_u_47[v_u_45] then
			v_u_64:SwapWeapon(v_u_45)
			return
		end
		local v98 = v_u_47[v_u_45]
		local v99
		if v98.Config and v98.Config.CannotSwapTo then
			local v100 = v98.Config.CannotSwapTo
			if type(v100) == "function" then
				v99 = v98.Config:CannotSwapTo(v98)
			else
				v99 = v98.Config.CannotSwapTo
			end
		else
			v99 = false
		end
		if not v99 then
			v_u_64:SwapWeapon(v_u_47[v_u_45].HotbarSlot)
			return
		end
		v_u_45 = v_u_45 + 1 * (p95 or 1)
		if v_u_45 < 1 then
			v_u_45 = #v_u_47
		end
		v97 = v97 + 1
	end
end
function v_u_64.Reload(_) -- name: Reload
	-- upvalues: (copy) v_u_30, (copy) v_u_32, (copy) v_u_31, (ref) v_u_37, (copy) v_u_15
	if v_u_30:IsActive() then
		v_u_30:Complete()
	end
	if v_u_32:IsActive() then
		return
	elseif v_u_31:IsActive() then
		local v101, _ = v_u_31:Reload()
		if v101 then
			v_u_37 = v_u_31:GetRightWeapon()
			v_u_15.CurrentWeapon = v_u_37
			v_u_15:UpdateCurrentWeapon()
		end
	elseif v_u_37 then
		local v102 = v_u_37.Config.DelayPerShot
		if v_u_15.FocusEnabled then
			v102 = v102 / 2
		end
		if v_u_37.Config.PrimeAction and os.clock() - v102 < (v_u_37.LastShot or 0) then
			return
		end
		v_u_37.Bursting = false
		v_u_37.CurrentShot = 1
		v_u_37:Reload()
	end
end
function v_u_64.CycleFiremode(_) -- name: CycleFiremode
	-- upvalues: (ref) v_u_37, (copy) v_u_64, (copy) v_u_3, (copy) v_u_12
	if v_u_37 and (#v_u_37.Config.FireMode > 1 and not v_u_37.Bursting) then
		local v103 = v_u_37
		v103.SelFireMode = v103.SelFireMode + 1
		if not v_u_37.Config.FireMode[v_u_37.SelFireMode] then
			v_u_37.SelFireMode = 1
		end
		v_u_37.FireMode = v_u_37.Config.FireMode[v_u_37.SelFireMode]
		v_u_64.FireModeChanged:Fire(v_u_37.FireMode)
		v_u_37.Viewmodel:ChangedFiremode()
		v_u_3:PlayLocalSound(v_u_12.FireSelector)
	end
end
function v_u_64.ForceUnequip(_) -- name: ForceUnequip
	-- upvalues: (ref) v_u_37, (copy) v_u_31, (copy) v_u_30, (ref) v_u_39, (copy) v_u_64
	if v_u_37 then
		local v104 = v_u_37
		local v105 = v_u_31:IsActive()
		local v106 = v_u_30:IsActive()
		UnequipWeapon()
		if not v105 and (not v106 and v104.IsEquipped ~= false) then
			v104:ForceUnequip()
		end
		v_u_39 = nil
		v_u_64.EquippedSlot:Fire(nil)
	end
end
function v_u_64.DisableSwapping(_, p107) -- name: DisableSwapping
	-- upvalues: (ref) v_u_40
	v_u_40 = (p107 == nil or p107) and true or false
end
function v_u_64.SetWeaponsEnabled(_, p108) -- name: SetWeaponsEnabled
	-- upvalues: (copy) v_u_64
	if p108 then
		v_u_64:DisableSwapping(false)
		v_u_64:SwapWeapon(1)
	else
		v_u_64:DisableSwapping(true)
		v_u_64:ForceUnequip()
	end
end
function v_u_64.SetInputMethod(_, p109) -- name: SetInputMethod
	-- upvalues: (ref) v_u_58
	v_u_58 = p109 == "Touch"
end
local function v_u_114() -- name: findTwoHandedAbility
	-- upvalues: (copy) v_u_47
	for v110, v111 in v_u_47 do
		if v111.Config and v111.Config.IsTwoHandedAbility then
			local v112
			if v111.Config.CannotSwapTo then
				local v113 = v111.Config.CannotSwapTo
				if type(v113) == "function" then
					v112 = v111.Config:CannotSwapTo(v111)
				else
					v112 = v111.Config.CannotSwapTo
				end
			else
				v112 = false
			end
			if not v112 then
				return v110
			end
		end
	end
	return nil
end
function v_u_64.UseOffHand(_) -- name: UseOffHand
	-- upvalues: (ref) v_u_37, (ref) v_u_39, (ref) v_u_38, (copy) v_u_52, (copy) v_u_32, (copy) v_u_33, (copy) v_u_47, (copy) v_u_114, (ref) v_u_60, (ref) v_u_62, (copy) v_u_49, (ref) v_u_61, (copy) v_u_48, (copy) v_u_64
	if v_u_37 and (v_u_37.Config and v_u_37.Config.IsTwoHandedAbility) then
		if v_u_39 and v_u_39 ~= v_u_37.Slot then
			return false
		end
		if v_u_38 then
			return false
		end
		if v_u_37.Config.Use then
			function v_u_37.FireServerDeployEvent()
				-- upvalues: (ref) v_u_52
				v_u_52:FireServer()
			end
			v_u_37.Config:Use(v_u_37)
		end
		return true
	end
	if not v_u_32:IsActive() and v_u_33.CanUseWithCurrentWeapon(v_u_37) then
		for v115, v116 in v_u_47 do
			if v_u_33.CanUseItem(v116, v_u_37) and v_u_32:UseItem(v115) then
				return true
			end
		end
	end
	local v117 = v_u_114()
	if not v117 then
		return false
	end
	local v118 = v_u_47[v117]
	v_u_60 = v_u_39
	v_u_62 = {
		["X"] = v_u_49.X,
		["Y"] = v_u_49.Y
	}
	v_u_61 = true
	v_u_39 = v117
	if v118 and v118.HotbarSlot then
		v_u_49.X = v118.HotbarSlot
		v_u_49.Y = 1
		if v_u_48[v118.HotbarSlot] then
			for v119, v120 in v_u_48[v118.HotbarSlot] do
				if v120 == v118 then
					v_u_49.Y = v119
					break
				end
			end
		end
	end
	v_u_64.EquippedSlot:Fire(v117)
	return true
end
function v_u_64.CancelOffHand(_) -- name: CancelOffHand
	-- upvalues: (ref) v_u_61, (ref) v_u_37, (ref) v_u_39, (ref) v_u_60, (copy) v_u_64, (ref) v_u_62, (copy) v_u_49, (copy) v_u_32
	if not v_u_61 then
		if not v_u_32:IsActive() then
			return false
		end
		v_u_32:Cancel()
		return true
	end
	if v_u_37 and (v_u_37.Config and v_u_37.Config.CancelPreActivation) then
		v_u_37.Config:CancelPreActivation(v_u_37)
	end
	v_u_39 = v_u_60
	v_u_64.EquippedSlot:Fire(v_u_60)
	if v_u_62 then
		v_u_49.X = v_u_62.X
		v_u_49.Y = v_u_62.Y
	end
	v_u_61 = false
	v_u_60 = nil
	v_u_62 = nil
	return true
end
function v_u_64.GetCurrentWeapon(_) -- name: GetCurrentWeapon
	-- upvalues: (ref) v_u_37
	return v_u_37
end
function v_u_64.StartQuickSwap(_, p121) -- name: StartQuickSwap
	-- upvalues: (copy) v_u_30
	return v_u_30:Start(p121)
end
function v_u_64.CompleteQuickSwap(_) -- name: CompleteQuickSwap
	-- upvalues: (copy) v_u_30
	return v_u_30:Complete()
end
function v_u_64.CancelQuickSwap(_, p122) -- name: CancelQuickSwap
	-- upvalues: (copy) v_u_30
	return v_u_30:Cancel(p122)
end
function v_u_64.IsQuickSwapActive(_) -- name: IsQuickSwapActive
	-- upvalues: (copy) v_u_30
	return v_u_30:IsActive()
end
function v_u_64.StartDualWield(_, p123) -- name: StartDualWield
	-- upvalues: (copy) v_u_31
	return v_u_31:Start(p123)
end
function v_u_64.StartDualWieldWithWeapons(_, p124, p125) -- name: StartDualWieldWithWeapons
	-- upvalues: (copy) v_u_31
	return v_u_31:StartWithWeapons(p124, p125)
end
function v_u_64.StopDualWield(_) -- name: StopDualWield
	-- upvalues: (copy) v_u_31
	return v_u_31:Stop()
end
function v_u_64.IsDualWieldActive(_) -- name: IsDualWieldActive
	-- upvalues: (copy) v_u_31
	return v_u_31:IsActive()
end
function v_u_64.GetDualWieldWeapons(_) -- name: GetDualWieldWeapons
	-- upvalues: (copy) v_u_31
	return v_u_31:GetWeapons()
end
function v_u_64.DualWieldFire(_) -- name: DualWieldFire
	-- upvalues: (copy) v_u_31
	return v_u_31:Fire()
end
function v_u_64.DualWieldAlternate(_) -- name: DualWieldAlternate
	-- upvalues: (copy) v_u_31
	return v_u_31:Alternate()
end
function v_u_64.IsDualWieldAutoMode(_) -- name: IsDualWieldAutoMode
	-- upvalues: (copy) v_u_31
	return v_u_31:IsAutoMode()
end
function v_u_64.DualWieldFireBoth(_, p126, p127) -- name: DualWieldFireBoth
	-- upvalues: (copy) v_u_31
	return v_u_31:FireBoth(p126, p127)
end
function v_u_64.DualWieldReload(_, p128) -- name: DualWieldReload
	-- upvalues: (copy) v_u_31
	return v_u_31:Reload(p128)
end
function v_u_64.DualWieldAutoReload(_, p129) -- name: DualWieldAutoReload
	-- upvalues: (copy) v_u_31
	return v_u_31:AutoReload(p129)
end
function v_u_64.DualWieldReloadComplete(_, p130) -- name: DualWieldReloadComplete
	-- upvalues: (copy) v_u_31, (copy) v_u_64
	v_u_31:ReloadComplete(p130)
	v_u_64.AmmoChanged:Fire(true)
end
function v_u_64.UseOffHandItem(_, p131) -- name: UseOffHandItem
	-- upvalues: (copy) v_u_32
	return v_u_32:UseItem(p131)
end
function v_u_64.CancelOffHandItem(_) -- name: CancelOffHandItem
	-- upvalues: (copy) v_u_32
	return v_u_32:Cancel()
end
function v_u_64.OffHandItemComplete(_) -- name: OffHandItemComplete
	-- upvalues: (copy) v_u_32
	return v_u_32:Complete()
end
function v_u_64.IsOffHandActive(_) -- name: IsOffHandActive
	-- upvalues: (copy) v_u_32
	return v_u_32:IsActive()
end
function v_u_64.GetOffHandItem(_) -- name: GetOffHandItem
	-- upvalues: (copy) v_u_32
	return v_u_32:GetItem()
end
function UnequipWeapon() -- name: UnequipWeapon
	-- upvalues: (copy) v_u_30, (copy) v_u_31, (copy) v_u_32, (ref) v_u_37, (copy) v_u_29, (ref) v_u_38, (copy) v_u_15, (copy) v_u_64, (copy) v_u_18, (copy) v_u_13
	v_u_30:Cleanup()
	v_u_31:Cleanup()
	v_u_32:Cleanup()
	if v_u_37 then
		v_u_29:Unequip(v_u_37)
		if v_u_37.Viewmodel then
			v_u_37.Viewmodel:SetEnabled(false)
		end
	end
	addToLast2Weapons(false)
	v_u_37 = nil
	v_u_38 = false
	v_u_15.CurrentWeapon = nil
	v_u_15:UpdateCurrentWeapon()
	v_u_64.WeaponUnequipped:Fire()
	local v132 = v_u_18.Elements.StaminaDisplay
	if v132 then
		v132:SetPlacement(false)
	end
	if v_u_13 then
		v_u_13:Stop()
	end
end
function addToLast2Weapons(p133) -- name: addToLast2Weapons
	-- upvalues: (copy) v_u_53
	local v134 = v_u_53
	table.insert(v134, p133)
	if #v_u_53 > 2 then
		table.remove(v_u_53, 1)
	end
end
function getLastWeapon() -- name: getLastWeapon
	-- upvalues: (copy) v_u_53
	if v_u_53[1] then
		return v_u_53[1]
	else
		return nil
	end
end
function SwapWeapon(p135, p136) -- name: SwapWeapon
	-- upvalues: (copy) v_u_13, (ref) v_u_37, (copy) v_u_15, (ref) v_u_38, (ref) v_u_40, (copy) v_u_47, (copy) v_u_30, (copy) v_u_31, (ref) v_u_39, (copy) v_u_64, (copy) v_u_32, (ref) v_u_61, (ref) v_u_60, (ref) v_u_62, (copy) v_u_33, (copy) v_u_29, (copy) v_u_21, (copy) v_u_51, (ref) v_u_41, (ref) v_u_46, (ref) v_u_42, (copy) v_u_52, (copy) v_u_49
	if v_u_13 then
		v_u_13:Stop()
	end
	if v_u_37 then
		v_u_37.Bursting = false
		v_u_37.CurrentShot = 1
	end
	if not (v_u_15.States.IsDead or (v_u_38 or v_u_40)) then
		if p136 or not (p135 and v_u_47[p135]) then
			if v_u_30:IsActive() then
				v_u_30:Cancel()
			end
		else
			local v137 = v_u_47[p135]
			if v_u_30:IsActive() then
				local v138 = v_u_30:GetPrimaryWeapon()
				if v138 and v137 == v138 then
					v_u_30:Cancel()
					return
				end
				if v137 == v_u_37 then
					v_u_30:Complete()
					return
				end
				v_u_30:Cancel()
			elseif v_u_37 and (v137.Config.IsAPistol and (not v_u_37.Config.IsMelee and (not v_u_37.Config.IsAPistol and v_u_30:Start(p135)))) then
				return
			end
		end
		if not p136 and (p135 and (v_u_47[p135] and v_u_37)) then
			local v139 = v_u_47[p135]
			if v_u_37.Config.CanDualWield and (v139.Config.CanDualWield and (v_u_37.WeaponId == v139.WeaponId and (v139 ~= v_u_37 and not v_u_31:IsActive()))) then
				print(string.format("[WeaponController-DEBUG] Auto-dual-wield triggered: %s + %s", v_u_37.Name or "Unknown", v139.Name or "Unknown"))
				if v_u_31:StartWithWeapons(v_u_37, v139) then
					return
				end
			end
		end
		if v_u_31:IsActive() then
			local v140
			if p135 then
				v140 = v_u_47[p135]
			else
				v140 = p135
			end
			local v141, v142 = v_u_31:GetWeapons()
			if v140 then
				v140 = v140 == v141 and true or v140 == v142
			end
			if not p135 then
				v_u_31:Stop()
				UnequipWeapon()
				v_u_39 = nil
				v_u_64.EquippedSlot:Fire(nil)
				return
			end
			if v140 then
				return
			end
			v_u_31:Stop()
		end
		if v_u_32:IsActive() then
			local v143
			if p135 then
				v143 = v_u_47[p135]
			else
				v143 = p135
			end
			local v144 = v_u_32:GetItem()
			local v145 = v_u_32:GetPrimaryWeapon()
			if not p135 then
				v_u_32:Cancel()
				return
			end
			if v143 == v144 then
				v_u_32:Cancel()
				return
			end
			if v143 == v145 then
				v_u_32:Cancel()
				return
			end
			v_u_32:Cancel()
		end
		if v_u_37 and (v_u_37.Config and v_u_37.Config.IsTwoHandedAbility) then
			local v146
			if p135 then
				v146 = v_u_47[p135]
			else
				v146 = p135
			end
			if not v146 or v146 ~= v_u_37 then
				if v_u_37.Config.CancelPreActivation then
					v_u_37.Config:CancelPreActivation(v_u_37)
				end
				v_u_61 = false
				v_u_60 = nil
				v_u_62 = nil
			end
		end
		if not p136 and (p135 and v_u_47[p135]) then
			local v147 = v_u_47[p135]
			if v_u_33.CanUseItem(v147, v_u_37) and (v_u_33.CanUseWithCurrentWeapon(v_u_37) and v_u_32:UseItem(p135)) then
				if v_u_37 then
					for v148, v149 in v_u_47 do
						if v149 == v_u_37 then
							v_u_39 = v148
							return
						end
					end
				end
				return
			end
		end
		if v_u_37 then
			v_u_38 = p135 or true
			if v_u_37.AutoLoop and v_u_37.AutoLoop.Playing then
				v_u_37.AutoLoop:Stop()
				v_u_37.AutoLoopEnd:Play()
			end
			local v150 = v_u_37
			v_u_29:Unequip(v150)
			if p136 then
				v_u_37:ForceUnequip()
			else
				v_u_21:PlaySound(v_u_37.Config.UnequipSFX)
				if v_u_37:Unequip() then
					v_u_29:Equip(v150, "Both", v150.Config.ViewmodelPriority or 10)
					v_u_38 = false
					return
				end
			end
			v_u_51:FireServer(nil)
			v_u_38 = false
			if not p136 and (not p135 or (not v_u_47[p135] or v_u_47[p135] and (v_u_37 and v_u_47[p135].Slot == v_u_37.Slot))) then
				UnequipWeapon()
				return
			end
		end
		if p136 then
			v_u_64.EquippedSlot:Fire(p135)
			v_u_39 = p135
		end
		if v_u_39 and v_u_47[v_u_39] then
			v_u_37 = v_u_47[v_u_39]
			v_u_51:FireServer(v_u_39)
			v_u_37:Equip()
			v_u_29:Equip(v_u_37, "Both", v_u_37.Config.ViewmodelPriority or 10)
			v_u_21:PlaySound(v_u_37.Config.DeploySFX)
			if v_u_47[p135].Config.IsMelee then
				v_u_41 = p135
			elseif v_u_47[p135].Config.IsAPistol then
				v_u_46 = p135
			end
			addToLast2Weapons(v_u_39)
			v_u_42 = getLastWeapon()
			setupConfigurationChanges(v_u_47[v_u_39])
			v_u_30:ResumePausedReload(v_u_37)
			v_u_64.WeaponEquipped:Fire(v_u_37)
			v_u_64.AmmoChanged:Fire(true)
			v_u_15.CurrentWeapon = v_u_37
			v_u_15:UpdateCurrentWeapon()
			if v_u_47[p135].Config.IsTwoHandedAbility and (v_u_61 and v_u_15.OffHandPressed) then
				function v_u_37.FireServerDeployEvent()
					-- upvalues: (ref) v_u_52
					v_u_52:FireServer()
				end
				function v_u_37.OnDeploymentComplete()
					-- upvalues: (ref) v_u_61, (ref) v_u_60, (ref) v_u_39, (ref) v_u_64, (ref) v_u_62, (ref) v_u_49
					if v_u_61 and v_u_60 then
						task.defer(function()
							-- upvalues: (ref) v_u_39, (ref) v_u_60, (ref) v_u_64, (ref) v_u_62, (ref) v_u_49, (ref) v_u_61
							v_u_39 = v_u_60
							v_u_64.EquippedSlot:Fire(v_u_60)
							if v_u_62 then
								v_u_49.X = v_u_62.X
								v_u_49.Y = v_u_62.Y
							end
							v_u_61 = false
							v_u_60 = nil
							v_u_62 = nil
						end)
					end
				end
				task.defer(function()
					-- upvalues: (ref) v_u_37
					if v_u_37 and v_u_37.Config.Use then
						v_u_37.Config:Use(v_u_37)
					end
				end)
			end
		end
	end
end
local v_u_151 = nil
function setupConfigurationChanges(p_u_152) -- name: setupConfigurationChanges
	-- upvalues: (ref) v_u_151, (copy) v_u_18, (copy) v_u_16
	if v_u_151 then
		v_u_151:Disconnect()
	end
	local function v155() -- name: doChanges
		-- upvalues: (ref) v_u_18, (copy) p_u_152, (ref) v_u_16
		local v153 = v_u_18.Elements.StaminaDisplay
		if v153 then
			v153:SetPlacement(p_u_152.Config.IsMelee)
		end
		local v154 = p_u_152.Config.AimFOVMultiplier
		if v154 then
			v_u_16:SetMagnificationSensitivity(v154)
		else
			v_u_16:SetMagnificationSensitivity(1)
		end
	end
	v_u_151 = p_u_152.Viewmodel.ConfigLoaded:Connect(v155)
	local v156 = v_u_18.Elements.StaminaDisplay
	if v156 then
		v156:SetPlacement(p_u_152.Config.IsMelee)
	end
	local v157 = p_u_152.Config.AimFOVMultiplier
	if v157 then
		v_u_16:SetMagnificationSensitivity(v157)
	else
		v_u_16:SetMagnificationSensitivity(1)
	end
end
function WeaponStepped(p158) -- name: WeaponStepped
	-- upvalues: (ref) v_u_37, (copy) v_u_15, (ref) v_u_39, (copy) v_u_64, (copy) v_u_28, (copy) v_u_23, (copy) v_u_18, (copy) v_u_31, (copy) v_u_7, (ref) v_u_41, (copy) v_u_47, (copy) v_u_34, (copy) v_u_35, (ref) v_u_57, (ref) v_u_56, (ref) v_u_43, (ref) v_u_44, (ref) v_u_55, (ref) v_u_42, (ref) v_u_46, (ref) v_u_38, (ref) v_u_40, (ref) v_u_58, (copy) v_u_24, (ref) v_u_59, (copy) v_u_26, (copy) v_u_25, (copy) v_u_22, (copy) v_u_50, (copy) v_u_13, (copy) v_u_52, (ref) v_u_54, (copy) v_u_27, (copy) v_u_21, (copy) v_u_30
	if v_u_37 and (not v_u_15.hrp or (not v_u_15.hrp.Parent or (not v_u_15.humanoid.Humanoid or v_u_15.humanoid.Humanoid.Health <= 0))) then
		v_u_37:ForceUnequip()
		UnequipWeapon()
		v_u_39 = nil
		v_u_64.EquippedSlot:Fire(nil)
		return
	end
	local v159, v160
	if v_u_15.FocusEnabled then
		v159 = 2
		v160 = 0.5
	else
		v159 = 1
		v160 = 1
	end
	if not v_u_28.UsingViewmodelStep then
		v_u_28:Update(p158)
	end
	if v_u_37 and (v_u_37.Config and v_u_37.Config.IsMelee) then
		v_u_23.Think(v_u_37, p158, v_u_15)
		v_u_64.Blocking = v_u_37.Blocking
		if v_u_37.Blocking and v_u_37.ParryTime then
			v_u_64.Parrying = os.clock() <= v_u_37.ParryTime
		elseif not v_u_37.Blocking then
			v_u_37.ParryTime = nil
			v_u_64.Parrying = false
		end
	else
		v_u_64.Blocking = false
		v_u_64.Parrying = false
	end
	if (not v_u_37 or (not v_u_37.Charging or v_u_37 and (v_u_37.Charging and v_u_15:GetStamina() < (v_u_37.Config.HeavyStaminaRequired or 9999999)))) and (v_u_18.Elements.StaminaDisplay and v_u_18.Elements.StaminaDisplay.ChargeDisplay) then
		v_u_18.Elements.StaminaDisplay.ChargeDisplay = false
		v_u_18.Elements.StaminaDisplay:ChargeNotReady()
	end
	local v161 = v_u_31:GetActiveWeapons()
	for _, v162 in v161 do
		local v163 = v162.Config
		if not v162.ShootingInaccuracy then
			v162.ShootingInaccuracy = 0
		end
		local v164 = v163.BaseSpread or v163.Spread
		if v164 then
			local v165 = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult") or 1
			v164 = v164 * (v_u_7.Data.Variables.WeaponSpread * v165)
		end
		local v166 = Lerp
		local v167 = v162.ShootingInaccuracy
		local v168 = p158 / (v163.ShootingSpreadDecay or 0.3)
		v162.ShootingInaccuracy = v166(v167, 0, (math.min(v168, 1)))
		local v169 = 1
		local v170 = false
		if v_u_15.States.Crouching or v_u_15.States.Sliding then
			v169 = v169 * (v163.CrouchSpreadReduction or 0.5)
			v170 = true
		elseif v_u_15.States.Proning then
			v169 = v169 * (v163.ProneSpreadReduction or 0.25)
			v170 = true
		end
		if v162.Aiming and (v162.ADSStrength and v162.ADSStrength > 0.9) then
			if v170 then
				v169 = v169 * 1.65
			end
			local v171 = v169 * (v163.ADSSpreadReduction or 0.75)
			v162.Inaccuracy = (v164 and math.deg(v164) * 2 or 0) * v171
			local v172 = v162.Inaccuracy
			v162.Inaccuracy = math.max(0, v172)
		else
			v162.Inaccuracy = (v164 and math.deg(v164) * 2 or 0) * v169
			v162.Inaccuracy = v162.Inaccuracy + v162.ShootingInaccuracy + (v_u_15.humanoid.HasLanded and 0 or (v163.AirSpread or 25))
			local v173 = v162.Inaccuracy
			v162.Inaccuracy = math.max(0, v173)
		end
	end
	if #v161 > 0 then
		v_u_64.InaccuracyUpdated:Fire()
	end
	if v_u_41 then
		local v174 = v_u_47[v_u_41]
		local v175 = v_u_34.peek(v_u_35.MeleeSwingSpeedMult) or 1
		local v176 = v174.Config.DelayPerShot / v175
		if os.clock() - v176 >= (v174.LastShot or 0) and (v_u_15.BlockPressed and (v_u_47[v_u_41] and (v_u_15:GetStamina() >= v_u_47[v_u_41].Config.StaminaRequired and not v_u_15.States.IsDowned))) then
			if v_u_37 and (v_u_37.Slot == v_u_41 and not v_u_57) then
				v_u_56 = true
			else
				v_u_57 = true
				v_u_56 = false
				v_u_39 = v_u_41
				if v174 then
					v174.QuickEquip = true
				end
			end
			v_u_43 = true
		elseif v_u_15.BlockPressed or (not v_u_43 or (not v_u_37 or v_u_37.Slot ~= v_u_41)) then
			if v_u_55 and (v_u_37 and (not v_u_37.Meleeing and (v_u_37.Slot == v_u_41 and not v_u_56))) then
				v_u_39 = v_u_42
				v_u_57 = false
			end
		else
			v_u_43 = false
			if v_u_44 < 0.25 then
				v_u_55 = true
			elseif not v_u_56 then
				v_u_39 = v_u_42
				v_u_57 = false
			end
		end
		if v_u_15.BlockPressed then
			v_u_44 = v_u_44 + p158
		else
			v_u_44 = 0
		end
	end
	if not v_u_55 and (not v_u_37 or v_u_37 and not v_u_37.Meleeing) or (v_u_55 and (v_u_37 and v_u_37.Slot ~= v_u_41) or (v_u_55 and (v_u_37 and (v_u_37.Slot == v_u_41 and not v_u_37.IsEquipped)) or v_u_55 and not v_u_37)) then
		if v_u_55 then
			v_u_39 = v_u_41
		end
		if v_u_15.States.IsDowned and not v_u_15.States.IsDead then
			if v_u_34.peek(v_u_35.HasLastStand) then
				local v177 = v_u_39
				local v178 = tostring(v177)
				if v178 ~= "1" and v178 ~= "2" then
					local v179
					if v_u_37 and (v_u_37.Slot == "1" or v_u_37.Slot == "2") then
						v179 = v_u_37.Slot
					else
						v179 = v_u_46
					end
					v_u_39 = v179
				end
			else
				v_u_39 = v_u_46
			end
		end
		if v_u_39 and v_u_47[v_u_39] then
			if v_u_37 and v_u_37 ~= v_u_47[v_u_39] or not v_u_37 then
				if not (v_u_38 or v_u_40) then
					SwapWeapon(v_u_39)
				end
			elseif v_u_37 and (v_u_37 == v_u_47[v_u_39] and not v_u_37.IsEquipped) then
				v_u_37.CancelUnequip = true
			end
		elseif not v_u_39 and (v_u_37 and not (v_u_38 or v_u_40)) then
			SwapWeapon()
		end
	end
	if v_u_64.MobileShootDown then
		v_u_64.PrimaryAttackDown = true
	elseif v_u_58 then
		v_u_64.PrimaryAttackDown = false
	end
	local v180 = v_u_24:CheckTarget()
	if v_u_59 ~= v180 then
		v_u_64.TargetChanged:Fire(v180)
		v_u_59 = v180
	end
	if v_u_58 and (v_u_26(v_u_25.Controls.AutoShoot) and (v_u_37 and (not v_u_37.Config.IsMelee and (not v_u_37.Config.Deployable and (v_u_37.Ammo > 0 and (v_u_37.Primed ~= false and v180)))))) then
		v_u_64.PrimaryAttackDown = true
		v_u_37.MouseReleased = true
	elseif v_u_64.PrimaryAttackDown and (v_u_58 and (v_u_26(v_u_25.Controls.AutoShoot) and (not v_u_64.MobileShootDown and (v_u_37 and not v_u_37.Config.IsMelee)))) then
		v_u_64.PrimaryAttackDown = false
	end
	if v_u_37 then
		local _ = v_u_37.Config.FireWhileSprinting
	end
	local v181 = v_u_37
	if v181 then
		v181 = v_u_37.QuickDrawActive
	end
	local v182 = v_u_37 and v_u_37.Config.IsMelee or not v_u_15.States.Sprinting
	if v182 then
		if not v181 then
			local v183 = v_u_22.EquipSpring.Position > 0.1
			v181 = not v183
		end
	else
		v181 = v182
	end
	if v_u_37 then
		local v184 = (game.Players.LocalPlayer:GetAttribute("Skill_ReloadSpeedMult") or 1) * v_u_34.peek(v_u_35.ReloadSpeedMult)
		if v_u_37.Reloading and (v_u_64.PrimaryAttackDown and (v_u_37.Config.UsesLoadLoop and (v_u_37.Ammo > 0 and v_u_37.MouseReleased))) then
			if v_u_37.Config.UsesLoadLoop and v_u_37.Config.LoadStopOnReload then
				v_u_37.ReloadingTime = v_u_37.Config.LoadStopTime * v184
				v_u_37.LoopStage = 3
			else
				v_u_37.CancelReload = true
			end
		end
		if v_u_37.ReloadingTime then
			if v_u_37.ReloadingTime <= 0 or v_u_37.CancelReload then
				v_u_37.ReloadingTime = 0
				if v_u_37.Config.UsesLoadLoop then
					if v_u_37.LoopStage == 1 then
						if not v_u_37.Config.ShouldNotCycleAfterReload and (v_u_37.Config.PrimeAction and v_u_37.Ammo <= 0) then
							v_u_37.Priming = false
							v_u_37.Primed = false
						end
						v_u_37.CancelReload = false
						v_u_37.LoopStage = 2
						v_u_37.IncreasedAmmo = true
					end
					if v_u_37.LoopStage == 2 then
						if v_u_37.StoredAmmo <= 0 or (v_u_37.Ammo >= v_u_37.Config.Ammo or v_u_37.CancelReload) then
							v_u_37.LoopStage = 3
						end
						if v_u_37.IncreasedAmmo then
							if v_u_37.LoopStage == 2 then
								local v185 = v_u_37.Viewmodel.Animations.LoadLoop
								if v185 then
									v185.Priority = Enum.AnimationPriority.Action4
									local v186 = v185.Length / (v_u_37.Config.InsertAnimationTime or v_u_37.Config.InsertTime)
									v_u_37.Viewmodel:PlayAnimation("LoadLoop", 0, 1, v186 * v159 / v184)
								end
								v_u_37.ReloadingTime = v_u_37.Config.IncrAmmoCountTime * v160 * v184
								v_u_37.IncreasedAmmo = false
							end
						elseif v_u_37.LoopStage == 2 then
							local v_u_187 = v_u_37.Config.AmmoPerLoad or 1
							if v_u_37.StoredAmmo < v_u_187 then
								v_u_187 = v_u_37.StoredAmmo
							end
							if v_u_187 + v_u_37.Ammo > v_u_37.Config.Ammo then
								v_u_37.Ammo = v_u_37.Config.Ammo
							else
								local v188 = v_u_37
								v188.Ammo = v188.Ammo + v_u_187
							end
							local v189 = v_u_37
							v189.StoredAmmo = v189.StoredAmmo - v_u_187
							if v_u_37.Config.AmmoUpdated then
								task.defer(function()
									-- upvalues: (ref) v_u_37, (ref) v_u_187
									local v190 = {
										["Ammo"] = v_u_37.Ammo,
										["StoredAmmo"] = v_u_37.StoredAmmo
									}
									v_u_37.Config.AmmoUpdated(v190, v_u_37.Viewmodel.Model, {
										["Ammo"] = v_u_37.Ammo - v_u_187,
										print("real"),
										["StoredAmmo"] = v_u_37.StoredAmmo - v_u_187
									})
								end)
							end
							v_u_64.AmmoChanged:Fire()
							v_u_64.Reloaded:Fire()
							v_u_37.ReloadingTime = (v_u_37.Config.InsertTime - v_u_37.Config.IncrAmmoCountTime) * v160 * v184
							v_u_37.IncreasedAmmo = true
						end
					end
					if v_u_37.LoopStage == 3 then
						local v191 = v_u_37.CancelReload and 0 or nil
						v_u_37.Viewmodel:StopAnimation("LoadLoop", v191)
						v_u_37.Viewmodel:StopAnimation("LoadIdle", v191)
						v_u_37.Viewmodel:StopAnimation("LoadStart", v191)
						v_u_37.Viewmodel:StopAnimation("LoadStartEmpty", v191)
						local v192 = v_u_37.Viewmodel.Animations.LoadStop
						if v192 and not v_u_37.CancelReload then
							local v193 = v192.Length / (v_u_37.Config.LoadStopAnimationTime or v_u_37.Config.LoadStartTime)
							v_u_37.Viewmodel:PlayAnimation("LoadStop", 0, 1, v193 * v159 / v184)
						end
						local _ = v_u_37.CancelReload
						v_u_37.CancelReload = false
						v_u_37.LoopStage = 4
						local v_u_194 = v_u_37
						local v_u_195 = v_u_194.Slot
						local v_u_196 = v_u_194.Ammo
						task.defer(function()
							-- upvalues: (copy) v_u_194, (ref) v_u_50, (copy) v_u_195, (copy) v_u_196, (ref) v_u_64
							if not v_u_194.IsDestroyed then
								v_u_50:Call({ v_u_195, v_u_196 }):After(function(p197, p198)
									-- upvalues: (ref) v_u_194, (ref) v_u_196, (ref) v_u_64
									if p197 and (p198 and (v_u_194 and not v_u_194.IsDestroyed)) then
										local v199 = v_u_196 - v_u_194.Ammo
										p198[1] = p198[1] - v199
										v_u_194.newAmmo = p198
										v_u_194.ServerFinishedReload = true
										v_u_194.Ammo = v_u_194.newAmmo[1]
										v_u_194.StoredAmmo = v_u_194.newAmmo[2]
										if v_u_194.Config.AmmoUpdated then
											task.defer(function()
												-- upvalues: (ref) v_u_194
												local v200 = {
													["Ammo"] = v_u_194.Ammo,
													["StoredAmmo"] = v_u_194.StoredAmmo
												}
												v_u_194.Config.AmmoUpdated(v200, v_u_194.Viewmodel.Model, v200)
											end)
										end
										v_u_64.AmmoChanged:Fire()
										v_u_64.Reloaded:Fire()
										v_u_194.newAmmo = nil
									else
										warn(p198)
									end
								end)
							end
						end)
					elseif not v_u_37.Reloaded and v_u_37.LoopStage == 4 then
						v_u_37.Reloading = false
						v_u_37.Reloaded = true
						v_u_37.CancelReload = false
						if v_u_31:IsActive() then
							v_u_64:DualWieldReloadComplete(v_u_37)
						end
					end
				elseif not v_u_37.Reloaded then
					v_u_37.Reloading = false
					if v_u_37.Config.AmmoUpdated then
						task.defer(function()
							-- upvalues: (ref) v_u_37
							local v201 = {
								["Ammo"] = v_u_37.Ammo,
								["StoredAmmo"] = v_u_37.StoredAmmo
							}
							v_u_37.Config.AmmoUpdated(v201, v_u_37.Viewmodel.Model, v201)
						end)
					end
					if v_u_37.newAmmo then
						print("Updated Client ammo: NewAmmo Object", v_u_37.newAmmo)
						v_u_37.Ammo = v_u_37.newAmmo[1]
						v_u_37.StoredAmmo = v_u_37.newAmmo[2]
						v_u_64.AmmoChanged:Fire()
						v_u_64.Reloaded:Fire()
						v_u_37.newAmmo = nil
					end
					v_u_37.Reloaded = true
					v_u_37:ReloadFinished()
					if v_u_31:IsActive() then
						v_u_64:DualWieldReloadComplete(v_u_37)
					end
				end
			else
				if not v_u_37.Config.UsesLoadLoop then
					local v202 = v_u_15.FocusEnabled and true or false
					if v202 ~= (v_u_37.ReloadFocusActive or false) then
						local v203 = v202 and 0.5 or 2
						v_u_37.ReloadingTime = v_u_37.ReloadingTime * v203
						if v_u_37.ReloadCancelTime then
							v_u_37.ReloadCancelTime = v_u_37.ReloadCancelTime * v203
						end
						v_u_37.ReloadFocusActive = v202
						if v_u_37.Viewmodel and v_u_37.Viewmodel.Animations then
							local v204 = v_u_37.Viewmodel.Animations
							local v205 = 1 / v203
							for _, v206 in {
								"Reload",
								"ReloadEmpty",
								"LoadStart",
								"LoadStartEmpty"
							} do
								local v207 = v204[v206]
								if v207 and v207.IsPlaying then
									v207:AdjustSpeed(v207.Speed * v205)
									break
								end
							end
						end
					end
				end
				v_u_37.ReloadingTime = v_u_37.ReloadingTime - p158
				if v_u_37.ReloadingTime < (v_u_37.ReloadCancelTime or 0) then
					if not v_u_37.IsEquipped then
						v_u_37.ReloadingTime = 0
					end
					if v_u_37.newAmmo and not v_u_37.MagInUpdate then
						v_u_37.MagInUpdate = true
						v_u_37.Ammo = v_u_37.newAmmo[1]
						v_u_37.StoredAmmo = v_u_37.newAmmo[2]
						v_u_64.AmmoChanged:Fire()
						v_u_64.Reloaded:Fire()
						v_u_37.newAmmo = nil
					end
				end
			end
		end
		if (v_u_37.Ammo <= 0 or not v181) and v_u_37.Bursting then
			v_u_37.Bursting = false
			v_u_37.CurrentShot = 1
		end
		if v_u_37.Ammo <= 0 and not (v_u_37.Reloading or v_u_37.Config.IsMelee) then
			if v_u_64.PrimaryAttackDown then
				if v_u_13 and not v_u_13.IsPlaying then
					v_u_13:Play()
				end
			elseif v_u_13 then
				v_u_13:Stop()
			end
			if v_u_37.StoredAmmo > 0 then
				if v_u_13 then
					v_u_13:Stop()
				end
				if v_u_31:IsActive() then
					v_u_64:DualWieldAutoReload(v_u_37)
				else
					v_u_64:Reload()
				end
			end
		elseif v_u_13 and v_u_13.IsPlaying then
			v_u_13:Stop()
		end
		local v208 = v_u_37.Config.DelayPerShot / v_u_7.Data.Variables.FireRate
		if v_u_37.FireMode ~= "Auto" and (v_u_37.FireMode ~= "Burst" and not v_u_37.Config.IsMelee) then
			v208 = v208 * v160
		end
		if v_u_37.Config.IsMelee then
			v208 = v208 / (v_u_34.peek(v_u_35.MeleeSwingSpeedMult) or 1)
		end
		local v209 = v_u_37.Config
		local v210 = nil
		local v211 = nil
		if v_u_37.Aiming and (v209.ADSFireMode and v209.ADSFireRate) then
			v210 = v209.ADSFireMode
			v211 = v209.ADSFireRate
			if v209.VariableShotgun then
				v209.Damage = v209.AimDmg
				v209.BulletsPerShot = v209.ADSPellets
			end
		elseif v209.HipFireMode then
			v210 = v209.HipFireMode
			v211 = v209.HipFireRate
			if v209.VariableShotgun then
				v209.Damage = v209.HipDmg
				v209.BulletsPerShot = v209.HipFirePellets
			end
		end
		if v210 then
			v_u_37.FireMode = v210
			v209.DelayPerShot = v211
			v_u_64.FireModeChanged:Fire(v210)
		end
		local v212 = v_u_37.Config.HeavyDelayPerShot or v_u_37.Config.FireRate
		if v212 then
			v212 = v212 / v_u_7.Data.Variables.FireRate * 0.5 * v160
		end
		if v181 and (v_u_64.PrimaryAttackDown or (v_u_37.Config.IsMelee or v_u_37.Bursting)) and not v_u_37.Busy then
			if v_u_31:IsActive() and v_u_64.PrimaryAttackDown then
				local v213, v214 = v_u_64:DualWieldFire()
				if v213 and v214 then
					v209 = v_u_37.Config
					v208 = (v209.FireRate or (v209.DelayPerShot or 0.15)) / v_u_7.Data.Variables.FireRate * v160
				end
			end
			local v215 = os.clock() - v208 >= (v_u_37.LastShot or 0)
			local v216 = v215 and v_u_37.MouseReleased and ((v_u_37.Config.IsMelee or v_u_37.Ammo > 0) and ((not v_u_37.ReloadingTime or v_u_37.ReloadingTime and (v_u_37.ReloadingTime <= 0 and v_u_37.Reloaded)) and (not v_u_37.Config.PrimeAction or v_u_37.Primed)))
			if v216 then
				if v_u_37.Charging or (not v_u_37.Config.StaminaRequired or v_u_15:GetStamina() >= v_u_37.Config.StaminaRequired) then
					v216 = not v_u_37.Busy
				else
					v216 = false
				end
			end
			if v_u_55 and (v_u_15:GetStamina() < v_u_37.Config.StaminaRequired or not (v_u_37.Config.StaminaRequired and v215)) then
				v_u_37.QuickEquip = nil
				v_u_55 = false
			end
			if v_u_37.Config.CustomShouldFire and not v_u_37.Config.CustomShouldFire(v_u_37) then
				v216 = false
			end
			if v_u_37.Config.StaminaRequired and (v_u_15:GetStamina() < v_u_37.Config.StaminaRequired and v_u_64.PrimaryAttackDown) then
				v_u_18.Elements.StaminaDisplay:FlashRequired(v_u_37.Config.StaminaRequired)
			end
			if v216 and v_u_37.Config.Use then
				if v_u_37.Config.IsTwoHandedAbility then
					function v_u_37.FireServerDeployEvent()
						-- upvalues: (ref) v_u_52
						v_u_52:FireServer()
					end
				else
					v_u_52:FireServer()
				end
				v_u_37.Config:Use(v_u_37)
			elseif v216 then
				if v_u_64.PrimaryAttackDown and (not v_u_37.PrimaryAttackStart and v181) then
					v_u_37.PrimaryAttackStart = os.clock()
					v_u_37.Charging = true
				elseif not v_u_64.PrimaryAttackDown and v_u_37.PrimaryAttackStart or v_u_55 then
					v_u_54 = true
				end
				if v_u_37.Charging and (os.clock() >= v_u_37.PrimaryAttackStart + (v_u_37.Config.ChargeTime or 9999) and (v_u_15:GetStamina() >= (v_u_37.Config.HeavyStaminaRequired or 9999999) and (v_u_18.Elements.StaminaDisplay and not v_u_18.Elements.StaminaDisplay.ChargeDisplay))) then
					v_u_18.Elements.StaminaDisplay.ChargeDisplay = true
					v_u_18.Elements.StaminaDisplay:ChargeReady()
				end
				if not v_u_37.Config.IsMelee or (v_u_54 or v_u_37.Charging and v_u_15:GetStamina() <= 0) then
					v_u_54 = false
					if v_u_37.StartSFX and not v_u_37.Config.HasSuppressor then
						v_u_27:Start(v_u_37)
					elseif v_u_37.Config.ShootSingle then
						local v217 = v_u_37.Config.ShootSingle
						if v_u_37.Config.HasSuppressor and v_u_37.Config.SuppressorShootSingle then
							v217 = v_u_37.Config.SuppressorShootSingle
						end
						v_u_21:PlaySound(v217)
					end
					if v_u_37.Config.LayeredSFXs then
						for v218, v219 in v_u_37.Config.LayeredSFXs do
							if tonumber(v218) > 0 then
								for _, v_u_220 in v219 do
									task.delay(v218, function()
										-- upvalues: (ref) v_u_21, (copy) v_u_220
										v_u_21:PlaySound(v_u_220)
									end)
								end
							else
								for _, v221 in v219 do
									v_u_21:PlaySound(v221)
								end
							end
						end
					end
					if v_u_37.AutoLoop and not v_u_37.AutoLoop.Playing then
						v_u_37.AutoLoop:Play()
					end
					local v222, v223
					if v_u_15.States.Crouching then
						v222 = not v209.CrouchSpreadReduction and 50 or v209.CrouchSpreadReduction * 10
						v223 = true
					else
						v223 = false
						v222 = 100
					end
					if v_u_15.States.Proning then
						v222 = not v209.ProneSpreadReduction and 25 or v209.ProneSpreadReduction * 10
						v223 = true
					end
					if v_u_37.Aiming and (v_u_37.ADSStrength and v_u_37.ADSStrength > 0.9) then
						if v223 then
							v222 = v222 * 1.65
						end
						v222 = v222 * (v209.ADSSpreadReduction or 0.75)
					end
					if v209.Spread or v209.BaseSpread then
						local v224 = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult") or 1
						local v225 = (v209.BaseSpread or v209.Spread) * v_u_7.Data.Variables.WeaponSpread * v224
						v_u_37.ShootingInaccuracy = v_u_37.ShootingInaccuracy + v225 * v222
					end
					v_u_64.GunFired:Fire(v_u_37)
					v_u_37:Shoot()
					v_u_37.PrimaryAttackStart = nil
					v_u_37.Charging = false
					if not (v_u_15.States and v_u_15.States.InSwanSong) then
						v_u_37.Ammo = v_u_37.Ammo - (v_u_37.Config.AmmoPerShot or 1)
					end
					if v_u_37.Config.AmmoUpdated then
						task.defer(function()
							-- upvalues: (ref) v_u_37
							local v226 = {
								["Ammo"] = v_u_37.Ammo,
								["StoredAmmo"] = v_u_37.StoredAmmo
							}
							v_u_37.Config.AmmoUpdated(v226, v_u_37.Viewmodel.Model, {
								["Ammo"] = v_u_37.Ammo - (v_u_37.Config.AmmoPerShot or 1),
								["StoredAmmo"] = v_u_37.StoredAmmo
							})
						end)
					end
					if v_u_37.Config.StaminaUsed then
						v_u_15:DrainStamina(v_u_37.Config.StaminaUsed, v_u_37.Config.StaminaCooldown)
					end
					if v_u_37.Config.IsMelee then
						v_u_15.BlockPressed = false
						v_u_64.SecondaryAttackDown = false
						v_u_37.MeleeStart = os.clock()
						v_u_37.Meleeing = true
						v_u_55 = false
					else
						v_u_64.AmmoChanged:Fire()
					end
					local v227 = os.clock()
					if v_u_37.LastShot then
						local v228 = v_u_37.LastShot + v208
						if v227 - v228 < v208 * 0.5 then
							v227 = v228
						end
					end
					v_u_37.LastShot = v227 + (v_u_37.DoingHeavy and (v212 - v208 or 0) or 0)
					if v_u_31:IsActive() and not v_u_64:IsDualWieldAutoMode() then
						v_u_64:DualWieldAlternate()
					end
					if v_u_37.FireMode == "Burst" and not v_u_37.Bursting then
						v_u_37.Bursting = true
					end
					if v_u_37.Bursting then
						if not v_u_37.CurrentShot then
							v_u_37.CurrentShot = 1
						end
						local v229 = v_u_37
						v229.CurrentShot = v229.CurrentShot + 1
						if v_u_37.CurrentShot > v_u_37.Config.BurstAmt then
							local v230 = (v_u_37.Config.BurstDelay or 0) * v160
							v_u_37.CurrentShot = 1
							v_u_37.Bursting = false
							v_u_37.LastShot = os.clock() + v230
							v_u_37.MouseReleased = false
						end
					end
					if v_u_37.FireMode == "Semi-Auto" or v_u_37.Config.PrimeAction then
						v_u_37.MouseReleased = false
					end
					if v_u_37.Config.PrimeAction then
						v_u_37.Priming = false
						if v_u_37.Ammo > 0 or v_u_37.Config.PrimeOnLastShot then
							v_u_37.Primed = false
						end
					end
				end
			end
		elseif os.clock() - (v_u_37.FireMode == "Burst" and 0 or v208) >= (v_u_37.LastShot or 0) then
			v_u_37.MouseReleased = true
		end
		if not (v_u_37.Primed or v_u_37.Reloading) then
			local v231 = v_u_37.Viewmodel.Animations.Pump
			if v231 then
				v231.Priority = Enum.AnimationPriority.Action3
				local v232 = v231.Length / (v_u_37.Config.BoltAnimationTime or v208)
				v_u_37.Viewmodel:PlayAnimation("Pump", 0, 1, v232 * v159)
			end
			v_u_37.Primed = true
			v_u_37.LastShot = os.clock()
		end
		for _, v233 in v_u_31:GetActiveWeapons() do
			v233.SecondaryAttackDown = v_u_64.SecondaryAttackDown
		end
		if v_u_37.LoopSFX_Playing and (not v_u_64.PrimaryAttackDown or (not v181 or (v_u_37.Ammo <= 0 or (v_u_37.Reloading or v_u_30:IsActive())))) then
			v_u_27:Stop(v_u_37)
		end
	end
	if v_u_31:IsActive() then
		local v234, v235 = v_u_31:GetWeapons()
		local v236 = nil
		if v_u_37 == v234 and v235 then
			v236 = v235
		elseif v_u_37 == v235 then
			v236 = v234 or v236
		end
		if v236 and v236.Reloading then
			local v237 = (game.Players.LocalPlayer:GetAttribute("Skill_ReloadSpeedMult") or 1) * (not (v_u_35 and v_u_35.ReloadSpeedMult) and 1 or v_u_34.peek(v_u_35.ReloadSpeedMult))
			if v236.ReloadingTime then
				v236.ReloadingTime = v236.ReloadingTime - p158
				if v236.ReloadingTime <= 0 then
					v236.ReloadingTime = 0
					if v236.Config.UsesLoadLoop then
						if v236.LoopStage == 1 then
							v236.LoopStage = 2
							v236.IncreasedAmmo = true
						end
						if v236.LoopStage == 2 then
							if v236.StoredAmmo <= 0 or v236.Ammo >= v236.Config.Ammo then
								v236.LoopStage = 3
							end
							if v236.IncreasedAmmo then
								if v236.LoopStage == 2 then
									local v238 = v236.Viewmodel.Animations.LoadLoop
									if v238 then
										v238.Priority = Enum.AnimationPriority.Action4
										local v239 = v238.Length / (v236.Config.InsertAnimationTime or v236.Config.InsertTime)
										v236.Viewmodel:PlayAnimation("LoadLoop", 0, 1, v239 * v159 / v237)
									end
									v236.ReloadingTime = v236.Config.IncrAmmoCountTime * v160 * v237
									v236.IncreasedAmmo = false
								end
							elseif v236.LoopStage == 2 then
								local v240 = v236.Config.AmmoPerLoad or 1
								if v236.StoredAmmo < v240 then
									v240 = v236.StoredAmmo
								end
								if v240 + v236.Ammo > v236.Config.Ammo then
									v236.Ammo = v236.Config.Ammo
								else
									v236.Ammo = v236.Ammo + v240
								end
								v236.StoredAmmo = v236.StoredAmmo - v240
								v_u_64.AmmoChanged:Fire()
								v236.ReloadingTime = (v236.Config.InsertTime - v236.Config.IncrAmmoCountTime) * v160 * v237
								v236.IncreasedAmmo = true
							end
						end
						if v236.LoopStage == 3 then
							v236.Viewmodel:StopAnimation("LoadLoop")
							v236.Viewmodel:StopAnimation("LoadIdle")
							v236.Viewmodel:StopAnimation("LoadStart")
							v236.Viewmodel:StopAnimation("LoadStartEmpty")
							local v241 = v236.Viewmodel.Animations.LoadStop
							if v241 then
								local v242 = v241.Length / (v236.Config.LoadStopAnimationTime or v236.Config.LoadStartTime)
								v236.Viewmodel:PlayAnimation("LoadStop", 0, 1, v242 * v159 / v237)
							end
							v236.LoopStage = 4
						end
						if not v236.Reloaded and v236.LoopStage == 4 then
							v236.Reloading = false
							v236.Reloaded = true
							v236.CancelReload = false
							v_u_64:DualWieldReloadComplete(v236)
						end
					elseif not v236.Reloaded then
						v236.Reloading = false
						if v236.newAmmo then
							v236.Ammo = v236.newAmmo[1]
							v236.StoredAmmo = v236.newAmmo[2]
							v_u_64.AmmoChanged:Fire()
							v236.newAmmo = nil
						end
						v236.Reloaded = true
						v236:ReloadFinished()
						v_u_64:DualWieldReloadComplete(v236)
					end
				end
			end
			if v236.Ammo <= 0 and (not v236.Reloading and v236.StoredAmmo > 0) then
				v_u_64:DualWieldAutoReload(v236)
			end
		end
	end
end
function Lerp(p243, p244, p245) -- name: Lerp
	return p243 * (1 - p245) + p244 * p245
end
function removeWeapons() -- name: removeWeapons
	-- upvalues: (ref) v_u_37, (ref) v_u_39, (copy) v_u_64, (copy) v_u_47, (copy) v_u_48, (ref) v_u_41
	if v_u_37 then
		v_u_37:ForceUnequip()
		UnequipWeapon()
		v_u_39 = nil
		v_u_64.EquippedSlot:Fire(nil)
	end
	for v246, v247 in v_u_47 do
		v247:Destroy()
		v_u_47[v246] = nil
	end
	table.clear(v_u_48)
	v_u_41 = nil
end
local v_u_248 = {}
local function v_u_251(p249) -- name: addToWeaponEventQueue
	-- upvalues: (copy) v_u_248
	local v250 = v_u_248
	table.insert(v250, p249)
	if #v_u_248 == 1 then
		repeat
			v_u_248[1]()
			table.remove(v_u_248, 1)
		until #v_u_248 == 0
	end
end
v_u_36.UpdateAmmo:SetClientListener(function(p_u_252)
	-- upvalues: (copy) v_u_251, (copy) v_u_47, (copy) v_u_64
	v_u_251(function()
		-- upvalues: (copy) p_u_252, (ref) v_u_47, (ref) v_u_64
		for v253, v254 in p_u_252 do
			local v255 = v_u_47[tonumber(v253)]
			if v255 then
				for v256, v257 in v254 do
					v255[v256] = v257
				end
				v255.newAmmo = nil
				v255.ServerFinishedReload = false
			end
		end
		v_u_64.AmmoChanged:Fire()
	end)
end)
game.Players.LocalPlayer.CharacterRemoving:Connect(function()
	-- upvalues: (copy) v_u_15, (copy) v_u_64
	removeWeapons()
	v_u_15:UpdateInventory({})
	v_u_64.InventoryChanged:Fire({})
end)
v_u_36.SetLoadout:SetClientListener(function(p_u_258)
	-- upvalues: (copy) v_u_251, (copy) v_u_47, (copy) v_u_19, (copy) v_u_64, (copy) v_u_48, (ref) v_u_41, (ref) v_u_46, (copy) v_u_27, (ref) v_u_42, (copy) v_u_15, (copy) v_u_49, (ref) v_u_39, (ref) v_u_45
	v_u_251(function()
		-- upvalues: (ref) v_u_47, (copy) p_u_258, (ref) v_u_19, (ref) v_u_64, (ref) v_u_48, (ref) v_u_41, (ref) v_u_46, (ref) v_u_27, (ref) v_u_42, (ref) v_u_15, (ref) v_u_49, (ref) v_u_39, (ref) v_u_45
		for _, v259 in v_u_47 do
			if v259.Config.Reset then
				v259.Config:Reset(v259)
			end
		end
		local v260 = p_u_258
		local v261, v262 = unpack(v260)
		removeWeapons()
		for v263, v264 in v261 do
			local v_u_265 = v_u_19.new(v264.id, v264.mods)
			v_u_265.Slot = v263
			v_u_265.Viewmodel.ConfigLoaded:Once(function()
				-- upvalues: (copy) v_u_265, (ref) v_u_64
				local v266 = v_u_265
				local v267 = v_u_265.Config.FireMode
				if v267 then
					v267 = v_u_265.Config.FireMode[v_u_265.SelFireMode]
				end
				v266.FireMode = v267
				v_u_64.FireModeChanged:Fire()
			end)
			v_u_47[v263] = v_u_265
			v_u_47[v263].Slot = v263
			local v268 = v_u_47[v263]
			local v269 = v264.ammo
			v268.Ammo = v269 and (v264.ammo[1] or 0) or v269
			local v270 = v_u_47[v263]
			local v271 = v264.ammo
			v270.StoredAmmo = v271 and (v264.ammo[2] or 0) or v271
			local v272 = v_u_47[v263]
			local v273 = v264.hbslot
			v272.HotbarSlot = tonumber(v273) or 4
			if not v_u_48[v_u_265.HotbarSlot] then
				v_u_48[v_u_265.HotbarSlot] = {}
			end
			local v274 = v_u_48[v_u_265.HotbarSlot]
			table.insert(v274, v_u_265)
			if v_u_265.Config.IsMelee then
				v_u_41 = v263
			end
			if v_u_265.Config.IsAPistol then
				v_u_46 = v263
			end
			if v_u_265.Config.Shooting_Start then
				v_u_27:Init(v_u_265)
			end
		end
		v_u_42 = nil
		v_u_15:UpdateInventory(v_u_47)
		v_u_64.InventoryChanged:Fire(v_u_47)
		if v262 then
			for v275, v276 in v_u_48 do
				for v277, v278 in v276 do
					if v278.Slot == v262 then
						v_u_49.X = v275
						v_u_49.Y = v277
					end
				end
			end
			v_u_42 = v262
			v_u_39 = v262
			v_u_45 = tonumber(v262)
			v_u_64.EquippedSlot:Fire(v_u_39)
			SwapWeapon(v262, true)
		end
	end)
end)
v_u_15.States:GetPropertyChangedSignal("IsDead"):Connect(function(p279)
	-- upvalues: (ref) v_u_37, (ref) v_u_39, (copy) v_u_64
	if p279 then
		if v_u_37 then
			v_u_37:ForceUnequip()
			UnequipWeapon()
			v_u_39 = nil
			v_u_64.EquippedSlot:Fire(nil)
		end
	end
end)
v68()
v2:BindToRenderStep("WeaponController", v63, WeaponStepped)
v_u_64:SetInputMethod(v20.getInputMethod())
workspace:SetAttribute("DebugMelee", v_u_26(v_u_25.Graphics.ShowMeleeHitboxes))
function v_u_64.RequestLoadout(_) -- name: RequestLoadout
	-- upvalues: (copy) v_u_36, (copy) v_u_251, (copy) v_u_47, (copy) v_u_19, (copy) v_u_64, (copy) v_u_48, (ref) v_u_41, (ref) v_u_46, (copy) v_u_27, (ref) v_u_42, (copy) v_u_15, (copy) v_u_49, (ref) v_u_39, (ref) v_u_45
	v_u_36.RequestLoadout:Call():After(function(p280, p_u_281)
		-- upvalues: (ref) v_u_251, (ref) v_u_47, (ref) v_u_19, (ref) v_u_64, (ref) v_u_48, (ref) v_u_41, (ref) v_u_46, (ref) v_u_27, (ref) v_u_42, (ref) v_u_15, (ref) v_u_49, (ref) v_u_39, (ref) v_u_45
		if p280 and p_u_281 then
			v_u_251(function()
				-- upvalues: (ref) v_u_47, (copy) p_u_281, (ref) v_u_19, (ref) v_u_64, (ref) v_u_48, (ref) v_u_41, (ref) v_u_46, (ref) v_u_27, (ref) v_u_42, (ref) v_u_15, (ref) v_u_49, (ref) v_u_39, (ref) v_u_45
				for _, v282 in v_u_47 do
					if v282.Config.Reset then
						v282.Config:Reset(v282)
					end
				end
				local v283 = p_u_281
				local v284, v285 = unpack(v283)
				removeWeapons()
				for v286, v287 in v284 do
					local v_u_288 = v_u_19.new(v287.id, v287.mods)
					v_u_288.Slot = v286
					v_u_288.Viewmodel.ConfigLoaded:Once(function()
						-- upvalues: (copy) v_u_288, (ref) v_u_64
						local v289 = v_u_288
						local v290 = v_u_288.Config.FireMode
						if v290 then
							v290 = v_u_288.Config.FireMode[v_u_288.SelFireMode]
						end
						v289.FireMode = v290
						v_u_64.FireModeChanged:Fire()
					end)
					v_u_47[v286] = v_u_288
					v_u_47[v286].Slot = v286
					local v291 = v_u_47[v286]
					local v292 = v287.ammo
					v291.Ammo = v292 and (v287.ammo[1] or 0) or v292
					local v293 = v_u_47[v286]
					local v294 = v287.ammo
					v293.StoredAmmo = v294 and (v287.ammo[2] or 0) or v294
					local v295 = v_u_47[v286]
					local v296 = v287.hbslot
					v295.HotbarSlot = tonumber(v296) or 4
					if not v_u_48[v_u_288.HotbarSlot] then
						v_u_48[v_u_288.HotbarSlot] = {}
					end
					local v297 = v_u_48[v_u_288.HotbarSlot]
					table.insert(v297, v_u_288)
					if v_u_288.Config.IsMelee then
						v_u_41 = v286
					end
					if v_u_288.Config.IsAPistol then
						v_u_46 = v286
					end
					if v_u_288.Config.Shooting_Start then
						v_u_27:Init(v_u_288)
					end
				end
				v_u_42 = nil
				v_u_15:UpdateInventory(v_u_47)
				v_u_64.InventoryChanged:Fire(v_u_47)
				if v285 then
					for v298, v299 in v_u_48 do
						for v300, v301 in v299 do
							if v301.Slot == v285 then
								v_u_49.X = v298
								v_u_49.Y = v300
							end
						end
					end
					v_u_42 = v285
					v_u_39 = v285
					v_u_45 = tonumber(v285)
					v_u_64.EquippedSlot:Fire(v_u_39)
					SwapWeapon(v285, true)
				end
			end)
		end
	end)
end
return v_u_64