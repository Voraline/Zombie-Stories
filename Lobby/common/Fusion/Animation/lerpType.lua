local v1 = script.Parent.Parent
require(v1.PubTypes)
local v_u_2 = require(v1.Colour.Oklab)
return function(p3, p4, p5) -- name: lerpType
	-- upvalues: (copy) v_u_2
	local v6 = typeof(p3)
	if typeof(p4) == v6 then
		if v6 == "number" then
			return (p4 - p3) * p5 + p3
		end
		if v6 == "CFrame" then
			return p3:Lerp(p4, p5)
		end
		if v6 == "Color3" then
			local v7 = v_u_2.to(p3)
			local v8 = v_u_2.to(p4)
			return v_u_2.from(v7:Lerp(v8, p5), false)
		end
		if v6 == "ColorSequenceKeypoint" then
			local v9 = v_u_2.to(p3.Value)
			local v10 = v_u_2.to(p4.Value)
			return ColorSequenceKeypoint.new((p4.Time - p3.Time) * p5 + p3.Time, v_u_2.from(v9:Lerp(v10, p5), false))
		end
		if v6 == "DateTime" then
			return DateTime.fromUnixTimestampMillis((p4.UnixTimestampMillis - p3.UnixTimestampMillis) * p5 + p3.UnixTimestampMillis)
		end
		if v6 == "NumberRange" then
			return NumberRange.new((p4.Min - p3.Min) * p5 + p3.Min, (p4.Max - p3.Max) * p5 + p3.Max)
		end
		if v6 == "NumberSequenceKeypoint" then
			return NumberSequenceKeypoint.new((p4.Time - p3.Time) * p5 + p3.Time, (p4.Value - p3.Value) * p5 + p3.Value, (p4.Envelope - p3.Envelope) * p5 + p3.Envelope)
		end
		if v6 == "PhysicalProperties" then
			return PhysicalProperties.new((p4.Density - p3.Density) * p5 + p3.Density, (p4.Friction - p3.Friction) * p5 + p3.Friction, (p4.Elasticity - p3.Elasticity) * p5 + p3.Elasticity, (p4.FrictionWeight - p3.FrictionWeight) * p5 + p3.FrictionWeight, (p4.ElasticityWeight - p3.ElasticityWeight) * p5 + p3.ElasticityWeight)
		end
		if v6 == "Ray" then
			return Ray.new(p3.Origin:Lerp(p4.Origin, p5), p3.Direction:Lerp(p4.Direction, p5))
		end
		if v6 == "Rect" then
			return Rect.new(p3.Min:Lerp(p4.Min, p5), p3.Max:Lerp(p4.Max, p5))
		end
		if v6 == "Region3" then
			local v11 = p3.CFrame.Position:Lerp(p4.CFrame.Position, p5)
			local v12 = p3.Size:Lerp(p4.Size, p5) / 2
			return Region3.new(v11 - v12, v11 + v12)
		end
		if v6 == "Region3int16" then
			return Region3int16.new(Vector3int16.new((p4.Min.X - p3.Min.X) * p5 + p3.Min.X, (p4.Min.Y - p3.Min.Y) * p5 + p3.Min.Y, (p4.Min.Z - p3.Min.Z) * p5 + p3.Min.Z), Vector3int16.new((p4.Max.X - p3.Max.X) * p5 + p3.Max.X, (p4.Max.Y - p3.Max.Y) * p5 + p3.Max.Y, (p4.Max.Z - p3.Max.Z) * p5 + p3.Max.Z))
		end
		if v6 == "UDim" then
			return UDim.new((p4.Scale - p3.Scale) * p5 + p3.Scale, (p4.Offset - p3.Offset) * p5 + p3.Offset)
		end
		if v6 == "UDim2" then
			return p3:Lerp(p4, p5)
		end
		if v6 == "Vector2" then
			return p3:Lerp(p4, p5)
		end
		if v6 == "Vector2int16" then
			return Vector2int16.new((p4.X - p3.X) * p5 + p3.X, (p4.Y - p3.Y) * p5 + p3.Y)
		end
		if v6 == "Vector3" then
			return p3:Lerp(p4, p5)
		end
		if v6 == "Vector3int16" then
			return Vector3int16.new((p4.X - p3.X) * p5 + p3.X, (p4.Y - p3.Y) * p5 + p3.Y, (p4.Z - p3.Z) * p5 + p3.Z)
		end
	end
	if p5 < 0.5 then
		return p3
	else
		return p4
	end
end