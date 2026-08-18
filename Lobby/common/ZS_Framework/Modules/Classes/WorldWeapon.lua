local v1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("Players")
local v4 = v1.common
local v5 = v1.common.SharedResources
script.Parent.Parent:WaitForChild("Shared")
local v6 = script.Parent.Parent.Utils
local v_u_7 = workspace.CurrentCamera
local v_u_8 = require(v4:WaitForChild("ItemData"))
local v_u_9 = require(script.Parent:WaitForChild("WorldViewmodel"))
local v_u_10 = require(v4:WaitForChild("WepConfig"))
local v_u_11 = require(v6:WaitForChild("BulletUtil"))
local v_u_12 = require(v6:WaitForChild("SoundUtil"))
local v_u_13 = require(v5.Attachments.AttachmentSystem.AttachmentsRoot)
local v_u_14 = require("@game/ReplicatedStorage/common/Settings")
local v_u_15 = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local function v_u_25(p16, p17) -- name: isInView
	-- upvalues: (copy) v_u_7
	local v18 = v_u_7.CFrame.LookVector
	local v19 = p16 - v_u_7.CFrame.Position
	local v20 = v_u_7.FieldOfView + 2
	local v21 = v19.Unit:Angle(v18)
	local v22 = math.deg(v21)
	if math.floor(v22) > v20 then
		return false
	end
	if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.PrimaryPart then
		v19 = p16 - game.Players.LocalPlayer.Character.PrimaryPart.Position or v19
	end
	local v23 = v19.X
	local v24 = v19.Z
	return Vector3.new(v23, 0, v24).Magnitude <= p17
end
local v_u_26 = {}
v_u_26.__index = v_u_26
function v_u_26.new(p27, p28, p29, p30) -- name: new
	-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) v_u_13, (copy) v_u_9, (copy) v_u_3, (copy) v_u_2, (copy) v_u_26
	local v31 = v_u_8:GetItemIdFromName(p27) or p27
	local v32 = v_u_10:GetWeaponConfig(v31)
	if not v32 then
		warn("[Weapon] Could not get weapon config of " .. p27)
		return nil
	end
	local v33 = v_u_8.List[v31] or {
		["Name"] = v32.WeaponName or "NO NAME",
		["Rarity"] = v32.Rarity or "Stock"
	}
	local v34 = {
		["Owner"] = p30,
		["WeaponId"] = v31 or v32.WeaponId,
		["Config"] = deepCopy(v32),
		["WeaponData"] = v33
	}
	v34.Mods = v_u_13.new(v34.Config, p29)
	v34.Ammo = 1
	v34.StoredAmmo = 1
	v34.Viewmodel = v_u_9.new(p28, v34)
	if v34.Owner ~= v_u_3.LocalPlayer then
		v_u_2:AddTag(v34.Viewmodel.Model, "WorldWeapon")
	end
	local v35 = v_u_26
	return setmetatable(v34, v35)
end
function v_u_26.Equip(p_u_36) -- name: Equip
	if not p_u_36.LowPolyMode and p_u_36.Config.CustomEquip then
		task.spawn(function()
			-- upvalues: (copy) p_u_36
			if not p_u_36.Viewmodel.Model then
				repeat
					task.wait()
				until p_u_36.IsDestroyed or p_u_36.Viewmodel.Model
			end
			if not p_u_36.IsDestroyed then
				p_u_36.Config.CustomEquip(p_u_36.Ammo, p_u_36.Viewmodel.Model, {
					["Ammo"] = p_u_36.Ammo,
					["StoredAmmo"] = p_u_36.StoredAmmo
				})
			end
		end)
	end
