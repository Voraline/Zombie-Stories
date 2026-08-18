local v1 = require(game.ReplicatedStorage.Packages.Red)
local v_u_2 = require(game.ReplicatedStorage.Packages.Guard)
local v_u_3 = v_u_2.Or(v_u_2.String, v_u_2.List(v_u_2.String))
return {
	["CustomHit"] = v1.SharedEvent("CustomHit", function(p4)
		return p4
	end),
	["PreloadWeapon"] = v1.SharedEvent("PreloadWeapon", function(p5)
		-- upvalues: (copy) v_u_3
		return v_u_3(p5)
	end),
	["UpdateAmmo"] = v1.SharedEvent("UpdateAmmo", function(p6)
		return p6
	end),
	["Reloading"] = v1.SharedEvent("Reloading", function(p7)
		return p7
	end),
	["CancelReload"] = v1.Function("CancelReload", function(p8)
		return p8
	end),
	["ReloadingFunction"] = v1.Function("ReloadingFunction", function(p9)
		return p9
	end, function(p10)
		return p10
	end),
	["SetLoadout"] = v1.SharedEvent("SetLoadout", function(p11)
		return p11
	end),
	["RequestLoadout"] = v1.Function("RequestLoadout", function() end, function(p12)
		return p12
	end),
	["RequestPendingTeleport"] = v1.Function("RequestPendingTeleport", function() end, function(p13)
		return p13
	end),
	["RollbackHP"] = v1.SharedEvent("RollbackHP", function(p14)
		return p14
	end),
	["LookAngle"] = v1.SharedEvent("LookAngle", function(p15)
		return p15
	end),
	["Shoot"] = v1.SharedEvent("Shoot", function(p16)
		return p16
	end),
	["MeleeSwing"] = v1.SharedEvent("MeleeSwing", function(p17)
		return p17
	end),
	["MeleeReg"] = v1.SharedEvent("MeleeReg", function(p18)
		return p18
	end),
	["HitReplication"] = v1.SharedEvent("HitReplication", function(p19)
		return p19
	end),
	["Equipped"] = v1.SharedEvent("Equipped", function(p20)
		-- upvalues: (copy) v_u_2
		return v_u_2.Optional(v_u_2.Or(v_u_2.String, v_u_2.Number))(p20)
	end),
	["CharacterLoaded"] = v1.SharedEvent("CharacterLoaded", function() end),
	["WeaponUse"] = v1.SharedEvent("WeaponUse", function(p21)
		return p21
	end),
	["OffHandUse"] = v1.SharedEvent("OffHandUse", function(p22)
		return p22
	end)
}