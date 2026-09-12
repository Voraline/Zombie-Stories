local Parent_2 = script.Parent.Parent
require(Parent_2.Types)
return function(p1) -- Line: 13
    if typeof(p1) == "table" and p1.type == "State" then
        return p1
    end
    return nil
end