local u0 = {
    append = function(p1, p2) -- Line: 15
        for k, v in pairs(p2) do
            p1[#p1 + 1] = v
        end
        return p1
    end,
    merge = function(p1, p2) -- Line: 30
        local v1 = {}
        for k, v in pairs(p1) do
            v1[k] = v
        end
        for k2, i in pairs(p2) do
            v1[k2] = i
        end
        return v1
    end,
    reverse = function(p1) -- Line: 47
        local v1 = {}
        local v2 = 1
        local v3 = -1
        for i = #p1, v2, v3 do
            table.insert(v1, p1[i])
        end
        return v1
    end,
    values = function(p1) -- Line: 61
        local v1 = {}
        for k, v in pairs(p1) do
            table.insert(v1, v)
        end
        return v1
    end,
    keys = function(p1) -- Line: 75
        local v1 = {}
        for k, v in pairs(p1) do
            table.insert(v1, k)
        end
        return v1
    end,
    mergeLists = function(p1, p2) -- Line: 90
        local v1 = {}
        for k, v in pairs(p1) do
            table.insert(v1, v)
        end
        for k2, i in pairs(p2) do
            table.insert(v1, i)
        end
        return v1
    end,
    swapKeyValue = function(p1) -- Line: 107
        local v1 = {}
        for k, v in pairs(p1) do
            v1[v] = k
        end
        return v1
    end,
    toList = function(p1) -- Line: 121
        local v1 = {}
        for k, v in pairs(p1) do
            table.insert(v1, v)
        end
        return v1
    end,
    count = function(p1) -- Line: 136
        local v1 = 0
        for k, v in pairs(p1) do
            v1 = v1 + 1
        end
        return v1
    end,
    copy = table.clone,
}
function u0.deepCopy(p1, p2) -- Line: 161 -- upvalues: u0 (val)
    local v1
    local v2 = p2
    if not v2 then
        v2 = {}
    end
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
        v2[v1] = u0.deepCopy(v, v3)
    end
    local v4 = getmetatable(p1)
    return (setmetatable(v2, u0.deepCopy(v4, v3)))
end
function u0.deepOverwrite(p1, p2) -- Line: 185 -- upvalues: u0 (val)
    local v1 = p1
    for k, v in pairs(p2) do
        if type(v1[k]) ~= "table" then
            v1[k] = v
        elseif type(v) == "table" then
            v1[k] = u0.deepOverwrite(v1[k], v)
        end
    end
    return v1
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
    local v1, v2, v3
    local v4 = p3
    if not v4 then
        v4 = tostring(p1)
    end
    local v5 = v4
    local v6 = p2 or 0
    for k, v in pairs(p1) do
        v1 = string.rep("  ", v6)
        v2 = tostring(k)
        v3 = "\n" .. v1 .. v2 .. ": "
        if type(v) ~= "table" then
            v5 = v5 .. v3 .. tostring(v)
        else
            v5 = v5 .. v3
            v5 = u0.stringify(v, v6 + 1, v5)
        end
    end
    return v5
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
    local v2 = math.min(#p1, p2)
    local v3 = 1
    for i = 1, v2, v3 do
        v1[i] = p1[i]
    end
    return v1
end
local function errorOnIndex(p1, p2) -- Line: 286
    local v1 = ("Bad index %q"):format((tostring(p2)))
    error(v1, 2)
end
local u19 = {__index = errorOnIndex, __newindex = errorOnIndex}
function u0.readonly(p1) -- Line: 302 -- upvalues: u19 (val)
    return (setmetatable(p1, u19))
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