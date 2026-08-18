local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Colour.Oklab)
return function(p3, p4) -- name: packType
	-- upvalues: (copy) v_u_2
	if p4 == "number" then
		return p3[1]
	elseif p4 == "CFrame" then
		local v5 = CFrame.new(p3[1], p3[2], p3[3])
		local v6 = CFrame.fromAxisAngle
		local v7 = p3[4]
		local v8 = p3[5]
		local v9 = p3[6]
		return v5 * v6(Vector3.new(v7, v8, v9).Unit, p3[7])
	elseif p4 == "Color3" then
		local v10 = v_u_2.toSRGB
		local v11 = p3[1]
		local v12 = p3[2]
		local v13 = p3[3]
		return v10(Vector3.new(v11, v12, v13), false)
	elseif p4 == "ColorSequenceKeypoint" then
		local v14 = ColorSequenceKeypoint.new
		local v15 = p3[4]
		local v16 = v_u_2.toSRGB
		local v17 = p3[1]
		local v18 = p3[2]
		local v19 = p3[3]
		return v14(v15, v16(Vector3.new(v17, v18, v19), false))
	elseif p4 == "DateTime" then
		return DateTime.fromUnixTimestampMillis(p3[1])
	elseif p4 == "NumberRange" then
		return NumberRange.new(p3[1], p3[2])
	elseif p4 == "NumberSequenceKeypoint" then
		return NumberSequenceKeypoint.new(p3[2], p3[1], p3[3])
	elseif p4 == "PhysicalProperties" then
		return PhysicalProperties.new(p3[1], p3[2], p3[3], p3[4], p3[5])
	elseif p4 == "Ray" then
		local v20 = Ray.new
		local v21 = p3[1]
		local v22 = p3[2]
		local v23 = p3[3]
		local v24 = Vector3.new(v21, v22, v23)
		local v25 = p3[4]
		local v26 = p3[5]
		local v27 = p3[6]
		return v20(v24, (Vector3.new(v25, v26, v27)))
	elseif p4 == "Rect" then
		return Rect.new(p3[1], p3[2], p3[3], p3[4])
	elseif p4 == "Region3" then
		local v28 = p3[1]
		local v29 = p3[2]
		local v30 = p3[3]
		local v31 = Vector3.new(v28, v29, v30)
		local v32 = p3[4] / 2
		local v33 = p3[5] / 2
		local v34 = p3[6] / 2
		local v35 = Vector3.new(v32, v33, v34)
		return Region3.new(v31 - v35, v31 + v35)
	elseif p4 == "Region3int16" then
		return Region3int16.new(Vector3int16.new(p3[1], p3[2], p3[3]), Vector3int16.new(p3[4], p3[5], p3[6]))
	elseif p4 == "UDim" then
		return UDim.new(p3[1], p3[2])
	elseif p4 == "UDim2" then
		return UDim2.new(p3[1], p3[2], p3[3], p3[4])
	elseif p4 == "Vector2" then
		return Vector2.new(p3[1], p3[2])
	elseif p4 == "Vector2int16" then
		return Vector2int16.new(p3[1], p3[2])
	elseif p4 == "Vector3" then
		local v36 = p3[1]
		local v37 = p3[2]
		local v38 = p3[3]
		return Vector3.new(v36, v37, v38)
	elseif p4 == "Vector3int16" then
		return Vector3int16.new(p3[1], p3[2], p3[3])
	else
		return nil
	end
end