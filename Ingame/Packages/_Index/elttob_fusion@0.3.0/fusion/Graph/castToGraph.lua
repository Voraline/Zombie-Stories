require(script.Parent.Parent.Types)
return function(p1) -- Line: 13
    if typeof(p1) ~= "table" or typeof(p1.validity) ~= "string" or typeof(p1.timeliness) ~= "string" or typeof(p1.dependencySet) ~= "table" then
        return nil
    end
    if typeof(p1.dependentSet) == "table" then
        return p1
    end
    return nil
end