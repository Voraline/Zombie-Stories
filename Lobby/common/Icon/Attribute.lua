local RunService = game:GetService("RunService")
game:GetService("GroupService")
game:GetService("Players")
if not (RunService:IsStudio()) then
    print((("🍍 Running TopbarPlus %* by ForeverHD"):format((require("./VERSION")))))
end
return {}