local v_u_1 = game:GetService("UserInputService")
require("./types/fusion")
local v_u_2 = require(script.Parent.utils["lock-value"])
return function(p3, p_u_4) -- name: useMouse
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v_u_5 = p3.peek
	local v_u_6 = p3:Value(v_u_1:GetMouseLocation())
	local v7 = v_u_1.InputBegan
	local function v9(p8)
		-- upvalues: (copy) v_u_6, (ref) v_u_1
		if p8.UserInputType == Enum.UserInputType.MouseMovement or p8.UserInputType == Enum.UserInputType.Touch then
			v_u_6:set(v_u_1:GetMouseLocation())
		end
	end
	table.insert(p3, v7:Connect(v9))
	if p_u_4 then
		p3:Observer(v_u_6):onBind(function()
			-- upvalues: (copy) p_u_4, (copy) v_u_5, (copy) v_u_6
			p_u_4(v_u_5(v_u_6))
		end)
	end
	return v_u_2(v_u_6)
end