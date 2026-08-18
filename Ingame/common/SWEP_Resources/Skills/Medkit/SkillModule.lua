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
			p_u_7("MEDKIT: " .. p8 .. " [" .. p9 .. "]")
		end
	end
	return v_u_1
else
	if v2:IsServer() then
		local v_u_10 = require("@game/ServerStorage/common/ProgressionTracker")
		function v_u_1.SetupDrop(p_u_11, p_u_12, p13) -- name: SetupDrop
			-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_1, (copy) v_u_6, (copy) v_u_10
			local v14 = v_u_4:GenerateGUID(false)
			v_u_3:AddTag(p_u_11, "TacticalDrop")
			p_u_11:SetAttribute("TacticalDropId", v14)
			local v_u_15 = p13 or {}
			v_u_1.DropPlayer[p_u_11] = p_u_12
			v_u_1.DropPlayersUsed[p_u_11] = v_u_15
			p_u_11.Used.OnServerEvent:connect(function(p16)
				-- upvalues: (ref) v_u_15, (copy) p_u_11, (copy) p_u_12, (ref) v_u_6, (ref) v_u_10
				if not v_u_15[p16] then
					local v17 = p_u_11
					local v18 = p16.Character
					local v19
					if v18 then
						local v20 = v18:FindFirstChild("HumanoidRootPart")
						v19 = v20 and (v17.MinDist.Value >= (v17.Position - v20.Position).Magnitude and v17.Active.Value == true) and true or false
					else
						v19 = false
					end
					if v19 and p16.Character.HP.Value > 0 then
						v_u_15[p16] = true
						p_u_11.Heal:Play()
						p16.Character.HP.Value = p16.Character.MaxHP.Value
						game.ReplicatedStorage.common.Remotes.Net:FireClient(p16, "UsedMedkit")
						if p_u_12 ~= p16 then
							v_u_6:FireClient(p_u_12, {
								["Type"] = "AddXPItem",
								["Reason"] = nil,
								["Color"] = nil,
								["Reason"] = "Healed " .. p16.Name,
								["Color"] = Color3.fromRGB(137, 255, 124)
							})
							v_u_10:UpdateXpItem(p_u_12, "Heal", false, nil, function(p21, p22)
								local v23 = (p21 or 0) + 1
								return v23, (p22 or 0) + 10, v23 .. " Heals"
							end)
						end
					end
				end
			end)
			return v14
		end
		function v_u_1.Activate(p24) -- name: Activate
			-- upvalues: (copy) v_u_1
			local v25 = nil
			local v26 = p24.Character
			if v26 then
				local v27 = v26:FindFirstChild("HumanoidRootPart")
				if v27 and p24.Character.HP.Value > 0 then
					local v28 = v27.Position
					local v29 = Ray.new(v28, Vector3.new(0, -1000, 0))
					local v30, v31 = workspace:FindPartOnRayWithIgnoreList(v29, { workspace.Ignore, v26, workspace.InteractSystem })
					if v30 then
						v25 = v31 or v25
					end
				end
			end
			if v25 then
				local v32 = game:GetService("ServerStorage").SWEP_Resources.Skills.Medkit.Resources
				local v33 = v25 + Vector3.new(0, 0.4, 0)
				local v34 = v32.Medkit:Clone()
				v34:SetPrimaryPartCFrame(CFrame.new(v33))
				v34.Parent = workspace.Ignore
				local v35 = workspace.InteractSystem
				local v36 = v32.Use:Clone()
				v36.CFrame = CFrame.new(v33 + Vector3.new(0, 0.4, 0))
				v36.Active.Value = true
				v36.Parent = v35
				v36.Drop:Play()
				v_u_1.SetupDrop(v36, p24)
			end
		end
	end
	return v_u_1
end