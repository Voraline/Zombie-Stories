require("./types/fusion")
local v_u_1 = require(script.Parent.utils["lock-value"])
local function v_u_8(p2, p3) -- name: isSimilar
	local v4 = typeof(p2)
	local v5 = v4 == "table"
	local v6 = v4 == "userdata"
	local v7
	if v5 or v6 then
		if v4 == typeof(p3) and (v6 or (table.isfrozen(p2) or getmetatable(p2) ~= nil)) then
			return p2 == p3
		end
		v7 = false
	elseif p2 == p3 then
		v7 = true
	else
		if p2 ~= p2 then
			return p3 ~= p3
		end
		v7 = false
	end
	return v7
end
return function(p9, p_u_10, p11) -- name: usePrevious
	-- upvalues: (copy) v_u_8, (copy) v_u_1
	local v_u_12 = p9.peek
	local v_u_13 = p9:Value(nil)
	local v_u_14 = p11 or v_u_8
	p9:Observer(p_u_10):onChange(function()
		-- upvalues: (copy) v_u_12, (copy) p_u_10, (copy) v_u_13, (copy) v_u_14
		local v15 = v_u_12(p_u_10)
		if not v_u_14(v_u_12(v_u_13), v15) then
			v_u_13:set(v15)
		end
	end)
	return v_u_1(v_u_13)
end