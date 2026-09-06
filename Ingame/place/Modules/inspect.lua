local countCycles, math, processRecursive, string, table, u160, v1, v2
local v3 = nil
local v4 = tonumber((_VERSION or ""):match("[%d.]*$")) or 0
if v4 < 5.3 then
    v4, v2 = pcall(require, "compat53.module")
    if v4 then
        v3 = v2
    end
end
if not v3 then
    math = math
else
    math = v3.math
end
if not v3 then
    string = string
else
    string = v3.string
end
if not v3 then
    table = table
else
    table = v3.table
end
local u172 = {}
local v5 = {}
u172.Options = v5
u172._VERSION = "inspect.lua 3.1.0"
u172._URL = "http://github.com/kikito/inspect.lua"
u172._DESCRIPTION = "human-readable representations of tables"
u172._LICENSE = "  MIT LICENSE\n\n  Copyright (c) 2022 Enrique García Cota\n\n  Permission is hereby granted, free of charge, to any person obtaining a\n  copy of this software and associated documentation files (the\n  \"Software\"), to deal in the Software without restriction, including\n  without limitation the rights to use, copy, modify, merge, publish,\n  distribute, sublicense, and/or sell copies of the Software, and to\n  permit persons to whom the Software is furnished to do so, subject to\n  the following conditions:\n\n  The above copyright notice and this permission notice shall be included\n  in all copies or substantial portions of the Software.\n\n  THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n"
u172.KEY = setmetatable({}, {
    __tostring = function() -- Line: 47
        return "inspect.KEY"
    end,
})
local v6 = {}
u172.METATABLE = setmetatable(v6, {
    __tostring = function() -- Line: 48
        return "inspect.METATABLE"
    end,
})
local u185 = tostring
local rep = string.rep
local match = string.match
local char = string.char
local gsub = string.gsub
local format = string.format
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
    local v1
    if not (match(p1, "\"")) then
        v1 = gsub(p1, "\"", "\\\"")
        return "\"" .. v1 .. "\""
    end
    if not (match(p1, "'")) then
        return "'" .. p1 .. "'"
    end
    v1 = gsub(p1, "\"", "\\\"")
    return "\"" .. v1 .. "\""
end
local u104 = {}
u104["\007"] = "\\a"
u104["\008"] = "\\b"
u104["\012"] = "\\f"
u104["\n"] = "\\n"
u104["\r"] = "\\r"
u104["\t"] = "\\t"
u104["\011"] = "\\v"
u104["\127"] = "\\127"
local u105 = {}
u105["\127"] = "\127"
local v7 = 31
local v8 = 1
for i = 0, v7, v8 do
    v1 = char(i)
    if not (u104[v1]) then
        u104[v1] = "\\" .. i
        u105[v1] = format("\\%03d", i)
    end
end
local function escape(p1) -- Line: 91 -- upvalues: gsub (val), u105 (val), u104 (val)
    local v1 = gsub(p1, "\\", "\\\\")
    local v2 = gsub(v1, "(%c)%f[0-9]", u105)
    return (gsub(v2, "%c", u104))
end
local u112 = {}
u112["and"] = true
u112["break"] = true
u112["do"] = true
u112["else"] = true
u112["elseif"] = true
u112["end"] = true
u112["false"] = true
u112["for"] = true
u112["function"] = true
u112.goto = true
u112["if"] = true
u112["in"] = true
u112["local"] = true
u112["nil"] = true
u112["not"] = true
u112["or"] = true
u112["repeat"] = true
u112["return"] = true
u112["then"] = true
u112["true"] = true
u112["until"] = true
u112["while"] = true
local function isIdentifier(p1) -- Line: 122 -- upvalues: u112 (val)
    local v1 = false
    if type(p1) == "string" then
        v1 = not not p1:match("^[_%a][_%a%d]*$")
        if v1 then
            v1 = not u112[p1]
        end
    end
    return v1
end
local floor = math.floor
local function isSequenceKey(p1, p2) -- Line: 129 -- upvalues: floor (val)
    local v1 = if type(p1) == "number" then if floor(p1) == p1 then if 1 <= p1 then p1 <= p2 else false else false else false
    return v1
