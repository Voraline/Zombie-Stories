local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.common:FindFirstChild("Fusion", true))
local v_u_3 = v2.Value
local v_u_4 = v2.Computed
local v_u_5 = {}
local v6 = {}
local v_u_7 = {
	["textSize"] = 0.02,
	["headerSize"] = 0.025,
	["subSize"] = 0.014,
	["cornerSize"] = 0.0049
}
for _, v8 in ipairs(script:GetChildren()) do
	if v8:IsA("ModuleScript") then
		v_u_5[v8.Name] = require(v8)
		local v9 = v8.Name
		table.insert(v6, v9)
	end
end
local v_u_10 = {
	["Nord"] = 1,
	["Dark"] = 2,
	["Light"] = 3,
	["Ocean"] = 4,
	["Autumn"] = 5,
	["Demon"] = 6
}
table.sort(v6, function(p11, p12)
	-- upvalues: (copy) v_u_10
	return (v_u_10[p11] or 100) < (v_u_10[p12] or 100)
end)
local v_u_19 = {
	["options"] = v6,
	["init"] = function(p_u_13) -- name: init
		-- upvalues: (copy) v_u_19, (copy) v_u_3, (copy) v_u_5, (copy) v_u_4, (copy) v_u_7
		v_u_19.name = p_u_13
		local v_u_14 = v_u_3(workspace.CurrentCamera.ViewportSize.Y)
		workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
			-- upvalues: (copy) v_u_14
			v_u_14:set(workspace.CurrentCamera.ViewportSize.Y)
		end)
		for v_u_15 in pairs(v_u_5.Nord) do
			v_u_19[v_u_15] = v_u_4(function()
				-- upvalues: (copy) p_u_13, (ref) v_u_5, (copy) v_u_15
				return (v_u_5[p_u_13:get()] or v_u_5.Nord)[v_u_15]:get()
			end)
		end
		for v16, v_u_17 in pairs(v_u_7) do
			v_u_19[v16] = v_u_4(function()
				-- upvalues: (copy) v_u_14, (copy) v_u_17
				local v18 = v_u_14:get() * v_u_17
				return math.floor(v18)
			end)
		end
	end
}
return v_u_19