end
function v_u_26.ForceUnequip(_) -- name: ForceUnequip end
function v_u_26.Unequip(_) -- name: Unequip end
function v_u_26.Reload(p_u_37, p38) -- name: Reload
	if p38 then
		p_u_37.Ammo = 0
	else
		p_u_37.Ammo = 1
	end
	if p_u_37.Viewmodel.Animations.Inspect then
		p_u_37.Viewmodel.Animations.Inspect:Stop()
	end
	if p_u_37.Viewmodel.Animations.Shoot then
		p_u_37.Viewmodel.Animations.Shoot:Stop()
	end
	if not p_u_37.LowPolyMode and p_u_37.Config.OnWeaponReload then
		p_u_37.Config.OnWeaponReload(p_u_37)
	end
	if p38 and p_u_37.Viewmodel.Animations.ReloadEmpty then
		p_u_37.Viewmodel:PlayAnimation("ReloadEmpty", 0, 1, p_u_37.Config.EmptyReloadTimeScale or 1)
		return
	elseif p_u_37.Config.UsesLoadLoop and not p38 then
		local v39 = p_u_37.Viewmodel.Animations.LoadStart.Length
		local v40 = v39 / (p_u_37.Config.LoadStopAnimationTime or p_u_37.Config.LoadStartTime)
		p_u_37.Viewmodel:StopAnimation("Pump")
		p_u_37.Viewmodel:PlayAnimation("LoadStart", 0, 1, v40)
		p_u_37.LoadingLoop = true
		task.delay(v39, function()
			-- upvalues: (copy) p_u_37
			if p_u_37.LoadingLoop then
				p_u_37.Viewmodel.Animations.LoadLoop.Looped = true
				local v41 = p_u_37.Viewmodel.Animations.LoadLoop.Length / (p_u_37.Config.InsertAnimationTime or p_u_37.Config.InsertTime)
				p_u_37.Viewmodel:PlayAnimation("LoadLoop", 0, 1, v41)
			end
		end)
		return
	elseif p_u_37.Config.UsesLoadLoop and p38 then
		local v42 = p_u_37.Viewmodel.Animations.LoadStop.Length / (p_u_37.Config.LoadStopAnimationTime or p_u_37.Config.LoadStartTime)
		p_u_37.Viewmodel:StopAnimation("LoadLoop")
		p_u_37.Viewmodel:PlayAnimation("LoadStop", 0, 1, v42)
	else
		p_u_37.Viewmodel:PlayAnimation("Reload", 0, 1, p_u_37.Config.ReloadTimeScale or 1)
	end
end
function v_u_26.Charging(p43) -- name: Charging
	if not p43.ChargeAttack then
		p43.ChargeAttack = true
		p43.Viewmodel:PlayAnimation("Charge")
		p43.Viewmodel:PlayAnimation("ChargeIdle")
	end
end
function v_u_26.Blocking(p44) -- name: Blocking
	if not p44.Block then
		p44.Block = true
		p44.Viewmodel:StopAnimation("Charge")
		p44.Viewmodel:StopAnimation("ChargeIdle")
		p44.Viewmodel:StopAnimation("HeavySwing")
		p44.Viewmodel:StopAnimation("HeavySwing2")
		p44.Viewmodel:StopAnimation("Swing1")
		p44.Viewmodel:StopAnimation("Swing2")
		p44.Viewmodel:PlayAnimation("Block")
	end
end
function v_u_26.StopBlocking(p45) -- name: StopBlocking
	if p45.Block then
		p45.Block = false
		p45.Viewmodel:StopAnimation("Block")
	end
end
function v_u_26.Melee(p46, p47) -- name: Melee
	p46.ChargeAttack = false
	p46.Viewmodel:StopAnimation("Charge")
	p46.Viewmodel:StopAnimation("ChargeIdle")
	p46.Viewmodel:StopAnimation("HeavySwing")
	p46.Viewmodel:StopAnimation("HeavySwing2")
	p46.Viewmodel:StopAnimation("Swing1")
	p46.Viewmodel:StopAnimation("Swing2")
	p46:StopBlocking()
	if p47 then
		p46.Viewmodel:PlayAnimation("HeavySwing")
		return
	else
		if p46.SwingCombo then
			p46.SwingCombo = p46.SwingCombo + 1
		else
			p46.SwingCombo = 1
		end
		if p46.PreviouslyPlayed then
			p46.Viewmodel:StopAnimation(p46.PreviouslyPlayed)
		end
		if p46.SwingCombo and p46.Viewmodel.Animations["Swing" .. p46.SwingCombo] then
			p46.Viewmodel:PlayAnimation("Swing" .. p46.SwingCombo, 0.1, 1, 1)
			p46.PreviouslyPlayed = "Swing" .. p46.SwingCombo
		else
			p46.SwingCombo = 1
			p46.Viewmodel:PlayAnimation("Swing1")
			p46.PreviouslyPlayed = "Swing1"
		end
	end
