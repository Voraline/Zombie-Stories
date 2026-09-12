local Spawn = require(script.Parent.Spawn)
local u5 = {}
u5.__index = u5

local function Disconnect(p1, p2) -- Line: 23
    if p1.Root == p2 then
        p1.Root = p2.Next
        return
    end
    local Root = p1.Root
    while Root do
        if Root.Next == p2 then
            Root.Next = p2.Next
            return
        end
        Root = Root.Next
    end
end

function u5:Connect(p2) -- Line: 40 -- upvalues: Disconnect (val)
    local u2 = {}
    u2.Next = self.Root
    u2.Callback = p2
    self.Root = u2
    return function() -- Line: 48 -- upvalues: Disconnect (upval), self (val), u2 (val)
        Disconnect(self, u2)
    end
end

function u5.Wait(p1) -- Line: 53
    local u2 = coroutine.running()
    local u3 = nil
    local v1 = p1:Connect(function(...) -- Line: 57 -- upvalues: u3 (ref), u2 (val)
        u3()
        coroutine.resume(u2, ...)
    end)
    v1 = coroutine.yield()
    return v1
end

function u5.Once(p1, p2) -- Line: 65
    local u2 = nil
    u2 = (p1:Connect(function(...) -- Line: 68 -- upvalues: u2 (ref), p2 (val)
        u2()
        p2(...)
    end))
    return u2
end

function u5.Fire(p1, ...) -- Line: 76 -- upvalues: Spawn (val)
    local Root = p1.Root
    while Root do
        Spawn(Root.Callback, ...)
        Root = Root.Next
    end
end

function u5.DisconnectAll(p1) -- Line: 85
    p1.Root = nil
end

return function() -- Line: 89 -- upvalues: u5 (val)
    local v1 = u5
    return (setmetatable({}, v1))
end