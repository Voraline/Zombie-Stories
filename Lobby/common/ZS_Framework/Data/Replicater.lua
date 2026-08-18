local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require("./PlayerDatabase")
local v3 = require("@game/ReplicatedStorage/common/zap")
local v_u_4 = require(v1.Packages.Fusion).peek
local v_u_8 = {
	["SplitPath"] = function(p5) -- name: SplitPath
		local v6 = {}
		for v7 in string.gmatch(p5, "[^.]+") do
			table.insert(v6, v7)
		end
		return v6
	end
}
local function v_u_14(p9) -- name: findPosition
	-- upvalues: (copy) v_u_2, (copy) v_u_8
	local v10 = p9:gsub("Public.", ""):gsub("Profile.", "")
	local v11 = v_u_2
	if v11 == nil then
		return nil
	end
	local v12 = v_u_8.SplitPath(v10)
	for _, v13 in ipairs(v12) do
		if v11 == nil then
			return nil
		end
		v11 = v11[v13]
	end
	return v11
end
v3.UpdateValue.On(function(p15)
	-- upvalues: (copy) v_u_14
	local v16 = p15.path
	local v17 = p15.value
	local v18 = v_u_14(v16)
	if v18 then
		if v18.type == "State" then
			v18:set(v17)
		end
	else
		return
	end
end)
v3.RemoveIndex.On(function(p19)
	-- upvalues: (copy) v_u_14, (copy) v_u_4
	local v20 = p19.path
	local v21 = p19.index
	local v22 = v_u_14(v20)
	if v22 then
		if v22.type == "State" then
			local v23 = v_u_4(v22)
			table.remove(v23, v21)
			v22:set(v23)
		else
			table.remove(v22, v21)
		end
	else
		return
	end
end)
v3.InsertIndex.On(function(p24)
	-- upvalues: (copy) v_u_14, (copy) v_u_4
	local v25 = p24.path
	local v26 = p24.index
	local v27 = p24.value
	local v28 = v_u_14(v25)
	if v28 then
		if v28.type == "State" then
			local v29 = v_u_4(v28)
			table.insert(v29, v26, v27)
			v28:set(v29)
		else
			table.insert(v28, v26, v27)
		end
	else
		return
	end
end)
v3.InsertKey.On(function(p30)
	-- upvalues: (copy) v_u_14, (copy) v_u_4
	local v31 = p30.path
	local v32 = p30.key
	local v33 = p30.value
	local v34 = v_u_14(v31)
	if v34 then
		if v34.type == "State" then
			local v35 = v_u_4(v34)
			v35[v32] = v33
			v34:set(v35)
		else
			v34[v32] = v33
		end
	else
		return
	end
end)
v3.RemoveKey.On(function(p36)
	-- upvalues: (copy) v_u_14, (copy) v_u_4
	local v37 = p36.path
	local v38 = p36.key
	local v39 = v_u_14(v37)
	if v39 then
		if v39.type == "State" then
			local v40 = v_u_4(v39)
			v40[v38] = nil
			v39:set(v40)
		else
			v39[v38] = nil
		end
	else
		return
	end
end)
return v_u_8