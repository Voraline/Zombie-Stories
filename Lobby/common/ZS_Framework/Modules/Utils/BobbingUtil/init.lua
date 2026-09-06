local RunService = game:GetService("RunService")
local u5 = {gunBobCF = CFrame.new(), cameraBobCF = CFrame.new()}
local bobCycles = require(script:WaitForChild("bobCycles"))
RunService:BindToRenderStep("BobbingUtil", Enum.RenderPriority.Character.Value, function(p1) -- Line: 16 -- upvalues: bobCycles (val), u5 (val)
    local v1, v2
    bobCycles.Weapon = u5.CurrentWeapon
    v1, v2 = bobCycles.Update(p1)
    u5.gunBobCF = v1
    u5.cameraBobCF = v2
end)
return u5