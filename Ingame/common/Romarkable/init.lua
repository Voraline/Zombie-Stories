local blocks
local v1 = {}
local v2 = {Text = 0, Ref = 1}
local v3 = {
    Bold = 0,
    Italic = 1,
    ItalicBold = 2,
    Strike = 3,
    Code = 4,
    Red = 5,
}
local function sanitize(p1) -- Line: 32
    local v1 = string.gsub(p1, "&", "&amp;")
    local v2 = string.gsub(v1, "<", "&lt;")
    local v3 = string.gsub(v2, ">", "&gt;")
    local v4 = string.gsub(v3, "\"", "&quot;")
    return string.gsub(v4, "'", "&apos;")
end
local u4 = {}
u4["`"] = v3.Code
u4["~"] = v3.Strike
u4["~~"] = v3.Strike
u4["*"] = v3.Italic
u4._ = v3.Italic
u4["**"] = v3.Bold
u4.__ = v3.Bold
u4.___ = v3.ItalicBold
u4["***"] = v3.ItalicBold
u4["||"] = v3.Red
local u15 = {}
u15[v3.Bold] = {"<font color=\"#e3df6d\"><b>", "</b></font>"}
u15[v3.Italic] = {"<font color=\"#b0ffdb\"><i>", "</i></font>"}
u15[v3.ItalicBold] = {"<font color=\"#e3df6d\"><b><i>", "</i></b></font>"}
u15[v3.Strike] = {"<s>", "</s>"}
u15[v3.Code] = {"<font face=\"RobotoMono\">", "</font>"}
local v4 = {"<font color=\"#fa7878\"><b>", "</b></font>"}
u15[v3.Red] = v4
local function richText(p1) -- Line: 62 -- upvalues: sanitize (val), u4 (val), u15 (val)
    local v1, v2, v3, v4, v5
    local v6 = sanitize(p1)
    local v7 = {}
    local v8 = 0
    local v9 = 0
    while true do
        v1, v2 = string.match(v6, "([%*_~`|]+)(%S[^\n]-)%1", v9)
        if not v1 then
            break
        end
        v3, v4 = string.find(v6, v1 .. v2 .. v1, v9, true)
        v5 = u15[u4[v1]]
        v8 = v8 + 1
        v7[v8] = string.sub(v6, v9, v3 - 1)
        v9 = v4 + 1
        if not v5 then
            v8 = v8 + 1
            v7[v8] = v2
        else
            v8 = v8 + 1
            v7[v8] = v5[1] .. v2 .. v5[2]
        end
    end
    v7[v8 + 1] = string.sub(v6, v9)
    return table.concat(v7)
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
    local v1, v2
    v1, v2 = string.match(p1, "^%s*()(.*)")
    return v2, (math.floor(v1 / 2))
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
        if string.match(v1, "^%-%-%-+") or string.match(v1, "^===+") then
            return u41.Ruler, ""
        end
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
        if string.match(v1, "^%s*%-%s+") or string.match(v1, "^%s*%*%s+") or string.match(v1, "^%s*[%u%d]+%.%s+") or string.match(v1, "^%s*%+%s+") then
            return u41.List, v1
        end
        return u41.Paragraph, v1
    end
end
local function textBlocks(p1) -- Line: 189 -- upvalues: u41 (val), u42 (val)
    local u12
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
        if string.match(v1, "^%-%-%-+") or string.match(v1, "^===+") then
            return u41.Ruler, ""
        end
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
        if string.match(v1, "^%s*%-%s+") or string.match(v1, "^%s*%*%s+") or string.match(v1, "^%s*[%u%d]+%.%s+") or string.match(v1, "^%s*%+%s+") then
            return u41.List, v1
        end
        return u41.Paragraph, v1
    end
    None, u12 = u9()
    function u7() -- Line: 192 -- upvalues: u9 (val), u41 (upval), None (ref), u12 (ref), u42 (upval)
        local v1, v2, v3, v4
        v1, v2 = u9()
        if v1 ~= u41.Ruler then
            local v5 = {u12}
            while u42[v1] do
                if v1 ~= None then
                    break
                end
                table.insert(v5, v2)
                v3, v4 = u9()
                v1 = v3
                v2 = v4
            end
            None = v1
            u12 = v2
            return None, (table.concat(v5, "\n"))
        elseif None == u41.Paragraph then
            local v6
            v3, v4 = u9()
            None = v3
            u12 = v4
            if string.sub(u12, 1, 1) ~= "=" then
                v6 = 1
            else
                v6 = 2
            end
            local v7 = string.rep("#", v6)
            return u41.Heading, v7 .. " " .. u12
        end
    end
    return u7
