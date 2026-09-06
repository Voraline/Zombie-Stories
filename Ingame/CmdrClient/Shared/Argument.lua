local u2 = require("./Util")
local function unescapeOperators(p1) -- Line: 3
    local v1 = {"%.", "%?", "%*", "%*%*"}
    local v2 = p1
    for i, v in ipairs(v1) do
        v2 = v2:gsub("\\" .. v, v:gsub("%%", ""))
    end
    return v2
end
local u4 = {}
u4.__index = u4
function u4.new(p1, p2, p3) -- Line: 15 -- upvalues: u2 (val), u4 (val)
    local v1 = {
        Prefix = "",
        TextSegmentInProgress = "",
        RawSegmentsAreAutocomplete = false,
        Command = p1,
        Name = p2.Name,
        Object = p2,
    }
    local v2 = if p2.Default == nil then p2.Optional ~= true else false
    v1.Required = v2
    v1.Executor = p1.Executor
    v1.RawValue = p3
    v1.RawSegments = {}
    v2 = {}
    v1.TransformedValues = v2
    if type(p2.Type) ~= "table" then
        local v3, v4
        local TypeName = p1.Cmdr.Registry:GetTypeName(p2.Type)
        v2, v3, v4 = u2.ParsePrefixedUnionType(TypeName, p3)
        v1.Type = p1.Dispatcher.Registry:GetType(v2)
        v1.RawValue = v3
        v1.Prefix = v4
        if v1.Type == nil then
            error(string.format("%s has an unregistered type %q", v1.Name or "<none>", v2 or "<none>"))
        end
    else
        v1.Type = p2.Type
    end
    setmetatable(v1, u4)
    v1:Transform()
    return v1
end
function u4:GetDefaultAutocomplete() -- Line: 55
    local v1, v2
    if not self.Type.Autocomplete then
        return {}
    end
    v1, v2 = self.Type.Autocomplete(self:TransformSegment(""))
    local v3 = v2
    if not v3 then
        v3 = {}
    end
    return v1, v3
