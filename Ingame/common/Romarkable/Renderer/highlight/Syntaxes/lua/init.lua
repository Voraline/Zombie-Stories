local u0 = {}
local v1 = require("@self/language")
local keyword = v1.keyword
local builtin = v1.builtin
local libraries = v1.libraries
local u7 = {
    {"^[%c%s]*[%a_][%w_]*[%c%s]*", "var"},
    {"^[%c%s]*0x[%da-fA-F]+[%c%s]*", "number"},
    {"^[%c%s]*%d+%.?%d*[eE][%+%-]?%d+[%c%s]*", "number"},
    {"^[%c%s]*%d+[%._]?[%d_eE]*[%c%s]*", "number"},
    {"^[%c%s]*(['\"])%1[%c%s]*", "string"},
    {"^[%c%s]*(['\"])[^\n]-([^\\]%1)[%c%s]*", "string"},
    {"^[%c%s]*(['\"]).-\n[%c%s]*", "string"},
    {"^[%c%s]*(['\"])[^\n]*[%c%s]*", "string"},
    {"^[%c%s]*%[(=*)%[.-%]%1%][%c%s]*", "string"},
    {"^[%c%s]*%[=*%[.-.*[%c%s]*", "string"},
    {"^[%c%s]*%-%-%[(=*)%[.-%]%1%][%c%s]*", "comment"},
    {"^[%c%s]*%-%-%[=*%[.-.*[%c%s]*", "comment"},
    {"^[%c%s]*%-%-.-\n[%c%s]*", "comment"},
    {"^[%c%s]*%-%-.*[%c%s]*", "comment"},
    {"^[%c%s]*[:;<>/~%*%(%)%-={},%.#%^%+%%]+[%c%s]*", "operator"},
    {"^[%c%s]*[%[%]]+[%c%s]*", "operator"},
    {"^[%c%s]*[%z\001-\127Â-ô][€-¿]+[%c%s]*", "iden"},
    {"^.", "iden"},
}

function u0.scan(p1) -- Line: 92 -- upvalues: u0 (val), u7 (val), keyword (val), builtin (val), libraries (val)
    u0.finished = false
    local u3 = 1
    local u4 = #p1
    local u5 = ""
    local u6 = ""
    local u7_2 = ""
    local u8 = ""
    return function() -- Line: 100
        -- upvalues: u3 (ref), u4 (val), u7 (upval), p1 (val), u0 (upval), keyword (upval), builtin (upval), u5 (ref)
        -- upvalues: u8 (ref), u6 (ref), libraries (upval), u7_2 (ref)
        if u3 <= u4 then
            local v1, v2, v3, v4, v5, v6, v7, v8
            for i, v in ipairs(u7) do
                v4, v5 = string.find(p1, v[1], u3)
                if v4 then
                    v7 = p1
                    v6 = string.sub(v7, v4, v5)
                    u3 = v5 + 1
                    v7 = u0
                    v1 = u3
                    v8 = u4 < v1
                    v7.finished = v8
                    v7 = v[2]
                    v8 = v7
                    if v7 == "var" then
                        v1 = string.gsub(v6, "[%c%s]+", "")
                        if keyword[v1] then
                            v8 = "keyword"
                        elseif not builtin[v1] then
                            v8 = "iden"
                        else
                            v8 = "builtin"
                        end
                        if string.find(u5, "%.[%s%c]*$") and u8 ~= "comment" then
                            v2 = string.gsub(u6, "[%c%s]+", "")
                            v3 = libraries[v2]
                            if not v3 or not v3[v1] or string.find(u7_2, "%.[%s%c]*$") then
                                v8 = "iden"
                            else
                                v8 = "builtin"
                            end
                        end
                    end
                    u7_2 = u6
                    u6 = u5
                    u5 = v6
                    u8 = v8
                    return v8, v6
                end
            end
        end
    end
end

function u0.navigator() -- Line: 156 -- upvalues: u0 (val)
    local u0_2 = {Source = "", _RealIndex = 0, _UserIndex = 0}
    u0_2.TokenCache = table.create(50)

    function u0_2.Destroy(p1) -- Line: 166
        p1.Source = nil
        p1._RealIndex = nil
        p1._UserIndex = nil
        p1.TokenCache = nil
        p1._ScanThread = nil
    end

    function u0_2.SetSource(p1, p2) -- Line: 174 -- upvalues: u0 (upval)
        p1.Source = p2
        p1._RealIndex = 0
        p1._UserIndex = 0
        table.clear(p1.TokenCache)
        local create = coroutine.create
        p1._ScanThread = create(function() -- Line: 181 -- upvalues: u0 (upval), p1 (val)
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

    function u0_2.Next() -- Line: 190 -- upvalues: u0_2 (val)
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

    function u0_2.Peek(p1) -- Line: 213 -- upvalues: u0_2 (val)
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