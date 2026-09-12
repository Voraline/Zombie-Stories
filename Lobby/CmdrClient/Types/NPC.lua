local u2 = require("../Shared/Util")
local common = game.ReplicatedStorage.common
local NPCRegistry = require(common.NPCRegistry)
local u9 = {}
for i in NPCRegistry:GetAllNPCs() do
    table.insert(u9, i)
end
NPCRegistry.NPCAdded:Connect(function(p1) -- Line: 10 -- upvalues: u9 (val)
    local v1 = u9
    local UID = p1.UID
    table.insert(v1, UID)
end)
NPCRegistry.NPCRemoved:Connect(function(p1) -- Line: 13 -- upvalues: u9 (val)
    table.remove(u9, table.find(u9, p1.UID))
end)
local u33 = {}

function u33.Transform(p1) -- Line: 18 -- upvalues: u2 (val), u9 (val)
    return u2.MakeFuzzyFinder(u9)(p1)
end

function u33.Validate(p1) -- Line: 23
    local v1 = 0 < #p1
    return v1, "No NPC with that UID could be found."
end

function u33.Autocomplete(p1) -- Line: 27 -- upvalues: u2 (val)
    return u2.GetNames(p1)
end

function u33.Parse(p1) -- Line: 31 -- upvalues: NPCRegistry (val)
    local v1 = NPCRegistry
    local v2 = p1[1]
    return v1:GetNPC(v2)
end

return function(p1) -- Line: 36 -- upvalues: u33 (val), u2 (val)
    local v1 = u33
    p1:RegisterType("npc", v1)
    v1 = u2
    local MakeListableType = v1.MakeListableType
    local v2 = u33
    v1 = MakeListableType(v2)
    p1:RegisterType("npcs", v1)
end