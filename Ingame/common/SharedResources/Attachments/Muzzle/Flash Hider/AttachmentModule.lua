local WepConfig = require(game:GetService("ReplicatedStorage").common:WaitForChild("WepConfig"))
local AttachmentFolder = WepConfig:GetAttachmentFolder("Muzzle_Shared")
local AttachmentModule = require(AttachmentFolder:WaitForChild("AttachmentModule", 5))
local u23 = {}
u23.__index = u23
setmetatable(u23, AttachmentModule)
function u23.new(p1, p2) -- Line: 8 -- upvalues: AttachmentModule (val), u23 (val)
    local v1 = AttachmentModule.new(p1, p2)
    setmetatable(v1, u23)
    v1.SettingChanges.MuzzleModule = "Smoke"
    return v1
end
return u23