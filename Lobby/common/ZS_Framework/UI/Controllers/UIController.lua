local v_u_1 = game:GetService("Players")
local v_u_2 = require("../../Data/PlayerDatabase")
task.spawn(function()
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	while not v_u_1.LocalPlayer:FindFirstChild("PlayerGui") do
		task.wait(0.1)
	end
	v_u_2.PlayerGui:set(v_u_1.LocalPlayer:FindFirstChild("PlayerGui"))
end)
return {}