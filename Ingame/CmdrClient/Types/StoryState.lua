if not (workspace.Values:FindFirstChild("IsLobby")) then
    local StoryData
    local u16 = require("../Shared/Util")
    local u21 = {}
    local u22 = {}
    local StateListEvent = require(game.ReplicatedStorage.common.RedEvents.Story.StateListEvent)
    if not (game:GetService("RunService"):IsServer()) then
        StateListEvent:SetClientListener(function(p1) -- Line: 48 -- upvalues: u22 (ref)
            u22 = p1
        end)
        StateListEvent:FireServer()
    else
        StoryData = game.ReplicatedStorage.common:FindFirstChild("StoryData")
        local function updateStateList() -- Line: 18 -- upvalues: StoryData (ref), u22 (ref), StateListEvent (val)
            local StateModules = require(StoryData).StateModules
            local v1 = {}
            u22 = v1
            if StateModules then
                v1 = StateModules
                local v2 = nil
                local v3 = nil
                for i, j in v1, v2, v3 do
                    u22[i] = j.Name
                end
            end
            StateListEvent:FireAllClients(u22)
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
            if not (u21[p1]) then
                StateListEvent:FireClient(p1, u22)
                u21[p1] = true
            end
        end)
    end
    StoryData = {
        DisplayName = "Story state",
        Prefixes = "",
        Transform = function(p1) -- Line: 59 -- upvalues: u16 (val), u22 (ref)
            local v1 = u16.MakeFuzzyFinder(u22)(p1)
            if #v1 ~= 0 then
                return v1
            end
            local v2 = u22[tonumber(p1)]
            return {v2}
        end,
        Validate = function(p1) -- Line: 70
            local v1 = 0 < #p1
            return v1, "No state with that identifier exists."
        end,
        Autocomplete = function(p1) -- Line: 74 -- upvalues: u16 (val)
            return u16.GetNames(p1)
        end,
        Parse = function(p1) -- Line: 78 -- upvalues: u22 (ref)
            local v1 = p1[1]
            local v2 = tonumber(v1)
            if v2 then
                return u22[v2]
            end
            return v1
        end,
    }
    return function(p1) -- Line: 89 -- upvalues: StoryData (val)
        p1:RegisterType("storyState", StoryData)
    end
elseif workspace.Values.IsLobby.Value then
    return function() end
end