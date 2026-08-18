local v_u_61 = {
	["new"] = function(p1, p2) -- name: new
		-- upvalues: (copy) v_u_61
		local v3 = p1 or 0
		local v4 = p2 or tick
		local v5 = {
			["_clock"] = nil,
			["_time0"] = nil,
			["_position0"] = nil,
			["_velocity0"] = nil,
			["_target"] = nil,
			["_damper"] = 1,
			["_speed"] = 1,
			["_clock"] = v4,
			["_time0"] = v4(),
			["_position0"] = v3,
			["_velocity0"] = 0 * v3,
			["_target"] = v3
		}
		local v6 = v_u_61
		return setmetatable(v5, v6)
	end,
	["Impulse"] = function(p7, p8) -- name: Impulse
		p7.Velocity = p7.Velocity + p8
	end,
	["TimeSkip"] = function(p9, p10) -- name: TimeSkip
		local v11 = p9._clock()
		local v12, v13 = p9:_positionVelocity(v11 + p10)
		p9._position0 = v12
		p9._velocity0 = v13
		p9._time0 = v11
	end,
	["__index"] = function(p14, p15) -- name: __index
		-- upvalues: (copy) v_u_61
		if v_u_61[p15] then
			return v_u_61[p15]
		end
		if p15 == "Value" or (p15 == "Position" or p15 == "p") then
			local v16, _ = p14:_positionVelocity(p14._clock())
			return v16
		end
		if p15 == "Velocity" or p15 == "v" then
			local _, v17 = p14:_positionVelocity(p14._clock())
			return v17
		end
		if p15 == "Target" or p15 == "t" then
			return p14._target
		end
		if p15 == "Damper" or p15 == "d" then
			return p14._damper
		end
		if p15 == "Speed" or p15 == "s" then
			return p14._speed
		end
		if p15 == "Clock" then
			return p14._clock
		end
		error(("%q is not a valid member of Spring"):format((tostring(p15))), 2)
	end,
	["__newindex"] = function(p18, p19, p20) -- name: __newindex
		local v21 = p18._clock()
		if p19 == "Value" or (p19 == "Position" or p19 == "p") then
			local _, v22 = p18:_positionVelocity(v21)
			p18._position0 = p20
			p18._velocity0 = v22
			p18._time0 = v21
			return
		elseif p19 == "Velocity" or p19 == "v" then
			local v23, _ = p18:_positionVelocity(v21)
			p18._position0 = v23
			p18._velocity0 = p20
			p18._time0 = v21
			return
		elseif p19 == "Target" or p19 == "t" then
			local v24, v25 = p18:_positionVelocity(v21)
			p18._position0 = v24
			p18._velocity0 = v25
			p18._target = p20
			p18._time0 = v21
			return
		elseif p19 == "Damper" or p19 == "d" then
			local v26, v27 = p18:_positionVelocity(v21)
			p18._position0 = v26
			p18._velocity0 = v27
			p18._damper = math.clamp(p20, 0, 1)
			p18._time0 = v21
			return
		elseif p19 == "Speed" or p19 == "s" then
			local v28, v29 = p18:_positionVelocity(v21)
			p18._position0 = v28
			p18._velocity0 = v29
			p18._speed = p20 < 0 and 0 or p20
			p18._time0 = v21
			return
		elseif p19 == "Clock" then
			local v30, v31 = p18:_positionVelocity(v21)
			p18._position0 = v30
			p18._velocity0 = v31
			p18._clock = p20
			p18._time0 = p20()
		else
			error(("%q is not a valid member of Spring"):format((tostring(p19))), 2)
		end
	end,
	["_positionVelocity"] = function(p32, p33) -- name: _positionVelocity
		local v34 = p32._position0
		local v35 = p32._velocity0
		local v36 = p32._target
		local v37 = p32._damper
		local v38 = p32._speed
		local v39 = v38 * (p33 - p32._time0)
		local v40 = v37 * v37
		local v41, v42, v43
		if v40 < 1 then
			local v44 = 1 - v40
			v41 = math.sqrt(v44)
			local v45 = -v37 * v39
			local v46 = math.exp(v45) / v41
			local v47 = v41 * v39
			v42 = v46 * math.cos(v47)
			local v48 = v41 * v39
			v43 = v46 * math.sin(v48)
		elseif v40 == 1 then
			v41 = 1
			local v49 = -v37 * v39
			v42 = math.exp(v49) / v41
			v43 = v42 * v39
		else
			local v50 = v40 - 1
			v41 = math.sqrt(v50)
			local v51 = (-v37 + v41) * v39
			local v52 = math.exp(v51) / (2 * v41)
			local v53 = (-v37 - v41) * v39
			local v54 = math.exp(v53) / (2 * v41)
			v42 = v52 + v54
			v43 = v52 - v54
		end
		local v55 = v41 * v42 + v37 * v43
		local v56 = 1 - (v41 * v42 + v37 * v43)
		local v57 = v43 / v38
		local v58 = -v38 * v43
		local v59 = v38 * v43
		local v60 = v41 * v42 - v37 * v43
		return v55 * v34 + v56 * v36 + v57 * v35, v58 * v34 + v59 * v36 + v60 * v35
	end
}
return v_u_61