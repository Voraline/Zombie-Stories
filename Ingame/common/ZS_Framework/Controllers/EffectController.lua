local v1 = {
	["Effects"] = {}
}
for v2, v3 in script.Parent.Parent.Effects:GetChildren() do
	if v3:IsA("ModuleScript") then
		local v4 = require(v3)
		v1.Effects[v2] = v4
	end
end
return v1