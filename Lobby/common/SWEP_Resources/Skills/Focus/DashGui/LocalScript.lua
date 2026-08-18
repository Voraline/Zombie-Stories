local v_u_1 = game:GetService("TweenService")
local v_u_2 = script.Parent:WaitForChild("DashLineTemplate")
local v_u_3 = script.Parent
local v_u_4 = v_u_3:WaitForChild("DashLineFrame")
local v_u_5 = Random.new()
local function v_u_11(p6, p7) -- name: chooseEdgePoint
	-- upvalues: (copy) v_u_5
	local v8 = v_u_5:NextInteger(1, p6 * 2 + p7 * 2)
	for v9 = 1, 4 do
		local v10
		if v9 % 2 == 0 then
			v10 = p7
		else
			v10 = p6
		end
		if v8 <= v10 then
			if v9 == 1 then
				return Vector2.new(v8, 0)
			elseif v9 == 2 then
				return Vector2.new(p6, v8)
			elseif v9 == 3 then
				return Vector2.new(p6 - v8, p7)
			else
				return Vector2.new(0, p7 - v8)
			end
		end
		v8 = v8 - v10
	end
end
local v_u_12 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
game:GetService("RunService").RenderStepped:Connect(function()
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_11, (copy) v_u_5, (copy) v_u_4, (copy) v_u_1, (copy) v_u_12
	if script.Parent.On.Value then
		local v13 = v_u_3.AbsoluteSize.X
		local v14 = v_u_3.AbsoluteSize.Y
		local v_u_15 = v_u_2:Clone()
		local v16 = v_u_11(v13, v14)
		local v17 = v16 - Vector2.new(v13 * 0.5, v14 * 0.5)
		local v18 = v17.Unit
		local v19 = v17.Y
		local v20 = v17.X
		local v21 = math.atan2(v19, v20)
		v_u_15.Rotation = math.deg(v21) - 90
		local v22 = v17.Magnitude * 0.5 * v_u_5:NextNumber(0.7, 1.3)
		v_u_15.Size = UDim2.new(0, v22 * 0.05, 0, v22)
		local v23 = v16 - v18 * v22 * 0.4
		local v24 = v16 + v18 * v22 * 0.4
		v_u_15.Position = UDim2.new(0, v23.X, 0, v23.Y)
		v_u_15.Parent = v_u_4
		local v25 = {
			["ImageTransparency"] = 0.3,
			["Position"] = nil,
			["Position"] = UDim2.new(0, v16.X, 0, v16.Y)
		}
		local v_u_26 = {
			["ImageTransparency"] = 1,
			["Position"] = nil,
			["Position"] = UDim2.new(0, v24.X, 0, v24.Y)
		}
		local v27 = v_u_1:Create(v_u_15, v_u_12, v25)
		v27:Play()
		v27.Completed:Connect(function()
			-- upvalues: (ref) v_u_1, (copy) v_u_15, (ref) v_u_12, (copy) v_u_26
			local v28 = v_u_1:Create(v_u_15, v_u_12, v_u_26)
			v28:Play()
			v28.Completed:Connect(function()
				-- upvalues: (ref) v_u_15
				v_u_15:Destroy()
			end)
		end)
	end
end)