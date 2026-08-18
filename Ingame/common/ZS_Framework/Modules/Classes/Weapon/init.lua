local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = v_u_1.common
local v3 = v_u_1.common.SharedResources
local v4 = script.Parent.Parent:WaitForChild("Shared")
local v5 = script.Parent.Parent.Utils
local v6 = script:WaitForChild("WeaponUtils")
local v7 = v_u_1.common.RedEvents
local v_u_8 = require(v2:WaitForChild("ItemData"))
local v_u_9 = require(script.Parent:WaitForChild("Viewmodel"))
local v_u_10 = require(v2:WaitForChild("WepConfig"))
local v_u_11 = require(v5:WaitForChild("RaycastUtil"))
local v_u_12 = require(v5:WaitForChild("BulletUtil"))
local v_u_13 = require(v4:WaitForChild("SharedSprings"))
local v_u_14 = require(script.Parent.Parent.Controllers:WaitForChild("CameraController"))
local v_u_15 = require(v6:WaitForChild("MeleeUtil"))
local v_u_16 = require(game.ReplicatedStorage.common:WaitForChild("NPCs_Shared"):WaitForChild("Utils"):WaitForChild("ClassMirror"))
local v_u_17 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/Encoder_Util")
require(v2.Settings)
local v_u_18 = require("@game/ReplicatedStorage/common/Signal")
local v_u_19 = require("../Controllers/LocalPlayerController")
local v_u_20 = require(v3.Attachments.AttachmentSystem.AttachmentsRoot)
local v_u_21 = nil
local v_u_22 = require(v5:WaitForChild("CursorRecoilUtil"))
local v_u_23 = require("@game/ReplicatedStorage/common/zap")
local v_u_24 = require(v_u_1.common.HitReg)
local v25 = require(v7.Framework.FrameworkEvents)
local _ = v25.Reloading
local v_u_26 = v25.ReloadingFunction
local v_u_27 = v25.Shoot
require(v_u_1.common.ZS_Shared.Data.GameState)
local v_u_28 = require(v_u_1.Packages.Fusion)
local v_u_29 = nil
pcall(function()
	-- upvalues: (ref) v_u_29, (copy) v_u_1
	v_u_29 = require(v_u_1.common.skillTree.SkillTreeData)
end)
local v_u_30 = {}
v_u_30.__index = v_u_30
v_u_30.Hit = v_u_18.new()
v_u_30.HitEntity = v_u_18.new()
function v_u_30.new(p31, p32) -- name: new
	-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) v_u_14, (copy) v_u_20, (copy) v_u_9, (copy) v_u_15, (copy) v_u_18, (copy) v_u_30
	local v33 = v_u_8:GetItemIdFromName(p31) or p31
	local v34 = v_u_10:GetWeaponConfig(v33)
	if not v34 then
		warn("[Weapon] Could not get weapon config of " .. p31)
		return nil
	end
	local v35 = v_u_8.List[v33] or {
		["Name"] = v34.WeaponName or "NO NAME",
		["Rarity"] = v34.Rarity or "Stock"
	}
	local v36 = {
		["WeaponId"] = v33 or v34.WeaponId,
		["Name"] = v35.Name,
		["Rarity"] = v35.Rarity,
		["BaseConfig"] = v34,
		["Config"] = deepCopy(v34)
	}
	v36.RecoilUtil = v_u_14:NewRecoil(v36)
	v36.Mods = v_u_20.new(v36.Config, p32)
	v36.Viewmodel = v_u_9.new(v36)
	v36.Viewmodel:ApplyOffset("Offset", v34.Offset)
	v36.Primed = true
	local v37 = v36.Config.FireMode
	if typeof(v37) == "string" then
		v36.Config.FireMode = { v36.Config.FireMode }
	end
	if v36.Config.IsMelee then
		v_u_15.NewMelee(v36)
	end
	v36.SelFireMode = 1
	local v38 = v36.Config.FireMode
	if v38 then
		v38 = v36.Config.FireMode[v36.SelFireMode]
	end
	v36.FireMode = v38
	if v36.Config.AutoLoop then
		v36.AutoLoop = Instance.new("Sound")
		v36.AutoLoop.Looped = true
		v36.AutoLoop.SoundId = "rbxassetid://" .. v36.Config.AutoLoop.SoundId
		v36.AutoLoop.Parent = workspace
		v36.AutoLoopEnd = Instance.new("Sound")
		v36.AutoLoopEnd.SoundId = "rbxassetid://" .. v36.Config.AutoLoopEnd.SoundId
		v36.AutoLoopEnd.Parent = workspace
	end
	v36.Equipped = v_u_18.new()
	v36.Destroyed = v_u_18.new()
	local v39 = v_u_30
	return setmetatable(v36, v39)
