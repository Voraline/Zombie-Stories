local v1 = game:GetService("RunService")
game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v1:IsClient()
local v_u_4 = v1:IsServer()
local v_u_5 = require(v2.common.ZS_Shared.Data.GameState)
local v_u_6 = require(v2.common.NPCs_Shared.Utils.DamageFalloffUtil)
local v_u_7
if v_u_4 then
	v_u_7 = require(v2.common.skillTree.SkillTreeData)
else
	v_u_7 = nil
end
local v_u_8 = {}
local function v_u_14(p9) -- name: isPlayerStationary
	-- upvalues: (copy) v_u_8
	if not (p9 and p9.Character) then
		return false
	end
	local v10 = p9.Character:FindFirstChild("HumanoidRootPart")
	if not v10 then
		return false
	end
	local v11 = v10.Position
	local v12 = os.clock()
	local v13 = v_u_8[p9]
	if not v13 then
		v_u_8[p9] = {
			["LastPosition"] = v11,
			["StationaryStartTime"] = v12
		}
		return false
	end
	if (v11 - v13.LastPosition).Magnitude <= 0.5 then
		return v12 - v13.StationaryStartTime >= 1
	end
	v13.LastPosition = v11
	v13.StationaryStartTime = v12
	return false
end
local v_u_15 = {}
return function(p16, p17, p18, p19)
	-- upvalues: (copy) v_u_5, (copy) v_u_15, (copy) v_u_6, (copy) v_u_3, (copy) v_u_4, (ref) v_u_7, (copy) v_u_14
	if not (p16._Destroyed or table.isfrozen(p16)) then
		local v20 = p17.startPos
		local v21 = p17.raycastResult
		local v22 = p17.weapon
		local v23 = p17.prevHit
		local v24 = p17.ignoreList or {}
		local v25 = p17.toNetwork or {}
		local v26 = p17.roundedDistance
		if v26 then
			local v27 = p17.roundedDistance
			v26 = tonumber(v27)
		end
		local v28 = p17.shooter
		local v29 = nil
		local v30 = nil
		if p18 then
			if not (p16.Model and p16.Model.Parent) then
				return
			end
			if p16.ArmorHPs and p16.ArmorHPs[p18] then
				v29 = p16.Model[p16.ArmorHPs[p18][2]]
				v30 = true
			elseif p16.UIDTable and p16.UIDTable[p18] then
				v29 = p16.UIDTable[p18]
			end
		else
			v29 = v21.Instance
			p18 = v29:GetAttribute("uid")
		end
		if v29 and p18 then
			local v31 = false
			local v32 = v22.Config
			local v33 = {}
			local v34 = 1
			if v_u_5.Data.Variables.HeadshotOnly then
				local v35 = p16.Model.Name
				if not v_u_15[v35] then
					v_u_15[v35] = {
						["HasHead"] = p16.Model:FindFirstChild("Head")
					}
				end
				v34 = v_u_15[v35].HasHead and 0 or v34
			end
			local v36 = 1
			local v37 = v32.Multipliers
			if v37 and not v30 then
				if string.find(v29.Name, "Arm") or (string.find(v29.Name, "Torso") or string.find(v29.Name, "Leg")) then
					v36 = v34
				elseif string.find(v29.Name, "Head") then
					v36 = v37.Head or 1
					v33.HitHeadshot = true
				end
			end
			local v38
			if v32.DamageDropoff then
				local v39 = v26 or (v20 - v29.Position).Magnitude
				v38 = v_u_6.CalculateDamageAtDistance(v32, v39)
			else
				v38 = v32.Damage
			end
			local v40 = v38 * v36
			local v41 = p16.Resistances
			if v32.DamageCalculation then
				v40 = v32.DamageCalculation(v22, v40, p16, v36) or v40
			end
			if v41 then
				if v32.IsMelee and v41.Melee then
					v40 = v40 * v41.Melee
					if p19 then
						p19 = p19 * v41.Melee
					end
				elseif not v32.IsMelee and v41.Bullet then
					v40 = v40 * v41.Bullet
					if p19 then
						p19 = p19 * v41.Bullet
					end
				end
			end
			local v42 = v32.PenetrationReduction or 0.5
			local v43 = #v23
			if v43 >= 1 then
				v40 = v40 * (1 * v42 ^ v43)
			end
			local v44 = (v32.Penetration or 0) - v43
			local v45 = p16.UID
			if v22.lastZombieHit ~= v45 then
				v22.lastZombieHit = v45
				table.insert(v25, v45)
			end
			if p16.ArmorHPs and p16.ArmorHPs[p18] then
				local v46 = p16.ArmorHPs.HPDir[p16.ArmorHPs[p18][1]]
				local _ = v46.Lvl
				local v47 = v46.HP
				if p16.ArmorShot then
					p16:ArmorShot(p17)
				end
				v31 = true
				local v48 = v46.Lvl
				local _ = v46.HP
				local v49 = v32.UsesHP and 0.25 or (v32.ArmorDamageReduction or 0.5)
				local v50 = v48 - v44
				local v51 = v49 ^ math.max(v50, 1)
				local v52
				if v32.DamageDropoff then
					local v53 = v26 or (v20 - v29.Position).Magnitude
					v52 = v_u_6.CalculateDamageAtDistance(v32, v53)
				else
					v52 = v32.Damage
				end
				local v54 = v52 * v51
				local v55 = p16.ArmorResistances
				if v55 then
					if v32.IsMelee and v55.Melee then
						v54 = v54 * v55.Melee
					elseif not v32.IsMelee and v55.Bullet then
						v54 = v54 * v55.Bullet
					end
				end
				local _ = v40 - v54
				local v56 = v47 - v54
				local v57 = math.max(0, v56)
				v46.HP = v57
				if v57 <= 0 then
					if p16.ArmorBroken then
						p16:ArmorBroken(v29.Parent)
						v33.BrokeArmor = true
					end
					for _, v58 in v29.Parent:GetChildren() do
						if v58:IsA("BasePart") then
							v58.CanQuery = false
						end
					end
				end
				v33.HitArmor = true
				if v_u_3 then
					v40 = v40 + 0.01
				end
				local v59 = string.format("%.2f", v40)
				if v_u_3 then
					local v60 = "h" .. p18 .. "_" .. v59
					table.insert(v25, v60)
				end
			elseif p16.UIDTable and p16.UIDTable[p18] then
				if p16.FleshShot then
					p16:FleshShot(p17, v40)
				end
				v31 = true
				if v_u_4 then
					local v61 = p19 or v40
					if v40 < v61 then
						if v40 * 1.25 >= v61 then
							v40 = v61
						end
					end
					if v28 and v_u_7 then
						local v62 = require("@game/ReplicatedStorage/common/PlayerHandler"):GetPlayerState(v28)
						if v33.HitHeadshot then
							v40 = v40 * v_u_7.getHeadshotDamageMult(v28)
						end
						if v_u_7.hasFury(v28) and (v62 and v62.HP / v62.MaxHP <= 0.25) then
							v40 = v40 * 1.25
						end
						if v_u_7.hasDeadEye(v28) and v_u_14(v28) then
							v40 = v40 * 1.1
						end
						if v62 and v62.IsDowned then
							v62:AddSecondWindDamage(v40)
						end
					end
					local v63 = v61 * 0.03
					local v64 = math.max(0.5, v63)
					if v28 and p16.ReconcileDamage then
						local v65 = v40 - v61
						if v64 < math.abs(v65) then
							p16.ReconcileDamage(v28, v40, p18)
						end
					end
					p16:ChangeHealth(-v40)
				else
					p16:ClientChangeHealth(-v40)
				end
				if v_u_3 then
					v40 = v40 + 0.01
				end
				local v66 = string.format("%.2f", v40)
				if p16.HP <= 0 then
					local v67 = "k" .. p18 .. "_" .. v66
					table.insert(v25, v67)
					v33.Killed = true
				else
					local v68 = "h" .. p18 .. "_" .. v66
					table.insert(v25, v68)
				end
				v33.BloodNPC = { v32, p16.UID, p18 }
			end
			if v31 then
				local v69 = v29.Parent
				table.insert(v23, v69)
				local v70 = v29.Parent
				table.insert(v24, v70)
				if v_u_3 and (not v32.IsMelee and v32.OnHit) then
					v32.OnHit(v22, p16.Model)
				end
			end
			if p16.Shot then
				p16:Shot(p17)
			end
			p16.Model:SetAttribute("HP", p16.HP)
			return v33
		end
	end
end