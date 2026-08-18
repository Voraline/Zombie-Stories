local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.common.ZS_Shared.Data.GameState)
local v_u_4, v_u_5 = require(v2.Packages.Bin)()
local v_u_6 = nil
local function v_u_12() -- name: toggleWallhack
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (ref) v_u_6, (copy) v_u_1, (copy) v_u_4
	local v7 = v_u_3.Data.Variables.WallhackEnabled
	v_u_5()
	if v_u_6 then
		v_u_6:Destroy()
		v_u_6 = nil
	end
	if v7 then
		local v8 = v_u_1:GetTagged("ZombieFolder")[1]
		if v8 then
			if v_u_6 then
				v_u_6:Destroy()
				v_u_6 = nil
			end
			local v9 = Instance.new("Highlight")
			v9.Name = "WallhackHighlight"
			v9.OutlineColor = Color3.fromRGB(255, 0, 0)
			v9.FillTransparency = 1
			v9.Parent = v8
			v_u_6 = v9
		end
		v_u_4(v_u_1:GetInstanceAddedSignal("ZombieFolder"):Connect(function(p10)
			-- upvalues: (ref) v_u_3, (ref) v_u_6
			if v_u_3.Data.Variables.WallhackEnabled then
				if v_u_6 then
					v_u_6:Destroy()
					v_u_6 = nil
				end
				local v11 = Instance.new("Highlight")
				v11.Name = "WallhackHighlight"
				v11.OutlineColor = Color3.fromRGB(255, 0, 0)
				v11.FillTransparency = 1
				v11.Parent = p10
				v_u_6 = v11
			end
		end))
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u_12
	v_u_12()
end)
v_u_3.Signals.Variables.WallhackEnabled:Connect(function(_)
	-- upvalues: (copy) v_u_12
	v_u_12()
end)
return {}