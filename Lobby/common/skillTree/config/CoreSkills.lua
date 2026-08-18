require("./SkillTypes")
local v1 = {}
local v2 = {
	["id"] = "core2",
	["name"] = "Weight Lifting",
	["branch"] = "Core",
	["tier"] = 2,
	["maxRank"] = 1,
	["costs"] = nil,
	["description"] = "+10% max HP",
	["effectPerRank"] = 10,
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 1
		},
		{
			["type"] = "ZBucks",
			["amount"] = 200
		}
	},
	["requirements"] = {
		["logic"] = "all",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "skill",
				["skillId"] = "core1",
				["minRank"] = 1
			}
		}
	}
}
local v3 = {
	["id"] = "core3",
	["name"] = "Combat Drills",
	["branch"] = "Core",
	["tier"] = 3,
	["maxRank"] = 1,
	["costs"] = nil,
	["description"] = "+5% headshot damage",
	["effectPerRank"] = 5,
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 1
		},
		{
			["type"] = "ZBucks",
			["amount"] = 300
		}
	},
	["requirements"] = {
		["logic"] = "all",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "skill",
				["skillId"] = "core2",
				["minRank"] = 1
			}
		}
	}
}
local v4 = {
	["id"] = "core4",
	["name"] = "Survival Drills",
	["branch"] = "Core",
	["tier"] = 4,
	["maxRank"] = 1,
	["costs"] = nil,
	["description"] = "+1 down before spectator",
	["effectPerRank"] = 1,
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 1
		},
		{
			["type"] = "ZBucks",
			["amount"] = 400
		}
	},
	["requirements"] = {
		["logic"] = "all",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "skill",
				["skillId"] = "core3",
				["minRank"] = 1
			}
		}
	}
}
local v5 = {
	["id"] = "core5",
	["name"] = "Coming Soon",
	["branch"] = "Core",
	["tier"] = 5,
	["maxRank"] = 1,
	["costs"] = nil,
	["description"] = "Coming soon",
	["enabled"] = false,
	["comingSoonText"] = "Unlocks with future update",
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 1
		},
		{
			["type"] = "ZBucks",
			["amount"] = 500
		}
	},
	["requirements"] = {
		["logic"] = "all",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "skill",
				["skillId"] = "core4",
				["minRank"] = 1
			}
		}
	}
}
__set_list(v1, 1, {{
	["id"] = "core1",
	["name"] = "Basic Training",
	["branch"] = "Core",
	["tier"] = 1,
	["maxRank"] = 1,
	["costs"] = nil,
	["description"] = "+5% skill point XP",
	["effectPerRank"] = 5,
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 1
		},
		{
			["type"] = "ZBucks",
			["amount"] = 100
		}
	}
}, v2, v3, v4, v5})
return v1