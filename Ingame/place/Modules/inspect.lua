local v1 = nil
local v2 = _VERSION or ""
local v3
if (tonumber(v2:match("[%d.]*$")) or 0) < 5.3 then
	local v4
	v4, v3 = pcall(require, "compat53.module")
	if not v4 then
		v3 = v1
	end
else
	v3 = v1
end
local v_u_5 = v3 and v3.math or math
local v6 = v3 and v3.string or string
local v_u_7 = v3 and v3.table or table
local v_u_8 = {
	["Options"] = {},
	["_VERSION"] = "inspect.lua 3.1.0",
	["_URL"] = "http://github.com/kikito/inspect.lua",
	["_DESCRIPTION"] = "human-readable representations of tables",
	["_LICENSE"] = "  MIT LICENSE\n\n  Copyright (c) 2022 Enrique Garc\195\173a Cota\n\n  Permission is hereby granted, free of charge, to any person obtaining a\n  copy of this software and associated documentation files (the\n  \"Software\"), to deal in the Software without restriction, including\n  without limitation the rights to use, copy, modify, merge, publish,\n  distribute, sublicense, and/or sell copies of the Software, and to\n  permit persons to whom the Software is furnished to do so, subject to\n  the following conditions:\n\n  The above copyright notice and this permission notice shall be included\n  in all copies or substantial portions of the Software.\n\n  THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n",
	["KEY"] = setmetatable({}, {
		["__tostring"] = function() -- name: __tostring
			return "inspect.KEY"
		end
	}),
	["METATABLE"] = setmetatable({}, {
		["__tostring"] = function() -- name: __tostring
			return "inspect.METATABLE"
		end
	})
}
local v_u_9 = tostring
local v_u_10 = v6.rep
local v_u_11 = v6.match
local v12 = v6.char
local v_u_13 = v6.gsub
local v_u_14 = v6.format
local v_u_17 = not rawget and function(p15, p16)
	return p15[p16]
end or rawget
local v_u_18 = {
	["\7"] = "\\a",
	["\8"] = "\\b",
	["\f"] = "\\f",
	["\n"] = "\\n",
	["\r"] = "\\r",
	["\t"] = "\\t",
	["\11"] = "\\v",
	["\127"] = "\\127"
}
local v_u_19 = {
	["\127"] = "\127"
}
for v20 = 0, 31 do
	local v21 = v12(v20)
	if not v_u_18[v21] then
		v_u_18[v21] = "\\" .. v20
		v_u_19[v21] = v_u_14("\\%03d", v20)
	end
end
local v_u_22 = {
	["and"] = true,
	["break"] = true,
	["do"] = true,
	["else"] = true,
	["elseif"] = true,
	["end"] = true,
	["false"] = true,
	["for"] = true,
	["function"] = true,
	["goto"] = true,
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
	["while"] = true
}
local v_u_23 = v_u_5.floor
local v_u_24 = {
	["number"] = 1,
	["boolean"] = 2,
	["string"] = 3,
	["table"] = 4,
	["function"] = 5,
	["userdata"] = 6,
	["thread"] = 7
}
local function v_u_31(p25, p26) -- name: sortKeys
	-- upvalues: (copy) v_u_24
	local v27 = type(p25)
	local v28 = type(p26)
	if v27 == v28 and (v27 == "string" or v27 == "number") then
		return p25 < p26
	end
	local v29 = v_u_24[v27] or 100
	local v30 = v_u_24[v28] or 100
	return v29 == v30 and v27 < v28 and true or v29 < v30
end
local function v_u_39(p32) -- name: getKeys
	-- upvalues: (ref) v_u_17, (copy) v_u_23, (copy) v_u_7, (copy) v_u_31
	local v33 = 1
	while v_u_17(p32, v33) ~= nil do
		v33 = v33 + 1
	end
	local v34 = v33 - 1
	local v35 = 0
	local v36 = {}
	for v37 in next, p32 do
		local v38
		if type(v37) == "number" and (v_u_23(v37) == v37 and v37 >= 1) then
			v38 = v37 <= v34
		else
			v38 = false
		end
		if not v38 then
			v35 = v35 + 1
			v36[v35] = v37
		end
	end
	v_u_7.sort(v36, v_u_31)
	return v36, v35, v34
