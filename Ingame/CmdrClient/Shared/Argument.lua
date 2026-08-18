local v_u_1 = require("./Util")
local function v_u_4(p2) -- name: unescapeOperators
	for _, v3 in ipairs({
		"%.",
		"%?",
		"%*",
		"%*%*"
	}) do
		p2 = p2:gsub("\\" .. v3, v3:gsub("%%", ""))
	end
	return p2
end
local v_u_5 = {}
v_u_5.__index = v_u_5
function v_u_5.new(p6, p7, p8) -- name: new
	-- upvalues: (copy) v_u_1, (copy) v_u_5
	local v9 = {
		["Command"] = nil,
		["Type"] = nil,
		["Name"] = nil,
		["Object"] = nil,
		["Required"] = nil,
		["Executor"] = nil,
		["RawValue"] = nil,
		["RawSegments"] = nil,
		["TransformedValues"] = nil,
		["Prefix"] = "",
		["TextSegmentInProgress"] = "",
		["RawSegmentsAreAutocomplete"] = false,
		["Command"] = p6,
		["Name"] = p7.Name,
		["Object"] = p7
	}
	local v10
	if p7.Default == nil then
		v10 = p7.Optional ~= true
	else
		v10 = false
	end
	v9.Required = v10
	v9.Executor = p6.Executor
	v9.RawValue = p8
	v9.RawSegments = {}
	v9.TransformedValues = {}
	local v11 = p7.Type
	if type(v11) == "table" then
		v9.Type = p7.Type
	else
		local v12, v13, v14 = v_u_1.ParsePrefixedUnionType(p6.Cmdr.Registry:GetTypeName(p7.Type), p8)
		v9.Type = p6.Dispatcher.Registry:GetType(v12)
		v9.RawValue = v13
		v9.Prefix = v14
		if v9.Type == nil then
			error(string.format("%s has an unregistered type %q", v9.Name or "<none>", v12 or "<none>"))
		end
	end
	local v15 = v_u_5
	setmetatable(v9, v15)
	v9:Transform()
	return v9
end
function v_u_5.GetDefaultAutocomplete(p16) -- name: GetDefaultAutocomplete
	if not p16.Type.Autocomplete then
		return {}
	end
	local v17, v18 = p16.Type.Autocomplete(p16:TransformSegment(""))
	return v17, v18 or {}
end
function v_u_5.Transform(p19) -- name: Transform
	-- upvalues: (copy) v_u_4, (copy) v_u_1
	if #p19.TransformedValues == 0 then
		local v20 = p19.RawValue
		if p19.Type.ArgumentOperatorAliases then
			v20 = p19.Type.ArgumentOperatorAliases[v20] or v20
		end
		if v20 == "." and p19.Type.Default then
			v20 = p19.Type.Default(p19.Executor) or ""
			p19.RawSegmentsAreAutocomplete = true
		end
		if v20 == "?" and p19.Type.Autocomplete then
			local v21, v22 = p19:GetDefaultAutocomplete()
			if not v22.IsPartial and #v21 > 0 then
				v20 = v21[math.random(1, #v21)]
				p19.RawSegmentsAreAutocomplete = true
			end
		end
		if p19.Type.Listable and #p19.RawValue > 0 then
			local v23 = v20:match("^%?(%d+)$")
			if v23 then
				local v24 = tonumber(v23)
				if v24 and v24 > 0 then
					local v25 = {}
					local v26, v27 = p19:GetDefaultAutocomplete()
					if not v27.IsPartial and #v26 > 0 then
						local v28 = #v26
						for _ = 1, math.min(v24, v28) do
							local v29 = table.remove
							local v30 = math.random
							local v31 = #v26
							table.insert(v25, v29(v26, v30(1, v31)))
						end
						v20 = table.concat(v25, ",")
						p19.RawSegmentsAreAutocomplete = true
					end
				end
			elseif v20 == "*" or v20 == "**" then
				local v32, v33 = p19:GetDefaultAutocomplete()
				if not v33.IsPartial and #v32 > 0 then
					if v20 == "**" and p19.Type.Default then
						local v34 = p19.Type.Default(p19.Executor) or ""
						for v35, v36 in ipairs(v32) do
							if v36 == v34 then
								table.remove(v32, v35)
							end
						end
					end
					v20 = table.concat(v32, ",")
					p19.RawSegmentsAreAutocomplete = true
				end
			end
			local v37 = v_u_4(v20)
			local v38 = v_u_1.SplitStringSimple(v37, ",")
			local v39 = #v38 == 0 and { "" } or v38
			if v37:sub(#v37, #v37) == "," then
				v39[#v39 + 1] = ""
			end
			for v40, v41 in ipairs(v39) do
				p19.RawSegments[v40] = v41
				p19.TransformedValues[v40] = { p19:TransformSegment(v41) }
			end
			p19.TextSegmentInProgress = v39[#v39]
		else
			local v42 = v_u_4(v20)
			p19.RawSegments[1] = v_u_4(v42)
			p19.TransformedValues[1] = { p19:TransformSegment(v42) }
			p19.TextSegmentInProgress = p19.RawValue
		end
	else
		return
	end
end
function v_u_5.TransformSegment(p43, p44) -- name: TransformSegment
	if p43.Type.Transform then
		return p43.Type.Transform(p44, p43.Executor)
	else
		return p44
	end
end
function v_u_5.GetTransformedValue(p45, p46) -- name: GetTransformedValue
	local v47 = p45.TransformedValues[p46]
	return unpack(v47)
end
function v_u_5.Validate(p48, p49) -- name: Validate
	if p48.RawValue == nil or #p48.RawValue == 0 and p48.Required == false then
		return true
	end
	if p48.Required and (p48.RawSegments[1] == nil or #p48.RawSegments[1] == 0) then
		return false, "This argument is required."
	end
	if not (p48.Type.Validate or p48.Type.ValidateOnce) then
		return true
	end
	for v50 = 1, #p48.TransformedValues do
		if p48.Type.Validate then
			local v51, v52 = p48.Type.Validate(p48:GetTransformedValue(v50))
			if not v51 then
				return v51, v52 or "Invalid value"
			end
		end
		if p49 and p48.Type.ValidateOnce then
			local v53, v54 = p48.Type.ValidateOnce(p48:GetTransformedValue(v50))
			if not v53 then
				return v53, v54
			end
		end
	end
	return true
end
function v_u_5.GetAutocomplete(p55) -- name: GetAutocomplete
	return not p55.Type.Autocomplete and {} or p55.Type.Autocomplete(p55:GetTransformedValue(#p55.TransformedValues))
end
function v_u_5.ParseValue(p56, p57) -- name: ParseValue
	if p56.Type.Parse then
		return p56.Type.Parse(p56:GetTransformedValue(p57))
	else
		return p56:GetTransformedValue(p57)
	end
end
function v_u_5.GetValue(p58) -- name: GetValue
	if #p58.RawValue == 0 and (not p58.Required and p58.Object.Default ~= nil) then
		return p58.Object.Default
	end
	if not p58.Type.Listable then
		return p58:ParseValue(1)
	end
	local v59 = {}
	for v60 = 1, #p58.TransformedValues do
		local v61 = p58:ParseValue(v60)
		if type(v61) ~= "table" then
			error(("Listable types must return a table from Parse (%s)"):format(p58.Type.Name))
		end
		for _, v62 in pairs(v61) do
			v59[v62] = true
		end
	end
	local v63 = {}
	for v64 in pairs(v59) do
		v63[#v63 + 1] = v64
	end
	return v63
end
return v_u_5