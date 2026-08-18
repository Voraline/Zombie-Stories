workspace:WaitForChild("Ignore")
local v_u_1 = {}
CFrame.new()
local v_u_2 = nil
local v_u_3 = {}
local v_u_4 = nil
local v_u_5 = CFrame.new(0.588401794, -0.546500206, -4.0329895)
return {
	["NewWeapon"] = function(p6) -- name: NewWeapon
		-- upvalues: (ref) v_u_2, (copy) v_u_1, (ref) v_u_3
		v_u_2 = p6
		if p6 and p6.Model then
			v_u_1[p6] = v_u_1[p6] or {}
		end
		if p6 then
			v_u_3 = v_u_1[p6] or {}
		end
	end,
	["SetActiveViewmodel"] = function(p7) -- name: SetActiveViewmodel
		-- upvalues: (ref) v_u_4, (copy) v_u_1
		v_u_4 = p7
		if p7 then
			v_u_1[p7] = v_u_1[p7] or {}
		end
	end,
	["GetViewmodelRotations"] = function(p8) -- name: GetViewmodelRotations
		-- upvalues: (copy) v_u_1
		return v_u_1[p8] or {}
	end,
	["UpdateRotation"] = function(p9, p10, p11, p12) -- name: UpdateRotation
		-- upvalues: (ref) v_u_4, (copy) v_u_1, (copy) v_u_5, (ref) v_u_3
		if v_u_4 then
			v_u_1[v_u_4] = v_u_1[v_u_4] or {}
			local v13 = { p10 or v_u_5, p11, p12 }
			v_u_1[v_u_4][p9] = v13
		else
			v_u_3[p9] = { p10 or v_u_5, p11, p12 }
		end
	end,
	["UpdateGlobalRotation"] = function(p14, p15, p16, p17) -- name: UpdateGlobalRotation
		-- upvalues: (ref) v_u_3, (copy) v_u_5
		v_u_3[p14] = { p15 or v_u_5, p16, p17 }
	end,
	["GetRotation"] = function(p18) -- name: GetRotation
		-- upvalues: (ref) v_u_4, (copy) v_u_1, (ref) v_u_3
		if not (v_u_4 and v_u_1[v_u_4]) then
			return v_u_3[p18] and v_u_3[p18][2] or CFrame.new()
		end
		local v19 = v_u_1[v_u_4][p18]
		return v19 and v19[2] or CFrame.new()
	end,
	["Update"] = function(_, p_u_20, p_u_21, p_u_22, p_u_23, p_u_24, p25) -- name: Update
		-- upvalues: (ref) v_u_2, (copy) v_u_1, (ref) v_u_3
		local v_u_26 = p25 or v_u_2
		local v27 = false
		local v28
		if p25 and v_u_1[p25] then
			v28 = v_u_1[p25]
			v27 = true
		else
			local v29 = v_u_2
			if v29 then
				v29 = v_u_2.Model
			end
			if v29 ~= p_u_20 then
				return
			end
			v28 = v_u_3
		end
		if v_u_26 and v28 then
			local function v43(p30, p31, p32) -- name: ProcessRotation
				-- upvalues: (copy) v_u_26, (copy) p_u_23, (copy) p_u_21, (copy) p_u_24, (copy) p_u_22, (copy) p_u_20
				local v33 = v_u_26.Barrel
				local v34 = v_u_26.Aimpart
				local v35 = v_u_26.Config.AimOffset or CFrame.new()
				local v36 = p31[3]
				if p31[1] then
					if p31[1] ~= "Barrel" then
						if p31[1] == "Aimpart" then
							v33 = v34
						else
							v33 = p31[1]
						end
					end
					if v33 then
						local v37
						if typeof(v33) == "Instance" and v33.Parent then
							v37 = v33.CFrame
						else
							v37 = p_u_23 * v33
						end
						if p_u_21 and (not v36 and v34) then
							v37 = v37:Lerp(v34.CFrame * v35 * p_u_24, p_u_22.Position)
						end
						local v38 = v37:toObjectSpace(p_u_20.PrimaryPart.CFrame)
						local v39 = (v37 * p31[2]):toWorldSpace(v38)
						if (v39.p - CFrame.new().Position).Magnitude < 0.001 then
							local v40, v41, v42 = v39:ToAxisAngle()
							if math.abs(v40) < 0.001 and (math.abs(v41) < 0.001 and math.abs(v42) < 0.001) then
								v39 = CFrame.new()
							end
						end
						p_u_20.PrimaryPart.CFrame = v39
					else
						table.clear(p32[p30])
						p32[p30] = nil
					end
				else
					table.clear(p32[p30])
					p32[p30] = nil
					return
				end
			end
			for v44, v45 in v28 do
				v43(v44, v45, v28)
			end
			if v27 then
				for v46, v47 in v_u_3 do
					if not v28[v46] then
						v43(v46, v47, v_u_3)
					end
				end
			end
		end
	end
}