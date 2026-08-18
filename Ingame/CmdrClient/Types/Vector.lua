local v_u_1 = require("../Shared/Util")
local function v4(p2, p3) -- name: validateVector
	if p2 == nil then
		return false, ("Invalid or missing number at position %d in Vector type."):format(p3)
	else
		return true
	end
end
local v_u_5 = v_u_1.MakeSequenceType({
	["ValidateEach"] = nil,
	["TransformEach"] = nil,
	["Constructor"] = nil,
	["Length"] = 3,
	["ValidateEach"] = v4,
	["TransformEach"] = tonumber,
	["Constructor"] = Vector3.new
})
local v_u_6 = v_u_1.MakeSequenceType({
	["ValidateEach"] = nil,
	["TransformEach"] = nil,
	["Constructor"] = nil,
	["Length"] = 2,
	["ValidateEach"] = v4,
	["TransformEach"] = tonumber,
	["Constructor"] = Vector2.new
})
return function(p7)
	-- upvalues: (copy) v_u_5, (copy) v_u_1, (copy) v_u_6
	p7:RegisterType("vector3", v_u_5)
	p7:RegisterType("vector3s", v_u_1.MakeListableType(v_u_5))
	p7:RegisterType("vector2", v_u_6)
	p7:RegisterType("vector2s", v_u_1.MakeListableType(v_u_6))
end