local u0 = {}
local u1 = {}
for i = 65, 90 do
    table.insert(u0, i)
end
for j = 97, 122 do
    table.insert(u0, j)
end
table.insert(u0, 48)
table.insert(u0, 49)
table.insert(u0, 50)
table.insert(u0, 51)
table.insert(u0, 52)
table.insert(u0, 53)
table.insert(u0, 54)
table.insert(u0, 55)
table.insert(u0, 56)
table.insert(u0, 57)
table.insert(u0, 43)
table.insert(u0, 47)
for i2, v in ipairs(u0) do
    u1[v] = i2
end
local v1 = {}
local rshift = bit32.rshift
local lshift = bit32.lshift
local band = bit32.band

function v1.Encode(p1) -- Line: 38 -- upvalues: rshift (val), band (val), lshift (val), u0 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    local v10 = {}
    local v11 = 0
    local v12 = #p1
    local v13 = p1
    for i = 1, v12, 3 do
        v9 = i + 2
        v6, v7, v8 = string.byte(v13, i, v9)
        v9 = rshift(v6, 2)
        v3 = band(v6, 3)
        v1 = (lshift(v3, 4)) + rshift(v7 or 0, 4)
        v4 = band(v7 or 0, 15)
        v2 = (lshift(v4, 2)) + rshift(v8 or 0, 6)
        v3 = band(v8 or 0, 63)
        v11 = v11 + 1
        v10[v11] = u0[v9 + 1]
        v11 = v11 + 1
        v10[v11] = u0[v1 + 1]
        v11 = v11 + 1
        if not v7 then
            v4 = 61
        else
            v4 = u0[v2 + 1]
            if not v4 then
                v4 = 61
            end
        end
        v10[v11] = v4
        v11 = v11 + 1
        if not v8 then
            v4 = 61
        else
            v4 = u0[v3 + 1]
            if not v4 then
                v4 = 61
            end
        end
        v10[v11] = v4
    end
    v12 = {}
    local v14 = 0
    v6 = v11
    for j = 1, v6, 4096 do
        v14 = v14 + 1
        v5 = j + 4096 - 1
        v4 = v11 < v5 and v11 or v5
        v1 = table.unpack(v10, j, v4)
        v12[v14] = (string.char(v1))
    end
    return table.concat(v12)
end

function v1.Decode(p1) -- Line: 86 -- upvalues: u1 (val), lshift (val), rshift (val), band (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
    local v15 = {}
    local v16 = 0
    local v17 = #p1
    local v18 = p1
    for i = 1, v17, 4 do
        v14 = i + 3
        v11, v12, v13, v14 = string.byte(v18, i, v14)
        v1 = u1[v11] - 1
        v2 = u1[v12] - 1
        v3 = (u1[v13] or 1) - 1
        v4 = (u1[v14] or 1) - 1
        v5 = (lshift(v1, 2)) + rshift(v2, 4)
        v8 = band(v2, 15)
        v6 = (lshift(v8, 4)) + rshift(v3, 2)
        v9 = band(v3, 3)
        v7 = lshift(v9, 6) + v4
        v16 = v16 + 1
        v15[v16] = v5
        if v13 ~= 61 then
            v16 = v16 + 1
            v15[v16] = v6
        end
        if v14 ~= 61 then
            v16 = v16 + 1
            v15[v16] = v7
        end
    end
    v17 = {}
    local v19 = 0
    v11 = v16
    for j = 1, v11, 4096 do
        v19 = v19 + 1
        v10 = j + 4096 - 1
        v4 = v16 < v10 and v16 or v10
        v1 = table.unpack(v15, j, v4)
        v17[v19] = (string.char(v1))
    end
    return table.concat(v17)
end

return v1