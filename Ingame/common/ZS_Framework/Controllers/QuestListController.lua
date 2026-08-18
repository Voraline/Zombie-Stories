game:GetService("ReplicatedStorage")
game:GetService("Players")
local v1 = game:GetService("ReplicatedStorage").common.ZS_Framework
local v_u_2 = require(v1:WaitForChild("Data"):WaitForChild("PlayerDatabase"))
local v3 = require("@game/ReplicatedStorage/common/zap")
v3.InitQuests.On(function(p4)
	-- upvalues: (copy) v_u_2
	for v5, v6 in p4 do
		if v5 == "Daily" then
			v6.LayoutOrder = 1
		elseif v5 == "Weekly" then
			v6.LayoutOrder = 2
		elseif v5 == "Monthly" then
			v6.LayoutOrder = 3
		else
			v6.LayoutOrder = 100
		end
	end
	v_u_2.QuestList = p4
end)
v3.UpdateQuestCategory.On(function(p7)
	-- upvalues: (copy) v_u_2
	v_u_2.QuestList[p7.Category] = p7.Quests
	local v8 = p7.Category == "Daily" and 1 or (p7.Category == "Weekly" and 2 or (p7.Category == "Monthly" and 3 or 10))
	v_u_2.QuestList[p7.Category].LayoutOrder = v8
end)
v3.UpdateQuestProgress.On(function(p9)
	-- upvalues: (copy) v_u_2
	local v10 = v_u_2.QuestList[p9.Category]
	if v10 then
		local v11 = v10.List[p9.QuestKey]
		if v11 then
			v11.Progress.Current = p9.Progress
			if v11.Progress.Current >= v11.Progress.Goal then
				v11.IsCompleted = true
				v_u_2.Signals.BannerMessage:Fire(p9.Category .. " Quest Completed!", v11.Title, 1)
			end
		end
	else
		return
	end
end)
return {}