local v_u_1 = game:GetService("TweenService")
local v_u_2 = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local v_u_3 = TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)
return {
	["Notify"] = function(_, p4, p5, p6, p7) -- name: Notify
		-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_3
		if v_u_2:IsClient() then
			local v8 = game.Players.LocalPlayer.PlayerGui:WaitForChild("BannerNotification")
			local v9 = v8.ActiveNotifications
			local v10 = v8.Canvas
			v8.Enabled = true
			v10.Background.Size = UDim2.fromScale(0.18, 0.6)
			v10.Background.ImageTransparency = 1
			v10.Background.Scale.Scale = 0
			v10.Content.GroupTransparency = 1
			local v11 = v10:Clone()
			v11.Name = p4
			v11.Parent = v9
			v11.Content.Header.Text = p4
			v11.Content.Message.Text = p5
			v11.Content.Icon.Image = p6
			v11.Visible = true
			v11.Background.Image = "rbxassetid://11983017276"
			v_u_1:Create(v11.Background, v_u_3, {
				["ImageTransparency"] = 0.3
			}):Play()
			v_u_1:Create(v11.Background.Scale, v_u_3, {
				["Scale"] = 1.2
			}):Play()
			task.wait(0.3)
			v11.Background.Image = "rbxassetid://11942813307"
			v_u_1:Create(v11.Background, v_u_3, {
				["Size"] = UDim2.fromScale(1, 0.6)
			}):Play()
			v_u_1:Create(v11.Background.Scale, v_u_3, {
				["Scale"] = 1
			}):Play()
			task.wait(0.1)
			v_u_1:Create(v11.Content, v_u_3, {
				["GroupTransparency"] = 0
			}):Play()
			task.wait(p7)
			v_u_1:Create(v11.Content, v_u_3, {
				["GroupTransparency"] = 1
			}):Play()
			task.wait(0.3)
			v11.Background.Image = "rbxassetid://11983017276"
			v_u_1:Create(v11.Background, v_u_3, {
				["Size"] = UDim2.fromScale(0.18, 0.6)
			}):Play()
			v_u_1:Create(v11.Background.Scale, v_u_3, {
				["Scale"] = 1.2
			}):Play()
			task.wait(0.3)
			v_u_1:Create(v11.Background, v_u_3, {
				["ImageTransparency"] = 1
			}):Play()
			v_u_1:Create(v11.Background.Scale, v_u_3, {
				["Scale"] = 0
			}):Play()
			task.wait(0.3)
			v11:Destroy()
		end
	end,
	["NumberOfActiveNotifications"] = function() -- name: NumberOfActiveNotifications
		-- upvalues: (copy) v_u_2
		-- -- failed to decompile
	end
}