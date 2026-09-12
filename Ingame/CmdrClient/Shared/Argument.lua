local u2 = require("./Util")

local function unescapeOperators(p1) -- Line: 3
    local v1, v2
    local v3 = ipairs
    local v4 = {"%.", "%?", "%*", "%*%*"}
    local v5 = p1
    for i, v in v3(v4) do
        v1 = "\\" .. v
        v2 = v:gsub("%%", "")
        v5 = v5:gsub(v1, v2)
    end
    return v5
end

local u4 = {}
u4.__index = u4

function u4.new(p1, p2, p3) -- Line: 15 -- upvalues: u2 (val), u4 (val)
    local v1
    local v2 = {
        Prefix = "",
        TextSegmentInProgress = "",
        RawSegmentsAreAutocomplete = false,
        Command = p1,
        Name = p2.Name,
        Object = p2,
    }
    local v3 = false
    if p2.Default == nil then
        v3 = p2.Optional ~= true
    end
    v2.Required = v3
    v2.Executor = p1.Executor
    v2.RawValue = p3
    v2.RawSegments = {}
    v3 = {}
    v2.TransformedValues = v3
    local Type = p2.Type
    if type(Type) ~= "table" then
        local v4
        v3 = u2
        local ParsePrefixedUnionType = v3.ParsePrefixedUnionType
        local Registry = p1.Cmdr.Registry
        local Type_2 = p2.Type
        v3, v4, v1 = ParsePrefixedUnionType(Registry:GetTypeName(Type_2), p3)
        v2.Type = p1.Dispatcher.Registry:GetType(v3)
        v2.RawValue = v4
        v2.Prefix = v1
        if v2.Type == nil then
            error(string.format("%s has an unregistered type %q", v2.Name or "<none>", v3 or "<none>"))
        end
    else
        v2.Type = p2.Type
    end
    v1 = u4
    setmetatable(v2, v1)
    v2:Transform()
    return v2
end

function u4:GetDefaultAutocomplete() -- Line: 55
    if not self.Type.Autocomplete then
        return {}
    end
    local v1, v2 = self.Type.Autocomplete(self:TransformSegment(""))
    local v3 = v2 or {}
    return v1, v3
end