end
function blocks(p1, p2) -- Line: 214 -- upvalues: u41 (val), u42 (val), blocks (val)
    local it, u13
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
        if string.match(v1, "^%-%-%-+") or string.match(v1, "^===+") then
            return u41.Ruler, ""
        end
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
        if string.match(v1, "^%s*%-%s+") or string.match(v1, "^%s*%*%s+") or string.match(v1, "^%s*[%u%d]+%.%s+") or string.match(v1, "^%s*%+%s+") then
            return u41.List, v1
        end
        return u41.Paragraph, v1
    end
    None, u13 = u10()
    local function u14() -- Line: 192 -- upvalues: u10 (val), u41 (upval), None (ref), u13 (ref), u42 (upval)
        local v1, v2, v3, v4
        v1, v2 = u10()
        if v1 ~= u41.Ruler then
            local v5 = {u13}
            while u42[v1] do
                if v1 ~= None then
                    break
                end
                table.insert(v5, v2)
                v3, v4 = u10()
                v1 = v3
                v2 = v4
            end
            None = v1
            u13 = v2
            return None, (table.concat(v5, "\n"))
        elseif None == u41.Paragraph then
            local v6
            v3, v4 = u10()
            None = v3
            u13 = v4
            if string.sub(u13, 1, 1) ~= "=" then
                v6 = 1
            else
                v6 = 2
            end
            local v7 = string.rep("#", v6)
            return u41.Heading, v7 .. " " .. u13
        end
    end
    function it() -- Line: 216 -- upvalues: u14 (val), u41 (upval), it (val), p2 (val), blocks (upval)
        local v1, v2
        v1, v2 = u14()
        if v1 == u41.None then
            return it()
        end
        local v3 = {}
        if v1 then
            if v1 == u41.Paragraph then
                v3.Text = p2(v2)
            else
                local v4, v5, v6, v7, v8
                if v1 == u41.Image then
                    local v9
                    v6 = string.match(v2, "^!%[(%w-)|?[%dx]*,? ?%d*%%?%]")
                    v7 = string.match(v2, "%((.-)%)$")
                    v3.Title = v6 or "Unknown"
                    v3.ID = v7 or "6266306999"
                    v8, v9 = string.match(v2, "^%s*!%[%w-|(%d+)x(%d+)%]*")
                    local v10 = tonumber(v8)
                    local v11 = tonumber(v9)
                    local v12 = {}
                    if not v10 then
                        v4 = 1024
                    else
                        v4 = v10
                    end
                    v12.X = v4
                    if not v11 then
                        v4 = 1024
                    else
                        v4 = v11
                    end
                    v12.Y = v4
                    v3.Resolution = v12
                    if not v10 then
                        v4 = 1
                    else
                        v4 = v10
                    end
                    if not v11 then
                        v5 = 1
                    else
                        v5 = v11
                        if not v5 then
                            v5 = 1
                        end
                    end
                    v3.AspectRatio = v4 / v5
                    v3.Scale = (tonumber((string.match(v2, "^%s*!%[%w-|?[%dx]*, (%d+)%%"))) or 100) / 100
                elseif v1 == u41.Heading then
                    v6, v7 = string.match(v2, "^#+()%s*(.*)")
                    v3.Level = v6 - 1
                    v3.Text = p2(v7)
                elseif v1 == u41.Code then
                    v6, v7 = string.match(v2, "^```(.-)\n(.*)\n```$")
                    v3.Syntax = v6
                    v3.Code = v7
                elseif v1 == u41.List then
                    local v13
                    v6 = string.split(v2, "\n")
                    for i2, v in ipairs(v6) do
                        v5, v13 = string.match(v, "^%s*()(.*)")
                        v4 = math.floor(v5 / 2)
                        v5, v13 = string.match(v13, "^(.-)%s+(.*)")
                        v6[i2] = {Level = v4, Text = p2(v13), Symbol = v5}
                    end
                    v3.Lines = v6
                elseif v1 == u41.Quote then
                    v6 = string.split(v2, "\n")
                    v7 = #v6
                    v8 = 1
                    for i = 1, v7, v8 do
                        v6[i] = string.match(v6[i], "^%s*>%s*(.*)")
                    end
                    v7 = table.concat(v6, "\n")
                    v3.RawText = v7
                    v3.Iterator = blocks(v7, p2)
                end
            end
        end
        return v1, v3
    end
    return it