end
local u147 = {number = 1, boolean = 2, string = 3, table = 4}
u147["function"] = 5
u147.userdata = 6
u147.thread = 7
local function sortKeys(p1, p2) -- Line: 141 -- upvalues: u147 (val)
    local v1
    local v2 = type(p1)
    local v3 = type(p2)
    if v2 ~= v3 then
        local v4
        v1 = u147[v2] or 100
        local v5 = u147[v3] or 100
        if v1 ~= v5 then
            v4 = v1 < v5
        else
            v4 = if v2 >= v3 then v1 < v5 else true
        end
        return v4
    elseif v2 == "string" then
        v1 = p1 < p2
        return v1
    elseif v2 == "number" then
        v1 = p1 < p2
        return v1
    end
end
local function getKeys(p1) -- Line: 156 -- upvalues: u160 (ref), floor (val), table (val), sortKeys (val)
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
        v1 = if type(i) == "number" then if floor(i) == i then if 1 <= i then i <= v2 else false else false else false
        if not v1 then
            v4 = v4 + 1
            v3[v4] = i
        end
    end
    table.sort(v3, sortKeys)
    return v3, v4, v2
end
function countCycles(p1, p2) -- Line: 175 -- upvalues: countCycles (val)
    if type(p1) ~= "table" then
        return
    end
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
    v2 = getmetatable(p1)
    countCycles(v2, p2)
end
local function makePath(p1, p2, p3) -- Line: 190
    local v1 = {}
    local v2 = #p1
    local v3 = v2
    local v4 = 1
    for i = 1, v3, v4 do
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
        v2, v6, v8 = p1, p3, p4
        for i, j in v11, v12, v13 do
            KEY = u172.KEY
            v3 = {}
            v4 = #v6
            v5 = v4
            v7 = 1
            for k = 1, v5, v7 do
                v3[k] = v6[k]
            end
            v3[v4 + 1] = i
            v3[v4 + 2] = KEY
            v9 = processRecursive(v2, i, v3, v8)
            if v9 ~= nil then
                v3 = {}
                v4 = #v6
                v5 = v4
                v7 = 1
                for n = 1, v5, v7 do
                    v3[n] = v6[n]
                end
                v3[v4 + 1] = v9
                v3[v4 + 2] = nil
                v10[v9] = processRecursive(v2, j, v3, v8)
            end
        end
        v13 = getmetatable(v1)
        local METATABLE = u172.METATABLE
        local v14 = {}
        local v15 = #v6
        local v16 = v15
        local v17 = 1
        for m = 1, v16, v17 do
            v14[m] = v6[m]
        end
        v14[v15 + 1] = METATABLE
        v14[v15 + 2] = nil
        v11 = processRecursive(v2, v13, v14, v8)
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
local v9 = {}
local u175 = {__index = v9}
local function tabify(p1) -- Line: 250 -- upvalues: rep (val)
    local buf = p1.buf
    local v1 = p1.newline .. rep(p1.indent, p1.level)
    buf.n = buf.n + 1
    buf[buf.n] = v1
