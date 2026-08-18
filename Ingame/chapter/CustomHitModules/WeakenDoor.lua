local v_u_5 = {
	["Done"] = false,
	["ValidWeapon"] = function(_, p1) -- name: ValidWeapon
		return p1.WeaponName == "Hammer"
	end,
	["CustomHit"] = function(_, p2, p3, _, _, _) -- name: CustomHit
		-- upvalues: (copy) v_u_5
		local v4 = v_u_5.Done == false and game.ReplicatedStorage.common.Remotes:FindFirstChild("Door")
		if v4 then
			if workspace.Part_2:FindFirstChild("Gate1") then
				if v_u_5:ValidWeapon(p2) and (v4 and p3:IsDescendantOf(workspace.Part_2.Gate1)) then
					v4:FireServer()
					return true
				end
			else
				task.delay(10, function()
					-- upvalues: (ref) v_u_5
					if not workspace.Part_2:FindFirstChild("Gate1") then
						v_u_5.Done = true
					end
				end)
			end
		end
	end
}
return v_u_5