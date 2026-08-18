local v1 = game:GetService("ReplicatedFirst")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("ServerScriptService")
local v4 = game:GetService("ServerStorage")
local v_u_5 = {
	script.Parent.Parent,
	v1,
	v2,
	v3,
	v4
}
return function() -- name: GetPromiseLibrary
	-- upvalues: (copy) v_u_5
	local v6 = script:FindFirstAncestorOfClass("Plugin")
	if v6 then
		local v7 = v6:QueryDescendants("ModuleScript#Promise")
		local v8
		if #v7 > 0 then
			v8 = v7[1]
		else
			v8 = nil
		end
		if v8 then
			return true, require(v8)
		else
			return false
		end
	else
		local v9 = nil
		for _, v10 in ipairs(v_u_5) do
			local v11 = v10:QueryDescendants("ModuleScript#Promise")
			if #v11 > 0 then
				v9 = v11[1]
			else
				v9 = nil
			end
			if v9 then
				break
			end
		end
		if v9 then
			return true, require(v9)
		else
			return false
		end
	end
end