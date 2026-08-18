local v1 = game.ReplicatedStorage.common
local v_u_2 = game:GetService("RunService")
local v3 = require(v1.NPCRegistry)
local v_u_4 = false
local v_u_5 = {}
local v_u_6 = Instance.new("ScreenGui")
v_u_6.Name = "NPCXray"
v_u_6.IgnoreGuiInset = true
v_u_6.ResetOnSpawn = false
local v_u_7 = Instance.new("Frame")
v_u_7.BackgroundTransparency = 1
local v8 = Instance.new("UIStroke", v_u_7)
v8.Color = Color3.new(0, 1, 0)
v8.Thickness = 1
v8.LineJoinMode = Enum.LineJoinMode.Round
local v9 = Instance.new("TextLabel", v_u_7)
v9.Name = "UIDLabel"
v9.Position = UDim2.new(0.5, 0, 0.5, 0)
v9.Size = UDim2.new(1, 0, 1, 0)
v9.BackgroundTransparency = 1
v9.Text = "123"
v9.TextColor3 = Color3.new(0, 1, 0)
v9.FontFace = Font.new("SourceSansPro", Enum.FontWeight.Bold)
v9.AnchorPoint = Vector2.new(0.5, 0.5)
local function v_u_31() -- name: updateXrays
	-- upvalues: (copy) v_u_5
	for v10, v11 in v_u_5 do
		if v10.Model then
			local v12 = v11[1]
			local v13 = v11[2]
			local v14, v15 = v10.Model:GetBoundingBox()
			local v16 = nil
			local v17 = nil
			local v18 = nil
			local v19 = nil
			local v20 = false
			local v21 = nil
			for v22 = -1, 1, 2 do
				for v23 = -1, 1, 2 do
					for v24 = -1, 1, 2 do
						local v25 = v14 * CFrame.new(v22 * 0.5 * v15.X, v23 * 0.5 * v15.Y, v24 * 0.5 * v15.Z)
						local v26 = workspace.CurrentCamera:WorldToViewportPoint(v25.Position)
						v20 = v26.Z < 0 and true or v20
						if v16 then
							local v27 = v26.X
							v16 = math.max(v16, v27)
							local v28 = v26.Y
							v17 = math.max(v17, v28)
							local v29 = v26.X
							v19 = math.min(v19, v29)
							local v30 = v26.Y
							v18 = math.min(v18, v30)
							v21 = v26.Z
						else
							v16 = v26.X
							v17 = v26.Y
							v19 = v26.X
							v18 = v26.Y
						end
					end
				end
			end
			v12.Visible = not v20
			v12.Position = UDim2.new(0, v19, 0, v18)
			v12.Size = UDim2.new(0, v16 - v19, 0, v17 - v18)
			v13.TextSize = 700 / v21
		end
	end
end
if v_u_2:IsClient() then
	v_u_6.Parent = game.Players.LocalPlayer.PlayerGui
	for _, v32 in v3:GetAllNPCs() do
		local v33 = v_u_7:Clone()
		local v34 = v33:WaitForChild("UIDLabel")
		v34.Text = v32.UID
		v33.Parent = v_u_6
		v_u_5[v32] = { v33, v34 }
	end
	v3.NPCAdded:Connect(function(p35)
		-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_5
		local v36 = v_u_7:Clone()
		local v37 = v36:WaitForChild("UIDLabel")
		v37.Text = p35.UID
		v36.Parent = v_u_6
		v_u_5[p35] = { v36, v37 }
	end)
	v3.NPCRemoved:Connect(function(p38)
		-- upvalues: (copy) v_u_5
		local v39 = v_u_5[p38][1]
		if v39 then
			v_u_5[p38] = nil
			v39:Destroy()
		end
	end)
end
return {
	["Name"] = "npcxray",
	["Aliases"] = nil,
	["Description"] = "Highlights all NPCs and shows debug info.",
	["Group"] = "Debug",
	["Args"] = nil,
	["ClientRun"] = nil,
	["Aliases"] = { "nx" },
	["Args"] = {},
	["ClientRun"] = function(_) -- name: ClientRun
		-- upvalues: (ref) v_u_4, (copy) v_u_2, (copy) v_u_31, (copy) v_u_5
		v_u_4 = not v_u_4
		if v_u_4 then
			v_u_2:BindToRenderStep("NPCXray", Enum.RenderPriority.Input.Value - 1, v_u_31)
		else
			v_u_2:UnbindFromRenderStep("NPCXray")
			for _, v40 in v_u_5 do
				v40[1].Visible = false
			end
		end
		return string.format("NPC Xray %s", v_u_4 and "enabled" or "disabled")
	end
}