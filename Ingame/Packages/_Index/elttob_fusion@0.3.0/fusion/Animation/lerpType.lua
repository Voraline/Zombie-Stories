local Oklab = require(script.Parent.Parent.Colour.Oklab)
return function(p1, p2, p3) -- Line: 15 -- upvalues: Oklab (val)
    local v1, v2, v3, v4, v5
    local v6 = typeof(p1)
    if typeof(p2) ~= v6 then
        if p3 < 0.5 then
            return p1
        end
        return p2
    end
    if v6 == "number" then
        v2 = p1
        return (p2 - v2) * p3 + v2
    end
    if v6 == "CFrame" then
        return p1:Lerp(p2, p3)
    end
    if v6 == "Color3" then
        v3 = Oklab.fromSRGB(p1)
        v4 = Oklab.fromSRGB(p2)
        v5 = v3:Lerp(v4, p3)
        return Oklab.toSRGB(v5, false)
    end
    if v6 == "ColorSequenceKeypoint" then
        v1 = p2
        v2 = p1
        v3 = Oklab.fromSRGB(v2.Value)
        v4 = Oklab.fromSRGB(v1.Value)
        v5 = (v1.Time - v2.Time) * p3 + v2.Time
        local v7 = v3:Lerp(v4, p3)
        return ColorSequenceKeypoint.new(v5, Oklab.toSRGB(v7, false))
    end
    if v6 == "DateTime" then
        v2 = p1
        return DateTime.fromUnixTimestampMillis((p2.UnixTimestampMillis - v2.UnixTimestampMillis) * p3 + v2.UnixTimestampMillis)
    end
    if v6 == "NumberRange" then
        v1 = p2
        v2 = p1
        return NumberRange.new((v1.Min - v2.Min) * p3 + v2.Min, (v1.Max - v2.Max) * p3 + v2.Max)
    end
    if v6 == "NumberSequenceKeypoint" then
        v1 = p2
        v2 = p1
        return NumberSequenceKeypoint.new((v1.Time - v2.Time) * p3 + v2.Time, (v1.Value - v2.Value) * p3 + v2.Value, (v1.Envelope - v2.Envelope) * p3 + v2.Envelope)
    end
    if v6 == "PhysicalProperties" then
        v1 = p2
        v2 = p1
        return PhysicalProperties.new((v1.Density - v2.Density) * p3 + v2.Density, (v1.Friction - v2.Friction) * p3 + v2.Friction, (v1.Elasticity - v2.Elasticity) * p3 + v2.Elasticity, (v1.FrictionWeight - v2.FrictionWeight) * p3 + v2.FrictionWeight, (v1.ElasticityWeight - v2.ElasticityWeight) * p3 + v2.ElasticityWeight)
    end
    if v6 == "Ray" then
        v1 = p2
        v2 = p1
        v4 = v2.Origin:Lerp(v1.Origin, p3)
        return Ray.new(v4, v2.Direction:Lerp(v1.Direction, p3))
    end
    if v6 == "Rect" then
        v1 = p2
        v2 = p1
        v4 = v2.Min:Lerp(v1.Min, p3)
        return Rect.new(v4, v2.Max:Lerp(v1.Max, p3))
    end
    if v6 == "Region3" then
        v1 = p2
        v2 = p1
        v3 = v2.CFrame.Position:Lerp(v1.CFrame.Position, p3)
        v4 = v2.Size:Lerp(v1.Size, p3) / 2
        return Region3.new(v3 - v4, v3 + v4)
    end
    if v6 == "Region3int16" then
        v1 = p2
        v2 = p1
        v4 = Vector3int16.new((v1.Min.X - v2.Min.X) * p3 + v2.Min.X, (v1.Min.Y - v2.Min.Y) * p3 + v2.Min.Y, (v1.Min.Z - v2.Min.Z) * p3 + v2.Min.Z)
        return Region3int16.new(v4, Vector3int16.new((v1.Max.X - v2.Max.X) * p3 + v2.Max.X, (v1.Max.Y - v2.Max.Y) * p3 + v2.Max.Y, (v1.Max.Z - v2.Max.Z) * p3 + v2.Max.Z))
    end
    if v6 == "UDim" then
        v1 = p2
        v2 = p1
        return UDim.new((v1.Scale - v2.Scale) * p3 + v2.Scale, (v1.Offset - v2.Offset) * p3 + v2.Offset)
    end
    if v6 == "UDim2" or v6 == "Vector2" then
        return p1:Lerp(p2, p3)
    end
    if v6 == "Vector2int16" then
        v1 = p2
        v2 = p1
        return Vector2int16.new((v1.X - v2.X) * p3 + v2.X, (v1.Y - v2.Y) * p3 + v2.Y)
    end
    if v6 == "Vector3" then
        return p1:Lerp(p2, p3)
    end
    if v6 == "Vector3int16" then
        v1 = p2
        v2 = p1
        return Vector3int16.new((v1.X - v2.X) * p3 + v2.X, (v1.Y - v2.Y) * p3 + v2.Y, (v1.Z - v2.Z) * p3 + v2.Z)
    end
    if p3 < 0.5 then
        return p1
    end
    return p2
end