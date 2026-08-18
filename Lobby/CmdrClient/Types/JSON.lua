local v_u_1 = game:GetService("HttpService")
return function(p2)
	-- upvalues: (copy) v_u_1
	p2:RegisterType("json", {
		["Validate"] = function(p3) -- name: Validate
			-- upvalues: (ref) v_u_1
			return pcall(v_u_1.JSONDecode, v_u_1, p3)
		end,
		["Parse"] = function(p4) -- name: Parse
			-- upvalues: (ref) v_u_1
			return v_u_1:JSONDecode(p4)
		end
	})
end