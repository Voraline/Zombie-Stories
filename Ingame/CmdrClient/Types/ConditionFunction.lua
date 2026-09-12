return function(p1) -- Line: 1
    local v1 = p1.Cmdr.Util.MakeEnumType("ConditionFunction", {"startsWith"})
    p1:RegisterType("conditionFunction", v1)
end