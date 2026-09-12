local BadgeService = game:GetService("BadgeService")
local u7 = require("./EggData")
local RedEvents = game.ReplicatedStorage.common.RedEvents
local EggTouched = require(RedEvents.Events.EggTouched)
local EggCollected = require(RedEvents.Events.EggCollected)
local Players = game:GetService("Players")
local u25 = {pendingEggs = {}}

function u25.GetEligiblePlayers(p1, p2) -- Line: 12 -- upvalues: Players (val), BadgeService (val), u7 (val)
    local result, success
    local v1 = {}
    for i, j in Players:GetChildren() do
        success, result = pcall(function() -- Line: 15 -- upvalues: BadgeService (upval), j (val), u7 (upval), p2 (val)
            local v1 = BadgeService
            local v2 = j
            local UserId = v2.UserId
            local v3 = u7
            local EggConfigs = v3.EggConfigs
            local v4 = p2
            local BadgeId = EggConfigs[v4].BadgeId
            return v1:UserHasBadgeAsync(UserId, BadgeId)
        end)
        if not success then
            warn("Error while checking if player has badge!")
            return
        end
        if not result then
            table.insert(v1, j)
        end
    end
    return v1
end

function u25.RegisterEggTouch(p1, p2, p3) -- Line: 32 -- upvalues: u25 (val), EggTouched (val)
    if p3 ~= "Master" then
        u25.chapterId = p3
    end
    local UserId = p2.UserId
    local pendingEggs = u25.pendingEggs
    local v1 = u25.pendingEggs[p3]
    if not v1 then
        v1 = {}
    end
    pendingEggs[p3] = v1
    if u25.pendingEggs[p3][UserId] then
        return
    end
    local v2 = u25.pendingEggs[p3]
    v2[UserId] = true
    print("Server: Player " .. p2.Name .. " collected egg for chapter " .. p3)
    EggTouched:FireClient(p2, p3)
end

function u25.OnChapterCompleted(p1, p2) -- Line: 46 -- upvalues: u25 (val), u7 (val), BadgeService (val)
    if u25.chapterId == nil then
        u25.chapterId = "Master"
    end
    local chapterId = u25.chapterId
    local UserId = p2.UserId

    local function giveBadge(p1) -- Line: 53
        -- upvalues: u25 (upval), UserId (val), u7 (upval), BadgeService (upval), p2 (val)
        if u25.pendingEggs[p1] and u25.pendingEggs[p1][UserId] then
            local v1 = u25.pendingEggs[p1]
            v1[UserId] = nil
            local u16 = u7.EggConfigs[p1]
            if u16 and u16.BadgeId then
                local success, result = pcall(function() -- Line: 58 -- upvalues: BadgeService (upval), p2 (upval), u16 (val)
                    local v1 = BadgeService
                    local v2 = p2
                    local UserId = v2.UserId
                    local v3 = u16
                    local BadgeId = v3.BadgeId
                    v1:AwardBadge(UserId, BadgeId)
                end)
                if success then
                    local v2 = print
                    local BadgeId = u16.BadgeId
                    v2("Server: Awarded badge " .. (tostring(BadgeId)) .. " for chapter " .. p1 .. " to " .. p2.Name)
                    return
                end
                warn("Server: Error awarding badge for chapter " .. p1 .. ": " .. tostring(result))
            end
        end
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