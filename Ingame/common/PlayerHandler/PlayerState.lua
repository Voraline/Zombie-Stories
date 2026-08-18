local v1 = game.ReplicatedStorage.common
local v2 = game.ReplicatedStorage.common.RedEvents
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = require(v1.TableKit)
local v_u_5 = require(v1.Signal)
local v_u_6 = require("./StatusEffects")
local v_u_7 = require(v2.Framework.StatusEffectsEvent)
local v_u_8
if game:GetService("RunService"):IsServer() then
	v_u_8 = require(v3.common.skillTree.SkillTreeData)
else
	v_u_8 = nil
end
local v_u_9 = true
local v_u_10 = game:GetService("RunService"):IsServer()
local v_u_11 = require(v3.common.ZS_Shared.Data.GameState)
local v_u_12 = workspace.Values.IsLobby.Value
local v_u_13 = require(v2.Framework.PlayerStateEvent)
local v_u_14 = {}
local v_u_15 = {
	["Sprinting"] = false,
	["Crouching"] = false,
	["Proning"] = false,
	["Sliding"] = false,
	["Jogging"] = false,
	["Diving"] = false,
	["Aiming"] = false,
	["Equipped"] = false,
	["WepId"] = false,
	["SecondaryEquipped"] = false,
	["SecondaryWepId"] = false,
	["QuickSwapActive"] = false,
	["DualWieldActive"] = false,
	["OffHandActive"] = false,
	["OffHandEquipped"] = false,
	["OffHandWepId"] = false,
	["LastHit"] = os.clock(),
	["PreviousDamage"] = 0,
	["ImmunityTime"] = 0.05,
	["HP"] = 100,
	["MaxHP"] = 100,
	["GodMode"] = false,
	["IsDead"] = false,
	["IsDowned"] = false,
	["InSwanSong"] = false,
	["SwanSongEndTime"] = 0,
	["SwanSongUsed"] = false,
	["SpartanShield"] = 0,
	["SpartanShieldMax"] = 0,
	["SpartanShieldRegenDelay"] = 5,
	["SpartanLastHitTime"] = 0,
	["SecondWindDamage"] = 0,
	["SecondWindMaxDamage"] = 500,
	["SecondWindUsed"] = false,
	["IsFocused"] = false,
	["InstantKill"] = false,
	["BeingRevived"] = false,
	["Blocking"] = false,
	["Charging"] = false,
	["EquippedGun"] = false,
	["BlockingStart"] = os.clock()
}
local v_u_16 = {
	["Sprinting"] = "boolean",
	["Crouching"] = "boolean",
	["Proning"] = "boolean",
	["Sliding"] = "boolean",
	["Jogging"] = "boolean",
	["Diving"] = "boolean",
	["Aiming"] = "boolean",
	["Charging"] = "boolean",
	["Blocking"] = "boolean",
	["QuickSwapActive"] = "boolean",
	["DualWieldActive"] = "boolean",
	["SecondaryEquipped"] = "string_or_false",
	["SecondaryWepId"] = "string_or_false",
	["OffHandActive"] = "boolean",
	["OffHandEquipped"] = "string_or_false",
	["OffHandWepId"] = "string_or_false"
}
local v_u_99 = {
	["StateAdded"] = v_u_5.new(),
	["__index"] = function(p17, p18) -- name: __index
		-- upvalues: (copy) v_u_15, (copy) v_u_99
		local v19 = rawget(p17, p18)
		if v_u_15[p18] ~= nil then
			return rawget(p17, "Properties")[p18]
		end
		if v19 ~= nil then
			return v19
		end
		if v_u_99[p18] then
			return v_u_99[p18]
		end
		error(("%q is not a valid member of playerState"):format((tostring(p18))), 2)
	end,
	["__newindex"] = function(p20, p21, p22) -- name: __newindex
		-- upvalues: (copy) v_u_15, (copy) v_u_10, (copy) v_u_99
		local v23 = rawget(p20, p21)
		if v_u_15[p21] == nil then
			if v23 == nil then
				v_u_99[p21] = p22
				return p20
			else
				p20[p21] = p22
				return p20
			end
		else
			p20:_SetProperty(p21, p22, not v_u_10)
			return p20
		end
	end,
	["new"] = function(p24, p25) -- name: new
		-- upvalues: (copy) v_u_14, (copy) v_u_4, (copy) v_u_15, (copy) v_u_6, (copy) v_u_99, (copy) v_u_5, (copy) v_u_10, (copy) v_u_13
		if v_u_14[p24] then
			return v_u_14[p24]
		end
		local v26 = p24 ~= nil
		assert(v26, "PlayerState requires player parameter")
		local v_u_27 = {
			["Player"] = p24,
			["Properties"] = p25 or v_u_4.DeepCopy(v_u_15),
			["_Events"] = {},
			["StatusEffects"] = v_u_6.new(p24)
		}
		local v28 = v_u_99
		setmetatable(v_u_27, v28)
		rawset(v_u_27, "HPChanged", v_u_27:GetPropertyChangedSignal("HP"))
		rawset(v_u_27, "HealthChanged", v_u_27:GetPropertyChangedSignal("HP"))
		local v29 = v_u_5.new
		rawset(v_u_27, "Died", v29())
		local v30 = v_u_5.new
		rawset(v_u_27, "Downed", v30())
		local v31 = v_u_5.new
		rawset(v_u_27, "Damaged", v31())
		v_u_27:GetPropertyChangedSignal("IsDead"):Connect(function(p32)
			-- upvalues: (copy) v_u_27
			if p32 then
				v_u_27.Died:Fire()
			end
		end)
		v_u_27:GetPropertyChangedSignal("IsDowned"):Connect(function(p33)
			-- upvalues: (copy) v_u_27
			if p33 then
				v_u_27.Downed:Fire()
			end
		end)
		if v_u_10 then
			v_u_13:FireAllClientsExcept(p24, createAddPacket(v_u_27))
		end
		v_u_14[p24] = v_u_27
		v_u_99.StateAdded:Fire(v_u_27)
		v_u_6.StateAdded:Fire(v_u_27)
		return v_u_27
	end,
	["CopyState"] = function(p34, p35) -- name: CopyState
		-- upvalues: (copy) v_u_15
		for v36 in v_u_15 do
			if v36 ~= "StatusEffects" then
				p34[v36] = p35.Properties[v36]
			end
		end
		p34.StatusEffects:CopyEffects(p35.StatusEffects)
	end,
	["SetPeerReplicationEnabled"] = function(p37) -- name: SetPeerReplicationEnabled
		-- upvalues: (ref) v_u_9
		v_u_9 = p37
	end,
	["ApplyStatus"] = function(p38, p39, ...) -- name: ApplyStatus
		-- upvalues: (copy) v_u_10
		if v_u_10 then
			p38.StatusEffects:Apply(p39, ...)
		end
	end,
	["Heal"] = function(p40, p41) -- name: Heal
		-- upvalues: (copy) v_u_10
		if v_u_10 then
			local v42 = p40.HP + p41
			local v43 = p40.MaxHP
			p40.HP = math.clamp(v42, 0, v43)
		end
	end,
	["RefreshMaxHP"] = function(p44) -- name: RefreshMaxHP
		-- upvalues: (copy) v_u_10, (ref) v_u_8
		if v_u_10 and v_u_8 then
			local v45 = 100 * v_u_8.getMaxHPMult(p44.Player)
			local v46 = math.floor(v45)
			local v47 = p44.MaxHP
			if v46 ~= v47 then
				local v48 = v47 <= p44.HP
				p44.MaxHP = v46
				if v48 then
					p44.HP = v46
				end
				local v49 = p44.Player.Character
				if v49 then
					local v50 = v49:FindFirstChild("MaxHP")
					local v51 = v49:FindFirstChild("HP")
					if v50 and v50:IsA("NumberValue") then
						v50.Value = v46
					end
					if v51 and v51:IsA("NumberValue") then
						v51.Value = p44.HP
					end
				end
				if _G.plrDictionary and _G.plrDictionary[p44.Player] then
					local v52 = _G.plrDictionary[p44.Player]
					if v52.MaxHealth then
						v52.MaxHealth.Value = v46
					end
					if v52.Health then
						v52.Health.Value = p44.HP
					end
				end
				p44.Player:SetAttribute("Skill_MaxHP", v46)
				p44.Player:SetAttribute("Skill_CurrentHP", p44.HP)
				print((("[PlayerState] %* MaxHP updated: %* -> %*"):format(p44.Player.Name, v47, v46)))
			end
		end
	end,
	["RefreshSpartanShield"] = function(p53) -- name: RefreshSpartanShield
		-- upvalues: (copy) v_u_10, (ref) v_u_8
		if v_u_10 and v_u_8 then
			if v_u_8.hasTheSpartan(p53.Player) then
				p53.SpartanShieldMax = 50
				p53.SpartanShield = 50
				p53.SpartanLastHitTime = 0
				print((("[PlayerState] %* Spartan Shield initialized: %*"):format(p53.Player.Name, 50)))
			else
				p53.SpartanShieldMax = 0
				p53.SpartanShield = 0
			end
		else
			return
		end
	end,
	["ResetSecondWind"] = function(p54) -- name: ResetSecondWind
		-- upvalues: (copy) v_u_10
		if v_u_10 then
			p54.SecondWindDamage = 0
		end
	end,
	["AddSecondWindDamage"] = function(p_u_55, p56) -- name: AddSecondWindDamage
		-- upvalues: (copy) v_u_10, (ref) v_u_8
		if not (v_u_10 and v_u_8) then
			return false
		end
		if not p_u_55.IsDowned then
			return false
		end
		if not v_u_8.hasSecondWind(p_u_55.Player) then
			return false
		end
		if p_u_55.SecondWindUsed then
			return false
		end
		p_u_55.SecondWindDamage = p_u_55.SecondWindDamage + p56
		if p_u_55.SecondWindDamage < p_u_55.SecondWindMaxDamage then
			return false
		end
		p_u_55.SecondWindDamage = 0
		p_u_55.IsDowned = false
		local v57 = p_u_55.MaxHP * 0.25
		p_u_55.HP = math.floor(v57)
		p_u_55.SecondWindUsed = true
		p_u_55.GodMode = true
		task.delay(3, function()
			-- upvalues: (copy) p_u_55
			if p_u_55.HP > 0 and not p_u_55.IsDead then
				p_u_55.GodMode = false
			end
		end)
		local v58 = p_u_55.Player.Character
		if v58 then
			local v59 = Instance.new("ForceField")
			v59.Parent = v58
			game:GetService("Debris"):AddItem(v59, 3)
		end
		print((("[PlayerState] %* triggered Second Wind self-revive!"):format(p_u_55.Player.Name)))
		return true
	end,
	["UpdateSpartanShield"] = function(p60, p61) -- name: UpdateSpartanShield
		-- upvalues: (copy) v_u_10, (copy) v_u_13
		if v_u_10 then
			if p60.SpartanShieldMax <= 0 then
				return
			elseif p60.SpartanShield >= p60.SpartanShieldMax then
				return
			elseif not (p60.IsDowned or p60.IsDead) then
				if os.clock() - p60.SpartanLastHitTime >= p60.SpartanShieldRegenDelay then
					local v62 = p60.SpartanShieldMax / 3
					local v63 = p60.SpartanShield
					local v64 = p60.SpartanShield + v62 * p61
					local v65 = p60.SpartanShieldMax
					p60.SpartanShield = math.min(v64, v65)
					if v63 == 0 and p60.SpartanShield > 0 then
						v_u_13:FireAllClients({
							["Type"] = "ShieldRegenStart",
							["Player"] = nil,
							["Player"] = p60.Player
						})
					end
				end
			end
		else
			return
		end
	end,
	["Damage"] = function(p66, p67, p68, p69, p70) -- name: Damage
		-- upvalues: (copy) v_u_10, (copy) v_u_11, (ref) v_u_8, (copy) v_u_13
		if v_u_10 then
			if p66.HP <= 0 or p66.GodMode then
				return
			end
			if p69 then
				p66.InstantKill = true
			end
			if os.clock() < p66.LastHit and p67 <= p66.PreviousDamage then
				return
			end
			local v71 = p66.ImmunityTime
			local v72 = v_u_11.Data.Variables.PlayerDamageTaken
			local _ = v71 * math.min(4, v72)
			p66.LastHit = os.clock() + p66.ImmunityTime
			p66.PreviousDamage = p67
			local v73 = p67 * (p70 and 1 or v_u_11.Data.Variables.PlayerDamageTaken)
			if not p69 and (not p70 and v_u_8) then
				v73 = v73 * v_u_8.getDamageReductionMult(p66.Player)
			end
			if v73 ~= v73 then
				print("NaN HP detected!")
				v73 = 0
			end
			local v74 = 0
			if not p69 and p66.SpartanShieldMax > 0 then
				p66.SpartanLastHitTime = os.clock()
				if p66.SpartanShield > 0 then
					local v75 = p66.SpartanShield
					v74 = math.min(v75, v73)
					p66.SpartanShield = p66.SpartanShield - v74
					v73 = v73 - v74
				end
			end
			local v76 = p66.HP - v73
			local v77 = p66.MaxHP
			p66.HP = math.clamp(v76, 0, v77)
			p66.Damaged:Fire(p66.HP, v73, p68, v74)
			v_u_13:FireAllClients({
				["Type"] = "Damaged",
				["Player"] = nil,
				["Data"] = nil,
				["Player"] = p66.Player,
				["Data"] = {
					p66.HP,
					v73,
					p68,
					v74,
					p66.SpartanShield
				}
			})
		end
	end,
	["GetPropertyChangedSignal"] = function(p78, p79) -- name: GetPropertyChangedSignal
		-- upvalues: (copy) v_u_15, (copy) v_u_5
		local v80 = v_u_15[p79] ~= nil
		assert(v80, ("PlayerState has no property \'%s\'"):format(p79))
		if not p78._Events[p79] then
			p78._Events[p79] = v_u_5.new()
		end
		return p78._Events[p79]
	end,
	["GetStatusChangedSignal"] = function(p81, p82) -- name: GetStatusChangedSignal
		return p81.StatusEffects:GetPropertyChangedSignal(p82)
	end,
	["Destroy"] = function(p83) -- name: Destroy
		-- upvalues: (copy) v_u_14
		v_u_14[p83.Player] = nil
		rawset(p83, "_Destroyed", true)
		p83.Died:DisconnectAll()
		p83.Downed:DisconnectAll()
		p83.Damaged:DisconnectAll()
		for _, v84 in p83._Events do
			v84:DisconnectAll()
		end
		p83.StatusEffects:Destroy()
	end,
	["_SetProperty"] = function(p_u_85, p86, p87, p88, p89) -- name: _SetProperty
		-- upvalues: (copy) v_u_15, (copy) v_u_10, (copy) v_u_12, (ref) v_u_8, (ref) v_u_9, (copy) v_u_13, (copy) v_u_16
		if v_u_15[p86] ~= nil then
			local v90 = p86 ~= "StatusEffects"
			assert(v90, "Can\'t set StatusEffects property, please modify the StatusEffects object instead")
			local v91 = p_u_85.Properties[p86]
			if v91 == p87 then
				return
			end
			p_u_85.Properties[p86] = p87
			local v92 = p_u_85._Events[p86]
			if v92 then
				v92:Fire(p87, v91)
			end
			if v_u_10 then
				if p86 == "Blocking" then
					local v93
					if p87 then
						v93 = os.clock()
					else
						v93 = false
					end
					p_u_85.BlockingStart = v93
				elseif p86 == "HP" and p_u_85.HP == 0 then
					if v_u_12 and not p_u_85.InstantKill then
						if not rawget(p_u_85, "Revival") then
							rawset(p_u_85, "Revival", true)
							task.spawn(function()
								-- upvalues: (copy) p_u_85
								task.wait(1)
								repeat
									task.wait()
									p_u_85.HP = p_u_85.HP + 1
								until p_u_85.HP >= (p_u_85.MaxHP or 100)
								p_u_85.HP = p_u_85.MaxHP
								local v94 = p_u_85
								rawset(v94, "Revival", nil)
							end)
						end
					else
						local v95 = p_u_85.StatusEffects.Downed
						if p_u_85.InstantKill or v95 and (v95._RevivesLeft and v95._RevivesLeft <= 0) then
							p_u_85.IsDead = true
							p_u_85.InstantKill = false
							if v95 then
								v95:InitalizeRevives()
							end
						else
							local v96 = v_u_8
							if v96 then
								v96 = v_u_8.hasSwanSong(p_u_85.Player)
							end
							if v96 and not (p_u_85.InSwanSong or p_u_85.SwanSongUsed) then
								p_u_85.InSwanSong = true
								p_u_85.SwanSongUsed = true
								p_u_85.SwanSongEndTime = workspace:GetServerTimeNow() + 4
								p_u_85.HP = 1
								task.spawn(function()
									-- upvalues: (copy) p_u_85
									task.wait(4)
									if p_u_85.InSwanSong then
										local v97 = p_u_85
										if not rawget(v97, "_Destroyed") then
											p_u_85.InSwanSong = false
											p_u_85.SwanSongEndTime = 0
											p_u_85.HP = 0
										end
									end
								end)
							elseif p_u_85.InSwanSong then
								p_u_85.HP = 1
							else
								p_u_85:ApplyStatus("Downed", 30 * (v_u_8 and (v_u_8.getDownedTimeMult(p_u_85.Player) or 1) or 1))
								p_u_85.IsDowned = true
								p_u_85:ResetSecondWind()
							end
						end
					end
				end
				if v_u_9 or not p89 then
					local v98 = {
						["Type"] = "PropertyChanged",
						["Player"] = nil,
						["Index"] = nil,
						["Value"] = nil,
						["Player"] = p_u_85.Player,
						["Index"] = p86,
						["Value"] = p87
					}
					if p89 then
						v_u_13:FireAllClientsExcept(p89, v98)
					else
						v_u_13:FireAllClients(v98)
					end
				end
			elseif p88 and v_u_16[p86] ~= nil then
				v_u_13:FireServer({
					["Type"] = "PropertyChanged",
					["Index"] = nil,
					["Value"] = nil,
					["Index"] = p86,
					["Value"] = p87
				})
			end
		end
	end
}
function createAddPacket(p100) -- name: createAddPacket
	return {
		["Type"] = "Add",
		["Player"] = nil,
		["Properties"] = nil,
		["Player"] = p100.Player,
		["Properties"] = p100.Properties
	}
