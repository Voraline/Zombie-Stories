local u2 = require("../Shared/Util")
local EnumItems = Enum.UserInputType:GetEnumItems()
for k, v in pairs(Enum.KeyCode:GetEnumItems()) do
    EnumItems[#EnumItems + 1] = v
end
local u22 = {}

function u22.Transform(p1) -- Line: 10 -- upvalues: u2 (val), EnumItems (val)
    return u2.MakeFuzzyFinder(EnumItems)(p1)
end

function u22.Validate(p1) -- Line: 16
    local v1 = 0 < #p1
    return v1
end

function u22.Autocomplete(p1) -- Line: 20 -- upvalues: u2 (val)
    return u2.GetNames(p1)
end

function u22.Parse(p1) -- Line: 24
    return p1[1]
end

return function(p1) -- Line: 29 -- upvalues: u22 (val), u2 (val)
    local v1 = u22
    p1:RegisterType("userInput", v1)
    v1 = u2
    local MakeListableType = v1.MakeListableType
    local v2 = u22
    v1 = MakeListableType(v2)
    p1:RegisterType("userInputs", v1)
end