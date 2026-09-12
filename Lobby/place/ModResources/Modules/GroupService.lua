local u0 = {}
local GroupService = game:GetService("GroupService")

local function PagesToArray(p1) -- Line: 9
    local CurrentPage, CurrentPage_2, v1
    local v2 = {}
    local v3 = p1
    while true do
        v1 = next
        CurrentPage, CurrentPage_2 = v3:GetCurrentPage()
        for k, v in v1, CurrentPage, CurrentPage_2 do
            v2[#v2 + 1] = v
        end
        if v3.IsFinished then
            break
        end
        pcall(v3.AdvanceToNextPageAsync, v3)
    end
end

function u0.GetRankInGroupAsync(p1, p2, p3) -- Line: 18 -- upvalues: u0 (val)
    local v1
    local GroupsAsync = u0:GetGroupsAsync(p2)
    local v2 = #GroupsAsync
    for i = 1, v2 do
        v1 = GroupsAsync[i]
        if v1.Id == p3 then
            return v1.Rank
        end
    end
    return 0
end

function u0.GetRoleInGroupAsync(p1, p2, p3) -- Line: 29 -- upvalues: u0 (val)
    local v1
    local GroupsAsync = u0:GetGroupsAsync(p2)
    local v2 = #GroupsAsync
    for i = 1, v2 do
        v1 = GroupsAsync[i]
        if v1.Id == p3 then
            return v1.Role
        end
    end
    return "Guest"
end

function u0.GetPrimaryGroupAsync(p1, p2) -- Line: 40 -- upvalues: u0 (val)
    local v1
    local GroupsAsync = u0:GetGroupsAsync(p2)
    local v2 = #GroupsAsync
    for i = 1, v2 do
        v1 = GroupsAsync[i]
        if v1.IsPrimary then
            return v1
        end
    end
    return nil
end

function u0.IsInGroupAsync(p1, p2, p3) -- Line: 51 -- upvalues: u0 (val)
    local GroupsAsync = u0:GetGroupsAsync(p2)
    local v1 = #GroupsAsync
    for i = 1, v1 do
        if GroupsAsync[i].Id == p3 then
            return true
        end
    end
    return false
end

function u0.IsPrimaryGroupAsync(p1, p2) -- Line: 61 -- upvalues: u0 (val)
    local GroupsAsync = u0:GetGroupsAsync(p2)
    local v1 = #GroupsAsync
    for i = 1, v1 do
        if GroupsAsync[i].IsPrimary then
            return true
        end
    end
    return false
end

function u0.IsGroupAlly(p1, p2, p3) -- Line: 71 -- upvalues: u0 (val)
    local GroupAlliesAsync = u0:GetGroupAlliesAsync(p2)
    local v1 = #GroupAlliesAsync
    for i = 1, v1 do
        if GroupAlliesAsync[i].Id == p3 then
            return true
        end
    end
    return false
end

function u0.IsGroupEnemy(p1, p2, p3) -- Line: 81 -- upvalues: u0 (val)
    local GroupEnemiesAsync = u0:GetGroupEnemiesAsync(p2)
    local v1 = #GroupEnemiesAsync
    for i = 1, v1 do
        if GroupEnemiesAsync[i].Id == p3 then
            return true
        end
    end
    return false
end

function u0.GetGroupAlliesAsync(p1, p2) -- Line: 91 -- upvalues: GroupService (val), PagesToArray (val)
    local success, result = pcall(GroupService.GetAlliesAsync, GroupService, p2)
    local v1 = success
    if v1 then
        v1 = result
        if v1 then
            v1 = PagesToArray(result)
        end
    end
    return v1
end

function u0.GetEnemiesAsync(p1, p2) -- Line: 97 -- upvalues: GroupService (val), PagesToArray (val)
    local success, result = pcall(GroupService.GetEnemiesAsync, GroupService, p2)
    local v1 = success
    if v1 then
        v1 = result
        if v1 then
            v1 = PagesToArray(result)
        end
    end
    return v1
end

function u0.GetGroupsAsync(p1, p2) -- Line: 103 -- upvalues: GroupService (val)
    local success, result = pcall(GroupService.GetGroupsAsync, GroupService, p2.UserId)
    local v1 = success and result or {}
    return v1
end

function u0.GetGroupInfoAsync(p1, p2) -- Line: 108 -- upvalues: GroupService (val)
    local success, result = pcall(GroupService.GetGroupInfoAsync, GroupService, p2)
    local v1 = success and result or {}
    return v1
end

return u0