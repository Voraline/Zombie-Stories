local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local function whichScopeLivesLonger(p1, p2) -- Line: 15
    local v1, v2, v3, v4, v5
    local v6 = {p1, p2}
    local v7 = {}
    local v8 = 2
    local v9 = 0
    local v10 = {}
    v1, v2 = p1, p2
    while 0 < v8 do
        v3 = v6
        v4 = nil
        v5 = nil
        for i, j in v3, v4, v5 do
            v10[j] = true
            for i2, v in ipairs(j) do
                if v == v1 then
                    return "definitely-b"
                end
                if v == v2 then
                    return "definitely-a"
                end
                if typeof(v) == "table" and v[1] ~= nil and v10[j] == nil then
                    v9 = v9 + 1
                    v7[v9] = v
                end
            end
        end
        table.clear(v6)
        v3 = v7
        v7 = v6
        v6 = v3
        v8 = v9
        v9 = 0
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
    local v2 = 1
    local v3 = -1
    for i = #p1, v2, v3 do
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