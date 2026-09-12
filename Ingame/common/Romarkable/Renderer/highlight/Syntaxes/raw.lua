local u0 = {}

function u0.scan(p1) -- Line: 13
    local u1 = false
    return function() -- Line: 15 -- upvalues: u1 (ref), p1 (val)
        if u1 then
            return
        end
        u1 = true
        return "raw", p1
    end
end

function u0.navigator() -- Line: 23 -- upvalues: u0 (val)
    local u0_2 = {Source = "", _RealIndex = 0, _UserIndex = 0}
    u0_2.TokenCache = table.create(50)

    function u0_2.Destroy(p1) -- Line: 33
        p1.Source = nil
        p1._RealIndex = nil
        p1._UserIndex = nil
        p1.TokenCache = nil
        p1._ScanThread = nil
    end

    function u0_2.SetSource(p1, p2) -- Line: 41 -- upvalues: u0 (upval)
        p1.Source = p2
        p1._RealIndex = 0
        p1._UserIndex = 0
        table.clear(p1.TokenCache)
        local create = coroutine.create
        p1._ScanThread = create(function() -- Line: 48 -- upvalues: u0 (upval), p1 (val)
            local TokenCache, _RealIndex, v1, v2
            for i, j in u0.scan(p1.Source) do
                v1 = p1
                v1._RealIndex = v1._RealIndex + 1
                v1 = p1
                TokenCache = v1.TokenCache
                v2 = p1
                _RealIndex = v2._RealIndex
                TokenCache[_RealIndex] = {i, j}
                coroutine.yield(i, j)
            end
        end)
    end

    function u0_2.Next() -- Line: 57 -- upvalues: u0_2 (val)
        local v1, v2
        local v3 = u0_2
        v3._UserIndex = v3._UserIndex + 1
        v3 = u0_2
        local _RealIndex = v3._RealIndex
        if u0_2._UserIndex <= _RealIndex then
            v2 = u0_2
            local TokenCache = v2.TokenCache
            local v4 = u0_2
            v1 = TokenCache[v4._UserIndex]
            return table.unpack(v1)
        end
        if coroutine.status(u0_2._ScanThread) == "dead" then
            return
        end
        v3, v1, v2 = coroutine.resume(u0_2._ScanThread)
        if v3 and v1 then
            return v1, v2
        end
    end

    function u0_2.Peek(p1) -- Line: 80 -- upvalues: u0_2 (val)
        local v1, v2, v3, v4
        local v5 = u0_2._UserIndex + p1
        if v5 <= u0_2._RealIndex then
            if not (0 < v5) then
                return
            end
            v3 = u0_2
            local v6 = v3.TokenCache[v5]
            return table.unpack(v6)
        end
        if coroutine.status(u0_2._ScanThread) == "dead" then
            return
        end
        local v7 = v5 - u0_2._RealIndex
        v3 = nil
        local v8 = nil
        local v9 = v7
        for i = 1, v9 do
            v4, v1, v2 = coroutine.resume(u0_2._ScanThread)
            v3 = v1
            v8 = v2
            if not v4 and not v3 then
                break
            end
        end
        return v3, v8
    end

    return u0_2
end

return u0