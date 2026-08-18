require("./SkillTypes")
local v1 = {}
local v2 = {
	["id"] = "steadyAim",
	["name"] = "Steady Aim",
	["branch"] = "Combat",
	["tier"] = 1,
	["maxRank"] = 5,
	["costs"] = nil,
	["description"] = "-4% recoil per rank",
	["effectPerRank"] = 4,
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
				["skillId"] = "core3",
				["minRank"] = 1
			}
		}
	}
}
local v3 = {
	["id"] = "fastHands",
	["name"] = "Fast Hands",
	["branch"] = "Combat",
	["tier"] = 1,
	["maxRank"] = 5,
	["costs"] = nil,
	["description"] = "+4% reload speed per rank",
	["effectPerRank"] = 4,
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
				["skillId"] = "core3",
				["minRank"] = 1
			}
		}
	}
}
local v4 = {
	["id"] = "deepPockets",
	["name"] = "Deep Pockets",
	["branch"] = "Combat",
	["tier"] = 2,
	["maxRank"] = 5,
	["costs"] = nil,
	["description"] = "+8% ammo capacity per rank",
	["effectPerRank"] = 8,
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
				["skillId"] = "steadyAim",
				["minRank"] = 1
			},
			{
				["type"] = "skill",
				["skillId"] = "fastHands",
				["minRank"] = 1
			}
		}
	}
}
local v5 = {
	["id"] = "quickInteract",
	["name"] = "Quick Interact",
	["branch"] = "Combat",
	["tier"] = 2,
	["maxRank"] = 3,
	["costs"] = nil,
	["description"] = "+5% interact speed per rank",
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
				["skillId"] = "steadyAim",
				["minRank"] = 1
			},
			{
				["type"] = "skill",
				["skillId"] = "fastHands",
				["minRank"] = 1
			}
		}
	}
}
local v6 = {
	["id"] = "sleightSwitch",
	["name"] = "Sleight Switch",
	["branch"] = "Combat",
	["tier"] = 2,
	["maxRank"] = 3,
	["costs"] = nil,
	["description"] = "+10% swap speed per rank",
	["effectPerRank"] = 10,
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
				["skillId"] = "steadyAim",
				["minRank"] = 1
			},
			{
				["type"] = "skill",
				["skillId"] = "fastHands",
				["minRank"] = 1
			}
		}
	}
}
local v7 = {
	["id"] = "meleeTempo",
	["name"] = "Melee Tempo",
	["branch"] = "Combat",
	["tier"] = 2,
	["maxRank"] = 3,
	["costs"] = nil,
	["description"] = "+10% melee swing speed per rank",
	["effectPerRank"] = 10,
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
				["skillId"] = "steadyAim",
				["minRank"] = 1
			},
			{
				["type"] = "skill",
				["skillId"] = "fastHands",
				["minRank"] = 1
			}
		}
	}
}
local v8 = {
	["id"] = "fury",
	["name"] = "Fury",
	["branch"] = "Combat",
	["tier"] = 3,
	["maxRank"] = 1,
	["costs"] = nil,
	["description"] = "Below 25% HP, +25% damage",
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
				["branch"] = "Combat",
				["tier"] = 2,
				["count"] = 4
			}
		}
	}
}
local v9 = {
	["id"] = "deadEye",
	["name"] = "Dead Eye",
	["branch"] = "Combat",
	["tier"] = 3,
	["maxRank"] = 1,
	["costs"] = nil,
	["description"] = "+10% damage when stationary for 1 second",
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
				["branch"] = "Combat",
				["tier"] = 2,
				["count"] = 4
			}
		}
	}
}
local v10 = {
	["id"] = "parryMaster",
	["name"] = "Parry Master",
	["branch"] = "Combat",
	["tier"] = 3,
	["maxRank"] = 3,
	["costs"] = nil,
	["firstRankOnlyCosts"] = nil,
	["description"] = "+0.1s parry window per rank",
	["effectPerRank"] = 0.1,
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
	["firstRankOnlyCosts"] = { "Gems" },
	["requirements"] = {
		["logic"] = "all",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "tier",
				["branch"] = "Combat",
				["tier"] = 2,
				["count"] = 4
			}
		}
	}
}
local v11 = {
	["id"] = "quickDraw",
	["name"] = "Quick Draw",
	["branch"] = "Combat",
	["tier"] = 4,
	["maxRank"] = 1,
	["costs"] = nil,
	["description"] = "Primary lowers to side, pull pistol one-handed, shoot immediately",
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
	["requirements"] = {
		["logic"] = "all",
		["requirements"] = nil,
		["requirements"] = {
			{
				["type"] = "tier",
				["branch"] = "Combat",
				["tier"] = 3,
				["count"] = 3
			}
		}
	}
}
__set_list(v1, 1, {v2, v3, v4, v5, v6, v7, v8, v9, v10, v11})
return v1