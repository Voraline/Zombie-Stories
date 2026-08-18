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
local v_u_16 = require("./OffHandChecks")
local function v_u_20() -- name: lazyLoad
	-- upvalues: (ref) v_u_15, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14
	local v17 = game:GetService("ReplicatedStorage")
	if not v_u_15 then
		v_u_15 = require(v17.common.RedEvents.Framework.FrameworkEvents).OffHandUse
	end
	if not v_u_12 then
		local v18 = script.Parent.Parent.Parent
		local v19 = v18.Parent:WaitForChild("Classes")
		v_u_12 = require(v18.ViewmodelManager)
		v_u_13 = require(v19.Viewmodel.ViewmodelUtils.FakeArmUtil)
		v_u_14 = require(v17.common:WaitForChild("PlayerHandler"))
	end
end
function v1.Init(_, p21) -- name: Init
	-- upvalues: (ref) v_u_5, (ref) v_u_6, (ref) v_u_7, (ref) v_u_8, (ref) v_u_9, (ref) v_u_10, (ref) v_u_11
	v_u_5 = p21.Inventory
	v_u_6 = p21.CurrentWeaponGetter
	v_u_7 = p21.AmmoChangedSignal
	v_u_8 = p21.QuickSwapModule
	v_u_9 = p21.DualWieldModule
	v_u_10 = p21.SetSwappingDisabled
	v_u_11 = p21.LPC
end
function v1.IsActive(_) -- name: IsActive
	-- upvalues: (ref) v_u_2
	return v_u_2
end
function v1.GetItem(_) -- name: GetItem
	-- upvalues: (ref) v_u_3
	return v_u_3
end
function v1.GetPrimaryWeapon(_) -- name: GetPrimaryWeapon
	-- upvalues: (ref) v_u_4
	return v_u_4
end
function v1.UseItem(_, p22) -- name: UseItem
	-- upvalues: (ref) v_u_2, (ref) v_u_9, (ref) v_u_5, (ref) v_u_6, (copy) v_u_16, (copy) v_u_20, (ref) v_u_8, (ref) v_u_4, (ref) v_u_3, (ref) v_u_10, (ref) v_u_12, (ref) v_u_13, (ref) v_u_7, (ref) v_u_11, (ref) v_u_14, (ref) v_u_15
	if v_u_2 then
		return false
	end
	if v_u_9 and v_u_9:IsActive() then
		return false
	end
	local v23 = v_u_5[p22]
	local v24 = v_u_6()
	if not v_u_16.CanUseItem(v23, v24) then
		return false
	end
	if not v_u_16.CanUseWithCurrentWeapon(v24) then
		return false
	end
	v_u_20()
	if v_u_8 and v_u_8:IsActive() then
		v_u_8:Complete()
		v24 = v_u_6()
	end
	v_u_4 = v24
	v_u_3 = v23
	v_u_2 = true
	if v_u_10 then
		v_u_10(true)
	end
	if v_u_4 then
		if v_u_4.Viewmodel then
			v_u_4.Viewmodel.ForceOneHanded = true
			v_u_4.Viewmodel.RightArmOnly = true
		end
		v_u_12:SetArmRequest(v_u_4, "Right")
	end
	v_u_3.IsDualWieldLeft = true
	v_u_3.IsEquipped = true
	if v_u_3.Viewmodel then
		v_u_3.Viewmodel.LeftArmOnly = true
		v_u_3.Viewmodel:SetEnabled(true)
	end
	v_u_12:Equip(v_u_3, "Left", 20)
	if v_u_3.Viewmodel and v_u_3.Viewmodel.Model then
		v_u_13:SetArmOwner("Left", v_u_3.Viewmodel.Model)
	end
	task.delay(0.1, function()
		-- upvalues: (ref) v_u_10, (ref) v_u_2
		if v_u_10 and v_u_2 then
			v_u_10(false)
		end
	end)
	v_u_7:Fire(true)
	if v_u_11 then
		v_u_11.States.OffHandActive = true
	end
	local v25 = v_u_14:GetPlayerState(game.Players.LocalPlayer)
	if v25 then
		v25.OffHandActive = true
		v25.OffHandEquipped = v_u_3.Config.WeaponId or (v_u_3.Name or false)
		v25.OffHandWepId = v_u_3.WepId or false
	end
	if v_u_3.Config.Use then
		if v_u_15 and v_u_3.WepId then
			v_u_15:FireServer({
				["WepId"] = v_u_3.WepId
			})
		end
		task.defer(function()
			-- upvalues: (ref) v_u_3
			v_u_3.Config.Use(v_u_3.Config, v_u_3)
		end)
	end
	return true
