local u1 = Random.new()
local u2 = {}
for k, v in pairs(table) do
    u2[k] = v
end
function u2.contains(p1, p2) -- Line: 30 -- upvalues: u2 (val)
    local v1 = u2.indexOf(p1, p2) ~= nil
    return v1
end
function u2.indexOf(p1, p2) -- Line: 35 -- upvalues: u2 (val)
    local v1 = table.find(p1, p2)
    if v1 then
        return v1
    end
    return u2.keyOf(p1, p2)
end
function u2.keyOf(p1, p2) -- Line: 44
    for k, v in pairs(p1) do
        if v == p2 then
            return k
        end
    end
    return nil
end
function u2.skip(p1, p2) -- Line: 54
    return table.move(p1, p2 + 1, #p1, 1, table.create(#p1 - p2))
end
function u2.take(p1, p2) -- Line: 59
    return table.move(p1, 1, p2, 1, table.create(p2))
end
function u2.range(p1, p2, p3) -- Line: 64
    return table.move(p1, p2, p3, 1, table.create(p3 - p2 + 1))
end
function u2.skipAndTake(p1, p2, p3) -- Line: 69
    return table.move(p1, p2 + 1, p2 + p3, 1, table.create(p3))
end
function u2.random(p1) -- Line: 74 -- upvalues: u1 (val)
    return p1[u1:NextInteger(1, #p1)]
end
function u2.join(p1, p2) -- Line: 79
    local v1 = table.create(#p1 + #p2)
    table.move(p1, 1, #p1, 1, v1)
    return table.move(p2, 1, #p2, #p1 + 1, v1)
end
function u2.removeObject(p1, p2) -- Line: 86 -- upvalues: u2 (val)
    local v1 = u2.indexOf(p1, p2)
    if v1 then
        table.remove(p1, v1)
    end
end
function u2.expand(p1, p2) -- Line: 95
    if p2 < 0 then
        error("Cannot expand a table by a negative amount of objects.")
    end
    local v1 = table.create(#p1 + p2)
    local v2 = #p1
    local v3 = 1
    for i = 1, v2, v3 do
        v1[i] = p1[i]
    end
    return v1
end
return u2