end
local function v_u_44(p40, p41) -- name: countCycles
	-- upvalues: (copy) v_u_44
	if type(p40) == "table" then
		if p41[p40] then
			p41[p40] = p41[p40] + 1
			return
		end
		p41[p40] = 1
		for v42, v43 in next, p40 do
			v_u_44(v42, p41)
			v_u_44(v43, p41)
		end
		v_u_44(getmetatable(p40), p41)
	end
end
local function v_u_74(p45, p46, p47, p48) -- name: processRecursive
	-- upvalues: (copy) v_u_74, (copy) v_u_8
	if p46 == nil then
		return nil
	end
	if p48[p46] then
		return p48[p46]
	end
	local v49 = p45(p46, p47)
	local v50
	if type(v49) == "table" then
		v50 = {}
		p48[p46] = v50
		for v51, v52 in next, v49 do
			local v53 = v_u_74
			local v54 = v_u_8.KEY
			local v55 = #p47
			local v56 = p45
			local v57 = v51
			local v58 = {}
			for v59 = 1, v55 do
				v58[v59] = p47[v59]
			end
			v58[v55 + 1] = v51
			v58[v55 + 2] = v54
			local v60 = v53(p45, v57, v58, p48)
			if v60 == nil then
				p45 = v56
			else
				local v61 = v_u_74
				local v62 = #p47
				local v63 = v56
				local v64 = v60
				local v65 = {}
				for v66 = 1, v62 do
					v65[v66] = p47[v66]
				end
				v65[v62 + 1] = v64
				v65[v62 + 2] = nil
				v50[v60] = v61(v63, v52, v65, p48)
				p45 = v56
			end
		end
		local v67 = v_u_74
		local v68 = getmetatable(v49)
		local v69 = v_u_8.METATABLE
		local v70 = #p47
		local v71 = {}
		for v72 = 1, v70 do
			v71[v72] = p47[v72]
		end
		v71[v70 + 1] = v69
		v71[v70 + 2] = nil
		local v73 = v67(p45, v68, v71, p48)
		if type(v73) ~= "table" then
			v73 = nil
		end
		setmetatable(v50, v73)
	else
		v50 = v49
	end
	return v50
end
local v75 = {}
local v_u_76 = {
	["__index"] = v75
}
function v75.getId(p77, p78) -- name: getId
	-- upvalues: (copy) v_u_9
	local v79 = p77.ids[p78]
	local v80 = p77.ids
	if not v79 then
		local v81 = type(p78)
		v79 = (v80[v81] or 0) + 1
		v80[p78] = v79
		v80[v81] = v79
	end
	return v_u_9(v79)
