local v_u_1 = require(script.Parent.Parent.Trove)
require(script.Parent.Streamable)
return {
	["Compound"] = function(p_u_2, p_u_3) -- name: Compound
		-- upvalues: (copy) v_u_1
		local v4 = v_u_1.new()
		local v_u_5 = v_u_1.new()
		local v_u_6 = false
		local function v_u_7() -- name: Cleanup
			-- upvalues: (ref) v_u_6, (copy) v_u_5
			if v_u_6 then
				v_u_6 = false
				v_u_5:Clean()
			end
		end
		local v_u_8 = v_u_6
		for _, v9 in pairs(p_u_2) do
			v4:Add(v9:Observe(function(_, p10)
				-- upvalues: (ref) v_u_8, (copy) p_u_2, (copy) p_u_3, (copy) v_u_5, (copy) v_u_7
				if v_u_8 then
					::l3::
					p10:Add(v_u_7)
					return
				else
					for _, v11 in pairs(p_u_2) do
						if not v11.Instance then
							goto l3
						end
					end
					v_u_8 = true
					p_u_3(p_u_2, v_u_5)
					goto l3
				end
			end))
		end
		v4:Add(v_u_7)
		return v4
	end
}