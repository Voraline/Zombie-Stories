local TextService = game:GetService("TextService")
local u5 = {}

function u5.MakeDictionary(p1) -- Line: 6
    local v1 = {}
    local v2 = #p1
    for i = 1, v2 do
        v1[p1[i]] = true
    end
    return v1
end

function u5.DictionaryKeys(p1) -- Line: 17
    local v1 = {}
    for k in pairs(p1) do
        table.insert(v1, k)
    end
    return v1
end

local function transformInstanceSet(p1) -- Line: 28
    local v1 = {}
    local v2 = #p1
    for i = 1, v2 do
        v1[i] = p1[i].Name
    end
    return v1, p1
end

function u5.MakeFuzzyFinder(p1) -- Line: 42
    local v1, v2, v3
    local u63 = nil
    local u2 = {}
    if typeof(p1) ~= "Enum" then
        v1 = p1
    else
        v1 = p1:GetEnumItems()
    end
    if typeof(v1) == "Instance" then
        local Children = v1:GetChildren()
        v2 = {}
        v3 = #Children
        for n = 1, v3 do
            v2[n] = Children[n].Name
        end
        u63 = v2
        u2 = Children
    elseif typeof(v1) ~= "table" then
        error("MakeFuzzyFinder only accepts a table, Enum, or Instance.")
    else
        local v4
        local v5 = v1[1]
        if typeof(v5) == "Instance" then
            v4 = v1
            v2 = {}
            v3 = #v4
            for i = 1, v3 do
                v2[i] = v4[i].Name
            end
            u63 = v2
            u2 = v4
        else
            v5 = v1[1]
            if typeof(v5) == "EnumItem" then
                v4 = v1
                v2 = {}
                v3 = #v4
                for j = 1, v3 do
                    v2[j] = v4[j].Name
                end
                u63 = v2
                u2 = v4
            else
                v5 = v1[1]
                if typeof(v5) ~= "table" then
                    v5 = v1[1]
                    if type(v5) == "string" then
                        u63 = v1
                    elseif v1[1] == nil then
                        u63 = {}
                    else
                        error("MakeFuzzyFinder only accepts tables of instances or strings.")
                    end
                else
                    v5 = v1[1]
                    local Name = v5.Name
                    if typeof(Name) ~= "string" then
                        v5 = v1[1]
                        if type(v5) == "string" then
                            u63 = v1
                        elseif v1[1] == nil then
                            u63 = {}
                        else
                            error("MakeFuzzyFinder only accepts tables of instances or strings.")
                        end
                    else
                        v4 = v1
                        v2 = {}
                        v3 = #v4
                        for k = 1, v3 do
                            v2[k] = v4[k].Name
                        end
                        u63 = v2
                        u2 = v4
                    end
                end
            end
        end
    end
    return function(p1, p2) -- Line: 70 -- upvalues: u63 (ref), u2 (ref)
        local v1, v2, v3
        local v4 = {}
        local v5, v6 = p2, p1
        for k, v in pairs(u63) do
            if not u2 then
                v2 = v
            else
                v2 = u2[k]
                if not v2 then
                    v2 = v
                end
            end
            v3 = v:lower()
            if v3 ~= v6:lower() then
                v3 = v:lower()
                v1 = v6:lower()
                if v3:find(v1, 1, true) then
                    v4[#v4 + 1] = v2
                end
            else
                if v5 then
                    return v2
                end
                table.insert(v4, 1, v2)
            end
        end
        if v5 then
            return v4[1]
        end
        return v4
    end
end

function u5.GetNames(p1) -- Line: 98
    local Name, v1
    local v2 = {}
    local v3 = #p1
    local v4 = p1
    for i = 1, v3 do
        Name = v4[i].Name
        if not Name then
            v1 = v4[i]
            Name = tostring(v1)
        end
        v2[i] = Name
    end
    return v2
end

function u5.SplitStringSimple(p1, p2) -- Line: 109
    local v1
    if p2 ~= nil then
        v1 = p2
    else
        v1 = "%s"
    end
    local v2 = {}
    local v3 = 1
    for i in string.gmatch(p1, "([^" .. v1 .. "]+)") do
        v2[v3] = i
        v3 = v3 + 1
    end
    return v2
end

local function charCode(p1) -- Line: 122
    return utf8.char((tonumber(p1, 16)))
end

function u5.ParseEscapeSequences(p1) -- Line: 127 -- upvalues: charCode (val)
    local v1 = p1:gsub("\\(.)", {t = "\t", n = "\n"})
    local v2 = charCode
    v1 = v1:gsub("\\u(%x%x%x%x)", v2)
    v2 = charCode
    return v1:gsub("\\x(%x%x)", v2)
end

function u5.EncodeEscapedOperator(p1, p2) -- Line: 136
    local v1 = p2:sub(1, 1)
    local v2 = p2:gsub(".", "%%%1")
    local v3 = "(" .. ("%" .. v1) .. "+)(" .. v2 .. ")"
    return p1:gsub(v3, function(p1, p2) -- Line: 141
        local v1 = #p1 - 1
        return ((p1:sub(1, v1)) .. p2):gsub(".", function(p1) -- Line: 142
            return "\\u" .. string.format("%04x", string.byte(p1), 16)
        end)
    end)
end

local u15 = {"&&", "||", ";"}

function u5.EncodeEscapedOperators(p1) -- Line: 149 -- upvalues: u15 (val), u5 (val)
    local v1 = p1
    for i, v in ipairs(u15) do
        v1 = u5.EncodeEscapedOperator(v1, v)
    end
    return v1
end

local function encodeControlChars(p1) -- Line: 157
    return ((((p1:gsub("\\\\", "___!CMDR_ESCAPE!___")):gsub("\\\"", "___!CMDR_QUOTE!___")):gsub("\\'", "___!CMDR_SQUOTE!___")):gsub(
        "\\\n",
        "___!CMDR_NL!___"
    ))
end

local function decodeControlChars(p1) -- Line: 167
    return (((p1:gsub("___!CMDR_ESCAPE!___", "\\")):gsub("___!CMDR_QUOTE!___", "\"")):gsub("___!CMDR_NL!___", "\n"))
end

function u5.SplitString(p1, p2) -- Line: 177 -- upvalues: u5 (val)
    local v1, v2, v3, v4, v5, v6, v7
    local v8 = (((p1:gsub("\\\\", "___!CMDR_ESCAPE!___")):gsub("\\\"", "___!CMDR_QUOTE!___")):gsub("\\'", "___!CMDR_SQUOTE!___")):gsub(
        "\\\n",
        "___!CMDR_NL!___"
    )
    local v9 = p2 or (1 / 0)
    local v10 = {}
    local v11 = nil
    local v12 = nil
    for i in v8:gmatch("[^ ]+") do
        v7 = u5.ParseEscapeSequences(i)
        v1 = v7:match("^(['\"])")
        v2 = v7:match("(['\"])$")
        v3 = v7:match("(\\*)['\"]$")
        if not v1 or v12 then
            if not v11 or v2 ~= v12 then
                if v11 then
                    v11 = v11 .. " " .. v7
                end
            elseif #v3 % 2 == 0 then
                v7 = v11 .. " " .. v7
                v11 = nil
                v12 = nil
            elseif v11 then
                v11 = v11 .. " " .. v7
            end
        elseif not v2 then
            v11 = v7
            v12 = v1
        elseif not v11 or v2 ~= v12 then
            if v11 then
                v11 = v11 .. " " .. v7
            end
        elseif #v3 % 2 == 0 then
            v7 = v11 .. " " .. v7
            v11 = nil
            v12 = nil
        elseif v11 then
            v11 = v11 .. " " .. v7
        end
        if not v11 then
            v5 = #v10
            if not (v9 < #v10) then
                v6 = 1
            else
                v6 = 0
            end
            v4 = v5 + v6
            v10[v4] = (((((v7:gsub("^(['\"])", "")):gsub("(['\"])$", "")):gsub("___!CMDR_ESCAPE!___", "\\")):gsub(
                "___!CMDR_QUOTE!___",
                "\""
            )):gsub(
                "___!CMDR_NL!___",
                "\n"
            ))
        end
    end
    if v11 then
        local v13
        local v14 = #v10
        if not (v9 < #v10) then
            v13 = 1
        else
            v13 = 0
        end
        local v15 = v14 + v13
        v10[v15] = (((v11:gsub("___!CMDR_ESCAPE!___", "\\")):gsub("___!CMDR_QUOTE!___", "\"")):gsub("___!CMDR_NL!___", "\n"))
    end
    return v10
end

function u5.MashExcessArguments(p1, p2) -- Line: 209
    local v1, v2
    local v3 = {}
    local v4 = #p1
    local v5, v6 = p2, p1
    for i = 1, v4 do
        if not (v5 < i) then
            v3[i] = v6[i]
        else
            v1 = v3[v5] or ""
            v2 = v6[i]
            v3[v5] = (("%s %s"):format(v1, v2))
        end
    end
    return v3
end

function u5.TrimString(p1) -- Line: 222
    local v1
    _, v1 = string.find(p1, "^%s*")
    if v1 == #p1 then
        return ""
    end
    return (string.match(p1, ".*%S", v1 + 1))
end

function u5.GetTextSize(p1, p2, p3) -- Line: 229 -- upvalues: TextService (val)
    local v1 = TextService
    local TextSize = p2.TextSize
    local Font = p2.Font
    local v2 = p3
    if not v2 then
        v2 = Vector2.new(p2.AbsoluteSize.X, 0)
    end
    return v1:GetTextSize(p1, TextSize, Font, v2)
end

function u5.MakeEnumType(p1, p2) -- Line: 234 -- upvalues: u5 (val)
    local u5_2 = u5.MakeFuzzyFinder(p2)
    return {
        Validate = function(p1_2) -- Line: 237 -- upvalues: u5_2 (val), p1 (val)
            local v1 = u5_2(p1_2, true) ~= nil
            local v2 = p1
            return v1, ("Value %q is not a valid %s."):format(p1_2, v2)
        end,
        Autocomplete = function(p1) -- Line: 240 -- upvalues: u5_2 (val), u5 (upval)
            local v1
            local v2 = u5_2(p1)
            local v3 = v2[1]
            if type(v3) == "string" then
                v1 = v2
            else
                v1 = u5.GetNames(v2)
                if not v1 then
                    v1 = v2
                end
            end
            return v1
        end,
        Parse = function(p1) -- Line: 244 -- upvalues: u5_2 (val)
            return u5_2(p1, true)
        end,
    }
end

function u5.ParsePrefixedUnionType(p1, p2) -- Line: 251 -- upvalues: u5 (val)
    local type, v1, v2
    local v3 = u5.SplitStringSimple(p1)
    local v4 = {}
    local v5 = #v3
    for i = 1, v5, 2 do
        v2 = #v4 + 1
        v4[v2] = {prefix = v3[i - 1] or "", type = v3[i]}
    end
    table.sort(v4, function(p1, p2) -- Line: 265
        local v1 = #p1.prefix
        local v2 = #p2.prefix < v1
        return v2
    end)
    v5 = #v4
    for j = 1, v5 do
        v2 = v4[j]
        v1 = #v2.prefix
        if (p2:sub(1, v1)) == v2.prefix then
            type = v2.type
            v1 = #v2.prefix + 1
            return type, (p2:sub(v1)), v2.prefix
        end
    end
end

function u5.MakeListableType(p1, p2) -- Line: 280
    local v1 = {Listable = true}
    v1.Transform = p1.Transform
    v1.Validate = p1.Validate
    v1.ValidateOnce = p1.ValidateOnce
    v1.Autocomplete = p1.Autocomplete
    v1.Default = p1.Default
    v1.ArgumentOperatorAliases = p1.ArgumentOperatorAliases

    function v1.Parse(...) -- Line: 289 -- upvalues: p1 (val)
        return {p1.Parse(...)}
    end

    if p2 then
        for k, v in pairs(p2) do
            v1[k] = v
        end
    end
    return v1
end

local function encodeCommandEscape(p1) -- Line: 303
    return (p1:gsub("\\%$", "___!CMDR_DOLLAR!___"))
end

local function decodeCommandEscape(p1) -- Line: 307
    return (p1:gsub("___!CMDR_DOLLAR!___", "$"))
end

function u5.RunCommandString(p1, p2) -- Line: 311 -- upvalues: u5 (val)
    local v1, v2, v3, v4, v5
    local v6 = u5.ParseEscapeSequences(p2)
    local v7 = u5.EncodeEscapedOperators(v6):split("&&")
    local v8 = ""
    local v9 = p1
    for i, v in ipairs(v7) do
        v5 = (v8:gsub("%$", "\\x24")):gsub("%%", "%%%%")
        v3 = "||"
        if not v8:find("%s") then
            v4 = v5
        else
            v4 = ("%q"):format(v5)
            if not v4 then
                v4 = v5
            end
        end
        v1 = v:gsub(v3, v4)
        v4 = u5
        v4 = v4.RunEmbeddedCommands(v9, v1)
        v2 = v9:EvaluateAndRun(v4)
        v8 = tostring(v2)
        if i == #v7 then
            return v8
        end
    end
end

function u5.RunEmbeddedCommands(p1, p2) -- Line: 338 -- upvalues: u5 (val)
    local v1, v2, v3, v4
    local v5 = p2:gsub("\\%$", "___!CMDR_DOLLAR!___")
    local v6 = {}
    for i in v5:gmatch("$(%b{})") do
        v3 = true
        v2 = #i
        v1 = v2 - 1
        v4 = i:sub(2, v1)
        if v4:match("^{.+}$") then
            v3 = false
            v2 = #v4 - 1
            v4 = v4:sub(2, v2)
        end
        v6[i] = (u5.RunCommandString(v7, v4))
        if v3 then
            if v6[i]:find("%s") or v6[i] == "" then
                v6[i] = (string.format("%q", v6[i]))
            end
        end
    end
    return ((v5:gsub("$(%b{})", v6)):gsub("___!CMDR_DOLLAR!___", "$"))
end

function u5.SubstituteArgs(p1, p2) -- Line: 366
    local v1
    local v2 = p1:gsub("\\%$", "___!CMDR_DOLLAR!___")
    if type(p2) ~= "table" then
        v1 = p2
    else
        local v3
        local v4 = #p2
        v1 = p2
        for i = 1, v4 do
            v3 = tostring(i)
            v1[v3] = v1[i]
            if v1[v3]:find("%s") then
                v1[v3] = (string.format("%q", v1[v3]))
            end
        end
    end
    return (((v2:gsub("($%d+)%b{}", "%1")):gsub("$(%w+)", v1)):gsub("___!CMDR_DOLLAR!___", "$"))
end

function u5.MakeAliasCommand(p1, p2) -- Line: 383 -- upvalues: u5 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    local v11 = p1:split("|")
    v10, v11 = unpack(v11)
    local v12 = {}
    local u124 = u5.EncodeEscapedOperators(p2)
    local v13 = {}
    for i in u124:gmatch("$(%d+)") do
        if v13[i] == nil then
            v13[i] = true
            v3 = ("$%*(%%b{})"):format(i)
            v1 = u124:match(v3)
            v3 = nil
            v4 = nil
            v5 = nil
            if v1 then
                v9 = #v1 - 1
                v7 = v1:sub(2, v9):split("|")
                v6, v7, v8 = unpack(v7)
                v3 = v6
                v4 = v7
                v5 = v8
            end
            v6 = v3 and not not v3:match("%?$")
            v2 = v6
            if not v3 then
                v3 = "string"
            else
                v3 = v3:match("^%w+")
            end
            v6 = v4
            if not v6 then
                v6 = ("Argument %*"):format(i)
            end
            v8 = {Type = v3, Name = v6, Description = v5 or "", Optional = v2}
            table.insert(v12, v8)
        end
    end
    return {
        Group = "UserAlias",
        Name = v10,
        Aliases = {},
        Description = ("<Alias> %*"):format(v11 or u124),
        Args = v12,
        Run = function(p1) -- Line: 422 -- upvalues: u5 (upval), u124 (ref)
            return u5.RunCommandString(p1.Dispatcher, u5.SubstituteArgs(u124, p1.RawArguments))
        end,
    }
end

function u5.MakeSequenceType(p1) -- Line: 429 -- upvalues: u5 (val)
    local v1 = p1 or {}
    local u4 = v1
    local v2 = true
    if u4.Parse == nil then
        v2 = u4.Constructor ~= nil
    end
    assert(v2, "MakeSequenceType: Must provide one of: Constructor, Parse")
    local TransformEach = u4.TransformEach
    if not TransformEach then
        function TransformEach(...) -- Line: 434
            return ...
        end
    end
    u4.TransformEach = TransformEach
    local ValidateEach = u4.ValidateEach
    if not ValidateEach then
        function ValidateEach() -- Line: 438
            return true
        end
    end
    u4.ValidateEach = ValidateEach
    v1 = {
        Prefixes = u4.Prefixes,
        Transform = function(p1) -- Line: 445 -- upvalues: u5 (upval), u4 (ref)
            local v1 = u5
            local Map = v1.Map
            local v2 = u5
            return Map(v2.SplitPrioritizedDelimeter(p1, {",", "%s"}), function(p1) -- Line: 446 -- upvalues: u4 (upval)
                return u4.TransformEach(p1)
            end)
        end,
        Validate = function(p1) -- Line: 451 -- upvalues: u4 (ref)
            local v1, v2
            if u4.Length then
                local v3 = #p1
                if u4.Length < v3 then
                    v1 = u4
                    local Length = v1.Length
                    return false, ("Maximum of %d values allowed in sequence"):format(Length)
                end
            end
            local Length_2 = u4.Length
            if not Length_2 then
                Length_2 = #p1
            end
            for i = 1, Length_2 do
                v1, v2 = u4.ValidateEach(p1[i], i)
                if not v1 then
                    return false, v2
                end
            end
            return true
        end,
    }
    local Parse = u4.Parse
    if not Parse then
        function Parse(p1) -- Line: 467 -- upvalues: u4 (ref)
            return u4.Constructor(unpack(p1))
        end
    end
    v1.Parse = Parse
    return v1
end

function u5.SplitPrioritizedDelimeter(p1, p2) -- Line: 475 -- upvalues: u5 (val)
    for i, v in ipairs(p2) do
        if not p1:find(v) and i ~= #p2 then
            continue
        end
        return u5.SplitStringSimple(p1, v)
    end
end

function u5.Map(p1, p2) -- Line: 484
    local v1 = {}
    for i, v in ipairs(p1) do
        v1[i] = (p2(v, i))
    end
    return v1
end

function u5.Each(p1, ...) -- Line: 495
    local v1 = {}
    local v2 = ipairs
    local v3 = {...}
    for i, v in v2(v3) do
        v1[i] = (p1(v))
    end
    return unpack(v1)
end

function u5.EmulateTabstops(p1, p2) -- Line: 504
    local v1, v2, v3
    local v4 = 0
    local v5 = #p1
    local v6 = table.create(v5)
    local v7 = v5
    local v8, v9 = p1, p2
    for i = 1, v7 do
        v2 = string.sub(v8, i, i)
        if v2 ~= "\t" then
            table.insert(v6, v2)
            if v2 == "\n" then
                v4 = 0
            elseif v2 ~= "\r" then
                v4 = v4 + 1
            end
        else
            v3 = v9 - v4 % v9
            v1 = string.rep(" ", v3)
            table.insert(v6, v1)
            v4 = v4 + v3
        end
    end
    return table.concat(v6)
end

function u5.Mutex() -- Line: 526
    local u0 = {}
    local u1 = false
    return function() -- Line: 530 -- upvalues: u1 (ref), u0 (val)
        if not u1 then
            u1 = true
        else
            local v1 = u0
            local v2 = coroutine.running()
            table.insert(v1, v2)
            coroutine.yield()
        end
        return function() -- Line: 538 -- upvalues: u0 (upval), u1 (upval)
            if 0 < #u0 then
                coroutine.resume(table.remove(u0, 1))
                return
            end
            u1 = false
        end
    end
end

return u5