local v_u_1 = game:GetService("HttpService")
local v_u_2 = game:GetService("ServerStorage")
local v_u_3 = require(script.Parent.SkinFormat)
local v4 = {}
local v_u_5 = {}
function v4.init(p6) -- name: init
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_5, (copy) v_u_3
	local v7 = p6.VModels
	local v8 = p6.Configs
	local v9 = v_u_2:FindFirstChild("CustomResources")
	if v9 then
		for _, v10 in v9:GetChildren() do
			for _, v11 in v10:GetChildren() do
				v11.Parent = v_u_2.common.ServerResources[v10.Name]
			end
		end
		v9:Destroy()
	end
	for _, v16 in { v7, v8 } do
		local v13 = v16:FindFirstChild("RenameMap")
		if v13 and (v13:IsA("StringValue") and v13.Value ~= "") then
			for _, v14 in v_u_1:JSONDecode(v13.Value) do
				local v15 = v16
				local v16
				for _, v17 in v14.path do
					v16 = v16:FindFirstChild(v17)
					if not v16 then
						break
					end
				end
				if v16 and v16.Name ~= v14.name then
					v16.Name = v14.name
					v16 = v15
				else
					v16 = v15
				end
			end
			v13:Destroy()
		end
	end
	local function v_u_20(p18) -- name: Register
		-- upvalues: (copy) v_u_20, (ref) v_u_5
		if p18:IsA("Folder") then
			for _, v19 in p18:GetChildren() do
				v_u_20(v19)
			end
		elseif p18:IsA("Model") or (p18:IsA("ModuleScript") or p18:IsA("Configuration")) then
			v_u_5[p18.Name] = p18
		end
	end
	for _, v21 in v7:GetChildren() do
		v_u_20(v21)
	end
	for _, v22 in v_u_5 do
		v_u_3.stampAttributes(v22)
	end
	if not p6.IsInEdit then
		local v_u_23 = p6.SharedResources
		local v_u_24 = p6.ChunkSender
		local v25 = p6.GetAttFolder
		local v_u_26 = p6.attCache
		for _, v27 in v_u_2.common.ServerResources.Attachments:GetChildren() do
			if v27:IsA("Folder") then
				for _, v28 in v27:GetChildren() do
					v_u_26[v28.Name] = v28
				end
				Instance.new("Folder", v_u_23.Attachments).Name = v27.Name
			end
		end
		v25:SetCallback(function(p29, p30)
			-- upvalues: (copy) v_u_26, (copy) v_u_24, (copy) v_u_23
			local v31 = p30[1]
			if v_u_26[v31] then
				v_u_24.Send(p29, v_u_26[v31], nil, v_u_23.Attachments[v_u_26[v31].Parent.Name])
			end
			return { v_u_26[v31] and v_u_26[v31].Parent.Name or nil }
		end)
	end
end
function v4.loadViewmodel(p32) -- name: loadViewmodel
	-- upvalues: (copy) v_u_5
	return v_u_5[p32]
end
function v4.GetViewmodels() -- name: GetViewmodels
	-- upvalues: (copy) v_u_5
	return v_u_5
end
function v4.GetViewmodel(p33) -- name: GetViewmodel
	-- upvalues: (copy) v_u_5
	return v_u_5[p33]
end
return v4