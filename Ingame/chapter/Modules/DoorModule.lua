return {
	["OpenDoor"] = function(_, p1, p2, p3, p4) -- name: OpenDoor
		local v5 = p2 or 1
		local v6 = p3 or Enum.EasingStyle.Quad
		local v7 = p4 or Enum.EasingDirection.Out
		local v8 = p1:GetChildren()
		local v9 = p1:FindFirstChild("OriginalCF")
		local v10 = p1:FindFirstChild("OpenOffset")
		if v10 then
			local v11 = v10.Value
			if not v9 then
				for _, v12 in pairs(v8) do
					if v12:IsA("BasePart") then
						if p1.PrimaryPart then
							local v13 = Instance.new("Weld")
							v13.Part0 = p1.PrimaryPart
							v13.Parent = p1.PrimaryPart
							v13.Part1 = v12
							v13.C0 = p1.PrimaryPart.CFrame:Inverse() * v12.CFrame
							v12.Anchored = false
						else
							p1.PrimaryPart = v12
						end
					end
				end
				v9 = Instance.new("CFrameValue")
				v9.Value = p1.PrimaryPart.CFrame
				v9.Name = "OriginalCF"
				v9.Parent = p1
			end
			local v14 = v9.Value
			game:GetService("TweenService"):Create(p1.PrimaryPart, TweenInfo.new(v5, v6, v7), {
				["CFrame"] = v14 + v11
			}):Play()
		else
			print("Door " .. p1.Name .. " had no open offset")
		end
	end,
	["CloseDoor"] = function(_, p15, p16, p17, p18) -- name: CloseDoor
		local v19 = p16 or 1
		local v20 = p17 or Enum.EasingStyle.Quad
		local v21 = p18 or Enum.EasingDirection.Out
		local v22 = p15:FindFirstChild("OriginalCF")
		if v22 then
			local v23 = {
				["CFrame"] = v22.Value
			}
			game:GetService("TweenService"):Create(p15.PrimaryPart, TweenInfo.new(v19, v20, v21), v23):Play()
		else
			print("Door " .. p15.Name .. " had no original CFrame")
		end
	end
}