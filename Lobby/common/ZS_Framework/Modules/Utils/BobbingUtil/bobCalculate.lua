local v_u_1 = require(script.Parent.Parent.Parent:WaitForChild("Controllers"):WaitForChild("LocalPlayerController"))
return function(p2) -- name: BobCalculate
	-- upvalues: (copy) v_u_1
	local v3 = v_u_1.PlayerVelocity / 3.0001 * 0.1
	local v4 = p2.BobCycle and p2.BobCycle(v_u_1.PlayerVelocityDT, v3) or Vector3.new()
	local v5 = p2.BobCycle2 and p2.BobCycle2(v_u_1.PlayerVelocityDT, v3) or CFrame.new()
	local v6 = (v4.magnitude > 0.0001 and CFrame.fromAxisAngle(v4, v4.magnitude / 15) or CFrame.new()) * v5
	local v7
	if v3 == nil or tonumber(v3) ~= v3 then
		v7 = 0
	else
		local v8 = math.max(v3, 0)
		v7 = math.min(1, v8)
	end
	if v7 <= 0.0001 then
		v6 = CFrame.new()
	end
	return v6
end