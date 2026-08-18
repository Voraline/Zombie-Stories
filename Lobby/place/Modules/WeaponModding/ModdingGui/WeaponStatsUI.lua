game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
require("@game/ReplicatedStorage/common/Fusion/State/Value")
local v_u_1 = require("../../Graph")
local v2 = require("@game/ReplicatedStorage/common/Fusion")
require("../MiscFunctions")
local v_u_3 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/DamageFalloffUtil")
local _ = v2.New
local _ = v2.Children
local v_u_4 = v2.Value
local v_u_5 = {
	["Damage"] = {
		["Min"] = 0,
		["Max"] = 250
	},
	["Reload"] = {
		["Min"] = 0,
		["Max"] = 8
	},
	["FireRate"] = {
		["Min"] = 0,
		["Max"] = 1300
	},
	["Spread"] = {
		["Min"] = 0,
		["Max"] = 10
	},
	["Piercing"] = {
		["Min"] = 0,
		["Max"] = 5
	},
	["PierceReduction"] = {
		["Min"] = 0,
		["Max"] = 1
	},
	["Mobility"] = {
		["Min"] = 0,
		["Max"] = 6
	},
	["Control"] = {
		["Min"] = 0,
		["Max"] = 8
	},
	["Handling"] = {
		["Min"] = 0,
		["Max"] = 6
	}
}
local v_u_6 = utf8.char(176)
local v_u_7 = {
	["Damage"] = 1,
	["Reload"] = -1,
	["FireRate"] = 1,
	["Spread"] = -1,
	["Piercing"] = 1,
	["Mobility"] = 1,
	["Control"] = 1,
	["Handling"] = 1
}
local v_u_8 = {
	["Pump Action"] = "Single",
	["Bolt Action"] = "Single",
	["Auto"] = "Auto",
	["Semi-Auto"] = "Single",
	["Burst"] = "Burst",
	["Melee"] = "Melee"
}
local v_u_16 = {
	["Damage"] = function(p9) -- name: Damage
		return ("%d"):format((math.round(p9)))
	end,
	["FireRate"] = function(p10) -- name: FireRate
		return ("%d"):format((math.round(p10)))
	end,
	["Spread"] = function(p11) -- name: Spread
		-- upvalues: (copy) v_u_6
		return ("%.1f" .. v_u_6):format(p11)
	end,
	["Piercing"] = function(p12) -- name: Piercing
		return ("%d"):format(p12)
	end,
	["Mobility"] = function(p13) -- name: Mobility
		return ("%.1f"):format(p13)
	end,
	["Control"] = function(p14) -- name: Control
		return ("%.1f"):format(p14)
	end,
	["Handling"] = function(p15) -- name: Handling
		return ("%.1f"):format(p15)
	end
}
local v_u_17 = nil
local function v_u_25(p18, p19) -- name: populateGraph
	-- upvalues: (ref) v_u_17, (copy) v_u_3
	if v_u_17 and v_u_17 > os.clock() then
		return nil
	end
	v_u_17 = os.clock() + 0.1
	local v20 = {}
	for _, v21 in { "DMG", "HS DMG" } do
		local v22 = {}
		for v23 = 1, 100 do
			local v24 = v_u_3.CalculateDamageAtDistance(p18, v23 - 1)
			if v21 == "HS DMG" then
				v24 = v24 * p19
			end
			v22[v23] = v24
		end
		v20[v21] = v22
		task.wait()
	end
	return v20
end
local function v_u_33(p26) -- name: getAverageSpread
	local v27 = 1
	local v28 = 1
	for _, v29 in {
		"CrouchSpreadReduction",
		"ProneSpreadReduction",
		"ADSSpreadReduction",
		"MovementSpread",
		"AirSpread",
		"SlidingSpread",
		"DivingSpread",
		"ShootingSpreadIncrement",
		"ShootingSpreadDecay"
	} do
		local v30 = p26[v29]
		if v30 then
			v27 = v27 + v30
			v28 = v28 + 1
		end
	end
	local v31 = v27 / v28
	local v32 = p26.BaseSpread
	return v31 * math.deg(v32)
