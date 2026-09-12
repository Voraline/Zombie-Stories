local countCycles, math_2, processRecursive, string_2, table_2, u160, v1
local v2 = nil
local v3 = (_VERSION or ""):match("[%d.]*$")
if (tonumber(v3) or 0) < 5.3 then
    local success, result = pcall(require, "compat53.module")
    if success then
        v2 = result
    end
end
if not v2 then
    math_2 = math
else
    math_2 = v2.math
    if not math_2 then
        math_2 = math
    end
end
if not v2 then
    string_2 = string
else
    string_2 = v2.string
    if not string_2 then
        string_2 = string
    end
end
if not v2 then
    table_2 = table
else
    table_2 = v2.table
    if not table_2 then
        table_2 = table
    end
end
local u172 = {
    Options = {},
    _VERSION = "inspect.lua 3.1.0",
    _URL = "http://github.com/kikito/inspect.lua",
    _DESCRIPTION = "human-readable representations of tables",
    _LICENSE = "  MIT LICENSE\n\n  Copyright (c) 2022 Enrique García Cota\n\n  Permission is hereby granted, free of charge, to any person obtaining a\n  copy of this software and associated documentation files (the\n  \"Software\"), to deal in the Software without restriction, including\n  without limitation the rights to use, copy, modify, merge, publish,\n  distribute, sublicense, and/or sell copies of the Software, and to\n  permit persons to whom the Software is furnished to do so, subject to\n  the following conditions:\n\n  The above copyright notice and this permission notice shall be included\n  in all copies or substantial portions of the Software.\n\n  THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n",
}
local v4 = {
    __tostring = function() -- Line: 47
        return "inspect.KEY"
    end,
}
u172.KEY = setmetatable({}, v4)
v4 = {
    __tostring = function() -- Line: 48
        return "inspect.METATABLE"
    end,
}
u172.METATABLE = setmetatable({}, v4)
local u185 = tostring
local rep = string_2.rep
local match = string_2.match
local char = string_2.char
local gsub = string_2.gsub
local format = string_2.format
if not rawget then
    function u160(p1, p2) -- Line: 61
        return p1[p2]
    end
else
    u160 = rawget
end

local function rawpairs(p1) -- Line: 64
    return next, p1, nil
end

local function smartQuote(p1) -- Line: 70 -- upvalues: match (val), gsub (val)
    if match(p1, "\"") and not match(p1, "'") then
        return "'" .. p1 .. "'"
    end
    return "\"" .. (gsub(p1, "\"", "\\\"")) .. "\""
end

local u104 = {
    ["\007"] = "\\a",
    ["\008"] = "\\b",
    ["\012"] = "\\f",
    ["\n"] = "\\n",
    ["\r"] = "\\r",
    ["\t"] = "\\t",
    ["\011"] = "\\v",
    ["\127"] = "\\127",
}
local u105 = {["\127"] = "\127"}
for i = 0, 31 do
    v1 = char(i)
    if not u104[v1] then
        u104[v1] = "\\" .. i
        u105[v1] = (format("\\%03d", i))
    end
end

local function escape(p1) -- Line: 91 -- upvalues: gsub (val), u105 (val), u104 (val)
    local v1 = gsub
    local v2 = gsub
    v2 = v2(gsub(p1, "\\", "\\\\"), "(%c)%f[0-9]", u105)
    return (v1(v2, "%c", u104))
end

local u112 = {
    ["and"] = true,
    ["break"] = true,
    ["do"] = true,
    ["else"] = true,
    ["elseif"] = true,
    ["end"] = true,
    ["false"] = true,
    ["for"] = true,
    ["function"] = true,
    goto = true,
    ["if"] = true,
    ["in"] = true,
    ["local"] = true,
    ["nil"] = true,
    ["not"] = true,
    ["or"] = true,
    ["repeat"] = true,
    ["return"] = true,
    ["then"] = true,
    ["true"] = true,
    ["until"] = true,
    ["while"] = true,
}

local function isIdentifier(p1) -- Line: 122 -- upvalues: u112 (val)
    local v1 = false
    if type(p1) == "string" then
        v1 = not not p1:match("^[_%a][_%a%d]*$") and not u112[p1]
    end
    return v1
end

local floor = math_2.floor

local function isSequenceKey(p1, p2) -- Line: 129 -- upvalues: floor (val)
    local v1 = false
    if type(p1) == "number" then
        v1 = false
        if floor(p1) == p1 then
            v1 = false
            if 1 <= p1 then
                v1 = p1 <= p2
            end
        end
    end
    return v1
end

local u147 = {
    number = 1,
    boolean = 2,
    string = 3,
    table = 4,
    ["function"] = 5,
    userdata = 6,
    thread = 7,
}

