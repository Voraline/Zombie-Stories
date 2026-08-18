local v1 = {
	["_DESCRIPTION"] = "\t\tWorldPositionToGuiPosition by orange451\n\t\t\n\t\tThis script can take a part and a world position, and output Surface Gui data.\n\t\tUseful for clippable bulletholes.\n\t\t\n\t\tUsage:\n\t\t\tWorldPositionToGuiPosition( Part, WorldPosition )\n\t\t\n\t\tReturns:\n\t\t\t- Surface\n\t\t\t- Width of surface\n\t\t\t- Height of surface\n\t\t\t- Relative X Position WorldPosition\n\t\t\t- Relative Y Position WorldPosition\n\t",
	["_LICENSE"] = "\t\tMIT LICENSE\n\n\t\tCopyright (c) 2017 Andrew Hamilton\n\n\t\tPermission is hereby granted, free of charge, to any person obtaining a\n\t\tcopy of this software and associated documentation files (the\n\t\t\"Software\"), to deal in the Software without restriction, including\n\t\twithout limitation the rights to use, copy, modify, merge, publish,\n\t\tdistribute, sublicense, and/or sell copies of the Software, and to\n\t\tpermit persons to whom the Software is furnished to do so, subject to\n\t\tthe following conditions:\n\n\t\tThe above copyright notice and this permission notice shall be included\n\t\tin all copies or substantial portions of the Software.\n\n\t\tTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n\t\tOR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n\t\tMERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n\t\tIN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n\t\tCLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n\t\tTORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n\t\tSOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\t"
}
local v_u_2 = {
	[Enum.NormalId.Right] = { Vector3.new(0.5, 0.5, 0.5), Vector3.new(0.5, 0.5, -0.5), Vector3.new(0.5, -0.5, -0.5) },
	[Enum.NormalId.Left] = { Vector3.new(-0.5, 0.5, -0.5), Vector3.new(-0.5, 0.5, 0.5), Vector3.new(-0.5, -0.5, 0.5) },
	[Enum.NormalId.Front] = { Vector3.new(0.5, 0.5, -0.5), Vector3.new(-0.5, 0.5, -0.5), Vector3.new(-0.5, -0.5, -0.5) },
	[Enum.NormalId.Back] = { Vector3.new(-0.5, 0.5, 0.5), Vector3.new(0.5, 0.5, 0.5), Vector3.new(0.5, -0.5, 0.5) },
	[Enum.NormalId.Top] = { Vector3.new(-0.5, 0.5, 0.5), Vector3.new(-0.5, 0.5, -0.5), Vector3.new(0.5, 0.5, -0.5) },
	[Enum.NormalId.Bottom] = { Vector3.new(0.5, -0.5, 0.5), Vector3.new(0.5, -0.5, -0.5), Vector3.new(-0.5, -0.5, -0.5) }
}
function v1.GetSurfaceClosestToPoint(_, p3, p4) -- name: GetSurfaceClosestToPoint
	local v5 = p3.CFrame:pointToObjectSpace(p4) / p3.Size
	local v6 = v5.X
	local v7 = v5.Y
	local v8 = v5.Z
	local v9 = math.abs(v6)
	local v10 = math.abs(v7)
	local v11 = math.abs(v8)
	if v10 < v11 and v9 < v11 then
		if v8 > 0 then
			return Enum.NormalId.Back
		else
			return Enum.NormalId.Front
		end
	elseif v11 < v10 and v9 < v10 then
		if v7 > 0 then
			return Enum.NormalId.Top
		else
			return Enum.NormalId.Bottom
		end
	elseif v11 < v9 and v10 < v9 then
		if v6 > 0 then
			return Enum.NormalId.Right
		else
			return Enum.NormalId.Left
		end
	else
		return nil
	end
end
function v1.NearestPointOnLine(_, p12, p13, p14) -- name: NearestPointOnLine
	local v15 = p13.unit
	return p12 + v15 * (p14 - p12):Dot(v15)
end
function v1.WorldPositionToGuiPosition(p16, p17, p18) -- name: WorldPositionToGuiPosition
	-- upvalues: (copy) v_u_2
	local v19 = p16:GetSurfaceClosestToPoint(p17, p18)
	if v19 == nil then
		return nil, nil, nil, nil, nil
	end
	local v20 = v_u_2[v19]
	if v20 == nil then
		return nil, nil, nil, nil, nil
	end
	local v21 = (p17.CFrame * CFrame.new(v20[1] * p17.Size)).p
	local v22 = (p17.CFrame * CFrame.new(v20[2] * p17.Size)).p
	local v23 = (p17.CFrame * CFrame.new(v20[3] * p17.Size)).p
	local v24 = p16:NearestPointOnLine(v21, v22 - v21, p18)
	local v25 = p16:NearestPointOnLine(v22, v23 - v22, p18)
	local v26 = (v22 - v21).Magnitude
	local v27 = (v23 - v22).Magnitude
	return v19, v26, v27, (v24 - v21).Magnitude / v26, (v25 - v22).Magnitude / v27
end
return v1