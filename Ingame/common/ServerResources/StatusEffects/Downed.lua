local u0 = {Stacks = false, Refreshes = false}
u0.__index = u0
function u0.new() -- Line: 8 -- upvalues: u0 (val)
    local v1 = {}
    setmetatable(v1, u0)
    v1.Ticks = 0
    v1.MaxTicks = 30
    v1.ClientData = "1"
    return v1
end
function u0.OnServerTick(p1, p2, p3) -- Line: 19
    p1.Ticks = p1.Ticks + 1
    p1.ClientData = string.format("%.2f", 1 - p1.Ticks / p1.MaxTicks)
    p2:WaitForPlayerState(p3)
    if p1.MaxTicks <= p1.Ticks then
        return "Remove"
    end
end
function u0.Destroy(p1) -- Line: 28
    setmetatable(p1, nil)
    table.clear(p1)
    table.freeze(p1)
end
return u0