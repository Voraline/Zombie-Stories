local u0 = {Clearance = 0.075}
local u2 = {Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), (Vector3.new(0, 0, 1))}
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
    local v1, v2, v3, v4, v5, v6
    local v7 = {}
    local v8 = p2
    for i, j in p1:GetDescendants() do
        if j:IsA("BasePart") and j.Transparency < 1 then
            v5 = v8.CFrame:ToObjectSpace(j.CFrame)
            v6 = j.Size * 0.5
            v1 = 1
            v2 = 2
            for k = -1, v1, v2 do
                v3 = 1
                v4 = 2
                for n = -1, v3, v4 do
                    table.insert(v7, v5:PointToWorldSpace(v6 * Vector3.new(k, n, -1)))
                    table.insert(v7, v5:PointToWorldSpace(v6 * Vector3.new(k, n, 1)))
                end
            end
        end
    end
    return v7
end
local function meleeRotation(p1, p2) -- Line: 37 -- upvalues: bounds (val), u2 (val)
    local v1, v2, v3, v4, v5
    v3, v4 = bounds(p1)
    local v6 = v4 - v3
    local v7 = 1
    local v8 = 3
    local v9 = 1
    for i = 2, v8, v9 do
        v5 = v6:Dot(u2[i])
        if v6:Dot(u2[v7]) + 1e-05 < v5 then
            v7 = i
        end
    end
    v8 = nil
    v9 = 3
    local v10 = 1
    for j = 1, v9, v10 do
        if j ~= v7 then
            if not v8 then
                v8 = j
            else
                v2 = v6:Dot(u2[j])
                if v2 >= v6:Dot(u2[v8]) - 1e-05 then end
            end
        end
    end
    v9 = u2[v7]
    v10 = v4:Dot(v9)
    v5 = -v3:Dot(v9)
    if v10 + 1e-05 < v5 then
        v9 = -v9
    else
        v2 = math.abs(v10 - v5)
        if v2 <= 1e-05 and v1:VectorToWorldSpace(v9).Y < 0 then
            v9 = -v9
        end
    end
    v2 = u2[v8]
    if v1:VectorToWorldSpace(v2).Z < 0 then
        v2 = -v2
    end
    local v11 = v9:Cross(v2)
    return CFrame.fromMatrix(Vector3.new(0, 0, 0), v11, v9, v2):Inverse()
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
        v1 = v3:PointToWorldSpace(j)
        v4 = math.min(v4, v1:Dot(v2))
    end
    return v3 + v2 * math.max(0, p2:Dot(v2) * 0.5 + u0.Clearance - v4)
end
return u0