end
function v1.Cancel(_) -- name: Cancel
	-- upvalues: (ref) v_u_2, (copy) v_u_20, (ref) v_u_10, (ref) v_u_3, (ref) v_u_12, (ref) v_u_4, (ref) v_u_13, (ref) v_u_11, (ref) v_u_14, (ref) v_u_7
	if not v_u_2 then
		return false
	end
	v_u_20()
	if v_u_10 then
		v_u_10(false)
	end
	if v_u_3 then
		local v26
		if v_u_3.Config.CancelPreActivation then
			v26 = v_u_3.Config.CancelPreActivation(v_u_3.Config, v_u_3)
		else
			v26 = false
		end
		v_u_3.IsDualWieldLeft = false
		v_u_3.IsEquipped = false
		if v_u_3.Viewmodel then
			v_u_3.Viewmodel.LeftArmOnly = false
			v_u_3.Viewmodel.ForceOneHanded = false
			v_u_3.Viewmodel:SetEnabled(false)
		end
		v_u_12:Unequip(v_u_3)
		v_u_3 = nil
	end
	if v_u_4 then
		if v_u_4.Viewmodel then
			v_u_4.Viewmodel.ForceOneHanded = false
			v_u_4.Viewmodel.RightArmOnly = false
			v_u_13:SetArmOwner("Left", v_u_4.Viewmodel.Model)
		end
		v_u_12:SetArmRequest(v_u_4, "Both")
	end
	v_u_2 = false
	v_u_4 = nil
	if v_u_11 then
		v_u_11.States.OffHandActive = false
	end
	local v27 = v_u_14:GetPlayerState(game.Players.LocalPlayer)
	if v27 then
		v27.OffHandActive = false
		v27.OffHandEquipped = false
		v27.OffHandWepId = false
	end
	v_u_7:Fire(true)
	return true
end
function v1.Complete(p28) -- name: Complete
	return p28:Cancel()
end
function v1.Cleanup(_) -- name: Cleanup
	-- upvalues: (ref) v_u_2, (copy) v_u_20, (ref) v_u_10, (ref) v_u_3, (ref) v_u_12, (ref) v_u_4, (ref) v_u_11, (ref) v_u_14
	if v_u_2 then
		v_u_20()
		if v_u_10 then
			v_u_10(false)
		end
		if v_u_3 then
			v_u_3.IsDualWieldLeft = false
			v_u_3.IsEquipped = false
			if v_u_3.Viewmodel then
				v_u_3.Viewmodel.LeftArmOnly = false
				v_u_3.Viewmodel.ForceOneHanded = false
				v_u_3.Viewmodel:SetEnabled(false)
			end
			v_u_12:Unequip(v_u_3)
		end
		if v_u_4 and v_u_4.Viewmodel then
			v_u_4.Viewmodel.ForceOneHanded = false
			v_u_4.Viewmodel.RightArmOnly = false
		end
		v_u_2 = false
		v_u_3 = nil
		v_u_4 = nil
		if v_u_11 then
			v_u_11.States.OffHandActive = false
		end
		local v29 = v_u_14:GetPlayerState(game.Players.LocalPlayer)
		if v29 then
			v29.OffHandActive = false
			v29.OffHandEquipped = false
			v29.OffHandWepId = false
		end
	end
end
return v1