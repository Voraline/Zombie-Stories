require("./types/fusion")
local v_u_1 = require(script.Parent["use-viewport"])
local v_u_2 = Vector2.new(1600, 900)
return function(p_u_3, p4, p5, p6) -- name: usePx
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v_u_7 = p4 or v_u_2
	local v_u_8 = p5 or 0.5
	local v_u_9 = p6 or 0.5
	local v_u_10 = v_u_1(p_u_3)
	local v_u_18 = p_u_3:Computed(function(p11)
		-- upvalues: (copy) v_u_10, (ref) v_u_7, (ref) v_u_9, (ref) v_u_8
		local v12 = p11(v_u_10)
		local v13 = v12.X / v_u_7.X
		local v14 = math.log(v13, 2)
		local v15 = v12.Y / v_u_7.Y
		local v16 = 2 ^ (v14 + (math.log(v15, 2) - v14) * v_u_9)
		local v17 = v_u_8
		return math.max(v16, v17)
	end)
	local v19 = {}
	setmetatable(v19, {
		["__call"] = function(_, p_u_20) -- name: __call
			-- upvalues: (copy) p_u_3, (copy) v_u_18
			return p_u_3:Computed(function(p21)
				-- upvalues: (copy) p_u_20, (ref) v_u_18
				return p_u_20 * p21(v_u_18)
			end)
		end
	})
	function v19.even(_, p_u_22) -- name: even
		-- upvalues: (copy) p_u_3, (copy) v_u_18
		return p_u_3:Computed(function(p23)
			-- upvalues: (copy) p_u_22, (ref) v_u_18
			local v24 = p_u_22 * p23(v_u_18) * 0.5
			return math.round(v24) * 2
		end)
	end
	function v19.scale(_, p_u_25) -- name: scale
		-- upvalues: (copy) p_u_3, (copy) v_u_18
		return p_u_3:Computed(function(p26)
			-- upvalues: (copy) p_u_25, (ref) v_u_18
			return p_u_25 * p26(v_u_18)
		end)
	end
	function v19.floor(_, p_u_27) -- name: floor
		-- upvalues: (copy) p_u_3, (copy) v_u_18
		return p_u_3:Computed(function(p28)
			-- upvalues: (copy) p_u_27, (ref) v_u_18
			local v29 = p_u_27 * p28(v_u_18)
			return math.floor(v29)
		end)
	end
	function v19.ceil(_, p_u_30) -- name: ceil
		-- upvalues: (copy) p_u_3, (copy) v_u_18
		return p_u_3:Computed(function(p31)
			-- upvalues: (copy) p_u_30, (ref) v_u_18
			local v32 = p_u_30 * p31(v_u_18)
			return math.ceil(v32)
		end)
	end
	return v19
end