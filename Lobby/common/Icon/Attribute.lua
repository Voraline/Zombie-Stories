local RunService = game:GetService("RunService")
game:GetService("GroupService")
game:GetService("Players")
if not RunService:IsStudio() then
    local v1 = print
    local v2 = require("./VERSION")
    v1((("🍍 Running TopbarPlus %* by ForeverHD"):format(v2)))
end
return {}