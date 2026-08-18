local v_u_1 = 0
return {
	["GetUID"] = function(_) -- name: GetUID
		-- upvalues: (ref) v_u_1
		v_u_1 = v_u_1 % 65536 + 1
		return v_u_1
	end
}