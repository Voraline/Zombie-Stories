local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)

local function whichScopeLivesLonger(p1, p2) -- Line: 15
    local v1, v2, v3
    local v4 = {}
    v4[1] = p1
    v4[2] = p2
    local v5 = {}
    local v6 = 2
    local v7 = 0
    local v8 = {}
    local v9, v10 = p1, p2
    while 0 < v6 do
        v1 = v4
        v2 = nil
        v3 = nil
        for i, j in v1, v2, v3 do
            v8[j] = true
            for i2, v in ipairs(j) do
                if v == v9 then
                    return "definitely-b"
                end
                if v == v10 then
                    return "definitely-a"
                end
                if typeof(v) == "table" and v[1] ~= nil and v8[j] == nil then
                    v7 = v7 + 1
                    v5[v7] = v
                end
            end
        end
        table.clear(v4)
        v1 = v5
        v5 = v4
        v4 = v1
        v6 = v7
        v7 = 0
    end
    return "unsure"
end

return function(p1, p2, p3, p4) -- Line: 51 -- upvalues: External (val), whichScopeLivesLonger (val)
    local v1
    if External.isTimeCritical() then
        return "unsure"
    end
    if p1 ~= p3 then
        return (whichScopeLivesLonger(p1, p3))
    end
    for i = #p1, 1, -1 do
        v1 = p1[i]
        if v1 == p2 then
            return "definitely-b"
        end
        if v1 == p4 then
            return "definitely-a"
        end
    end
    return "unsure"
end