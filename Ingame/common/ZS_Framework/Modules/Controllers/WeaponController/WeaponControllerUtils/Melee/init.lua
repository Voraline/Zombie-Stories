local v1 = game:GetService("ReplicatedStorage")
local v2 = v1.common
local v3 = script.Parent.Parent.Parent.Parent:WaitForChild("Utils")
local v4 = game.ReplicatedStorage.common.RedEvents
local v_u_5 = require(v3:WaitForChild("BulletUtil"))
local v_u_6 = require(script:WaitForChild("MeleeCaster"))
local v7 = require(v2:WaitForChild("Signal"))
require(v3.Parent.Controllers.CameraController)
local v_u_8 = require(v3:WaitForChild("SoundUtil"))
local v_u_9 = require(game.ReplicatedStorage.common:WaitForChild("NPCs_Shared"):WaitForChild("Utils"):WaitForChild("ClassMirror"))
local v_u_10 = require(v1.common.HitReg)
local v_u_11 = require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local v_u_12 = require(v1.Packages.Fusion)
local v_u_13 = require(v1.common.skillTree.SkillTreeData)
local v_u_14 = v7.new()
local v_u_15 = require(v4.Framework.FrameworkEvents).MeleeReg
local v_u_62 = {
	["Hit"] = v7.new(),
	["Think"] = function(p_u_16, p17, p18) -- name: Think
		-- upvalues: (copy) v_u_6, (copy) v_u_14, (copy) v_u_12, (copy) v_u_13, (copy) v_u_8, (copy) v_u_11
		local v19 = -60 * p17
		local v20 = 1 - math.exp(v19)
		local v21 = math.min(v20, 1)
		local v22 = p_u_16.Config
		local v23 = p_u_16.MeleeStart
		if p_u_16.Meleeing and v23 then
			local v24 = p_u_16.DoingHeavy and v22.HeavySwingStart or v22.SwingStart
			local v25 = p_u_16.DoingHeavy and v22.HeavySwingEnd or v22.SwingEnd
			local v26 = p_u_16.DoingHeavy and v22.HeavyDelayPerShot or v22.DelayPerShot
			local v27 = (v26 == 0 and 1 or v26) / (v24 + v25)
			p_u_16.MeleeRPMRatio = v27
			local v28 = not (p_u_16.DoingHeavy and v22.HeavySwingRPMScaling or p_u_16.DoingHeavy)
			if v28 then
				v28 = v22.SwingRPMScaling
			end
			local v_u_29
			if v22.SwingData then
				v_u_29 = v22.SwingData[p_u_16.PreviouslyPlayed or "Swing1"] or v22.SwingData.Swing1
				if v_u_29 then
					v24 = v_u_29.start
				end
			else
				v_u_29 = nil
			end
			if v28 then
				v24 = v24 * v27
				v25 = v25 * v27
			end
			if p_u_16.SwingStarted then
				if p_u_16.SwingStarted and os.clock() >= v23 + v25 then
					task.spawn(function()
						-- upvalues: (copy) p_u_16
						local v30 = p_u_16.SlashTrail
						if v30 then
							v30.Enabled = false
						end
					end)
					p_u_16.Meleeing = nil
					p_u_16.SwingStarted = nil
					if p_u_16.DoingHeavy then
						local v31 = p_u_16.Config
						v31.Damage = v31.Damage / 2
					end
					p_u_16.DoingHeavy = false
				end
			elseif os.clock() >= v23 + v24 then
				task.spawn(function()
					-- upvalues: (copy) p_u_16
					if p_u_16.SlashTrail then
						p_u_16.SlashTrail.Enabled = true
					else
						local v32 = p_u_16.Viewmodel.Model
						local v33 = v32 and (v32:FindFirstChild("KeyParts") and v32.KeyParts:FindFirstChild("SlashTrail"))
						if v33 then
							p_u_16.SlashTrail = v33
							p_u_16.SlashTrail.Enabled = true
						end
					end
				end)
				p_u_16.SwingStarted = true
				p_u_16.TimesHitEnemy = {}
				p_u_16.HitModels = {}
				if v_u_29 then
					task.spawn(function()
						-- upvalues: (ref) v_u_6, (ref) v_u_29, (ref) v_u_14, (copy) p_u_16
						v_u_6:StartCast(v_u_29, v_u_14, p_u_16)
					end)
				end
				if p_u_16.DoingHeavy then
					local v34 = p_u_16.Config
					v34.Damage = v34.Damage * 2
				end
			end
		end
		if v23 and os.clock() >= v23 + (v22.SwingComboEnd or 0) then
			p_u_16.SwingCombo = 0
		end
		if p_u_16.Viewmodel.Animations then
			if p_u_16.Viewmodel.Animations.Block then
				local v35 = v22.ParryOnly
				if p_u_16.Blocking or (p_u_16.SecondaryAttackDown or p18.BlockPressed) then
					if (p_u_16.SecondaryAttackDown or p18.BlockPressed) and (not p_u_16.Meleeing and (not p_u_16.DoCharging and (p18:GetStamina() >= 0.01 and not p_u_16.Config.CantBloc))) and ((p_u_16.BlockDebounce and os.clock() > p_u_16.BlockDebounce or not p_u_16.BlockDebounce) and not (v35 and p_u_16.ParryDebounce)) then
						if p_u_16.Blocking or p18:GetStamina() < (v22.BlockStaminaRequired or 25) then
							if not p_u_16.Blocking and p18:GetStamina() < (v22.BlockStaminaRequired or 25) then
								v_u_11.Elements.StaminaDisplay:FlashRequired(v22.BlockStaminaRequired or 25)
							end
						else
							p18:DrainStamina(v22.BlockStaminaUse or 0)
							local v36 = v_u_12.peek(v_u_13.ParryWindowBonus) or 0
							p_u_16.ParryTime = os.clock() + (v22.ParryWindow or 0) + v36
							p_u_16.Blocking = true
							v_u_8:PlaySound(p_u_16.Config.StartBlockSFX)
						end
						if p_u_16.Blocking then
							p18:DrainStamina(v22.BlockStaminaDrain * v21)
							if p_u_16.Config.UseBlockAnimation then
								p_u_16.Viewmodel:PlayAnimation("Block", 0.1, 1, 1)
							end
							p_u_16.Viewmodel:StopAnimation("HeavySwing")
							p_u_16.Viewmodel:StopAnimation("HeavySwing2")
							p_u_16.Viewmodel:StopAnimation("Swing1")
							p_u_16.Viewmodel:StopAnimation("Swing2")
							if v35 and (p_u_16.ParryTime and os.clock() > p_u_16.ParryTime) then
								if p_u_16.Blocking then
									if not p_u_16.Parried then
										p_u_16.BlockDebounce = os.clock() + (v22.BlockCooldown or 0.75)
									end
									p_u_16.Parried = false
									if v35 then
										p_u_16.ParryDebounce = true
									end
								end
								p_u_16.Blocking = false
								p_u_16.Viewmodel:StopAnimation("Block", p_u_16.Meleeing and 0 or 0.1)
							end
						end
					elseif not v22.ParryOnly or v22.ParryOnly and (not p_u_16.ParryTime or p_u_16.ParryTime and os.clock() > p_u_16.ParryTime) then
						if p_u_16.Blocking then
							if not p_u_16.Parried then
								p_u_16.BlockDebounce = os.clock() + (v22.BlockCooldown or 0.75)
							end
							p_u_16.Parried = false
							if v35 then
								p_u_16.ParryDebounce = true
							end
						end
						p_u_16.Blocking = false
						p_u_16.Viewmodel:StopAnimation("Block", p_u_16.Meleeing and 0 or 0.1)
					end
				elseif v22.ParryOnly and not (p_u_16.Blocking and p_u_16.SecondaryAttackDown) and not p18.BlockPressed then
					p_u_16.ParryDebounce = nil
				end
			end
			if p_u_16.Viewmodel.Animations.Charge and (p_u_16.Viewmodel.Animations.Charge.IsPlaying or p_u_16.Charging and os.clock() >= p_u_16.PrimaryAttackStart + 0.3 or p_u_16.DoCharging and not p_u_16.Charging) then
				if p_u_16.Charging and not p_u_16.DoCharging then
					if p18:GetStamina() >= v22.HeavyStaminaRequired then
						p18:DrainStamina(v22.HeavyStaminaCost, v22.HeavyDelayPerShot)
						p_u_16.DoCharging = true
						p_u_16.Viewmodel:PlayAnimation("Charge")
						if p_u_16.PreviouslyPlayed then
							p_u_16.Viewmodel:StopAnimation(p_u_16.PreviouslyPlayed)
							if p_u_16.PreviouslyPlayed == "Swing1" then
								p_u_16.Viewmodel:PlayAnimation("Charge2")
							end
						end
						if p_u_16.Viewmodel.Animations.ChargeIdle then
							p_u_16.Viewmodel.Animations.ChargeIdle.Looped = true
							p_u_16.Viewmodel.Animations.ChargeIdle.Priority = Enum.AnimationPriority.Action
							p_u_16.Viewmodel:PlayAnimation("ChargeIdle")
							return
						end
					elseif not p_u_16.DoCharging and v22.HeavyStaminaRequired < 100 then
						v_u_11.Elements.StaminaDisplay:FlashRequired(v22.HeavyStaminaRequired)
						return
					end
				else
					if p_u_16.DoCharging and not p_u_16.Charging then
						p_u_16.DoCharging = false
						p_u_16.Viewmodel:StopAnimation("ChargeIdle")
						p_u_16.Viewmodel:StopAnimation("Charge")
						p_u_16.Viewmodel:StopAnimation("Charge2")
						return
					end
					if p_u_16.DoCharging and p_u_16.Charging then
						local v37 = v22.HeavyChargeStaminaDrain * v21
						p18:DrainStamina(v22.OnlyDrainWhileCharging and os.clock() > p_u_16.PrimaryAttackStart + v22.ChargeTime and 0 or v37, 1)
					end
				end
			end
		end
	end,
	["ProcessHit"] = function(p38, p39, p40, p41) -- name: ProcessHit
		-- upvalues: (copy) v_u_62, (copy) v_u_10, (copy) v_u_9, (copy) v_u_5, (copy) v_u_15
		local v42 = p39.Instance
		local v43 = p40.Config
		local v44 = {}
		local v45 = {
			["startPos"] = p38,
			["raycastResult"] = p39,
			["weapon"] = p40,
			["prevHit"] = {},
			["ignoreList"] = {},
			["toNetwork"] = v44
		}
		local v46 = v42:FindFirstAncestorWhichIsA("Model")
		if not p40.HitModels then
			p40.HitModels = {}
		end
		if not p40.HitModels[v46] then
			p40.HitModels[v46] = true
			v_u_62.Hit:Fire(p39, p40.WeaponId)
		end
		local v47 = v_u_10:ProcessHit(p39, v45)
		local v48
		if v47 or not v46 then
			v48 = nil
		else
			v48 = v_u_9:GetObjFromModel(v46)
		end
		if v47 or v48 and v48.ClientShot then
			if p40.TimesHitEnemy.HitTable == nil then
				p40.TimesHitEnemy.HitTable = {}
			end
			local v49 = p40.TimesHitEnemy.HitTable[v46]
			if not p40.TimesHitEnemy.EnemiesHit then
				p40.TimesHitEnemy.EnemiesHit = 0
			end
			if p40.TimesHitEnemy.EnemiesHit < v43.MaxEnemiesPerSwing and (not v49 or v49 and v49 < v43.MaxHitsPerEnemy) then
				if p40.TimesHitEnemy.HitTable[v46] == nil then
					if v43.OnHit then
						v43.OnHit(p40, v46)
					end
					local v50 = p40.TimesHitEnemy
					v50.EnemiesHit = v50.EnemiesHit + 1
					p40.TimesHitEnemy.HitTable[v46] = 1
				else
					local v51 = p40.TimesHitEnemy.HitTable
					v51[v46] = v51[v46] + 1
				end
				local v52 = v47 or v48:ClientShot(v45)
				local v53 = nil
				local v54 = nil
				local v55 = nil
				local v56 = nil
				local v57 = nil
				if v52 then
					if p41 then
						p41.BrickColor = BrickColor.new("Bright green")
					end
					if v52.BloodNPC and v48 then
						local v58 = v_u_5
						local v59 = v52.BloodNPC
						v58:BloodNPC(unpack(v59))
						v53 = true
					end
					v53 = v52.HitFlesh and true or v53
					v54 = v52.HitArmor and true or v54
					v56 = v52.HitHeadshot and true or v56
					v57 = v52.Killed and true or v57
					if v52.BrokeArmor then
						v55 = true
					end
				end
				v_u_10:ProcessNetworkQueue()
				v_u_15:FireServer({ p40.Slot, v44[1], v44[2] })
				if v57 then
					p40.HitEntity:Fire("Kill")
				elseif v56 then
					p40.HitEntity:Fire("Headshot")
				elseif v55 then
					p40.HitEntity:Fire("ArmorBreak", {
						["dontDoSound"] = true
					})
				elseif v54 then
					p40.HitEntity:Fire("HitArmor", {
						["dontDoSound"] = true
					})
				elseif v53 then
					p40.HitEntity:Fire("Flesh")
				end
				p40.lastZombieHit = nil
				return
			end
			if not p40.TimesHitEnemy.IgnoreTable then
				p40.TimesHitEnemy.IgnoreTable = {}
			end
			local v60 = p40.TimesHitEnemy.IgnoreTable
			table.insert(v60, v46)
			if p41 then
				local v61
				if v49 and v49 < v43.MaxHitsPerEnemy then
					v61 = BrickColor.new("Cloudy grey")
				else
					v61 = BrickColor.new("Baby blue")
				end
				p41.BrickColor = v61
				p41.Transparency = 0.75
			end
		end
	end
}
v_u_14:Connect(v_u_62.ProcessHit)
return v_u_62