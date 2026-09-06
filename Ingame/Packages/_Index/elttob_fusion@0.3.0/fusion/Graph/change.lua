local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local evaluate = require(Parent.Graph.evaluate)
return function(p1) -- Line: 23 -- upvalues: External (val), evaluate (val)
    local dependentSet, v1, v2, v3, v4, v5, v6
    if p1.validity == "busy" then
        return External.logError("infiniteLoop")
    end
    if not (evaluate(p1, true)) then
        return
    end
    local v7 = {}
    local v8 = {}
    local v9 = {}
    v7[1] = p1
    local v10 = os.clock() + 1 * External.safetyTimerMultiplier
    while v10 >= os.clock() do
        v3 = true
        v4 = v7
        v5 = nil
        v6 = nil
        for i, j in v4, v5, v6 do
            dependentSet = j.dependentSet
            v1 = nil
            v2 = nil
            for k in dependentSet, v1, v2 do
                if k.validity == "valid" then
                    v3 = false
                    table.insert(v9, k)
                    table.insert(v8, k)
                elseif k.validity == "busy" then
                    return External.logError("infiniteLoop")
                end
            end
        end
        v4 = v8
        v8 = v7
        v7 = v4
        table.clear(v8)
        if v3 then
            v3 = {}
            v4 = v9
            v5 = nil
            v6 = nil
            for n, m in v4, v5, v6 do
                m.validity = "invalid"
                if m.timeliness == "eager" then
                    table.insert(v3, m)
                end
            end
            table.sort(v3, function(p1, p2) -- Line: 73
                local v1 = p1.createdAt < p2.createdAt
                return v1
            end)
            v4 = v3
            v5 = nil
            v6 = nil
            for i5, i6 in v4, v5, v6 do
                evaluate(i6, false)
            end
            return
        end
    end
    return External.logError("infiniteLoop")
end