return {
	["Any"] = function(p1)
		return p1
	end,
	["Boolean"] = function(p2)
		local v3 = type(p2) == "boolean"
		assert(v3)
		return p2
	end,
	["Thread"] = function(p4)
		local v5 = type(p4) == "thread"
		assert(v5)
		return p4
	end,
	["Nil"] = function(p6)
		local v7 = p6 == nil
		assert(v7)
		return p6
	end,
	["Number"] = function(p8)
		local v9 = type(p8) == "number"
		assert(v9)
		local v10 = p8 == p8
		assert(v10)
		return p8
	end,
	["String"] = function(p11)
		local v12 = type(p11) == "string"
		assert(v12)
		return p11
	end,
	["Optional"] = function(p_u_13) -- name: Optional
		return function(p14)
			-- upvalues: (copy) p_u_13
			if p14 == nil then
				return nil
			else
				return p_u_13(p14)
			end
		end
	end,
	["Literal"] = function(p_u_15) -- name: Literal
		return function(p16)
			-- upvalues: (copy) p_u_15
			local v17 = p16 == p_u_15
			assert(v17)
			return p16
		end
	end,
	["Or"] = function(p_u_18, p_u_19) -- name: Or
		return function(p20)
			-- upvalues: (copy) p_u_18, (copy) p_u_19
			if pcall(p_u_18, p20) then
				return p20
			end
			if pcall(p_u_19, p20) then
				return p20
			end
			error("Union check failed")
		end
	end,
	["And"] = function(p_u_21, p_u_22) -- name: And
		return function(p23)
			-- upvalues: (copy) p_u_21, (copy) p_u_22
			if not pcall(p_u_21, p23) then
				error("Intersection check failed")
			end
			if not pcall(p_u_22, p23) then
				error("Intersection check failed")
			end
			return p23
		end
	end,
	["Map"] = function(p_u_24, p_u_25) -- name: Map
		return function(p26)
			-- upvalues: (copy) p_u_24, (copy) p_u_25
			local v27 = type(p26) == "table"
			assert(v27)
			for v28, v29 in p26 do
				p_u_24(v28)
				p_u_25(v29)
			end
			return p26
		end
	end,
	["Set"] = function(p_u_30) -- name: Set
		local v_u_31 = true
		local function v_u_34(p32)
			-- upvalues: (copy) v_u_31
			local v33 = p32 == v_u_31
			assert(v33)
			return p32
		end
		return function(p35)
			-- upvalues: (copy) p_u_30, (copy) v_u_34
			local v36 = type(p35) == "table"
			assert(v36)
			for v37, v38 in p35 do
				p_u_30(v37)
				v_u_34(v38)
			end
			return p35
		end
	end,
	["List"] = function(p_u_39) -- name: List
		return function(p40)
			-- upvalues: (copy) p_u_39
			local v41 = type(p40) == "table"
			assert(v41)
			for v42 = 1, table.maxn(p40) do
				p_u_39(p40[v42])
			end
			return p40
		end
	end,
	["Integer"] = function(p43)
		local v44 = type(p43) == "number"
		assert(v44)
		local v45 = p43 % 1 == 0
		assert(v45)
		return p43
	end,
	["NumberMin"] = function(p_u_46) -- name: NumberMin
		return function(p47)
			-- upvalues: (copy) p_u_46
			local v48 = type(p47) == "number"
			assert(v48)
			local v49 = p_u_46 <= p47
			assert(v49)
			return p47
		end
	end,
	["NumberMax"] = function(p_u_50) -- name: NumberMax
		return function(p51)
			-- upvalues: (copy) p_u_50
			local v52 = type(p51) == "number"
			assert(v52)
			local v53 = p51 <= p_u_50
			assert(v53)
			return p51
		end
	end,
	["NumberMinMax"] = function(p_u_54, p_u_55) -- name: NumberMinMax
		return function(p56)
			-- upvalues: (copy) p_u_54, (copy) p_u_55
			local v57 = type(p56) == "number"
			assert(v57)
			local v58 = p_u_54 < p56
			assert(v58)
			local v59 = p56 < p_u_55
			assert(v59)
			return p56
		end
	end,
	["CFrame"] = function(p60)
		local v61 = typeof(p60) == "CFrame"
		assert(v61)
		local v62 = p60 == p60
		assert(v62)
		return p60
	end,
	["Color3"] = function(p63)
		local v64 = typeof(p63) == "Color3"
		assert(v64)
		local v65 = p63 == p63
		assert(v65)
		return p63
	end,
	["DateTime"] = function(p66)
		local v67 = typeof(p66) == "DateTime"
		assert(v67)
		return p66
	end,
	["Instance"] = function(p68)
		local v69 = typeof(p68) == "Instance"
		assert(v69)
		return p68
	end,
	["Vector2"] = function(p70)
		local v71 = typeof(p70) == "Vector2"
		assert(v71)
		local v72 = p70 == p70
		assert(v72)
		return p70
	end,
	["Vector2int16"] = function(p73)
		local v74 = typeof(p73) == "Vector2int16"
		assert(v74)
		return p73
	end,
	["Vector3"] = function(p75)
		local v76 = typeof(p75) == "Vector3"
		assert(v76)
		local v77 = p75 == p75
		assert(v77)
		return p75
	end,
	["Vector3int16"] = function(p78)
		local v79 = typeof(p78) == "Vector3int16"
		assert(v79)
		return p78
	end,
	["Check"] = function(p_u_80) -- name: Check
		return function(p81)
			-- upvalues: (copy) p_u_80
			return pcall(p_u_80, p81)
		end
	end
}