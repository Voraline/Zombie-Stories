game:GetService("ReplicatedStorage")
local u5 = {}
local u6 = {}
local u7 = {}

local function shallowCopy(p1) -- Line: 8
    local v1 = {}
    for i, v in ipairs(p1) do
        v1[i] = v
    end
    return v1
end

local function registerEventModule(p1) -- Line: 16 -- upvalues: u6 (val), u7 (val)
    if p1 and p1:IsA("ModuleScript") then
        local success, result = pcall(require, p1)
        if not success then
            warn(string.format("[EventData] Failed to require event module %s: %s", p1:GetFullName(), (tostring(result))))
            return
        end
        if type(result) ~= "table" then
            warn(string.format("[EventData] Event module %s did not return a table", p1:GetFullName()))
            return
        end
        local Id = result.Id
        if not Id then
            Id = result.id
            if not Id then
                Id = p1.Name
            end
        end
        if not Id then
            warn(string.format("[EventData] Event module %s is missing an Id field", p1:GetFullName()))
            return
        end
        result.Id = Id
        u6[Id] = result
        local DataStoreKey = result.DataStoreKey
        if not DataStoreKey then
            DataStoreKey = result.datastoreKey
            if not DataStoreKey then
                DataStoreKey = Id
            end
        end
        result.DataStoreKey = DataStoreKey
        u7[DataStoreKey] = result
        return
    end
end

for i, v in ipairs(script:GetChildren()) do
    registerEventModule(v)
end
local u25 = {}

function u5.GetEvent(p1) -- Line: 58 -- upvalues: u6 (val)
    if not p1 then
        return nil
    end
    return u6[p1]
end

function u5.GetEventByDataStoreKey(p1) -- Line: 65 -- upvalues: u7 (val)
    if not p1 then
        return nil
    end
    return u7[p1]
end

function u5.GetRegisteredEventIds() -- Line: 72 -- upvalues: u6 (val)
    local v1 = {}
    for k in pairs(u6) do
        table.insert(v1, k)
    end
    table.sort(v1)
    return v1
end

function u5.SetActiveEventIds(p1) -- Line: 81 -- upvalues: u25 (ref)
    local v1 = p1 or {}
    local v2 = {}
    for i, v in ipairs(v1) do
        v2[i] = v
    end
    u25 = v2
end

function u5.GetActiveEventIds() -- Line: 85 -- upvalues: u25 (ref)
    local v1 = u25
    local v2 = {}
    for i, v in ipairs(v1) do
        v2[i] = v
    end
    return v2
end

function u5.GetActiveEvents() -- Line: 89 -- upvalues: u25 (ref), u5 (val)
    local v1
    local v2 = {}
    for i, v in ipairs(u25) do
        v1 = u5.GetEvent(v)
        if not v1 then
            warn(string.format("[EventData] Active event %s has no registered configuration", (tostring(v))))
        else
            table.insert(v2, v1)
        end
    end
    return v2
end

local function createDefaultRewardState(p1) -- Line: 102
    local v1 = {}
    if p1 then
        local Rewards = p1.Rewards
        if type(Rewards) == "table" then
            local RewardId
            for i, v in ipairs(p1.Rewards) do
                RewardId = v.RewardId
                if not RewardId then
                    RewardId = v.Id
                end
                if RewardId then
                    v1[RewardId] = {rewarded = false, count = 0}
                end
            end
            return v1
        end
    end
    return v1
end

function u5.BuildDefaultAwardsForEvent(p1) -- Line: 121 -- upvalues: u5 (val), createDefaultRewardState (val)
    local v1 = u5.GetEvent(p1)
    if not v1 then
        return {}
    end
    return (createDefaultRewardState(v1))
end

function u5.BuildDefaultAwardsForActiveEvents() -- Line: 129 -- upvalues: u5 (val), createDefaultRewardState (val)
    local v1 = {}
    for i, v in ipairs(u5.GetActiveEvents()) do
        v1[v.DataStoreKey] = (createDefaultRewardState(v))
    end
    return v1
end

function u5.EnsureEventDataForEvent(p1, p2) -- Line: 137 -- upvalues: u5 (val), createDefaultRewardState (val)
    local v1, v2
    if type(p1) ~= "table" then
        return nil
    end
    local v3 = u5.GetEvent(p2)
    if not v3 then
        return nil
    end
    local Stats = p1.Stats
    if not Stats then
        Stats = {}
    end
    p1.Stats = Stats
    local Stats_2 = p1.Stats
    local UniqueAwards = p1.Stats.UniqueAwards
    if not UniqueAwards then
        UniqueAwards = {}
    end
    Stats_2.UniqueAwards = UniqueAwards
    local UniqueAwards_2 = p1.Stats.UniqueAwards
    local DataStoreKey = v3.DataStoreKey
    local v4 = UniqueAwards_2[DataStoreKey]
    if type(v4) ~= "table" then
        v4 = {}
        UniqueAwards_2[DataStoreKey] = v4
    end
    for k, v in pairs((createDefaultRewardState(v3))) do
        v1 = v4[k]
        if type(v1) == "table" then
            if v1.count == nil then
                v1.count = v.count
            end
            if v1.rewarded == nil then
                v1.rewarded = v.rewarded
            end
        else
            v2 = {rewarded = v.rewarded, count = v.count}
            v4[k] = v2
        end
    end
    return v4
end

function u5.EnsureEventDataTables(p1) -- Line: 177 -- upvalues: u5 (val)
    if type(p1) ~= "table" then
        return
    end
    local Stats = p1.Stats
    if not Stats then
        Stats = {}
    end
    p1.Stats = Stats
    local Stats_2 = p1.Stats
    local UniqueAwards = p1.Stats.UniqueAwards
    if not UniqueAwards then
        UniqueAwards = {}
    end
    Stats_2.UniqueAwards = UniqueAwards
    for i, v in ipairs(u5.GetActiveEvents()) do
        u5.EnsureEventDataForEvent(p1, v.Id)
    end
end

function u5.RegisterEventModule(p1) -- Line: 190 -- upvalues: registerEventModule (val)
    registerEventModule(p1)
end

if #u25 == 0 then
    u5.SetActiveEventIds({"CHRISTMAS2025"})
end
return u5