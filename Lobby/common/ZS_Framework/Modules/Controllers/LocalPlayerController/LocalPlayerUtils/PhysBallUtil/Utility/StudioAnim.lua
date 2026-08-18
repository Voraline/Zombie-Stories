game:GetService("RunService")
local v_u_1 = game:GetService("KeyframeSequenceProvider")
return function(p2)
	-- upvalues: (copy) v_u_1
	local v3 = next
	local v4, v5 = p2:GetChildren()
	for _, v6 in v3, v4, v5 do
		local v7 = v6:FindFirstChildWhichIsA("KeyframeSequence")
		if v7 then
			v6.AnimationId = v_u_1:RegisterKeyframeSequence(v7)
		end
	end
end