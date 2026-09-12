local deepCopyInner
local u0 = {}

function deepCopyInner(p1, p2) -- Line: 32 -- upvalues: deepCopyInner (val)
    local v1
    if typeof(p1) ~= "table" then
        return p1
    end
    local v2 = p2[p1]
    if v2 then
        return v2
    end
    local v3 = table.create(#p1)
    p2[p1] = v3
    local v4 = p1
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
        v1 = deepCopyInner(i, p2)
        v3[v1] = (deepCopyInner(j, p2))
    end
    v4 = getmetatable(p1)
    if v4 ~= nil then
        local v7 = deepCopyInner
        v7 = v7(v4, p2)
        setmetatable(v3, v7)
    end
    if table.isfrozen and table.isfrozen(p1) then
        table.freeze(v3)
    end
    return v3
end

function u0.DeepCopy(p1) -- Line: 62 -- upvalues: deepCopyInner (val)
    return (deepCopyInner(p1, {}))
end

function u0.MergeDictionary(p1, p2) -- Line: 92
    local v1 = table.clone(p1)
    local v2 = p2
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        v1[i] = j
    end
    return v1
end

function u0.Keys(p1) -- Line: 119
    local v1 = {}
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        table.insert(v1, i)
    end
    return v1
end

function u0.Values(p1) -- Line: 146
    local v1 = {}
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        table.insert(v1, j)
    end
    return v1
end

function u0.MergeArray(p1, p2) -- Line: 170
    local v1 = table.clone(p1)
    local v2 = p2
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        table.insert(v1, j)
    end
    return v1
end

function u0.Reconcile(p1, p2) -- Line: 205 -- upvalues: u0 (val)
    local v1
    local v2 = table.clone(p1)
    local v3 = p2
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        if v2[i] ~= nil then
            v1 = p2[i]
            if typeof(v1) == "table" then
                if typeof(j) ~= "table" then
                    v2[i] = (u0.DeepCopy(p2[i]))
                else
                    v2[i] = (u0.Reconcile(j, p2[i]))
                end
            end
        elseif typeof(j) ~= "table" then
            v2[i] = j
        else
            v2[i] = (u0.DeepCopy(j))
        end
    end
    return v2
end

function u0.IsArray(p1) -- Line: 241
    local v1 = 0
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        v1 = v1 + 1
    end
    v2 = v1 == #p1
    return v2
end

function u0.IsDictionary(p1) -- Line: 263 -- upvalues: u0 (val)
    return not u0.IsArray(p1)
end

function u0.ToString(p1) -- Line: 288
    local v1, v2
    local v3 = ""
    local v4 = p1
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
        v1 = tostring(i)
        v2 = tostring(j)
        v3 = v3 .. (string.format("[%*]: %*\n", v1, v2))
    end
    return v3
end

function u0.From(p1) -- Line: 313
    if typeof(p1) == "string" then
        local v1
        local v2 = {}
        local v3 = string.len(p1)
        for i = 1, v3 do
            v1 = string.sub(p1, i, i)
            table.insert(v2, v1)
        end
        return v2
    end
    if typeof(p1) == "Color3" then
        return {p1.R, p1.G, p1.B}
    end
    if typeof(p1) == "Vector2" then
        return {p1.X, p1.Y}
    end
    if typeof(p1) == "Vector3" then
        return {p1.X, p1.Y, p1.Z}
    end
    if typeof(p1) == "NumberSequence" then
        return p1.Keypoints
    end
    if typeof(p1) == "Vector3int16" then
        return {p1.X, p1.Y, p1.Z}
    end
    if typeof(p1) == "Vector2int16" then
        return {p1.X, p1.Y}
    end
    return {p1}
end

function u0.Filter(p1, p2) -- Line: 350
    local v1 = table.clone(p1)
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if p2(j) then
            table.remove(v1, i)
        end
    end
    return v1
end

function u0.Some(p1, p2) -- Line: 377
    local v1 = p1
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if p2(j) == true then
            return true
        end
    end
    return false
end

function u0.IsFlat(p1) -- Line: 402
    local v1 = p1
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if typeof(j) == "table" then
            return false
        end
    end
    return true
end

function u0.Every(p1, p2) -- Line: 428
    local v1 = p1
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if not p2(j) then
            return false, i
        end
    end
    return true
end

function u0.HasKey(p1, p2) -- Line: 456
    local v1 = p1
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if i == p2 then
            return true
        end
    end
    return false
end

function u0.HasValue(p1, p2) -- Line: 479
    local v1 = p1
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if j == p2 then
            return true
        end
    end
    return false
end

function u0.IsEmpty(p1) -- Line: 502
    local v1 = next(p1) == nil
    return v1
end

return u0