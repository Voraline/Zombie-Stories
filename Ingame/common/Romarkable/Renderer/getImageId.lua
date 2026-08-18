local v_u_1 = game:GetService("MarketplaceService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = {}
local function v_u_10(p4) -- name: resolveAssetPath
	-- upvalues: (copy) v_u_2
	local v5 = string.split(p4, "/")
	local v6, v7 = pcall(function()
		-- upvalues: (ref) v_u_2
		return require(v_u_2.common:FindFirstChild("Assets", true):FindFirstChild("assets"))
	end)
	if v6 and v7 then
		local v8 = v7.Images
		for _, v9 in v5 do
			if type(v8) ~= "table" then
				return nil
			end
			v8 = v8[v9]
		end
		if type(v8) == "string" then
			return v8
		else
			return nil
		end
	else
		return nil
	end
end
return function(p11)
	-- upvalues: (copy) v_u_3, (copy) v_u_10, (copy) v_u_1
	local v12 = string.match(p11, "^asset://(.+)$")
	if v12 then
		local v13 = v_u_3[v12]
		if v13 then
			return v13
		end
		local v14 = v_u_10(v12)
		if not v14 then
			return "rbxassetid://6266306999"
		end
		v_u_3[v12] = v14
		return v14
	else
		local v_u_15 = string.match(p11, "%d+")
		local v_u_16 = tonumber(v_u_15)
		local v_u_17 = v_u_3[v_u_15]
		if v_u_17 then
			return v_u_17
		else
			local v_u_18 = nil
			local v23, v24 = pcall(function()
				-- upvalues: (ref) v_u_18, (ref) v_u_1, (copy) v_u_15, (ref) v_u_17, (ref) v_u_3, (copy) v_u_16
				v_u_18 = v_u_1:GetProductInfo(v_u_15, Enum.InfoType.Asset)
				if v_u_18.AssetTypeId == 1 then
					v_u_17 = "rbxassetid://" .. v_u_15
					v_u_3[v_u_15] = v_u_17
					return v_u_17
				end
				if v_u_18.AssetTypeId ~= 13 then
					return "rbxassetid://6266306999"
				end
				local v19 = v_u_18.Creator.Id
				for v20 = 0, 50 do
					local v21 = v_u_1:GetProductInfo(v_u_16 - v20, Enum.InfoType.Asset)
					if v21.AssetTypeId == 1 and v21.Creator.Id == v19 then
						v_u_17 = "rbxassetid://" .. v_u_16 - v20
						v_u_3[v_u_15] = v_u_17
						return v_u_17
					end
					local v22 = v_u_3[v_u_15]
					if v22 then
						return v22
					end
				end
				v_u_17 = "rbxthumb://type=Asset&id=" .. v_u_15 .. "&w=420&h=420"
				v_u_3[v_u_15] = v_u_17
				return v_u_17
			end)
			if v23 then
				return v24
			else
				return "rbxthumb://type=Asset&id=" .. v_u_15 .. "&w=420&h=420"
			end
		end
	end
end