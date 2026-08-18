local v1 = {}
local v2 = {
	["Bold"] = 0,
	["Italic"] = 1,
	["ItalicBold"] = 2,
	["Strike"] = 3,
	["Code"] = 4,
	["Red"] = 5
}
local function v_u_4(p3) -- name: sanitize
	return string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(p3, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"), "\"", "&quot;"), "\'", "&apos;")
end
local v_u_5 = {
	["`"] = v2.Code,
	["~"] = v2.Strike,
	["~~"] = v2.Strike,
	["*"] = v2.Italic,
	["_"] = v2.Italic,
	["**"] = v2.Bold,
	["__"] = v2.Bold,
	["___"] = v2.ItalicBold,
	["***"] = v2.ItalicBold,
	["||"] = v2.Red
}
local v_u_6 = {
	[v2.Bold] = { "<font color=\"#e3df6d\"><b>", "</b></font>" },
	[v2.Italic] = { "<font color=\"#b0ffdb\"><i>", "</i></font>" },
	[v2.ItalicBold] = { "<font color=\"#e3df6d\"><b><i>", "</i></b></font>" },
	[v2.Strike] = { "<s>", "</s>" },
	[v2.Code] = { "<font face=\"RobotoMono\">", "</font>" },
	[v2.Red] = { "<font color=\"#fa7878\"><b>", "</b></font>" }
}
local function v_u_19(p7) -- name: richText
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_6
	local v8 = v_u_4(p7)
	local v9 = 0
	local v10 = 0
	local v11 = {}
	while true do
		local v12, v13 = string.match(v8, "([%*_~`|]+)(%S[^\n]-)%1", v9)
		if not v12 then
			break
		end
		local v14, v15 = string.find(v8, v12 .. v13 .. v12, v9, true)
		local v16 = v_u_6[v_u_5[v12]]
		local v17 = v10 + 1
		local v18 = v14 - 1
		v11[v17] = string.sub(v8, v9, v18)
		v9 = v15 + 1
		if v16 then
			v10 = v17 + 1
			v11[v10] = v16[1] .. v13 .. v16[2]
		else
			v10 = v17 + 1
			v11[v10] = v13
		end
	end
	v11[v10 + 1] = string.sub(v8, v9)
	return table.concat(v11)
