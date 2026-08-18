game:GetService("Players")
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v3 = game:GetService("SoundService")
local v_u_4 = require("./config/SkillConfig")
local v_u_5 = {}
if v2:IsServer() then
	game:GetService("ServerScriptService")
	require("@game/ServerScriptService/common/zap")
	local v_u_6 = {}
	function v_u_5.initializePlayer(p7) -- name: initializePlayer
		-- upvalues: (copy) v_u_6, (copy) v_u_4
		v_u_6[p7] = {}
		for v8 in v_u_4.skills do
			v_u_6[p7][v8] = 0
		end
	end
	function v_u_5.cleanupPlayer(p9) -- name: cleanupPlayer
		-- upvalues: (copy) v_u_6
		v_u_6[p9] = nil
	end
	function v_u_5.getSkillRank(p10, p11) -- name: getSkillRank
		-- upvalues: (copy) v_u_6
		local v12 = v_u_6[p10]
		return v12 and (v12[p11] or 0) or 0
	end
	function v_u_5.setSkillRank(p13, p14, p15) -- name: setSkillRank
		-- upvalues: (copy) v_u_6
		local v16 = v_u_6[p13]
		if v16 then
			v16[p14] = p15
		end
	end
	function v_u_5.getAllSkillRanks(p17) -- name: getAllSkillRanks
		-- upvalues: (copy) v_u_6
		return v_u_6[p17] or {}
	end
	function v_u_5.getReloadSpeedMult(p18) -- name: getReloadSpeedMult
		-- upvalues: (copy) v_u_5
		return 1 / (1 + 0.04 * v_u_5.getSkillRank(p18, "fastHands"))
	end
	function v_u_5.getRecoilMult(p19) -- name: getRecoilMult
		-- upvalues: (copy) v_u_5
		return 1 - 0.04 * v_u_5.getSkillRank(p19, "steadyAim")
	end
	function v_u_5.getSwapSpeedMult(p20) -- name: getSwapSpeedMult
		-- upvalues: (copy) v_u_5
		return 1 + 0.1 * v_u_5.getSkillRank(p20, "sleightSwitch")
	end
	function v_u_5.getMaxHPMult(p21) -- name: getMaxHPMult
		-- upvalues: (copy) v_u_5
		local v22 = v_u_5.getSkillRank(p21, "thickSkin")
		local v23 = v_u_5.getSkillRank(p21, "core2")
		return 1 + 0.1 * v22 + 0.1 * v23
	end
	function v_u_5.getDamageReductionMult(p24) -- name: getDamageReductionMult
		-- upvalues: (copy) v_u_5
		return 1 - 0.03 * v_u_5.getSkillRank(p24, "grit")
	end
	function v_u_5.getAmmoCapacityMult(p25) -- name: getAmmoCapacityMult
		-- upvalues: (copy) v_u_5
		return 1 + 0.08 * v_u_5.getSkillRank(p25, "deepPockets")
	end
	function v_u_5.getInteractSpeedMult(p26) -- name: getInteractSpeedMult
		-- upvalues: (copy) v_u_5
		return 1 + 0.05 * v_u_5.getSkillRank(p26, "quickInteract")
	end
	function v_u_5.getMeleeSwingSpeedMult(p27) -- name: getMeleeSwingSpeedMult
		-- upvalues: (copy) v_u_5
		return 1 + 0.1 * v_u_5.getSkillRank(p27, "meleeTempo")
	end
	function v_u_5.getDownedTimeMult(p28) -- name: getDownedTimeMult
		-- upvalues: (copy) v_u_5
		return 1 + 0.15 * v_u_5.getSkillRank(p28, "ironWill")
	end
	function v_u_5.getHeadshotDamageMult(p29) -- name: getHeadshotDamageMult
		-- upvalues: (copy) v_u_5
		return 1 + 0.05 * v_u_5.getSkillRank(p29, "core3")
	end
	function v_u_5.getXPBonusMult(p30) -- name: getXPBonusMult
		-- upvalues: (copy) v_u_5
		return 1 + 0.05 * v_u_5.getSkillRank(p30, "core1")
	end
	function v_u_5.getAdrenalineStamina(p31) -- name: getAdrenalineStamina
		-- upvalues: (copy) v_u_5
		return 5 * v_u_5.getSkillRank(p31, "adrenaline")
	end
	function v_u_5.getParryWindowBonus(p32) -- name: getParryWindowBonus
		-- upvalues: (copy) v_u_5
		return 0.1 * v_u_5.getSkillRank(p32, "parryMaster")
	end
	function v_u_5.getSpartanCooldownMult(p33) -- name: getSpartanCooldownMult
		-- upvalues: (copy) v_u_5
		return 1 - 0.1 * v_u_5.getSkillRank(p33, "theSpartan")
	end
	function v_u_5.hasFury(p34) -- name: hasFury
		-- upvalues: (copy) v_u_5
		return v_u_5.getSkillRank(p34, "fury") >= 1
	end
	function v_u_5.hasDeadEye(p35) -- name: hasDeadEye
		-- upvalues: (copy) v_u_5
		return v_u_5.getSkillRank(p35, "deadEye") >= 1
	end
	function v_u_5.hasQuickDraw(p36) -- name: hasQuickDraw
		-- upvalues: (copy) v_u_5
		return v_u_5.getSkillRank(p36, "quickDraw") >= 1
	end
	function v_u_5.hasSecondChance(p37) -- name: hasSecondChance
		-- upvalues: (copy) v_u_5
		return v_u_5.getSkillRank(p37, "secondChance") >= 1
	end
	function v_u_5.hasSwanSong(p38) -- name: hasSwanSong
		-- upvalues: (copy) v_u_5
		return v_u_5.getSkillRank(p38, "swanSong") >= 1
	end
	function v_u_5.hasSecondWind(p39) -- name: hasSecondWind
		-- upvalues: (copy) v_u_5
		return v_u_5.getSkillRank(p39, "secondWind") >= 1
	end
	function v_u_5.hasLastStand(p40) -- name: hasLastStand
		-- upvalues: (copy) v_u_5
		return v_u_5.getSkillRank(p40, "lastStand") >= 1
	end
	function v_u_5.hasTheSpartan(p41) -- name: hasTheSpartan
		-- upvalues: (copy) v_u_5
		return v_u_5.getSkillRank(p41, "theSpartan") >= 1
	end
	function v_u_5.getExtraDowns(p42) -- name: getExtraDowns
		-- upvalues: (copy) v_u_5
		return v_u_5.getSkillRank(p42, "core4") + v_u_5.getSkillRank(p42, "secondChance")
	end
	return v_u_5
