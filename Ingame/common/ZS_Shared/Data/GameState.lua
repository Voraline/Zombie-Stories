local v1 = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local v_u_2 = require("@game/ReplicatedStorage/common/Signal")
local v3 = {}
local v4 = game.GameId == 1970013852
v1:IsStudio()
local v5 = os.date("*t")
local v6
if v5.month == 12 then
	v6 = v5.day >= 20
else
	v6 = false
end
local v7 = workspace:GetAttribute("PlaceType")
v3.Data = {
	["IsLobby"] = nil,
	["IsArcade"] = nil,
	["IsStory"] = nil,
	["ServerLoaded"] = false,
	["SkipSpecialAwards"] = false,
	["EasyModifiersActive"] = false,
	["ModifiersActive"] = false,
	["QuestSystemActive"] = true,
	["Events"] = nil,
	["IsTestUniverse"] = nil,
	["Variables"] = nil,
	["ActiveModifiers"] = nil,
	["IsLobby"] = v7 == "Lobby",
	["IsArcade"] = v7 == "Arcade",
	["IsStory"] = v7 == "Story",
	["Events"] = {
		["ChristmasActive"] = v6
	},
	["IsTestUniverse"] = v4,
	["Variables"] = {
		["ZBucksMultiplier"] = 1,
		["XPMultiplier"] = 1,
		["PlayerDamageTaken"] = 1,
		["PlayerDowns"] = 3,
		["ZombieHealth"] = 1,
		["ZombieSpeed"] = 1,
		["ZombieDamage"] = 1,
		["ZombieSpawnRate"] = 1,
		["ZombieSlowdown"] = 1,
		["ZombieSlowdownEnabled"] = true,
		["ZombiesExplodeOnDeath"] = false,
		["ZombieExplodeDamage"] = 1,
		["ZombieExplodeRadius"] = 1,
		["ZombieAttackSpeed"] = 1,
		["ZombieAttackDelay"] = 1,
		["HeadshotOnly"] = false,
		["DefaultMusicEnabled"] = true,
		["WallhackEnabled"] = false,
		["MotionSicknessEnabled"] = false,
		["HalfBlindEnabled"] = false,
		["BreakdancingZombiesEnabled"] = false,
		["PartyModeEnabled"] = false,
		["PlayerSpeed"] = 1,
		["FireRate"] = 1,
		["WeaponSpread"] = 1,
		["SlidingEnabled"] = true,
		["GivePrimary"] = true,
		["GiveSecondary"] = true,
		["GiveMelee"] = true,
		["GiveAbility"] = true,
		["ForcePrimary"] = "",
		["ForceSecondary"] = "",
		["ForceMelee"] = "",
		["ForceAbility"] = ""
	},
	["ActiveModifiers"] = {}
}
v3.LocalState = {
	["NPCRotation"] = CFrame.Angles(0, 0, 0),
	["RotationAxis"] = {
		["X"] = 0,
		["Y"] = 0,
		["Z"] = 0
	}
}
v3.Signals = {}
local v_u_8 = {
	["ActiveModifiers"] = true
}
local function v_u_13(p9, p10) -- name: deepTraverse
	-- upvalues: (copy) v_u_8, (copy) v_u_13, (copy) v_u_2
	for v11, v12 in p9 do
		if type(v12) == "table" and not v_u_8[v11] then
			p10[v11] = {}
			v_u_13(v12, p10[v11])
		else
			p10[v11] = v_u_2.new()
		end
	end
end
v_u_13(v3.Data, v3.Signals)
return v3