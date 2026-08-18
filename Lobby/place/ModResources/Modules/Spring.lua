local v1 = game:GetService("RunService")
local v_u_2 = typeof
local v_u_3 = unpack
local v_u_4 = math.sin
local v_u_5 = math.cos
local v_u_6 = math.exp
local v_u_7 = math.floor
local v_u_8 = math.min
local v_u_9 = {}
v_u_9.__index = v_u_9
function v_u_9.new(p10, p11, p12, p13) -- name: new
	-- upvalues: (copy) v_u_9
	local v14 = p13.toIntermediate(p12)
	local v15 = {
		["d"] = p10,
		["f"] = p11,
		["g"] = v14,
		["p"] = v14,
		["v"] = v14 * 0,
		["typedat"] = p13
	}
	local v16 = v_u_9
	return setmetatable(v15, v16)
end
function v_u_9.setGoal(p17, p18) -- name: setGoal
	p17.g = p17.typedat.toIntermediate(p18)
end
function v_u_9.setSpringParams(p19, p20, p21) -- name: setSpringParams
	p19.d = p20
	p19.f = p21
end
function v_u_9.canSleep(p22) -- name: canSleep
	local v23 = p22.v:norm()
	local v24 = (p22.p - p22.g):norm()
	local v25
	if v23 < 1e-12 then
		v25 = v24 < 1e-10
	else
		v25 = false
	end
	return v25
end
function v_u_9.step(p26, p27) -- name: step
	-- upvalues: (copy) v_u_6, (copy) v_u_5, (copy) v_u_4
	local v28 = p26.d
	local v29 = p26.f * 6.2831853071796
	local v30 = p26.g
	local v31 = p26.p
	local v32 = p26.v
	local v33 = v31 - v30
	local v34 = v_u_6(-v28 * v29 * p27)
	local v35, v36
	if v28 == 1 then
		v35 = (v33 * (1 + v29 * p27) + v32 * p27) * v34 + v30
		v36 = (v32 * (1 - v29 * p27) - v33 * (v29 * v29 * p27)) * v34
	elseif v28 < 1 then
		local v37 = (1 - v28 * v28) ^ 0.5
		local v38 = v_u_5(p27 * v29 * v37)
		local v39 = v_u_4(p27 * v29 * v37)
		local v40 = v39 / (v29 * v37)
		local v41 = v39 / v37
		v35 = (v33 * (v38 + v41 * v28) + v32 * v40) * v34 + v30
		v36 = (v32 * (v38 - v41 * v28) - v33 * (v41 * v29)) * v34
	else
		local v42 = (v28 * v28 - 1) ^ 0.5
		local v43 = -v29 * (v28 - v42)
		local v44 = -v29 * (v28 + v42)
		local v45 = (v32 - v33 * v43) / (2 * v29 * v42)
		local v46 = (v33 - v45) * v_u_6(v43 * p27)
		local v47 = v45 * v_u_6(v44 * p27)
		v35 = v46 + v47 + v30
		v36 = v46 * v43 + v47 * v44
	end
	p26.p = v35
	p26.v = v36
	return p26.typedat.fromIntermediate(v35)
end
local v_u_48 = {}
v_u_48.__index = v_u_48
function v_u_48.new(...) -- name: new
	-- upvalues: (copy) v_u_48
	local v49 = v_u_48
	return setmetatable({ ... }, v49)
end
function v_u_48.__add(p50, p51) -- name: __add
	-- upvalues: (copy) v_u_3, (copy) v_u_48
	local v52 = { v_u_3(p50) }
	local v53 = v_u_48
	local v54 = setmetatable(v52, v53)
	for v55 = 1, #v54 do
		v54[v55] = v54[v55] + p51[v55]
	end
	return v54
end
function v_u_48.__sub(p56, p57) -- name: __sub
	-- upvalues: (copy) v_u_3, (copy) v_u_48
	local v58 = { v_u_3(p56) }
	local v59 = v_u_48
	local v60 = setmetatable(v58, v59)
	for v61 = 1, #v60 do
		v60[v61] = v60[v61] - p57[v61]
	end
	return v60