function u4:Transform() -- Line: 67 -- upvalues: unescapeOperators (val), u2 (val)
    local v1
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
        local DefaultAutocomplete, DefaultAutocomplete_2 = self:GetDefaultAutocomplete()
        if not DefaultAutocomplete_2.IsPartial and 0 < #DefaultAutocomplete then
            RawValue = DefaultAutocomplete[math.random(1, #DefaultAutocomplete)]
            self.RawSegmentsAreAutocomplete = true
        end
    end
    if self.Type.Listable then
        local v2 = #self.RawValue
        if 0 < v2 then
            local TransformedValues, v3, v4, v5, v6
            v2 = RawValue:match("^%?(%d+)$")
            if v2 then
                v4 = tonumber(v2)
                if v4 and 0 < v4 then
                    v5 = {}
                    local DefaultAutocomplete_3, DefaultAutocomplete_4 = self:GetDefaultAutocomplete()
                    if not DefaultAutocomplete_4.IsPartial and 0 < #DefaultAutocomplete_3 then
                        local remove, v7
                        local v8 = #DefaultAutocomplete_3
                        v6 = math.min(v4, v8)
                        for j = 1, v6 do
                            remove = table.remove
                            v7 = math.random(1, #DefaultAutocomplete_3)
                            v8 = remove(DefaultAutocomplete_3, v7)
                            table.insert(v5, v8)
                        end
                        RawValue = table.concat(v5, ",")
                        self.RawSegmentsAreAutocomplete = true
                    end
                end
            else
                local DefaultAutocomplete_5, DefaultAutocomplete_6, v9
                if RawValue == "*" then
                    DefaultAutocomplete_5, DefaultAutocomplete_6 = self:GetDefaultAutocomplete()
                    if not DefaultAutocomplete_6.IsPartial and 0 < #DefaultAutocomplete_5 then
                        if RawValue == "**" and self.Type.Default then
                            v9 = self.Type.Default(self.Executor) or ""
                            for i, v in ipairs(DefaultAutocomplete_5) do
                                if v == v9 then
                                    table.remove(DefaultAutocomplete_5, i)
                                end
                            end
                        end
                        RawValue = table.concat(DefaultAutocomplete_5, ",")
                        self.RawSegmentsAreAutocomplete = true
                    end
                elseif RawValue == "**" then
                    DefaultAutocomplete_5, DefaultAutocomplete_6 = self:GetDefaultAutocomplete()
                    if not DefaultAutocomplete_6.IsPartial and 0 < #DefaultAutocomplete_5 then
                        if RawValue == "**" and self.Type.Default then
                            v9 = self.Type.Default(self.Executor) or ""
                            for i2, i3 in ipairs(DefaultAutocomplete_5) do
                                if i3 == v9 then
                                    table.remove(DefaultAutocomplete_5, i2)
                                end
                            end
                        end
                        RawValue = table.concat(DefaultAutocomplete_5, ",")
                        self.RawSegmentsAreAutocomplete = true
                    end
                end
            end
            v1 = unescapeOperators(RawValue)
            v4 = u2.SplitStringSimple(v1, ",")
            if #v4 == 0 then
                v4 = {""}
            end
            local v10 = #v1
            v6 = #v1
            if v1:sub(v10, v6) == "," then
                v5 = #v4 + 1
                v4[v5] = ""
            end
            for i4, k in ipairs(v4) do
                self.RawSegments[i4] = k
                TransformedValues = self.TransformedValues
                v3 = {self:TransformSegment(k)}
                TransformedValues[i4] = v3
            end
            self.TextSegmentInProgress = v4[#v4]
            return
        end
    end
    v1 = unescapeOperators(RawValue)
    self.RawSegments[1] = (unescapeOperators(v1))
    local TransformedValues_2 = self.TransformedValues
    TransformedValues_2[1] = {self:TransformSegment(v1)}
    self.TextSegmentInProgress = self.RawValue
end

function u4:TransformSegment(p2) -- Line: 159
    if self.Type.Transform then
        return self.Type.Transform(p2, self.Executor)
    end
    return p2
end

function u4:GetTransformedValue(p2) -- Line: 168
    local v1 = self.TransformedValues[p2]
    return unpack(v1)
end

function u4.Validate(p1, p2) -- Line: 173
    local v1, v2, v3, v4
    if p1.RawValue == nil then
        return true
    end
    if #p1.RawValue == 0 and p1.Required == false then
        return true
    end
    if not p1.Required then
        if not p1.Type.Validate and not p1.Type.ValidateOnce then
            return true
        end
        v2 = #p1.TransformedValues
        v1 = p1
        for j = 1, v2 do
            if v1.Type.Validate then
                v3, v4 = v1.Type.Validate(v1:GetTransformedValue(j))
                if not v3 then
                    return v3, v4 or "Invalid value"
                end
            end
            if v5 and v1.Type.ValidateOnce then
                v3, v4 = v1.Type.ValidateOnce(v1:GetTransformedValue(j))
                if not v3 then
                    return v3, v4
                end
            end
        end
        return true
    end
    if p1.RawSegments[1] ~= nil and #p1.RawSegments[1] ~= 0 then
        if not p1.Type.Validate and not p1.Type.ValidateOnce then
            return true
        end
        v2 = #p1.TransformedValues
        v1 = p1
        for i = 1, v2 do
            if v1.Type.Validate then
                v3, v4 = v1.Type.Validate(v1:GetTransformedValue(i))
                if not v3 then
                    return v3, v4 or "Invalid value"
                end
            end
            if v5 and v1.Type.ValidateOnce then
                v3, v4 = v1.Type.ValidateOnce(v1:GetTransformedValue(i))
                if not v3 then
                    return v3, v4
                end
            end
        end
        return true
    end
    return false, "This argument is required."
end

function u4.GetAutocomplete(p1) -- Line: 208
    if not p1.Type.Autocomplete then
        return {}
    end
    local Autocomplete = p1.Type.Autocomplete
    local v1 = #p1.TransformedValues
    return Autocomplete(p1:GetTransformedValue(v1))
end

function u4:ParseValue(p2) -- Line: 216
    if self.Type.Parse then
        return self.Type.Parse(self:GetTransformedValue(p2))
    end
    return self:GetTransformedValue(p2)
end

function u4.GetValue(p1) -- Line: 225
    local Name, v1, v2
    if #p1.RawValue == 0 and not p1.Required and p1.Object.Default ~= nil then
        return p1.Object.Default
    end
    if not p1.Type.Listable then
        return p1:ParseValue(1)
    end
    local v3 = {}
    local v4 = #p1.TransformedValues
    local v5 = p1
    for i = 1, v4 do
        v1 = v5:ParseValue(i)
        if type(v1) ~= "table" then
            v2 = error
            Name = v5.Type.Name
            v2(("Listable types must return a table from Parse (%s)"):format(Name))
        end
        for k, v in pairs(v1) do
            v3[v] = true
        end
    end
    v4 = {}
    for k2 in pairs(v3) do
        v4[#v4 + 1] = k2
    end
    return v4
end

return u4