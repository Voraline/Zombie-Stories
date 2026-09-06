require("./types")
return function(p1, ...) -- Line: 1
    local v1 = select("#", ...)
    local v2 = 1
    for i = 1, v1, v2 do
        table.insert(p1, select(i, ...))
    end
    return ...
end