local function sortKeys(p1, p2) -- Line: 141 -- upvalues: u147 (val)
    local v1, v2, v3
    local v4 = type(p1)
    local v5 = type(p2)
    if v4 ~= v5 then
        v1 = u147[v4] or 100
        v2 = u147[v5] or 100
        if v1 ~= v2 then
            v3 = v1 < v2
        else
            v3 = true
            if not (v4 < v5) then
                v3 = v1 < v2
            end
        end
        return v3
    end
    if v4 ~= "string" and v4 ~= "number" then
        v1 = u147[v4] or 100
        v2 = u147[v5] or 100
        if v1 ~= v2 then
            v3 = v1 < v2
        else
            v3 = true
            if not (v4 < v5) then
                v3 = v1 < v2
            end
        end
        return v3
    end
    v1 = p1 < p2
    return v1
end

local function getKeys(p1) -- Line: 156 -- upvalues: u160 (ref), floor (val), table_2 (val), sortKeys (val)
    local v1
    local v2 = 1
    while u160(p1, v2) ~= nil do
        v2 = v2 + 1
    end
    v2 = v2 - 1
    local v3 = {}
    local v4 = 0
    local v5 = next
    local v6 = p1
    local v7 = nil
    for i in v5, v6, v7 do
        v1 = false
        if type(i) == "number" then
            v1 = false
            if floor(i) == i then
                v1 = false
                if 1 <= i then
                    v1 = i <= v2
                end
            end
        end
        if not v1 then
            v4 = v4 + 1
            v3[v4] = i
        end
    end
    table_2.sort(v3, sortKeys)
    return v3, v4, v2
end

function countCycles(p1, p2) -- Line: 175 -- upvalues: countCycles (val)
    if type(p1) == "table" then
        if p2[p1] then
            p2[p1] = p2[p1] + 1
            return
        end
        p2[p1] = 1
        local v1 = next
        local v2 = p1
        local v3 = nil
        for i, j in v1, v2, v3 do
            countCycles(i, p2)
            countCycles(j, p2)
        end
        v1 = countCycles
        v1(getmetatable(p1), p2)
    end
end

local function makePath(p1, p2, p3) -- Line: 190
    local v1 = {}
    local v2 = #p1
    local v3 = v2
    for i = 1, v3 do
        v1[i] = p1[i]
    end
    v1[v2 + 1] = p2
    v1[v2 + 2] = p3
    return v1
end

function processRecursive(p1, p2, p3, p4) -- Line: 202 -- upvalues: processRecursive (val), u172 (val)
    if p2 == nil then
        return nil
    end
    if p4[p2] then
        return p4[p2]
    end
    local v1 = p1(p2, p3)
    if type(v1) == "table" then
        local KEY, v2, v3, v4, v5, v6, v7, v8, v9
        local v10 = {}
        p4[p2] = v10
        local v11 = next
        local v12 = v1
        local v13 = nil
        local v14, v15, v16 = p1, p3, p4
        for i, j in v11, v12, v13 do
            v2 = processRecursive
            v3 = v14
            v4 = i
            KEY = u172.KEY
            v6 = {}
            v7 = #v15
            v8 = v7
            for k = 1, v8 do
                v6[k] = v15[k]
            end
            v6[v7 + 1] = i
            v6[v7 + 2] = KEY
            v9 = v2(v3, v4, v6, v16)
            if v9 ~= nil then
                v2 = processRecursive
                v3 = v14
                v4 = j
                v5 = v9
                v6 = {}
                v7 = #v15
                v8 = v7
                for n = 1, v8 do
                    v6[n] = v15[n]
                end
                v6[v7 + 1] = v5
                v6[v7 + 2] = nil
                v10[v9] = (v2(v3, v4, v6, v16))
            end
        end
        v11 = processRecursive
        v12 = v14
        v13 = getmetatable(v1)
        local METATABLE = u172.METATABLE
        v2 = {}
        v3 = #v15
        v4 = v3
        for m = 1, v4 do
            v2[m] = v15[m]
        end
        v2[v3 + 1] = METATABLE
        v2[v3 + 2] = nil
        v11 = v11(v12, v13, v2, v16)
        if type(v11) ~= "table" then
            v11 = nil
        end
        setmetatable(v10, v11)
        v1 = v10
    end
    return v1
end

local function puts(p1, p2) -- Line: 230
    p1.n = p1.n + 1
    p1[p1.n] = p2
end

local v5 = {}
local u175 = {}
u175.__index = v5

local function tabify(p1) -- Line: 250 -- upvalues: rep (val)
    local buf = p1.buf
    local v1 = p1.newline .. rep(p1.indent, p1.level)
    buf.n = buf.n + 1
    buf[buf.n] = v1
end

function v5:getId(p2) -- Line: 254 -- upvalues: u185 (val)
    local v1 = self.ids[p2]
    local ids = self.ids
    if not v1 then
        local v2 = type(p2)
        v1 = (ids[v2] or 0) + 1
        ids[p2] = v1
        ids[v2] = v1
    end
    return (u185(v1))
end

