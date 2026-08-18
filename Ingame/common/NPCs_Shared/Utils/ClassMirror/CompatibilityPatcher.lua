local v_u_1 = game:GetService("CollectionService")
local v_u_2 = game:GetService("RunService")
game:GetService("ServerStorage")
local v3 = game.ReplicatedStorage.common:WaitForChild("NPCs_Shared")
local v_u_4 = require("@game/ReplicatedStorage/common/Signal")
local v_u_5 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/UIDManager")
local v_u_6 = require("@game/ReplicatedStorage/common/NPCRegistry")
local v_u_7 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/DamageHelper_Util")
local v_u_8 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/Hitreg_Util")
local v_u_9 = game:GetService("RunService"):IsServer()
local v_u_10 = require("@game/ReplicatedStorage/common/RedEvents/NPC/CompatEvent")
local v_u_11 = nil
local v_u_12 = require(game.ReplicatedStorage.common:WaitForChild("ItemData"))
local v_u_13 = require(v3.Utils.StatusEffect_Util)
local v_u_14 = {}
local v_u_71 = {
	["AddedNPC"] = v_u_4.new(),
	["MirrorEvent"] = v_u_10,
	["Create"] = function(_, p_u_15, p16, p17, p18) -- name: Create
		-- upvalues: (copy) v_u_4, (copy) v_u_9, (copy) v_u_5, (copy) v_u_2, (copy) v_u_13, (ref) v_u_11, (copy) v_u_10, (copy) v_u_7, (copy) v_u_14, (copy) v_u_71, (copy) v_u_1, (copy) v_u_8, (copy) v_u_12
		local v_u_19 = {
			["DontKill"] = false,
			["IsCompat"] = true,
			["Died"] = v_u_4.new()
		}
		if v_u_9 then
			p18 = v_u_5:GetUID() or p18
		end
		v_u_19.UID = p18
		v_u_19.Name = p16
		v_u_19.Model = p_u_15
		v_u_19.MaxHP = p17
		v_u_19.HP = p17
		v_u_19.PlayerHurtNPC = v_u_4.new()
		v_u_19.Destroyed = v_u_4.new()
		v_u_19.HealthChanged = v_u_4.new()
		v_u_19.MovementStateChanged = v_u_4.new()
		v_u_19.StatusUpdated = v_u_4.new()
		v_u_19.EffectLoop = v_u_2.Heartbeat:Connect(function(p20)
			-- upvalues: (ref) v_u_19
			if v_u_19 and v_u_19.CurrentEffects then
				for _, v21 in v_u_19.CurrentEffects do
					if v21.update then
						v21.update(p20)
					end
				end
			end
		end)
		function v_u_19.ApplyEffect(p22, ...)
			-- upvalues: (ref) v_u_13, (ref) v_u_9, (ref) v_u_11, (ref) v_u_10, (ref) v_u_19
			v_u_13.ApplyEffect(p22, ...)
			if v_u_9 then
				if not v_u_11 then
					v_u_11 = require("@game/ServerStorage/common/WepHandler")
				end
				v_u_10:FireAllClients({
					["Type"] = "ApplyEffect",
					["UID"] = nil,
					["args"] = nil,
					["UID"] = v_u_19.UID,
					["args"] = { ... }
				})
			end
		end
		function v_u_19.RemoveEffect(p23, ...)
			-- upvalues: (ref) v_u_13, (ref) v_u_9, (ref) v_u_10, (ref) v_u_19
			v_u_13.RemoveEffect(p23, ...)
			if v_u_9 then
				v_u_10:FireAllClients({
					["Type"] = "RemoveEffect",
					["UID"] = nil,
					["args"] = nil,
					["UID"] = v_u_19.UID,
					["args"] = { ... }
				})
			end
		end
		function v_u_19.SetKillable(p24, p25) -- name: SetKillable
			-- upvalues: (ref) v_u_9, (ref) v_u_10, (ref) v_u_19
			p24.DontKill = not p25 and true or nil
			if v_u_9 then
				v_u_10:FireAllClients({
					["Type"] = "Killable",
					["UID"] = nil,
					["isKillable"] = nil,
					["UID"] = v_u_19.UID,
					["isKillable"] = p25
				})
			end
		end
		if v_u_9 then
			v_u_19.UIDTable = v_u_7:GenUIDTable(p_u_15)
			p_u_15:AddTag("PatchNPC")
			p_u_15:SetAttribute("PatchUID", v_u_19.UID)
			p_u_15:SetAttribute("NPCName", p16)
			p_u_15.ChildAdded:Connect(function(p_u_26)
				-- upvalues: (ref) v_u_19, (copy) p_u_15
				if v_u_19 then
					if p_u_26:IsA("ForceField") then
						v_u_19.Immune = true
						local v_u_27 = nil
						v_u_27 = p_u_26.Destroying:Once(function()
							-- upvalues: (ref) v_u_19, (ref) v_u_27
							if v_u_19 then
								v_u_19.Immune = nil
								v_u_27 = nil
							end
						end)
						p_u_26.AncestryChanged:Connect(function(p28, p29)
							-- upvalues: (ref) v_u_19, (copy) p_u_26, (ref) p_u_15, (ref) v_u_27
							if v_u_19 then
								if p28 == p_u_26 and p29 ~= p_u_15 then
									v_u_19.Immune = nil
									if v_u_27 then
										v_u_27:Disconnect()
										v_u_27 = nil
									end
								end
							end
						end)
					end
				end
			end)
			p_u_15.AncestryChanged:Connect(function(_, p30)
				-- upvalues: (ref) v_u_14, (ref) v_u_19
				if p30 == nil then
					v_u_14[v_u_19] = nil
					v_u_19.Destroyed:Fire()
					v_u_19.Died:Fire()
					v_u_19 = nil
				end
			end)
			v_u_10:FireAllClients({
				["Type"] = "Add",
				["Name"] = nil,
				["HP"] = nil,
				["UID"] = nil,
				["Name"] = p16,
				["HP"] = p17,
				["UID"] = v_u_19.UID
			})
			v_u_14[v_u_19] = v_u_14
			v_u_71.AddedNPC:Fire(v_u_19)
			function v_u_19.DealDamage(p31, p32, p33, p34) -- name: DealDamage
				-- upvalues: (ref) v_u_11
				if not (p31._Destroyed or (p31.IsDead or p31.Immune)) then
					local v35 = p31.HP
					p31:ChangeHealth(-p33)
					local v36 = v35 - p31.HP
					v_u_11:CreditDamage(p32, p31, math.max(0, v36), p34)
					if p31.HP <= 0 then
						p31:Kill(p32)
					end
				end
			end
		else
			local function v_u_44(p_u_37) -- name: checkModel
				-- upvalues: (ref) v_u_19, (ref) v_u_7, (ref) v_u_10, (ref) v_u_14, (ref) v_u_71
				if p_u_37:GetAttribute("PatchUID") ~= v_u_19.UID then
					return false
				end
				v_u_19.Model = p_u_37
				v_u_19.UIDTable = v_u_7:GenUIDTable(p_u_37)
				p_u_37.DescendantAdded:Connect(function(p38)
					-- upvalues: (ref) v_u_19
					if p38:IsA("BasePart") and p38:GetAttribute("uid") then
						v_u_19.UIDTable[p38:GetAttribute("uid")] = p38
					end
				end)
				p_u_37.ChildAdded:Connect(function(p_u_39)
					-- upvalues: (ref) v_u_19, (ref) v_u_10, (copy) p_u_37
					if p_u_39:IsA("ForceField") then
						v_u_19.Immune = true
						local v_u_40 = nil
						v_u_40 = p_u_39.Destroying:Once(function()
							-- upvalues: (ref) v_u_10, (ref) v_u_40
							v_u_10.Immune = nil
							v_u_40 = nil
						end)
						p_u_39.AncestryChanged:Connect(function(p41, p42)
							-- upvalues: (copy) p_u_39, (ref) p_u_37, (ref) v_u_19, (ref) v_u_40
							if p41 == p_u_39 and p42 ~= p_u_37 then
								v_u_19.Immune = nil
								if v_u_40 then
									v_u_40:Disconnect()
									v_u_40 = nil
								end
							end
						end)
					end
				end)
				p_u_37.AncestryChanged:Connect(function(_, p43)
					-- upvalues: (ref) v_u_14, (ref) v_u_19
					if p43 == nil then
						v_u_14[v_u_19] = nil
						v_u_19.Destroyed:Fire()
						v_u_19.Died:Fire()
						v_u_19 = nil
					end
				end)
				v_u_71.AddedNPC:Fire(v_u_19)
				return true
			end
			local v45 = false
			for _, v46 in v_u_1:GetTagged("PatchNPC") do
				if v_u_44(v46) then
					v45 = true
					break
				end
			end
			if not v45 then
				local v_u_47 = nil
				v_u_47 = v_u_1:GetInstanceAddedSignal("PatchNPC"):Connect(function(p48)
					-- upvalues: (copy) v_u_44, (ref) v_u_47
					if v_u_44(p48) then
						v_u_47:Disconnect()
					end
				end)
			end
		end
		function v_u_19.Kill(p49, p50, p51) -- name: Kill
			if not (p49.IsDead or p49.DontKill) then
				p49.IsDead = true
				p49.Died:Fire(p50, p51)
				if p49.EffectLoop then
					p49.EffectLoop:Disconnect()
				end
			end
		end
		function v_u_19.ClientShot(p52, p53) -- name: ClientShot
			-- upvalues: (ref) v_u_8
			if not p52.Immune then
				return v_u_8(p52, p53)
			end
		end
		function v_u_19.ChangeHealth(p54, p55) -- name: ChangeHealth
			-- upvalues: (ref) v_u_10, (ref) v_u_19
			local v56 = p54.HP
			local v57 = p54.HP + p55
			local v58 = p54.DontKill and 1 or 0
			p54.HP = math.max(v57, v58)
			print("Damage Dealt", p55, "NewHP", p54.HP)
			if p54.HP ~= v56 then
				p54.HealthChanged:Fire(p54.HP)
			end
			v_u_10:FireAllClients({
				["Type"] = "UpdateHealth",
				["UID"] = nil,
				["HP"] = nil,
				["UID"] = v_u_19.UID,
				["HP"] = v_u_19.HP
			})
		end
		function v_u_19.ClientChangeHealth(_) -- name: ClientChangeHealth end
		function v_u_19.Hit(p59, p60, p61, p62, p63, p64) -- name: Hit
			-- upvalues: (ref) v_u_8, (ref) v_u_12, (ref) v_u_19
			if not (p59._Destroyed or (p59.IsDead or p59.Immune)) then
				local v65 = p59.HP
				local v66 = {
					["startPos"] = p60,
					["weapon"] = {
						["Config"] = p62
					},
					["prevHit"] = p63,
					["shooter"] = p64
				}
				local v67 = v_u_8(p59, v66, p61)
				if not (p59._Destroyed or p59.IsDead) then
					p59.LastShotBy = p64
					if p59.HP <= 0 then
						p59:Kill(p64, v67.HitHeadshot)
					elseif p62.OnHitEffect then
						local v68 = table.clone(p62.OnHitEffect)
						v68.Owner = p64
						v68.wepID = v_u_12:GetItemIdFromName(p62.WeaponName)
						p59:ApplyEffect(v68.Effect, v68)
					end
					v_u_19.PlayerHurtNPC:Fire(p59.HP, v65 - p59.HP, v65, p64, v67)
					return v65 - p59.HP, v67
				end
			end
		end
		local v69 = v_u_14
		local v70 = v_u_19
		table.insert(v69, v70)
		return v_u_19
	end
}
if v_u_9 then
	game.Players.PlayerAdded:Connect(function(p72)
		-- upvalues: (copy) v_u_14, (copy) v_u_10
		for v73, v74 in v_u_14 do
			v74.HP = v73.HP
			v_u_10:FireClient(p72, v74)
		end
	end)
else
	v_u_10:SetClientListener(function(p75)
		-- upvalues: (copy) v_u_71, (copy) v_u_6
		if p75 then
			if p75.Type == "Add" then
				v_u_71:Create(nil, p75.Name, p75.HP, p75.UID)
				return
			end
			if p75.Type == "UpdateHealth" then
				local v76 = v_u_6:GetNPC(p75.UID)
				if v76 then
					v76.HP = p75.HP
					v76.HealthChanged:Fire(p75.HP)
					return
				end
			elseif p75.Type == "ChangeMovementState" then
				local v77 = v_u_6:GetNPC(p75.UID)
				if v77 then
					v77.MovementStateChanged:Fire(p75.StateKey, p75.Value)
					return
				end
			elseif p75.Type == "Killable" then
				local v78 = v_u_6:GetNPC(p75.UID)
				if v78 then
					v78:SetKillable(p75.isKillable)
					return
				end
			elseif p75.Type == "ApplyEffect" or p75.Type == "RemoveEffect" then
				local v79 = p75.args
				local v80 = v_u_6:GetNPC(p75.UID)
				if v80 then
					v80[p75.Type](v80, table.unpack(v79))
				end
			end
		end
	end)
end
return v_u_71