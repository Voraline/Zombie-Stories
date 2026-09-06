local u2 = require("../Shared/Util")
local ItemData = require(game.ReplicatedStorage.common:WaitForChild("ItemData"))
local u12 = {}
for k, v in pairs(ItemData.List) do
    table.insert(u12, v)
end
local u25 = {
    DisplayName = "Item name",
    Prefixes = "# integer",
    Transform = function(p1) -- Line: 12 -- upvalues: u2 (val), u12 (val)
        return u2.MakeFuzzyFinder(u12)(p1)
    end,
    Validate = function(p1) -- Line: 17
        local v1 = 0 < #p1
        return v1, "No item with that name could be found."
    end,
    Autocomplete = function(p1) -- Line: 21 -- upvalues: u2 (val)
        return u2.GetNames(p1)
    end,
    Parse = function(p1) -- Line: 25
        return p1[1].Id
    end,
}
return function(p1) -- Line: 30 -- upvalues: u25 (val), u2 (val)
    p1:RegisterType("itemId", u25)
    p1:RegisterType("itemIds", u2.MakeListableType(u25, {Prefixes = "# integers"}))
end