local evaluate
local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
function evaluate(p1, p2) -- Line: 17 -- upvalues: External (val), evaluate (val)
    if p1.validity == "busy" then
        return External.logError("infiniteLoop")
    end
    local v1 = p1.lastChange == nil
    local v2 = p1.validity == "invalid"
    if v1 then
        local v3
        local v4 = v1 or p2
        if not v4 then
            local dependencySet = p1.dependencySet
            local v5 = nil
            v3 = nil
            for i in dependencySet, v5, v3 do
                evaluate(i, false)
                if p1.lastChange < i.lastChange then
                    v4 = true
                    break
                end
            end
        end
        local v6 = false
        if v4 then
            local dependencySet_2 = p1.dependencySet
            v3 = nil
            local v7 = nil
            for j in dependencySet_2, v3, v7 do
                j.dependentSet[p1] = nil
                p1.dependencySet[j] = nil
            end
            p1.validity = "busy"
            v6 = p1:_evaluate() or v1
        end
        if v6 then
            p1.lastChange = os.clock()
        end
        p1.validity = "valid"
        return v6
    elseif not v2 and not p2 then
        return false
    end
end
return evaluate