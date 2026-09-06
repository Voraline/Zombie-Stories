local u0 = nil
local function passer(p1, ...) -- Line: 3 -- upvalues: u0 (ref)
    u0 = nil
    p1(...)
    u0 = u0
end
local function yielder() -- Line: 10 -- upvalues: passer (val)
    while true do
        passer(coroutine.yield())
    end
end
return function(p1, ...) -- Line: 16 -- upvalues: u0 (ref), yielder (val)
    if u0 == nil then
        u0 = coroutine.create(yielder)
        coroutine.resume(u0)
    end
    task.spawn(u0, p1, ...)
end