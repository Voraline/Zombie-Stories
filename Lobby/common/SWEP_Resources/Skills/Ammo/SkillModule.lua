local v_u_1 = {
	["ActivateType"] = "Holding",
	["AmtUses"] = 3,
	["UseDelay"] = 30,
	["DropPlayer"] = {},
	["DropPlayersUsed"] = {}
}
local v2 = game:GetService("RunService")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = game:GetService("HttpService")
local v5 = game.ReplicatedStorage.common.RedEvents
local v_u_6 = require(v5.General.ProgressionEvent)
if v2:IsClient() then
	function v_u_1.Init(_, p_u_7, _) -- name: Init
		return function(p8, p9) -- name: udpText
			-- upvalues: (copy) p_u_7
			p_u_7("AMMO: " .. p8 .. " [" .. p9 .. "]")
		end
	end
	return v_u_1
else
	if v2:IsServer() then
		local v_u_10 = require("@game/ServerStorage/common/ProgressionTracker")
		local v_u_11 = require("@game/ServerStorage/common/WepHandler")
		function v_u_1.SetupDrop(p_u_12, p_u_13, p14) -- name: SetupDrop
			-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_1, (copy) v_u_11, (copy) v_u_6, (copy) v_u_10
			local v15 = v_u_4:GenerateGUID(false)
			v_u_3:AddTag(p_u_12, "TacticalDrop")
			p_u_12:SetAttribute("TacticalDropId", v15)
			local v_u_16 = p14 or {}
			v_u_1.DropPlayer[p_u_12] = p_u_13
			v_u_1.DropPlayersUsed[p_u_12] = v_u_16
			p_u_12:WaitForChild("Used").OnServerEvent:connect(function(p17)
				-- upvalues: (ref) v_u_16, (copy) p_u_12, (ref) v_u_11, (copy) p_u_13, (ref) v_u_6, (ref) v_u_10
				if not v_u_16[p17] then
					local v18 = p_u_12
					local v19 = p17.Character
					local v20
					if v19 then
						local v21 = v19:FindFirstChild("HumanoidRootPart")
						v20 = v21 and (v18.MinDist.Value >= (v18.Position - v21.Position).Magnitude and v18.Active.Value == true) and true or false
					else
						v20 = false
					end
					if v20 and p17.Character.HP.Value > 0 then
						v_u_16[p17] = true
						p_u_12.Ammo:Play()
						v_u_11:FillAmmo(p17)
						game.ReplicatedStorage.common.Remotes.Net:FireClient(p17, "GotAmmo")
						if p_u_13 ~= p17 then
							v_u_6:FireClient(p_u_13, {
								["Type"] = "AddXPItem",
								["Reason"] = nil,
								["Color"] = nil,
								["Reason"] = "Resupplied " .. p17.Name,
								["Color"] = Color3.fromRGB(137, 255, 124)
							})
							v_u_10:UpdateXpItem(p_u_13, "Resupply", false, nil, function(p22, p23)
								local v24 = (p22 or 0) + 1
								return v24, (p23 or 0) + 10, v24 .. " Resupplies"
							end)
						end
					end
				end
			end)
			return v15
		end
		function v_u_1.Activate(p25) -- name: Activate
			-- upvalues: (copy) v_u_1
			local v26 = nil
			local v27 = p25.Character
			if v27 then
				local v28 = v27:FindFirstChild("HumanoidRootPart")
				if v28 and p25.Character.HP.Value > 0 then
					local v29 = v28.Position
					local v30 = Ray.new(v29, Vector3.new(0, -1000, 0))
					local v31, v32 = workspace:FindPartOnRayWithIgnoreList(v30, { workspace.Ignore, v27, workspace.InteractSystem })
					if v31 then
						v26 = v32 or v26
					end
				end
			end
			if v26 then
				local v33 = game:GetService("ServerStorage").SWEP_Resources.Skills.Ammo.Resources
				local v34 = v26 + Vector3.new(0, 0.4, 0)
				local v35 = v33.Ammo:Clone()
				v35:SetPrimaryPartCFrame(CFrame.new(v34))
				v35.Parent = workspace.Ignore
				local v36 = workspace.InteractSystem
				local v37 = v33.Use:Clone()
				v37.CFrame = CFrame.new(v34 + Vector3.new(0, 1.5, 0))
				v37.Use.TextLabel.Text = "Take Ammo"
				v37.Active.Value = true
				v37.Parent = v36
				v37.Drop:Play()
				v_u_1.SetupDrop(v37, p25)
			end
		end
	end
	return v_u_1
end