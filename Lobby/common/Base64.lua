local u0 = {}
local u1 = {}
local v1 = 90
local v2 = 1
for i = 65, v1, v2 do
    table.insert(u0, i)
end
v1 = 122
v2 = 1
for j = 97, v1, v2 do
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
v1 = {}
local rshift = bit32.rshift
local lshift = bit32.lshift
local band = bit32.band
function v1.Encode(p1) -- Line: 38 -- upvalues: rshift (val), band (val), lshift (val), u0 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    local v10 = {}
    local v11 = 0
    local v12 = #p1
    local v13 = 3
    local v14 = p1
    for i = 1, v12, v13 do
        v6, v7, v8 = string.byte(v14, i, i + 2)
        v9 = rshift(v6, 2)
        v3 = band(v6, 3)
        v2 = lshift(v3, 4)
        v1 = v2 + rshift(v7 or 0, 4)
        v4 = band(v7 or 0, 15)
        v3 = lshift(v4, 2)
        v2 = v3 + rshift(v8 or 0, 6)
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
        end
        v10[v11] = v4
        v11 = v11 + 1
        if not v8 then
            v4 = 61
        else
            v4 = u0[v3 + 1]
        end
        v10[v11] = v4
    end
    v12 = {}
    v13 = 0
    v6 = v11
    v7 = 4096
    for j = 1, v6, v7 do
        v13 = v13 + 1
        v5 = j + 4096 - 1
        if v11 >= v5 then
            v4 = v5
        else
            v4 = v11
        end
        v12[v13] = string.char(table.unpack(v10, j, v4))
    end
    return table.concat(v12)
end
function v1.Decode(p1) -- Line: 86 -- upvalues: u1 (val), lshift (val), rshift (val), band (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13
    local v14 = {}
    local v15 = 0
    local v16 = #p1
    local v17 = 4
    local v18 = p1
    for i = 1, v16, v17 do
        v10, v11, v12, v13 = string.byte(v18, i, i + 3)
        v1 = u1[v11] - 1
        v2 = (u1[v12] or 1) - 1
        v3 = (u1[v13] or 1) - 1
        v5 = lshift(u1[v10] - 1, 2)
        v4 = v5 + rshift(v1, 4)
        v7 = band(v1, 15)
        v6 = lshift(v7, 4)
        v5 = v6 + rshift(v2, 2)
        v8 = band(v2, 3)
        v15 = v15 + 1
        v14[v15] = v4
        if v12 ~= 61 then
            v15 = v15 + 1
            v14[v15] = v5
        end
        if v13 ~= 61 then
            v15 = v15 + 1
            v14[v15] = lshift(v8, 6) + v3
        end
    end
    v16 = {}
    v17 = 0
    v10 = v15
    v11 = 4096
    for j = 1, v10, v11 do
        v17 = v17 + 1
        v9 = j + 4096 - 1
        if v15 >= v9 then
            v3 = v9
        else
            v3 = v15
        end
        v16[v17] = string.char(table.unpack(v14, j, v3))
    end
    return table.concat(v16)
end
return v1