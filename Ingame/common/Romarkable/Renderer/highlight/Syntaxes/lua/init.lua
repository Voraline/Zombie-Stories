local v_u_1 = {}
local v2 = require("@self/language")
local v_u_3 = v2.keyword
local v_u_4 = v2.builtin
local v_u_5 = v2.libraries
local v_u_6 = {
	{ "^[%c%s]*[%a_][%w_]*[%c%s]*", "var" },
	{ "^[%c%s]*0x[%da-fA-F]+[%c%s]*", "number" },
	{ "^[%c%s]*%d+%.?%d*[eE][%+%-]?%d+[%c%s]*", "number" },
	{ "^[%c%s]*%d+[%._]?[%d_eE]*[%c%s]*", "number" },
	{ "^[%c%s]*([\'\"])%1[%c%s]*", "string" },
	{ "^[%c%s]*([\'\"])[^\n]-([^\\]%1)[%c%s]*", "string" },
	{ "^[%c%s]*([\'\"]).-\n[%c%s]*", "string" },
	{ "^[%c%s]*([\'\"])[^\n]*[%c%s]*", "string" },
	{ "^[%c%s]*%[(=*)%[.-%]%1%][%c%s]*", "string" },
	{ "^[%c%s]*%[=*%[.-.*[%c%s]*", "string" },
	{ "^[%c%s]*%-%-%[(=*)%[.-%]%1%][%c%s]*", "comment" },
	{ "^[%c%s]*%-%-%[=*%[.-.*[%c%s]*", "comment" },
	{ "^[%c%s]*%-%-.-\n[%c%s]*", "comment" },
	{ "^[%c%s]*%-%-.*[%c%s]*", "comment" },
	{ "^[%c%s]*[:;<>/~%*%(%)%-={},%.#%^%+%%]+[%c%s]*", "operator" },
	{ "^[%c%s]*[%[%]]+[%c%s]*", "operator" },
	{ "^[%c%s]*[%z\1-\127\194-\244][\128-\191]+[%c%s]*", "iden" },
	{ "^.", "iden" }
}
function v_u_1.scan(p_u_7) -- name: scan
	-- upvalues: (copy) v_u_1, (copy) v_u_6, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
	v_u_1.finished = false
	local v_u_8 = 1
	local v_u_9 = #p_u_7
	local v_u_10 = ""
	local v_u_11 = ""
	local v_u_12 = ""
	local v_u_13 = ""
	return function()
		-- upvalues: (ref) v_u_8, (copy) v_u_9, (ref) v_u_6, (copy) p_u_7, (ref) v_u_1, (ref) v_u_3, (ref) v_u_4, (ref) v_u_10, (ref) v_u_13, (ref) v_u_11, (ref) v_u_5, (ref) v_u_12
		if v_u_8 <= v_u_9 then
			for _, v14 in ipairs(v_u_6) do
				local v15, v16 = string.find(p_u_7, v14[1], v_u_8)
				if v15 then
					local v17 = p_u_7
					local v18 = string.sub(v17, v15, v16)
					v_u_8 = v16 + 1
					v_u_1.finished = v_u_9 < v_u_8
					local v19 = v14[2]
					if v19 == "var" then
						local v20 = string.gsub(v18, "[%c%s]+", "")
						v19 = v_u_3[v20] and "keyword" or (v_u_4[v20] and "builtin" or "iden")
						if string.find(v_u_10, "%.[%s%c]*$") and v_u_13 ~= "comment" then
							local v21 = v_u_5[string.gsub(v_u_11, "[%c%s]+", "")]
							v19 = v21 and (v21[v20] and not string.find(v_u_12, "%.[%s%c]*$")) and "builtin" or "iden"
						end
					end
					v_u_12 = v_u_11
					v_u_11 = v_u_10
					v_u_10 = v18
					v_u_13 = v19
					return v19, v18
				end
			end
		end
	end
end
function v_u_1.navigator() -- name: navigator
	-- upvalues: (copy) v_u_1
	local v_u_39 = {
		["Source"] = "",
		["TokenCache"] = nil,
		["_RealIndex"] = 0,
		["_UserIndex"] = 0,
		["_ScanThread"] = nil,
		["TokenCache"] = table.create(50),
		["Destroy"] = function(p22) -- name: Destroy
			p22.Source = nil
			p22._RealIndex = nil
			p22._UserIndex = nil
			p22.TokenCache = nil
			p22._ScanThread = nil
		end,
		["SetSource"] = function(p_u_23, p24) -- name: SetSource
			-- upvalues: (ref) v_u_1
			p_u_23.Source = p24
			p_u_23._RealIndex = 0
			p_u_23._UserIndex = 0
			table.clear(p_u_23.TokenCache)
			p_u_23._ScanThread = coroutine.create(function()
				-- upvalues: (ref) v_u_1, (copy) p_u_23
				for v25, v26 in v_u_1.scan(p_u_23.Source) do
					local v27 = p_u_23
					v27._RealIndex = v27._RealIndex + 1
					p_u_23.TokenCache[p_u_23._RealIndex] = { v25, v26 }
					coroutine.yield(v25, v26)
				end
			end)
		end,
		["Next"] = function() -- name: Next
			-- upvalues: (copy) v_u_39
			local v28 = v_u_39
			v28._UserIndex = v28._UserIndex + 1
			if v_u_39._RealIndex >= v_u_39._UserIndex then
				local v29 = v_u_39.TokenCache[v_u_39._UserIndex]
				return table.unpack(v29)
			elseif coroutine.status(v_u_39._ScanThread) ~= "dead" then
				local v30, v31, v32 = coroutine.resume(v_u_39._ScanThread)
				if v30 and v31 then
					return v31, v32
				end
			end
		end,
		["Peek"] = function(p33) -- name: Peek
			-- upvalues: (copy) v_u_39
			local v34 = v_u_39._UserIndex + p33
			if v34 <= v_u_39._RealIndex then
				if v34 > 0 then
					local v35 = v_u_39.TokenCache[v34]
					return table.unpack(v35)
				end
			elseif coroutine.status(v_u_39._ScanThread) ~= "dead" then
				local v36 = nil
				local v37 = nil
				for _ = 1, v34 - v_u_39._RealIndex do
					local v38
					v38, v36, v37 = coroutine.resume(v_u_39._ScanThread)
					if not (v38 or v36) then
						break
					end
				end
				return v36, v37
			end
		end
	}
	return v_u_39
end
return v_u_1