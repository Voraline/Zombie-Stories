local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("Lighting")
local v_u_4 = game:GetService("SoundService")
local v_u_5 = require(v1.common.ZS_Shared.Data.GameState)
local v_u_6, v_u_7 = require(v1.Packages.Bin)()
local function v_u_35() -- name: togglePartyMode
	-- upvalues: (copy) v_u_5, (copy) v_u_7, (copy) v_u_4, (copy) v_u_6, (copy) v_u_3, (copy) v_u_2
	local v8 = v_u_5.Data.Variables.PartyModeEnabled
	v_u_7()
	if v8 then
		local v9 = v_u_4:WaitForChild("Primary")
		local v_u_10 = v9:WaitForChild("Music")
		local v_u_11 = v_u_6(Instance.new("SoundGroup"))
		v_u_11.Name = "PartyModeMusicGroup"
		v_u_11.Volume = v_u_10:GetAttribute("Volume") or 1
		v_u_11.Parent = v9
		v_u_6(v_u_10:GetAttributeChangedSignal("Volume"):Connect(function()
			-- upvalues: (copy) v_u_11, (copy) v_u_10
			v_u_11.Volume = v_u_10:GetAttribute("Volume") or 1
		end))
		local v12 = v_u_6(Instance.new("Sound"))
		v12.Name = "PartyModeMusic"
		v12.SoundId = "rbxassetid://80336684189373"
		v12.Looped = true
		v12.Volume = 1
		v12.SoundGroup = v_u_11
		v12.Parent = v_u_4
		v12.Playing = true
		local v_u_13 = v_u_3:FindFirstChild("ColorCorrection")
		if not v_u_13 then
			v_u_13 = Instance.new("ColorCorrectionEffect")
			v_u_13.Parent = v_u_3
		end
		local v_u_14 = {
			["R"] = 255,
			["G"] = 255,
			["B"] = 255
		}
		local v_u_15 = nil
		local v_u_16 = "Exclude"
		local v_u_17 = nil
		local v_u_18 = 1
		local v_u_19 = 0.25
		v_u_6(v_u_2.RenderStepped:Connect(function(p20)
			-- upvalues: (ref) v_u_15, (ref) v_u_17, (copy) v_u_14, (ref) v_u_16, (ref) v_u_18, (ref) v_u_19, (ref) v_u_13
			local v21 = workspace.CurrentCamera
			if not v_u_15 then
				v_u_17 = -1
				local v22 = {}
				for v23, _ in v_u_14 do
					table.insert(v22, v23)
				end
				if math.random(1, 2) == 1 then
					v_u_16 = "Exclude"
				else
					v_u_16 = "Include"
				end
				v_u_15 = v22[math.random(#v22)]
			end
			local v24 = v_u_18 + v_u_17 * 0.4705882352941176 * p20
			v_u_18 = math.clamp(v24, 0.9, 1)
			v21.CFrame = v21.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, v_u_18)
			local v25 = v_u_19 + v_u_17 * -1 * 3.5294117647058822 * p20
			v_u_19 = math.clamp(v25, 0.25, 1)
			if v_u_16 == "Exclude" then
				for v26, v27 in v_u_14 do
					if v26 ~= v_u_15 then
						local v28 = v_u_14
						local v29 = v27 + v_u_17 * 1200 * p20
						v28[v26] = math.clamp(v29, 0, 255)
					end
				end
				for v30, v31 in v_u_14 do
					if v30 ~= v_u_15 then
						if v31 <= 0 then
							v_u_17 = 1
						elseif v31 >= 255 then
							v_u_17 = -1
							v_u_15 = nil
						end
					end
				end
			else
				local v32 = v_u_14
				local v33 = v_u_15
				local v34 = v_u_14[v_u_15] + v_u_17 * 1200 * p20
				v32[v33] = math.clamp(v34, 0, 255)
				if v_u_14[v_u_15] <= 0 then
					v_u_17 = 1
				elseif v_u_14[v_u_15] >= 255 then
					v_u_17 = -1
					v_u_15 = nil
				end
			end
			v_u_13.TintColor = Color3.fromRGB(v_u_14.R, v_u_14.G, v_u_14.B)
			v_u_13.Saturation = v_u_19
		end))
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u_3, (copy) v_u_35
	v_u_3:WaitForChild("ColorCorrection", 10)
	v_u_35()
end)
v_u_5.Signals.Variables.PartyModeEnabled:Connect(v_u_35)
return {}