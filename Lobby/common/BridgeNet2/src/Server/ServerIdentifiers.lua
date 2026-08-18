local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require("../Constants")
require("../Types")
local v_u_4 = require("../Utilities/Output")
local v_u_5 = {}
local v_u_6 = 0
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = nil
function v_u_5.start() -- name: start
	-- upvalues: (ref) v_u_9, (copy) v_u_1, (copy) v_u_5
	v_u_9 = Instance.new("Folder")
	v_u_9.Name = "identifierStorage"
	v_u_9.Parent = v_u_1
	v_u_5.ref("NIL_VALUE")
	v_u_5.ref("REQUEST")
end
function v_u_5.ref(p10) -- name: ref
	-- upvalues: (copy) v_u_2, (copy) v_u_7, (copy) v_u_8, (copy) v_u_4, (ref) v_u_6, (copy) v_u_3, (ref) v_u_9
	if v_u_2:IsStudio() then
		v_u_7[p10] = p10
		v_u_8[p10] = p10
		return p10
	end
	if v_u_7[p10] ~= nil then
		return v_u_7[p10]
	end
	v_u_4.fatalAssert(v_u_6 <= v_u_3.IDENTIFIER_CAP, (("cannot create any more identifiers - over %* cap."):format(v_u_3.IDENTIFIER_CAP_STRING)))
	v_u_4.silent((("creating identifier: %*, identifier count: %*"):format(p10, v_u_6 + 1)))
	local v11
	if v_u_6 <= 255 then
		v11 = string.pack("B", v_u_6)
	else
		v11 = string.pack("H", v_u_6)
	end
	v_u_6 = v_u_6 + 1
	v_u_9:SetAttribute(p10, v11)
	v_u_7[p10] = v11
	v_u_8[v11] = p10
	return v11
end
function v_u_5.deser(p12) -- name: deser
	-- upvalues: (copy) v_u_4, (copy) v_u_8
	v_u_4.fatalAssert(typeof(p12) == "string", string.format("Deserialize takes string, got %*", (typeof(p12))))
	return v_u_8[p12]
end
function v_u_5.ser(p13) -- name: ser
	-- upvalues: (copy) v_u_4, (copy) v_u_7
	v_u_4.fatalAssert(typeof(p13) == "string", string.format("Serialize takes string, got %*", (typeof(p13))))
	return v_u_7[p13]
end
return v_u_5