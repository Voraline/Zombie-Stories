local v1 = game:GetService("ReplicatedStorage")
workspace:WaitForChild("Ignore")
local v2 = v1.common:WaitForChild("NPCs_Shared")
v2:WaitForChild("Resources")
local v_u_3 = require(v2.AIClasses.BaseNPCv2_Client)
local v_u_4 = {
	["_ClassName"] = script.Name
}
v_u_4.__index = v_u_4
setmetatable(v_u_4, v_u_3)
function v_u_4.new(p5) -- name: new
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	local v6 = v_u_3.new(p5)
	local v7 = v_u_4
	setmetatable(v6, v7)
	return v6
end
return v_u_4