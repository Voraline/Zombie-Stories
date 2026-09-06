require(script.Parent.Parent.Types)
return function(p1) -- Line: 13
    if typeof(p1) ~= "table" then
        return nil
    end
    if p1.type == "State" then
        return p1
    end
    return nil
end