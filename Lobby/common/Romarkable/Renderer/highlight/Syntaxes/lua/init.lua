local u0 = {}
local v1 = require("@self/language")
local keyword = v1.keyword
local builtin = v1.builtin
local libraries = v1.libraries
local u7 = {}
local v2 = {"^[%c%s]*%d+%.?%d*[eE][%+%-]?%d+[%c%s]*", "number"}
local v3 = {"^[%c%s]*%d+[%._]?[%d_eE]*[%c%s]*", "number"}
local v4 = {"^[%c%s]*(['\"])%1[%c%s]*", "string"}
local v5 = {"^[%c%s]*(['\"])[^\n]-([^\\]%1)[%c%s]*", "string"}
local v6 = {"^[%c%s]*(['\"]).-\n[%c%s]*", "string"}
u7[1] = {"^[%c%s]*[%a_][%w_]*[%c%s]*", "var"}
u7[2] = {"^[%c%s]*0x[%da-fA-F]+[%c%s]*", "number"}
u7[3] = v2
u7[4] = v3
u7[5] = v4
u7[6] = v5
u7[7] = v6
u7[8] = {"^[%c%s]*(['\"])[^\n]*[%c%s]*", "string"}
u7[9] = {"^[%c%s]*%[(=*)%[.-%]%1%][%c%s]*", "string"}
u7[10] = {"^[%c%s]*%[=*%[.-.*[%c%s]*", "string"}
u7[11] = {"^[%c%s]*%-%-%[(=*)%[.-%]%1%][%c%s]*", "comment"}
u7[12] = {"^[%c%s]*%-%-%[=*%[.-.*[%c%s]*", "comment"}
u7[13] = {"^[%c%s]*%-%-.-\n[%c%s]*", "comment"}
u7[14] = {"^[%c%s]*%-%-.*[%c%s]*", "comment"}
u7[15] = {"^[%c%s]*[:;<>/~%*%(%)%-={},%.#%^%+%%]+[%c%s]*", "operator"}
u7[16] = {"^[%c%s]*[%[%]]+[%c%s]*", "operator"}
local v7 = {"^[%c%s]*[%z\001-\127Â-ô][€-¿]+[%c%s]*", "iden"}
local v8 = {"^.", "iden"}
u7[17] = v7
u7[18] = v8
function u0.scan(p1) -- Line: 92 -- upvalues: u0 (val), u7 (val), keyword (val), builtin (val), libraries (val)
    u0.finished = false
    local u3 = 1
    local u4 = #p1
    local u5 = ""
    local u6 = ""
    local u7 = ""
    local u8 = ""
    return function() -- Line: 100 -- upvalues: u3 (ref), u4 (val), u7 (upval), p1 (val), u0 (upval), keyword (upval), builtin (upval), u5 (ref), u8 (ref), u6 (ref), libraries (upval), u7 (ref)
        local v1, v2, v3, v4, v5, v6, v7, v8
        if u3 > u4 then
            return
        end
        for i, v in ipairs(u7) do
            v4, v5 = string.find(p1, v[1], u3)
            if v4 then
                v6 = string.sub(p1, v4, v5)
                u3 = v5 + 1
                v8 = u4 < u3
                u0.finished = v8
                v7 = v[2]
                v8 = v7
                if v7 == "var" then
                    v1 = string.gsub(v6, "[%c%s]+", "")
                    if keyword[v1] then
                        v8 = "keyword"
                    elseif not (builtin[v1]) then
                        v8 = "iden"
                    else
                        v8 = "builtin"
                    end
                    if string.find(u5, "%.[%s%c]*$") and u8 ~= "comment" then
                        v2 = string.gsub(u6, "[%c%s]+", "")
                        v3 = libraries[v2]
                        if not v3 then
                            v8 = "iden"
                        elseif not (v3[v1]) then
                            v8 = "iden"
                        elseif string.find(u7, "%.[%s%c]*$") then
                            v8 = "iden"
                        else
                            v8 = "builtin"
                        end
                    end
                end
                u7 = u6
                u6 = u5
                u5 = v6
                u8 = v8
                return v8, v6
            end
        end
    end
end
function u0.navigator() -- Line: 156 -- upvalues: u0 (val)
    local u0 = {
        Source = "",
        _RealIndex = 0,
        _UserIndex = 0,
        TokenCache = table.create(50),
        Destroy = function(p1) -- Line: 166
            p1.Source = nil
            p1._RealIndex = nil
            p1._UserIndex = nil
            p1.TokenCache = nil
            p1._ScanThread = nil
        end,
    }
    function u0.SetSource(p1, p2) -- Line: 174 -- upvalues: u0 (upval)
        p1.Source = p2
        p1._RealIndex = 0
        p1._UserIndex = 0
        table.clear(p1.TokenCache)
        p1._ScanThread = coroutine.create(function() -- Line: 181 -- upvalues: u0 (upval), p1 (val)
            local v1
            for i, j in u0.scan(p1.Source) do
                v1 = p1
                v1._RealIndex = v1._RealIndex + 1
                p1.TokenCache[p1._RealIndex] = {i, j}
                coroutine.yield(i, j)
            end
        end)
    end
    function u0.Next() -- Line: 190 -- upvalues: u0 (val)
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
    function u0.Peek(p1) -- Line: 213 -- upvalues: u0 (val)
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