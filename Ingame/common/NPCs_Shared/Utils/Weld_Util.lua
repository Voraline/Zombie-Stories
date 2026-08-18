return { function(p1, p2, p3, p4, p5) -- name: WeldTogether
		local v6 = Instance.new(p3)
		v6.Name = p1.Name .. ":" .. p2.Name
		v6.Part0 = p1
		v6.Part1 = p2
		if not p5 then
			v6.C0 = v6.Part0.CFrame:Inverse() * v6.Part1.CFrame
		end
		v6.Parent = p4 or p1
		return v6
	end, function(p7, p8, p9) -- name: WeldAllToBase
		local v10 = {}
		for _, v11 in pairs(p7:GetChildren()) do
			if v11:IsA("BasePart") and (not v10[v11] and v11 ~= p8) then
				v11.Anchored = false
				v11.CanCollide = false
				v11.CanTouch = false
				v11.CanQuery = false
				v10[v11] = true
			end
			for _, v12 in pairs(v11:GetDescendants()) do
				if v12:IsA("BasePart") and (not v10[v12] and (not v10[v12] and v12 ~= p8)) then
					v12.Anchored = false
					v12.CanCollide = false
					v12.CanTouch = false
					v12.CanQuery = false
					v10[v12] = true
				end
			end
		end
		for v13, _ in pairs(v10) do
			local v14 = Instance.new("Weld")
			v14.Name = p8.Name .. ":" .. v13.Name
			v14.Part0 = p8
			v14.Part1 = v13
			if not p9 then
				v14.C0 = v14.Part0.CFrame:Inverse() * v14.Part1.CFrame
			end
			v14.Parent = p8
		end
	end }