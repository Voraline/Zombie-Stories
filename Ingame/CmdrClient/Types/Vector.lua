local u2 = require("../Shared/Util")
local function validateVector(p1, p2) -- Line: 3
    if p1 == nil then
        return false, ("Invalid or missing number at position %d in Vector type."):format(p2)
    end
    return true
end
local u8 = u2.MakeSequenceType({Length = 3, ValidateEach = validateVector, TransformEach = tonumber, Constructor = Vector3.new})
local u13 = u2.MakeSequenceType({Length = 2, ValidateEach = validateVector, TransformEach = tonumber, Constructor = Vector2.new})
return function(p1) -- Line: 25 -- upvalues: u8 (val), u2 (val), u13 (val)
    p1:RegisterType("vector3", u8)
    p1:RegisterType("vector3s", u2.MakeListableType(u8))
    p1:RegisterType("vector2", u13)
    p1:RegisterType("vector2s", u2.MakeListableType(u13))
end