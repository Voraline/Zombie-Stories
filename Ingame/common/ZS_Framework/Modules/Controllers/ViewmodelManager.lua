local v_u_1 = game:GetService("RunService")
local v_u_2 = Enum.RenderPriority.Last.Value
return {
	["Equipped"] = {},
	["ArmAssignments"] = {
		["Right"] = nil,
		["Left"] = nil
	},
	["Initialized"] = false,
	["RenderStepBound"] = false,
	["Equip"] = function(p3, p4, p5, p6) -- name: Equip
		if p4 and p4.Viewmodel then
			local v7 = {
				["Weapon"] = nil,
				["Viewmodel"] = nil,
				["ArmRequest"] = nil,
				["Priority"] = nil,
				["GrantedArms"] = nil,
				["State"] = "Hidden",
				["PreviousState"] = nil,
				["Weapon"] = p4,
				["Viewmodel"] = p4.Viewmodel,
				["ArmRequest"] = p5 or "Both",
				["Priority"] = p6 or 10,
				["GrantedArms"] = {
					["Right"] = false,
					["Left"] = false
				}
			}
			p3.Equipped[p4] = v7
			if p4.Viewmodel.ManagedByManager ~= nil then
				p4.Viewmodel.ManagedByManager = true
			end
			p3:ResolveArmConflicts()
			p3:EnsureRenderStep()
		else
			warn("[ViewmodelManager] Cannot equip weapon without viewmodel")
		end
	end,
	["Unequip"] = function(p8, p9) -- name: Unequip
		local v10 = p8.Equipped[p9]
		if v10 then
			if p8.ArmAssignments.Right == p9 then
				p8.ArmAssignments.Right = nil
			end
			if p8.ArmAssignments.Left == p9 then
				p8.ArmAssignments.Left = nil
			end
			if v10.Viewmodel and v10.Viewmodel.ManagedByManager ~= nil then
				v10.Viewmodel.ManagedByManager = false
			end
			p8.Equipped[p9] = nil
			p8:ResolveArmConflicts()
			if next(p8.Equipped) == nil then
				p8:UnbindRenderStep()
			end
		end
	end,
	["SetPriority"] = function(p11, p12, p13) -- name: SetPriority
		local v14 = p11.Equipped[p12]
		if v14 then
			v14.Priority = p13
			p11:ResolveArmConflicts()
		else
			warn("[ViewmodelManager] Cannot set priority - weapon not equipped")
		end
	end,
	["SetArmRequest"] = function(p15, p16, p17) -- name: SetArmRequest
		local v18 = p15.Equipped[p16]
		if v18 then
			v18.ArmRequest = p17
			p15:ResolveArmConflicts()
		else
			warn("[ViewmodelManager] Cannot set arm request - weapon not equipped")
		end
	end,
	["GetState"] = function(p19, p20) -- name: GetState
		local v21 = p19.Equipped[p20]
		return v21 and v21.State or nil
	end,
	["GetGrantedArms"] = function(p22, p23) -- name: GetGrantedArms
		local v24 = p22.Equipped[p23]
		return v24 and v24.GrantedArms or nil
	end,
	["IsArmAvailable"] = function(p25, p26) -- name: IsArmAvailable
		return p25.ArmAssignments[p26] == nil
	end,
	["GetWeaponWithArm"] = function(p27, p28) -- name: GetWeaponWithArm
		return p27.ArmAssignments[p28]
	end,
	["GetEquippedWeapons"] = function(p29) -- name: GetEquippedWeapons
		local v30 = {}
		for v31, _ in p29.Equipped do
			table.insert(v30, v31)
		end
		return v30
	end,
	["GetEntry"] = function(p32, p33) -- name: GetEntry
		return p32.Equipped[p33]
	end,
	["ResolveArmConflicts"] = function(p34) -- name: ResolveArmConflicts
		p34.ArmAssignments = {
			["Right"] = nil,
			["Left"] = nil
		}
		local v35 = p34:GetSortedByPriority()
		for _, v36 in ipairs(v35) do
			local v37 = p34:TryGrantArms(v36.ArmRequest)
			v36.GrantedArms = v37
			v36.PreviousState = v36.State
			v36.State = p34:ComputeState(v36.ArmRequest, v37)
		end
	end,
	["GetSortedByPriority"] = function(p38) -- name: GetSortedByPriority
		local v39 = {}
		for _, v40 in p38.Equipped do
			table.insert(v39, v40)
		end
		table.sort(v39, function(p41, p42)
			return p41.Priority > p42.Priority
		end)
		return v39
	end,
	["TryGrantArms"] = function(p43, p44) -- name: TryGrantArms
		local v45 = {
			["Right"] = false,
			["Left"] = false
		}
		if p44 == "Both" then
			if p43.ArmAssignments.Right == nil and p43.ArmAssignments.Left == nil then
				v45.Right = true
				v45.Left = true
				return v45
			end
			if p43.ArmAssignments.Right == nil then
				v45.Right = true
				return v45
			end
			if p43.ArmAssignments.Left == nil then
				v45.Left = true
				return v45
			end
		elseif p44 == "Right" then
			if p43.ArmAssignments.Right == nil then
				v45.Right = true
				return v45
			end
		elseif p44 == "Left" then
			if p43.ArmAssignments.Left == nil then
				v45.Left = true
				return v45
			end
		elseif p44 == "Either" then
			if p43.ArmAssignments.Right == nil then
				v45.Right = true
				return v45
			end
			if p43.ArmAssignments.Left == nil then
				v45.Left = true
			end
		end
		return v45
	end,
	["ComputeState"] = function(_, p46, p47) -- name: ComputeState
		local v48 = p47.Right
		local v49 = p47.Left
		local v50 = v48 or v49
		return p46 == "Both" and (v48 and v49 and "Full" or (v50 and "OneHanded" or "Lowered")) or (p46 == "Right" and (v48 and "Full" or "Lowered") or (p46 == "Left" and (v49 and "Full" or "Lowered") or (p46 == "Either" and (v50 and "Full" or "Lowered") or "Hidden")))
	end,
	["ResolveArmConflicts"] = function(p51) -- name: ResolveArmConflicts
		p51.ArmAssignments = {
			["Right"] = nil,
			["Left"] = nil
		}
		local v52 = p51:GetSortedByPriority()
		for _, v53 in ipairs(v52) do
			local v54 = {
				["Right"] = false,
				["Left"] = false
			}
			local v55 = v53.ArmRequest
			if v55 == "Both" then
				if p51.ArmAssignments.Right == nil and p51.ArmAssignments.Left == nil then
					v54.Right = true
					v54.Left = true
					p51.ArmAssignments.Right = v53.Weapon
					p51.ArmAssignments.Left = v53.Weapon
				elseif p51.ArmAssignments.Right == nil then
					v54.Right = true
					p51.ArmAssignments.Right = v53.Weapon
				elseif p51.ArmAssignments.Left == nil then
					v54.Left = true
					p51.ArmAssignments.Left = v53.Weapon
				end
			elseif v55 == "Right" then
				if p51.ArmAssignments.Right == nil then
					v54.Right = true
					p51.ArmAssignments.Right = v53.Weapon
				end
			elseif v55 == "Left" then
				if p51.ArmAssignments.Left == nil then
					v54.Left = true
					p51.ArmAssignments.Left = v53.Weapon
				end
			elseif v55 == "Either" then
				if p51.ArmAssignments.Right == nil then
					v54.Right = true
					p51.ArmAssignments.Right = v53.Weapon
				elseif p51.ArmAssignments.Left == nil then
					v54.Left = true
					p51.ArmAssignments.Left = v53.Weapon
				end
			end
			v53.GrantedArms = v54
			v53.PreviousState = v53.State
			v53.State = p51:ComputeState(v55, v54)
			local v56 = v53.Viewmodel
			if v56 and v56.ApplyManagerState then
				v56:ApplyManagerState(v53.State, v53.GrantedArms)
			end
		end
	end,
	["EnsureRenderStep"] = function(p_u_57) -- name: EnsureRenderStep
		-- upvalues: (copy) v_u_1, (copy) v_u_2
		if not p_u_57.RenderStepBound then
			p_u_57.RenderStepBound = true
			v_u_1:BindToRenderStep("ViewmodelManager", v_u_2 - 1, function(p58)
				-- upvalues: (copy) p_u_57
				p_u_57:Update(p58)
			end)
		end
	end,
	["UnbindRenderStep"] = function(p59) -- name: UnbindRenderStep
		-- upvalues: (copy) v_u_1
		if p59.RenderStepBound then
			p59.RenderStepBound = false
			v_u_1:UnbindFromRenderStep("ViewmodelManager")
		end
	end,
	["Update"] = function(p60, _) -- name: Update
		for _, v61 in p60.Equipped do
			local v62 = v61.Viewmodel
			if v62 and v62.ApplyManagerState then
				v62:ApplyManagerState(v61.State, v61.GrantedArms)
			end
		end
	end,
	["Init"] = function(p63) -- name: Init
		if not p63.Initialized then
			p63.Initialized = true
		end
	end
}