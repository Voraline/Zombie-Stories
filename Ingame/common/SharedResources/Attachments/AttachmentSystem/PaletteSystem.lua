return function(p1, p2)
	for _, v3 in { p1:GetAttribute("attuid3"), p1:GetAttribute("attuid2"), p1:GetAttribute("attuid1") } do
		if v3 and v3 ~= "None" then
			local v4 = nil
			for _, v5 in p1:GetDescendants() do
				if v5:IsA("BasePart") and v5:GetAttribute("uid") == v3 then
					v4 = v5
					break
				end
			end
			if v4 then
				local v6 = {}
				for _, v7 in v4:GetChildren() do
					if v7:IsA("Texture") and not v6[v7.Texture] then
						v6[v7.Texture] = v7
					end
				end
				for _, v8 in p2:GetDescendants() do
					if v8:IsA("BasePart") and v8.Transparency == 0 then
						for _, v9 in v6 do
							for _, v10 in Enum.NormalId:GetEnumItems() do
								local v11 = v9:Clone()
								v11.Face = v10
								local v12 = v11.Transparency
								local v13 = v8.Transparency
								v11.Transparency = v12 + (1 - v12) * v13
								v11.Parent = v8
							end
						end
						v8.Color = v4.Color
						v8.Material = v4.Material
						if v8.Transparency == 0 then
							v8.Transparency = v4.Transparency
						end
						v8.Reflectance = v4.Reflectance
						if v8:IsA("UnionOperation") then
							v8.UsePartColor = true
						end
					end
				end
			end
		end
	end
end