end
function v75.putValue(p82, p83) -- name: putValue
	-- upvalues: (copy) v_u_13, (copy) v_u_19, (copy) v_u_18, (copy) v_u_11, (copy) v_u_9, (copy) v_u_8, (copy) v_u_14, (copy) v_u_39, (copy) v_u_10, (copy) v_u_22
	local v84 = p82.buf
	local v85 = type(p83)
	if v85 == "string" then
		local v86 = v_u_13(v_u_13(v_u_13(p83, "\\", "\\\\"), "(%c)%f[0-9]", v_u_19), "%c", v_u_18)
		local v87
		if v_u_11(v86, "\"") and not v_u_11(v86, "\'") then
			v87 = "\'" .. v86 .. "\'"
		else
			v87 = "\"" .. v_u_13(v86, "\"", "\\\"") .. "\""
		end
		v84.n = v84.n + 1
		v84[v84.n] = v87
		return
	elseif v85 == "number" or (v85 == "boolean" or (v85 == "nil" or (v85 == "cdata" or v85 == "ctype"))) then
		local v88 = v_u_9(p83)
		v84.n = v84.n + 1
		v84[v84.n] = v88
		return
	elseif v85 == "table" and not p82.ids[p83] then
		if p83 == v_u_8.KEY or p83 == v_u_8.METATABLE then
			local v89 = v_u_9(p83)
			v84.n = v84.n + 1
			v84[v84.n] = v89
			return
		elseif p82.level >= p82.depth then
			v84.n = v84.n + 1
			v84[v84.n] = "{...}"
		else
			if p82.cycles[p83] > 1 then
				local v90 = v_u_14("<%d>", p82:getId(p83))
				v84.n = v84.n + 1
				v84[v84.n] = v90
			end
			local v91, v92, v93 = v_u_39(p83)
			v84.n = v84.n + 1
			v84[v84.n] = "{"
			p82.level = p82.level + 1
			for v94 = 1, v93 + v92 do
				if v94 > 1 then
					v84.n = v84.n + 1
					v84[v84.n] = ","
				end
				if v94 <= v93 then
					v84.n = v84.n + 1
					v84[v84.n] = " "
					p82:putValue(p83[v94])
				else
					local v95 = v91[v94 - v93]
					local v96 = p82.buf
					local v97 = p82.newline .. v_u_10(p82.indent, p82.level)
					v96.n = v96.n + 1
					v96[v96.n] = v97
					local v98 = type(v95) == "string" and (v95:match("^[_%a][_%a%d]*$") and true or false)
					if v98 then
						v98 = not v_u_22[v95]
					end
					if v98 then
						v84.n = v84.n + 1
						v84[v84.n] = v95
					else
						v84.n = v84.n + 1
						v84[v84.n] = "["
						p82:putValue(v95)
						v84.n = v84.n + 1
						v84[v84.n] = "]"
					end
					v84.n = v84.n + 1
					v84[v84.n] = " = "
					p82:putValue(p83[v95])
				end
			end
			local v99 = getmetatable(p83)
			if type(v99) == "table" then
				if v93 + v92 > 0 then
					v84.n = v84.n + 1
					v84[v84.n] = ","
				end
				local v100 = p82.buf
				local v101 = p82.newline .. v_u_10(p82.indent, p82.level)
				v100.n = v100.n + 1
				v100[v100.n] = v101
				v84.n = v84.n + 1
				v84[v84.n] = "<metatable> = "
				p82:putValue(v99)
			end
			p82.level = p82.level - 1
			if v92 > 0 or type(v99) == "table" then
				local v102 = p82.buf
				local v103 = p82.newline .. v_u_10(p82.indent, p82.level)
				v102.n = v102.n + 1
				v102[v102.n] = v103
			elseif v93 > 0 then
				v84.n = v84.n + 1
				v84[v84.n] = " "
			end
			v84.n = v84.n + 1
			v84[v84.n] = "}"
		end
	else
		local v104 = v_u_14("<%s %d>", v85, p82:getId(p83))
		v84.n = v84.n + 1
		v84[v84.n] = v104
		return
	end
end
function v_u_8.inspect(p105, p106) -- name: inspect
	-- upvalues: (copy) v_u_5, (copy) v_u_74, (copy) v_u_44, (copy) v_u_76, (copy) v_u_7
	local v107 = p106 or {}
	local v108 = v107.depth or v_u_5.huge
	local v109 = v107.newline or "\n"
	local v110 = v107.indent or "  "
	local v111 = v107.process
	if v111 then
		p105 = v_u_74(v111, p105, {}, {})
	end
	local v112 = {}
	v_u_44(p105, v112)
	local v113 = v_u_76
	local v114 = setmetatable({
		["buf"] = nil,
		["ids"] = nil,
		["cycles"] = nil,
		["depth"] = nil,
		["level"] = 0,
		["newline"] = nil,
		["indent"] = nil,
		["buf"] = {
			["n"] = 0
		},
		["ids"] = {},
		["cycles"] = v112,
		["depth"] = v108,
		["newline"] = v109,
		["indent"] = v110
	}, v113)
	v114:putValue(p105)
	return v_u_7.concat(v114.buf)
end
setmetatable(v_u_8, {
	["__call"] = function(_, p115, p116) -- name: __call
		-- upvalues: (copy) v_u_8
		return v_u_8.inspect(p115, p116)
	end
})
return v_u_8