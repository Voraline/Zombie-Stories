local Parent_2 = script.Parent.Parent
require(Parent_2.PubTypes)
return {
    type = "SpecialKey",
    kind = "Cleanup",
    stage = "observer",
    apply = function(p1, p2, p3, p4) -- Line: 16
        table.insert(p4, p2)
    end,
}