end
if v_u_10 then
	v_u_13:SetServerListener(function(p101, p102)
		-- upvalues: (copy) v_u_16, (copy) v_u_14, (copy) v_u_13, (copy) v_u_7
		if p102 then
			if p102.Type == "PropertyChanged" then
				local v103 = v_u_16[p102.Index]
				local v104 = v_u_14[p101]
				if v103 then
					local v105 = p102.Value
					local v106
					if v103 == "string_or_false" then
						v106 = typeof(v105) == "string" and true or v105 == false
					else
						v106 = typeof(v105) == v103
					end
					if v106 and v104 then
						v104:_SetProperty(p102.Index, p102.Value, nil, p101)
						return
					end
				end
			end
		else
			for _, v107 in v_u_14 do
				v_u_13:FireClient(p101, createAddPacket(v107))
			end
			for _, v108 in v_u_14 do
				local v109 = v108.StatusEffects
				if v109 then
					v109 = v108.StatusEffects.EffectObjects
				end
				if v109 then
					for v110, v111 in v109 do
						if not v111.Inactive then
							v_u_7:FireClient(p101, {
								["Type"] = "StatusApplied",
								["Player"] = nil,
								["Status"] = nil,
								["Params"] = nil,
								["Player"] = v108.Player,
								["Status"] = v110,
								["Params"] = v111:Serialize()
							})
						end
					end
				end
			end
		end
	end)
else
	v_u_13:SetClientListener(function(p112)
		-- upvalues: (copy) v_u_14, (copy) v_u_99
		if p112 then
			local v113 = p112.Type
			if v113 == "Add" then
				local v114 = v_u_14[p112.Player]
				if v114 then
					for v115, v116 in p112.Properties do
						if v114.Properties[v115] ~= v116 then
							v114:_SetProperty(v115, v116)
						end
					end
				else
					v_u_99.new(p112.Player, p112.Properties)
				end
			end
			if v113 == "PropertyChanged" then
				local v117 = v_u_14[p112.Player]
				if v117 then
					v117:_SetProperty(p112.Index, p112.Value)
					return
				end
			else
				local v118 = v113 == "Damaged" and v_u_14[p112.Player]
				if v118 then
					local v119 = p112.Data
					local v120, v121, v122 = unpack(v119)
					v118.Damaged:Fire(v120, v121, v122)
				end
			end
		end
	end)
	v_u_13:FireServer()
end
return v_u_99