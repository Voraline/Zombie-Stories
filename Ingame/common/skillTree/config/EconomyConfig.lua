local v_u_6 = {
	["HEARTBEAT_INTERVAL"] = 60,
	["MAX_SCORE_PER_INTERVAL"] = 100,
	["SP_XP_PER_MAX_SCORE"] = 50,
	["SP_XP_PER_SP"] = 600,
	["BASE_SP_CAP"] = 20,
	["BASE_DAILY_EARN_CAP"] = 5,
	["DAILY_QUEST_SP"] = 1,
	["DAILY_QUESTS_WITH_SP"] = 2,
	["WEEKLY_QUEST_SP"] = 1,
	["WEEKLY_QUESTS_WITH_SP"] = 1,
	["XP_BOOST_PER_PRESTIGE"] = 0.03,
	["MAX_XP_BOOST"] = 0.25,
	["RESPEC_ZBUCKS_COST"] = 500,
	["SKILL_TREE_VERSION"] = 1,
	["IS_BETA"] = true,
	["getPrestigeStats"] = function(p1) -- name: getPrestigeStats
		-- upvalues: (copy) v_u_6
		local v2 = v_u_6.BASE_SP_CAP
		local v3 = v_u_6.BASE_DAILY_EARN_CAP
		for v4 = 1, p1 do
			if v4 <= 5 then
				v2 = v2 + 2
				v3 = v3 + 1
			elseif v4 <= 15 then
				v2 = v2 + 4
			else
				v2 = v2 + 2
				v3 = v3 + 1
			end
		end
		return {
			["spCap"] = v2,
			["dailyEarnCap"] = math.max(v3, 10)
		}
	end,
	["getPrestigeZBucksCost"] = function(p5) -- name: getPrestigeZBucksCost
		return p5 * 500 + 1000
	end
}
return v_u_6