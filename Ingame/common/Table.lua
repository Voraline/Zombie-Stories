local u0 = {}

function u0.append(p1, p2) -- Line: 15
    for k, v in pairs(p2) do
        p1[#p1 + 1] = v
    end
    return p1
end

function u0.merge(p1, p2) -- Line: 30
    local v1 = {}
    for k, v in pairs(p1) do
        v1[k] = v
    end
    for k2, i in pairs(p2) do
        v1[k2] = i
    end
    return v1
end

function u0.reverse(p1) -- Line: 47
    local v1
    local v2 = {}
    for i = #p1, 1, -1 do
        v1 = p1[i]
        table.insert(v2, v1)
    end
    return v2
end

function u0.values(p1) -- Line: 61
    local v1 = {}
    for k, v in pairs(p1) do
        table.insert(v1, v)
    end
    return v1
end

function u0.keys(p1) -- Line: 75
    local v1 = {}
    for k, v in pairs(p1) do
        table.insert(v1, k)
    end
    return v1
end

function u0.mergeLists(p1, p2) -- Line: 90
    local v1 = {}
    for k, v in pairs(p1) do
        table.insert(v1, v)
    end
    for k2, i in pairs(p2) do
        table.insert(v1, i)
    end
    return v1
end

function u0.swapKeyValue(p1) -- Line: 107
    local v1 = {}
    for k, v in pairs(p1) do
        v1[v] = k
    end
    return v1
end

function u0.toList(p1) -- Line: 121
    local v1 = {}
    for k, v in pairs(p1) do
        table.insert(v1, v)
    end
    return v1
end

function u0.count(p1) -- Line: 136
    local v1 = 0
    for k, v in pairs(p1) do
        v1 = v1 + 1
    end
    return v1
end

u0.copy = table.clone

function u0.deepCopy(p1, p2) -- Line: 161 -- upvalues: u0 (val)
    local v1
    local v2 = p2 or {}
    local v3 = v2
    if v3[p1] then
        return v3[p1]
    end
    if type(p1) ~= "table" then
        return p1
    end
    v2 = {}
    v3[p1] = v2
    for k, v in pairs(p1) do
        v1 = u0.deepCopy(k, v3)
        v2[v1] = (u0.deepCopy(v, v3))
    end
    local v4 = u0
    v4 = v4.deepCopy(getmetatable(p1), v3)
    return (setmetatable(v2, v4))
end

function u0.deepOverwrite(p1, p2) -- Line: 185 -- upvalues: u0 (val)
    local v1
    local v2 = p1
    for k, v in pairs(p2) do
        v1 = v2[k]
        if type(v1) ~= "table" or type(v) ~= "table" then
            v2[k] = v
        else
            v2[k] = (u0.deepOverwrite(v2[k], v))
        end
    end
    return v2
end

function u0.getIndex(p1, p2) -- Line: 203
    local v1 = p2 ~= nil
    assert(v1, "Needle cannot be nil")
    for k, v in pairs(p1) do
        if p2 == v then
            return k
        end
    end
    return nil
end

function u0.stringify(p1, p2, p3) -- Line: 222 -- upvalues: u0 (val)
    local v1
    local v2 = p3
    if not v2 then
        v2 = tostring(p1)
    end
    local v3 = v2
    local v4 = p2 or 0
    for k, v in pairs(p1) do
        v1 = "\n" .. (string.rep("  ", v4)) .. (tostring(k)) .. ": "
        if type(v) ~= "table" then
            v3 = v3 .. v1 .. tostring(v)
        else
            v3 = v3 .. v1
            v3 = u0.stringify(v, v4 + 1, v3)
        end
    end
    return v3
end

function u0.contains(p1, p2) -- Line: 244
    for k, v in pairs(p1) do
        if v == p2 then
            return true
        end
    end
    return false
end

function u0.overwrite(p1, p2) -- Line: 261
    for k, v in pairs(p2) do
        p1[k] = v
    end
    return p1
end

function u0.take(p1, p2) -- Line: 278
    local v1 = {}
    local v2 = #p1
    local v3 = math.min(v2, p2)
    for i = 1, v3 do
        v1[i] = p1[i]
    end
    return v1
end

local function errorOnIndex(p1, p2) -- Line: 286
    local v1 = error
    local v2 = tostring(p2)
    v1(("Bad index %q"):format(v2), 2)
end

local u19 = {}
u19.__index = errorOnIndex
u19.__newindex = errorOnIndex

function u0.readonly(p1) -- Line: 302 -- upvalues: u19 (val)
    local v1 = u19
    return (setmetatable(p1, v1))
end

function u0.deepReadonly(p1) -- Line: 312 -- upvalues: u0 (val)
    for k, v in pairs(p1) do
        if type(v) == "table" then
            u0.deepReadonly(v)
        end
    end
    return u0.readonly(p1)
end

return u0