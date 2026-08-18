return function(p_u_1, p_u_2)
	local v3 = p_u_1 > 0
	assert(v3, "Limit must be greater than 0")
	local v_u_4 = {}
	local v_u_5 = 0
	return function(p_u_6)
		-- upvalues: (copy) v_u_4, (copy) p_u_2, (copy) p_u_1, (ref) v_u_5
		if p_u_6 then
			local v7 = v_u_4[p_u_6]
			if v7 == nil then
				task.delay(p_u_2, function()
					-- upvalues: (ref) v_u_4, (copy) p_u_6
					v_u_4[p_u_6] = nil
				end)
				v7 = 0
			end
			if v7 == p_u_1 then
				return false
			end
			v_u_4[p_u_6] = v7 + 1
		else
			if v_u_5 == 0 then
				task.delay(p_u_2, function()
					-- upvalues: (ref) v_u_5
					v_u_5 = 0
				end)
			end
			if v_u_5 == p_u_1 then
				return false
			end
			v_u_5 = v_u_5 + 1
		end
		return true
	end
end