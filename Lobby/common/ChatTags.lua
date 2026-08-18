game:GetService("Players")
game:GetService("GamePassService")
local v_u_1 = game:GetService("BadgeService")
game:GetService("GroupService")
local v7 = {
	{
		["Condition"] = nil,
		["Priority"] = 1,
		["TagText"] = "[DEV]",
		["TagColor"] = nil,
		["NameColor"] = nil,
		["ChatColor"] = nil,
		["Condition"] = function(p2) -- name: Condition
			return p2:GetRankInGroup(3532462) >= 251
		end,
		["TagColor"] = Color3.fromRGB(146, 43, 255),
		["NameColor"] = Color3.fromRGB(146, 43, 255),
		["ChatColor"] = Color3.fromRGB(102, 247, 255)
	},
	{
		["Condition"] = nil,
		["Priority"] = 2,
		["TagText"] = "[MOD*]",
		["TagColor"] = nil,
		["NameColor"] = nil,
		["ChatColor"] = nil,
		["Condition"] = function(p3) -- name: Condition
			return p3:GetRankInGroup(3532462) == 201
		end,
		["TagColor"] = Color3.fromRGB(140, 77, 255),
		["NameColor"] = Color3.fromRGB(140, 77, 255),
		["ChatColor"] = Color3.fromRGB(193, 145, 255)
	},
	{
		["Condition"] = nil,
		["Priority"] = 3,
		["TagText"] = "[MOD]",
		["TagColor"] = nil,
		["NameColor"] = nil,
		["ChatColor"] = nil,
		["Condition"] = function(p4) -- name: Condition
			return p4:GetRankInGroup(3532462) == 200
		end,
		["TagColor"] = Color3.fromRGB(255, 0, 0),
		["NameColor"] = Color3.fromRGB(255, 181, 181),
		["ChatColor"] = Color3.fromRGB(255, 181, 181)
	},
	{
		["Condition"] = nil,
		["Priority"] = 4,
		["TagText"] = "[CONTR.]",
		["TagColor"] = nil,
		["NameColor"] = nil,
		["ChatColor"] = nil,
		["Condition"] = function(p5) -- name: Condition
			return p5:GetRankInGroup(3532462) == 3
		end,
		["TagColor"] = Color3.fromRGB(255, 44, 227),
		["NameColor"] = Color3.fromRGB(255, 73, 237),
		["ChatColor"] = Color3.fromRGB(255, 143, 229)
	},
	{
		["Condition"] = nil,
		["Priority"] = 5,
		["TagText"] = "[\206\177]",
		["TagColor"] = nil,
		["Condition"] = function(p6) -- name: Condition
			-- upvalues: (copy) v_u_1
			return v_u_1:UserHasBadgeAsync(p6.UserId, 2124478718)
		end,
		["TagColor"] = Color3.fromRGB(199, 252, 255)
	}
}
table.sort(v7, function(p8, p9)
	return p8.Priority < p9.Priority
end)
return v7