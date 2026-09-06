local u2 = require("../Shared/Util")
local EnumItems = Enum.UserInputType:GetEnumItems()
for k, v in pairs(Enum.KeyCode:GetEnumItems()) do
    EnumItems[#EnumItems + 1] = v
end
local u22 = {
    Transform = function(p1) -- Line: 10 -- upvalues: u2 (val), EnumItems (val)
        return u2.MakeFuzzyFinder(EnumItems)(p1)
    end,
    Validate = function(p1) -- Line: 16
        local v1 = 0 < #p1
        return v1
    end,
    Autocomplete = function(p1) -- Line: 20 -- upvalues: u2 (val)
        return u2.GetNames(p1)
    end,
    Parse = function(p1) -- Line: 24
        return p1[1]
    end,
}
return function(p1) -- Line: 29 -- upvalues: u22 (val), u2 (val)
    p1:RegisterType("userInput", u22)
    p1:RegisterType("userInputs", u2.MakeListableType(u22))
end