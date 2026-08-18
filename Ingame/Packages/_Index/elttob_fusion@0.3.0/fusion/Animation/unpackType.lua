local v1 = script.Parent.Parent
local v_u_2 = require(v1.Colour.Oklab)
return function(p3, p4) -- name: unpackType
	-- upvalues: (copy) v_u_2
	if p4 == "number" then
		return { p3 }
	end
	if p4 == "CFrame" then
		local v5, v6 = p3:ToAxisAngle()
		return {
			p3.X,
			p3.Y,
			p3.Z,
			v5.X,
			v5.Y,
			v5.Z,
			v6
		}
	end
	if p4 == "Color3" then
		local v7 = v_u_2.fromSRGB(p3)
		return { v7.X, v7.Y, v7.Z }
	end
	if p4 ~= "ColorSequenceKeypoint" then
		return p4 == "DateTime" and { p3.UnixTimestampMillis } or (p4 == "NumberRange" and { p3.Min, p3.Max } or (p4 == "NumberSequenceKeypoint" and { p3.Value, p3.Time, p3.Envelope } or (p4 == "PhysicalProperties" and {
			p3.Density,
			p3.Friction,
			p3.Elasticity,
			p3.FrictionWeight,
			p3.ElasticityWeight
		} or (p4 == "Ray" and {
			p3.Origin.X,
			p3.Origin.Y,
			p3.Origin.Z,
			p3.Direction.X,
			p3.Direction.Y,
			p3.Direction.Z
		} or (p4 == "Rect" and {
			p3.Min.X,
			p3.Min.Y,
			p3.Max.X,
			p3.Max.Y
		} or (p4 == "Region3" and {
			p3.CFrame.X,
			p3.CFrame.Y,
			p3.CFrame.Z,
			p3.Size.X,
			p3.Size.Y,
			p3.Size.Z
		} or (p4 == "Region3int16" and {
			p3.Min.X,
			p3.Min.Y,
			p3.Min.Z,
			p3.Max.X,
			p3.Max.Y,
			p3.Max.Z
		} or (p4 == "UDim" and { p3.Scale, p3.Offset } or (p4 == "UDim2" and {
			p3.X.Scale,
			p3.X.Offset,
			p3.Y.Scale,
			p3.Y.Offset
		} or (p4 == "Vector2" and { p3.X, p3.Y } or (p4 == "Vector2int16" and { p3.X, p3.Y } or (p4 == "Vector3" and { p3.X, p3.Y, p3.Z } or (p4 == "Vector3int16" and { p3.X, p3.Y, p3.Z } or {})))))))))))))
	end
	local v8 = v_u_2.fromSRGB(p3.Value)
	return {
		v8.X,
		v8.Y,
		v8.Z,
		p3.Time
	}
end