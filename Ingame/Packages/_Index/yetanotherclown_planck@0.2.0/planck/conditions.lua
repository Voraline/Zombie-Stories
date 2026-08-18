local v_u_1 = require(script.Parent.utils)
local v_u_2 = v_u_1.getConnectFunction
local v_u_3 = {}
return {
	["timePassed"] = function(p_u_4) -- name: timePassed
		local v_u_5 = nil
		return function()
			-- upvalues: (ref) v_u_5, (copy) p_u_4
			if v_u_5 ~= nil and p_u_4 > os.clock() - v_u_5 then
				return false
			end
			v_u_5 = os.clock()
			return true
		end
	end,
	["runOnce"] = function() -- name: runOnce
		local v_u_6 = false
		return function()
			-- upvalues: (ref) v_u_6
			if v_u_6 then
				return false
			end
			v_u_6 = true
			return true
		end
	end,
	["onEvent"] = function(p7, p8) -- name: onEvent
		-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_3
		local v9 = v_u_2(p7, p8)
		assert(v9, "Event passed to .onEvent is not valid")
		local v_u_10 = false
		local v_u_11 = {}
		local v_u_12 = nil
		local function v_u_13() -- name: disconnect
			-- upvalues: (ref) v_u_12, (ref) v_u_1
			if v_u_12 then
				v_u_1.disconnectEvent(v_u_12)
				v_u_12 = nil
			end
		end
		v_u_12 = v9(function(...) -- name: callback
			-- upvalues: (ref) v_u_10, (copy) v_u_11
			v_u_10 = true
			local v14 = v_u_11
			table.insert(v14, { ... })
		end)
		local function v15() -- name: hasNewEvent
			-- upvalues: (ref) v_u_10, (copy) v_u_11
			if v_u_10 then
				v_u_10 = false
				return true
			else
				table.clear(v_u_11)
				return false
			end
		end
		v_u_3[v15] = v_u_13
		return v15, function() -- name: collectEvents
			-- upvalues: (copy) v_u_11
			local v_u_16 = 0
			return function()
				-- upvalues: (ref) v_u_16, (ref) v_u_11
				v_u_16 = v_u_16 + 1
				local v17 = table.remove(v_u_11, 1)
				if v17 then
					return v_u_16, table.unpack(v17)
				else
					return nil
				end
			end
		end, function() -- name: getDisconnectFn
			-- upvalues: (copy) v_u_13
			return v_u_13
		end
	end,
	["isNot"] = function(p_u_18, ...) -- name: isNot
		return function()
			-- upvalues: (copy) p_u_18
			return not p_u_18()
		end
	end,
	["cleanupCondition"] = function(p19) -- name: cleanupCondition
		-- upvalues: (copy) v_u_3
		local v20 = v_u_3[p19]
		if v20 then
			v20()
			v_u_3[p19] = nil
		end
	end
}