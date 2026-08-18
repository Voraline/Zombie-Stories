local v_u_1 = game:GetService("RunService")
return function(p_u_2, p_u_3)
	-- upvalues: (copy) v_u_1
	local v_u_4 = 0
	local v_u_5 = p_u_2 * 10
	local v_u_7 = v_u_1.Heartbeat:Connect(function(p6)
		-- upvalues: (ref) v_u_4, (copy) v_u_5, (copy) p_u_3, (copy) p_u_2
		v_u_4 = v_u_4 + p6
		if v_u_5 < v_u_4 then
			v_u_4 = 0
			p_u_3()
		elseif p_u_2 < v_u_4 then
			v_u_4 = v_u_4 - p_u_2
			p_u_3()
		end
	end)
	return function()
		-- upvalues: (copy) v_u_7
		v_u_7:Disconnect()
	end
end