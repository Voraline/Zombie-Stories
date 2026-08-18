local v_u_1 = script.Name
local v_u_2 = {}
v_u_2.__index = v_u_2
function v_u_2.new(p3) -- name: new
	-- upvalues: (copy) v_u_2
	local v4 = v_u_2
	return setmetatable({
		["_StatusEffects"] = nil,
		["SpeedMult"] = 0,
		["Inactive"] = true,
		["_TimeRemaining"] = nil,
		["_StatusEffects"] = p3
	}, v4)
end
function v_u_2.Apply(p5, _, p6, p7) -- name: Apply
	p5.SpeedMult = p7 or 0
	p5.Inactive = p5.SpeedMult == 0
	if p5.Inactive or (not p6 or p6 <= 0) then
		p5._TimeRemaining = nil
	else
		p5._TimeRemaining = p6
	end
end
function v_u_2.Update(p8, p9) -- name: Update
	-- upvalues: (copy) v_u_1
	if not p8.Inactive and p8._TimeRemaining then
		p8._TimeRemaining = p8._TimeRemaining - p9
		if p8._TimeRemaining <= 0 then
			local v10 = p8._StatusEffects
			if v10 then
				v10:RemoveStatus(v_u_1)
				return
			end
			p8:Destroy()
		end
	end
end
function v_u_2.Destroy(p11) -- name: Destroy
	p11.SpeedMult = 0
	p11.Inactive = true
	p11._TimeRemaining = nil
end
return v_u_2