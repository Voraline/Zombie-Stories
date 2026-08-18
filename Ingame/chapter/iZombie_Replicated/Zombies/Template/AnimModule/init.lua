return {
	["LoadAnimation"] = function(p1, p2) -- name: LoadAnimation
		local v3 = p1:WaitForChild("HitboxModelPointer")
		local v_u_4 = v3.Value
		if not v_u_4 then
			while not v_u_4 do
				v_u_4 = v3.Value
				task.wait()
			end
		end
		local v_u_5 = v_u_4:WaitForChild("HP")
		local v_u_6 = p1:WaitForChild("NPCHumanoid")
		local v_u_7 = p2:LoadAnimation(script.Animations.Walk)
		v_u_7.Priority = Enum.AnimationPriority.Idle
		local v_u_8 = p2:LoadAnimation(script.Animations.Idle)
		v_u_8.Priority = Enum.AnimationPriority.Core
		local v_u_9 = p2:LoadAnimation(script.Animations.Death)
		v_u_9.Priority = Enum.AnimationPriority.Action
		local v_u_10 = p2:LoadAnimation(script.Animations.Stunned)
		v_u_10.Priority = Enum.AnimationPriority.Movement
		local v_u_11 = nil
		local v_u_15 = v_u_6.Running:Connect(function(p12)
			-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8
			if p12 > 0.2 and v_u_5.Value > 0 then
				local v13 = v_u_6.WalkSpeed
				local v14 = math.min(p12, v13)
				if v_u_7.IsPlaying == false then
					v_u_7:Play(0.1, 1, v14 / v_u_6.WalkSpeed)
				else
					v_u_7:AdjustSpeed(v14 / v_u_6.WalkSpeed)
				end
				v_u_8:Stop()
			else
				v_u_7:Stop()
				v_u_8:Play()
			end
		end)
		local v_u_16 = v_u_6.Jumping:Connect(function()
			-- upvalues: (copy) v_u_5, (copy) v_u_7
			if v_u_5.Value > 0 then
				v_u_7:Stop()
			end
		end)
		local v_u_18 = v_u_5.Changed:Connect(function(p17)
			-- upvalues: (copy) v_u_9
			if p17 <= 0 then
				v_u_9:Play()
			else
				v_u_9:Stop()
			end
		end)
		local v_u_19 = v_u_4.AttributeChanged:Connect(function(_)
			-- upvalues: (ref) v_u_4, (copy) v_u_10
			if v_u_4:GetAttribute("Stunned") then
				v_u_10:Play()
			else
				v_u_10:Stop()
			end
		end)
		local v_u_20 = p1:WaitForChild("HumanoidRootPart")
		v_u_11 = v_u_20:GetPropertyChangedSignal("Parent"):Connect(function()
			-- upvalues: (copy) v_u_20, (ref) v_u_15, (ref) v_u_16, (ref) v_u_18, (ref) v_u_19, (ref) v_u_11
			if not v_u_20.Parent then
				if v_u_15 then
					v_u_15:Disconnect()
					v_u_15 = nil
				end
				if v_u_16 then
					v_u_16:Disconnect()
					v_u_16 = nil
				end
				if v_u_18 then
					v_u_18:Disconnect()
					v_u_18 = nil
				end
				if v_u_19 then
					v_u_19:Disconnect()
					v_u_19 = nil
				end
				if v_u_11 then
					v_u_11:Disconnect()
					v_u_11 = nil
				end
			end
		end)
	end
}