end
v1.sanitize = sanitize
function v1.parse(p1, p2) -- Line: 271 -- upvalues: richText (val), u41 (val), u42 (val), blocks (val)
    local it, u21
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
        if string.match(v1, "^%-%-%-+") or string.match(v1, "^===+") then
            return u41.Ruler, ""
        end
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
        if string.match(v1, "^%s*%-%s+") or string.match(v1, "^%s*%*%s+") or string.match(v1, "^%s*[%u%d]+%.%s+") or string.match(v1, "^%s*%+%s+") then
            return u41.List, v1
        end
        return u41.Paragraph, v1
    end
    None, u21 = u18()
    local function u22() -- Line: 192 -- upvalues: u18 (val), u41 (upval), None (ref), u21 (ref), u42 (upval)
        local v1, v2, v3, v4
        v1, v2 = u18()
        if v1 ~= u41.Ruler then
            local v5 = {u21}
            while u42[v1] do
                if v1 ~= None then
                    break
                end
                table.insert(v5, v2)
                v3, v4 = u18()
                v1 = v3
                v2 = v4
            end
            None = v1
            u21 = v2
            return None, (table.concat(v5, "\n"))
        elseif None == u41.Paragraph then
            local v6
            v3, v4 = u18()
            None = v3
            u21 = v4
            if string.sub(u21, 1, 1) ~= "=" then
                v6 = 1
            else
                v6 = 2
            end
            local v7 = string.rep("#", v6)
            return u41.Heading, v7 .. " " .. u21
        end
    end
    function it() -- Line: 216 -- upvalues: u22 (val), u41 (upval), it (val), u8 (val), blocks (upval)
        local v1, v2
        v1, v2 = u22()
        if v1 == u41.None then
            return it()
        end
        local v3 = {}
        if v1 then
            if v1 == u41.Paragraph then
                v3.Text = u8(v2)
            else
                local v4, v5, v6, v7, v8
                if v1 == u41.Image then
                    local v9
                    v6 = string.match(v2, "^!%[(%w-)|?[%dx]*,? ?%d*%%?%]")
                    v7 = string.match(v2, "%((.-)%)$")
                    v3.Title = v6 or "Unknown"
                    v3.ID = v7 or "6266306999"
                    v8, v9 = string.match(v2, "^%s*!%[%w-|(%d+)x(%d+)%]*")
                    local v10 = tonumber(v8)
                    local v11 = tonumber(v9)
                    local v12 = {}
                    if not v10 then
                        v4 = 1024
                    else
                        v4 = v10
                    end
                    v12.X = v4
                    if not v11 then
                        v4 = 1024
                    else
                        v4 = v11
                    end
                    v12.Y = v4
                    v3.Resolution = v12
                    if not v10 then
                        v4 = 1
                    else
                        v4 = v10
                    end
                    if not v11 then
                        v5 = 1
                    else
                        v5 = v11
                        if not v5 then
                            v5 = 1
                        end
                    end
                    v3.AspectRatio = v4 / v5
                    v3.Scale = (tonumber((string.match(v2, "^%s*!%[%w-|?[%dx]*, (%d+)%%"))) or 100) / 100
                elseif v1 == u41.Heading then
                    v6, v7 = string.match(v2, "^#+()%s*(.*)")
                    v3.Level = v6 - 1
                    v3.Text = u8(v7)
                elseif v1 == u41.Code then
                    v6, v7 = string.match(v2, "^```(.-)\n(.*)\n```$")
                    v3.Syntax = v6
                    v3.Code = v7
                elseif v1 == u41.List then
                    local v13
                    v6 = string.split(v2, "\n")
                    for i2, v in ipairs(v6) do
                        v5, v13 = string.match(v, "^%s*()(.*)")
                        v4 = math.floor(v5 / 2)
                        v5, v13 = string.match(v13, "^(.-)%s+(.*)")
                        v6[i2] = {Level = v4, Text = u8(v13), Symbol = v5}
                    end
                    v3.Lines = v6
                elseif v1 == u41.Quote then
                    v6 = string.split(v2, "\n")
                    v7 = #v6
                    v8 = 1
                    for i = 1, v7, v8 do
                        v6[i] = string.match(v6[i], "^%s*>%s*(.*)")
                    end
                    v7 = table.concat(v6, "\n")
                    v3.RawText = v7
                    v3.Iterator = blocks(v7, u8)
                end
            end
        end
        return v1, v3
    end
    return it
end
v1.BlockType = u41
v1.InlineType = v2
v1.ModifierType = v3
return v1