end
function v_u_30.Equip(p_u_40) -- name: Equip
	-- upvalues: (copy) v_u_19, (copy) v_u_13
	local v41 = v_u_19.FocusEnabled and 1.5 or 1
	local v42 = p_u_40.QuickSwapBonus or 1
	p_u_40.QuickSwapBonus = nil
	p_u_40.IsEquipped = true
	v_u_13.EquipSpring.Target = 0
	if p_u_40.QuickEquip then
		p_u_40.QuickEquip = nil
		v_u_13.EquipSpring.Position = 0.5
	else
		v_u_13.EquipSpring.Position = 1.5
	end
	v_u_13.EquipSpring.Speed = 12 * (p_u_40.Config.DrawSpeed or 1) * v41 * v42
	p_u_40.SwingCombo = nil
	p_u_40.Viewmodel:StopAnimation("HeavySwing")
	p_u_40.Viewmodel:StopAnimation("HeavySwing2")
	p_u_40.Viewmodel:StopAnimation("Swing1")
	p_u_40.Viewmodel:StopAnimation("Swing2")
	p_u_40.Viewmodel:StopAnimation("Inspect")
	if p_u_40.Viewmodel.Animations.Block then
		p_u_40.Viewmodel:StopAnimation("Block")
	end
	p_u_40.Viewmodel:SetEnabled(true)
	p_u_40.Equipped:Fire()
	if p_u_40.Config.CustomEquip then
		task.spawn(function()
			-- upvalues: (copy) p_u_40
			if not p_u_40.Viewmodel.Model then
				repeat
					task.wait()
				until p_u_40.IsDestroyed or p_u_40.Viewmodel.Model
			end
			if not p_u_40.IsDestroyed then
				p_u_40.Config.CustomEquip(p_u_40.Ammo, p_u_40.Viewmodel.Model, {
					["Ammo"] = p_u_40.Ammo,
					["StoredAmmo"] = p_u_40.StoredAmmo
				})
			end
		end)
	end
	if p_u_40.Config.OnEquipped then
		task.spawn(function()
			-- upvalues: (copy) p_u_40
			p_u_40.Config.OnEquipped(p_u_40)
		end)
	end
end
function v_u_30.ForceUnequip(p43) -- name: ForceUnequip
	p43.IsEquipped = false
	if p43.Config.OnUnequipped then
		task.spawn(p43.Config.OnUnequipped, p43)
	end
	p43.Viewmodel:SetEnabled(false)
end
function v_u_30.Unequip(p_u_44) -- name: Unequip
	-- upvalues: (copy) v_u_19, (copy) v_u_13
	p_u_44.Bursting = nil
	p_u_44.CurrentShot = 1
	local v45 = v_u_19.FocusEnabled and 1.5 or 1
	p_u_44.QuickEquip = nil
	p_u_44.IsEquipped = false
	v_u_13.EquipSpring.Target = 1.5
	v_u_13.EquipSpring.Speed = 12 * (p_u_44.Config.HolsterSpeed or 1) * v45
	p_u_44.CancelUnequip = nil
	repeat
		task.wait()
	until v_u_13.EquipSpring.Position >= 1.3 or p_u_44.CancelUnequip
	if p_u_44.Config.IsMelee then
		if p_u_44.Blocking then
			p_u_44.Blocking = nil
			p_u_44.BlockDebounce = p_u_44.BlockCooldown or 0.75
		end
		p_u_44.SwingCombo = 1
		p_u_44.Charging = nil
		p_u_44.MeleeStart = nil
		p_u_44.Meleeing = nil
		p_u_44.SwingStarted = nil
		p_u_44.DoingHeavy = false
		if p_u_44.SlashTrail then
			task.spawn(function()
				-- upvalues: (copy) p_u_44
				p_u_44.SlashTrail.Enabled = false
			end)
		end
	end
	if p_u_44.CancelUnequip then
		p_u_44.IsEquipped = true
		v_u_13.EquipSpring.Target = 0
		v_u_13.EquipSpring.Speed = 12 * (p_u_44.Config.DrawSpeed or 1)
		return true
	end
	if p_u_44.Config.OnUnequipped then
		task.spawn(p_u_44.Config.OnUnequipped, p_u_44)
	end
	p_u_44.Viewmodel:SetEnabled(false)
