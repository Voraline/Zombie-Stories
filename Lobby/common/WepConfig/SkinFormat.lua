local v_u_1 = game:GetService("HttpService")
return {
	["classify"] = function(p2) -- name: classify
		return p2:IsA("Model") and p2:GetAttribute("SkinSDKVersion") and {
			["type"] = "skinsdk_model",
			["baseWeapon"] = nil,
			["instance"] = nil,
			["baseWeapon"] = p2:GetAttribute("BaseWeapon"),
			["instance"] = p2
		} or (p2:IsA("ModuleScript") and (p2:GetAttribute("Skin") and {
			["type"] = "diff",
			["baseWeapon"] = nil,
			["instance"] = nil,
			["baseWeapon"] = p2:GetAttribute("BaseWeapon"),
			["instance"] = p2
		} or {
			["type"] = "stock",
			["instance"] = nil,
			["instance"] = p2
		}) or (p2:IsA("Configuration") and {
			["type"] = "configuration",
			["baseWeapon"] = nil,
			["instance"] = nil,
			["baseWeapon"] = p2:GetAttribute("BaseWeapon"),
			["instance"] = p2
		} or (p2:IsA("Model") and {
			["type"] = "derived_model",
			["baseWeapon"] = nil,
			["instance"] = nil,
			["baseWeapon"] = p2:GetAttribute("BaseWeapon"),
			["instance"] = p2
		} or {
			["type"] = "stock",
			["instance"] = nil,
			["instance"] = p2
		})))
	end,
	["getBaseWeapon"] = function(p3) -- name: getBaseWeapon
		-- upvalues: (copy) v_u_1
		local v4 = p3:GetAttribute("BaseWeapon")
		if v4 then
			return v4
		end
		if p3:IsA("ModuleScript") and not p3:GetAttribute("Skin") then
			local v5, v6 = pcall(require, p3)
			if v5 and type(v6) == "string" then
				local v7, v8 = pcall(v_u_1.JSONDecode, v_u_1, v6)
				local v9 = v7 and type(v8) == "table" and (v8.Attributes or v8.a)
				if v9 then
					return v9.BaseWeapon
				end
			end
		end
		return nil
	end,
	["stampAttributes"] = function(_) -- name: stampAttributes end
}