require("../types/fusion")
return function(p1) -- Line: 6
    local v1 = getmetatable(p1)
    if typeof(v1) == "table" and v1.type == "State" then
        local kind = v1.kind
        if typeof(kind) == "string" then
            return p1
        end
    end
    return nil
end