workspace:WaitForChild("Ignore")
local v_u_1 = game:GetService("TweenService")
local v_u_2 = nil
local v_u_3 = nil
local v_u_4 = nil
local v_u_50 = {
	["Arms"] = nil,
	["ArmOwners"] = {
		["Left"] = nil,
		["Right"] = nil
	},
	["Hide"] = function(p5, p6) -- name: Hide
		-- upvalues: (ref) v_u_2, (copy) v_u_1
		if v_u_2 then
			local v7 = p5.ArmOwners.Left == p6
			local v8 = p5.ArmOwners.Right == p6
			local v9 = p6.PrimaryPart.CFrame:ToObjectSpace(v_u_2.LeftShoulder.Part0.CFrame)
			if v7 then
				v_u_2.LeftWeld.Enabled = false
				local v10 = v_u_2.LeftShoulderC0
				v_u_2.LeftShoulder.C0 = v_u_2.LeftShoulder.Part0.CFrame:Inverse() * p6.PrimaryPart.CFrame * v9
				local v11 = v_u_2.LeftShoulder.Part0.CFrame:toWorldSpace(CFrame.new(v_u_2.LeftShoulder.C0.Position))
				v_u_2.LeftShoulder.C0 = v_u_2.LeftShoulder.C0 * CFrame.Angles(-1.5707963267948966, 0, 0)
				local v12 = CFrame.lookAt(v11.Position, v_u_2.LeftShoulder.Part0.CFrame.Position, v_u_2.Left.CFrame.UpVector) * CFrame.Angles(1.5707963267948966, 0, 0)
				v_u_2.LeftShoulder.C0 = v_u_2.LeftShoulder.Part0.CFrame:toObjectSpace(v12)
				v_u_2.LeftShoulder.Enabled = true
				v_u_1:Create(v_u_2.LeftShoulder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["C0"] = v10
				}):Play()
				p5.ArmOwners.Left = nil
			end
			if v8 then
				v_u_2.RightWeld.Enabled = false
				local v13 = v_u_2.RightShoulderC0
				v_u_2.RightShoulder.C0 = v_u_2.RightShoulder.Part0.CFrame:Inverse() * p6.PrimaryPart.CFrame * v9
				local v14 = v_u_2.RightShoulder.Part0.CFrame:toWorldSpace(CFrame.new(v_u_2.RightShoulder.C0.Position))
				v_u_2.RightShoulder.C0 = v_u_2.RightShoulder.C0 * CFrame.Angles(-1.5707963267948966, 0, 0)
				local v15 = CFrame.lookAt(v14.Position, v_u_2.RightShoulder.Part0.CFrame.Position, v_u_2.Right.CFrame.UpVector) * CFrame.Angles(1.5707963267948966, 0, 0)
				v_u_2.RightShoulder.C0 = v_u_2.RightShoulder.Part0.CFrame:toObjectSpace(v15)
				v_u_2.RightShoulder.Enabled = true
				v_u_1:Create(v_u_2.RightShoulder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["C0"] = v13
				}):Play()
				p5.ArmOwners.Right = nil
			end
		end
	end,
	["Show"] = function(p16, p17) -- name: Show
		-- upvalues: (ref) v_u_3, (ref) v_u_4, (ref) v_u_2, (copy) v_u_50
		v_u_3 = p17
		local v18 = p17["Left Arm"]
		local v19 = v18.Size.Y > 3
		local v20 = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
		if v20 ~= v_u_4 then
			v_u_4 = v20
			if v_u_2 then
				v_u_2.LeftWeld:Destroy()
				v_u_2.RightWeld:Destroy()
				v_u_2.LeftShoulder.Enabled = true
				v_u_2.RightShoulder.Enabled = true
				v_u_2 = nil
				v_u_50.Arms = nil
			end
			p16.ArmOwners.Left = nil
			p16.ArmOwners.Right = nil
		end
		if v_u_3 ~= p17 then
			return
		end
		if not v_u_2 then
			local v21 = v_u_4:WaitForChild("Left Arm", 5)
			if not v21 then
				return
			end
			local v22 = v_u_4:WaitForChild("Right Arm", 5)
			if not v22 then
				return
			end
			local v23 = v_u_4:WaitForChild("Torso", 5)
			if not v23 then
				return
			end
			local v24 = v23:WaitForChild("Left Shoulder", 5)
			local v25 = v23:WaitForChild("Right Shoulder", 5)
			if v_u_3 ~= p17 or not (v_u_4.Parent and (v24 and v25)) then
				return
			end
			local v26 = {}
			local v27 = Instance.new("Motor6D")
			v27.Part1 = v21
			v27.Parent = v21
			local v28 = Instance.new("Motor6D")
			v28.Part1 = v22
			v28.Parent = v22
			v26.LeftWeld = v27
			v26.RightWeld = v28
			v26.LeftShoulder = v24
			v26.RightShoulder = v25
			v26.LeftShoulderC0 = v24.C0
			v26.RightShoulderC0 = v25.C0
			v26.Left = v21
			v26.Right = v22
			v_u_2 = v26
		end
		for _, v29 in v18.Parent:QueryDescendants("Motor6D") do
			if v29.Part1 == v18 then
				v_u_2.OGLArmWeld = v29
				break
			end
		end
		v_u_2.LeftShoulder.Enabled = false
		v_u_2.RightShoulder.Enabled = false
		v_u_2.LeftWeld.Enabled = true
		v_u_2.RightWeld.Enabled = true
		v_u_2.LeftWeld.Part0 = v18
		v_u_2.RightWeld.Part0 = p17:WaitForChild("Right Arm")
		v_u_2.MoveCF = v19
		v_u_2.LeftWeld.C1 = v19 and CFrame.new(0, 1, 0) or CFrame.new()
		v_u_2.RightWeld.C1 = v19 and CFrame.new(0, 1, 0) or CFrame.new()
		v_u_50.Arms = v_u_2
		p16.ArmOwners.Left = p17
		p16.ArmOwners.Right = p17
		return v_u_2
	end,
	["SetArmOwner"] = function(p30, p31, p32) -- name: SetArmOwner
		-- upvalues: (ref) v_u_2
		if v_u_2 then
			p30.ArmOwners[p31] = p32
			if p31 == "Left" then
				local v33 = p32:FindFirstChild("Left Arm") or p32:FindFirstChild("Left Arm", true)
				if v33 then
					v_u_2.LeftWeld.Part0 = v33
					local v34 = v33.Size.Y > 3
					v_u_2.LeftWeld.C1 = v34 and CFrame.new(0, 1, 0) or CFrame.new()
					return
				end
			else
				local v35 = p31 == "Right" and (p32:FindFirstChild("Right Arm") or p32:FindFirstChild("Right Arm", true))
				if v35 then
					v_u_2.RightWeld.Part0 = v35
					local v36 = v35.Size.Y > 3
					v_u_2.RightWeld.C1 = v36 and CFrame.new(0, 1, 0) or CFrame.new()
				end
			end
		end
	end,
	["OwnsArm"] = function(p37, p38, p39) -- name: OwnsArm
		return p37.ArmOwners[p39] == p38
	end,
	["GetArmOwner"] = function(p40, p41) -- name: GetArmOwner
		return p40.ArmOwners[p41]
	end,
	["ReleaseArm"] = function(p42, p43) -- name: ReleaseArm
		p42.ArmOwners[p43] = nil
	end,
	["ShowForArms"] = function(p44, p45, p46, p47) -- name: ShowForArms
		-- upvalues: (ref) v_u_2, (ref) v_u_4, (copy) v_u_50
		if v_u_2 and game.Players.LocalPlayer.Character ~= v_u_4 then
			v_u_2 = nil
			v_u_50.Arms = nil
		end
		if not v_u_2 then
			p44:Show(p45)
			if not p46 then
				p44.ArmOwners.Left = nil
			end
			if not p47 then
				p44.ArmOwners.Right = nil
			end
			return v_u_2
		end
		if p46 then
			p44:SetArmOwner("Left", p45)
			local v48 = p45:FindFirstChild("Left Arm") or p45:FindFirstChild("Left Arm", true)
			if v48 then
				for _, v49 in v48.Parent:QueryDescendants("Motor6D") do
					if v49.Part1 == v48 then
						v_u_2.OGLArmWeld = v49
						break
					end
				end
			end
		end
		if p47 then
			p44:SetArmOwner("Right", p45)
		end
		return v_u_2
	end
}
return v_u_50