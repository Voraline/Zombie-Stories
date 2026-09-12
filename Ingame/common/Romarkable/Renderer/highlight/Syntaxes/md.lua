local u0 = {}
local u1 = {
    {"^[%c%s]*#+ .-\n[%c%s]*", "header"},
    {"^[%c%s]*%.-\n%-%-%-\n[%c%s]*", "header"},
    {"^[%c%s]*> .-\n\n[%c%s]*", "quote"},
    {"^[%c%s]*```%w-\n.-```[%c%s]*", "code"},
    {"^[%c%s]*%* .-\n[%c%s]*", "list"},
    {"^[%c%s]*%d[%.)] .-\n[%c%s]*", "list"},
    {"^[%c%s]*%-%-%-%-%-*\n?[%c%s]*", "ruler"},
    {"^[%c%s]*[%w \t]+[%c%s]*", "text"},
    {"^.", "text"},
}

function u0.scan(p1) -- Line: 55 -- upvalues: u0 (val), u1 (val)
    u0.finished = false
    local u3 = 1
    local u4 = #p1
    return function() -- Line: 62 -- upvalues: u3 (ref), u4 (val), u1 (upval), p1 (val), u0 (upval)
        if u3 <= u4 then
            local v1, v2, v3, v4, v5, v6
            for i, v in ipairs(u1) do
                v2, v3 = string.find(p1, v[1], u3)
                if v2 then
                    v5 = p1
                    v4 = string.sub(v5, v2, v3)
                    u3 = v3 + 1
                    v5 = u0
                    v1 = u3
                    v6 = u4 < v1
                    v5.finished = v6
                    return v[2], v4
                end
            end
        end
    end
end

function u0.navigator() -- Line: 78 -- upvalues: u0 (val)
    local u0_2 = {Source = "", _RealIndex = 0, _UserIndex = 0}
    u0_2.TokenCache = table.create(50)

    function u0_2.Destroy(p1) -- Line: 88
        p1.Source = nil
        p1._RealIndex = nil
        p1._UserIndex = nil
        p1.TokenCache = nil
        p1._ScanThread = nil
    end

    function u0_2.SetSource(p1, p2) -- Line: 96 -- upvalues: u0 (upval)
        p1.Source = p2
        p1._RealIndex = 0
        p1._UserIndex = 0
        table.clear(p1.TokenCache)
        local create = coroutine.create
        p1._ScanThread = create(function() -- Line: 103 -- upvalues: u0 (upval), p1 (val)
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

    function u0_2.Next() -- Line: 112 -- upvalues: u0_2 (val)
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

    function u0_2.Peek(p1) -- Line: 135 -- upvalues: u0_2 (val)
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