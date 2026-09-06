require(script.Parent.Parent.PubTypes)
return function(p1) -- Line: 17
    local dependentSet_2, dependentSet_3, v1, v2, v3
    local v4 = {}
    local v5 = {}
    local v6 = {}
    local v7 = 0
    local v8 = 1
    local dependentSet = p1.dependentSet
    local v9 = nil
    local v10 = nil
    for i in dependentSet, v9, v10 do
        v7 = v7 + 1
        v6[v7] = i
        v5[i] = true
    end
    while v8 <= v7 do
        v2 = v6[v8]
        v9 = v4[v2]
        if v9 ~= nil then
            v10 = v9 + 1
        else
            v10 = 1
        end
        v4[v2] = v10
        if v2.dependentSet ~= nil then
            dependentSet_2 = v2.dependentSet
            v3 = nil
            v1 = nil
            for j in dependentSet_2, v3, v1 do
                v7 = v7 + 1
                v6[v7] = j
            end
        end
        v8 = v8 + 1
    end
    v8 = 1
    while v8 <= v7 do
        v2 = v6[v8]
        v9 = v4[v2] - 1
        v4[v2] = v9
        if v9 == 0 and v5[v2] and v2:update() and v2.dependentSet ~= nil then
            dependentSet_3 = v2.dependentSet
            v3 = nil
            v1 = nil
            for k in dependentSet_3, v3, v1 do
                v5[k] = true
            end
        end
        v8 = v8 + 1
    end
end