local v_u_1 = require("./CameraShakeInstance")
local v_u_9 = {
	["Bump"] = function() -- name: Bump
		-- upvalues: (copy) v_u_1
		local v2 = v_u_1.new(2.5, 4, 0.1, 0.75)
		v2.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
		v2.RotationInfluence = Vector3.new(1, 1, 1)
		return v2
	end,
	["Explosion"] = function() -- name: Explosion
		-- upvalues: (copy) v_u_1
		local v3 = v_u_1.new(5, 10, 0, 1.5)
		v3.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		v3.RotationInfluence = Vector3.new(4, 1, 1)
		return v3
	end,
	["Earthquake"] = function() -- name: Earthquake
		-- upvalues: (copy) v_u_1
		local v4 = v_u_1.new(0.6, 3.5, 2, 10)
		v4.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		v4.RotationInfluence = Vector3.new(1, 1, 4)
		return v4
	end,
	["BadTrip"] = function() -- name: BadTrip
		-- upvalues: (copy) v_u_1
		local v5 = v_u_1.new(10, 0.15, 5, 10)
		v5.PositionInfluence = Vector3.new(0, 0, 0.15)
		v5.RotationInfluence = Vector3.new(2, 1, 4)
		return v5
	end,
	["HandheldCamera"] = function() -- name: HandheldCamera
		-- upvalues: (copy) v_u_1
		local v6 = v_u_1.new(1, 0.25, 5, 10)
		v6.PositionInfluence = Vector3.new(0, 0, 0)
		v6.RotationInfluence = Vector3.new(1, 0.5, 0.5)
		return v6
	end,
	["Vibration"] = function() -- name: Vibration
		-- upvalues: (copy) v_u_1
		local v7 = v_u_1.new(0.4, 20, 2, 2)
		v7.PositionInfluence = Vector3.new(0, 0.15, 0)
		v7.RotationInfluence = Vector3.new(1.25, 0, 4)
		return v7
	end,
	["RoughDriving"] = function() -- name: RoughDriving
		-- upvalues: (copy) v_u_1
		local v8 = v_u_1.new(1, 2, 1, 1)
		v8.PositionInfluence = Vector3.new(0, 0, 0)
		v8.RotationInfluence = Vector3.new(1, 1, 1)
		return v8
	end
}
return setmetatable({}, {
	["__index"] = function(_, p10) -- name: __index
		-- upvalues: (copy) v_u_9
		local v11 = v_u_9[p10]
		if type(v11) == "function" then
			return v11()
		end
		error("No preset found with index \"" .. p10 .. "\"")
	end
})