end
function calculateStats(p34, p35) -- name: calculateStats
	-- upvalues: (copy) v_u_8, (copy) v_u_33, (copy) v_u_5
	p35.Damage = p34.Damage
	p35.HeadShotMult = p34.Multipliers.Head or 1
	p35.HeadShotDamage = p34.Damage * p35.HeadShotMult
	if p34.IsMelee then
		p35.IsMelee = true
		if p34.MaxHitsPerEnemy then
			p35.Damage = p35.Damage * p34.MaxHitsPerEnemy
			p35.HeadShotDamage = p35.HeadShotDamage * p34.MaxHitsPerEnemy
		end
		p35.Handling = (p34.DrawSpeed + p34.HolsterSpeed) / 2 * 2
	else
		p35.IsMelee = false
		if p34.DamageDropoff then
			p35.DamageDropoff = p34.DamageDropoff
		end
		p35.FireModes = {}
		for _, v36 in p34.FireMode do
			p35.FireModes[v_u_8[v36]] = true
		end
		if p34.BulletsPerShot then
			p35.Damage = p35.Damage * p34.BulletsPerShot
			p35.HeadShotDamage = p35.HeadShotDamage * p34.BulletsPerShot
		end
		p35.ReloadTime = p34.ReloadTime
		p35.EmptyReloadTime = p34.EmptyReloadTime
		if p34.UsesLoadLoop then
			p35.ReloadTime = p34.LoadStartTime + p34.InsertTime
			p35.EmptyReloadTime = p34.LoadStartTime + p34.InsertTime * p34.Ammo + p34.LoadStopTime
		end
		p35.Spread = v_u_33(p34)
		local v37 = p34.BaseSpread
		p35.BaseSpread = math.deg(v37)
		p35.ADSSpreadReduction = p34.ADSSpreadReduction
		p35.Control = v_u_5.Control.Max - (p34.VerticalRecoil + p34.HorizontalRecoil) * 0.5
		p35.Handling = (p34.ADSSpeed + p34.DrawSpeed + p34.HolsterSpeed) / 3 * 2
		p35.Magazine = p34.Ammo
		p35.Reserve = p34.StoredAmmo
	end
	p35.Piercing = p34.Penetration
	p35.PierceReduction = p34.PenetrationReduction
	p35.FireRate = 1 / p34.DelayPerShot * 60
	p35.Mobility = (p34.EquippedWalkspeedMultiplier + p34.HolsteredWalkspeedMultiplier) * 0.5 * 3
