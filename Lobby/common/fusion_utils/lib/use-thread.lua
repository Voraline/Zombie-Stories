require("./types/fusion")
return function(p1, p2, ...) -- Line: 10
    local u5 = task.spawn(p2, ...)
    table.insert(p1, function() -- Line: 16 -- upvalues: u5 (val)
        task.cancel(u5)
    end)
    return u5
end