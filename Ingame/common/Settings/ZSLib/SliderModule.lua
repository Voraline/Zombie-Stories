local v_u_1 = game:GetService("UserInputService")
local v_u_2 = game:GetService("RunService")
local v3 = {}
local v_u_4 = {}
v_u_4.__index = v_u_4
function v3.new(p_u_5, p6, p7, p8, p9, p10)
	-- upvalues: (copy) v_u_4
	local v11 = v_u_4
	local v_u_12 = setmetatable({}, v11)
	local v13 = p9.min
	assert(v13, "sliderConfigurations need a min variable.")
	local v14 = p9.max
	assert(v14, "sliderConfigurations need a max variable.")
	local v15 = p9.snapFactor
	assert(v15, "sliderConfigurations need a snapFactor variable.")
	local v16 = p_u_5.AnchorPoint == Vector2.new(0.5, 0.5)
	local v17 = "Set the AnchorPoint of " .. p_u_5.Name .. " to (0.5, 0.5)"
	assert(v16, v17)
	local v18 = p7:IsDescendantOf(p6)
	assert(v18, "SliderButton needs to be a descendant of sliderMarker.")
	v_u_12.slidingBase = p_u_5
	v_u_12.sliderMarker = p6
	v_u_12.sliderButton = p7
	v_u_12.sliderFill = p8
	v_u_12.min = p9.min
	v_u_12.max = p9.max
	v_u_12.snapFactor = p9.snapFactor
	local v19 = p_u_5.AbsoluteSize
	local v20 = workspace.CurrentCamera.ViewportSize
	local v21 = UDim2.new(v19.X / v20.X, 0, v19.Y / v20.Y, 0)
	local v22 = p_u_5.AbsolutePosition
	local v23 = workspace.CurrentCamera.ViewportSize
	local v24 = UDim2.new(v22.X / v23.X, 0, (v22.Y + 36) / v23.Y, 0)
	p_u_5.Changed:Connect(function()
		-- upvalues: (copy) p_u_5, (copy) v_u_12
		local v25 = p_u_5.AbsoluteSize
		local v26 = workspace.CurrentCamera.ViewportSize
		local v27 = UDim2.new(v25.X / v26.X, 0, v25.Y / v26.Y, 0)
		local v28 = p_u_5.AbsolutePosition
		local v29 = workspace.CurrentCamera.ViewportSize
		local v30 = UDim2.new(v28.X / v29.X, 0, (v28.Y + 36) / v29.Y, 0)
		v_u_12.firstPartPos = UDim2.new(v30.X.Scale, 0, v30.Y.Scale, 0)
		v_u_12.lineSize = v27.X.Scale
	end)
	v_u_12.firstPartPos = UDim2.new(v24.X.Scale, 0, v24.Y.Scale, 0)
	v_u_12.lineSize = v21.X.Scale
	if p10 then
		v_u_12.TargetTextLabel = p10.TextBox
		v_u_12.TargetTextBox = p10.TextBox
		if p10.TextLabel then
			v_u_12.TargetTextLabel = p10.TextLabel
		end
	end
	v_u_12.InteractionBegan = Instance.new("BindableEvent")
	v_u_12.InteractionEnded = Instance.new("BindableEvent")
	v_u_12.ValueChanged = Instance.new("BindableEvent")
	return v_u_12
