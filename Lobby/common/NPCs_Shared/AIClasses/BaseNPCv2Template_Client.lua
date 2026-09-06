local ReplicatedStorage = game:GetService("ReplicatedStorage")
workspace:WaitForChild("Ignore")
local NPCs_Shared = ReplicatedStorage.common:WaitForChild("NPCs_Shared")
NPCs_Shared:WaitForChild("Resources")
local BaseNPCv2_Client = require(NPCs_Shared.AIClasses.BaseNPCv2_Client)
local u23 = {_ClassName = script.Name}
u23.__index = u23
setmetatable(u23, BaseNPCv2_Client)
function u23.new(p1) -- Line: 25 -- upvalues: BaseNPCv2_Client (val), u23 (val)
    local v1 = BaseNPCv2_Client.new(p1)
    setmetatable(v1, u23)
    return v1
end
return u23