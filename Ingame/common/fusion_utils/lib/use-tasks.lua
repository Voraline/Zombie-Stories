require("./types")
return function(p1, ...) -- Line: 1
    local v1
    local v2 = select("#", ...)
    for i = 1, v2 do
        v1 = select(i, ...)
        table.insert(p1, v1)
    end
    return ...
end