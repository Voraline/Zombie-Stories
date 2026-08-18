local v_u_1 = game:GetService("RunService")
return function(p_u_2, p_u_3)
	-- upvalues: (copy) v_u_1
	local v_u_4 = Instance.new("BindableEvent")
	local v_u_5 = p_u_2.CFrame
	local v_u_6 = nil
	local v_u_7 = os.clock()
	local v_u_8 = math.random(-5, 5)
	local v_u_9 = math.random(-5, 5)
	v_u_6 = v_u_1.RenderStepped:Connect(function(_)
		-- upvalues: (copy) v_u_7, (ref) v_u_5, (copy) p_u_2, (copy) v_u_8, (copy) v_u_9, (copy) p_u_3, (ref) v_u_4, (ref) v_u_6
		local v10 = os.clock() - v_u_7
		local v11 = -v10 ^ 3 * 35 + 8 * v10
		p_u_2.CFrame = CFrame.new(0, v11, v10):ToWorldSpace(v_u_5) * CFrame.Angles(v10 * v_u_8, -v10 * v_u_9, 0)
		if v10 >= 2 or not p_u_3.Parent then
			if v_u_4 then
				v_u_4:Fire()
				v_u_4:Destroy()
				v_u_4 = nil
			end
			if v_u_6 then
				v_u_6:Disconnect()
				v_u_6 = nil
			end
			v_u_5 = nil
		end
	end)
	return v_u_4.Event
end