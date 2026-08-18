local v1 = game.ReplicatedStorage.common.RedEvents
local v_u_2 = nil
local v_u_3 = require(v1.Framework.ChangeStateEvent)
local v_u_4 = {
	["Sprinting"] = true,
	["Crouching"] = true,
	["Proning"] = true,
	["Sliding"] = true,
	["Jogging"] = true,
	["Diving"] = true,
	["Aiming"] = true,
	["Blocking"] = true,
	["Charging"] = true,
	["EquippedGun"] = true,
	["QuickSwapActive"] = true,
	["DualWieldActive"] = true
}
local v_u_5 = {
	["EquippedGun"] = true
}
local v_u_14 = {
	["Init"] = function(_) -- name: Init
		-- upvalues: (ref) v_u_2, (copy) v_u_4, (copy) v_u_5
		v_u_2 = require(game:GetService("ReplicatedStorage").common:WaitForChild("PlayerHandler"))
		for v6, _ in v_u_4 do
			v_u_4[v6] = (v_u_5[v6] or not v6) and true or v6
		end
	end,
	["new"] = function() -- name: new
		-- upvalues: (copy) v_u_14
		local v7 = v_u_14
		return setmetatable({
			["_sprinting"] = false,
			["_crouching"] = false,
			["_proning"] = false,
			["_sliding"] = false,
			["_jogging"] = false,
			["_diving"] = false,
			["_aiming"] = false,
			["_blocking"] = false,
			["_charging"] = false,
			["_equippedgun"] = false,
			["_quickswapactive"] = false,
			["_dualwieldactive"] = false
		}, v7)
	end,
	["__index"] = function(p8, p9) -- name: __index
		-- upvalues: (copy) v_u_14, (copy) v_u_4
		if v_u_14[p9] or v_u_14["_" .. string.lower(p9)] then
			return v_u_14[p9]
		end
		if v_u_4[p9] then
			return p8["_" .. string.lower(p9)]
		end
		error(("%q is not a valid member of playerState"):format((tostring(p9))), 2)
	end,
	["__newindex"] = function(p10, p11, p12) -- name: __newindex
		-- upvalues: (copy) v_u_4, (ref) v_u_2, (copy) v_u_5, (copy) v_u_3
		local v13 = nil
		if v_u_4[p11] then
			v13 = p10[p11]
			p10["_" .. string.lower(p11)] = p12
		else
			error(("%q is not a valid member of playerState"):format((tostring(p11))), 2)
		end
		if v13 ~= nil and v13 ~= p12 then
			v_u_2:SetState(game.Players.LocalPlayer, p11, p12)
			if not v_u_5[p11] then
				v_u_3:FireServer({ v_u_4[p11], p12 })
			end
		end
	end
}
return v_u_14