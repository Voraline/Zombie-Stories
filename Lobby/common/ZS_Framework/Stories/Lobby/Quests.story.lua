local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Fusion)
local v_u_3 = require(v1.common.fusion_utils)
local v_u_4 = {
	["Visible"] = true
}
local v_u_5 = require("../../UI/Components/Quests/QuestsMenu")
return {
	["fusion"] = nil,
	["controls"] = nil,
	["summary"] = "A wide window with a title and close button.",
	["story"] = nil,
	["fusion"] = v2,
	["controls"] = v_u_4,
	["story"] = function(p6) -- name: story
		-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_4
		local v7 = v_u_5
		local v8 = {
			["scope"] = p6.scope:innerScope(v_u_3),
			["Parent"] = p6.target,
			["OnClickClose"] = function() -- name: OnClickClose
				-- upvalues: (ref) v_u_4
				v_u_4.Visible = false
			end
		}
		local v9 = {}
		local v10 = {
			["LayoutOrder"] = 1,
			["NextReset"] = nil,
			["List"] = nil,
			["Bonus"] = nil,
			["NextReset"] = os.time() + 1000
		}
		local v11 = {}
		local v12 = {
			["Title"] = "Main Quest 1",
			["Description"] = "Description for Main Quest 1",
			["IsCompleted"] = false,
			["IsClaimed"] = false,
			["Progress"] = nil,
			["LayoutOrder"] = 1,
			["Rewards"] = nil,
			["Progress"] = {
				["Current"] = 2,
				["Goal"] = 5
			},
			["Rewards"] = {
				["ZBucks"] = {
					["Amount"] = 100
				},
				["ClassXP"] = {
					["Amount"] = 50,
					["Type"] = "Assault"
				}
			}
		}
		v11.Quest1 = v12
		local v13 = {
			["Title"] = "Main Quest 2",
			["Description"] = "Description for Main Quest 2",
			["IsCompleted"] = false,
			["IsClaimed"] = false,
			["Progress"] = nil,
			["LayoutOrder"] = 2,
			["Rewards"] = nil,
			["Progress"] = {
				["Current"] = 0,
				["Goal"] = 1
			},
			["Rewards"] = {
				["ZBucks"] = {
					["Amount"] = 100
				},
				["ClassXP"] = {
					["Amount"] = 50,
					["Type"] = "Support"
				}
			}
		}
		v11.Quest2 = v13
		local v14 = {
			["Title"] = "Main Quest 3",
			["Description"] = "Description for Main Quest 3",
			["IsCompleted"] = false,
			["IsClaimed"] = false,
			["Progress"] = nil,
			["LayoutOrder"] = 2,
			["Rewards"] = nil,
			["Progress"] = {
				["Current"] = 4,
				["Goal"] = 5
			},
			["Rewards"] = {
				["ZBucks"] = {
					["Amount"] = 100
				},
				["ClassXP"] = {
					["Amount"] = 50,
					["Type"] = "Sniper"
				}
			}
		}
		v11.Quest3 = v14
		local v15 = {
			["Title"] = "Main Quest 4",
			["Description"] = "Description for Main Quest 4",
			["IsCompleted"] = true,
			["IsClaimed"] = false,
			["Progress"] = nil,
			["LayoutOrder"] = 2,
			["Rewards"] = nil,
			["Progress"] = {
				["Current"] = 5,
				["Goal"] = 5
			},
			["Rewards"] = {
				["ZBucks"] = {
					["Amount"] = 100
				},
				["ClassXP"] = {
					["Amount"] = 50,
					["Type"] = "Medic"
				}
			}
		}
		v11.Quest4 = v15
		local v16 = {
			["Title"] = "Main Quest 5",
			["Description"] = "Description for Main Quest 5",
			["IsCompleted"] = true,
			["IsClaimed"] = true,
			["Progress"] = nil,
			["LayoutOrder"] = 2,
			["Rewards"] = nil,
			["Progress"] = {
				["Current"] = 5,
				["Goal"] = 5
			},
			["Rewards"] = {
				["ZBucks"] = {
					["Amount"] = 100
				},
				["ClassXP"] = {
					["Amount"] = 50,
					["Type"] = "Medic"
				}
			}
		}
		v11.Quest5 = v16
		v10.List = v11
		local v17 = {
			["QuestsToComplete"] = 5,
			["QuestsCompleted"] = 0,
			["IsClaimed"] = false,
			["Rewards"] = nil,
			["Rewards"] = {
				["ZBucks"] = {
					["Amount"] = 500
				},
				["ClassXP"] = {
					["Amount"] = 250,
					["Type"] = "Medic"
				}
			}
		}
		v10.Bonus = v17
		v9.Daily = v10
		local v18 = {
			["LayoutOrder"] = 2,
			["NextReset"] = nil,
			["List"] = nil,
			["Bonus"] = nil,
			["NextReset"] = os.time() + 10000000
		}
		local v19 = {}
		local v20 = {
			["Title"] = "Main Quest 1",
			["Description"] = "Description for Main Quest 1",
			["IsCompleted"] = false,
			["IsClaimed"] = false,
			["Progress"] = nil,
			["LayoutOrder"] = 1,
			["Rewards"] = nil,
			["Progress"] = {
				["Current"] = 2,
				["Goal"] = 5
			},
			["Rewards"] = {
				["ZBucks"] = {
					["Amount"] = 100
				},
				["ClassXP"] = {
					["Amount"] = 50,
					["Type"] = "Medic"
				}
			}
		}
		v19.Quest1 = v20
		v18.List = v19
		local v21 = {
			["QuestsToComplete"] = 5,
			["QuestsCompleted"] = 0,
			["IsClaimed"] = false,
			["Rewards"] = nil,
			["Rewards"] = {
				["ZBucks"] = {
					["Amount"] = 500
				},
				["ClassXP"] = {
					["Amount"] = 250,
					["Type"] = "Medic"
				}
			}
		}
		v18.Bonus = v21
		v9.Weekly = v18
		v8.QuestCategories = v9
		return v7(v8)
	end
}