function v5:putValue(p2) -- Line: 265
    -- upvalues: gsub (val), u105 (val), u104 (val), match (val), u185 (val), u172 (val), format (val), getKeys (val)
    -- upvalues: rep (val), u112 (val)
    local v1, v2, v3
    local buf = self.buf
    local v4 = type(p2)
    if v4 == "string" then
        v2 = gsub
        v3 = gsub
        v3 = v3(gsub(p2, "\\", "\\\\"), "(%c)%f[0-9]", u105)
        v2 = v2(v3, "%c", u104)
        if not match(v2, "\"") or match(v2, "'") then
            v1 = "\"" .. (gsub(v2, "\"", "\\\"")) .. "\""
        else
            v1 = "'" .. v2 .. "'"
        end
        buf.n = buf.n + 1
        buf[buf.n] = v1
        return
    end
    if v4 ~= "number" and v4 ~= "boolean" and v4 ~= "nil" and v4 ~= "cdata" and v4 ~= "ctype" then
        if v4 == "table" and not self.ids[p2] then
            if p2 ~= u172.KEY and p2 ~= u172.METATABLE then
                local buf_2, v5, v6, v7, v8, v9, v10, v11
                local level = self.level
                if self.depth <= level then
                    buf.n = buf.n + 1
                    buf[buf.n] = "{...}"
                    return
                end
                v1 = self.cycles[p2]
                if 1 < v1 then
                    v1 = format("<%d>", self:getId(p2))
                    buf.n = buf.n + 1
                    buf[buf.n] = v1
                end
                v1, v2, v3 = getKeys(p2)
                buf.n = buf.n + 1
                buf[buf.n] = "{"
                self.level = self.level + 1
                local v12 = v3 + v2
                for i = 1, v12 do
                    if 1 < i then
                        buf.n = buf.n + 1
                        buf[buf.n] = ","
                    end
                    if not (i <= v3) then
                        v7 = v1[i - v3]
                        buf_2 = v5.buf
                        v9 = v5.newline .. rep(v5.indent, v5.level)
                        buf_2.n = buf_2.n + 1
                        buf_2[buf_2.n] = v9
                        v8 = false
                        if type(v7) == "string" then
                            v8 = not not v7:match("^[_%a][_%a%d]*$") and not u112[v7]
                        end
                        if not v8 then
                            buf.n = buf.n + 1
                            buf[buf.n] = "["
                            v5:putValue(v7)
                            buf.n = buf.n + 1
                            buf[buf.n] = "]"
                        else
                            buf.n = buf.n + 1
                            buf[buf.n] = v7
                        end
                        buf.n = buf.n + 1
                        buf[buf.n] = " = "
                        v10 = v6[v7]
                        v5:putValue(v10)
                    else
                        buf.n = buf.n + 1
                        buf[buf.n] = " "
                        v9 = v6[i]
                        v5:putValue(v9)
                    end
                end
                v12 = getmetatable(v6)
                if type(v12) == "table" then
                    if 0 < v3 + v2 then
                        buf.n = buf.n + 1
                        buf[buf.n] = ","
                    end
                    local buf_3 = v5.buf
                    v11 = v5.newline .. rep(v5.indent, v5.level)
                    buf_3.n = buf_3.n + 1
                    buf_3[buf_3.n] = v11
                    buf.n = buf.n + 1
                    buf[buf.n] = "<metatable> = "
                    v5:putValue(v12)
                end
                v5.level = v5.level - 1
                if 0 < v2 or type(v12) == "table" then
                    local buf_4 = v5.buf
                    v11 = v5.newline .. rep(v5.indent, v5.level)
                    buf_4.n = buf_4.n + 1
                    buf_4[buf_4.n] = v11
                elseif 0 < v3 then
                    buf.n = buf.n + 1
                    buf[buf.n] = " "
                end
                buf.n = buf.n + 1
                buf[buf.n] = "}"
                return
            end
            v1 = u185(p2)
            buf.n = buf.n + 1
            buf[buf.n] = v1
            return
        end
        v1 = format("<%s %d>", v4, self:getId(p2))
        buf.n = buf.n + 1
        buf[buf.n] = v1
        return
    end
    v1 = u185(p2)
    buf.n = buf.n + 1
    buf[buf.n] = v1
end

function u172.inspect(p1, p2) -- Line: 335
    -- upvalues: math_2 (val), processRecursive (val), countCycles (val), u175 (val), table_2 (val)
    local v1
    local v2 = p2 or {}
    local v3 = v2
    local depth = v3.depth
    if not depth then
        depth = math_2.huge
    end
    local v4 = v3.newline or "\n"
    local v5 = v3.indent or "  "
    local process = v3.process
    if not process then
        v1 = p1
    else
        v1 = processRecursive(process, p1, {}, {})
    end
    local v6 = {}
    countCycles(v1, v6)
    local v7 = {
        level = 0,
        buf = {n = 0},
        ids = {},
        cycles = v6,
        depth = depth,
        newline = v4,
        indent = v5,
    }
    local v8 = u175
    local v9 = setmetatable(v7, v8)
    v9:putValue(v1)
    return table_2.concat(v9.buf)
end

local v6 = {
    __call = function(p1, p2, p3) -- Line: 366 -- upvalues: u172 (val)
        return u172.inspect(p2, p3)
    end,
}
setmetatable(u172, v6)
return u172