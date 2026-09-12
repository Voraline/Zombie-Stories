local Parent_2 = script.Parent.Parent
local Oklab = require(Parent_2.Colour.Oklab)
return function(p1, p2, p3) -- Line: 15 -- upvalues: Oklab (val)
    local v1 = typeof(p1)
    if typeof(p2) == v1 then
        local v2, v3, v4, v5
        if v1 == "number" then
            v3 = p1
            return (p2 - v3) * p3 + v3
        end
        if v1 == "CFrame" then
            return p1:Lerp(p2, p3)
        end
        if v1 == "Color3" then
            v4 = Oklab.fromSRGB(p1)
            v5 = Oklab.fromSRGB(p2)
            local v6 = Oklab
            return v6.toSRGB(v4:Lerp(v5, p3), false)
        end
        if v1 == "ColorSequenceKeypoint" then
            v2 = p2
            v3 = p1
            v4 = Oklab.fromSRGB(v3.Value)
            v5 = Oklab.fromSRGB(v2.Value)
            local new = ColorSequenceKeypoint.new
            local v7 = (v2.Time - v3.Time) * p3 + v3.Time
            local v8 = Oklab
            return new(v7, v8.toSRGB(v4:Lerp(v5, p3), false))
        end
        if v1 == "DateTime" then
            v3 = p1
            return DateTime.fromUnixTimestampMillis((p2.UnixTimestampMillis - v3.UnixTimestampMillis) * p3 + v3.UnixTimestampMillis)
        end
        if v1 == "NumberRange" then
            v2 = p2
            v3 = p1
            return NumberRange.new((v2.Min - v3.Min) * p3 + v3.Min, (v2.Max - v3.Max) * p3 + v3.Max)
        end
        if v1 == "NumberSequenceKeypoint" then
            v2 = p2
            v3 = p1
            return NumberSequenceKeypoint.new(
                (v2.Time - v3.Time) * p3 + v3.Time,
                (v2.Value - v3.Value) * p3 + v3.Value,
                (v2.Envelope - v3.Envelope) * p3 + v3.Envelope
            )
        end
        if v1 == "PhysicalProperties" then
            v2 = p2
            v3 = p1
            return PhysicalProperties.new(
                (v2.Density - v3.Density) * p3 + v3.Density,
                (v2.Friction - v3.Friction) * p3 + v3.Friction,
                (v2.Elasticity - v3.Elasticity) * p3 + v3.Elasticity,
                (v2.FrictionWeight - v3.FrictionWeight) * p3 + v3.FrictionWeight,
                (v2.ElasticityWeight - v3.ElasticityWeight) * p3 + v3.ElasticityWeight
            )
        end
        if v1 == "Ray" then
            v2 = p2
            v3 = p1
            local new_5 = Ray.new
            local Origin = v3.Origin
            local Origin_2 = v2.Origin
            v5 = Origin:Lerp(Origin_2, p3)
            local Direction = v3.Direction
            local Direction_2 = v2.Direction
            return new_5(v5, Direction:Lerp(Direction_2, p3))
        end
        if v1 == "Rect" then
            v2 = p2
            v3 = p1
            local new_6 = Rect.new
            local Min = v3.Min
            local Min_2 = v2.Min
            v5 = Min:Lerp(Min_2, p3)
            local Max = v3.Max
            local Max_2 = v2.Max
            return new_6(v5, Max:Lerp(Max_2, p3))
        end
        if v1 == "Region3" then
            v2 = p2
            v3 = p1
            local Position = v3.CFrame.Position
            local Position_2 = v2.CFrame.Position
            v4 = Position:Lerp(Position_2, p3)
            local Size = v3.Size
            local Size_2 = v2.Size
            v5 = Size:Lerp(Size_2, p3) / 2
            return Region3.new(v4 - v5, v4 + v5)
        end
        if v1 == "Region3int16" then
            v2 = p2
            v3 = p1
            return Region3int16.new(Vector3int16.new(
                (v2.Min.X - v3.Min.X) * p3 + v3.Min.X,
                (v2.Min.Y - v3.Min.Y) * p3 + v3.Min.Y,
                (v2.Min.Z - v3.Min.Z) * p3 + v3.Min.Z
            ), Vector3int16.new(
                (v2.Max.X - v3.Max.X) * p3 + v3.Max.X,
                (v2.Max.Y - v3.Max.Y) * p3 + v3.Max.Y,
                (v2.Max.Z - v3.Max.Z) * p3 + v3.Max.Z
            ))
        end
        if v1 == "UDim" then
            v2 = p2
            v3 = p1
            return UDim.new((v2.Scale - v3.Scale) * p3 + v3.Scale, (v2.Offset - v3.Offset) * p3 + v3.Offset)
        end
        if v1 == "UDim2" or v1 == "Vector2" then
            return p1:Lerp(p2, p3)
        end
        if v1 == "Vector2int16" then
            v2 = p2
            v3 = p1
            return Vector2int16.new((v2.X - v3.X) * p3 + v3.X, (v2.Y - v3.Y) * p3 + v3.Y)
        end
        if v1 == "Vector3" then
            return p1:Lerp(p2, p3)
        end
        if v1 == "Vector3int16" then
            v2 = p2
            v3 = p1
            return Vector3int16.new((v2.X - v3.X) * p3 + v3.X, (v2.Y - v3.Y) * p3 + v3.Y, (v2.Z - v3.Z) * p3 + v3.Z)
        end
    end
    if p3 < 0.5 then
        return p1
    end
    return p2
end