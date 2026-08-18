local v_u_1 = require("./CameraShakeInstance")
local v_u_10 = {
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
	["Helicopter"] = function() -- name: Helicopter
		-- upvalues: (copy) v_u_1
		local v7 = v_u_1.new(0.5, 0.1, 5, 10)
		v7.PositionInfluence = Vector3.new(0, 0, 0)
		v7.RotationInfluence = Vector3.new(1, 0.25, 0.25)
		return v7
	end,
	["Vibration"] = function() -- name: Vibration
		-- upvalues: (copy) v_u_1
		local v8 = v_u_1.new(0.4, 20, 2, 2)
		v8.PositionInfluence = Vector3.new(0, 0.15, 0)
		v8.RotationInfluence = Vector3.new(1.25, 0, 4)
		return v8
	end,
	["RoughDriving"] = function() -- name: RoughDriving
		-- upvalues: (copy) v_u_1
		local v9 = v_u_1.new(1, 2, 1, 1)
		v9.PositionInfluence = Vector3.new(0, 0, 0)
		v9.RotationInfluence = Vector3.new(1, 1, 1)
		return v9
	end
}
return setmetatable({}, {
	["__index"] = function(_, p11) -- name: __index
		-- upvalues: (copy) v_u_10
		local v12 = v_u_10[p11]
		if type(v12) == "function" then
			return v12()
		end
		error("No preset found with index \"" .. p11 .. "\"")
	end
})