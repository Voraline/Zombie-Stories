require(script.Parent.Parent.Types)
return function(p1) -- Line: 13
    return {type = "Error", raw = p1, message = p1:gsub("^.+:%d+:%s*", ""), trace = debug.traceback(nil, 2)}
end