end
function u4:Transform() -- Line: 67 -- upvalues: unescapeOperators (val), u2 (val)
    local TransformedValues, TransformedValues_2, v1, v2, v3
    if #self.TransformedValues ~= 0 then
        return
    end
    local RawValue = self.RawValue
    if self.Type.ArgumentOperatorAliases then
        RawValue = self.Type.ArgumentOperatorAliases[RawValue] or RawValue
    end
    if RawValue == "." and self.Type.Default then
        RawValue = self.Type.Default(self.Executor) or ""
        self.RawSegmentsAreAutocomplete = true
    end
    if RawValue == "?" and self.Type.Autocomplete then
        local DefaultAutocomplete, DefaultAutocomplete_2
        DefaultAutocomplete, DefaultAutocomplete_2 = self:GetDefaultAutocomplete()
        if not DefaultAutocomplete_2.IsPartial and 0 < #DefaultAutocomplete then
            RawValue = DefaultAutocomplete[math.random(1, #DefaultAutocomplete)]
            self.RawSegmentsAreAutocomplete = true
        end
    end
    if not self.Type.Listable then
        v1 = unescapeOperators(RawValue)
        self.RawSegments[1] = unescapeOperators(v1)
        TransformedValues_2 = self.TransformedValues
        TransformedValues_2[1] = {self:TransformSegment(v1)}
        self.TextSegmentInProgress = self.RawValue
        return
    end
    local v4 = #self.RawValue
    if 0 >= v4 then
        v1 = unescapeOperators(RawValue)
        self.RawSegments[1] = unescapeOperators(v1)
        TransformedValues_2 = self.TransformedValues
        TransformedValues_2[1] = {self:TransformSegment(v1)}
        self.TextSegmentInProgress = self.RawValue
        return
    end
    v4 = RawValue:match("^%?(%d+)$")
    if v4 then
        v2 = tonumber(v4)
        if v2 and 0 < v2 then
            local DefaultAutocomplete_3, DefaultAutocomplete_4
            local v5 = {}
            DefaultAutocomplete_3, DefaultAutocomplete_4 = self:GetDefaultAutocomplete()
            if not DefaultAutocomplete_4.IsPartial and 0 < #DefaultAutocomplete_3 then
                v3 = math.min(v2, #DefaultAutocomplete_3)
                local v6 = 1
                for i2 = 1, v3, v6 do
                    table.insert(v5, table.remove(DefaultAutocomplete_3, math.random(1, #DefaultAutocomplete_3)))
                end
                RawValue = table.concat(v5, ",")
                self.RawSegmentsAreAutocomplete = true
            end
        end
    elseif RawValue == "*" then
        local DefaultAutocomplete_5, DefaultAutocomplete_6
        DefaultAutocomplete_5, DefaultAutocomplete_6 = self:GetDefaultAutocomplete()
        if not DefaultAutocomplete_6.IsPartial and 0 < #DefaultAutocomplete_5 then
            if RawValue == "**" and self.Type.Default then
                for i, v in ipairs(DefaultAutocomplete_5) do
                    if v == self.Type.Default(self.Executor) or "" then
                        table.remove(DefaultAutocomplete_5, i)
                    end
                end
            end
            RawValue = table.concat(DefaultAutocomplete_5, ",")
            self.RawSegmentsAreAutocomplete = true
        end
    elseif RawValue ~= "**" then
    end
    v1 = unescapeOperators(RawValue)
    v2 = u2.SplitStringSimple(v1, ",")
    if #v2 == 0 then
        v2 = {""}
    end
    local v7 = #v1
    v3 = #v1
    if v1:sub(v7, v3) == "," then
        v2[#v2 + 1] = ""
    end
    for i3, j in ipairs(v2) do
        self.RawSegments[i3] = j
        TransformedValues = self.TransformedValues
        TransformedValues[i3] = {self:TransformSegment(j)}
    end
    self.TextSegmentInProgress = v2[#v2]
end
function u4:TransformSegment(p2) -- Line: 159
    if self.Type.Transform then
        return self.Type.Transform(p2, self.Executor)
    end
    return p2
end
function u4:GetTransformedValue(p2) -- Line: 168
    return unpack(self.TransformedValues[p2])
end
function u4.Validate(p1, p2) -- Line: 173
    if p1.RawValue == nil then
        return true
    elseif #p1.RawValue ~= 0 then
        if not p1.Required then
            if p1.Type.Validate then
                local v1, v2
                local v3 = #p1.TransformedValues
                local v4 = 1
                local v5 = p1
                for i = 1, v3, v4 do
                    if v5.Type.Validate then
                        v1, v2 = v5.Type.Validate(v5:GetTransformedValue(i))
                        if not v1 then
                            return v1, v2 or "Invalid value"
                        end
                    end
                    if v6 and v5.Type.ValidateOnce then
                        v1, v2 = v5.Type.ValidateOnce(v5:GetTransformedValue(i))
                        if not v1 then
                            return v1, v2
                        end
                    end
                end
                return true
            elseif not p1.Type.ValidateOnce then
                return true
            end
        elseif p1.RawSegments[1] == nil then
            return false, "This argument is required."
        elseif #p1.RawSegments[1] == 0 then
            return false, "This argument is required."
        end
    elseif p1.Required == false then
        return true
    end
end
function u4.GetAutocomplete(p1) -- Line: 208
    if p1.Type.Autocomplete then
        return p1.Type.Autocomplete(p1:GetTransformedValue(#p1.TransformedValues))
    end
    return {}
end
function u4:ParseValue(p2) -- Line: 216
    if self.Type.Parse then
        return self.Type.Parse(self:GetTransformedValue(p2))
    end
    return self:GetTransformedValue(p2)
end
function u4.GetValue(p1) -- Line: 225
    if #p1.RawValue ~= 0 then
        local v1
        if not p1.Type.Listable then
            return p1:ParseValue(1)
        end
        local v2 = {}
        local v3 = #p1.TransformedValues
        local v4 = 1
        local v5 = p1
        for i = 1, v3, v4 do
            v1 = v5:ParseValue(i)
            if type(v1) ~= "table" then
                error(("Listable types must return a table from Parse (%s)"):format(v5.Type.Name))
            end
            for k, v in pairs(v1) do
                v2[v] = true
            end
        end
        v3 = {}
        for k2 in pairs(v2) do
            v3[#v3 + 1] = k2
        end
        return v3
    elseif not p1.Required and p1.Object.Default ~= nil then
        return p1.Object.Default
    end
end
return u4