end
return function(p_u_38) -- name: init
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_25, (copy) v_u_7, (copy) v_u_5, (copy) v_u_16, (copy) v_u_6
	local v_u_39 = v_u_4(false)
	local v_u_40 = v_u_4(false)
	local v_u_41 = p_u_38.Ammo
	local v_u_42 = p_u_38.Modes
	local _ = v_u_42.ModesLabel
	local v_u_43 = p_u_38.Rows
	game:GetService("RunService"):IsStudio()
	local v_u_44 = os.clock()
	local v45 = require("./CreateGraphFrame")({
		["isOpen"] = v_u_39,
		["onClose"] = function() -- name: onClose
			-- upvalues: (copy) v_u_39
			v_u_39:set(false)
		end
	})
	v45.Parent = p_u_38.Parent
	local v_u_46 = v_u_1.new(v45)
	local v47 = {
		["graphOpen"] = v_u_39,
		["ButtonVisibility"] = {
			["Falloff"] = v_u_40
		},
		["onFalloff"] = function() -- name: onFalloff
			-- upvalues: (copy) v_u_39
			v_u_39:set(not v_u_39:get())
		end
	}
	require("./CreateButtonList")(v47).Parent = p_u_38
	local v_u_48 = {
		["Damage"] = 30,
		["HeadShotDamage"] = 60,
		["ReloadTime"] = 2.5,
		["EmptyReloadTime"] = 3,
		["FireRate"] = 500,
		["Spread"] = 7,
		["Piercing"] = 1,
		["PierceReduction"] = 0.5,
		["Mobility"] = 2,
		["Control"] = 3.5,
		["Handling"] = 3,
		["Magazine"] = 30,
		["Reserve"] = 180
	}
	local v_u_49 = table.clone(v_u_48)
	local v58 = {
		["UpdatePlacement"] = function(_, p50) -- name: UpdatePlacement
			-- upvalues: (copy) p_u_38, (copy) v_u_41
			if p50 == "Nodes" then
				p_u_38.AnchorPoint = Vector2.new(1, 1)
				p_u_38.Position = UDim2.new(0.99, 0, 0.99, 0)
				v_u_41.AnchorPoint = Vector2.new(1, 0.5)
				v_u_41.Position = UDim2.new(-0.05, 0, 0.5, 0)
			else
				p_u_38.AnchorPoint = Vector2.new(0, 1)
				p_u_38.Position = UDim2.new(0.01, 0, 0.65, 0)
				v_u_41.AnchorPoint = Vector2.new(0, 0.5)
				v_u_41.Position = UDim2.new(1.05, 0, 0.5, 0)
			end
		end,
		["UpdateGraph"] = function(_, p51) -- name: UpdateGraph
			-- upvalues: (ref) v_u_44, (copy) v_u_40, (ref) v_u_25, (ref) v_u_46, (copy) v_u_39
			if os.clock() >= v_u_44 then
				v_u_44 = os.clock() + 0.15
				if p51.DamageDropoff then
					v_u_40:set(true)
					local v52
					if p51.Multipliers then
						v52 = p51.Multipliers.Head
					else
						v52 = p51.HeadShotMult
					end
					local v53 = v_u_25(p51, v52)
					if v53 then
						v_u_46.Resolution = 10
						v_u_46.Data = v53
						return
					end
				else
					v_u_40:set(false)
					v_u_39:set(false)
				end
			end
		end,
		["SetBaseStats"] = function(p54, p55) -- name: SetBaseStats
			-- upvalues: (copy) v_u_48, (ref) v_u_49
			calculateStats(p55, v_u_48)
			v_u_49 = table.clone(v_u_48)
			p54:UpdateGraph(p55)
		end,
		["UpdateStats"] = function(p56, p57) -- name: UpdateStats
			-- upvalues: (ref) v_u_49
			calculateStats(p57, v_u_49)
			p56:UpdateGraph(p57)
		end
	}
	local function v_u_72(p59, p60, p61) -- name: updateStatBar
		-- upvalues: (ref) v_u_7, (ref) v_u_5, (copy) v_u_43
		local v62 = v_u_7[p59]
		local v63 = v_u_5[p59]
		local v64 = v63.Max - v63.Min
		local v65 = v_u_43[p59].Bar
		local v66 = (p60 - v63.Min) / v64
		local v67 = math.clamp(v66, 0, 1)
		local v68 = (p61 - v63.Min) / v64
		local v69 = math.clamp(v68, 0, 1)
		local v70 = v69 - v67
		local v71
		if math.sign(v70) == v62 then
			v71 = v65.GoodBar
			v65.BadBar.Visible = false
		else
			v71 = v65.BadBar
			v65.GoodBar.Visible = false
		end
		v71.Visible = true
		if v67 < v69 then
			v65.BaseBar.Size = UDim2.new(v67, 0, 1, 0)
			v71.Size = UDim2.new(v69 - v67, 0, 1, 0)
			v71.Position = UDim2.new(v67, 0, 0, 0)
		else
			v65.BaseBar.Size = UDim2.new(v69, 0, 1, 0)
			v71.Size = UDim2.new(v67 - v69, 0, 1, 0)
			v71.Position = UDim2.new(v69, 0, 0, 0)
		end
	end
	function v58.UpdateDisplay(_) -- name: UpdateDisplay
		-- upvalues: (ref) v_u_49, (copy) v_u_48, (copy) v_u_43, (copy) v_u_72, (ref) v_u_5, (ref) v_u_16, (ref) v_u_6, (copy) v_u_41, (copy) v_u_42, (copy) p_u_38
		local v73 = v_u_49.Damage
		local v74 = v_u_49.HeadShotDamage
		local v75 = (v_u_48.Damage + v_u_48.HeadShotDamage) * 0.5
		local v76 = (v73 + v74) * 0.5
		v_u_43.Damage.Value.Text = ("%d <font color=\"#f2b035\">(%d)</font>"):format(v73, v74)
		v_u_72("Damage", v75, v76)
		local v77 = v_u_49.ReloadTime
		local v78 = v_u_49.EmptyReloadTime
		local v79 = (v_u_48.ReloadTime + v_u_48.EmptyReloadTime) * 0.5
		local v80 = (v77 + v78) * 0.5
		v_u_43.Reload.Value.Text = ("%.1f-%.1fs"):format(v77, v78)
		v_u_72("Reload", v79, v80)
		local v81 = v_u_48.Piercing
		local v82 = v_u_49.Piercing
		local v83 = v_u_49.PierceReduction
		local v84 = v_u_43.Piercing.Value
		local v85
		if v82 < 1 then
			v85 = ("%d"):format(v82)
		else
			v85 = ("%d <font color=\"#f2b035\">(x%.1f)</font>"):format(v82, v83)
		end
		v84.Text = v85
		v_u_72("Piercing", v81, v82)
		for v86, v87 in v_u_48 do
			local v88 = v_u_49[v86]
			if v86 ~= "Damage" and (v86 ~= "Piercing" and (v86 ~= "PierceReduction" and v_u_5[v86])) then
				v_u_43[v86].Value.Text = v_u_16[v86](v88)
				v_u_72(v86, v87, v88)
			end
		end
		if not v_u_49.IsMelee then
			local v89 = v_u_49.BaseSpread
			if v_u_49.ADSSpreadReduction then
				local v90 = v89 * v_u_49.ADSSpreadReduction
				v_u_43.Spread.Value.Text = ("%.1f" .. v_u_6 .. " <font color=\"#f2b035\">(%.1f" .. v_u_6 .. ")</font>"):format(v89, v90)
			end
		end
		v_u_41.Visible = not v_u_49.IsMelee
		if v_u_49.Magazine > v_u_48.Magazine then
			v_u_41.Magazine.AmountLabel.TextColor3 = Color3.fromRGB(112, 216, 107)
		elseif v_u_49.Magazine < v_u_48.Magazine then
			v_u_41.Magazine.AmountLabel.TextColor3 = Color3.fromRGB(216, 90, 90)
		else
			v_u_41.Magazine.AmountLabel.TextColor3 = Color3.new(1, 1, 1)
		end
		v_u_41.Magazine.AmountLabel.Text = v_u_49.Magazine
		if v_u_49.Reserve > v_u_48.Reserve then
			v_u_41.Reserve.AmountLabel.TextColor3 = Color3.fromRGB(112, 216, 107)
		elseif v_u_49.Reserve < v_u_48.Reserve then
			v_u_41.Reserve.AmountLabel.TextColor3 = Color3.fromRGB(216, 90, 90)
		else
			v_u_41.Reserve.AmountLabel.TextColor3 = Color3.new(1, 1, 1)
		end
		v_u_41.Reserve.AmountLabel.Text = v_u_49.Reserve
		if v_u_49.IsMelee then
			v_u_42.ModesLabel.Text = ("<font color=\"#f2b035\">%s</font>"):format("MELEE")
		else
			local v91 = not v_u_49.FireModes.Single and "SINGLE" or ("<font color=\"#f2b035\">%s</font>"):format("SINGLE")
			local v92 = not v_u_49.FireModes.Burst and "BURST" or ("<font color=\"#f2b035\">%s</font>"):format("BURST")
			local v93 = not v_u_49.FireModes.Auto and "AUTO" or ("<font color=\"#f2b035\">%s</font>"):format("AUTO")
			v_u_42.ModesLabel.Text = ("%s | %s | %s"):format(v91, v92, v93)
		end
		v_u_43.Control.Visible = not v_u_49.IsMelee
		v_u_43.Reload.Visible = not v_u_49.IsMelee
		v_u_43.Spread.Visible = not v_u_49.IsMelee
		if v_u_49.IsMelee then
			p_u_38.Size = UDim2.new(0.45, 0, 0.153, 0)
		else
			p_u_38.Size = UDim2.new(0.45, 0, 0.246, 0)
		end
	end
	return v58
end