local Spawn = require(script.Parent.Spawn)
local function IsComplete(p1) -- Line: 20
    local v1 = p1.ValueList ~= nil
    return v1
end
local function IsPending(p1) -- Line: 24
    local v1 = p1.ValueList == nil
    return v1
end
local function Expect(p1, p2) -- Line: 28
    assert(p1.ValueList, p2)
    return table.unpack(p1.ValueList)
end
local function Unwrap(p1) -- Line: 34
    return p1:Expect("Attempt to unwrap pending future!")
end
local function UnwrapOr(p1, ...) -- Line: 38
    if p1.ValueList then
        return table.unpack(p1.ValueList)
    end
    return ...
end
local function UnwrapOrElse(p1, p2) -- Line: 46
    if p1.ValueList then
        return table.unpack(p1.ValueList)
    end
    return p2()
end
local function After(p1, p2) -- Line: 54 -- upvalues: Spawn (val)
    if p1.ValueList then
        Spawn(p2, table.unpack(p1.ValueList))
        return
    end
    table.insert(p1.AfterList, p2)
end
local function Await(p1) -- Line: 62
    if p1.ValueList then
        return table.unpack(p1.ValueList)
    end
    table.insert(p1.YieldList, coroutine.running())
    return coroutine.yield()
end
local function Future(p1, ...) -- Line: 72 -- upvalues: IsComplete (val), IsPending (val), Expect (val), Unwrap (val), UnwrapOr (val), UnwrapOrElse (val), After (val), Await (val), Spawn (val)
    local v1 = {AfterList = {}}
    local v2 = {}
    v1.YieldList = v2
    v1.IsComplete = IsComplete
    v1.IsPending = IsPending
    v1.Expect = Expect
    v1.Unwrap = Unwrap
    v1.UnwrapOr = UnwrapOr
    v1.UnwrapOrElse = UnwrapOrElse
    v1.After = After
    v1.Await = Await
    Spawn(function(p1, p2, ...) -- Line: 90 -- upvalues: Spawn (upval)
        local v1 = {p2(...)}
        p1.ValueList = v1
        local YieldList = p1.YieldList
        local v2 = nil
        local v3 = nil
        for i, j in YieldList, v2, v3 do
            task.spawn(j, table.unpack(v1))
        end
        local AfterList = p1.AfterList
        v2 = nil
        v3 = nil
        for k, n in AfterList, v2, v3 do
            Spawn(n, table.unpack(v1))
        end
    end, v1, p1, ...)
    return v1
end
return {
    new = Future,
    Try = function(p1, ...) -- Line: 106 -- upvalues: Future (val)
        return Future(pcall, p1, ...)
    end,
}