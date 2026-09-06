local u0 = {
    scan = function(p1) -- Line: 13
        local u1 = false
        return function() -- Line: 15 -- upvalues: u1 (ref), p1 (val)
            if u1 then
                return
            end
            u1 = true
            return "raw", p1
        end
    end,
}
function u0.navigator() -- Line: 23 -- upvalues: u0 (val)
    local u0 = {
        Source = "",
        _RealIndex = 0,
        _UserIndex = 0,
        TokenCache = table.create(50),
        Destroy = function(p1) -- Line: 33
            p1.Source = nil
            p1._RealIndex = nil
            p1._UserIndex = nil
            p1.TokenCache = nil
            p1._ScanThread = nil
        end,
    }
    function u0.SetSource(p1, p2) -- Line: 41 -- upvalues: u0 (upval)
        p1.Source = p2
        p1._RealIndex = 0
        p1._UserIndex = 0
        table.clear(p1.TokenCache)
        p1._ScanThread = coroutine.create(function() -- Line: 48 -- upvalues: u0 (upval), p1 (val)
            local v1
            for i, j in u0.scan(p1.Source) do
                v1 = p1
                v1._RealIndex = v1._RealIndex + 1
                p1.TokenCache[p1._RealIndex] = {i, j}
                coroutine.yield(i, j)
            end
        end)
    end
    function u0.Next() -- Line: 57 -- upvalues: u0 (val)
        local v1, v2
        local v3 = u0
        v3._UserIndex = v3._UserIndex + 1
        if u0._UserIndex <= u0._RealIndex then
            return table.unpack(u0.TokenCache[u0._UserIndex])
        end
        if coroutine.status(u0._ScanThread) == "dead" then
            return
        end
        v3, v1, v2 = coroutine.resume(u0._ScanThread)
        if not v3 then
            return
        end
        if v1 then
            return v1, v2
        end
    end
    function u0.Peek(p1) -- Line: 80 -- upvalues: u0 (val)
        local v1, v2, v3
        local v4 = u0._UserIndex + p1
        if v4 <= u0._RealIndex then
            if 0 < v4 then
                return table.unpack(u0.TokenCache[v4])
            end
            return
        end
        if coroutine.status(u0._ScanThread) == "dead" then
            return
        end
        local v5 = nil
        local v6 = nil
        local v7 = v4 - u0._RealIndex
        local v8 = 1
        for i = 1, v7, v8 do
            v3, v1, v2 = coroutine.resume(u0._ScanThread)
            v5 = v1
            v6 = v2
            if not v3 and not v5 then
                break
            end
        end
        return v5, v6
    end
    return u0
end
return u0