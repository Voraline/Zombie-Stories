local u2 = require("../Shared/Util")
local u3 = {
    Validate = function(p1) -- Line: 4
        local v1 = p1 ~= nil
        return v1
    end,
    Parse = function(p1) -- Line: 8
        return (tostring(p1))
    end,
}
local u6 = {
    Transform = function(p1) -- Line: 14
        return (tonumber(p1))
    end,
    Validate = function(p1) -- Line: 18
        local v1 = p1 ~= nil
        return v1
    end,
    Parse = function(p1) -- Line: 22
        return p1
    end,
}
local u10 = {
    Transform = function(p1) -- Line: 28
        return (tonumber(p1))
    end,
    Validate = function(p1) -- Line: 32
        local v1 = if p1 ~= nil then p1 == math.floor(p1) else false
        return v1, "Only whole numbers are valid."
    end,
    Parse = function(p1) -- Line: 36
        return p1
    end,
}
local u14 = {
    Transform = function(p1) -- Line: 42
        return (tonumber(p1))
    end,
    Validate = function(p1) -- Line: 46
        local v1 = if p1 ~= nil then if p1 == math.floor(p1) then 0 < p1 else false else false
        return v1, "Only positive whole numbers are valid."
    end,
    Parse = function(p1) -- Line: 50
        return p1
    end,
}
local u18 = {
    Transform = function(p1) -- Line: 56
        return (tonumber(p1))
    end,
    Validate = function(p1) -- Line: 60
        local v1 = if p1 ~= nil then if p1 == math.floor(p1) then 0 <= p1 else false else false
        return v1, "Only non-negative whole numbers are valid."
    end,
    Parse = function(p1) -- Line: 64
        return p1
    end,
}
local u22 = {
    Transform = function(p1) -- Line: 70
        return (tonumber(p1))
    end,
    Validate = function(p1) -- Line: 74
        local v1 = if p1 ~= nil then if p1 == math.floor(p1) then if 0 <= p1 then p1 <= 255 else false else false else false
        return v1, "Only bytes are valid."
    end,
    Parse = function(p1) -- Line: 78
        return p1
    end,
}
local u26 = {
    Transform = function(p1) -- Line: 84
        return (tonumber(p1))
    end,
    Validate = function(p1) -- Line: 88
        local v1 = if p1 ~= nil then if p1 == math.floor(p1) then if 0 <= p1 then p1 <= 9 else false else false else false
        return v1, "Only digits are valid."
    end,
    Parse = function(p1) -- Line: 92
        return p1
    end,
}
local u42 = u2.MakeDictionary({
    "true",
    "t",
    "yes",
    "y",
    "on",
    "enable",
    "enabled",
    "1",
    "+",
})
local u54 = u2.MakeDictionary({
    "false",
    "f",
    "no",
    "n",
    "off",
    "disable",
    "disabled",
    "0",
    "-",
})
local u59 = {
    Transform = function(p1) -- Line: 102
        return p1:lower()
    end,
    Validate = function(p1) -- Line: 106 -- upvalues: u42 (val), u54 (val)
        local v1 = if u42[p1] == nil then u54[p1] ~= nil else true
        return v1, "Please use true/yes/on or false/no/off."
    end,
    Parse = function(p1) -- Line: 110 -- upvalues: u42 (val), u54 (val)
        if u42[p1] then
            return true
        end
        if u54[p1] then
            return false
        end
        return nil
    end,
}
return function(p1) -- Line: 122 -- upvalues: u3 (val), u6 (val), u10 (val), u14 (val), u18 (val), u22 (val), u26 (val), u59 (ref), u2 (val)
    p1:RegisterType("string", u3)
    p1:RegisterType("number", u6)
    p1:RegisterType("integer", u10)
    p1:RegisterType("positiveInteger", u14)
    p1:RegisterType("nonNegativeInteger", u18)
    p1:RegisterType("byte", u22)
    p1:RegisterType("digit", u26)
    p1:RegisterType("boolean", u59)
    p1:RegisterType("strings", u2.MakeListableType(u3))
    p1:RegisterType("numbers", u2.MakeListableType(u6))
    p1:RegisterType("integers", u2.MakeListableType(u10))
    p1:RegisterType("positiveIntegers", u2.MakeListableType(u14))
    p1:RegisterType("nonNegativeIntegers", u2.MakeListableType(u18))
    p1:RegisterType("bytes", u2.MakeListableType(u22))
    p1:RegisterType("digits", u2.MakeListableType(u26))
    p1:RegisterType("booleans", u2.MakeListableType(u59))
end