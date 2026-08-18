local v_u_1 = game:GetService("TweenService")
return {
	["Init"] = function(_, p2) -- name: Init
		local v3 = p2.Config
		local v4 = v3.Shooting_Start
		local v5 = Instance.new("Sound")
		for v6, v7 in v4 do
			v5[v6] = v7
		end
		v5.SoundId = (string.find(v5.SoundId, "rbxassetid://") and "" or "rbxassetid://") .. v5.SoundId
		p2.StartSFX = v5
		local v8 = v3.Shooting_Loop
		local v9 = Instance.new("Sound")
		for v10, v11 in v8 do
			v9[v10] = v11
		end
		v9.SoundId = (string.find(v9.SoundId, "rbxassetid://") and "" or "rbxassetid://") .. v9.SoundId
		p2.LoopSFX = v9
		local v12 = v3.Shooting_End
		local v13 = Instance.new("Sound")
		for v14, v15 in v12 do
			v13[v14] = v15
		end
		v13.SoundId = (string.find(v13.SoundId, "rbxassetid://") and "" or "rbxassetid://") .. v13.SoundId
		p2.EndSFX = v13
		repeat
			task.wait()
		until p2.Viewmodel.Model
		local v16 = p2.Viewmodel.Model.KeyParts.Handle
		p2.StartSFX.Parent = v16
		p2.LoopSFX.Parent = v16
		p2.EndSFX.Parent = v16
	end,
	["Start"] = function(_, p17) -- name: Start
		-- upvalues: (copy) v_u_1
		if not p17.LoopSFX_Playing then
			p17.LoopSFX_Playing = true
			p17.LoopSFX.TimePosition = p17.Config.Shooting_Loop.PlaybackRegion and (p17.Config.Shooting_Loop.PlaybackRegion.Min or 0) or 0
			p17.StartSFX.TimePosition = p17.Config.Shooting_Start.PlaybackRegion.Min
			p17.StartSFX.Volume = p17.Config.Shooting_Start.Volume or 0.5
			p17.LoopSFX.Volume = p17.Config.Shooting_Loop.Volume or 0.5
			v_u_1:Create(p17.StartSFX, TweenInfo.new(0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				["Volume"] = p17.StartSFX.Volume
			}):Play()
			v_u_1:Create(p17.LoopSFX, TweenInfo.new(0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				["Volume"] = p17.LoopSFX.Volume
			}):Play()
			p17.LoopSFX:Play()
			p17.StartSFX:Play()
		end
	end,
	["Stop"] = function(_, p18) -- name: Stop
		-- upvalues: (copy) v_u_1
		if p18.LoopSFX_Playing then
			p18.LoopSFX_Playing = false
			v_u_1:Create(p18.StartSFX, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				["Volume"] = 0
			}):Play()
			v_u_1:Create(p18.LoopSFX, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				["Volume"] = 0
			}):Play()
			p18.EndSFX.TimePosition = p18.Config.Shooting_End.PlaybackRegion.Min
			p18.EndSFX:Play()
		end
	end
}