end
function v_u_4.Activate(p_u_31) -- name: Activate
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v_u_32 = nil
	local v_u_33 = 0
	p_u_31.sliderButton.MouseButton1Down:Connect(function()
		-- upvalues: (copy) p_u_31, (ref) v_u_32, (ref) v_u_2, (ref) v_u_1, (ref) v_u_33
		p_u_31.InteractionBegan:Fire()
		v_u_32 = v_u_2.RenderStepped:Connect(function()
			-- upvalues: (ref) v_u_1, (ref) v_u_32, (ref) p_u_31, (ref) v_u_33
			if v_u_1:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
				local v34 = workspace.Camera.ViewportSize.X
				local v35 = (v_u_1:GetMouseLocation().X - p_u_31.firstPartPos.X.Scale * v34) / v34
				local v36 = p_u_31.lineSize
				local v37 = math.clamp(v35, 0, v36)
				if v37 > 0 then
					if v37 < 1 then
						local v38 = p_u_31.sliderMarker
						local v39 = UDim2.new
						local v40 = p_u_31
						local v41 = v37 / p_u_31.lineSize / v40.snapFactor
						local v42 = math.floor(v41) * v40.snapFactor
						v38.Position = v39(math.clamp(v42, 0, 1), 0, p_u_31.sliderMarker.Position.Y.Scale, 0)
						local v43 = p_u_31.sliderFill
						local v44 = UDim2.new
						local v45 = p_u_31
						local v46 = v37 / p_u_31.lineSize / v45.snapFactor
						local v47 = math.floor(v46) * v45.snapFactor
						v43.Size = v44(math.clamp(v47, 0, 1), 0, p_u_31.sliderFill.Size.Y.Scale, 0)
						local v48 = p_u_31
						local v49 = p_u_31
						local v50 = p_u_31
						local v51 = v37 / p_u_31.lineSize / v50.snapFactor
						local v52 = math.floor(v51) * v50.snapFactor
						local v53 = math.clamp(v52, 0, 1)
						local v54 = 1 / v49.snapFactor
						local v55 = (v49.max - v49.min) / v54 * (v53 / v49.snapFactor) * 100
						v48.CurrentValue = math.round(v55) / 100 + v49.min
						if p_u_31.TargetTextLabel then
							local v56 = p_u_31.TargetTextLabel
							local v57 = p_u_31.CurrentValue
							v56.Text = string.format("%.2f", v57)
						end
						if v_u_33 ~= p_u_31.CurrentValue then
							v_u_33 = p_u_31.CurrentValue
							p_u_31.ValueChanged:Fire(p_u_31.CurrentValue)
							return
						end
					end
				else
					p_u_31.sliderMarker.Position = UDim2.new(0, 0, p_u_31.sliderMarker.Position.Y.Scale, 0)
					p_u_31.sliderFill.Size = UDim2.new(0, 0, p_u_31.sliderFill.Size.Y.Scale, 0)
					local v58 = p_u_31
					local v59 = p_u_31
					local v60 = p_u_31
					local v61 = v37 / p_u_31.lineSize / v60.snapFactor
					local v62 = math.floor(v61) * v60.snapFactor
					local v63 = math.clamp(v62, 0, 1)
					local v64 = 1 / v59.snapFactor
					local v65 = (v59.max - v59.min) / v64 * (v63 / v59.snapFactor) * 100
					v58.CurrentValue = math.round(v65) / 100 + v59.min
					if p_u_31.TargetTextLabel then
						local v66 = p_u_31.TargetTextLabel
						local v67 = p_u_31.CurrentValue
						v66.Text = string.format("%.2f", v67)
					end
				end
			else
				v_u_32:Disconnect()
				p_u_31.InteractionEnded:Fire(p_u_31.CurrentValue)
			end
		end)
	end)
	local function v_u_78(p68) -- name: update
		-- upvalues: (copy) p_u_31
		local v69 = p_u_31.TargetTextBox.Text
		local v70 = tonumber(v69)
		if p68 then
			p_u_31.TargetTextBox.Text = string.format("%.2f", p68)
		else
			p68 = v70
		end
		if p68 then
			local v71 = p_u_31
			local v72 = p_u_31.min
			local v73 = math.max(v72, p68)
			local v74 = p_u_31.max
			v71.CurrentValue = math.min(v73, v74)
			local v75 = p_u_31.TargetTextBox
			local v76 = p_u_31.CurrentValue
			v75.Text = string.format("%.2f", v76)
			local v77 = (p_u_31.CurrentValue - p_u_31.min) / (p_u_31.max - p_u_31.min)
			p_u_31.sliderMarker.Position = UDim2.new(v77, 0, p_u_31.sliderMarker.Position.Y.Scale, 0)
			p_u_31.sliderFill.Size = UDim2.new(v77, 0, p_u_31.sliderFill.Size.Y.Scale, 0)
		end
	end
	p_u_31.TargetTextBox.FocusLost:Connect(function(p79)
		-- upvalues: (copy) v_u_78, (copy) p_u_31
		if p79 then
			v_u_78()
			p_u_31.InteractionEnded:Fire(p_u_31.CurrentValue)
		end
	end)
	v_u_78()
	return v_u_78
end
return v3