local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v3 = v1.Packages
local v_u_4 = require(v3.Fusion).Children
local v_u_5 = require("./SkillsUI/SkillsUI")
return function(p_u_6)
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_5
	local v7 = p_u_6.scope
	local v9 = v7:Computed(function(p8)
		-- upvalues: (copy) p_u_6
		return p8(p_u_6.SelectedSkillId) ~= nil
	end)
	local v10 = v7:New("ScreenGui")
	local v11 = {
		["Name"] = "SkillTreeGui",
		["Parent"] = v_u_2.LocalPlayer:WaitForChild("PlayerGui"),
		["ResetOnSpawn"] = false,
		["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
		[v_u_4] = { v_u_5({
				["scope"] = v7,
				["Visible"] = v9,
				["SelectedSkillId"] = p_u_6.SelectedSkillId,
				["CurrentRank"] = p_u_6.CurrentRank,
				["OnBuy"] = p_u_6.OnBuy,
				["OnExit"] = p_u_6.OnExit
			}) }
	}
	return v10(v11)
end