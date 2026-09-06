local u2 = require("../Shared/Util")
local NPCRegistry = require(game.ReplicatedStorage.common.NPCRegistry)
local u9 = {}
for i in NPCRegistry:GetAllNPCs() do
    table.insert(u9, i)
end
NPCRegistry.NPCAdded:Connect(function(p1) -- Line: 10 -- upvalues: u9 (val)
    table.insert(u9, p1.UID)
end)
NPCRegistry.NPCRemoved:Connect(function(p1) -- Line: 13 -- upvalues: u9 (val)
    table.remove(u9, table.find(u9, p1.UID))
end)
local u33 = {
    Transform = function(p1) -- Line: 18 -- upvalues: u2 (val), u9 (val)
        return u2.MakeFuzzyFinder(u9)(p1)
    end,
    Validate = function(p1) -- Line: 23
        local v1 = 0 < #p1
        return v1, "No NPC with that UID could be found."
    end,
    Autocomplete = function(p1) -- Line: 27 -- upvalues: u2 (val)
        return u2.GetNames(p1)
    end,
    Parse = function(p1) -- Line: 31 -- upvalues: NPCRegistry (val)
        return NPCRegistry:GetNPC(p1[1])
    end,
}
return function(p1) -- Line: 36 -- upvalues: u33 (val), u2 (val)
    p1:RegisterType("npc", u33)
    p1:RegisterType("npcs", u2.MakeListableType(u33))
end