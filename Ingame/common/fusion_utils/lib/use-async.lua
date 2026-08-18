require("./types/fusion")
local v_u_1 = require(script.Parent.utils["cast-to-state"])
local v_u_2 = require(script.Parent.utils["lock-value"])
return function(p3, p_u_4, p_u_5) -- name: useAsync
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v_u_6 = p3:scoped()
	local v_u_7 = v_u_6.peek
	local v_u_8 = v_u_6:Value(p_u_4)
	local v_u_9 = {}
	local v_u_10 = nil
	local function v_u_12(p11) -- name: become
		-- upvalues: (copy) v_u_8
		return v_u_8:set(p11)
	end
	local function v_u_14() -- name: clear
		-- upvalues: (ref) v_u_10, (copy) v_u_9, (copy) v_u_8, (copy) p_u_4
		if v_u_10 then
			v_u_10:doCleanup()
			v_u_10 = nil
		end
		if next(v_u_9) ~= nil then
			for _, v13 in pairs(v_u_9) do
				pcall(v13)
			end
			table.clear(v_u_9)
		end
		v_u_8:set(p_u_4)
	end
	local function v_u_19() -- name: process
		-- upvalues: (copy) v_u_14, (ref) v_u_1, (copy) v_u_9, (copy) v_u_6, (copy) v_u_19, (copy) v_u_7, (ref) v_u_10, (copy) p_u_5, (copy) v_u_12, (copy) v_u_8, (copy) p_u_4
		v_u_14()
		local function v16(p15) -- name: use
			-- upvalues: (ref) v_u_1, (ref) v_u_9, (ref) v_u_6, (ref) v_u_19, (ref) v_u_7
			if not v_u_1(p15) then
				return p15
			end
			v_u_9[p15] = v_u_6:Observer(p15):onChange(function()
				-- upvalues: (ref) v_u_19
				task.spawn(v_u_19)
			end)
			return v_u_7(p15)
		end
		v_u_10 = v_u_6:innerScope()
		local v17, v18 = xpcall(p_u_5, debug.traceback, v16, v_u_12, v_u_10)
		if v17 then
			v_u_8:set(v18)
		end
		warn((("[pretty-fusion-utils] useEventual processor thrown error during processing:\n%*"):format(v18)))
		v_u_8:set(p_u_4)
	end
	return v_u_2(v_u_8)
end