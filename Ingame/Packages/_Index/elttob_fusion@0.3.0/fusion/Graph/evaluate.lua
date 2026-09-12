local evaluate
local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)

function evaluate(p1, p2) -- Line: 17 -- upvalues: External (val), evaluate (val)
    local v1
    if p1.validity == "busy" then
        return External.logError("infiniteLoop")
    end
    local v2 = p1.lastChange == nil
    local v3 = p1.validity == "invalid"
    if not v2 and not v3 and not p2 then
        return false
    end
    local v4 = v2 or p2
    if not v4 then
        local lastChange
        local dependencySet = p1.dependencySet
        local v5 = nil
        v1 = nil
        for i in dependencySet, v5, v1 do
            evaluate(i, false)
            lastChange = i.lastChange
            if p1.lastChange < lastChange then
                v4 = true
                break
            end
        end
    end
    local v6 = false
    if v4 then
        local dependencySet_2 = p1.dependencySet
        v1 = nil
        local v7 = nil
        for j in dependencySet_2, v1, v7 do
            j.dependentSet[p1] = nil
            p1.dependencySet[j] = nil
        end
        p1.validity = "busy"
        v6 = p1:_evaluate() or v2
    end
    if v6 then
        p1.lastChange = os.clock()
    end
    p1.validity = "valid"
    return v6
end

return evaluate