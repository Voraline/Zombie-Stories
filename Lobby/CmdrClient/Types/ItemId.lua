local u2 = require("../Shared/Util")
local ItemData = require(game.ReplicatedStorage.common:WaitForChild("ItemData"))
local u12 = {}
for k, v in pairs(ItemData.List) do
    table.insert(u12, v)
end
local u25 = {DisplayName = "Item name", Prefixes = "# integer"}

function u25.Transform(p1) -- Line: 12 -- upvalues: u2 (val), u12 (val)
    return u2.MakeFuzzyFinder(u12)(p1)
end

function u25.Validate(p1) -- Line: 17
    local v1 = 0 < #p1
    return v1, "No item with that name could be found."
end

function u25.Autocomplete(p1) -- Line: 21 -- upvalues: u2 (val)
    return u2.GetNames(p1)
end

function u25.Parse(p1) -- Line: 25
    return p1[1].Id
end

return function(p1) -- Line: 30 -- upvalues: u25 (val), u2 (val)
    local v1 = u25
    p1:RegisterType("itemId", v1)
    v1 = u2
    local MakeListableType = v1.MakeListableType
    local v2 = u25
    v1 = MakeListableType(v2, {Prefixes = "# integers"})
    p1:RegisterType("itemIds", v1)
end