end
local v43 = v1:WaitForChild("Packages")
local v_u_44 = require(v43:WaitForChild("Fusion"))
local v45 = require("@game/ReplicatedStorage/common/zap")
local v46 = require("@game/ReplicatedStorage/common/Signal")
local v47 = v_u_44.scoped(v_u_44)
v_u_5.Scope = v47
local v_u_48 = {}
for v49 in v_u_4.skills do
	v_u_48[v49] = v47:Value(0)
end
v_u_5.SkillRanks = v_u_48
v_u_5.Loaded = v47:Value(false)
function v_u_5.getSkillRankValue(p50) -- name: getSkillRankValue
	-- upvalues: (copy) v_u_48
	return v_u_48[p50]
end
function v_u_5.getSkillRank(p51) -- name: getSkillRank
	-- upvalues: (copy) v_u_48, (copy) v_u_44
	local v52 = v_u_48[p51]
	return v52 and v_u_44.peek(v52) or 0
end
v_u_5.ReloadSpeedMult = v47:Computed(function(p53)
	-- upvalues: (copy) v_u_48
	return 1 / (1 + 0.04 * (p53(v_u_48.fastHands) or 0))
end)
v_u_5.RecoilMult = v47:Computed(function(p54)
	-- upvalues: (copy) v_u_48
	return 1 - 0.04 * (p54(v_u_48.steadyAim) or 0)
end)
v_u_5.SwapSpeedMult = v47:Computed(function(p55)
	-- upvalues: (copy) v_u_48
	return 1 + 0.1 * (p55(v_u_48.sleightSwitch) or 0)
end)
v_u_5.MaxHPMult = v47:Computed(function(p56)
	-- upvalues: (copy) v_u_48
	local v57 = p56(v_u_48.thickSkin) or 0
	local v58 = p56(v_u_48.core2) or 0
	return 1 + 0.1 * v57 + 0.1 * v58
end)
v_u_5.DamageReductionMult = v47:Computed(function(p59)
	-- upvalues: (copy) v_u_48
	return 1 - 0.03 * (p59(v_u_48.grit) or 0)
end)
v_u_5.AmmoCapacityMult = v47:Computed(function(p60)
	-- upvalues: (copy) v_u_48
	return 1 + 0.08 * (p60(v_u_48.deepPockets) or 0)
end)
v_u_5.InteractSpeedMult = v47:Computed(function(p61)
	-- upvalues: (copy) v_u_48
	return 1 + 0.05 * (p61(v_u_48.quickInteract) or 0)
end)
v_u_5.MeleeSwingSpeedMult = v47:Computed(function(p62)
	-- upvalues: (copy) v_u_48
	return 1 + 0.1 * (p62(v_u_48.meleeTempo) or 0)
end)
v_u_5.DownedTimeMult = v47:Computed(function(p63)
	-- upvalues: (copy) v_u_48
	return 1 + 0.15 * (p63(v_u_48.ironWill) or 0)
end)
v_u_5.HeadshotDamageMult = v47:Computed(function(p64)
	-- upvalues: (copy) v_u_48
	return 1 + 0.05 * (p64(v_u_48.core3) or 0)
end)
v_u_5.XPBonusMult = v47:Computed(function(p65)
	-- upvalues: (copy) v_u_48
	return 1 + 0.05 * (p65(v_u_48.core1) or 0)
end)
v_u_5.AdrenalineStamina = v47:Computed(function(p66)
	-- upvalues: (copy) v_u_48
	return 5 * (p66(v_u_48.adrenaline) or 0)
end)
v_u_5.ParryWindowBonus = v47:Computed(function(p67)
	-- upvalues: (copy) v_u_48
	return 0.1 * (p67(v_u_48.parryMaster) or 0)
end)
v_u_5.SpartanCooldownMult = v47:Computed(function(p68)
	-- upvalues: (copy) v_u_48
	return 1 - 0.1 * (p68(v_u_48.theSpartan) or 0)
end)
v_u_5.HasFury = v47:Computed(function(p69)
	-- upvalues: (copy) v_u_48
	return (p69(v_u_48.fury) or 0) >= 1
end)
v_u_5.HasDeadEye = v47:Computed(function(p70)
	-- upvalues: (copy) v_u_48
	return (p70(v_u_48.deadEye) or 0) >= 1
end)
v_u_5.HasQuickDraw = v47:Computed(function(p71)
	-- upvalues: (copy) v_u_48
	return (p71(v_u_48.quickDraw) or 0) >= 1
end)
v_u_5.HasSecondChance = v47:Computed(function(p72)
	-- upvalues: (copy) v_u_48
	return (p72(v_u_48.secondChance) or 0) >= 1
end)
v_u_5.HasSwanSong = v47:Computed(function(p73)
	-- upvalues: (copy) v_u_48
	return (p73(v_u_48.swanSong) or 0) >= 1
end)
v_u_5.HasSecondWind = v47:Computed(function(p74)
	-- upvalues: (copy) v_u_48
	return (p74(v_u_48.secondWind) or 0) >= 1
end)
v_u_5.HasLastStand = v47:Computed(function(p75)
	-- upvalues: (copy) v_u_48
	return (p75(v_u_48.lastStand) or 0) >= 1
end)
v_u_5.HasTheSpartan = v47:Computed(function(p76)
	-- upvalues: (copy) v_u_48
	return (p76(v_u_48.theSpartan) or 0) >= 1
end)
v_u_5.ExtraDowns = v47:Computed(function(p77)
	-- upvalues: (copy) v_u_48
	return (p77(v_u_48.core4) or 0) + (p77(v_u_48.secondChance) or 0)
end)
v_u_5.DesperateSprintThreshold = v47:Computed(function(p78)
	-- upvalues: (copy) v_u_48
	return 0.05 * (p78(v_u_48.desperateSprint) or 0)
end)
local v79 = require("./config/EconomyConfig")
v_u_5.SP = v47:Value(0)
v_u_5.SPCap = v47:Value(v79.BASE_SP_CAP)
v_u_5.SPSpent = v47:Value(0)
v_u_5.XPBar = v47:Value(0)
v_u_5.DailyEarned = v47:Value(0)
v_u_5.DailyEarnCap = v47:Value(v79.BASE_DAILY_EARN_CAP)
v_u_5.PrestigeLevel = v47:Value(0)
v_u_5.ZBucks = v47:Value(0)
v_u_5.ZBucksInvested = v47:Value(0)
v_u_5.XPPerSP = v79.SP_XP_PER_SP
v_u_5.XPChanged = v46.new()
v_u_5.AtSPCap = v47:Computed(function(p80)
	-- upvalues: (copy) v_u_5
	return p80(v_u_5.SP) + p80(v_u_5.SPSpent) >= p80(v_u_5.SPCap)
end)
v_u_5.AtDailyCap = v47:Computed(function(p81)
	-- upvalues: (copy) v_u_5
	return p81(v_u_5.DailyEarned) >= p81(v_u_5.DailyEarnCap)
end)
v_u_5.CanPrestige = v47:Computed(function(p82)
	-- upvalues: (copy) v_u_5
	local v83
	if p82(v_u_5.SPSpent) >= p82(v_u_5.SPCap) then
		v83 = p82(v_u_5.SP) == 0
	else
		v83 = false
	end
	return v83
end)
v45.InitSkillTree.On(function(p84)
	-- upvalues: (copy) v_u_48, (copy) v_u_5
	print("[SkillTreeData] Received initial skill data")
	for v85, v86 in p84 do
		local v87 = v_u_48[v85]
		if v87 then
			v87:set(v86)
		end
	end
	v_u_5.Loaded:set(true)
end)
local v_u_88 = Instance.new("Sound")
v_u_88.SoundId = "rbxassetid://9039999622"
v_u_88.Parent = v3
local v_u_89 = Instance.new("Sound")
v_u_89.SoundId = "rbxassetid://118207534374651"
v_u_89.Parent = v3
v45.UpdateSkillRank.On(function(p90)
	-- upvalues: (copy) v_u_48, (copy) v_u_88, (copy) v_u_89
	print((("[SkillTreeData] Skill %* updated to rank %*"):format(p90.SkillId, p90.Rank)))
	local v91 = p90.SkillId
	local v92 = p90.Rank
	local v93 = v_u_48[v91]
	if v93 then
		v93:set(v92)
	end
	v_u_88:Play()
	v_u_89:Play()
end)
local v_u_94 = nil
local v_u_95 = nil
v45.SyncSkillTreeEconomy.On(function(p96)
	-- upvalues: (ref) v_u_94, (ref) v_u_95, (copy) v_u_5
	local v97 = v_u_94
	local v98 = v_u_95
	v_u_5.SP:set(p96.SP)
	v_u_5.SPCap:set(p96.SPCap)
	v_u_5.SPSpent:set(p96.SPSpent)
	v_u_5.XPBar:set(p96.XPBar)
	v_u_5.DailyEarned:set(p96.DailyEarned)
	v_u_5.DailyEarnCap:set(p96.DailyEarnCap)
	v_u_5.PrestigeLevel:set(p96.PrestigeLevel)
	v_u_5.ZBucks:set(p96.ZBucks)
	v_u_5.ZBucksInvested:set(p96.ZBucksInvested)
	if v97 ~= nil and p96.XPBar ~= v97 then
		v_u_5.XPChanged:Fire(v97, p96.XPBar, v98, p96.SP)
	end
	v_u_94 = p96.XPBar
	v_u_95 = p96.SP
end)
return v_u_5