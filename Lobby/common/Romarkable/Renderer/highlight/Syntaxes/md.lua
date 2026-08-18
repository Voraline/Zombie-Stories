local v_u_1 = {}
local v_u_2 = {
	{ "^[%c%s]*#+ .-\n[%c%s]*", "header" },
	{ "^[%c%s]*%.-\n%-%-%-\n[%c%s]*", "header" },
	{ "^[%c%s]*> .-\n\n[%c%s]*", "quote" },
	{ "^[%c%s]*```%w-\n.-```[%c%s]*", "code" },
	{ "^[%c%s]*%* .-\n[%c%s]*", "list" },
	{ "^[%c%s]*%d[%.)] .-\n[%c%s]*", "list" },
	{ "^[%c%s]*%-%-%-%-%-*\n?[%c%s]*", "ruler" },
	{ "^[%c%s]*[%w \t]+[%c%s]*", "text" },
	{ "^.", "text" }
}
function v_u_1.scan(p_u_3) -- name: scan
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	v_u_1.finished = false
	local v_u_4 = 1
	local v_u_5 = #p_u_3
	return function()
		-- upvalues: (ref) v_u_4, (copy) v_u_5, (ref) v_u_2, (copy) p_u_3, (ref) v_u_1
		if v_u_4 <= v_u_5 then
			for _, v6 in ipairs(v_u_2) do
				local v7, v8 = string.find(p_u_3, v6[1], v_u_4)
				if v7 then
					local v9 = p_u_3
					local v10 = string.sub(v9, v7, v8)
					v_u_4 = v8 + 1
					v_u_1.finished = v_u_5 < v_u_4
					return v6[2], v10
				end
			end
		end
	end
end
function v_u_1.navigator() -- name: navigator
	-- upvalues: (copy) v_u_1
	local v_u_28 = {
		["Source"] = "",
		["TokenCache"] = nil,
		["_RealIndex"] = 0,
		["_UserIndex"] = 0,
		["_ScanThread"] = nil,
		["TokenCache"] = table.create(50),
		["Destroy"] = function(p11) -- name: Destroy
			p11.Source = nil
			p11._RealIndex = nil
			p11._UserIndex = nil
			p11.TokenCache = nil
			p11._ScanThread = nil
		end,
		["SetSource"] = function(p_u_12, p13) -- name: SetSource
			-- upvalues: (ref) v_u_1
			p_u_12.Source = p13
			p_u_12._RealIndex = 0
			p_u_12._UserIndex = 0
			table.clear(p_u_12.TokenCache)
			p_u_12._ScanThread = coroutine.create(function()
				-- upvalues: (ref) v_u_1, (copy) p_u_12
				for v14, v15 in v_u_1.scan(p_u_12.Source) do
					local v16 = p_u_12
					v16._RealIndex = v16._RealIndex + 1
					p_u_12.TokenCache[p_u_12._RealIndex] = { v14, v15 }
					coroutine.yield(v14, v15)
				end
			end)
		end,
		["Next"] = function() -- name: Next
			-- upvalues: (copy) v_u_28
			local v17 = v_u_28
			v17._UserIndex = v17._UserIndex + 1
			if v_u_28._RealIndex >= v_u_28._UserIndex then
				local v18 = v_u_28.TokenCache[v_u_28._UserIndex]
				return table.unpack(v18)
			elseif coroutine.status(v_u_28._ScanThread) ~= "dead" then
				local v19, v20, v21 = coroutine.resume(v_u_28._ScanThread)
				if v19 and v20 then
					return v20, v21
				end
			end
		end,
		["Peek"] = function(p22) -- name: Peek
			-- upvalues: (copy) v_u_28
			local v23 = v_u_28._UserIndex + p22
			if v23 <= v_u_28._RealIndex then
				if v23 > 0 then
					local v24 = v_u_28.TokenCache[v23]
					return table.unpack(v24)
				end
			elseif coroutine.status(v_u_28._ScanThread) ~= "dead" then
				local v25 = nil
				local v26 = nil
				for _ = 1, v23 - v_u_28._RealIndex do
					local v27
					v27, v25, v26 = coroutine.resume(v_u_28._ScanThread)
					if not (v27 or v25) then
						break
					end
				end
				return v25, v26
			end
		end
	}
	return v_u_28
end
return v_u_1