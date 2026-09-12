if workspace.Values:FindFirstChild("IsLobby") and workspace.Values.IsLobby.Value then
    return function() end
end
local common = game.ReplicatedStorage.common
local u16 = require("../Shared/Util")
local RedEvents = game.ReplicatedStorage.common.RedEvents
local u21 = {}
local u22 = {}
local StateListEvent = require(RedEvents.Story.StateListEvent)
if not game:GetService("RunService"):IsServer() then
    StateListEvent:SetClientListener(function(p1) -- Line: 48 -- upvalues: u22 (ref)
        u22 = p1
    end)
    StateListEvent:FireServer()
else
    local StoryData = game.ServerStorage.chapter:FindFirstChild("StoryData")

    local function updateStateList() -- Line: 18 -- upvalues: StoryData (ref), u22 (ref), StateListEvent (val)
        local v1
        local StateModules = require(StoryData).StateModules
        local v2 = {}
        u22 = v2
        if StateModules then
            v2 = StateModules
            local v3 = nil
            v1 = nil
            for i, j in v2, v3, v1 do
                u22[i] = j.Name
            end
        end
        v2 = StateListEvent
        v1 = u22
        v2:FireAllClients(v1)
    end

    if not StoryData then
        game.ServerStorage.ChildAdded:Connect(function(p1) -- Line: 33 -- upvalues: StoryData (ref), updateStateList (val)
            if p1.Name == "StoryData" then
                StoryData = p1
                updateStateList()
            end
        end)
    else
        updateStateList()
    end
    StateListEvent:SetServerListener(function(p1) -- Line: 41 -- upvalues: u21 (val), StateListEvent (val), u22 (ref)
        if not u21[p1] then
            local v1 = StateListEvent
            local v2 = u22
            v1:FireClient(p1, v2)
            u21[p1] = true
        end
    end)
end
local u66 = {DisplayName = "Story state", Prefixes = ""}

function u66.Transform(p1) -- Line: 59 -- upvalues: u16 (val), u22 (ref)
    local v1 = u16.MakeFuzzyFinder(u22)(p1)
    if #v1 == 0 then
        return {u22[tonumber(p1)]}
    end
    return v1
end

function u66.Validate(p1) -- Line: 70
    local v1 = 0 < #p1
    return v1, "No state with that identifier exists."
end

function u66.Autocomplete(p1) -- Line: 74 -- upvalues: u16 (val)
    return u16.GetNames(p1)
end

function u66.Parse(p1) -- Line: 78 -- upvalues: u22 (ref)
    local v1 = p1[1]
    local v2 = tonumber(v1)
    if v2 then
        return u22[v2]
    end
    return v1
end

return function(p1) -- Line: 89 -- upvalues: u66 (val)
    local v1 = u66
    p1:RegisterType("storyState", v1)
end