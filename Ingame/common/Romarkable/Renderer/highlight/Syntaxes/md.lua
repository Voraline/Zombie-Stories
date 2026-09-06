local u0 = {}
local u1 = {}
local v1 = {"^[%c%s]*#+ .-\n[%c%s]*", "header"}
local v2 = {"^[%c%s]*> .-\n\n[%c%s]*", "quote"}
local v3 = {"^[%c%s]*```%w-\n.-```[%c%s]*", "code"}
local v4 = {"^[%c%s]*%* .-\n[%c%s]*", "list"}
local v5 = {"^[%c%s]*%d[%.)] .-\n[%c%s]*", "list"}
local v6 = {"^[%c%s]*[%w \t]+[%c%s]*", "text"}
local v7 = {"^.", "text"}
u1[1] = v1
u1[2] = {"^[%c%s]*%.-\n%-%-%-\n[%c%s]*", "header"}
u1[3] = v2
u1[4] = v3
u1[5] = v4
u1[6] = v5
u1[7] = {"^[%c%s]*%-%-%-%-%-*\n?[%c%s]*", "ruler"}
u1[8] = v6
u1[9] = v7
function u0.scan(p1) -- Line: 55 -- upvalues: u0 (val), u1 (val)
    u0.finished = false
    local u3 = 1
    local u4 = #p1
    return function() -- Line: 62 -- upvalues: u3 (ref), u4 (val), u1 (upval), p1 (val), u0 (upval)
        local v1, v2, v3, v4
        if u3 > u4 then
            return
        end
        for i, v in ipairs(u1) do
            v1, v2 = string.find(p1, v[1], u3)
            if v1 then
                v3 = string.sub(p1, v1, v2)
                u3 = v2 + 1
                v4 = u4 < u3
                u0.finished = v4
                return v[2], v3
            end
        end
    end
end
function u0.navigator() -- Line: 78 -- upvalues: u0 (val)
    local u0 = {
        Source = "",
        _RealIndex = 0,
        _UserIndex = 0,
        TokenCache = table.create(50),
        Destroy = function(p1) -- Line: 88
            p1.Source = nil
            p1._RealIndex = nil
            p1._UserIndex = nil
            p1.TokenCache = nil
            p1._ScanThread = nil
        end,
    }
    function u0.SetSource(p1, p2) -- Line: 96 -- upvalues: u0 (upval)
        p1.Source = p2
        p1._RealIndex = 0
        p1._UserIndex = 0
        table.clear(p1.TokenCache)
        p1._ScanThread = coroutine.create(function() -- Line: 103 -- upvalues: u0 (upval), p1 (val)
            local v1
            for i, j in u0.scan(p1.Source) do
                v1 = p1
                v1._RealIndex = v1._RealIndex + 1
                p1.TokenCache[p1._RealIndex] = {i, j}
                coroutine.yield(i, j)
            end
        end)
    end
    function u0.Next() -- Line: 112 -- upvalues: u0 (val)
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
    function u0.Peek(p1) -- Line: 135 -- upvalues: u0 (val)
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