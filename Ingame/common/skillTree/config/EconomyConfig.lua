local u0 = {
    HEARTBEAT_INTERVAL = 60,
    MAX_SCORE_PER_INTERVAL = 100,
    SP_XP_PER_MAX_SCORE = 50,
    SP_XP_PER_SP = 600,
    BASE_SP_CAP = 20,
    BASE_DAILY_EARN_CAP = 5,
    DAILY_QUEST_SP = 1,
    DAILY_QUESTS_WITH_SP = 2,
    WEEKLY_QUEST_SP = 1,
    WEEKLY_QUESTS_WITH_SP = 1,
    XP_BOOST_PER_PRESTIGE = 0.03,
    MAX_XP_BOOST = 0.25,
    RESPEC_ZBUCKS_COST = 500,
    SKILL_TREE_VERSION = 1,
    IS_BETA = true,
}

function u0.getPrestigeStats(p1) -- Line: 51 -- upvalues: u0 (val)
    local BASE_SP_CAP = u0.BASE_SP_CAP
    local BASE_DAILY_EARN_CAP = u0.BASE_DAILY_EARN_CAP
    local v1 = p1
    for i = 1, v1 do
        if i <= 5 or not (i <= 15) then
            BASE_SP_CAP = BASE_SP_CAP + 2
            BASE_DAILY_EARN_CAP = BASE_DAILY_EARN_CAP + 1
        else
            BASE_SP_CAP = BASE_SP_CAP + 4
        end
    end
    return {spCap = BASE_SP_CAP, dailyEarnCap = math.max(BASE_DAILY_EARN_CAP, 10)}
end

function u0.getPrestigeZBucksCost(p1) -- Line: 78
    return p1 * 500 + 1000
end

return u0