local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
game:GetService("Players")
workspace:WaitForChild("Ignore")
local NPCs_Shared = ReplicatedStorage.common:WaitForChild("NPCs_Shared")
NPCs_Shared:WaitForChild("Resources")
local BaseNPCv2_Client = require(NPCs_Shared.AIClasses.BaseNPCv2_Client)
local u33 = {_ClassName = script.Name}
u33.__index = u33
setmetatable(u33, BaseNPCv2_Client)
u33.Name = "WalkingNPC"
function u33.new(p1) -- Line: 31 -- upvalues: BaseNPCv2_Client (val), u33 (val)
    local v1 = BaseNPCv2_Client.new(p1)
    setmetatable(v1, u33)
    return v1
end
return u33