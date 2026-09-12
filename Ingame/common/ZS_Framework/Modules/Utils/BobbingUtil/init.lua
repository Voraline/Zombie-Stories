local RunService = game:GetService("RunService")
local u5 = {}
u5.gunBobCF = CFrame.new()
u5.cameraBobCF = CFrame.new()
local bobCycles = require(script:WaitForChild("bobCycles"))
local Value = Enum.RenderPriority.Character.Value
RunService:BindToRenderStep("BobbingUtil", Value, function(p1) -- Line: 16 -- upvalues: bobCycles (val), u5 (val)
    bobCycles.Weapon = u5.CurrentWeapon
    local v1 = u5
    local v2 = u5
    local v3, v4 = bobCycles.Update(p1)
    v1.gunBobCF = v3
    v2.cameraBobCF = v4
end)
return u5