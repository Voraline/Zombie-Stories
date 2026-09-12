local u0 = {}

function u0.DeepCopy(p1) -- Line: 27 -- upvalues: u0 (val)
    local v1 = table.clone(p1)
    local v2 = v1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if typeof(j) == "table" then
            v1[i] = (u0.DeepCopy(j))
        end
    end
    return v1
end

function u0.MergeDictionary(p1, p2) -- Line: 63
    local v1 = table.clone(p1)
    local v2 = p2
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        v1[i] = j
    end
    return v1
end

function u0.Keys(p1) -- Line: 93
    local v1 = {}
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i in v2, v3, v4 do
        table.insert(v1, i)
    end
    return v1
end

function u0.Values(p1) -- Line: 120
    local v1 = {}
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        table.insert(v1, j)
    end
    return v1
end

function u0.MergeArrays(p1, p2) -- Line: 145
    local v1 = table.clone(p1)
    local move = table.move
    local v2 = #p2
    local v3 = #v1 + 1
    move(p2, 1, v2, v3, v1)
    return v1
end

function u0.Reconcile(p1, p2) -- Line: 177 -- upvalues: u0 (val)
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

function u0.IsArray(p1) -- Line: 213
    local v1 = 0
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i in v2, v3, v4 do
        v1 = v1 + 1
    end
    v2 = v1 == #p1
    return v2
end

function u0.IsDictionary(p1) -- Line: 235
    local v1 = 0
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i in v2, v3, v4 do
        v1 = v1 + 1
    end
    v2 = v1 ~= #p1
    return v2
end

function u0.ToString(p1) -- Line: 264
    local v1, v2, v3, v4
    local v5 = {}
    local v6 = p1
    local v7 = nil
    local v8 = nil
    for i, j in v6, v7, v8 do
        if typeof(i) ~= "string" then
            v2 = tostring(i)
        else
            v1 = tostring(i)
            v2 = ("\"%*\""):format(v1)
        end
        v4 = tostring(j)
        if typeof(j) ~= "string" then
            v3 = v4
        else
            v3 = ("\"%*\""):format(v4)
        end
        v1 = ("\t[%*] = %*"):format(v2, v3)
        table.insert(v5, v1)
    end
    return "{\n" .. (table.concat(v5, "\n")) .. "\n}"
end

function u0.ToArrayString(p1) -- Line: 288
    local v1, v2
    local v3 = {}
    local v4 = p1
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
        v2 = tostring(j)
        if typeof(j) ~= "string" then
            v1 = v2
        else
            v1 = ("\"%*\""):format(v2)
        end
        table.insert(v3, v1)
    end
    return "{" .. (table.concat(v3, ", ")) .. "}"
end

function u0.From(p1) -- Line: 317
    local v1 = typeof(p1)
    if v1 == "string" then
        return string.split(p1, "")
    end
    if v1 == "Color3" then
        return {p1.R, p1.G, p1.B}
    end
    if v1 == "Vector2" then
        return {p1.X, p1.Y}
    end
    if v1 == "Vector3" then
        return {p1.X, p1.Y, p1.Z}
    end
    if v1 == "NumberSequence" then
        return p1.Keypoints
    end
    if v1 == "Vector3int16" then
        return {p1.X, p1.Y, p1.Z}
    end
    if v1 == "Vector2int16" then
        return {p1.X, p1.Y}
    end
    return {p1}
end

function u0.Filter(p1, p2) -- Line: 360
    local v1 = {}
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if p2(j) then
            table.insert(v1, j)
        end
    end
    return v1
end

function u0.Some(p1, p2) -- Line: 387
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

function u0.IsFlat(p1) -- Line: 411
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

function u0.Every(p1, p2) -- Line: 437
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

function u0.HasKey(p1, p2) -- Line: 465
    local v1 = p1[p2] ~= nil
    return v1
end

function u0.HasValue(p1, p2) -- Line: 483
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

function u0.IsEmpty(p1) -- Line: 506
    local v1 = next(p1) == nil
    return v1
end

return table.freeze(u0)