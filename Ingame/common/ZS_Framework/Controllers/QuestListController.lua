game:GetService("ReplicatedStorage")
game:GetService("Players")
local ZS_Framework = (game:GetService("ReplicatedStorage")).common.ZS_Framework
local PlayerDatabase = require((ZS_Framework:WaitForChild("Data")):WaitForChild("PlayerDatabase"))
local v1 = require("@game/ReplicatedStorage/common/zap")
v1.InitQuests.On(function(p1) -- Line: 12 -- upvalues: PlayerDatabase (val)
    local v1 = p1
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if i == "Daily" then
            j.LayoutOrder = 1
        elseif i == "Weekly" then
            j.LayoutOrder = 2
        elseif i ~= "Monthly" then
            j.LayoutOrder = 100
        else
            j.LayoutOrder = 3
        end
    end
    PlayerDatabase.QuestList = p1
end)
v1.UpdateQuestCategory.On(function(p1) -- Line: 30 -- upvalues: PlayerDatabase (val)
    PlayerDatabase.QuestList[p1.Category] = p1.Quests
    local v1 = 10
    if p1.Category == "Daily" then
        v1 = 1
    elseif p1.Category == "Weekly" then
        v1 = 2
    elseif p1.Category == "Monthly" then
        v1 = 3
    end
    PlayerDatabase.QuestList[p1.Category].LayoutOrder = v1
end)
v1.UpdateQuestProgress.On(function(p1) -- Line: 45 -- upvalues: PlayerDatabase (val)
    local v1 = PlayerDatabase.QuestList[p1.Category]
    if not v1 then
        return
    end
    local v2 = v1.List[p1.QuestKey]
    if not v2 then
        return
    end
    v2.Progress.Current = p1.Progress
    local Current = v2.Progress.Current
    if v2.Progress.Goal <= Current then
        v2.IsCompleted = true
        local v3 = PlayerDatabase
        local BannerMessage = v3.Signals.BannerMessage
        local v4 = p1.Category .. " Quest Completed!"
        local Title = v2.Title
        BannerMessage:Fire(v4, Title, 1)
    end
end)
return {}