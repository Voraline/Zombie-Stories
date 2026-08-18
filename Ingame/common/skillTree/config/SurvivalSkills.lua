require("./SkillTypes")
local v1 = {}
local v2 = {
	["id"] = "thickSkin",
	["name"] = "Thick Skin",
	["branch"] = "Survival",
	["tier"] = 1,
	["maxRank"] = 5,
	["costs"] = nil,
	["description"] = "+10% max HP per rank",
	["effectPerRank"] = 10,
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 1
		},
		{
			["type"] = "ZBucks",
			["amount"] = 250
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
local v3 = {
	["id"] = "grit",
	["name"] = "Grit",
	["branch"] = "Survival",
	["tier"] = 1,
	["maxRank"] = 5,
	["costs"] = nil,
	["description"] = "+3% damage reduction per rank",
	["effectPerRank"] = 3,
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 1
		},
		{
			["type"] = "ZBucks",
			["amount"] = 250
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
	["id"] = "adrenaline",
	["name"] = "Adrenaline",
	["branch"] = "Survival",
	["tier"] = 2,
	["maxRank"] = 3,
	["costs"] = nil,
	["description"] = "Regain +5 stamina when hit per rank",
	["effectPerRank"] = 5,
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 2
		},
		{
			["type"] = "ZBucks",
			["amount"] = 500
		}
	},
	["requirements"] = {
		["logic"] = "any",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "skill",
				["skillId"] = "thickSkin",
				["minRank"] = 1
			},
			{
				["type"] = "skill",
				["skillId"] = "grit",
				["minRank"] = 1
			}
		}
	}
}
local v5 = {
	["id"] = "ironWill",
	["name"] = "Iron Will",
	["branch"] = "Survival",
	["tier"] = 2,
	["maxRank"] = 5,
	["costs"] = nil,
	["description"] = "+15% downed time per rank",
	["effectPerRank"] = 15,
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 2
		},
		{
			["type"] = "ZBucks",
			["amount"] = 500
		}
	},
	["requirements"] = {
		["logic"] = "any",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "skill",
				["skillId"] = "thickSkin",
				["minRank"] = 1
			},
			{
				["type"] = "skill",
				["skillId"] = "grit",
				["minRank"] = 1
			}
		}
	}
}
local v6 = {
	["id"] = "desperateSprint",
	["name"] = "Desperate Sprint",
	["branch"] = "Survival",
	["tier"] = 2,
	["maxRank"] = 5,
	["costs"] = nil,
	["description"] = "Below X% HP, sprint costs no stamina (5% per rank)",
	["effectPerRank"] = 5,
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 2
		},
		{
			["type"] = "ZBucks",
			["amount"] = 500
		}
	},
	["requirements"] = {
		["logic"] = "any",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "skill",
				["skillId"] = "thickSkin",
				["minRank"] = 1
			},
			{
				["type"] = "skill",
				["skillId"] = "grit",
				["minRank"] = 1
			}
		}
	}
}
local v7 = {
	["id"] = "secondChance",
	["name"] = "Second Chance",
	["branch"] = "Survival",
	["tier"] = 3,
	["maxRank"] = 1,
	["costs"] = nil,
	["description"] = "+1 down before spectator",
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 3
		},
		{
			["type"] = "ZBucks",
			["amount"] = 1000
		},
		{
			["type"] = "Gems",
			["amount"] = 35
		}
	},
	["requirements"] = {
		["logic"] = "all",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "tier",
				["branch"] = "Survival",
				["tier"] = 2,
				["count"] = 4
			}
		}
	}
}
local v8 = {
	["id"] = "swanSong",
	["name"] = "Swan Song",
	["branch"] = "Survival",
	["tier"] = 3,
	["maxRank"] = 1,
	["costs"] = nil,
	["description"] = "4s free movement + infinite ammo when downed",
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 3
		},
		{
			["type"] = "ZBucks",
			["amount"] = 1000
		},
		{
			["type"] = "Gems",
			["amount"] = 35
		}
	},
	["requirements"] = {
		["logic"] = "all",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "tier",
				["branch"] = "Survival",
				["tier"] = 2,
				["count"] = 4
			}
		}
	}
}
local v9 = {
	["id"] = "secondWind",
	["name"] = "Second Wind",
	["branch"] = "Survival",
	["tier"] = 3,
	["maxRank"] = 1,
	["costs"] = nil,
	["description"] = "Deal damage while downed to fill self-revive meter",
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 3
		},
		{
			["type"] = "ZBucks",
			["amount"] = 1000
		},
		{
			["type"] = "Gems",
			["amount"] = 35
		}
	},
	["requirements"] = {
		["logic"] = "all",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "tier",
				["branch"] = "Survival",
				["tier"] = 2,
				["count"] = 4
			}
		}
	}
}
local v10 = {
	["id"] = "lastStand",
	["name"] = "Last Stand",
	["branch"] = "Survival",
	["tier"] = 3,
	["maxRank"] = 1,
	["costs"] = nil,
	["description"] = "Use primary weapon while downed",
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 3
		},
		{
			["type"] = "ZBucks",
			["amount"] = 1000
		},
		{
			["type"] = "Gems",
			["amount"] = 35
		}
	},
	["requirements"] = {
		["logic"] = "all",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "tier",
				["branch"] = "Survival",
				["tier"] = 2,
				["count"] = 4
			}
		}
	}
}
local v11 = {
	["id"] = "theSpartan",
	["name"] = "The Spartan",
	["branch"] = "Survival",
	["tier"] = 4,
	["maxRank"] = 3,
	["costs"] = nil,
	["firstRankOnlyCosts"] = nil,
	["description"] = "Energy shield, regens after cooldown (-10% per rank)",
	["effectPerRank"] = 10,
	["requirements"] = nil,
	["costs"] = {
		{
			["type"] = "SP",
			["amount"] = 3
		},
		{
			["type"] = "ZBucks",
			["amount"] = 2000
		},
		{
			["type"] = "Gems",
			["amount"] = 100
		}
	},
	["firstRankOnlyCosts"] = { "Gems" },
	["requirements"] = {
		["logic"] = "all",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "tier",
				["branch"] = "Survival",
				["tier"] = 3,
				["count"] = 3
			}
		}
	}
}
__set_list(v1, 1, {v2, v3, v4, v5, v6, v7, v8, v9, v10, v11})
return v1