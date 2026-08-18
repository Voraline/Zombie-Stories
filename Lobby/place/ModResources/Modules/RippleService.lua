local v1 = game:GetService("ReplicatedStorage").place:WaitForChild("ModResources")
local v_u_2 = require(v1.common:WaitForChild("TweenService"))
local v_u_3 = game:GetService("ServerScriptService").place:WaitForChild("Resources"):WaitForChild("RippleTwo") or game:GetService("ServerScriptService").place:WaitForChild("Resources"):WaitForChild("RippleOne")
return {
	["ButtonAnimationClassic"] = function(p_u_4) -- name: ButtonAnimationClassic
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		p_u_4.MouseButton1Down:Connect(function(p5, p6)
			-- upvalues: (ref) v_u_3, (copy) p_u_4, (ref) v_u_2
			local v_u_7 = v_u_3:Clone()
			v_u_7.Parent = p_u_4
			v_u_7.Position = UDim2.new(0, p5 - p_u_4.AbsolutePosition.X, 0, p6 - p_u_4.AbsolutePosition.Y - 36)
			v_u_7.Visible = true
			v_u_2:TweenAsync(v_u_7, 0.4, "Quint", "Out", {
				["Size"] = UDim2.new(3, 0, 3, 0)
			})
			coroutine.wrap(function()
				-- upvalues: (ref) v_u_2, (copy) v_u_7
				task.wait(0.1)
				v_u_2:Tween(v_u_7, 1, "Quint", "Out", {
					["ImageTransparency"] = 1
				})
				v_u_7.ImageTransparency = 1
				v_u_7:Destroy()
			end)()
		end)
	end,
	["ButtonAnimation"] = function(p_u_8) -- name: ButtonAnimation
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		p_u_8.MouseButton1Down:Connect(function(p9, p10)
			-- upvalues: (ref) v_u_3, (copy) p_u_8, (ref) v_u_2
			local v_u_11 = v_u_3:Clone()
			v_u_11.ZIndex = p_u_8.ZIndex + 1
			v_u_11.Parent = p_u_8:FindFirstChild("RippleFrame") and p_u_8.RippleFrame or p_u_8
			v_u_11.Position = UDim2.new(0, p9 - p_u_8.AbsolutePosition.X, 0, p10 - p_u_8.AbsolutePosition.Y - 36)
			v_u_11.Visible = true
			v_u_2:SpringAsync(v_u_11, 0.4, 1.5, {
				["Size"] = UDim2.new(3, 0, 3, 0)
			})
			task.defer(function()
				-- upvalues: (ref) v_u_2, (copy) v_u_11
				task.wait(0.1)
				v_u_2:Spring(v_u_11, 0.2, 1.5, {
					["ImageTransparency"] = 1
				})
				v_u_11.ImageTransparency = 1
				v_u_11:Destroy()
			end)
		end)
	end,
	["TextBoxAnimation"] = function(p12, _) -- name: TextBoxAnimation
		p12.Focused:Connect(function() end)
	end
}