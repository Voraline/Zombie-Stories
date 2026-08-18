local v1 = {}
for _, v2 in script:GetChildren() do
	for v3, v4 in require(v2) do
		v1[v3] = v4
	end
end
for v5, _ in pairs(v1) do
	v1[v5].Name = v5
end
return v1