local BadgeService = game:GetService("BadgeService")
local u7 = require("./EggData")
local RedEvents = game.ReplicatedStorage.common.RedEvents
local EggTouched = require(RedEvents.Events.EggTouched)
local EggCollected = require(RedEvents.Events.EggCollected)
local Players = game:GetService("Players")
local u25 = {}
local v1 = {}
u25.pendingEggs = v1
function u25.GetEligiblePlayers(p1, p2) -- Line: 12 -- upvalues: Players (val), BadgeService (val), u7 (val)
    local v1, v2
    local v3 = {}
    for i, j in Players:GetChildren() do
        v1, v2 = pcall(function() -- Line: 15 -- upvalues: BadgeService (upval), j (val), u7 (upval), p2 (val)
            return BadgeService:UserHasBadgeAsync(j.UserId, u7.EggConfigs[p2].BadgeId)
        end)
        if not v1 then
            warn("Error while checking if player has badge!")
            return
        end
        if not v2 then
            table.insert(v3, j)
        end
    end
    return v3
end
function u25.RegisterEggTouch(p1, p2, p3) -- Line: 32 -- upvalues: u25 (val), EggTouched (val)
    if p3 ~= "Master" then
        u25.chapterId = p3
    end
    local UserId = p2.UserId
    local v1 = u25.pendingEggs[p3]
    if not v1 then
        v1 = {}
    end
    u25.pendingEggs[p3] = v1
    if u25.pendingEggs[p3][UserId] then
        return
    end
    local v2 = u25.pendingEggs[p3]
    v2[UserId] = true
    print("Server: Player " .. p2.Name .. " collected egg for chapter " .. p3)
    EggTouched:FireClient(p2, p3)
end
function u25.OnChapterCompleted(p1, p2) -- Line: 46 -- upvalues: u25 (val), u7 (val), BadgeService (val)
    local Master, chapterId
    if u25.chapterId == nil then
        u25.chapterId = "Master"
    end
    chapterId = u25.chapterId
    local UserId = p2.UserId
    local function giveBadge(p1) -- Line: 53 -- upvalues: u25 (upval), UserId (val), u7 (upval), BadgeService (upval), p2 (val)
        local v1
        if not (u25.pendingEggs[p1]) then
            return
        end
        local v2 = u25.pendingEggs[p1]
        if not (v2[UserId]) then
            return
        end
        local v3 = u25.pendingEggs[p1]
        v3[UserId] = nil
        local u16 = u7.EggConfigs[p1]
        if not u16 or not u16.BadgeId then
            return
        end
        v2, v1 = pcall(function() -- Line: 58 -- upvalues: BadgeService (upval), p2 (upval), u16 (val)
            BadgeService:AwardBadge(p2.UserId, u16.BadgeId)
        end)
        if not v2 then
            warn("Server: Error awarding badge for chapter " .. p1 .. ": " .. tostring(v1))
            return
        end
        local v4 = tostring(u16.BadgeId)
        print("Server: Awarded badge " .. v4 .. " for chapter " .. p1 .. " to " .. p2.Name)
    end
    giveBadge(chapterId)
    if chapterId ~= "Master" then
        giveBadge("Master")
    end
end
EggCollected:SetServerListener(function(p1, p2) -- Line: 77 -- upvalues: u25 (val)
    u25:RegisterEggTouch(p1, p2)
end)
return u25