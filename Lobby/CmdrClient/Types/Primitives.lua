local u2 = require("../Shared/Util")
local u3 = {}

function u3.Validate(p1) -- Line: 4
    local v1 = p1 ~= nil
    return v1
end

function u3.Parse(p1) -- Line: 8
    return (tostring(p1))
end

local u6 = {}

function u6.Transform(p1) -- Line: 14
    return (tonumber(p1))
end

function u6.Validate(p1) -- Line: 18
    local v1 = p1 ~= nil
    return v1
end

function u6.Parse(p1) -- Line: 22
    return p1
end

local u10 = {}

function u10.Transform(p1) -- Line: 28
    return (tonumber(p1))
end

function u10.Validate(p1) -- Line: 32
    local v1 = false
    if p1 ~= nil then
        v1 = p1 == math.floor(p1)
    end
    return v1, "Only whole numbers are valid."
end

function u10.Parse(p1) -- Line: 36
    return p1
end

local u14 = {}

function u14.Transform(p1) -- Line: 42
    return (tonumber(p1))
end

function u14.Validate(p1) -- Line: 46
    local v1 = false
    if p1 ~= nil then
        v1 = false
        if p1 == math.floor(p1) then
            v1 = 0 < p1
        end
    end
    return v1, "Only positive whole numbers are valid."
end

function u14.Parse(p1) -- Line: 50
    return p1
end

local u18 = {}

function u18.Transform(p1) -- Line: 56
    return (tonumber(p1))
end

function u18.Validate(p1) -- Line: 60
    local v1 = false
    if p1 ~= nil then
        v1 = false
        if p1 == math.floor(p1) then
            v1 = 0 <= p1
        end
    end
    return v1, "Only non-negative whole numbers are valid."
end

function u18.Parse(p1) -- Line: 64
    return p1
end

local u22 = {}

function u22.Transform(p1) -- Line: 70
    return (tonumber(p1))
end

function u22.Validate(p1) -- Line: 74
    local v1 = false
    if p1 ~= nil then
        v1 = false
        if p1 == math.floor(p1) then
            v1 = false
            if 0 <= p1 then
                v1 = p1 <= 255
            end
        end
    end
    return v1, "Only bytes are valid."
end

function u22.Parse(p1) -- Line: 78
    return p1
end

local u26 = {}

function u26.Transform(p1) -- Line: 84
    return (tonumber(p1))
end

function u26.Validate(p1) -- Line: 88
    local v1 = false
    if p1 ~= nil then
        v1 = false
        if p1 == math.floor(p1) then
            v1 = false
            if 0 <= p1 then
                v1 = p1 <= 9
            end
        end
    end
    return v1, "Only digits are valid."
end

function u26.Parse(p1) -- Line: 92
    return p1
end

local u42 = u2.MakeDictionary({"true", "t", "yes", "y", "on", "enable", "enabled", "1", "+"})
local u54 = u2.MakeDictionary({"false", "f", "no", "n", "off", "disable", "disabled", "0", "-"})
local u59 = {
    Transform = function(p1) -- Line: 102
        return p1:lower()
    end,
    Validate = function(p1) -- Line: 106 -- upvalues: u42 (val), u54 (val)
        local v1 = true
        if u42[p1] == nil then
            v1 = u54[p1] ~= nil
        end
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
return function(p1) -- Line: 122
    -- upvalues: u3 (val), u6 (val), u10 (val), u14 (val), u18 (val), u22 (val), u26 (val), u59 (ref), u2 (val)
    local v1 = u3
    p1:RegisterType("string", v1)
    v1 = u6
    p1:RegisterType("number", v1)
    v1 = u10
    p1:RegisterType("integer", v1)
    v1 = u14
    p1:RegisterType("positiveInteger", v1)
    v1 = u18
    p1:RegisterType("nonNegativeInteger", v1)
    v1 = u22
    p1:RegisterType("byte", v1)
    v1 = u26
    p1:RegisterType("digit", v1)
    v1 = u59
    p1:RegisterType("boolean", v1)
    v1 = u2
    local MakeListableType = v1.MakeListableType
    local v2 = u3
    v1 = MakeListableType(v2)
    p1:RegisterType("strings", v1)
    v1 = u2
    local MakeListableType_2 = v1.MakeListableType
    v2 = u6
    v1 = MakeListableType_2(v2)
    p1:RegisterType("numbers", v1)
    v1 = u2
    local MakeListableType_3 = v1.MakeListableType
    v2 = u10
    v1 = MakeListableType_3(v2)
    p1:RegisterType("integers", v1)
    v1 = u2
    local MakeListableType_4 = v1.MakeListableType
    v2 = u14
    v1 = MakeListableType_4(v2)
    p1:RegisterType("positiveIntegers", v1)
    v1 = u2
    local MakeListableType_5 = v1.MakeListableType
    v2 = u18
    v1 = MakeListableType_5(v2)
    p1:RegisterType("nonNegativeIntegers", v1)
    v1 = u2
    local MakeListableType_6 = v1.MakeListableType
    v2 = u22
    v1 = MakeListableType_6(v2)
    p1:RegisterType("bytes", v1)
    v1 = u2
    local MakeListableType_7 = v1.MakeListableType
    v2 = u26
    v1 = MakeListableType_7(v2)
    p1:RegisterType("digits", v1)
    v1 = u2
    local MakeListableType_8 = v1.MakeListableType
    v2 = u59
    v1 = MakeListableType_8(v2)
    p1:RegisterType("booleans", v1)
end