end
function v_u_26.Shoot(p_u_48, p_u_49) -- name: Shoot
	-- upvalues: (copy) v_u_11, (copy) v_u_12, (copy) v_u_25, (copy) v_u_15, (copy) v_u_14
	task.spawn(function()
		-- upvalues: (copy) p_u_48, (copy) p_u_49, (ref) v_u_11, (ref) v_u_12, (ref) v_u_25, (ref) v_u_15, (ref) v_u_14
		p_u_48.Viewmodel:StopAnimation("ReloadEmpty")
		p_u_48.Viewmodel:StopAnimation("Reload")
		p_u_48.Viewmodel:StopAnimation("Inspect")
		p_u_48.Viewmodel:StopAnimation("LoadLoop")
		p_u_48._IsWorldWeapon = true
		p_u_48.LoadingLoop = false
		if p_u_48.Config.CustomShootAnimation then
			if not p_u_48.LowPolyMode then
				p_u_48.Config.CustomShootAnimation(p_u_48)
			end
		else
			if p_u_48.Viewmodel.Animations.Shoot then
				p_u_48.Viewmodel:PlayAnimation("Shoot", 0, 1, 1)
			end
			if p_u_48.Viewmodel.Animations.Pump then
				local v50 = p_u_48.Viewmodel.Animations.Pump.Length / (p_u_48.Config.BoltAnimationTime or p_u_48.Config.DelayPerShot)
				p_u_48.Viewmodel:PlayAnimation("Pump", 0, 1, v50)
			end
		end
		for _, v51 in p_u_49 or {} do
			v_u_11:BulletTrail(p_u_48.Viewmodel.BarrelAttachment, v51, p_u_48.Config.BulletTrailSettings)
		end
		if p_u_48.Config.OnShot then
			p_u_48.Config.OnShot(p_u_48, p_u_49[1])
		end
		p_u_48.RecoilOffset = CFrame.new(0, 0, -(p_u_48.Config.VerticalRecoil or 3) * 0.23)
		if p_u_48.Config.ShootSingle then
			local v52 = p_u_48.Config.ShootSingle
			if p_u_48.Config.HasSuppressor and p_u_48.Config.SuppressorShootSingle then
				v52 = p_u_48.Config.SuppressorShootSingle
			end
			v_u_12:PlaySound(v52, p_u_48.Viewmodel.BarrelAttachment.WorldPosition)
		end
		if p_u_48.Config.LayeredSFXs then
			for v53, v54 in p_u_48.Config.LayeredSFXs do
				if tonumber(v53) > 0 then
					for _, v_u_55 in v54 do
						task.delay(v53, function()
							-- upvalues: (ref) v_u_12, (copy) v_u_55, (ref) p_u_48
							v_u_12:PlaySound(v_u_55, p_u_48.Viewmodel.BarrelAttachment.WorldPosition)
						end)
					end
				else
					for _, v56 in v54 do
						v_u_12:PlaySound(v56, p_u_48.Viewmodel.BarrelAttachment.WorldPosition)
					end
				end
			end
		end
		if v_u_25(p_u_48.Viewmodel.BarrelAttachment.WorldPosition, 50) and (p_u_48.Viewmodel.MuzzleModule and v_u_15(v_u_14.Graphics.ParticleQuality) > 1) then
			p_u_48.Viewmodel.MuzzleModule:Emit(p_u_48.Viewmodel)
		end
	end)
end
function v_u_26.Destroy(p57) -- name: Destroy
	p57.Viewmodel:Destroy()
	p57.IsDestroyed = true
end
function deepCopy(p58) -- name: deepCopy
	local v59 = {}
	for v60, v62 in pairs(p58) do
		if type(v62) == "table" then
			local v62 = deepCopy(v62)
		end
		v59[v60] = v62
	end
	return v59
end
return v_u_26