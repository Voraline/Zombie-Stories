local u0 = {Clearance = 0.075}
local u2 = {}
u2[1] = (Vector3.new(1, 0, 0))
u2[2] = (Vector3.new(0, 1, 0))
u2[3] = (Vector3.new(0, 0, 1))

local function bounds(p1) -- Line: 9
    local v1 = Vector3.new((1 / 0), (1 / 0), (1 / 0))
    local v2 = -v1
    local v3 = p1
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        v1 = v1:Min(j)
        v2 = v2:Max(j)
    end
    return v1, v2
end

function u0.collectCorners(p1, p2) -- Line: 19
    local CFrame, CFrame_2, v1, v2, v3, v4
    local v5 = {}
    local v6 = p2
    for i, j in p1:GetDescendants() do
        if j:IsA("BasePart") and j.Transparency < 1 then
            CFrame = v6.CFrame
            CFrame_2 = j.CFrame
            v3 = CFrame:ToObjectSpace(CFrame_2)
            v4 = j.Size * 0.5
            for k = -1, 1, 2 do
                for n = -1, 1, 2 do
                    v2 = v4 * (Vector3.new(k, n, -1))
                    v1 = v3:PointToWorldSpace(v2)
                    table.insert(v5, v1)
                    v2 = v4 * (Vector3.new(k, n, 1))
                    v1 = v3:PointToWorldSpace(v2)
                    table.insert(v5, v1)
                end
            end
        end
    end
    return v5
end

local function meleeRotation(p1, p2) -- Line: 37 -- upvalues: bounds (val), u2 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8
    local v9, v10 = bounds(p1)
    local v11 = v10 - v9
    local v12 = 1
    for i = 2, 3 do
        v4 = u2
        v3 = v4[i]
        v8 = v11:Dot(v3)
        v6 = u2
        v5 = v6[v12]
        if v11:Dot(v5) + 1e-05 < v8 then
            v12 = i
        end
    end
    local v13 = nil
    for j = 1, 3 do
        if j ~= v12 then
            if not v13 then
                v13 = j
            else
                v5 = u2
                v4 = v5[j]
                v2 = v11:Dot(v4)
                v7 = u2
                v6 = v7[v13]
                if v2 < v11:Dot(v6) - 1e-05 then
                    v13 = j
                end
            end
        end
    end
    local v14 = u2[v12]
    local v15 = v10:Dot(v14)
    v8 = -v9:Dot(v14)
    if v15 + 1e-05 < v8 then
        v14 = -v14
    else
        v3 = v15 - v8
        if (math.abs(v3)) <= 1e-05 and v1:VectorToWorldSpace(v14).Y < 0 then
            v14 = -v14
        end
    end
    v2 = u2[v13]
    if v1:VectorToWorldSpace(v2).Z < 0 then
        v2 = -v2
    end
    local fromMatrix = CFrame.fromMatrix
    v5 = v14:Cross(v2)
    return fromMatrix(Vector3.new(0, 0, 0), v5, v14, v2):Inverse()
end

function u0.calculate(p1, p2, p3, p4) -- Line: 74 -- upvalues: meleeRotation (val), u0 (val)
    local v1, v2
    if #p1 == 0 then
        return nil
    end
    local Rotation = p3.Rotation
    if p4 == "HolsterMelee" then
        Rotation = meleeRotation(p1, Rotation)
    end
    local v3 = CFrame.new(p3.Position) * Rotation
    if p4 ~= "HolsterSecondary" then
        v2 = Vector3.new(0, 0, 1)
    else
        v2 = Vector3.new(1, 0, 0)
    end
    local v4 = (1 / 0)
    local v5 = p1
    local v6 = nil
    local v7 = nil
    for i, j in v5, v6, v7 do
        v1 = (v3:PointToWorldSpace(j)):Dot(v2)
        v4 = math.min(v4, v1)
    end
    v5 = (p2:Dot(v2)) * 0.5
    local v8 = u0
    local v9 = v5 + v8.Clearance - v4
    return v3 + v2 * math.max(0, v9)
end

return u0