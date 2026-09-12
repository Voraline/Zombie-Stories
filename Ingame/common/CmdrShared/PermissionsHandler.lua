local u0 = {}
local u8 = game:GetService("RunService"):IsStudio()
local u12 = game.GameId == 1970013852
local u13 = {AlexRouger = 100, ExpressSurvival = 100, Huskrri = 100, Seanjacksepticeyem = 100}
local u14 = {
    DefaultAdmin = 201,
    DefaultDebug = 250,
    DefaultUtil = 200,
    UserAlias = 200,
    Ingame = 250,
    Items = 250,
    Lobby = 250,
    Moderation = 200,
    Announcements = 201,
    EventManager = 100,
    Progression = 250,
    Debug = 250,
    Help = 0,
}
local u15 = {}

function u0.GetRank(p1, p2) -- Line: 34 -- upvalues: u15 (val), u13 (val)
    if not u15[p2] then
        local v1 = u15
        local RankInGroup = u13[p2.Name]
        if not RankInGroup then
            RankInGroup = p2:GetRankInGroup(3532462)
        end
        v1[p2] = RankInGroup
    end
    return u15[p2]
end

function u0.GetRequiredRank(p1, p2) -- Line: 43 -- upvalues: u14 (val)
    return u14[p2] or 254
end

function u0.HasCommand(p1, p2, p3) -- Line: 49 -- upvalues: u0 (val), u8 (val), u12 (val)
    local v1 = true
    local Rank = u0:GetRank(p2)
    if not (u0:GetRequiredRank(p3) <= Rank) then
        v1 = u8
        if not v1 then
            v1 = u12
        end
    end
    return v1
end

return u0