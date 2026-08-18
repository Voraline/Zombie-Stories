local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v3 = v1.common
local v_u_4 = require(v3:WaitForChild("WepConfig"))
local v_u_5 = require(v3:WaitForChild("Signal"))
return {
	["onClick"] = function(p6, p7, p8) -- name: onClick
		-- upvalues: (copy) v_u_2
		local v_u_9 = Instance.new("ImageLabel")
		v_u_9.Name = "circle"
		v_u_9.Image = "rbxassetid://4175209485"
		v_u_9.BackgroundTransparency = 1
		v_u_9.AnchorPoint = Vector2.new(0.5, 0.5)
		v_u_9.Position = UDim2.new(0, p7 - p6.AbsolutePosition.X, 0, p8 - p6.AbsolutePosition.Y - 36)
		v_u_9.Size = UDim2.new(0, 0, 0, 0)
		v_u_9.ZIndex = p6.ZIndex
		v_u_9.ImageTransparency = 0.75
		v_u_9.Parent = p6
		local v10 = p6.AbsoluteSize.X
		local v11 = p6.AbsoluteSize.Y
		local v12 = math.max(v10, v11) * 2.2
		local v13 = v_u_2:Create(v_u_9, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["Size"] = nil,
			["ImageTransparency"] = 1,
			["Size"] = UDim2.new(0, v12, 0, v12)
		})
		v13.Completed:Connect(function()
			-- upvalues: (copy) v_u_9
			v_u_9:Destroy()
		end)
		v13:Play()
	end,
	["clickEvent"] = function(p_u_14, p15, p16) -- name: clickEvent
		-- upvalues: (copy) v_u_2, (copy) v_u_5
		local v_u_17 = p15 or p_u_14.ZIndex
		p_u_14.ClipsDescendants = true
		if not p16 then
			p_u_14.MouseButton1Down:Connect(function(p18, p19)
				-- upvalues: (copy) p_u_14, (ref) v_u_17, (ref) v_u_2
				local v_u_20 = Instance.new("ImageLabel")
				v_u_20.Name = "circle"
				v_u_20.Image = "rbxassetid://4175209485"
				v_u_20.BackgroundTransparency = 1
				v_u_20.AnchorPoint = Vector2.new(0.5, 0.5)
				v_u_20.Position = UDim2.new(0, p18 - p_u_14.AbsolutePosition.X, 0, p19 - p_u_14.AbsolutePosition.Y - 36)
				v_u_20.Size = UDim2.new(0, 0, 0, 0)
				v_u_20.ZIndex = v_u_17
				v_u_20.ImageTransparency = 0.75
				v_u_20.Parent = p_u_14
				local v21 = p_u_14.AbsoluteSize.X
				local v22 = p_u_14.AbsoluteSize.Y
				local v23 = math.max(v21, v22) * 2.2
				local v24 = v_u_2:Create(v_u_20, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["Size"] = nil,
					["ImageTransparency"] = 1,
					["Size"] = UDim2.new(0, v23, 0, v23)
				})
				v24.Completed:Connect(function()
					-- upvalues: (copy) v_u_20
					v_u_20:Destroy()
				end)
				v24:Play()
			end)
		end
		local v_u_25 = v_u_5.new()
		local v26 = p_u_14.MouseEnter
		local v27 = p_u_14.MouseLeave
		local v28 = Instance.new("BindableEvent")
		p_u_14.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_25
			v_u_25:Fire()
		end)
		return v_u_25, v26, v27, v28
	end,
	["drawLine"] = function(p29, p30, p31, p32) -- name: drawLine
		local v33 = p30 - p29
		if not p32 then
			p32 = Instance.new("Frame", p31)
			p32.Name = "Line"
		end
		p32.AnchorPoint = Vector2.new(0.5, 0.5)
		p32.BackgroundColor3 = Color3.fromRGB(255, 145, 35)
		p32.BorderSizePixel = 0
		p32.ZIndex = -1
		local v34 = v33.Y
		local v35 = v33.X
		p32.Rotation = math.atan2(v34, v35) * 57.29577951308232
		p32.Position = UDim2.fromOffset((p30 + p29).X / 2, (p30 + p29).Y / 2)
		p32.Size = UDim2.fromOffset((v33.X ^ 2 + v33.Y ^ 2) ^ 0.5, 1)
		return p32
	end,
	["moddingFuncs"] = function() -- name: moddingFuncs
		-- upvalues: (copy) v_u_4, (copy) v_u_2
		local v_u_36 = workspace.CurrentCamera
		local function v42(p37) -- name: getModel
			-- upvalues: (ref) v_u_4
			local v38 = v_u_4:StreamViewmodel(p37):expect()
			if not v38.PrimaryPart then
				v38.PrimaryPart = v38:WaitForChild("HumanoidRootPart")
			end
			local v39 = v38:WaitForChild("KeyParts", 5)
			local v40
			if v39 then
				v40 = v39:WaitForChild("ViewCenter", 5)
			else
				v40 = v39
			end
			if v40 then
				v39 = v40
			elseif v39 then
				v39 = v39:WaitForChild("Handle", 5)
			end
			if v39 then
				local v41 = v39.CFrame
				v38.PrimaryPart.PivotOffset = v38.PrimaryPart.CFrame:ToObjectSpace(v41)
			end
			return v38
		end
		local v_u_43 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		return v42, function(p44, _, _) -- name: calcGunRotationAxisAngle
			-- upvalues: (copy) v_u_36
			local v45 = v_u_36.CFrame.Rotation
			local v46 = -p44.Y
			local v47 = p44.X
			local v48 = math.atan2(v46, v47)
			return (v45 * CFrame.Angles(0, 0, v48 + 1.5707963267948966)).RightVector, p44.Magnitude * 0.015
		end, function(p49) -- name: updateFOV
			-- upvalues: (ref) v_u_2, (copy) v_u_36, (copy) v_u_43
			v_u_2:Create(v_u_36, v_u_43, {
				["FieldOfView"] = 20 + 80 * p49
			}):Play()
		end
	end
}