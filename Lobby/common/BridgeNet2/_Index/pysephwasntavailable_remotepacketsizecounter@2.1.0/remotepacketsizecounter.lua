local GetDataByteSize
local u0 = {
    ["nil"] = 0,
    EnumItem = 4,
    boolean = 1,
    number = 8,
    UDim = 8,
    UDim2 = 16,
    Ray = 24,
    Faces = 6,
    Axes = 6,
    BrickColor = 4,
    Color3 = 12,
    Vector2 = 8,
    Vector3 = 12,
    Instance = 4,
    Vector2int16 = 4,
    Vector3int16 = 6,
    NumberSequenceKeypoint = 12,
    ColorSequenceKeypoint = 16,
    NumberRange = 8,
    Rect = 16,
    PhysicalProperties = 20,
    Color3uint8 = 3,
}
local u23 = {}
local v1 = CFrame.Angles(0, 0, 0)
u23[v1] = true
v1 = CFrame.Angles(0, 3.141592653589793, 0)
u23[v1] = true
v1 = CFrame.Angles(1.5707963267948966, 0, 0)
u23[v1] = true
v1 = CFrame.Angles(-1.5707963267948966, -3.141592653589793, 0)
u23[v1] = true
v1 = CFrame.Angles(0, 3.141592653589793, 3.141592653589793)
u23[v1] = true
v1 = CFrame.Angles(0, 0, 3.141592653589793)
u23[v1] = true
v1 = CFrame.Angles(-1.5707963267948966, 0, 0)
u23[v1] = true
v1 = CFrame.Angles(1.5707963267948966, 3.141592653589793, 0)
u23[v1] = true
v1 = CFrame.Angles(0, 3.141592653589793, 1.5707963267948966)
u23[v1] = true
v1 = CFrame.Angles(0, 0, -1.5707963267948966)
u23[v1] = true
v1 = CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966)
u23[v1] = true
v1 = CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966)
u23[v1] = true
v1 = CFrame.Angles(0, 0, 1.5707963267948966)
u23[v1] = true
v1 = CFrame.Angles(0, -3.141592653589793, -1.5707963267948966)
u23[v1] = true
v1 = CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)
u23[v1] = true
v1 = CFrame.Angles(0, 1.5707963267948966, -1.5707963267948966)
u23[v1] = true
v1 = CFrame.Angles(-1.5707963267948966, -1.5707963267948966, 0)
u23[v1] = true
v1 = CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0)
u23[v1] = true
v1 = CFrame.Angles(0, -1.5707963267948966, 0)
u23[v1] = true
v1 = CFrame.Angles(0, 1.5707963267948966, 0)
u23[v1] = true
v1 = CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0)
u23[v1] = true
v1 = CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)
u23[v1] = true
v1 = CFrame.Angles(0, 1.5707963267948966, 3.141592653589793)
u23[v1] = true
v1 = CFrame.Angles(0, -1.5707963267948966, 3.141592653589793)
u23[v1] = true

function GetDataByteSize(p1, p2) -- Line: 69 -- upvalues: u0 (val), GetDataByteSize (val), u23 (val)
    local v1, v2, v3, v4
    local v5 = typeof(p1)
    if u0[v5] then
        return u0[v5]
    end
    if v5 == "string" then
        return #p1 + 2
    end
    if v5 ~= "table" then
        if v5 == "CFrame" then
            v1 = false
            v2 = next
            v3 = u23
            v4 = nil
            for k2 in v2, v3, v4 do
                if k2 == p1.Rotation then
                    v1 = true
                    break
                end
            end
            if v1 then
                return 13
            end
            return 21
        end
        if v5 ~= "NumberSequence" and v5 ~= "ColorSequence" then
            warn("Unsupported data type: " .. v5)
            return 0
        end
        v1 = 4
        v2 = next
        local Keypoints = p1.Keypoints
        v4 = nil
        for k, v in v2, Keypoints, v4 do
            v1 = v1 + GetDataByteSize(v, p2)
        end
        return v1
    end
    if p2[p1] then
        return 0
    end
    p2[p1] = true
    v1 = 0
    v2 = 0
    v3 = 1
    v4 = true
    local v6 = next
    local v7 = p1
    local v8 = nil
    local v9 = p1
    for k3, i in v6, v7, v8 do
        if k3 == v3 then
            v3 = v3 + 1
        else
            v4 = false
        end
        v1 = v1 + (GetDataByteSize(k3, v10) + 1)
        v2 = v2 + (GetDataByteSize(i, v10) + 1)
    end
    v7 = 1
    if not v4 then
        v8 = v1 + v2
    else
        v8 = #v9 + v2
        if not v8 then
            v8 = v1 + v2
        end
    end
    return v7 + v8
end

local v2 = {
    RemoteOverhead = 9,
    TypeOverhead = 1,
    GetPacketSize = function(p1) -- Line: 150 -- upvalues: GetDataByteSize (val)
        local v1
        if not p1.IgnoreRemoteOffset then
            v1 = 9
        else
            v1 = 0
        end
        local v2 = {}
        for i, v in ipairs(p1.PacketData) do
            v1 = v1 + (GetDataByteSize(v, v2) + 1)
        end
        return v1
    end,
    GetDataByteSize = function(p1) -- Line: 164 -- upvalues: GetDataByteSize (val)
        return (GetDataByteSize(p1, {}))
    end,
}
table.freeze(v2)
return v2