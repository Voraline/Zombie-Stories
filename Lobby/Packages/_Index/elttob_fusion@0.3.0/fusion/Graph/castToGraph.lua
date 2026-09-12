local Parent_2 = script.Parent.Parent
require(Parent_2.Types)
return function(p1) -- Line: 13
    if typeof(p1) == "table" then
        local validity = p1.validity
        if typeof(validity) == "string" then
            local timeliness = p1.timeliness
            if typeof(timeliness) == "string" then
                local dependencySet = p1.dependencySet
                if typeof(dependencySet) == "table" then
                    local dependentSet = p1.dependentSet
                    if typeof(dependentSet) == "table" then
                        return p1
                    end
                end
            end
        end
    end
    return nil
end