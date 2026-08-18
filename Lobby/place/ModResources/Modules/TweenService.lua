local v1 = {}
local v_u_2 = game:GetService("TweenService")
local v_u_3 = require("./Spring")
function v1.Tween(_, p4, p5, p6, p7, p8) -- name: Tween
	-- upvalues: (copy) v_u_2
	local v9 = v_u_2:Create(p4, TweenInfo.new(p5, Enum.EasingStyle[p6].Value, Enum.EasingDirection[p7].Value), p8)
	v9:Play()
	v9.Completed:Wait()
	v9:Destroy()
end
function v1.TweenAsync(_, p10, p11, p12, p13, p14) -- name: TweenAsync
	-- upvalues: (copy) v_u_2
	v_u_2:Create(p10, TweenInfo.new(p11, Enum.EasingStyle[p12].Value, Enum.EasingDirection[p13].Value), p14):Play()
end
function v1.Spring(_, p15, p16, p17, p18) -- name: Spring
	-- upvalues: (copy) v_u_3
	v_u_3.Target(p15, p16, p17, p18)
	task.wait(p16)
	v_u_3.Stop(p15)
end
function v1.SpringAsync(_, p_u_19, p20, p21, p22) -- name: SpringAsync
	-- upvalues: (copy) v_u_3
	v_u_3.Target(p_u_19, p20, p21, p22)
	task.delay(p20, function()
		-- upvalues: (ref) v_u_3, (copy) p_u_19
		v_u_3.Stop(p_u_19)
	end)
end
return v1