end
function v_u_30.UpdateAmmo(_) -- name: UpdateAmmo
	-- upvalues: (ref) v_u_21
	if not v_u_21 then
		v_u_21 = require("../Controllers/HUDController/HUDElements/AmmoDisplay")
	end
	v_u_21:UpdateAmmo(true)
end
function v_u_30.Reload(p_u_46) -- name: Reload
	-- upvalues: (copy) v_u_19, (ref) v_u_29, (copy) v_u_28, (copy) v_u_23, (copy) v_u_26
	if p_u_46.Reloading then
		return
	else
		local v47, v48
		if v_u_19.FocusEnabled then
			v47 = 0.5
			v48 = 2
		else
			v47 = 1
			v48 = 1
		end
		if p_u_46.ReloadingTime and p_u_46.ReloadingTime > 0 or (p_u_46.StoredAmmo <= 0 or (p_u_46.Ammo >= p_u_46.Config.Ammo or p_u_46.Config.IsMelee)) then
			if p_u_46.Reloaded == nil then
				p_u_46.Reloaded = p_u_46.Ammo > 0
				p_u_46.Viewmodel:StopAnimation("ReloadEmpty")
			end
			if (p_u_46.Reloaded or p_u_46.Config.IsMelee and not p_u_46.Meleeing) and not p_u_46.Aiming then
				if p_u_46.Viewmodel.Animations.Inspect and not p_u_46.Viewmodel.Animations.Inspect.IsPlaying then
					p_u_46.Viewmodel:PlayAnimation("Inspect", 0, 1, 1)
					p_u_46.Viewmodel:StopAnimation("HeavySwing")
					p_u_46.Viewmodel:StopAnimation("HeavySwing2")
					p_u_46.Viewmodel:StopAnimation("Swing1")
					p_u_46.Viewmodel:StopAnimation("Swing2")
				end
				if p_u_46.Config.InspectStart then
					p_u_46.Config.InspectStart(p_u_46.Viewmodel.Model)
				end
			end
			return
		else
			if p_u_46.Config.ReloadConditional then
				local v49, v50 = p_u_46.Config.ReloadConditional(p_u_46)
				if v49 then
					v50(p_u_46)
					return
				end
			end
			p_u_46.Viewmodel:StopAnimation("Inspect")
			p_u_46.Viewmodel:StopAnimation("Shoot", 1e-6)
			p_u_46.Viewmodel:StopAnimation("Pump")
			local v_u_51 = p_u_46.Ammo
			local v52 = (game.Players.LocalPlayer:GetAttribute("Skill_ReloadSpeedMult") or 1) * (not (v_u_29 and v_u_29.ReloadSpeedMult) and 1 or v_u_28.peek(v_u_29.ReloadSpeedMult))
			if p_u_46.Config.OnWeaponReload then
				p_u_46.Config.OnWeaponReload(p_u_46)
			end
			p_u_46.ServerFinishedReload = false
			if not p_u_46.Reloading then
				p_u_46.Viewmodel:StopAnimation(p_u_46.Config.FirstDrawAnimation or "")
				p_u_46.Viewmodel:StopAnimation(p_u_46.Config.DrawAnimation or "")
			end
			p_u_46.Reloading = true
			p_u_46.Reloaded = false
			p_u_46.ReloadFocusActive = v_u_19.FocusEnabled and true or false
			if p_u_46.Config.UsesLoadLoop then
				v_u_23.Reloading.Fire({
					["Slot"] = p_u_46.Slot
				})
				p_u_46.LoopStage = 1
				p_u_46.ReloadingTime = p_u_46.Config.LoadStartTime * v47 * v52
				local v53 = p_u_46.Viewmodel.Animations.LoadStart
				if p_u_46.Viewmodel.Animations.LoadStartEmpty and p_u_46.Ammo <= 0 then
					local v54 = p_u_46.Viewmodel.Animations.LoadStartEmpty
					local v55 = v54.Length
					local v56 = p_u_46.Config.LoadStartEmptyAnimationTime or p_u_46.Config.LoadStartEmptyTime
					local v57 = v55 / v56
					v54.Priority = Enum.AnimationPriority.Action
					p_u_46.Viewmodel:PlayAnimation("LoadStartEmpty", 0, 1, v57 * v48 / v52)
					p_u_46.ReloadingTime = p_u_46.Config.LoadStartEmptyTime * v47 * v52
					p_u_46.Primed = true
					p_u_46.loadingEmpty = true
					local v_u_58 = os.clock()
					p_u_46.emptyLoadTick = v_u_58
					task.delay((p_u_46.Config.LoadStartEmptyInsertTime or v56) * v47 * v52, function()
						-- upvalues: (copy) p_u_46, (copy) v_u_58
						if p_u_46.Reloading and p_u_46.emptyLoadTick == v_u_58 then
							local v59 = p_u_46
							v59.Ammo = v59.Ammo + 1
							local v60 = p_u_46
							v60.StoredAmmo = v60.StoredAmmo - 1
							p_u_46:UpdateAmmo()
						end
					end)
				elseif v53 then
					local v61 = v53.Length / (p_u_46.Config.LoadStartAnimationTime or p_u_46.Config.LoadStartTime)
					v53.Priority = Enum.AnimationPriority.Action
					print("Reload Start SPeed:", v61)
					p_u_46.Viewmodel:PlayAnimation("LoadStart", 0, 1, v61 * v48 / v52)
				end
				p_u_46.Viewmodel.Animations.LoadIdle.Priority = Enum.AnimationPriority.Movement
				p_u_46.Viewmodel.Animations.LoadIdle.Looped = true
				p_u_46.Viewmodel:PlayAnimation("LoadIdle", 0, 1, 1)
			else
				v_u_26:Call({ p_u_46.Slot }):After(function(_, p62)
					-- upvalues: (copy) p_u_46, (copy) v_u_51
					local v63 = p62[1]
					if p_u_46.Config.OnReloadComplete then
						p_u_46.Config.OnReloadComplete(p_u_46, v_u_51)
					end
					if v63 then
						p_u_46.newAmmo = v63
						p_u_46.ServerFinishedReload = true
					end
				end)
				local v64 = p_u_46.Config.ReloadTimeScale
				local v65 = p_u_46.Config.EmptyReloadTimeScale
				local v66 = p_u_46.Config.ReloadTime * v52
				local v67 = (p_u_46.Config.EmptyReloadTime or p_u_46.Config.ReloadTime) * v52
				local v68 = p_u_46.Config.ReloadTimeUntilMagInserted
				local v69 = p_u_46.Config.EmptyReloadTimeUntilBoltPulled
				local v70 = 1 / v52
				local v71 = (v64 or 1) * v70
				local v72 = (v65 or 1) * v70
				if v_u_19.FocusEnabled then
					v71 = v71 * 2
					v72 = v72 * 2
					v66 = v66 / 2
					v67 = v67 / 2
					if v68 ~= nil then
						v68 = v68 / 2
					end
					if v69 ~= nil then
						v69 = v69 / 2
					end
				end
				if p_u_46.Ammo > 0 then
					p_u_46.Viewmodel:PlayAnimation("Reload", 0, 1, v71)
					p_u_46.ReloadingTimeStart = v66
					p_u_46.ReloadingTime = v66
					p_u_46.ReloadCancelTime = p_u_46.ReloadingTime - (v68 or p_u_46.ReloadingTime)
				else
					p_u_46.Viewmodel:PlayAnimation("ReloadEmpty", 0, 1, v72)
					p_u_46.ReloadingTimeStart = v66
					p_u_46.ReloadingTime = v67 or v66
					p_u_46.ReloadCancelTime = p_u_46.ReloadingTime - (v69 or p_u_46.ReloadingTime)
				end
				p_u_46.MagInUpdate = false
			end
		end
	end
