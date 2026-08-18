require("./types/fusion")
local function v_u_1() -- name: doNothing end
return function(p2, p_u_3) -- name: useEffect
	-- upvalues: (copy) v_u_1
	p2:Observer(p2:Computed(function(p4, p5)
		-- upvalues: (copy) p_u_3
		p_u_3(p4, p5)
		return {}
	end)):onChange(v_u_1)
end