end
local v_u_20 = {
	["None"] = 0,
	["Paragraph"] = 1,
	["Heading"] = 2,
	["Code"] = 3,
	["List"] = 4,
	["Ruler"] = 5,
	["Quote"] = 6,
	["Image"] = 7
}
local v_u_21 = {
	[v_u_20.None] = true,
	[v_u_20.Paragraph] = true,
	[v_u_20.Code] = true,
	[v_u_20.List] = true,
	[v_u_20.Quote] = true
}
local function v_u_71(p22, p_u_23) -- name: blocks
	-- upvalues: (copy) v_u_20, (copy) v_u_21, (copy) v_u_71
	local v_u_24 = v_u_20.None
	local v_u_25 = string.split(p22, "\n")
	local v_u_26 = 0
	local function v_u_28() -- name: it
		-- upvalues: (ref) v_u_26, (copy) v_u_25, (ref) v_u_24, (ref) v_u_20
		v_u_26 = v_u_26 + 1
		local v27 = v_u_25[v_u_26]
		if v27 then
			if v_u_24 == v_u_20.Code then
				if string.match(v27, "^```") then
					v_u_24 = v_u_20.None
				end
				return v_u_20.Code, v27
			elseif string.match(v27, "^%s*$") then
				return v_u_20.None, ""
			elseif string.match(v27, "^%-%-%-+") or string.match(v27, "^===+") then
				return v_u_20.Ruler, ""
			elseif string.match(v27, "^%s*!%[%w-|?[%dx]*,? ?%d*%%?%]%(.-%)") then
				return v_u_20.Image, v27
			elseif string.match(v27, "^#") then
				return v_u_20.Heading, v27
			elseif string.match(v27, "^%s*```") then
				v_u_24 = v_u_20.Code
				return v_u_24, v27
			elseif string.match(v27, "^%s*>") then
				return v_u_20.Quote, v27
			elseif string.match(v27, "^%s*%-%s+") or (string.match(v27, "^%s*%*%s+") or (string.match(v27, "^%s*[%u%d]+%.%s+") or string.match(v27, "^%s*%+%s+"))) then
				return v_u_20.List, v27
			else
				return v_u_20.Paragraph, v27
			end
		else
			return
		end
	end
	local v_u_29, v_u_30 = v_u_28()
	local function v_u_40()
		-- upvalues: (copy) v_u_28, (ref) v_u_20, (ref) v_u_29, (ref) v_u_30, (ref) v_u_21
		local v31, v32 = v_u_28()
		if v31 == v_u_20.Ruler and v_u_29 == v_u_20.Paragraph then
			local v33 = v_u_30
			local v34, v35 = v_u_28()
			v_u_29 = v34
			v_u_30 = v35
			local v36 = v_u_30
			return v_u_20.Heading, string.rep("#", string.sub(v36, 1, 1) == "=" and 2 or 1) .. " " .. v33
		end
		local v37 = { v_u_30 }
		while v_u_21[v31] and v31 == v_u_29 do
			table.insert(v37, v32)
			v31, v32 = v_u_28()
		end
		local v38 = v_u_29
		local v39 = table.concat(v37, "\n")
		v_u_29 = v31
		v_u_30 = v32
		return v38, v39
	end
	local function v_u_70() -- name: it
		-- upvalues: (copy) v_u_40, (ref) v_u_20, (copy) v_u_70, (copy) p_u_23, (ref) v_u_71
		local v41, v42 = v_u_40()
		if v41 == v_u_20.None then
			return v_u_70()
		end
		local v43 = {}
		if v41 then
			if v41 == v_u_20.Paragraph then
				v43.Text = p_u_23(v42)
			elseif v41 == v_u_20.Image then
				local v44 = string.match(v42, "^!%[(%w-)|?[%dx]*,? ?%d*%%?%]")
				local v45 = string.match(v42, "%((.-)%)$")
				v43.Title = v44 or "Unknown"
				v43.ID = v45 or "6266306999"
				local v46, v47 = string.match(v42, "^%s*!%[%w-|(%d+)x(%d+)%]*")
				local v48 = tonumber(v46)
				local v49 = tonumber(v47)
				v43.Resolution = {
					["X"] = v48 or 1024,
					["Y"] = v49 or 1024
				}
				v43.AspectRatio = (v48 or 1) / (v49 or 1)
				local v50 = string.match(v42, "^%s*!%[%w-|?[%dx]*, (%d+)%%")
				v43.Scale = (tonumber(v50) or 100) / 100
			elseif v41 == v_u_20.Heading then
				local v51, v52 = string.match(v42, "^#+()%s*(.*)")
				local v53 = v51 - 1
				local v54 = p_u_23(v52)
				v43.Level = v53
				v43.Text = v54
			elseif v41 == v_u_20.Code then
				local v55, v56 = string.match(v42, "^```(.-)\n(.*)\n```$")
				v43.Syntax = v55
				v43.Code = v56
			elseif v41 == v_u_20.List then
				local v57 = string.split(v42, "\n")
				for v58, v59 in ipairs(v57) do
					local v60, v61 = string.match(v59, "^%s*()(.*)")
					local v62 = v60 / 2
					local v63 = math.floor(v62)
					local v64, v65 = string.match(v61, "^(.-)%s+(.*)")
					v57[v58] = {
						["Level"] = v63,
						["Text"] = p_u_23(v65),
						["Symbol"] = v64
					}
				end
				v43.Lines = v57
			elseif v41 == v_u_20.Quote then
				local v66 = string.split(v42, "\n")
				for v67 = 1, #v66 do
					v66[v67] = string.match(v66[v67], "^%s*>%s*(.*)")
				end
				local v68 = table.concat(v66, "\n")
				local v69 = v_u_71(v68, p_u_23)
				v43.RawText = v68
				v43.Iterator = v69
			end
		end
		return v41, v43
	end
	return v_u_70
