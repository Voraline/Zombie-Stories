local u0 = {}

local function RunCallback(p1, p2, ...) -- Line: 3 -- upvalues: u0 (val)
    p1(...)
    local v1 = u0
    table.insert(v1, p2)
end

local function Yielder() -- Line: 8 -- upvalues: RunCallback (val)
    while true do
        RunCallback(coroutine.yield())
    end
end

return function(p1, ...) -- Line: 14 -- upvalues: u0 (val), Yielder (val)
    local v1
    local v2 = #u0
    if not (0 < v2) then
        v1 = coroutine.create(Yielder)
        coroutine.resume(v1)
    else
        v1 = u0[#u0]
        v2 = u0
        local v3 = #u0
        v2[v3] = nil
    end
    task.spawn(v1, p1, v1, ...)
end