end
function v9:getId(p2) -- Line: 254 -- upvalues: u185 (val)
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
function v9:putValue(p2) -- Line: 265 -- upvalues: gsub (val), u105 (val), u104 (val), match (val), u185 (val), u172 (val), format (val), getKeys (val), rep (val), u112 (val)
    local buf_2, buf_4, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    local buf = self.buf
    local v11 = type(p2)
    if v11 == "string" then
        v9 = gsub(p2, "\\", "\\\\")
        v8 = gsub(v9, "(%c)%f[0-9]", u105)
        v7 = gsub(v8, "%c", u104)
        if not (match(v7, "\"")) then
            v9 = gsub(v7, "\"", "\\\"")
            v6 = "\"" .. v9 .. "\""
        elseif match(v7, "'") then
            v9 = gsub(v7, "\"", "\\\"")
            v6 = "\"" .. v9 .. "\""
        else
            v6 = "'" .. v7 .. "'"
        end
        buf.n = buf.n + 1
        buf[buf.n] = v6
        return
    end
    if v11 == "number" or v11 == "boolean" or v11 == "nil" or v11 == "cdata" or v11 == "ctype" then
        v6 = u185(p2)
        buf.n = buf.n + 1
        buf[buf.n] = v6
        return
    end
    if v11 ~= "table" or self.ids[p2] then
        v6 = format("<%s %d>", v11, self:getId(p2))
        buf.n = buf.n + 1
        buf[buf.n] = v6
        return
    end
    if p2 == u172.KEY or p2 == u172.METATABLE then
        v6 = u185(p2)
        buf.n = buf.n + 1
        buf[buf.n] = v6
        return
    end
    if self.depth <= self.level then
        buf.n = buf.n + 1
        buf[buf.n] = "{...}"
        return
    end
    v6 = self.cycles[p2]
    if 1 < v6 then
        v6 = format("<%d>", self:getId(p2))
        buf.n = buf.n + 1
        buf[buf.n] = v6
    end
    v6, v7, v8 = getKeys(p2)
    buf.n = buf.n + 1
    buf[buf.n] = "{"
    self.level = self.level + 1
    v9 = v8 + v7
    local v12 = 1
    for i = 1, v9, v12 do
        if 1 < i then
            buf.n = buf.n + 1
            buf[buf.n] = ","
        end
        if i > v8 then
            v3 = v6[i - v8]
            buf_2 = v1.buf
            v5 = v1.newline .. rep(v1.indent, v1.level)
            buf_2.n = buf_2.n + 1
            buf_2[buf_2.n] = v5
            v4 = false
            if type(v3) == "string" then
                v4 = not not v3:match("^[_%a][_%a%d]*$")
                if v4 then
                    v4 = not u112[v3]
                end
            end
            if not v4 then
                buf.n = buf.n + 1
                buf[buf.n] = "["
                v1:putValue(v3)
                buf.n = buf.n + 1
                buf[buf.n] = "]"
            else
                buf.n = buf.n + 1
                buf[buf.n] = v3
            end
            buf.n = buf.n + 1
            buf[buf.n] = " = "
            v1:putValue(v2[v3])
        else
            buf.n = buf.n + 1
            buf[buf.n] = " "
            v1:putValue(v2[i])
        end
    end
    v9 = getmetatable(v2)
    if type(v9) == "table" then
        if 0 < v8 + v7 then
            buf.n = buf.n + 1
            buf[buf.n] = ","
        end
        local buf_3 = v1.buf
        v10 = v1.newline .. rep(v1.indent, v1.level)
        buf_3.n = buf_3.n + 1
        buf_3[buf_3.n] = v10
        buf.n = buf.n + 1
        buf[buf.n] = "<metatable> = "
        v1:putValue(v9)
    end
    v1.level = v1.level - 1
    if 0 < v7 then
        buf_4 = v1.buf
        v10 = v1.newline .. rep(v1.indent, v1.level)
        buf_4.n = buf_4.n + 1
        buf_4[buf_4.n] = v10
    elseif type(v9) == "table" then
        buf_4 = v1.buf
        v10 = v1.newline .. rep(v1.indent, v1.level)
        buf_4.n = buf_4.n + 1
        buf_4[buf_4.n] = v10
    elseif 0 < v8 then
        buf.n = buf.n + 1
        buf[buf.n] = " "
    end
    buf.n = buf.n + 1
    buf[buf.n] = "}"
end
function u172.inspect(p1, p2) -- Line: 335 -- upvalues: math (val), processRecursive (val), countCycles (val), u175 (val), table (val)
    local v1
    local v2 = p2
    if not v2 then
        v2 = {}
    end
    local v3 = v2
    local depth = v3.depth
    if not depth then
        depth = math.huge
    end
    local process = v3.process
    if not process then
        v1 = p1
    else
        v1 = processRecursive(process, p1, {}, {})
    end
    local v4 = {}
    countCycles(v1, v4)
    local v5 = setmetatable({
        level = 0,
        buf = {n = 0},
        ids = {},
        cycles = v4,
        depth = depth,
        newline = v3.newline or "\n",
        indent = v3.indent or "  ",
    }, u175)
    v5:putValue(v1)
    return table.concat(v5.buf)
end
setmetatable(u172, {
    __call = function(p1, p2, p3) -- Line: 366 -- upvalues: u172 (val)
        return u172.inspect(p2, p3)
    end,
})
return u172