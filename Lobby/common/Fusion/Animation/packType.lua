local Parent = script.Parent.Parent
require(Parent.PubTypes)
local Oklab = require(Parent.Colour.Oklab)
return function(p1, p2) -- Line: 16 -- upvalues: Oklab (val)
    local v1
    if p2 == "number" then
        return p1[1]
    end
    if p2 == "CFrame" then
        v1 = CFrame.new(p1[1], p1[2], p1[3])
        return v1 * CFrame.fromAxisAngle(Vector3.new(p1[4], p1[5], p1[6]).Unit, p1[7])
    end
    if p2 == "Color3" then
        v1 = Vector3.new(p1[1], p1[2], p1[3])
        return Oklab.from(v1, false)
    end
    if p2 == "ColorSequenceKeypoint" then
        local v2 = Vector3.new(p1[1], p1[2], p1[3])
        return ColorSequenceKeypoint.new(p1[4], Oklab.from(v2, false))
    end
    if p2 == "DateTime" then
        return DateTime.fromUnixTimestampMillis(p1[1])
    end
    if p2 == "NumberRange" then
        return NumberRange.new(p1[1], p1[2])
    end
    if p2 == "NumberSequenceKeypoint" then
        return NumberSequenceKeypoint.new(p1[2], p1[1], p1[3])
    end
    if p2 == "PhysicalProperties" then
        return PhysicalProperties.new(p1[1], p1[2], p1[3], p1[4], p1[5])
    end
    if p2 == "Ray" then
        v1 = Vector3.new(p1[1], p1[2], p1[3])
        return Ray.new(v1, (Vector3.new(p1[4], p1[5], p1[6])))
    end
    if p2 == "Rect" then
        return Rect.new(p1[1], p1[2], p1[3], p1[4])
    end
    if p2 == "Region3" then
        local v3 = Vector3.new(p1[1], p1[2], p1[3])
        v1 = Vector3.new(p1[4] / 2, p1[5] / 2, p1[6] / 2)
        return Region3.new(v3 - v1, v3 + v1)
    end
    if p2 == "Region3int16" then
        v1 = Vector3int16.new(p1[1], p1[2], p1[3])
        return Region3int16.new(v1, Vector3int16.new(p1[4], p1[5], p1[6]))
    end
    if p2 == "UDim" then
        return UDim.new(p1[1], p1[2])
    end
    if p2 == "UDim2" then
        return UDim2.new(p1[1], p1[2], p1[3], p1[4])
    end
    if p2 == "Vector2" then
        return Vector2.new(p1[1], p1[2])
    end
    if p2 == "Vector2int16" then
        return Vector2int16.new(p1[1], p1[2])
    end
    if p2 == "Vector3" then
        return (Vector3.new(p1[1], p1[2], p1[3]))
    end
    if p2 == "Vector3int16" then
        return Vector3int16.new(p1[1], p1[2], p1[3])
    end
    return nil
end