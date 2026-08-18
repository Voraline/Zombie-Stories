local v1 = game:GetService("RunService")
local v_u_2 = {
	["gunBobCF"] = CFrame.new(),
	["cameraBobCF"] = CFrame.new()
}
local v_u_3 = require(script:WaitForChild("bobCycles"))
v1:BindToRenderStep("BobbingUtil", Enum.RenderPriority.Character.Value, function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	v_u_3.Weapon = v_u_2.CurrentWeapon
	local v5 = v_u_2
	local v6 = v_u_2
	local v7, v8 = v_u_3.Update(p4)
	v5.gunBobCF = v7
	v6.cameraBobCF = v8
end)
return v_u_2