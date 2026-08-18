local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1.__tostring(p2) -- name: __tostring
	return p2._name
end
function v_u_1.new(p3) -- name: new
	-- upvalues: (copy) v_u_1
	local v4 = {
		["_name"] = nil,
		["_type"] = "phase",
		["_name"] = p3 or debug.info(2, "sl")
	}
	local v5 = v_u_1
	return setmetatable(v4, v5)
end
v_u_1.PreStartup = v_u_1.new("PreStartup")
v_u_1.Startup = v_u_1.new("Startup")
v_u_1.PostStartup = v_u_1.new("PostStartup")
return v_u_1