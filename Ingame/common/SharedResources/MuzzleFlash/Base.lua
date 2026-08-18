local v1 = {}
local function v_u_17(p2, p3) -- name: changeColorSequenceHue
	if not p3 then
		return p2
	end
	local v4 = {}
	for _, v5 in ipairs(p2.Keypoints) do
		local v6 = v5.Value
		if p3 then
			local v7, v8, v9 = v6:ToHSV()
			local v10 = Color3.fromHSV
			if p3.X ~= 0 then
				v7 = p3.X or v7
			end
			local v11 = math.clamp(v7, 0, 1)
			local v12 = v8 + p3.Y
			local v13 = math.clamp(v12, 0, 1)
			local v14 = v9 + p3.Z
			v6 = v10(v11, v13, (math.clamp(v14, 0, 1)))
		end
		local v15 = ColorSequenceKeypoint.new
		local v16 = v5.Time
		table.insert(v4, v15(v16, v6))
	end
	return ColorSequence.new({ unpack(v4) })
end
function v1.Emit(_, p_u_18) -- name: Emit
	-- upvalues: (copy) v_u_17
	local v_u_19 = p_u_18.BarrelAttachment.MuzzleModuleFX
	if not p_u_18.MuzzleEffects then
		p_u_18.MuzzleEffects = v_u_19:GetChildren()
		local v20 = p_u_18.Model:GetAttribute("HSVChanges")
		for _, v21 in p_u_18.MuzzleEffects do
			if v21:IsA("Light") then
				v21.Parent = v21.Parent.Parent
				local v22 = v21.Color
				if v20 then
					local v23, v24, v25 = v22:ToHSV()
					local v26 = Color3.fromHSV
					if v20.X ~= 0 then
						v23 = v20.X or v23
					end
					local v27 = math.clamp(v23, 0, 1)
					local v28 = v24 + v20.Y
					local v29 = math.clamp(v28, 0, 1)
					local v30 = v25 + v20.Z
					v22 = v26(v27, v29, (math.clamp(v30, 0, 1)))
				end
				v21.Color = v22
			elseif v21:IsA("ParticleEmitter") or (v21:IsA("Beam") or v21:IsA("Trail")) then
				v21.Color = v_u_17(v21.Color, v20)
			end
		end
	end
	if not p_u_18.MuzzleTimesShot then
		p_u_18.MuzzleTimesShot = 0
	end
	p_u_18.MuzzleTimesShot = p_u_18.MuzzleTimesShot + 1
	local v31 = math.random(1, 100)
	for _, v32 in p_u_18.MuzzleEffects do
		if (v32.Name:sub(1, 7) == "FlashFX" or v32.Name:sub(1, 5) == "Smoke") and not v32:IsA("Beam") then
			if p_u_18.MuzzleTimesShot >= math.random(3, 6) and v32.Name:sub(1, 7) == "FlashFX" then
				p_u_18.MuzzleTimesShot = 0
			else
				v32.Enabled = true
			end
		elseif (v32.Name:sub(1, 7) == "FlashFX" or v32.Name:sub(1, 5) == "Smoke") and (v32:IsA("Beam") and v31 <= 25) then
			v32.Enabled = true
		end
	end
	local v_u_33 = p_u_18.MuzzleEffects
	task.delay(0.03333333333333333, function()
		-- upvalues: (copy) v_u_33, (copy) p_u_18, (copy) v_u_19
		for _, v34 in v_u_33 do
			if v34.Name:sub(1, 7) == "FlashFX" or v34.Name:sub(1, 5) == "Smoke" then
				v34.Enabled = false
			end
		end
		local v35 = os.clock()
		p_u_18.LastShot = v35
		if v_u_19.Parent then
			local v36 = v_u_19.Trail
			v36.Enabled = false
			task.wait(0.3)
			if p_u_18.LastShot == v35 then
				v36.Enabled = true
				task.wait(1.25)
				if p_u_18.LastShot == v35 then
					v36.Enabled = false
				end
			end
		end
	end)
end
return v1