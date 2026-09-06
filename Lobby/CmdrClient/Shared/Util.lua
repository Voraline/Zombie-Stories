local TextService = game:GetService("TextService")
local u5 = {
    MakeDictionary = function(p1) -- Line: 6
        local v1 = {}
        local v2 = #p1
        local v3 = 1
        for i = 1, v2, v3 do
            v1[p1[i]] = true
        end
        return v1
    end,
    DictionaryKeys = function(p1) -- Line: 17
        local v1 = {}
        for k in pairs(p1) do
            table.insert(v1, k)
        end
        return v1
    end,
}
local function transformInstanceSet(p1) -- Line: 28
    local v1 = {}
    local v2 = #p1
    local v3 = 1
    for i = 1, v2, v3 do
        v1[i] = p1[i].Name
    end
    return v1, p1
end
function u5.MakeFuzzyFinder(p1) -- Line: 42
    local v1, v2, v3, v4
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
        v4 = 1
        for j = 1, v3, v4 do
            v2[j] = Children[j].Name
        end
        u63 = v2
        u2 = Children
    elseif typeof(v1) ~= "table" then
        error("MakeFuzzyFinder only accepts a table, Enum, or Instance.")
    elseif typeof(v1[1]) == "Instance" then
        local v5 = v1
        v2 = {}
        v3 = #v5
        v4 = 1
        for i = 1, v3, v4 do
            v2[i] = v5[i].Name
        end
        u63 = v2
        u2 = v5
    elseif typeof(v1[1]) ~= "EnumItem" then
        if typeof(v1[1]) ~= "table" then
            if type(v1[1]) == "string" then
                u63 = v1
            elseif v1[1] == nil then
                u63 = {}
            else
                error("MakeFuzzyFinder only accepts tables of instances or strings.")
            end
        elseif typeof(v1[1].Name) ~= "string" then
            if type(v1[1]) == "string" then
                u63 = v1
            elseif v1[1] == nil then
                u63 = {}
            else
                error("MakeFuzzyFinder only accepts tables of instances or strings.")
            end
        end
    end
    return function(p1, p2) -- Line: 70 -- upvalues: u63 (ref), u2 (ref)
        local v1, v2, v3, v4, v5
        local v6 = {}
        v2, v1 = p2, p1
        for k, v in pairs(u63) do
            if not u2 then
                v4 = v
            else
                v4 = u2[k]
            end
            v5 = v:lower()
            if v5 ~= v1:lower() then
                v3 = v1:lower()
                if v:lower():find(v3, 1, true) then
                    v6[#v6 + 1] = v4
                end
            else
                if v2 then
                    return v4
                end
                table.insert(v6, 1, v4)
            end
        end
        if v2 then
            return v6[1]
        end
        return v6
    end
end
function u5.GetNames(p1) -- Line: 98
    local Name
    local v1 = {}
    local v2 = #p1
    local v3 = 1
    local v4 = p1
    for i = 1, v2, v3 do
        Name = v4[i].Name
        if not Name then
            Name = tostring(v4[i])
        end
        v1[i] = Name
    end
    return v1
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
    v1 = v1:gsub("\\u(%x%x%x%x)", charCode)
    return v1:gsub("\\x(%x%x)", charCode)
end
function u5.EncodeEscapedOperator(p1, p2) -- Line: 136
    local v1 = p2:sub(1, 1)
    local v2 = p2:gsub(".", "%%%1")
    return p1:gsub("(" .. ("%" .. v1) .. "+)(" .. v2 .. ")", function(p1, p2) -- Line: 141
        local v1 = p1:sub(1, #p1 - 1)
        return (v1 .. p2):gsub(".", function(p1) -- Line: 142
            local v1 = string.byte(p1)
            return "\\u" .. string.format("%04x", v1, 16)
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
    local v1 = p1:gsub("\\\\", "___!CMDR_ESCAPE!___")
    v1 = v1:gsub("\\\"", "___!CMDR_QUOTE!___")
    v1 = v1:gsub("\\'", "___!CMDR_SQUOTE!___")
    return (v1:gsub("\\\n", "___!CMDR_NL!___"))
end
local function decodeControlChars(p1) -- Line: 167
    local v1 = p1:gsub("___!CMDR_ESCAPE!___", "\\")
    v1 = v1:gsub("___!CMDR_QUOTE!___", "\"")
    return (v1:gsub("___!CMDR_NL!___", "\n"))
end
function u5.SplitString(p1, p2) -- Line: 177 -- upvalues: u5 (val)
    local v1, v2, v3, v4, v5, v6, v7
    local v8 = p1:gsub("\\\\", "___!CMDR_ESCAPE!___")
    v8 = v8:gsub("\\\"", "___!CMDR_QUOTE!___")
    v8 = v8:gsub("\\'", "___!CMDR_SQUOTE!___")
    local v9 = v8:gsub("\\\n", "___!CMDR_NL!___")
    local v10 = p2 or (1 / 0)
    local v11 = {}
    v8 = nil
    local v12 = nil
    for i in v9:gmatch("[^ ]+") do
        v7 = u5.ParseEscapeSequences(i)
        v1 = v7:match("^(['\"])")
        v2 = v7:match("(['\"])$")
        v3 = v7:match("(\\*)['\"]$")
        if not v1 then
            if not v8 then
                if v8 then
                    v8 = v8 .. " " .. v7
                end
            elseif v2 == v12 and #v3 % 2 == 0 then
                v7 = v8 .. " " .. v7
                v8 = nil
                v12 = nil
            end
        elseif not v12 and not v2 then
            v8 = v7
            v12 = v1
        end
        if not v8 then
            if v10 >= #v11 then
                v5 = 1
            else
                v5 = 0
            end
            v4 = #v11 + v5
            v5 = v7:gsub("^(['\"])", "")
            v5 = v5:gsub("(['\"])$", "")
            v6 = v5:gsub("___!CMDR_ESCAPE!___", "\\")
            v6 = v6:gsub("___!CMDR_QUOTE!___", "\"")
            v11[v4] = v6:gsub("___!CMDR_NL!___", "\n")
        end
    end
    if v8 then
        local v13
        if v10 >= #v11 then
            v13 = 1
        else
            v13 = 0
        end
        local v14 = #v11 + v13
        v7 = v8:gsub("___!CMDR_ESCAPE!___", "\\")
        v7 = v7:gsub("___!CMDR_QUOTE!___", "\"")
        v11[v14] = v7:gsub("___!CMDR_NL!___", "\n")
    end
    return v11
end
function u5.MashExcessArguments(p1, p2) -- Line: 209
    local v1, v2
    local v3 = {}
    local v4 = #p1
    local v5 = 1
    v2, v1 = p2, p1
    for i = 1, v4, v5 do
        if v2 >= i then
            v3[i] = v1[i]
        else
            v3[v2] = ("%s %s"):format(v3[v2] or "", v1[i])
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
    local v1 = p3
    if not v1 then
        v1 = Vector2.new(p2.AbsoluteSize.X, 0)
    end
    return TextService:GetTextSize(p1, p2.TextSize, p2.Font, v1)
end
function u5.MakeEnumType(p1, p2) -- Line: 234 -- upvalues: u5 (val)
    local u5
    u5 = u5.MakeFuzzyFinder(p2)
    return {
        Validate = function(a1) -- Line: 237 -- upvalues: u5 (val), p1 (val)
            local v1 = u5(a1, true) ~= nil
            return v1, ("Value %q is not a valid %s."):format(a1, p1)
        end,
        Autocomplete = function(p1) -- Line: 240 -- upvalues: u5 (val), u5 (upval)
            local v1
            local v2 = u5(p1)
            if type(v2[1]) == "string" then
                v1 = v2
            else
                v1 = u5.GetNames(v2)
                if not v1 then
                    v1 = v2
                end
            end
            return v1
        end,
        Parse = function(p1) -- Line: 244 -- upvalues: u5 (val)
            return u5(p1, true)
        end,
    }
end
function u5.ParsePrefixedUnionType(p1, p2) -- Line: 251 -- upvalues: u5 (val)
    local v1, v2, v3
    local v4 = u5.SplitStringSimple(p1)
    local v5 = {}
    local v6 = #v4
    local v7 = 2
    for i = 1, v6, v7 do
        v5[#v5 + 1] = {prefix = v4[i - 1] or "", type = v4[i]}
    end
    table.sort(v5, function(p1, p2) -- Line: 265
        local v1 = #p1.prefix
        local v2 = #p2.prefix < v1
        return v2
    end)
    v6 = #v5
    v7 = 1
    for j = 1, v6, v7 do
        v1 = v5[j]
        v2 = p2:sub(1, #v1.prefix)
        if v2 == v1.prefix then
            v3 = p2:sub(#v1.prefix + 1)
            return v1.type, v3, v1.prefix
        end
    end
end
function u5.MakeListableType(p1, p2) -- Line: 280
    local v1 = {
        Listable = true,
        Transform = p1.Transform,
        Validate = p1.Validate,
        ValidateOnce = p1.ValidateOnce,
        Autocomplete = p1.Autocomplete,
        Default = p1.Default,
        ArgumentOperatorAliases = p1.ArgumentOperatorAliases,
        Parse = function(...) -- Line: 289 -- upvalues: p1 (val)
            return {p1.Parse(...)}
        end,
    }
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
    local v1, v2, v3
    local v4 = u5.ParseEscapeSequences(p2)
    local v5 = u5.EncodeEscapedOperators(v4):split("&&")
    local v6 = ""
    local v7 = p1
    for i, v in ipairs(v5) do
        v3 = v6:gsub("%$", "\\x24")
        v3 = v3:gsub("%%", "%%%%")
        v1 = "||"
        if not (v6:find("%s")) then
            v2 = v3
        else
            v2 = ("%q"):format(v3)
        end
        v6 = tostring(v7:EvaluateAndRun((u5.RunEmbeddedCommands(v7, (v:gsub(v1, v2))))))
        if i == #v5 then
            return v6
        end
    end
end
function u5.RunEmbeddedCommands(p1, p2) -- Line: 338 -- upvalues: u5 (val)
    local v1, v2
    local v3 = p2:gsub("\\%$", "___!CMDR_DOLLAR!___")
    local v4 = {}
    for i in v3:gmatch("$(%b{})") do
        v1 = true
        v2 = i:sub(2, #i - 1)
        if v2:match("^{.+}$") then
            v1 = false
            v2 = v2:sub(2, #v2 - 1)
        end
        v4[i] = u5.RunCommandString(v5, v2)
        if v1 then
            if v4[i]:find("%s") then
                v4[i] = string.format("%q", v4[i])
            elseif v4[i] ~= "" then
            end
        end
    end
    local v6 = v3:gsub("$(%b{})", v4)
    return (v6:gsub("___!CMDR_DOLLAR!___", "$"))
end
function u5.SubstituteArgs(p1, p2) -- Line: 366
    local v1, v2
    local v3 = p1:gsub("\\%$", "___!CMDR_DOLLAR!___")
    if type(p2) ~= "table" then
        v1 = p2
    else
        local v4
        local v5 = #p2
        v2 = 1
        v1 = p2
        for i = 1, v5, v2 do
            v4 = tostring(i)
            v1[v4] = v1[i]
            if v1[v4]:find("%s") then
                v1[v4] = string.format("%q", v1[v4])
            end
        end
    end
    v2 = v3:gsub("($%d+)%b{}", "%1")
    v2 = v2:gsub("$(%w+)", v1)
    return (v2:gsub("___!CMDR_DOLLAR!___", "$"))
end
function u5.MakeAliasCommand(p1, p2) -- Line: 383 -- upvalues: u5 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    v8, v9 = unpack(p1:split("|"))
    local v10 = {}
    local u124 = u5.EncodeEscapedOperators(p2)
    local v11 = {}
    for i in u124:gmatch("$(%d+)") do
        if v11[i] == nil then
            v11[i] = true
            v1 = u124:match((("$%*(%%b{})"):format(i)))
            v2 = nil
            v3 = nil
            v4 = nil
            if v1 then
                v5, v6, v7 = unpack(v1:sub(2, #v1 - 1):split("|"))
                v2 = v5
                v3 = v6
                v4 = v7
            end
            v5 = v2
            if v5 then
                v5 = not not v2:match("%?$")
            end
            if not v2 then
                v2 = "string"
            else
                v2 = v2:match("^%w+")
            end
            v5 = v3
            if not v5 then
                v5 = ("Argument %*"):format(i)
            end
            table.insert(v10, {Type = v2, Name = v5, Description = v4 or "", Optional = v5})
        end
    end
    return {
        Group = "UserAlias",
        Name = v8,
        Aliases = {},
        Description = ("<Alias> %*"):format(v9 or u124),
        Args = v10,
        Run = function(p1) -- Line: 422 -- upvalues: u5 (upval), u124 (ref)
            return u5.RunCommandString(p1.Dispatcher, u5.SubstituteArgs(u124, p1.RawArguments))
        end,
    }
end
function u5.MakeSequenceType(p1) -- Line: 429 -- upvalues: u5 (val)
    local Parse
    local v1 = p1
    if not v1 then
        v1 = {}
    end
    local u4 = v1
    local v2 = if u4.Parse == nil then u4.Constructor ~= nil else true
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
            local v1 = u5.SplitPrioritizedDelimeter(p1, {",", "%s"})
            return u5.Map(v1, function(p1) -- Line: 446 -- upvalues: u4 (upval)
                return u4.TransformEach(p1)
            end)
        end,
        Validate = function(p1) -- Line: 451 -- upvalues: u4 (ref)
            local Length
            if not u4.Length then
                local v1, v2
                Length = u4.Length
                if not Length then
                    Length = #p1
                end
                local v3 = 1
                for i = 1, Length, v3 do
                    v1, v2 = u4.ValidateEach(p1[i], i)
                    if not v1 then
                        return false, v2
                    end
                end
                return true
            elseif u4.Length < #p1 then
                return false, ("Maximum of %d values allowed in sequence"):format(u4.Length)
            end
        end,
    }
    Parse = u4.Parse
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
        if not (p1:find(v)) and i ~= #p2 then
            continue
        end
        return u5.SplitStringSimple(p1, v)
    end
end
function u5.Map(p1, p2) -- Line: 484
    local v1 = {}
    for i, v in ipairs(p1) do
        v1[i] = p2(v, i)
    end
    return v1
end
function u5.Each(p1, ...) -- Line: 495
    local v1 = {}
    local v2 = {...}
    for i, v in ipairs(v2) do
        v1[i] = p1(v)
    end
    return unpack(v1)
end
function u5.EmulateTabstops(p1, p2) -- Line: 504
    local v1, v2, v3, v4
    local v5 = 0
    local v6 = #p1
    local v7 = table.create(v6)
    local v8 = v6
    local v9 = 1
    v1, v2 = p1, p2
    for i = 1, v8, v9 do
        v3 = string.sub(v1, i, i)
        if v3 ~= "\t" then
            table.insert(v7, v3)
            if v3 == "\n" then
                v5 = 0
            elseif v3 ~= "\r" then
                v5 = v5 + 1
            end
        else
            v4 = v2 - v5 % v2
            table.insert(v7, string.rep(" ", v4))
            v5 = v5 + v4
        end
    end
    return table.concat(v7)
end
function u5.Mutex() -- Line: 526
    local u0 = {}
    local u1 = false
    return function() -- Line: 530 -- upvalues: u1 (ref), u0 (val)
        if not u1 then
            u1 = true
        else
            table.insert(u0, coroutine.running())
            coroutine.yield()
        end
        return function() -- Line: 538 -- upvalues: u0 (upval), u1 (upval)
            local v1 = #u0
            if 0 < v1 then
                coroutine.resume(table.remove(u0, 1))
                return
            end
            u1 = false
        end
    end
end
return u5