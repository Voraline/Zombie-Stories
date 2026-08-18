local v_u_1 = game:GetService("SoundService")
local v_u_2 = Instance.new("Folder")
v_u_2.Name = "SoundHolder"
v_u_2.Parent = workspace.Ignore
return {
	["SoundCache"] = {},
	["CreateSound"] = function(_, p3) -- name: CreateSound
		-- upvalues: (copy) v_u_2
		if p3 then
			local v4 = Instance.new("Sound")
			local v5
			if typeof(p3) == "table" then
				v5 = p3.SoundId or ""
				local v6 = p3.Volume
				v4.Volume = math.min(v6, 0.75)
				v4.PlaybackRegionsEnabled = p3.PlaybackStart ~= nil
				if v4.PlaybackRegionsEnabled then
					v4.PlaybackRegion = NumberRange.new(p3.PlaybackStart, 999999)
				end
			else
				v5 = p3
			end
			v4.SoundId = (string.find(v5, "rbxassetid://") and "" or "rbxassetid://") .. v5
			v4.Parent = v_u_2
			for _, v7 in script.Effects:GetChildren() do
				v7:Clone().Parent = v4
			end
			return {
				["Sound"] = v4
			}
		end
	end,
	["CreateSoundGroup"] = function(p8, p9) -- name: CreateSoundGroup
		local v10 = {
			["SFX"] = nil,
			["SoundIndex"] = 1,
			["SFX"] = {}
		}
		local v11
		if typeof(p9) == "table" then
			v11 = p9.SoundId or p9
		else
			v11 = p9
		end
		for _ = 1, 15 do
			local v12 = p8:CreateSound(p9)
			local v13 = v10.SFX
			table.insert(v13, v12)
		end
		p8.SoundCache[v11] = v10
	end,
	["PlaySound"] = function(p14, p15, p16) -- name: PlaySound
		-- upvalues: (copy) v_u_2, (copy) v_u_1
		if p15 then
			local v17
			if typeof(p15) == "table" then
				v17 = p15.SoundId or p15
			else
				v17 = p15
			end
			if not p14.SoundCache[v17] then
				p14:CreateSoundGroup(p15)
			end
			local v18 = p14.SoundCache[v17]
			local v_u_19 = v18.SFX[v18.SoundIndex]
			v_u_19.Sound.Pitch = 1 + math.random(-100, 100) * 0.001
			v18.SoundIndex = v18.SoundIndex % #v18.SFX + 1
			if p16 then
				local v_u_20 = Instance.new("Attachment")
				v_u_20.Position = p16
				v_u_20.Parent = workspace.Terrain
				v_u_19.Sound.Parent = v_u_20
				v_u_19.Sound:Play()
				task.delay(5, function()
					-- upvalues: (copy) v_u_19, (copy) v_u_20, (ref) v_u_2
					if v_u_19.Sound.Parent == v_u_20 then
						v_u_19.Sound.Parent = v_u_2
					end
					v_u_20:Destroy()
				end)
			else
				v_u_19.Sound.Parent = v_u_2
				v_u_1:PlayLocalSound(v_u_19.Sound)
			end
		else
			return
		end
	end
}