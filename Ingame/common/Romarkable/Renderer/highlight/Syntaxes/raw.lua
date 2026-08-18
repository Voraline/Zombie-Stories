local v_u_21 = {
	["scan"] = function(p_u_1) -- name: scan
		local v_u_2 = false
		return function()
			-- upvalues: (ref) v_u_2, (copy) p_u_1
			if not v_u_2 then
				v_u_2 = true
				return "raw", p_u_1
			end
		end
	end,
	["navigator"] = function() -- name: navigator
		-- upvalues: (copy) v_u_21
		local v_u_20 = {
			["Source"] = "",
			["TokenCache"] = nil,
			["_RealIndex"] = 0,
			["_UserIndex"] = 0,
			["_ScanThread"] = nil,
			["TokenCache"] = table.create(50),
			["Destroy"] = function(p3) -- name: Destroy
				p3.Source = nil
				p3._RealIndex = nil
				p3._UserIndex = nil
				p3.TokenCache = nil
				p3._ScanThread = nil
			end,
			["SetSource"] = function(p_u_4, p5) -- name: SetSource
				-- upvalues: (ref) v_u_21
				p_u_4.Source = p5
				p_u_4._RealIndex = 0
				p_u_4._UserIndex = 0
				table.clear(p_u_4.TokenCache)
				p_u_4._ScanThread = coroutine.create(function()
					-- upvalues: (ref) v_u_21, (copy) p_u_4
					for v6, v7 in v_u_21.scan(p_u_4.Source) do
						local v8 = p_u_4
						v8._RealIndex = v8._RealIndex + 1
						p_u_4.TokenCache[p_u_4._RealIndex] = { v6, v7 }
						coroutine.yield(v6, v7)
					end
				end)
			end,
			["Next"] = function() -- name: Next
				-- upvalues: (copy) v_u_20
				local v9 = v_u_20
				v9._UserIndex = v9._UserIndex + 1
				if v_u_20._RealIndex >= v_u_20._UserIndex then
					local v10 = v_u_20.TokenCache[v_u_20._UserIndex]
					return table.unpack(v10)
				elseif coroutine.status(v_u_20._ScanThread) ~= "dead" then
					local v11, v12, v13 = coroutine.resume(v_u_20._ScanThread)
					if v11 and v12 then
						return v12, v13
					end
				end
			end,
			["Peek"] = function(p14) -- name: Peek
				-- upvalues: (copy) v_u_20
				local v15 = v_u_20._UserIndex + p14
				if v15 <= v_u_20._RealIndex then
					if v15 > 0 then
						local v16 = v_u_20.TokenCache[v15]
						return table.unpack(v16)
					end
				elseif coroutine.status(v_u_20._ScanThread) ~= "dead" then
					local v17 = nil
					local v18 = nil
					for _ = 1, v15 - v_u_20._RealIndex do
						local v19
						v19, v17, v18 = coroutine.resume(v_u_20._ScanThread)
						if not (v19 or v17) then
							break
						end
					end
					return v17, v18
				end
			end
		}
		return v_u_20
	end
}
return v_u_21