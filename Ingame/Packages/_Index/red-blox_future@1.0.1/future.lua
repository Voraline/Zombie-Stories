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
    local ValueList = p1.ValueList
    assert(ValueList, p2)
    local ValueList_2 = p1.ValueList
    return table.unpack(ValueList_2)
end

local function Unwrap(p1) -- Line: 34
    return p1:Expect("Attempt to unwrap pending future!")
end

local function UnwrapOr(p1, ...) -- Line: 38
    if not p1.ValueList then
        return ...
    end
    local ValueList = p1.ValueList
    return table.unpack(ValueList)
end

local function UnwrapOrElse(p1, p2) -- Line: 46
    if not p1.ValueList then
        return p2()
    end
    local ValueList = p1.ValueList
    return table.unpack(ValueList)
end

local function After(p1, p2) -- Line: 54 -- upvalues: Spawn (val)
    if not p1.ValueList then
        local AfterList = p1.AfterList
        table.insert(AfterList, p2)
        return
    end
    local v1 = Spawn
    local ValueList = p1.ValueList
    v1(p2, table.unpack(ValueList))
end

local function Await(p1) -- Line: 62
    if p1.ValueList then
        local ValueList = p1.ValueList
        return table.unpack(ValueList)
    end
    local YieldList = p1.YieldList
    local v1 = coroutine.running()
    table.insert(YieldList, v1)
    return coroutine.yield()
end

local function Future(p1, ...) -- Line: 72
    -- upvalues: IsComplete (val), IsPending (val), Expect (val), Unwrap (val), UnwrapOr (val), UnwrapOrElse (val)
    -- upvalues: After (val), Await (val), Spawn (val)
    local v1 = {
        AfterList = {},
        YieldList = {},
        IsComplete = IsComplete,
        IsPending = IsPending,
        Expect = Expect,
        Unwrap = Unwrap,
        UnwrapOr = UnwrapOr,
        UnwrapOrElse = UnwrapOrElse,
        After = After,
        Await = Await,
    }
    local v2 = Spawn
    v2(function(p1, p2, ...) -- Line: 90 -- upvalues: Spawn (upval)
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