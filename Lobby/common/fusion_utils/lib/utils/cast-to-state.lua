require("../types/fusion")
return function(p1) -- Line: 6
    local v1 = getmetatable(p1)
    if typeof(v1) ~= "table" or v1.type ~= "State" then
        return nil
    end
    if typeof(v1.kind) == "string" then
        return p1
    end
    return nil
end