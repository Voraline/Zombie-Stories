local u1 = Random.new()
local u2 = table
local u3 = {}

function u3.contains(p1, p2) -- Line: 27 -- upvalues: u3 (val)
    local v1 = u3.indexOf(p1, p2) ~= nil
    return v1
end

function u3.indexOf(p1, p2) -- Line: 32 -- upvalues: u3 (val)
    local v1 = table.find(p1, p2)
    if v1 then
        return v1
    end
    return u3.keyOf(p1, p2)
end

function u3.keyOf(p1, p2) -- Line: 41
    for k, v in pairs(p1) do
        if v == p2 then
            return k
        end
    end
    return nil
end

function u3.insertAndGetIndexOf(p1, p2) -- Line: 51
    p1[#p1 + 1] = p2
    return #p1
end

function u3.skip(p1, p2) -- Line: 57
    return table.move(p1, p2 + 1, #p1, 1, table.create(#p1 - p2))
end

function u3.take(p1, p2) -- Line: 62
    return table.move(p1, 1, p2, 1, table.create(p2))
end

function u3.range(p1, p2, p3) -- Line: 67
    return table.move(p1, p2, p3, 1, table.create(p3 - p2 + 1))
end

function u3.skipAndTake(p1, p2, p3) -- Line: 72
    return table.move(p1, p2 + 1, p2 + p3, 1, table.create(p3))
end

function u3.random(p1) -- Line: 77 -- upvalues: u1 (val)
    local v1 = u1
    local v2 = #p1
    return p1[v1:NextInteger(1, v2)]
end

function u3.join(p1, p2) -- Line: 82
    local v1 = table.create(#p1 + #p2)
    table.move(p1, 1, #p1, 1, v1)
    local move = table.move
    local v2 = #p2
    local v3 = #p1 + 1
    return move(p2, 1, v2, v3, v1)
end

function u3.removeObject(p1, p2) -- Line: 89 -- upvalues: u3 (val)
    local v1 = u3.indexOf(p1, p2)
    if v1 then
        table.remove(p1, v1)
    end
end

local v1 = {
    __index = function(p1, p2) -- Line: 97 -- upvalues: u3 (val), u2 (val)
        if u3[p2] ~= nil then
            return u3[p2]
        end
        return u2[p2]
    end,
    __newindex = function(p1, p2, p3) -- Line: 105
        error("Add new table entries by editing the Module itself.")
    end,
}
return (setmetatable({}, v1))