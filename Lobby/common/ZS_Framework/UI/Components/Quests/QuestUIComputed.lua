local v1 = game:GetService("ReplicatedStorage")
require(v1.Packages.Fusion)
return function(p_u_2)
	local v3 = p_u_2.scope
	return v3:Computed(function(p4)
		-- upvalues: (copy) p_u_2
		if p4(p_u_2.Quest.IsCompleted) then
			return Color3.fromRGB(31, 31, 31)
		else
			return Color3.fromRGB(92, 92, 92)
		end
	end), v3:Computed(function(p5)
		-- upvalues: (copy) p_u_2
		return p5(p_u_2.Quest.IsCompleted) and 0.95 or 0.75
	end)
end