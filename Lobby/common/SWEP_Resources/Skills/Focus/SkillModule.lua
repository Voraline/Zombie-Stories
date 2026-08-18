local v1 = {
	["ActivateType"] = "Use"
}
local v2 = game:GetService("RunService")
local v_u_3 = game:GetService("ReplicatedStorage").common:WaitForChild("Remotes"):WaitForChild("Net")
local v_u_4 = script.Parent:WaitForChild("Resources")
if v2:IsClient() then
	function v1.Init(p5, p_u_6, p_u_7) -- name: Init
		-- upvalues: (copy) v_u_4, (copy) v_u_3
		local v_u_8 = script.Parent:WaitForChild("DashGui"):Clone()
		v_u_8.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
		local v_u_9 = game:GetService("SoundService")
		local v_u_10 = v_u_4.ColorCorrection
		local v_u_11 = v_u_9.AmbientReverb
		v_u_10.Parent = game.Lighting
		local v_u_12 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v13 = p5:WaitForChild("Frame")
		local v_u_14 = v13:WaitForChild("UseBar")
		local v_u_15 = v13:waitForChild("Tactical")
		game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("FrameworkEvent")
		local v_u_16 = game.ReplicatedStorage.common:WaitForChild("Remotes"):WaitForChild("Focus")
		local v_u_17 = workspace:WaitForChild("InitialFocus").Value
		local v_u_18 = false
		local v_u_19 = false
		local function v_u_20() -- name: FocusUpdate
			-- upvalues: (ref) v_u_18, (copy) v_u_14, (ref) v_u_17, (copy) p_u_7, (copy) v_u_15, (ref) v_u_19, (copy) v_u_9, (ref) v_u_4, (copy) p_u_6
			if v_u_18 == false then
				v_u_14:TweenSize(UDim2.new(v_u_17 / 1, 0, 0.75, 0), "Out", "Linear", 0.1, false)
				if v_u_17 >= 1 then
					p_u_7("white")
					if v_u_15.Text ~= "FOCUS: READY [<FInstruction>]" and v_u_19 == false then
						v_u_9:PlayLocalSound(v_u_4.Recharge)
						v_u_19 = true
					end
					p_u_6("FOCUS: READY [<FInstruction>]")
					return
				end
				p_u_7("red")
				p_u_6("FOCUS: NOT READY")
				v_u_19 = false
			end
		end
		v_u_3.OnClientEvent:connect(function(p21, p22)
			-- upvalues: (ref) v_u_17, (copy) v_u_20, (ref) v_u_18, (copy) v_u_8, (copy) v_u_14, (ref) v_u_4, (copy) v_u_9, (copy) v_u_10, (copy) v_u_12, (ref) v_u_11
			if p21 == "f" then
				v_u_17 = p22
				v_u_20()
			elseif p21 == "FocusEnded" then
				v_u_18 = false
				v_u_8.On.Value = false
				v_u_14:TweenSize(UDim2.new(0, 0, 0.75, 0), "Out", "Linear", 0, true)
				v_u_20()
				v_u_4.Focus:Stop()
				v_u_9:PlayLocalSound(v_u_4.FocusEnd)
				game:GetService("TweenService"):Create(v_u_10, v_u_12, {
					["TintColor"] = Color3.new(1, 1, 1)
				}):Play()
				v_u_9.AmbientReverb = v_u_11
			end
		end)
		return function(_) -- name: udpText
			-- upvalues: (copy) v_u_20
			v_u_20()
		end, function() -- name: activate
			-- upvalues: (ref) v_u_17, (copy) v_u_16, (ref) v_u_18, (copy) v_u_8, (copy) v_u_14, (copy) p_u_6, (ref) v_u_4, (copy) v_u_9, (copy) v_u_10, (copy) v_u_12, (ref) v_u_11
			if v_u_17 >= 1 then
				local v23, v24 = v_u_16:InvokeServer()
				if v23 then
					v_u_18 = true
					v_u_17 = 0
					v_u_8.On.Value = true
					v_u_14:TweenSize(UDim2.new(0, 0, 0.75, 0), "Out", "Linear", v24, true)
					p_u_6("FOCUS: ACTIVE")
					v_u_4.Focus:Play()
					v_u_9:PlayLocalSound(v_u_4.FocusActive)
					task.delay(0.7, function()
						-- upvalues: (ref) v_u_9, (ref) v_u_4
						v_u_9:PlayLocalSound(v_u_4.FocusActive2)
					end)
					game:GetService("TweenService"):Create(v_u_10, v_u_12, {
						["TintColor"] = Color3.fromRGB(202, 197, 255)
					}):Play()
					v_u_11 = v_u_9.AmbientReverb
					v_u_9.AmbientReverb = "Hangar"
				end
			end
		end
	end
	return v1
else
	v2:IsServer()
	return v1
end