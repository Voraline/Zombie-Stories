local v1 = game:GetService("ReplicatedStorage")
workspace:WaitForChild("Ignore")
local v2 = v1.common:WaitForChild("NPCs_Shared")
v2:WaitForChild("Resources")
local v_u_3 = v1.arc.NPCs_Shared.Resources.NPCModels
local v_u_4 = require(v2.AIClasses.BaseNPCv2_Client)
local v_u_5 = {
	["_ClassName"] = script.Name
}
v_u_5.__index = v_u_5
setmetatable(v_u_5, v_u_4)
v_u_5.Name = "Slasher"
function v_u_5.new(p6) -- name: new
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_3
	local v7 = v_u_4.new(p6)
	local v8 = v_u_5
	setmetatable(v7, v8)
	v7.BaseModel = v_u_3.Slasher
	v7.HealthBarName = "Slasher"
	v7.AnimationInfo.Idle = {
		["Id"] = "rbxassetid://1456411981",
		["Priority"] = nil,
		["Priority"] = Enum.AnimationPriority.Core
	}
	v7.AnimationInfo.Attack = {
		["Id"] = "rbxassetid://9205494146",
		["Priority"] = nil,
		["Priority"] = Enum.AnimationPriority.Action
	}
	return v7
end
return v_u_5