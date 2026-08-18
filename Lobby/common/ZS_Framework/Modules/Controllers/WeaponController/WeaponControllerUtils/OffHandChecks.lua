return {
	["CanUseWithCurrentWeapon"] = function(p1) -- name: CanUseWithCurrentWeapon
		if p1 then
			if p1.Reloading then
				return false, "Reloading"
			else
				return true, nil
			end
		else
			return true, nil
		end
	end,
	["CanUseItem"] = function(p2, p3) -- name: CanUseItem
		if p2 then
			if p2.Config.IsOffHand then
				if p2.Config.IsTwoHandedAbility then
					return false, "TwoHandedAbility"
				elseif p2 == p3 then
					return false, "SameAsCurrentWeapon"
				elseif p2.Ammo and p2.Ammo > 0 then
					if p2.Config.IsFullyActivated and p2.Config.IsFullyActivated(p2.Config) then
						return false, "AlreadyActivated"
					else
						return true, nil
					end
				else
					return false, "NoAmmo"
				end
			else
				return false, "NotOffHandItem"
			end
		else
			return false, "NoItem"
		end
	end
}