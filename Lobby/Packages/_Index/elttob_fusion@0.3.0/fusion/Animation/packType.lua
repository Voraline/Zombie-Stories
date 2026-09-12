local Parent = script.Parent.Parent
require(Parent.Types)
local Oklab = require(Parent.Colour.Oklab)
return function(p1, p2) -- Line: 15 -- upvalues: Oklab (val)
    local v1, v2, v3, v4, v5, v6, v7
    if p2 == "number" then
        return p1[1]
    end
    if p2 == "CFrame" then
        v2 = CFrame.new(p1[1], p1[2], p1[3])
        local fromAxisAngle = CFrame.fromAxisAngle
        v5 = p1[4]
        v6 = p1[5]
        v7 = p1[6]
        return v2 * fromAxisAngle(Vector3.new(v5, v6, v7).Unit, p1[7])
    end
    if p2 == "Color3" then
        v1 = Oklab
        local toSRGB = v1.toSRGB
        v3 = p1[1]
        v4 = p1[2]
        v5 = p1[3]
        return toSRGB(Vector3.new(v3, v4, v5), false)
    end
    if p2 == "ColorSequenceKeypoint" then
        local new = ColorSequenceKeypoint.new
        v2 = p1[4]
        v3 = Oklab
        local toSRGB_2 = v3.toSRGB
        v5 = p1[1]
        v6 = p1[2]
        v7 = p1[3]
        return new(v2, toSRGB_2(Vector3.new(v5, v6, v7), false))
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
        local new_2 = Ray.new
        v3 = p1[1]
        v4 = p1[2]
        v5 = p1[3]
        v2 = Vector3.new(v3, v4, v5)
        v4 = p1[4]
        v5 = p1[5]
        v6 = p1[6]
        return new_2(v2, (Vector3.new(v4, v5, v6)))
    end
    if p2 == "Rect" then
        return Rect.new(p1[1], p1[2], p1[3], p1[4])
    end
    if p2 == "Region3" then
        v2 = p1[1]
        v3 = p1[2]
        v4 = p1[3]
        v1 = Vector3.new(v2, v3, v4)
        v3 = p1[4] / 2
        v4 = p1[5] / 2
        v5 = p1[6] / 2
        v2 = Vector3.new(v3, v4, v5)
        return Region3.new(v1 - v2, v1 + v2)
    end
    if p2 == "Region3int16" then
        return Region3int16.new(Vector3int16.new(p1[1], p1[2], p1[3]), Vector3int16.new(p1[4], p1[5], p1[6]))
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
    if p2 ~= "Vector3" then
        if p2 == "Vector3int16" then
            return Vector3int16.new(p1[1], p1[2], p1[3])
        end
        return nil
    end
    v2 = p1[1]
    v3 = p1[2]
    v4 = p1[3]
    return (Vector3.new(v2, v3, v4))
end