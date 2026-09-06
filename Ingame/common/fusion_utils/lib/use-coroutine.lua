require("./types/fusion")
return function(p1, p2, ...) -- Line: 10
    local u9 = if typeof(p2) == "function" then coroutine.create(p2) else p2
    coroutine.resume(u9, ...)
    table.insert(p1, function() -- Line: 21 -- upvalues: u9 (ref)
        if coroutine.status(u9) ~= "dead" then
            coroutine.close(u9)
        end
    end)
    return u9
end