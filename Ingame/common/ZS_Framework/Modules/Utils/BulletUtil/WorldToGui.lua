local v1 = {
    _DESCRIPTION = "\t\tWorldPositionToGuiPosition by orange451\n\t\t\n\t\tThis script can take a part and a world position, and output Surface Gui data.\n\t\tUseful for clippable bulletholes.\n\t\t\n\t\tUsage:\n\t\t\tWorldPositionToGuiPosition( Part, WorldPosition )\n\t\t\n\t\tReturns:\n\t\t\t- Surface\n\t\t\t- Width of surface\n\t\t\t- Height of surface\n\t\t\t- Relative X Position WorldPosition\n\t\t\t- Relative Y Position WorldPosition\n\t",
    _LICENSE = "\t\tMIT LICENSE\n\n\t\tCopyright (c) 2017 Andrew Hamilton\n\n\t\tPermission is hereby granted, free of charge, to any person obtaining a\n\t\tcopy of this software and associated documentation files (the\n\t\t\"Software\"), to deal in the Software without restriction, including\n\t\twithout limitation the rights to use, copy, modify, merge, publish,\n\t\tdistribute, sublicense, and/or sell copies of the Software, and to\n\t\tpermit persons to whom the Software is furnished to do so, subject to\n\t\tthe following conditions:\n\n\t\tThe above copyright notice and this permission notice shall be included\n\t\tin all copies or substantial portions of the Software.\n\n\t\tTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n\t\tOR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n\t\tMERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n\t\tIN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n\t\tCLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n\t\tTORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n\t\tSOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\t",
}
local u1 = {}
local Right = Enum.NormalId.Right
local v2 = {Vector3.new(0.5, 0.5, 0.5), Vector3.new(0.5, 0.5, -0.5), (Vector3.new(0.5, -0.5, -0.5))}
u1[Right] = v2
local Left = Enum.NormalId.Left
v2 = {Vector3.new(-0.5, 0.5, -0.5), Vector3.new(-0.5, 0.5, 0.5), (Vector3.new(-0.5, -0.5, 0.5))}
u1[Left] = v2
local Front = Enum.NormalId.Front
v2 = {Vector3.new(0.5, 0.5, -0.5), Vector3.new(-0.5, 0.5, -0.5), (Vector3.new(-0.5, -0.5, -0.5))}
u1[Front] = v2
local Back = Enum.NormalId.Back
v2 = {Vector3.new(-0.5, 0.5, 0.5), Vector3.new(0.5, 0.5, 0.5), (Vector3.new(0.5, -0.5, 0.5))}
u1[Back] = v2
local Top = Enum.NormalId.Top
v2 = {Vector3.new(-0.5, 0.5, 0.5), Vector3.new(-0.5, 0.5, -0.5), (Vector3.new(0.5, 0.5, -0.5))}
u1[Top] = v2
local Bottom = Enum.NormalId.Bottom
v2 = {Vector3.new(0.5, -0.5, 0.5), Vector3.new(0.5, -0.5, -0.5), (Vector3.new(-0.5, -0.5, -0.5))}
u1[Bottom] = v2

function v1.GetSurfaceClosestToPoint(p1, p2, p3) -- Line: 79
    local v1 = (p2.CFrame:pointToObjectSpace(p3)) / p2.Size
    local X = v1.X
    local Y = v1.Y
    local Z = v1.Z
    local v2 = math.abs(X)
    local v3 = math.abs(Y)
    local v4 = math.abs(Z)
    if v3 < v4 and v2 < v4 then
        if 0 < Z then
            return Enum.NormalId.Back
        end
        return Enum.NormalId.Front
    end
    if v4 < v3 and v2 < v3 then
        if 0 < Y then
            return Enum.NormalId.Top
        end
        return Enum.NormalId.Bottom
    end
    if v4 < v2 and v3 < v2 then
        if 0 < X then
            return Enum.NormalId.Right
        end
        return Enum.NormalId.Left
    end
    return nil
end

function v1.NearestPointOnLine(p1, p2, p3, p4) -- Line: 112
    local unit = p3.unit
    return p2 + unit * (p4 - p2):Dot(unit)
end

function v1.WorldPositionToGuiPosition(p1, p2, p3) -- Line: 120 -- upvalues: u1 (val)
    local SurfaceClosestToPoint = p1:GetSurfaceClosestToPoint(p2, p3)
    if SurfaceClosestToPoint == nil then
        return nil, nil, nil, nil, nil
    end
    local v1 = u1[SurfaceClosestToPoint]
    if v1 == nil then
        return nil, nil, nil, nil, nil
    end
    local p = (p2.CFrame * CFrame.new(v1[1] * p2.Size)).p
    local p_2 = (p2.CFrame * CFrame.new(v1[2] * p2.Size)).p
    local p_3 = (p2.CFrame * CFrame.new(v1[3] * p2.Size)).p
    local v2 = p_2 - p
    local v3 = p1:NearestPointOnLine(p, v2, p3)
    local v4 = p_3 - p_2
    local v5 = p1:NearestPointOnLine(p_2, v4, p3)
    local Magnitude = (p_2 - p).Magnitude
    local Magnitude_2 = (p_3 - p_2).Magnitude
    return SurfaceClosestToPoint, Magnitude, Magnitude_2, (v3 - p).Magnitude / Magnitude, (v5 - p_2).Magnitude / Magnitude_2
end

return v1