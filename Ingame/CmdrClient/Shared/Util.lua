local v_u_1 = game:GetService("TextService")
local v_u_35 = {
	["MakeDictionary"] = function(p2) -- name: MakeDictionary
		local v3 = {}
		for v4 = 1, #p2 do
			v3[p2[v4]] = true
		end
		return v3
	end,
	["DictionaryKeys"] = function(p5) -- name: DictionaryKeys
		local v6 = {}
		for v7 in pairs(p5) do
			table.insert(v6, v7)
		end
		return v6
	end,
	["MakeFuzzyFinder"] = function(p8) -- name: MakeFuzzyFinder
		local v_u_9 = nil
		local v_u_10 = {}
		if typeof(p8) == "Enum" then
			p8 = p8:GetEnumItems()
		end
		if typeof(p8) == "Instance" then
			v_u_10 = p8:GetChildren()
			v_u_9 = {}
			for v11 = 1, #v_u_10 do
				v_u_9[v11] = v_u_10[v11].Name
			end
			::l8::
			return function(p12, p13)
				-- upvalues: (ref) v_u_9, (ref) v_u_10
				local v14 = {}
				for v15, v16 in pairs(v_u_9) do
					local v17
					if v_u_10 then
						v17 = v_u_10[v15] or v16
					else
						v17 = v16
					end
					if v16:lower() == p12:lower() then
						if p13 then
							return v17
						end
						table.insert(v14, 1, v17)
					elseif v16:lower():find(p12:lower(), 1, true) then
						v14[#v14 + 1] = v17
					end
				end
				if p13 then
					return v14[1]
				else
					return v14
				end
			end
		end
		if typeof(p8) ~= "table" then
			error("MakeFuzzyFinder only accepts a table, Enum, or Instance.")
			goto l8
		end
		local v18 = p8[1]
		if typeof(v18) ~= "Instance" then
			local v19 = p8[1]
			if typeof(v19) ~= "EnumItem" then
				local v20 = p8[1]
				if typeof(v20) ~= "table" then
					::l15::
					local v21 = p8[1]
					if type(v21) == "string" then
						v_u_9 = p8
					elseif p8[1] == nil then
						v_u_9 = {}
					else
						error("MakeFuzzyFinder only accepts tables of instances or strings.")
					end
					goto l8
				end
				local v22 = p8[1].Name
				if typeof(v22) ~= "string" then
					goto l15
				end
			end
		end
		v_u_9 = {}
		v_u_10 = p8
		for v23 = 1, #p8 do
			v_u_9[v23] = v_u_10[v23].Name
			p8 = v_u_10
			v_u_10 = p8
		end
		goto l8
	end,
	["GetNames"] = function(p24) -- name: GetNames
		local v25 = {}
		for v26 = 1, #p24 do
			local v27 = p24[v26].Name
			if not v27 then
				local v28 = p24[v26]
				v27 = tostring(v28)
			end
			v25[v26] = v27
		end
		return v25
	end,
	["SplitStringSimple"] = function(p29, p30) -- name: SplitStringSimple
		local v31 = p30 == nil and "%s" or p30
		local v32 = {}
		local v33 = 1
		for v34 in string.gmatch(p29, "([^" .. v31 .. "]+)") do
			v32[v33] = v34
			v33 = v33 + 1
		end
		return v32
	end
}
local function v_u_37(p36) -- name: charCode
	return utf8.char((tonumber(p36, 16)))
end
function v_u_35.ParseEscapeSequences(p38) -- name: ParseEscapeSequences
	-- upvalues: (copy) v_u_37
	return p38:gsub("\\(.)", {
		["t"] = "\t",
		["n"] = "\n"
	}):gsub("\\u(%x%x%x%x)", v_u_37):gsub("\\x(%x%x)", v_u_37)
end
function v_u_35.EncodeEscapedOperator(p39, p40) -- name: EncodeEscapedOperator
	local v41 = p40:sub(1, 1)
	local v42 = p40:gsub(".", "%%%1")
	return p39:gsub("(" .. ("%" .. v41) .. "+)(" .. v42 .. ")", function(p43, p44)
		return (p43:sub(1, #p43 - 1) .. p44):gsub(".", function(p45)
			return "\\u" .. string.format("%04x", string.byte(p45), 16)
		end)
	end)
end
local v_u_46 = { "&&", "||", ";" }
function v_u_35.EncodeEscapedOperators(p47) -- name: EncodeEscapedOperators
	-- upvalues: (copy) v_u_46, (copy) v_u_35
	for _, v48 in ipairs(v_u_46) do
		p47 = v_u_35.EncodeEscapedOperator(p47, v48)
	end
	return p47
end
function v_u_35.SplitString(p49, p50) -- name: SplitString
	-- upvalues: (copy) v_u_35
	local v51 = nil
	local v52 = nil
	local v53 = {}
	local v54 = p50 or (1 / 0)
	for v55 in p49:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___"):gmatch("[^ ]+") do
		local v56 = v_u_35.ParseEscapeSequences(v55)
		local v57 = v56:match("^([\'\"])")
		local v58 = v56:match("([\'\"])$")
		local v59 = v56:match("(\\*)[\'\"]$")
		if v57 and not (v51 or v58) then
			v51 = v57
			v52 = v56
		elseif v52 and (v58 == v51 and #v59 % 2 == 0) then
			v56 = v52 .. " " .. v56
			v52 = nil
			v51 = nil
		elseif v52 then
			v52 = v52 .. " " .. v56
		end
		if not v52 then
			v53[#v53 + (v54 < #v53 and 0 or 1)] = v56:gsub("^([\'\"])", ""):gsub("([\'\"])$", ""):gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
		end
	end
	if v52 then
		v53[#v53 + (v54 < #v53 and 0 or 1)] = v52:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
	end
	return v53
end
function v_u_35.MashExcessArguments(p60, p61) -- name: MashExcessArguments
	local v62 = {}
	for v63 = 1, #p60 do
		if p61 < v63 then
			v62[p61] = ("%s %s"):format(v62[p61] or "", p60[v63])
		else
			v62[v63] = p60[v63]
		end
	end
	return v62
end
function v_u_35.TrimString(p64) -- name: TrimString
	local _, v65 = string.find(p64, "^%s*")
	return v65 == #p64 and "" or string.match(p64, ".*%S", v65 + 1)
end
function v_u_35.GetTextSize(p66, p67, p68) -- name: GetTextSize
	-- upvalues: (copy) v_u_1
	return v_u_1:GetTextSize(p66, p67.TextSize, p67.Font, p68 or Vector2.new(p67.AbsoluteSize.X, 0))
end
function v_u_35.MakeEnumType(p_u_69, p70) -- name: MakeEnumType
	-- upvalues: (copy) v_u_35
	local v_u_71 = v_u_35.MakeFuzzyFinder(p70)
	return {
		["Validate"] = function(p72) -- name: Validate
			-- upvalues: (copy) v_u_71, (copy) p_u_69
			return v_u_71(p72, true) ~= nil, ("Value %q is not a valid %s."):format(p72, p_u_69)
		end,
		["Autocomplete"] = function(p73) -- name: Autocomplete
			-- upvalues: (copy) v_u_71, (ref) v_u_35
			local v74 = v_u_71(p73)
			local v75 = v74[1]
			if type(v75) ~= "string" then
				v74 = v_u_35.GetNames(v74) or v74
			end
			return v74
		end,
		["Parse"] = function(p76) -- name: Parse
			-- upvalues: (copy) v_u_71
			return v_u_71(p76, true)
		end
	}
end
function v_u_35.ParsePrefixedUnionType(p77, p78) -- name: ParsePrefixedUnionType
	-- upvalues: (copy) v_u_35
	local v79 = v_u_35.SplitStringSimple(p77)
	local v80 = {}
	for v81 = 1, #v79, 2 do
		v80[#v80 + 1] = {
			["prefix"] = v79[v81 - 1] or "",
			["type"] = v79[v81]
		}
	end
	table.sort(v80, function(p82, p83)
		return #p82.prefix > #p83.prefix
	end)
	for v84 = 1, #v80 do
		local v85 = v80[v84]
		if p78:sub(1, #v85.prefix) == v85.prefix then
			return v85.type, p78:sub(#v85.prefix + 1), v85.prefix
		end
	end
end
function v_u_35.MakeListableType(p_u_86, p87) -- name: MakeListableType
	local v88 = {
		["Listable"] = true,
		["Transform"] = nil,
		["Validate"] = nil,
		["ValidateOnce"] = nil,
		["Autocomplete"] = nil,
		["Default"] = nil,
		["ArgumentOperatorAliases"] = nil,
		["Parse"] = nil,
		["Transform"] = p_u_86.Transform,
		["Validate"] = p_u_86.Validate,
		["ValidateOnce"] = p_u_86.ValidateOnce,
		["Autocomplete"] = p_u_86.Autocomplete,
		["Default"] = p_u_86.Default,
		["ArgumentOperatorAliases"] = p_u_86.ArgumentOperatorAliases,
		["Parse"] = function(...) -- name: Parse
			-- upvalues: (copy) p_u_86
			return { p_u_86.Parse(...) }
		end
	}
	if p87 then
		for v89, v90 in pairs(p87) do
			v88[v89] = v90
		end
	end
	return v88
end
function v_u_35.RunCommandString(p91, p92) -- name: RunCommandString
	-- upvalues: (copy) v_u_35
	local v93 = v_u_35.ParseEscapeSequences(p92)
	local v94 = v_u_35.EncodeEscapedOperators(v93):split("&&")
	local v95 = ""
	for v96, v97 in ipairs(v94) do
		local v98 = v95:gsub("%$", "\\x24"):gsub("%%", "%%%%")
		local v99 = "||"
		if v95:find("%s") then
			v98 = ("%q"):format(v98) or v98
		end
		local v100 = v97:gsub(v99, v98)
		local v101 = v_u_35.RunEmbeddedCommands(p91, v100)
		v95 = tostring(p91:EvaluateAndRun(v101))
		if v96 == #v94 then
			return v95
		end
	end
end
function v_u_35.RunEmbeddedCommands(p102, p103) -- name: RunEmbeddedCommands
	-- upvalues: (copy) v_u_35
	local v104 = p103:gsub("\\%$", "___!CMDR_DOLLAR!___")
	local v105 = {}
	for v106 in v104:gmatch("$(%b{})") do
		local v107 = v106:sub(2, #v106 - 1)
		local v108
		if v107:match("^{.+}$") then
			v107 = v107:sub(2, #v107 - 1)
			v108 = false
		else
			v108 = true
		end
		v105[v106] = v_u_35.RunCommandString(p102, v107)
		if v108 and (v105[v106]:find("%s") or v105[v106] == "") then
			v105[v106] = string.format("%q", v105[v106])
		end
	end
	return v104:gsub("$(%b{})", v105):gsub("___!CMDR_DOLLAR!___", "$")
end
function v_u_35.SubstituteArgs(p109, p110) -- name: SubstituteArgs
	local v111 = p109:gsub("\\%$", "___!CMDR_DOLLAR!___")
	if type(p110) == "table" then
		for v112 = 1, #p110 do
			local v113 = tostring(v112)
			p110[v113] = p110[v112]
			if p110[v113]:find("%s") then
				p110[v113] = string.format("%q", p110[v113])
			end
		end
	end
	return v111:gsub("($%d+)%b{}", "%1"):gsub("$(%w+)", p110):gsub("___!CMDR_DOLLAR!___", "$")
end
function v_u_35.MakeAliasCommand(p114, p115) -- name: MakeAliasCommand
	-- upvalues: (copy) v_u_35
	local v116, v117 = unpack(p114:split("|"))
	local v_u_118 = v_u_35.EncodeEscapedOperators(p115)
	local v119 = {}
	local v120 = {}
	for v121 in v_u_118:gmatch("$(%d+)") do
		if v119[v121] == nil then
			v119[v121] = true
			local v122 = v_u_118:match((("$%*(%%b{})"):format(v121)))
			local v123, v124, v125
			if v122 then
				local v126 = v122:sub(2, #v122 - 1)
				v123, v124, v125 = unpack(v126:split("|"))
			else
				v123 = nil
				v124 = nil
				v125 = nil
			end
			local v127
			if v123 then
				v127 = v123:match("%?$") and true or false
			else
				v127 = v123
			end
			local v128 = not v123 and "string" or v123:match("^%w+")
			local v129 = v124 or ("Argument %*"):format(v121)
			table.insert(v120, {
				["Type"] = v128,
				["Name"] = v129,
				["Description"] = v125 or "",
				["Optional"] = v127
			})
		end
	end
	return {
		["Name"] = nil,
		["Aliases"] = nil,
		["Description"] = nil,
		["Group"] = "UserAlias",
		["Args"] = nil,
		["Run"] = nil,
		["Name"] = v116,
		["Aliases"] = {},
		["Description"] = ("<Alias> %*"):format(v117 or v_u_118),
		["Args"] = v120,
		["Run"] = function(p130) -- name: Run
			-- upvalues: (ref) v_u_35, (ref) v_u_118
			return v_u_35.RunCommandString(p130.Dispatcher, v_u_35.SubstituteArgs(v_u_118, p130.RawArguments))
		end
	}
end
function v_u_35.MakeSequenceType(p131) -- name: MakeSequenceType
	-- upvalues: (copy) v_u_35
	local v_u_132 = p131 or {}
	local v133 = v_u_132.Parse ~= nil and true or v_u_132.Constructor ~= nil
	assert(v133, "MakeSequenceType: Must provide one of: Constructor, Parse")
	v_u_132.TransformEach = v_u_132.TransformEach or function(...)
		return ...
	end
	v_u_132.ValidateEach = v_u_132.ValidateEach or function()
		return true
	end
	return {
		["Prefixes"] = v_u_132.Prefixes,
		["Transform"] = function(p134) -- name: Transform
			-- upvalues: (ref) v_u_35, (ref) v_u_132
			return v_u_35.Map(v_u_35.SplitPrioritizedDelimeter(p134, { ",", "%s" }), function(p135)
				-- upvalues: (ref) v_u_132
				return v_u_132.TransformEach(p135)
			end)
		end,
		["Validate"] = function(p136) -- name: Validate
			-- upvalues: (ref) v_u_132
			if v_u_132.Length and #p136 > v_u_132.Length then
				return false, ("Maximum of %d values allowed in sequence"):format(v_u_132.Length)
			end
			for v137 = 1, v_u_132.Length or #p136 do
				local v138, v139 = v_u_132.ValidateEach(p136[v137], v137)
				if not v138 then
					return false, v139
				end
			end
			return true
		end,
		["Parse"] = v_u_132.Parse or function(p140)
			-- upvalues: (ref) v_u_132
			return v_u_132.Constructor(unpack(p140))
		end
	}
end
function v_u_35.SplitPrioritizedDelimeter(p141, p142) -- name: SplitPrioritizedDelimeter
	-- upvalues: (copy) v_u_35
	for v143, v144 in ipairs(p142) do
		if p141:find(v144) or v143 == #p142 then
			return v_u_35.SplitStringSimple(p141, v144)
		end
	end
end
function v_u_35.Map(p145, p146) -- name: Map
	local v147 = {}
	for v148, v149 in ipairs(p145) do
		v147[v148] = p146(v149, v148)
	end
	return v147
end
function v_u_35.Each(p150, ...) -- name: Each
	local v151 = {}
	for v152, v153 in ipairs({ ... }) do
		v151[v152] = p150(v153)
	end
	return unpack(v151)
end
function v_u_35.EmulateTabstops(p154, p155) -- name: EmulateTabstops
	local v156 = #p154
	local v157 = table.create(v156)
	local v158 = 0
	for v159 = 1, v156 do
		local v160 = string.sub(p154, v159, v159)
		if v160 == "\t" then
			local v161 = p155 - v158 % p155
			local v162 = string.rep
			table.insert(v157, v162(" ", v161))
			v158 = v158 + v161
		else
			table.insert(v157, v160)
			if v160 == "\n" then
				v158 = 0
			elseif v160 ~= "\r" then
				v158 = v158 + 1
			end
		end
	end
	return table.concat(v157)
end
function v_u_35.Mutex() -- name: Mutex
	local v_u_163 = {}
	local v_u_164 = false
	return function()
		-- upvalues: (ref) v_u_164, (copy) v_u_163
		if v_u_164 then
			local v165 = v_u_163
			local v166 = coroutine.running
			table.insert(v165, v166())
			coroutine.yield()
		else
			v_u_164 = true
		end
		return function()
			-- upvalues: (ref) v_u_163, (ref) v_u_164
			if #v_u_163 > 0 then
				coroutine.resume(table.remove(v_u_163, 1))
			else
				v_u_164 = false
			end
		end
	end
end
return v_u_35