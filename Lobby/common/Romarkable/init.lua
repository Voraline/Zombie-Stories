local blocks
local v1 = {}
local v2 = {
    Bold = 0,
    Italic = 1,
    ItalicBold = 2,
    Strike = 3,
    Code = 4,
    Red = 5,
}

local function sanitize(p1) -- Line: 32
    return string.gsub(
        string.gsub(string.gsub(string.gsub(string.gsub(p1, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"), "\"", "&quot;"),
        "'",
        "&apos;"
    )
end

local u4 = {}
u4["`"] = v2.Code
u4["~"] = v2.Strike
u4["~~"] = v2.Strike
u4["*"] = v2.Italic
u4._ = v2.Italic
u4["**"] = v2.Bold
u4.__ = v2.Bold
u4.___ = v2.ItalicBold
u4["***"] = v2.ItalicBold
u4["||"] = v2.Red
local u15 = {}
local Bold = v2.Bold
u15[Bold] = {"<font color=\"#e3df6d\"><b>", "</b></font>"}
local Italic = v2.Italic
u15[Italic] = {"<font color=\"#b0ffdb\"><i>", "</i></font>"}
local ItalicBold = v2.ItalicBold
u15[ItalicBold] = {"<font color=\"#e3df6d\"><b><i>", "</i></b></font>"}
local Strike = v2.Strike
u15[Strike] = {"<s>", "</s>"}
local Code = v2.Code
u15[Code] = {"<font face=\"RobotoMono\">", "</font>"}
local Red = v2.Red
u15[Red] = {"<font color=\"#fa7878\"><b>", "</b></font>"}

local function richText(p1) -- Line: 62 -- upvalues: sanitize (val), u4 (val), u15 (val)
    local v1, v2, v3, v4, v5, v6, v7
    local v8 = sanitize(p1)
    local v9 = {}
    local v10 = 0
    local v11 = 0
    while true do
        v2, v3 = string.match(v8, "([%*_~`|]+)(%S[^\n]-)%1", v11)
        if not v2 then
            break
        end
        v4, v5 = string.find(v8, v2 .. v3 .. v2, v11, true)
        v7 = u4
        v6 = v7[v2]
        v7 = u15[v6]
        v10 = v10 + 1
        v1 = v4 - 1
        v9[v10] = (string.sub(v8, v11, v1))
        v11 = v5 + 1
        if not v7 then
            v10 = v10 + 1
            v9[v10] = v3
        else
            v10 = v10 + 1
            v9[v10] = v7[1] .. v3 .. v7[2]
        end
    end
    v9[v10 + 1] = (string.sub(v8, v11))
    return table.concat(v9)
end

local u41 = {
    None = 0,
    Paragraph = 1,
    Heading = 2,
    Code = 3,
    List = 4,
    Ruler = 5,
    Quote = 6,
    Image = 7,
}
local u42 = {}
u42[u41.None] = true
u42[u41.Paragraph] = true
u42[u41.Code] = true
u42[u41.List] = true
u42[u41.Quote] = true

local function cleanup(p1) -- Line: 120
    return string.gsub(p1, "\t", "    ")
end

local function getTextWithIndentation(p1) -- Line: 124
    local v1, v2 = string.match(p1, "^%s*()(.*)")
    local v3 = v1 / 2
    return v2, (math.floor(v3))
end

local function blockLines(p1) -- Line: 130 -- upvalues: u41 (val)
    local None = u41.None
    local u6 = string.split(p1, "\n")
    local u7 = 0
    return function() -- Line: 135 -- upvalues: u7 (ref), u6 (val), None (ref), u41 (upval)
        u7 = u7 + 1
        local v1 = u6[u7]
        if not v1 then
            return
        end
        if None == u41.Code then
            if string.match(v1, "^```") then
                None = u41.None
            end
            return u41.Code, v1
        end
        if string.match(v1, "^%s*$") then
            return u41.None, ""
        end
        if not string.match(v1, "^%-%-%-+") and not string.match(v1, "^===+") then
            if string.match(v1, "^%s*!%[%w-|?[%dx]*,? ?%d*%%?%]%(.-%)") then
                return u41.Image, v1
            end
            if string.match(v1, "^#") then
                return u41.Heading, v1
            end
            if string.match(v1, "^%s*```") then
                None = u41.Code
                return None, v1
            end
            if string.match(v1, "^%s*>") then
                return u41.Quote, v1
            end
            if not string.match(v1, "^%s*%-%s+")
                and not string.match(v1, "^%s*%*%s+")
                and not string.match(v1, "^%s*[%u%d]+%.%s+")
                and not string.match(v1, "^%s*%+%s+") then
                return u41.Paragraph, v1
            end
            return u41.List, v1
        end
        return u41.Ruler, ""
    end
end

local function textBlocks(p1) -- Line: 189 -- upvalues: u41 (val), u42 (val)
    local None = u41.None
    local u6 = string.split(p1, "\n")
    local u7 = 0

    local function u9() -- Line: 135 -- upvalues: u7 (ref), u6 (val), None (ref), u41 (upval)
        u7 = u7 + 1
        local v1 = u6[u7]
        if not v1 then
            return
        end
        if None == u41.Code then
            if string.match(v1, "^```") then
                None = u41.None
            end
            return u41.Code, v1
        end
        if string.match(v1, "^%s*$") then
            return u41.None, ""
        end
        if not string.match(v1, "^%-%-%-+") and not string.match(v1, "^===+") then
            if string.match(v1, "^%s*!%[%w-|?[%dx]*,? ?%d*%%?%]%(.-%)") then
                return u41.Image, v1
            end
            if string.match(v1, "^#") then
                return u41.Heading, v1
            end
            if string.match(v1, "^%s*```") then
                None = u41.Code
                return None, v1
            end
            if string.match(v1, "^%s*>") then
                return u41.Quote, v1
            end
            if not string.match(v1, "^%s*%-%s+")
                and not string.match(v1, "^%s*%*%s+")
                and not string.match(v1, "^%s*[%u%d]+%.%s+")
                and not string.match(v1, "^%s*%+%s+") then
                return u41.Paragraph, v1
            end
            return u41.List, v1
        end
        return u41.Ruler, ""
    end

    local u11, u12 = u9()
    return function() -- Line: 192 -- upvalues: u9 (val), u41 (upval), u11 (ref), u12 (ref), u42 (upval)
        local v1, v2, v3
        local v4, v5 = u9()
        if v4 == u41.Ruler and u11 == u41.Paragraph then
            local v6
            v1 = u12
            v2, v3 = u9()
            u11 = v2
            u12 = v3
            local Heading = u41.Heading
            local rep = string.rep
            local v7 = u12
            if string.sub(v7, 1, 1) ~= "=" then
                v6 = 1
            else
                v6 = 2
            end
            return Heading, (rep("#", v6)) .. " " .. v1
        end
        v1 = {u12}
        while u42[v4] do
            if v4 ~= u11 then
                break
            end
            table.insert(v1, v5)
            v2, v3 = u9()
            v4 = v2
            v5 = v3
        end
        v2 = u11
        v3 = table.concat(v1, "\n")
        u11 = v4
        u12 = v5
        return v2, v3
    end
end

function blocks(p1, p2) -- Line: 214 -- upvalues: u41 (val), u42 (val), blocks (val)
    local it
    local None = u41.None
    local u7 = string.split(p1, "\n")
    local u8 = 0

    local function u10() -- Line: 135 -- upvalues: u8 (ref), u7 (val), None (ref), u41 (upval)
        u8 = u8 + 1
        local v1 = u7[u8]
        if not v1 then
            return
        end
        if None == u41.Code then
            if string.match(v1, "^```") then
                None = u41.None
            end
            return u41.Code, v1
        end
        if string.match(v1, "^%s*$") then
            return u41.None, ""
        end
        if not string.match(v1, "^%-%-%-+") and not string.match(v1, "^===+") then
            if string.match(v1, "^%s*!%[%w-|?[%dx]*,? ?%d*%%?%]%(.-%)") then
                return u41.Image, v1
            end
            if string.match(v1, "^#") then
                return u41.Heading, v1
            end
            if string.match(v1, "^%s*```") then
                None = u41.Code
                return None, v1
            end
            if string.match(v1, "^%s*>") then
                return u41.Quote, v1
            end
            if not string.match(v1, "^%s*%-%s+")
                and not string.match(v1, "^%s*%*%s+")
                and not string.match(v1, "^%s*[%u%d]+%.%s+")
                and not string.match(v1, "^%s*%+%s+") then
                return u41.Paragraph, v1
            end
            return u41.List, v1
        end
        return u41.Ruler, ""
    end

    local u12, u13 = u10()

    local function u14() -- Line: 192 -- upvalues: u10 (val), u41 (upval), u12 (ref), u13 (ref), u42 (upval)
        local v1, v2, v3
        local v4, v5 = u10()
        if v4 == u41.Ruler and u12 == u41.Paragraph then
            local v6
            v1 = u13
            v2, v3 = u10()
            u12 = v2
            u13 = v3
            local Heading = u41.Heading
            local rep = string.rep
            local v7 = u13
            if string.sub(v7, 1, 1) ~= "=" then
                v6 = 1
            else
                v6 = 2
            end
            return Heading, (rep("#", v6)) .. " " .. v1
        end
        v1 = {u13}
        while u42[v4] do
            if v4 ~= u12 then
                break
            end
            table.insert(v1, v5)
            v2, v3 = u10()
            v4 = v2
            v5 = v3
        end
        v2 = u12
        v3 = table.concat(v1, "\n")
        u12 = v4
        u13 = v5
        return v2, v3
    end

    function it() -- Line: 216 -- upvalues: u14 (val), u41 (upval), it (val), p2 (val), blocks (upval)
        local v1, v2 = u14()
        if v1 == u41.None then
            return it()
        end
        local v3 = {}
        if v1 then
            if v1 == u41.Paragraph then
                v3.Text = p2(v2)
            else
                local v4, v5, v6, v7, v8, v9, v10
                if v1 == u41.Image then
                    v6 = string.match(v2, "^!%[(%w-)|?[%dx]*,? ?%d*%%?%]")
                    v7 = string.match(v2, "%((.-)%)$")
                    v3.Title = v6 or "Unknown"
                    v3.ID = v7 or "6266306999"
                    v8, v9 = string.match(v2, "^%s*!%[%w-|(%d+)x(%d+)%]*")
                    v10 = tonumber(v8)
                    local v11 = tonumber(v9)
                    local v12 = {}
                    v4 = v10 and v10 or 1024
                    v12.X = v4
                    v4 = v11 and v11 or 1024
                    v12.Y = v4
                    v3.Resolution = v12
                    v4 = v10 and v10 or 1
                    v5 = v11 and v11 or 1
                    v3.AspectRatio = v4 / v5
                    v12 = string.match(v2, "^%s*!%[%w-|?[%dx]*, (%d+)%%")
                    v3.Scale = (tonumber(v12) or 100) / 100
                elseif v1 == u41.Heading then
                    v6, v7 = string.match(v2, "^#+()%s*(.*)")
                    v8 = v6 - 1
                    v9 = p2
                    v9 = v9(v7)
                    v3.Level = v8
                    v3.Text = v9
                elseif v1 == u41.Code then
                    v6, v7 = string.match(v2, "^```(.-)\n(.*)\n```$")
                    v3.Syntax = v6
                    v3.Code = v7
                elseif v1 == u41.List then
                    local v13, v14, v15
                    v6 = string.split(v2, "\n")
                    for i2, v in ipairs(v6) do
                        v5, v13 = string.match(v, "^%s*()(.*)")
                        v15 = v5 / 2
                        v4 = math.floor(v15)
                        v5, v13 = string.match(v13, "^(.-)%s+(.*)")
                        v14 = {Level = v4, Text = p2(v13), Symbol = v5}
                        v6[i2] = v14
                    end
                    v3.Lines = v6
                elseif v1 == u41.Quote then
                    v6 = string.split(v2, "\n")
                    v7 = #v6
                    for i = 1, v7 do
                        v6[i] = (string.match(v6[i], "^%s*>%s*(.*)"))
                    end
                    v7 = table.concat(v6, "\n")
                    v8 = blocks
                    v10 = p2
                    v8 = v8(v7, v10)
                    v3.RawText = v7
                    v3.Iterator = v8
                end
            end
        end
        return v1, v3
    end

    return it
end

v1.sanitize = sanitize

function v1.parse(p1, p2) -- Line: 271 -- upvalues: richText (val), u41 (val), u42 (val), blocks (val)
    local it
    local v1 = string.gsub(p1, "\t", "    ")
    local u8 = p2
    if not u8 then
        u8 = richText
    end
    local None = u41.None
    local u15 = string.split(v1, "\n")
    local u16 = 0

    local function u18() -- Line: 135 -- upvalues: u16 (ref), u15 (val), None (ref), u41 (upval)
        u16 = u16 + 1
        local v1 = u15[u16]
        if not v1 then
            return
        end
        if None == u41.Code then
            if string.match(v1, "^```") then
                None = u41.None
            end
            return u41.Code, v1
        end
        if string.match(v1, "^%s*$") then
            return u41.None, ""
        end
        if not string.match(v1, "^%-%-%-+") and not string.match(v1, "^===+") then
            if string.match(v1, "^%s*!%[%w-|?[%dx]*,? ?%d*%%?%]%(.-%)") then
                return u41.Image, v1
            end
            if string.match(v1, "^#") then
                return u41.Heading, v1
            end
            if string.match(v1, "^%s*```") then
                None = u41.Code
                return None, v1
            end
            if string.match(v1, "^%s*>") then
                return u41.Quote, v1
            end
            if not string.match(v1, "^%s*%-%s+")
                and not string.match(v1, "^%s*%*%s+")
                and not string.match(v1, "^%s*[%u%d]+%.%s+")
                and not string.match(v1, "^%s*%+%s+") then
                return u41.Paragraph, v1
            end
            return u41.List, v1
        end
        return u41.Ruler, ""
    end

    local u20, u21 = u18()

    local function u22() -- Line: 192 -- upvalues: u18 (val), u41 (upval), u20 (ref), u21 (ref), u42 (upval)
        local v1, v2, v3
        local v4, v5 = u18()
        if v4 == u41.Ruler and u20 == u41.Paragraph then
            local v6
            v1 = u21
            v2, v3 = u18()
            u20 = v2
            u21 = v3
            local Heading = u41.Heading
            local rep = string.rep
            local v7 = u21
            if string.sub(v7, 1, 1) ~= "=" then
                v6 = 1
            else
                v6 = 2
            end
            return Heading, (rep("#", v6)) .. " " .. v1
        end
        v1 = {u21}
        while u42[v4] do
            if v4 ~= u20 then
                break
            end
            table.insert(v1, v5)
            v2, v3 = u18()
            v4 = v2
            v5 = v3
        end
        v2 = u20
        v3 = table.concat(v1, "\n")
        u20 = v4
        u21 = v5
        return v2, v3
    end

    function it() -- Line: 216 -- upvalues: u22 (val), u41 (upval), it (val), u8 (val), blocks (upval)
        local v1, v2 = u22()
        if v1 == u41.None then
            return it()
        end
        local v3 = {}
        if v1 then
            if v1 == u41.Paragraph then
                v3.Text = u8(v2)
            else
                local v4, v5, v6, v7, v8, v9, v10
                if v1 == u41.Image then
                    v6 = string.match(v2, "^!%[(%w-)|?[%dx]*,? ?%d*%%?%]")
                    v7 = string.match(v2, "%((.-)%)$")
                    v3.Title = v6 or "Unknown"
                    v3.ID = v7 or "6266306999"
                    v8, v9 = string.match(v2, "^%s*!%[%w-|(%d+)x(%d+)%]*")
                    v10 = tonumber(v8)
                    local v11 = tonumber(v9)
                    local v12 = {}
                    v4 = v10 and v10 or 1024
                    v12.X = v4
                    v4 = v11 and v11 or 1024
                    v12.Y = v4
                    v3.Resolution = v12
                    v4 = v10 and v10 or 1
                    v5 = v11 and v11 or 1
                    v3.AspectRatio = v4 / v5
                    v12 = string.match(v2, "^%s*!%[%w-|?[%dx]*, (%d+)%%")
                    v3.Scale = (tonumber(v12) or 100) / 100
                elseif v1 == u41.Heading then
                    v6, v7 = string.match(v2, "^#+()%s*(.*)")
                    v8 = v6 - 1
                    v9 = u8
                    v9 = v9(v7)
                    v3.Level = v8
                    v3.Text = v9
                elseif v1 == u41.Code then
                    v6, v7 = string.match(v2, "^```(.-)\n(.*)\n```$")
                    v3.Syntax = v6
                    v3.Code = v7
                elseif v1 == u41.List then
                    local v13, v14, v15
                    v6 = string.split(v2, "\n")
                    for i2, v in ipairs(v6) do
                        v5, v13 = string.match(v, "^%s*()(.*)")
                        v15 = v5 / 2
                        v4 = math.floor(v15)
                        v5, v13 = string.match(v13, "^(.-)%s+(.*)")
                        v14 = {Level = v4, Text = u8(v13), Symbol = v5}
                        v6[i2] = v14
                    end
                    v3.Lines = v6
                elseif v1 == u41.Quote then
                    v6 = string.split(v2, "\n")
                    v7 = #v6
                    for i = 1, v7 do
                        v6[i] = (string.match(v6[i], "^%s*>%s*(.*)"))
                    end
                    v7 = table.concat(v6, "\n")
                    v8 = blocks
                    v10 = u8
                    v8 = v8(v7, v10)
                    v3.RawText = v7
                    v3.Iterator = v8
                end
            end
        end
        return v1, v3
    end

    return it
end

v1.BlockType = u41
v1.InlineType = {Text = 0, Ref = 1}
v1.ModifierType = v2
return v1