end
function v_u_48.__mul(p62, p63) -- name: __mul
	-- upvalues: (copy) v_u_3, (copy) v_u_48
	local v64 = { v_u_3(p62) }
	local v65 = v_u_48
	local v66 = setmetatable(v64, v65)
	for v67 = 1, #v66 do
		v66[v67] = v66[v67] * p63
	end
	return v66
end
function v_u_48.__div(p68, p69) -- name: __div
	-- upvalues: (copy) v_u_3, (copy) v_u_48
	local v70 = { v_u_3(p68) }
	local v71 = v_u_48
	local v72 = setmetatable(v70, v71)
	for v73 = 1, #v72 do
		v72[v73] = v72[v73] / p69
	end
	return v72
end
function v_u_48.norm(p74) -- name: norm
	local v75 = 0
	for _, v76 in next, p74 do
		v75 = v75 + v76 * v76
	end
	return v75
end
local v_u_118 = {
	["number"] = {
		["springType"] = v_u_9,
		["toIntermediate"] = function(p77) -- name: toIntermediate
			-- upvalues: (copy) v_u_48
			return v_u_48.new(p77)
		end,
		["fromIntermediate"] = function(p78) -- name: fromIntermediate
			return p78[1]
		end
	},
	["NumberRange"] = {
		["springType"] = v_u_9,
		["toIntermediate"] = function(p79) -- name: toIntermediate
			-- upvalues: (copy) v_u_48
			return v_u_48.new(p79.Min, p79.Max)
		end,
		["fromIntermediate"] = function(p80) -- name: fromIntermediate
			return NumberRange.new(p80[1], p80[2])
		end
	},
	["UDim"] = {
		["springType"] = v_u_9,
		["toIntermediate"] = function(p81) -- name: toIntermediate
			-- upvalues: (copy) v_u_48
			return v_u_48.new(p81.Scale, p81.Offset)
		end,
		["fromIntermediate"] = function(p82) -- name: fromIntermediate
			return UDim.new(p82[1], p82[2])
		end
	},
	["UDim2"] = {
		["springType"] = v_u_9,
		["toIntermediate"] = function(p83) -- name: toIntermediate
			-- upvalues: (copy) v_u_48
			local v84 = p83.X
			local v85 = p83.Y
			return v_u_48.new(v84.Scale, v84.Offset, v85.Scale, v85.Offset)
		end,
		["fromIntermediate"] = function(p86) -- name: fromIntermediate
			-- upvalues: (copy) v_u_7
			return UDim2.new(p86[1], v_u_7(p86[2] + 0.5), p86[3], (v_u_7(p86[4] + 0.5)))
		end
	},
	["Vector2"] = {
		["springType"] = v_u_9,
		["toIntermediate"] = function(p87) -- name: toIntermediate
			-- upvalues: (copy) v_u_48
			return v_u_48.new(p87.X, p87.Y)
		end,
		["fromIntermediate"] = function(p88) -- name: fromIntermediate
			return Vector2.new(p88[1], p88[2])
		end
	},
	["Vector3"] = {
		["springType"] = v_u_9,
		["toIntermediate"] = function(p89) -- name: toIntermediate
			-- upvalues: (copy) v_u_48
			return v_u_48.new(p89.X, p89.Y, p89.Z)
		end,
		["fromIntermediate"] = function(p90) -- name: fromIntermediate
			local v91 = p90[1]
			local v92 = p90[2]
			local v93 = p90[3]
			return Vector3.new(v91, v92, v93)
		end
	},
	["Color3"] = {
		["springType"] = v_u_9,
		["toIntermediate"] = function(p94) -- name: toIntermediate
			-- upvalues: (copy) v_u_48
			local v95 = p94.r
			local v96 = p94.g
			local v97 = p94.b
			local v98 = v95 < 0.0404482362771076 and v95 / 12.92 or 0.87941546140213 * (v95 + 0.055) ^ 2.4
			local v99 = v96 < 0.0404482362771076 and v96 / 12.92 or 0.87941546140213 * (v96 + 0.055) ^ 2.4
			local v100 = v97 < 0.0404482362771076 and v97 / 12.92 or 0.87941546140213 * (v97 + 0.055) ^ 2.4
			local v101 = 0.9257063972951867 * v98 - 0.8333736323779866 * v99 - 0.09209820666085898 * v100
			local v102 = 0.2125862307855956 * v98 + 0.7151703037034108 * v99 + 0.0722004986433362 * v100
			local v103 = 3.6590806972265884 * v98 + 11.442689580057424 * v99 + 4.114991502426484 * v100
			local v104 = v102 > 0.008856451679035631 and 116 * v102 ^ 0.3333333333333333 - 16 or 903.296296296296 * v102
			local v105, v106
			if v103 > 1e-15 then
				v105 = v104 * v101 / v103
				v106 = v104 * (9 * v102 / v103 - 0.46832)
			else
				v105 = -0.19783 * v104
				v106 = -0.46832 * v104
			end
			return v_u_48.new(v104, v105, v106)
		end,
		["fromIntermediate"] = function(p107) -- name: fromIntermediate
			-- upvalues: (copy) v_u_8
			local v108 = p107[1]
			if v108 < 0.0197955 then
				return Color3.new()
			end
			local v109 = p107[2] / v108 + 0.19783
			local v110 = p107[3] / v108 + 0.46832
			local v111 = (v108 + 16) / 116
			local v112 = v111 > 0.20689655172413793 and v111 * v111 * v111 or 0.12841854934601665 * v111 - 0.01771290335807126
			local v113 = v112 * v109 / v110
			local v114 = v112 * ((3 - 0.75 * v109) / v110 - 5)
			local v115 = 7.2914074 * v113 - 1.537208 * v112 - 0.4986286 * v114
			local v116 = -2.180094 * v113 + 1.8757561 * v112 + 0.0415175 * v114
			local v117 = 0.1253477 * v113 - 0.2040211 * v112 + 1.0569959 * v114
			if v115 < 0 and (v115 < v116 and v115 < v117) then
				v116 = v116 - v115
				v117 = v117 - v115
				v115 = 0
			elseif v116 < 0 and v116 < v117 then
				v115 = v115 - v116
				v117 = v117 - v116
				v116 = 0
			elseif v117 < 0 then
				v115 = v115 - v117
				v116 = v116 - v117
				v117 = 0
			end
			return Color3.new(v_u_8(v115 < 0.0031306684425 and 12.92 * v115 or 1.055 * v115 ^ 0.4166666666666667 - 0.055, 1), v_u_8(v116 < 0.0031306684425 and 12.92 * v116 or 1.055 * v116 ^ 0.4166666666666667 - 0.055, 1), (v_u_8(v117 < 0.0031306684425 and 12.92 * v117 or 1.055 * v117 ^ 0.4166666666666667 - 0.055, 1)))
		end
	}
}
local v_u_119 = {}
v1.RenderStepped:Connect(function(p120)
	-- upvalues: (copy) v_u_119
	for v121, v122 in next, v_u_119 do
		for v123, v124 in next, v122 do
			v121[v123] = v124:step(p120)
			if v124:canSleep() then
				v122[v123] = nil
			end
		end
		if not next(v122) then
			v_u_119[v121] = nil
		end
	end
end)
local v137 = {
	["target"] = function(p125, p126, p127, p128) -- name: target
		-- upvalues: (copy) v_u_119, (copy) v_u_118, (copy) v_u_2
		local v129 = v_u_119[p125]
		if not v129 then
			v129 = {}
			v_u_119[p125] = v129
		end
		for v130, v131 in next, p128 do
			local v132 = v129[v130]
			if not v132 then
				local v133 = v_u_118[v_u_2(v131)]
				v132 = v133.springType.new(p126, p127, p125[v130], v133)
				v129[v130] = v132
			end
			v132:setSpringParams(p126, p127)
			v132:setGoal(v131)
		end
	end,
	["stop"] = function(p134, p135) -- name: stop
		-- upvalues: (copy) v_u_119
		if p135 then
			local v136 = v_u_119[p134]
			if v136 then
				v136[p135] = nil
				return
			end
		else
			v_u_119[p134] = nil
		end
	end
}
v137.Target = v137.target
v137.Stop = v137.stop
return v137