end
function v_u_30.ReloadFinished(p73) -- name: ReloadFinished
	local v74 = p73.Config.Ammo - p73.Ammo
	if p73.newAmmo then
		p73.Ammo = p73.newAmmo[1]
		p73.StoredAmmo = p73.newAmmo[2]
		return
	elseif v74 <= p73.StoredAmmo then
		p73.Ammo = p73.Ammo + v74
		p73.StoredAmmo = p73.StoredAmmo - v74
	elseif p73.StoredAmmo > 0 then
		p73.Ammo = p73.Ammo + p73.StoredAmmo
		p73.StoredAmmo = 0
	end
end
function v_u_30.Shoot(p_u_75) -- name: Shoot
	-- upvalues: (copy) v_u_15, (copy) v_u_22, (copy) v_u_14, (copy) v_u_11, (copy) v_u_30, (copy) v_u_24, (copy) v_u_16, (copy) v_u_17, (copy) v_u_12, (copy) v_u_27
	p_u_75.Viewmodel:StopAnimation(p_u_75.Config.FirstDrawAnimation or "")
	p_u_75.Viewmodel:StopAnimation(p_u_75.Config.DrawAnimation or "")
	if p_u_75.Config.IsMelee then
		p_u_75.Viewmodel:StopAnimation("Inspect")
		v_u_15.Shoot(p_u_75)
	else
		local v_u_76 = p_u_75.Ammo
		local v_u_77 = p_u_75.Slot
		task.spawn(function()
			-- upvalues: (copy) p_u_75, (ref) v_u_22, (ref) v_u_14, (copy) v_u_77, (copy) v_u_76, (ref) v_u_11, (ref) v_u_30, (ref) v_u_24, (ref) v_u_16, (ref) v_u_17, (ref) v_u_12, (ref) v_u_27
			p_u_75.Viewmodel:StopAnimation("ReloadEmpty")
			p_u_75.Viewmodel:StopAnimation("Reload")
			p_u_75.Viewmodel:StopAnimation("Pump")
			p_u_75.Viewmodel:StopAnimation("Inspect")
			p_u_75.Viewmodel:StopAnimation("LoadStop")
			p_u_75.RecoilUtil:Impulse()
			v_u_22:OnShoot(p_u_75)
			p_u_75.Viewmodel:Shoot()
			if p_u_75.Config.CustomShootAnimation then
				p_u_75.Config.CustomShootAnimation(p_u_75)
			else
				p_u_75.Viewmodel:PlayAnimation("Shoot", 0, 1, 1)
			end
			if p_u_75.Config.CameraShake then
				local v78 = v_u_14.CameraShakerAlt
				local v79 = p_u_75.Config.CameraShake
				v78:ShakeOnce(unpack(v79))
			else
				v_u_14.CameraShakerAlt:ShakeOnce(4, 15, 0, 0.1, Vector3.new(), Vector3.new(1, 1, 1))
			end
			if p_u_75.Config.ShellOn then
				p_u_75.NeedShell = true
			end
			local v80 = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0)
			local v81 = { v_u_77, v_u_76, v80 }
			local v82 = {}
			local v83 = nil
			local v84 = nil
			local v85 = nil
			local v86 = nil
			local v87 = nil
			for v88 = 1, p_u_75.Config.BulletsPerShot or 1 do
				local v89 = deepCopy(v82)
				local _ = p_u_75.Config.Penetration
				local v90 = false
				local v91 = {}
				while true do
					local v92 = v_u_11.CastRay
					local v93 = p_u_75
					local v94
					if #v89 >= 1 then
						v94 = v89
					else
						v94 = false
					end
					local v95 = v92(v93, v94, v_u_22.crosshairRecoil)
					local v96 = v95.Position
					if not v90 then
						local v97 = "b" .. v88
						table.insert(v81, v97)
						table.insert(v81, v96)
						v90 = true
					end
					local v98 = v95.Instance
					if not v98 then
						break
					end
					local v99 = (v80 - v98.Position).Magnitude
					local v100 = string.format("%.2f", v99)
					local v101 = "r" .. v100
					table.insert(v81, v101)
					local v102 = {
						["startPos"] = v80,
						["roundedDistance"] = v100,
						["raycastResult"] = v95,
						["weapon"] = p_u_75,
						["prevHit"] = v91,
						["ignoreList"] = v89,
						["toNetwork"] = v81
					}
					local v103 = nil
					v_u_30.Hit:Fire(v95, p_u_75.WeaponId)
					local v104 = v_u_24:ProcessHit(v95, v102)
					local v105 = nil
					if v104 then
						local v106 = v98:FindFirstAncestorWhichIsA("Model")
						if v106 then
							table.insert(v91, v106)
							table.insert(v89, v106)
						else
							table.insert(v91, v98)
							table.insert(v89, v98)
						end
					else
						local v107 = v98:FindFirstAncestorWhichIsA("Model")
						if v107 then
							v105 = v_u_16:GetObjFromModel(v107)
							if v105 and v105.ClientShot then
								v104 = v105:ClientShot(v102)
							else
								v104 = v103
							end
						else
							v104 = v103
						end
					end
					if v104 then
						if v104.BloodNPC and v105 then
							local v108 = v105.UIDTable[v104.BloodNPC[3]].CFrame:ToObjectSpace(CFrame.new(v96, v96)).p
							v104.BloodNPC[4] = v_u_17.EncodePositioningData(v108)
							local v109 = v_u_12
							local v110 = v104.BloodNPC
							v109:BloodNPC(unpack(v110))
							v87 = true
						end
						v87 = v104.HitFlesh and true or v87
						v86 = v104.HitArmor and true or v86
						v84 = v104.HitHeadshot and true or v84
						v83 = v104.Killed and true or v83
						if v104.BrokeArmor then
							v85 = true
						end
					end
					if p_u_75.Config.OnShot then
						p_u_75.Config.OnShot(p_u_75, v95.Position, v104)
					end
					if not v104 then
						v_u_12:MakeImpact(p_u_75.Config, v95, nil, true)
						table.insert(v81, v98)
						break
					end
					if #v91 > (p_u_75.Config.Penetration or 0) then
						break
					end
				end
				v_u_12:BulletTrail(p_u_75.Viewmodel.BarrelAttachment, v96, p_u_75.Config.BulletTrailSettings)
			end
			p_u_75.lastZombieHit = nil
			v_u_27:FireServer(v81)
			v_u_24:ProcessNetworkQueue()
			if v83 then
				v_u_30.HitEntity:Fire("Kill")
				return
			elseif v84 then
				v_u_30.HitEntity:Fire("Headshot")
				return
			elseif v85 then
				v_u_30.HitEntity:Fire("ArmorBreak", {
					["dontDoSound"] = true
				})
				return
			elseif v86 then
				v_u_30.HitEntity:Fire("HitArmor", {
					["dontDoSound"] = true
				})
			elseif v87 then
				v_u_30.HitEntity:Fire("Flesh")
			end
		end)
	end
end
function v_u_30.Destroy(p111) -- name: Destroy
	p111.Viewmodel:Destroy()
	p111.IsDestroyed = true
	p111.Destroyed:Fire()
	p111.Equipped:DisconnectAll()
	p111.Destroyed:DisconnectAll()
end
function deepCopy(p112) -- name: deepCopy
	local v113 = {}
	for v114, v116 in pairs(p112) do
		if type(v116) == "table" then
			local v116 = deepCopy(v116)
		end
		v113[v114] = v116
	end
	return v113
end
return v_u_30