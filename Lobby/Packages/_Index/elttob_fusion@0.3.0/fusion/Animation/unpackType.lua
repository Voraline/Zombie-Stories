local Oklab = require(script.Parent.Parent.Colour.Oklab)
return function(p1, p2) -- Line: 14 -- upvalues: Oklab (val)
    local v1
    if p2 == "number" then
        return {p1}
    end
    if p2 == "CFrame" then
        local v2
        v1, v2 = p1:ToAxisAngle()
        return {
            p1.X,
            p1.Y,
            p1.Z,
            v1.X,
            v1.Y,
            v1.Z,
            v2,
        }
    end
    if p2 == "Color3" then
        v1 = Oklab.fromSRGB(p1)
        return {v1.X, v1.Y, v1.Z}
    end
    if p2 == "ColorSequenceKeypoint" then
        v1 = Oklab.fromSRGB(p1.Value)
        return {v1.X, v1.Y, v1.Z, p1.Time}
    end
    if p2 == "DateTime" then
        return {p1.UnixTimestampMillis}
    end
    if p2 == "NumberRange" then
        return {p1.Min, p1.Max}
    end
    if p2 == "NumberSequenceKeypoint" then
        return {p1.Value, p1.Time, p1.Envelope}
    end
    if p2 == "PhysicalProperties" then
        return {
            p1.Density,
            p1.Friction,
            p1.Elasticity,
            p1.FrictionWeight,
            p1.ElasticityWeight,
        }
    end
    if p2 == "Ray" then
        return {
            p1.Origin.X,
            p1.Origin.Y,
            p1.Origin.Z,
            p1.Direction.X,
            p1.Direction.Y,
            p1.Direction.Z,
        }
    end
    if p2 == "Rect" then
        return {p1.Min.X, p1.Min.Y, p1.Max.X, p1.Max.Y}
    end
    if p2 == "Region3" then
        return {
            p1.CFrame.X,
            p1.CFrame.Y,
            p1.CFrame.Z,
            p1.Size.X,
            p1.Size.Y,
            p1.Size.Z,
        }
    end
    if p2 == "Region3int16" then
        return {
            p1.Min.X,
            p1.Min.Y,
            p1.Min.Z,
            p1.Max.X,
            p1.Max.Y,
            p1.Max.Z,
        }
    end
    if p2 == "UDim" then
        return {p1.Scale, p1.Offset}
    end
    if p2 == "UDim2" then
        return {p1.X.Scale, p1.X.Offset, p1.Y.Scale, p1.Y.Offset}
    end
    if p2 == "Vector2" or p2 == "Vector2int16" then
        return {p1.X, p1.Y}
    end
    if p2 == "Vector3" or p2 == "Vector3int16" then
        return {p1.X, p1.Y, p1.Z}
    end
    return {}
end