end
v1.sanitize = v_u_4
function v1.parse(p72, p73) -- name: parseDocument
	-- upvalues: (copy) v_u_19, (copy) v_u_20, (copy) v_u_21, (copy) v_u_71
	local v74 = string.gsub(p72, "\t", "    ")
	local v_u_75 = p73 or v_u_19
	local v_u_76 = v_u_20.None
	local v_u_77 = string.split(v74, "\n")
	local v_u_78 = 0
	local function v_u_80() -- name: it
		-- upvalues: (ref) v_u_78, (copy) v_u_77, (ref) v_u_76, (ref) v_u_20
		v_u_78 = v_u_78 + 1
		local v79 = v_u_77[v_u_78]
		if v79 then
			if v_u_76 == v_u_20.Code then
				if string.match(v79, "^```") then
					v_u_76 = v_u_20.None
				end
				return v_u_20.Code, v79
			elseif string.match(v79, "^%s*$") then
				return v_u_20.None, ""
			elseif string.match(v79, "^%-%-%-+") or string.match(v79, "^===+") then
				return v_u_20.Ruler, ""
			elseif string.match(v79, "^%s*!%[%w-|?[%dx]*,? ?%d*%%?%]%(.-%)") then
				return v_u_20.Image, v79
			elseif string.match(v79, "^#") then
				return v_u_20.Heading, v79
			elseif string.match(v79, "^%s*```") then
				v_u_76 = v_u_20.Code
				return v_u_76, v79
			elseif string.match(v79, "^%s*>") then
				return v_u_20.Quote, v79
			elseif string.match(v79, "^%s*%-%s+") or (string.match(v79, "^%s*%*%s+") or (string.match(v79, "^%s*[%u%d]+%.%s+") or string.match(v79, "^%s*%+%s+"))) then
				return v_u_20.List, v79
			else
				return v_u_20.Paragraph, v79
			end
		else
			return
		end
	end
	local v_u_81, v_u_82 = v_u_80()
	local function v_u_92()
		-- upvalues: (copy) v_u_80, (ref) v_u_20, (ref) v_u_81, (ref) v_u_82, (ref) v_u_21
		local v83, v84 = v_u_80()
		if v83 == v_u_20.Ruler and v_u_81 == v_u_20.Paragraph then
			local v85 = v_u_82
			local v86, v87 = v_u_80()
			v_u_81 = v86
			v_u_82 = v87
			local v88 = v_u_82
			return v_u_20.Heading, string.rep("#", string.sub(v88, 1, 1) == "=" and 2 or 1) .. " " .. v85
		end
		local v89 = { v_u_82 }
		while v_u_21[v83] and v83 == v_u_81 do
			table.insert(v89, v84)
			v83, v84 = v_u_80()
		end
		local v90 = v_u_81
		local v91 = table.concat(v89, "\n")
		v_u_81 = v83
		v_u_82 = v84
		return v90, v91
	end
	local function v_u_122() -- name: it
		-- upvalues: (copy) v_u_92, (ref) v_u_20, (copy) v_u_122, (copy) v_u_75, (ref) v_u_71
		local v93, v94 = v_u_92()
		if v93 == v_u_20.None then
			return v_u_122()
		end
		local v95 = {}
		if v93 then
			if v93 == v_u_20.Paragraph then
				v95.Text = v_u_75(v94)
			elseif v93 == v_u_20.Image then
				local v96 = string.match(v94, "^!%[(%w-)|?[%dx]*,? ?%d*%%?%]")
				local v97 = string.match(v94, "%((.-)%)$")
				v95.Title = v96 or "Unknown"
				v95.ID = v97 or "6266306999"
				local v98, v99 = string.match(v94, "^%s*!%[%w-|(%d+)x(%d+)%]*")
				local v100 = tonumber(v98)
				local v101 = tonumber(v99)
				v95.Resolution = {
					["X"] = v100 or 1024,
					["Y"] = v101 or 1024
				}
				v95.AspectRatio = (v100 or 1) / (v101 or 1)
				local v102 = string.match(v94, "^%s*!%[%w-|?[%dx]*, (%d+)%%")
				v95.Scale = (tonumber(v102) or 100) / 100
			elseif v93 == v_u_20.Heading then
				local v103, v104 = string.match(v94, "^#+()%s*(.*)")
				local v105 = v103 - 1
				local v106 = v_u_75(v104)
				v95.Level = v105
				v95.Text = v106
			elseif v93 == v_u_20.Code then
				local v107, v108 = string.match(v94, "^```(.-)\n(.*)\n```$")
				v95.Syntax = v107
				v95.Code = v108
			elseif v93 == v_u_20.List then
				local v109 = string.split(v94, "\n")
				for v110, v111 in ipairs(v109) do
					local v112, v113 = string.match(v111, "^%s*()(.*)")
					local v114 = v112 / 2
					local v115 = math.floor(v114)
					local v116, v117 = string.match(v113, "^(.-)%s+(.*)")
					v109[v110] = {
						["Level"] = v115,
						["Text"] = v_u_75(v117),
						["Symbol"] = v116
					}
				end
				v95.Lines = v109
			elseif v93 == v_u_20.Quote then
				local v118 = string.split(v94, "\n")
				for v119 = 1, #v118 do
					v118[v119] = string.match(v118[v119], "^%s*>%s*(.*)")
				end
				local v120 = table.concat(v118, "\n")
				local v121 = v_u_71(v120, v_u_75)
				v95.RawText = v120
				v95.Iterator = v121
			end
		end
		return v93, v95
	end
	return v_u_122
end
v1.BlockType = v_u_20
v1.InlineType = {
	["Text"] = 0,
	["Ref"] = 1
}
v1.ModifierType = v2
return v1