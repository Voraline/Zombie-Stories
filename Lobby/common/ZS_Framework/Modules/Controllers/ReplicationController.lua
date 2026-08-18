local v_u_1 = game:GetService("TweenService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
local v_u_5 = require("@game/ReplicatedStorage/common/zap")
local v_u_6 = workspace.CurrentCamera
local v7 = v_u_2.common
local v_u_8 = v_u_2.common:WaitForChild("SharedResources"):WaitForChild("Assets")
local v9 = script.Parent.Parent.Utils
local v10 = v_u_2.common.RedEvents
local v_u_11 = require(v7:WaitForChild("WepConfig"))
local v_u_12 = require(v7:WaitForChild("Promise"))
local v_u_13 = require(v7:WaitForChild("PlayerHandler"))
local v_u_14 = require("./FlashlightController")
local v_u_15 = require(v_u_2.common.NPCs_Shared.Utils.ClassMirror)
local v_u_16 = require(script.Parent.Parent.Utils:WaitForChild("CharacterAnimator"))
local v_u_17 = require(v_u_2.common.Settings)
local v_u_18 = require(v_u_2.Packages.Fusion).peek
require("../Classes/WorldViewmodel")
local v_u_19 = require("../Classes/WorldWeapon")
local v_u_20 = require(v9:WaitForChild("BulletUtil"))
local v_u_21 = require(v9:WaitForChild("RaycastUtil"))
local v_u_22 = require(v7:WaitForChild("GunID"))
local v_u_23 = require(v10.Framework.FrameworkEvents)
local v_u_24 = workspace.Values:FindFirstChild("IsLobby") == nil and true or not workspace.Values.IsLobby.Value
local v_u_25 = {}
local v_u_26 = {}
local v_u_27 = 0
local v_u_28 = {
	["rbxassetid://180426354"] = true
}
v_u_17.SettingsChanged:Connect(function(p29)
	-- upvalues: (copy) v_u_18, (copy) v_u_17, (copy) v_u_26
	if p29 and (p29[1] == "Graphics" and p29[2] == "ProceduralAnimations") then
		local v30 = v_u_18(v_u_17.Graphics.ProceduralAnimations)
		for _, v31 in v_u_26 do
			if v31.Animator then
				v31.Animator:SetIKEnabled(v30)
			end
		end
	end
end)
local v_u_32 = os.clock()
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = Enum.RenderPriority.Character.Value + 1
local v_u_36 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
local v37 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
local v_u_38 = CFrame.new(0, -0.25, 0) * CFrame.Angles(0, 3.141592653589793, 0)
local v_u_39 = CFrame.new(0, -0.25, 0) * v37
local v_u_40 = CFrame.new(0, -0.15, -0.3) * CFrame.Angles(0.5235987755982988, 0, 0)
local v_u_41 = CFrame.new(-0.3, -0.5, -0.2) * CFrame.Angles(0.6108652381980153, -0.2617993877991494, 0)
local v_u_42 = CFrame.new(0.25, 0, 0) * CFrame.Angles(0, -0.17453292519943295, 0)
local v_u_43 = CFrame.new(-0.25, 0, 0) * CFrame.Angles(0, 0.17453292519943295, 0)
local v_u_44 = CFrame.new(-0.25, 0, -0.1) * CFrame.Angles(0, 0.17453292519943295, 0)
local function v_u_49(p45) -- name: GetPlayerSkinColor
	if p45 then
		p45 = p45.Character
	end
	local v46 = Color3.fromRGB(255, 204, 153)
	if p45 then
		local v47 = p45:FindFirstChildOfClass("BodyColors")
		if v47 then
			return v47.RightArmColor3 or (v47.LeftArmColor3 or v46)
		end
		local v48 = p45:FindFirstChild("Right Arm")
		if v48 then
			v46 = v48.Color
		end
	end
	return v46
end
local function v_u_57(p50, p51) -- name: CreateMirroredArmModel
	-- upvalues: (copy) v_u_8, (copy) v_u_49
	local v52 = v_u_8:FindFirstChild("RightArm")
	if not v52 then
		warn("[ReplicationController] Could not find RightArm template for dual wield arm model")
		return nil
	end
	local v53 = p50:FindFirstChild("Right Arm")
	if not v53 then
		return nil
	end
	local v54 = v52:Clone()
	v54.Name = "DualWieldArmModel"
	v54.CanCollide = false
	v54.Anchored = false
	v54.Color = v_u_49(p51)
	local v55 = v54:FindFirstChildOfClass("FileMesh") or v54:FindFirstChildOfClass("SpecialMesh")
	if v55 then
		v55.Scale = Vector3.new(-1, 1, 1)
	end
	local v56 = Instance.new("Motor6D")
	v56.Name = "ArmModelWeld"
	v56.Part0 = v53
	v56.Part1 = v54
	v56.C0 = CFrame.Angles(0, -3.141592653589793, 0)
	v56.C1 = CFrame.new(0, 0, 0)
	v56.Parent = v54
	v54.Parent = p50
	return v54
end
local v281 = {
	["Init"] = function() -- name: Init
		-- upvalues: (copy) v_u_26, (copy) v_u_25, (copy) v_u_23, (copy) v_u_16, (copy) v_u_21, (copy) v_u_18, (copy) v_u_17, (copy) v_u_28, (copy) v_u_24, (copy) v_u_4, (ref) v_u_27, (copy) v_u_20, (copy) v_u_15, (copy) v_u_5, (copy) v_u_3, (copy) v_u_35, (ref) v_u_32, (copy) v_u_6, (ref) v_u_33, (ref) v_u_34, (copy) v_u_13, (copy) v_u_39, (copy) v_u_38, (copy) v_u_36, (copy) v_u_14, (copy) v_u_2, (copy) v_u_1, (copy) v_u_40, (copy) v_u_57, (copy) v_u_43, (copy) v_u_41, (copy) v_u_42, (copy) v_u_44
		local function v_u_59(p58) -- name: cleanPlayer
			-- upvalues: (ref) v_u_26, (ref) v_u_25
			if v_u_26[p58] then
				if v_u_26[p58].LookAttachment then
					v_u_26[p58].LookAttachment:Destroy()
				end
				if v_u_26[p58].WorldModel then
					DestroyModel(v_u_26[p58])
				end
				if v_u_26[p58].SecondaryWorldModel then
					DestroySecondaryModel(v_u_26[p58])
				end
				if v_u_26[p58].OffHandWorldModel then
					DestroyOffHandModel(v_u_26[p58])
				end
				if v_u_26[p58].Animator then
					v_u_26[p58].Animator:Destroy()
				end
			end
			v_u_25[p58.Name] = nil
			v_u_26[p58] = nil
		end
		local v_u_60 = v_u_23.CharacterLoaded
		local function v_u_77(p61, p62) -- name: CharAdded
			-- upvalues: (ref) v_u_26, (ref) v_u_16, (ref) v_u_21, (ref) v_u_18, (ref) v_u_17, (ref) v_u_28, (copy) v_u_60
			if v_u_26[p62] then
				if v_u_26[p62].LookAttachment then
					v_u_26[p62].LookAttachment:Destroy()
				end
				if v_u_26[p62].WorldModel then
					DestroyModel(v_u_26[p62])
				end
				if v_u_26[p62].SecondaryWorldModel then
					DestroySecondaryModel(v_u_26[p62])
				end
				if v_u_26[p62].OffHandWorldModel then
					DestroyOffHandModel(v_u_26[p62])
				end
				if v_u_26[p62].Animator then
					v_u_26[p62].Animator:Destroy()
				end
			end
			local v63 = p61:WaitForChild("HumanoidRootPart")
			local v64 = p61:WaitForChild("Torso")
			local v65 = p61:WaitForChild("Head")
			local v66 = v65:Clone()
			v66:ClearAllChildren()
			v66.Name = "HEADCOPY"
			v66.Transparency = 1
			v66.CollisionGroup = "Player"
			local v67 = v64:WaitForChild("Neck")
			local v68 = v67:Clone()
			v68.Name = "NeckClone"
			v68.Part1 = v66
			v68.C0 = v67.C0
			v68.C1 = v67.C1
			v68.Parent = v64
			v66.Parent = p61
			v_u_26[p62].HeadCopy = v66
			v_u_26[p62].Head = v65
			v_u_26[p62].HRP = v63
			v_u_26[p62].RootJoint = v63:WaitForChild("RootJoint", 5)
			v_u_26[p62].Shoulders = {}
			v_u_26[p62].LastLookAngleTick = 0
			local v69 = v64:WaitForChild("Left Shoulder", 5)
			local v70 = v64:WaitForChild("Right Shoulder", 5)
			if v69 then
				local v71 = v_u_26[p62].Shoulders
				table.insert(v71, v69)
			end
			if v70 then
				local v72 = v_u_26[p62].Shoulders
				table.insert(v72, v70)
			end
			if p62 ~= game.Players.LocalPlayer then
				v_u_26[p62].Animator = v_u_16.new(p61, false)
				if v_u_26[p62].Animator then
					v_u_26[p62].Animator:SetRaycastParams(v_u_21:GetAltRaycastParams())
					v_u_26[p62].Animator:SetIKEnabled(v_u_18(v_u_17.Graphics.ProceduralAnimations))
				end
				local v73 = p61:FindFirstChildOfClass("Humanoid")
				if v73 then
					v73 = v73:FindFirstChildOfClass("Animator")
				end
				if v73 then
					v73.AnimationPlayed:Connect(function(p74)
						-- upvalues: (ref) v_u_28
						if p74.Animation and (p74.Animation.Name == "Animation" and v_u_28[p74.Animation.AnimationId]) then
							p74:Stop(0)
						end
					end)
				end
			end
			v_u_26[p62].LookAttachment = Instance.new("Attachment")
			v_u_26[p62].LookAttachment.WorldCFrame = v64.CFrame + v64.CFrame.LookVector * 3
			local v75 = v_u_26[p62].LookAttachment
			if p62 == game.Players.LocalPlayer then
				v63 = workspace.Terrain
			end
			v75.Parent = v63
			v_u_26[p62].Neck = v67
			v_u_26[p62].NeckCF = CFrame.new()
			if p62 ~= game.Players.LocalPlayer then
				v_u_26[p62].LookAttachment.CFrame = CFrame.new(0, 0, -5)
				v_u_26[p62].LookGoal = 0
				v_u_26[p62].YawGoal = 0
			end
			if p62 == game.Players.LocalPlayer then
				v_u_60:FireServer()
			else
				local v76 = p61:WaitForChild("Vehicle", 2)
				if v76 then
					v76:Destroy()
				end
			end
		end
		local function v_u_81(p_u_78) -- name: PlrAdded
			-- upvalues: (ref) v_u_25, (ref) v_u_24, (ref) v_u_4, (ref) v_u_26, (copy) v_u_77, (ref) v_u_27
			v_u_25[p_u_78.Name] = p_u_78
			local v79 = p_u_78.Character or p_u_78.CharacterAdded:Wait()
			if v_u_24 or v_u_4.LocalPlayer == p_u_78 then
				v_u_26[p_u_78] = {
					["Update"] = nil,
					["RootJoint"] = nil,
					["Update"] = os.clock()
				}
				v_u_77(v79, p_u_78)
			end
			p_u_78.CharacterAdded:Connect(function(p80)
				-- upvalues: (ref) v_u_24, (ref) v_u_4, (copy) p_u_78, (ref) v_u_77
				if v_u_24 or v_u_4.LocalPlayer == p_u_78 then
					v_u_77(p80, p_u_78)
				end
			end)
			v_u_27 = #v_u_4:GetPlayers()
		end
		for _, v_u_82 in v_u_4:GetPlayers() do
			task.defer(function()
				-- upvalues: (copy) v_u_81, (copy) v_u_82
				v_u_81(v_u_82)
			end)
		end
		game.Players.PlayerAdded:Connect(v_u_81)
		game.Players.PlayerRemoving:Connect(function(p83)
			-- upvalues: (ref) v_u_27, (ref) v_u_4, (copy) v_u_59
			v_u_27 = #v_u_4:GetPlayers()
			v_u_59(p83)
		end)
		v_u_23.HitReplication:SetClientListener(function(p84)
			-- upvalues: (ref) v_u_26, (ref) v_u_20, (ref) v_u_15
			local v85 = nil
			local v86 = nil
			local v87 = nil
			local v88 = {}
			local v89 = nil
			for v90, v91 in p84 do
				if v90 == 1 then
					if v_u_26[v91] then
						v89 = v_u_26[v91].WorldModel
					else
						v89 = nil
					end
					if not v89 then
						return
					end
					v87 = v89.Weapon
					if v87 then
						v87 = v89.Weapon.Config
					end
					v86 = v91
				elseif typeof(v91) == "Vector3" then
					table.insert(v88, v91)
				elseif string.sub(v91, 1, 1) == "m" then
					if not (v85 and (v85.Model and v85.Model.Parent)) then
						return
					end
					local v92 = nil
					local v93 = nil
					local v94 = string.sub(v91, 2)
					if v85.ArmorHPs and v85.ArmorHPs[v94] then
						v92 = v85.Model[v85.ArmorHPs[v94][2]]
						v93 = true
					elseif v85.UIDTable and v85.UIDTable[v94] then
						v92 = v85.UIDTable[v94]
					end
					if not v92 then
						return
					end
					local v95 = RaycastParams.new()
					v95.FilterType = Enum.RaycastFilterType.Include
					v95.FilterDescendantsInstances = { v92 }
					local v96 = v92.Position - v_u_26[v86].HRP.Position
					local v97 = workspace:Raycast(v_u_26[v86].HRP.Position, v96, v95)
					local v98 = v92.Position + v96.Unit * -0.5
					if v97 then
						v98 = v97.Position
					end
					if v85.Flinch then
						v85:Flinch(v98, v_u_26[v86].HRP.Position, (v87 and (v87.Damage or 5) or 5) / v85.MaxHP)
					end
					if not v93 and v87 then
						v_u_20:BloodNPC(v87 or {}, v85.UID, v94)
					end
				else
					v85 = v_u_15:GetObjFromId(v91)
				end
			end
			if v89 and (v87 and not v87.IsMelee) then
				v89.Weapon:Shoot(v88)
				v89.Weapon.LastShotTime = os.clock()
			end
		end)
		v_u_23.MeleeSwing:SetClientListener(function(p99)
			-- upvalues: (ref) v_u_26
			local v100, v101 = unpack(p99)
			local v102
			if v_u_26[v100] then
				v102 = v_u_26[v100].WorldModel
			else
				v102 = nil
			end
			if v102 and v102.Weapon then
				v102.Weapon:Melee(v101)
			end
		end)
		v_u_23.Reloading:SetClientListener(function(p103)
			-- upvalues: (ref) v_u_26
			local v104 = p103[1]
			local v105 = p103[2]
			if v_u_26[v104] and (v_u_26[v104].WorldModel and v_u_26[v104].WorldModel.Weapon) then
				v_u_26[v104].WorldModel.Weapon:Reload(not v105)
			end
		end)
		v_u_5.LookAngleEvent.On(function(p106)
			-- upvalues: (ref) v_u_26
			local v107 = v_u_26[p106.Player]
			if v107 then
				if v107.LastLookAngleTick <= p106.ClientTick then
					v107.LastLookAngleTick = p106.ClientTick
					local v108
					if v107.Animator then
						v108 = v107.Animator.States
					else
						v108 = nil
					end
					local v109 = p106.Pitch + (v108 and (v108.Proning and 0.1 or 0.3) or 0.3)
					v107.LookGoal = math.clamp(v109, -1.4, 1.4)
					local v110 = p106.Yaw
					v107.YawGoal = math.clamp(v110, -1.57, 1.57)
				end
			else
				return
			end
		end)
		local v_u_111 = 0
		v_u_3.Stepped:Connect(function(_, p112)
			-- upvalues: (ref) v_u_26, (ref) v_u_4
			for v113, v114 in v_u_26 do
				if v113 ~= v_u_4.LocalPlayer and (v114.Animator and v113.Parent) then
					v114.Animator:UpdateStepped(p112)
				end
			end
		end)
		v_u_3:BindToRenderStep("REPLICATION", v_u_35, function(p115)
			-- upvalues: (ref) v_u_32, (ref) v_u_6, (ref) v_u_4, (ref) v_u_33, (ref) v_u_34, (ref) v_u_111, (ref) v_u_5, (ref) v_u_26, (ref) v_u_27, (ref) v_u_13, (ref) v_u_39, (ref) v_u_38, (ref) v_u_36, (ref) v_u_21, (ref) v_u_14, (ref) v_u_2, (ref) v_u_1, (ref) v_u_40, (ref) v_u_57, (ref) v_u_43, (ref) v_u_41, (ref) v_u_42, (ref) v_u_44, (copy) v_u_59
			if v_u_32 < os.clock() then
				local v116 = v_u_6.CFrame:ToOrientation()
				local v117 = v_u_4.LocalPlayer
				local v118 = v117 and v117.Character
				if v118 then
					v118 = v117.Character:FindFirstChild("HumanoidRootPart")
				end
				local v119
				if v118 then
					local v120 = (v118.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
					local v121 = (v_u_6.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
					local v122 = v121:Cross(v120)
					local v123 = v121:Dot(v120)
					local v124 = v122.Y
					v119 = math.atan2(v124, v123)
				else
					v119 = 0
				end
				v_u_32 = os.clock() + 0.1
				local v125 = not v_u_33
				if not v125 then
					local v126 = v_u_33 - v116
					v125 = math.abs(v126) > 0.05
				end
				local v127 = not v_u_34
				if not v127 then
					local v128 = v_u_34 - v119
					v127 = math.abs(v128) > 0.05
				end
				if v125 or v127 then
					v_u_111 = v_u_111 + 1
					v_u_33 = v116
					v_u_34 = v119
					v_u_5.UpdateLookAngle.Fire({
						["Pitch"] = math.clamp(v116, -1.4, 1.4),
						["Yaw"] = math.clamp(v119, -1.57, 1.57),
						["ClientTick"] = v_u_111
					})
				end
			end
			for v_u_129, v_u_130 in v_u_26 do
				if v_u_129.Parent then
					if v_u_129 == v_u_4.LocalPlayer or os.clock() > v_u_130.Update then
						local v131 = v_u_129:DistanceFromCharacter(workspace.CurrentCamera.CFrame.p) or (1 / 0)
						local v132
						if v_u_129 == v_u_4.LocalPlayer or not v_u_26[v_u_129].LastTick then
							v132 = p115
						else
							v132 = os.clock() - v_u_26[v_u_129].LastTick
						end
						local v133 = v132 * 10
						local v134 = math.clamp(v133, 0.01, 1)
						v_u_26[v_u_129].LastTick = os.clock()
						local v135 = v_u_27
						local v136 = math.pow(v135, 4) * 0.01
						local v137 = math.clamp(v136, 1, 4)
						local v138 = v_u_130.HRP
						local v139
						if v138 and v138.Parent then
							local v140 = v138.Position
							local v141 = v_u_6.CFrame.LookVector
							local v142 = v140 - v_u_6.CFrame.Position
							local v143 = v_u_6.FieldOfView + 2
							local v144 = v142.Unit:Angle(v141)
							local v145 = math.deg(v144)
							v139 = math.floor(v145) <= v143
						else
							v139 = false
						end
						local v146 = v_u_26[v_u_129]
						local v147 = os.clock()
						local v148 = v131 / 100 * 0.1
						local v149 = math.max(v148, 0.016666666666666666)
						v146.Update = v147 + v137 * math.clamp(v149, 0, 1)
						local v150 = v_u_13:GetPlayerState(v_u_129)
						if v150 then
							local v151 = v_u_130.RootJoint
							if v151 and (v138 and (v151.Parent and (v138.Parent and v139))) then
								if v_u_130.Animator then
									v_u_130.Animator:SetState(v150)
									local v152 = v_u_130.Animator
									local v153 = v150.Equipped
									if v153 then
										v153 = v150.Equipped ~= ""
									end
									v152:SetWeaponEquipped(v153)
									v_u_130.Animator:Heartbeat(v132)
									v_u_130.Animator:UpdateRenderStepped(v132, v131)
								end
								if v_u_129 ~= v_u_4.LocalPlayer then
									local v154 = v150.Proning
									local v155 = v150.Diving
									local v156 = -v138.Velocity:Dot(v138.CFrame.RightVector)
									local v157 = v155 and CFrame.Angles(0, math.clamp(v156, -1.0471975511965976, 1.0471975511965976), 0) or CFrame.new()
									v151.C0 = v151.C0:Lerp(((not v154 or v155) and true or false) and v_u_39 * v157 or v_u_38, v134)
								end
							end
							if v_u_130.NeckCF and v_u_130.Neck then
								v_u_130.NeckCF = v_u_130.NeckCF:Lerp(v150.Aiming and CFrame.Angles(0, 0.3, 0) or CFrame.new(), v134)
								v_u_130.Neck.C1 = v_u_36 * v_u_130.NeckCF
							end
							if v_u_129 == v_u_4.LocalPlayer and v138 then
								if (v_u_6.CFrame.Position - v138.Position).Magnitude <= 100 and v_u_130.LookAttachment then
									if v150.Proning then
										v_u_130.HeadCopy.CanCollide = false
										v_u_130.LookAttachment.WorldPosition = v_u_21.CastNoneRay().Position
									else
										v_u_130.HeadCopy.CanCollide = false
										v_u_130.LookAttachment.WorldPosition = v_u_21.CastBaseRay().Position
									end
									v_u_14:UpdatePlayerLookDirection(nil, v_u_129)
								end
							else
								local v158 = v_u_26[v_u_129].YawGoal or 0
								local v159 = v_u_26[v_u_129].LookGoal or 0
								if v_u_26[v_u_129].LookAttachment then
									v_u_26[v_u_129].LookAttachment.CFrame = CFrame.Angles(v159, v158, 0) * CFrame.new(0, 0, -5)
									if v_u_130.Animator then
										v_u_130.Animator:SetLookPoint(v_u_26[v_u_129].LookAttachment.WorldPosition)
										v_u_130.Animator:SetYaw(v158)
									end
									v_u_14:UpdatePlayerLookDirection(v_u_26[v_u_129].LookAttachment.WorldPosition - v_u_26[v_u_129].Head.Position, v_u_129)
									local v_u_160 = v_u_130.HeadCopy
									local v161 = v150.Equipped
									local v_u_162 = v150.WepId
									local _ = v_u_130.WorldModel
									local v163 = v_u_130._lastQuickSwapActive or false
									local v164 = v150.QuickSwapActive
									local v165 = v150.SecondaryEquipped
									if v_u_130._promotedToEquipped and (v161 == v_u_130._promotedToEquipped or (v161 ~= v_u_130._waitingForEquippedFrom or v_u_130._promotionTimestamp and os.clock() - v_u_130._promotionTimestamp > 2)) then
										v_u_130._promotedToEquipped = nil
										v_u_130._waitingForEquippedFrom = nil
										v_u_130._promotionTimestamp = nil
									end
									if v163 and (not v164 and (v165 == false or v165 == "")) and (v_u_130.SecondaryWorldModel and v_u_130.SecondaryWorldModel.Weapon) then
										if v161 ~= v_u_130.SecondaryWorldModel.Equipped then
											DestroySecondaryModel(v_u_130)
											if v_u_130.WorldModel and v_u_130.WorldModel.Weapon then
												local v166 = v_u_130.WorldModel.Weapon.Viewmodel.Model
												local v167 = v_u_130.WorldModel.Weapon
												v_u_130.WorldModel.WeldedShoulders = v_u_130.WorldModel.WeldedShoulders or {}
												for _, v168 in v_u_130.Shoulders do
													if v168 and (v168.Part1 and not (v167.Config.ArmIgnores and v167.Config.ArmIgnores[v168.Name])) then
														local v169 = v166:FindFirstChild(v168.Part1.Name)
														if v169 then
															local v170 = false
															for _, v171 in v166:GetChildren() do
																if v171:IsA("Weld") and (v171.Part0 == v168.Part1 and v171.Part1 == v169) then
																	v170 = true
																	break
																end
															end
															if not v170 then
																local v172 = Instance.new("Weld")
																v172.Part0 = v168.Part1
																v172.Part1 = v169
																v172.C1 = v169.Size.Y > 3 and CFrame.new(0, -1, 0) or CFrame.new()
																v172.Parent = v166
															end
															local v173 = false
															for _, v174 in v_u_130.WorldModel.WeldedShoulders do
																if v174 == v168 then
																	v173 = true
																	break
																end
															end
															if not v173 then
																local v175 = v_u_130.WorldModel.WeldedShoulders
																table.insert(v175, v168)
															end
														end
														v168.Enabled = false
													end
												end
											end
										else
											if v_u_130.WorldModel then
												DestroyModel(v_u_130)
											end
											v_u_130.WorldModel = v_u_130.SecondaryWorldModel
											v_u_130.SecondaryWorldModel = nil
											v_u_130._promotedToEquipped = v_u_130.WorldModel.Equipped
											v_u_130._waitingForEquippedFrom = v161
											v_u_130._promotionTimestamp = os.clock()
											local v176 = v_u_130.WorldModel.Weapon.Viewmodel.Model
											local v177 = v_u_130.WorldModel.Weapon
											v_u_130.WorldModel.WeldedShoulders = v_u_130.WorldModel.WeldedShoulders or {}
											for _, v178 in v_u_130.Shoulders do
												if v178 and (v178.Part1 and not (v177.Config.ArmIgnores and v177.Config.ArmIgnores[v178.Name])) then
													local v179 = false
													for _, v180 in v_u_130.WorldModel.WeldedShoulders do
														if v180 == v178 then
															v179 = true
															break
														end
													end
													local v181 = not v179 and v176:FindFirstChild(v178.Part1.Name)
													if v181 then
														local v182 = Instance.new("Weld")
														v182.Part0 = v178.Part1
														v182.Part1 = v181
														v182.C1 = v181.Size.Y > 3 and CFrame.new(0, -1, 0) or CFrame.new()
														v182.Parent = v176
														local v183 = v_u_130.WorldModel.WeldedShoulders
														table.insert(v183, v178)
													end
													v178.Enabled = false
												end
											end
											if not v177.HRPWeld then
												v176.HumanoidRootPart.Anchored = false
												local v184 = Instance.new("Weld")
												v184.Part0 = v176.HumanoidRootPart
												v184.Part1 = v_u_160
												v184.C0 = v184.C0 * (v177.Config.ReplicationOffset or CFrame.new())
												v184.Parent = v176
												v177.HRPWeldBaseC1 = v184.C1
												v177.HRPWeldBase = v184.C0
												v177.HRPWeldBaseC0 = v184.C0
												v177.HRPWeld = v184
											end
											v177.IsMirrored = false
											v177.IsSecondary = false
										end
									end
									v_u_130._lastQuickSwapActive = v164
									if v161 and (v161 ~= "" and v_u_160) then
										if not v_u_130.WorldModel then
											v_u_130.WorldModel = {}
										end
										local v185 = v_u_130._promotedToEquipped == nil and (v_u_130.WorldModel.Equipped == v161 and (v_u_130.WorldModel.Weapon and v_u_130.WorldModel.Weapon.WepId))
										if v185 then
											v185 = v_u_130.WorldModel.Weapon.WepId ~= v_u_162
										end
										if v185 then
											if v_u_130.WorldModel then
												DestroyModel(v_u_130)
											end
											v_u_130.WorldModel.Equipped = v161
											local v_u_186 = v150.QuickSwapActive
											local v_u_187 = v150.DualWieldActive
											local v_u_188 = v150.OffHandActive
											local v_u_189 = v_u_130.WorldModel
											v_u_130.WorldModel.Promise = GetWeapon(v161, nil, v_u_129)
											v_u_130.WorldModel.Promise:andThen(function(p190)
												-- upvalues: (copy) v_u_130, (copy) v_u_189, (copy) v_u_162, (ref) v_u_2, (copy) v_u_160, (copy) v_u_186, (copy) v_u_187, (copy) v_u_188
												if v_u_130.WorldModel == v_u_189 then
													p190.WepId = v_u_162
													local v_u_191 = p190.Viewmodel.Model
													v_u_191.HumanoidRootPart.Anchored = false
													local v192 = p190.Config.IsAPistol
													local v193 = p190.Config.BulletsPerShot and p190.Config.BulletsPerShot >= 5 and true or false
													local v194 = p190.Config.IsMelee
													local v195
													if p190.Config.LODModel then
														v195 = v_u_2.common.SharedResources.LOD[p190.Config.LODModel]:Clone()
													elseif v192 then
														v195 = v_u_2.common.SharedResources.LOD.DefaultPistol:Clone()
													elseif v193 then
														v195 = v_u_2.common.SharedResources.LOD.DefaultShotgun:Clone()
													elseif v194 then
														v195 = v_u_2.common.SharedResources.LOD.DefaultKatana:Clone()
													else
														v195 = v_u_2.common.SharedResources.LOD.DefaultRifle:Clone()
													end
													local v196 = Instance.new("Weld")
													v196.Part0 = v195.Handle
													v196.Part1 = v_u_191.KeyParts.Handle
													v196.C0 = v196.C0 * (p190.Config.LODOffset or CFrame.new())
													v196.Parent = v195
													v195.Parent = nil
													local v197 = Instance.new("Weld")
													v197.Part0 = v_u_191.HumanoidRootPart
													v197.Part1 = v_u_160
													v197.C0 = v197.C0 * (p190.Config.ReplicationOffset or CFrame.new())
													v197.Parent = v_u_191
													p190.HRPWeldBaseC1 = v197.C1
													p190.HRPWeldBase = v197.C0
													p190.HRPWeldBaseC0 = v197.C0
													p190.HRPWeld = v197
													v_u_130.WorldModel.LowPolyModel = v195
													v_u_130.WorldModel.HighPolyModel = v_u_191.Weapon
													v_u_130.WorldModel.Attachments = v_u_191.Attachments
													local v_u_198 = v_u_191.KeyParts:GetChildren()
													function v_u_130.WorldModel.HideKeyparts(p199)
														-- upvalues: (copy) v_u_198, (copy) v_u_191
														for _, v200 in v_u_198 do
															if not v200:IsA("BasePart") then
																local v201
																if p199 then
																	v201 = nil
																else
																	v201 = v_u_191.KeyParts
																end
																v200.Parent = v201
															end
														end
													end
													v_u_191.Parent = workspace.Ignore
													v_u_191["Left Arm"].Transparency = 1
													v_u_191["Right Arm"].Transparency = 1
													v_u_130.WorldModel.WeldedShoulders = {}
													for _, v202 in v_u_130.Shoulders do
														if not (p190.Config.ArmIgnores and p190.Config.ArmIgnores[v202.Name]) then
															if (v_u_186 or (v_u_187 or v_u_188)) and v202.Name == "Left Shoulder" then
																if v202 then
																	v202.Enabled = false
																	local v203 = v_u_130.WorldModel.WeldedShoulders
																	table.insert(v203, v202)
																end
															else
																local v204 = Instance.new("Weld")
																v204.Part0 = v202.Part1
																v204.Part1 = v_u_191[v202.Part1.Name]
																v204.C1 = v_u_191[v202.Part1.Name].Size.Y > 3 and CFrame.new(0, -1, 0) or CFrame.new()
																v204.Parent = v_u_191
																v202.Enabled = false
																local v205 = v_u_130.WorldModel.WeldedShoulders
																table.insert(v205, v202)
															end
														end
													end
													v_u_130.WorldModel.Weapon = p190
													p190:Equip()
												else
													p190.Viewmodel:Destroy()
												end
											end)
										elseif v_u_130.WorldModel and v_u_130.WorldModel.Weapon then
											local v206 = v_u_130.WorldModel.Weapon
											if v150.Sprinting then
												if not v206.Sprinting then
													v206.Sprinting = true
													v_u_1:Create(v206.HRPWeld, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
														["C1"] = v206.HRPWeldBaseC1 * CFrame.Angles(-0.4, 0, 0)
													}):Play()
												end
											elseif v206.Sprinting then
												v206.Sprinting = false
												v_u_1:Create(v206.HRPWeld, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
													["C1"] = v206.HRPWeldBaseC1
												}):Play()
											end
											if v_u_130.Animator and v206.HRPWeldBaseC0 then
												local v207 = v_u_130.Animator:GetAimTwistAngle()
												v206.aimTwistAngle = v207
												local v208 = v_u_130.LookGoal or 0
												local v209 = v208 / 1.5707963267948966
												local v210 = math.clamp(v209, 0, 1)
												local v211 = v208 * (v150.Aiming and 0.8 or 0.5)
												local v212 = v150.Proning and 1.5707963267948966 or 0
												v206.RecoilOffset = (v206.RecoilOffset or CFrame.identity):Lerp(CFrame.identity, v134)
												v206.HRPWeldBase = v206.HRPWeldBaseC0 * v206.RecoilOffset * (v150.Proning and CFrame.new(0, -1, -1) or CFrame.new()) * CFrame.new():Lerp(not v150.Proning and CFrame.new(0, 0, -0.5) or CFrame.new(), v210) * CFrame.Angles(-v212, 0, 0) * CFrame.Angles(-v211, 0, 0) * CFrame.Angles(0, v150.Proning and 0 or (-v207 or 0), 0)
												local v213 = os.clock()
												local v214 = v206.LastShotTime
												if v214 then
													v214 = v213 - v206.LastShotTime < 2
												end
												local v215 = not (v150.Aiming or v150.Sprinting or (v214 or v150.Proning or (v150.QuickSwapActive or v150.DualWieldActive)))
												if v215 then
													v215 = not v150.OffHandActive
												end
												v206.GunRestAlpha = v206.GunRestAlpha or 0
												v206.GunRestAlpha = v206.GunRestAlpha + ((v215 and 1 or 0) - v206.GunRestAlpha) * v134 * 0.3
												v206.HRPWeldBase = v206.HRPWeldBase * CFrame.new():Lerp(v_u_40, v206.GunRestAlpha)
												v206.HRPWeld.C0 = v206.HRPWeld.C0:Lerp(v206.HRPWeldBase, v134)
											end
											if v150.Charging then
												v_u_130.WorldModel.Weapon:Charging()
											end
											if v150.Blocking then
												v_u_130.WorldModel.Weapon:Blocking()
											elseif v_u_130.WorldModel.Weapon.Block then
												v_u_130.WorldModel.Weapon:StopBlocking()
											end
											local v216 = v_u_27 * -0.3
											if v139 and v131 <= math.exp(v216) * 50 + 10 then
												v_u_130.WorldModel.Weapon.LowPolyMode = false
												v_u_130.WorldModel.HighPolyModel.Parent = v_u_130.WorldModel.Weapon.Viewmodel.Model
												v_u_130.WorldModel.Attachments.Parent = v_u_130.WorldModel.Weapon.Viewmodel.Model
												v_u_130.WorldModel.LowPolyModel.Parent = nil
												v_u_130.WorldModel.HideKeyparts(false)
											elseif v131 > 5 then
												v_u_130.WorldModel.Weapon.LowPolyMode = true
												if v_u_130.WorldModel.Weapon.Viewmodel.ViewmodelLoaded then
													v_u_130.WorldModel.Attachments.Parent = nil
												end
												v_u_130.WorldModel.HideKeyparts(true)
												v_u_130.WorldModel.HighPolyModel.Parent = nil
												v_u_130.WorldModel.LowPolyModel.Parent = v_u_130.WorldModel.Weapon.Viewmodel.Model
											end
										end
									elseif v_u_130.WorldModel then
										DestroyModel(v_u_130)
									end
									local v217 = v150.SecondaryEquipped
									local v_u_218 = v150.SecondaryWepId
									local v219 = v150.QuickSwapActive
									local v_u_220 = v150.DualWieldActive
									local v221
									if v217 then
										if v217 == "" then
											v221 = false
										else
											v221 = v217 ~= false
										end
									else
										v221 = v217
									end
									if v_u_130.SecondaryWorldModel then
										local _ = v_u_130.SecondaryWorldModel.Weapon == nil
									end
									if v221 and v_u_160 then
										if not v_u_130.SecondaryWorldModel then
											v_u_130.SecondaryWorldModel = {}
										end
										local v222 = v_u_130.SecondaryWorldModel.Equipped == v217 and (not v_u_130.SecondaryWorldModel.Weapon or (not v_u_130.SecondaryWorldModel.Weapon.WepId or v_u_130.SecondaryWorldModel.Weapon.WepId == v_u_218)) and v_u_130.SecondaryWorldModel.Weapon
										if v222 then
											v222 = v_u_130.SecondaryWorldModel.Weapon.IsMirrored ~= v_u_220
										end
										if v222 then
											if v_u_130.SecondaryWorldModel and v_u_130.SecondaryWorldModel.Weapon then
												DestroySecondaryModel(v_u_130)
												v_u_130.SecondaryWorldModel = {}
											end
											v_u_130.SecondaryWorldModel.Equipped = v217
											local v_u_223 = v_u_130.SecondaryWorldModel
											v_u_130.SecondaryWorldModel.Promise = GetWeapon(v217, nil, v_u_129)
											v_u_130.SecondaryWorldModel.Promise:andThen(function(p224)
												-- upvalues: (copy) v_u_130, (copy) v_u_223, (copy) v_u_218, (copy) v_u_220, (ref) v_u_2, (copy) v_u_160, (ref) v_u_57, (copy) v_u_129
												if v_u_130.SecondaryWorldModel ~= v_u_223 then
													p224.Viewmodel:Destroy()
													return
												end
												p224.WepId = v_u_218
												p224.IsSecondary = true
												p224.IsMirrored = v_u_220
												local v_u_225 = p224.Viewmodel.Model
												v_u_225.HumanoidRootPart.Anchored = false
												local v226 = p224.Config.IsAPistol
												local v227 = p224.Config.BulletsPerShot and p224.Config.BulletsPerShot >= 5 and true or false
												local v228 = p224.Config.IsMelee
												local v229
												if p224.Config.LODModel then
													v229 = v_u_2.common.SharedResources.LOD[p224.Config.LODModel]:Clone()
												elseif v226 then
													v229 = v_u_2.common.SharedResources.LOD.DefaultPistol:Clone()
												elseif v227 then
													v229 = v_u_2.common.SharedResources.LOD.DefaultShotgun:Clone()
												elseif v228 then
													v229 = v_u_2.common.SharedResources.LOD.DefaultKatana:Clone()
												else
													v229 = v_u_2.common.SharedResources.LOD.DefaultRifle:Clone()
												end
												local v230 = Instance.new("Weld")
												v230.Part0 = v229.Handle
												v230.Part1 = v_u_225.KeyParts.Handle
												v230.C0 = v230.C0 * (p224.Config.LODOffset or CFrame.new())
												v230.Parent = v229
												v229.Parent = nil
												local v231 = p224.Config.ReplicationOffset or CFrame.new()
												if v_u_220 then
													v_u_225.HumanoidRootPart.Anchored = true
													p224.HRPWeld = nil
													p224.HRPWeldBaseC0 = v231
													p224.HRPWeldBase = v231
													p224.HeadRef = v_u_160
												else
													local v232 = Instance.new("Weld")
													v232.Part0 = v_u_225.HumanoidRootPart
													v232.Part1 = v_u_160
													v232.C0 = v232.C0 * v231
													v232.Parent = v_u_225
													p224.HRPWeldBaseC1 = v232.C1
													p224.HRPWeldBase = v232.C0
													p224.HRPWeldBaseC0 = v232.C0
													p224.HRPWeld = v232
												end
												v_u_130.SecondaryWorldModel.LowPolyModel = v229
												v_u_130.SecondaryWorldModel.HighPolyModel = v_u_225.Weapon
												v_u_130.SecondaryWorldModel.Attachments = v_u_225.Attachments
												local v_u_233 = v_u_225.KeyParts:GetChildren()
												function v_u_130.SecondaryWorldModel.HideKeyparts(p234)
													-- upvalues: (copy) v_u_233, (copy) v_u_225
													for _, v235 in v_u_233 do
														if not v235:IsA("BasePart") then
															local v236
															if p234 then
																v236 = nil
															else
																v236 = v_u_225.KeyParts
															end
															v235.Parent = v236
														end
													end
												end
												v_u_225.Parent = workspace.Ignore
												v_u_225["Left Arm"].Transparency = 1
												v_u_225["Right Arm"].Transparency = 1
												v_u_130.SecondaryWorldModel.WeldedShoulders = {}
												v_u_130.SecondaryWorldModel.ArmModel = nil
												if v_u_220 then
													v_u_130.SecondaryWorldModel.ArmModel = v_u_57(v_u_225, v_u_129)
												else
													for _, v237 in v_u_130.Shoulders do
														if v237 and (v237.Name == "Left Shoulder" and (v237.Part1 and not (p224.Config.ArmIgnores and p224.Config.ArmIgnores[v237.Name]))) then
															local v238 = v_u_225:FindFirstChild(v237.Part1.Name)
															if v238 then
																local v239 = Instance.new("Weld")
																v239.Part0 = v237.Part1
																v239.Part1 = v238
																v239.C1 = v238.Size.Y > 3 and CFrame.new(0, -1, 0) or CFrame.new()
																v239.Parent = v_u_225
																v237.Enabled = false
																local v240 = v_u_130.SecondaryWorldModel.WeldedShoulders
																table.insert(v240, v237)
																break
															end
														end
													end
												end
												v_u_130.SecondaryWorldModel.Weapon = p224
												p224:Equip()
											end)
										elseif v_u_130.SecondaryWorldModel and v_u_130.SecondaryWorldModel.Weapon then
											local v241 = v_u_130.SecondaryWorldModel.Weapon
											if v241.HRPWeldBaseC0 then
												local v242 = CFrame.new()
												if v_u_220 then
													v242 = v_u_43
												elseif v219 then
													v241.QuickSwapAlpha = v241.QuickSwapAlpha or 0
													v241.QuickSwapAlpha = v241.QuickSwapAlpha + (1 - v241.QuickSwapAlpha) * v134 * 0.5
													v242 = CFrame.new():Lerp(v_u_41, v241.QuickSwapAlpha)
												end
												local v243 = v_u_130.LookGoal or 0
												local v244 = v243 / 1.5707963267948966
												local v245 = math.clamp(v244, 0, 1)
												local v246 = v243 * (v150.Aiming and 0.8 or 0.5)
												local v247 = v150.Proning and 1.5707963267948966 or 0
												v241.RecoilOffset = (v241.RecoilOffset or CFrame.identity):Lerp(CFrame.identity, v134)
												if v219 then
													v241.HRPWeldBase = v241.HRPWeldBaseC0 * v242
												else
													v241.HRPWeldBase = v241.HRPWeldBaseC0 * v242 * v241.RecoilOffset * (v150.Proning and CFrame.new(0, -1, -1) or CFrame.new()) * CFrame.new():Lerp(not v150.Proning and CFrame.new(0, 0, -0.5) or CFrame.new(), v245) * CFrame.Angles(-v247, 0, 0) * CFrame.Angles(-v246, 0, 0)
												end
												if v241.IsMirrored and v241.HeadRef then
													local v248 = v241.HeadRef.CFrame * v241.HRPWeldBase
													local v249 = CFrame.fromMatrix(v248.Position, v248.XVector * -1, v248.YVector, v248.ZVector)
													v241.Viewmodel.Model.HumanoidRootPart.CFrame = v249
												elseif v241.HRPWeld then
													v241.HRPWeld.C0 = v241.HRPWeld.C0:Lerp(v241.HRPWeldBase, v134)
												end
											end
											local v250 = v_u_27 * -0.3
											if v139 and v131 <= math.exp(v250) * 50 + 10 then
												v_u_130.SecondaryWorldModel.Weapon.LowPolyMode = false
												v_u_130.SecondaryWorldModel.HighPolyModel.Parent = v_u_130.SecondaryWorldModel.Weapon.Viewmodel.Model
												v_u_130.SecondaryWorldModel.Attachments.Parent = v_u_130.SecondaryWorldModel.Weapon.Viewmodel.Model
												v_u_130.SecondaryWorldModel.LowPolyModel.Parent = nil
												v_u_130.SecondaryWorldModel.HideKeyparts(false)
											elseif v131 > 5 then
												v_u_130.SecondaryWorldModel.Weapon.LowPolyMode = true
												if v_u_130.SecondaryWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
													v_u_130.SecondaryWorldModel.Attachments.Parent = nil
												end
												v_u_130.SecondaryWorldModel.HideKeyparts(true)
												v_u_130.SecondaryWorldModel.HighPolyModel.Parent = nil
												v_u_130.SecondaryWorldModel.LowPolyModel.Parent = v_u_130.SecondaryWorldModel.Weapon.Viewmodel.Model
											end
										end
										if v_u_220 and (v_u_130.WorldModel and v_u_130.WorldModel.Weapon) then
											local v251 = v_u_130.WorldModel.Weapon
											if v251.HRPWeldBaseC0 and v251.HRPWeldBase then
												local v252 = v251.HRPWeldBase * v_u_42
												v251.HRPWeld.C0 = v251.HRPWeld.C0:Lerp(v252, v134)
											end
										end
									elseif v_u_130.SecondaryWorldModel then
										DestroySecondaryModel(v_u_130)
									end
									local _ = v150.OffHandActive
									local v253 = v150.OffHandEquipped
									local v_u_254 = v150.OffHandWepId
									local v255
									if v253 then
										if v253 == "" then
											v255 = false
										else
											v255 = v253 ~= false
										end
									else
										v255 = v253
									end
									if v255 and v_u_160 then
										if not v_u_130.OffHandWorldModel then
											v_u_130.OffHandWorldModel = {}
										end
										local v256 = v_u_130.OffHandWorldModel.Equipped == v253 and v_u_130.OffHandWorldModel.Weapon
										if v256 then
											v256 = v_u_130.OffHandWorldModel.Weapon.WepId ~= v_u_254
										end
										if v256 then
											if v_u_130.OffHandWorldModel and v_u_130.OffHandWorldModel.Weapon then
												DestroyOffHandModel(v_u_130)
												v_u_130.OffHandWorldModel = {}
											end
											v_u_130.OffHandWorldModel.Equipped = v253
											local v_u_257 = v_u_130.OffHandWorldModel
											v_u_130.OffHandWorldModel.Promise = GetWeapon(v253, nil, v_u_129)
											v_u_130.OffHandWorldModel.Promise:andThen(function(p258)
												-- upvalues: (copy) v_u_130, (copy) v_u_257, (copy) v_u_254, (ref) v_u_2, (copy) v_u_160
												if v_u_130.OffHandWorldModel ~= v_u_257 then
													p258.Viewmodel:Destroy()
													return
												end
												p258.WepId = v_u_254
												p258.IsOffHand = true
												local v_u_259 = p258.Viewmodel.Model
												v_u_259.HumanoidRootPart.Anchored = false
												local v260 = p258.Config.IsAPistol
												local v261 = p258.Config.BulletsPerShot
												if v261 then
													v261 = p258.Config.BulletsPerShot >= 5
												end
												local v262 = p258.Config.IsMelee
												local v263
												if p258.Config.LODModel then
													v263 = v_u_2.common.SharedResources.LOD[p258.Config.LODModel]:Clone()
												elseif v260 then
													v263 = v_u_2.common.SharedResources.LOD.DefaultPistol:Clone()
												elseif v261 then
													v263 = v_u_2.common.SharedResources.LOD.DefaultShotgun:Clone()
												elseif v262 then
													v263 = v_u_2.common.SharedResources.LOD.DefaultKatana:Clone()
												else
													v263 = v_u_2.common.SharedResources.LOD.DefaultRifle:Clone()
												end
												local v264 = Instance.new("Weld")
												v264.Part0 = v263.Handle
												v264.Part1 = v_u_259.KeyParts.Handle
												v264.C0 = v264.C0 * (p258.Config.LODOffset or CFrame.new())
												v264.Parent = v263
												v263.Parent = nil
												local v265 = p258.Config.ReplicationOffset or CFrame.new()
												local v266 = Instance.new("Weld")
												v266.Part0 = v_u_259.HumanoidRootPart
												v266.Part1 = v_u_160
												v266.C0 = v266.C0 * v265
												v266.Parent = v_u_259
												p258.HRPWeldBaseC1 = v266.C1
												p258.HRPWeldBase = v266.C0
												p258.HRPWeldBaseC0 = v266.C0
												p258.HRPWeld = v266
												v_u_130.OffHandWorldModel.LowPolyModel = v263
												v_u_130.OffHandWorldModel.HighPolyModel = v_u_259.Weapon
												v_u_130.OffHandWorldModel.Attachments = v_u_259.Attachments
												local v_u_267 = v_u_259.KeyParts:GetChildren()
												function v_u_130.OffHandWorldModel.HideKeyparts(p268)
													-- upvalues: (copy) v_u_267, (copy) v_u_259
													for _, v269 in v_u_267 do
														if not v269:IsA("BasePart") then
															local v270
															if p268 then
																v270 = nil
															else
																v270 = v_u_259.KeyParts
															end
															v269.Parent = v270
														end
													end
												end
												v_u_259.Parent = workspace.Ignore
												v_u_259["Left Arm"].Transparency = 1
												v_u_259["Right Arm"].Transparency = 1
												v_u_130.OffHandWorldModel.WeldedShoulders = {}
												for _, v271 in v_u_130.Shoulders do
													if v271 and (v271.Name == "Left Shoulder" and (v271.Part1 and not (p258.Config.ArmIgnores and p258.Config.ArmIgnores[v271.Name]))) then
														local v272 = v_u_259:FindFirstChild(v271.Part1.Name)
														if v272 then
															if v_u_130.WorldModel and (v_u_130.WorldModel.Weapon and v_u_130.WorldModel.Weapon.Viewmodel) then
																local v273 = v_u_130.WorldModel.Weapon.Viewmodel.Model
																if v273 then
																	for _, v274 in v273:GetChildren() do
																		if v274:IsA("Weld") and v274.Part0 == v271.Part1 then
																			v274:Destroy()
																			break
																		end
																	end
																end
															end
															local v275 = Instance.new("Weld")
															v275.Part0 = v271.Part1
															v275.Part1 = v272
															v275.C1 = v272.Size.Y > 3 and CFrame.new(0, -1, 0) or CFrame.new()
															v275.Parent = v_u_259
															v271.Enabled = false
															local v276 = v_u_130.OffHandWorldModel.WeldedShoulders
															table.insert(v276, v271)
														end
													end
												end
												v_u_130.OffHandWorldModel.Weapon = p258
												p258:Equip()
											end)
										elseif v_u_130.OffHandWorldModel and v_u_130.OffHandWorldModel.Weapon then
											local v277 = v_u_130.OffHandWorldModel.Weapon
											if v277.HRPWeldBaseC0 and v277.HRPWeld then
												v277.HRPWeldBase = v277.HRPWeldBaseC0 * v_u_44
												v277.HRPWeld.C0 = v277.HRPWeld.C0:Lerp(v277.HRPWeldBase, v134)
											end
											local v278 = v_u_27 * -0.3
											if v139 and v131 <= math.exp(v278) * 50 + 10 then
												v_u_130.OffHandWorldModel.Weapon.LowPolyMode = false
												v_u_130.OffHandWorldModel.HighPolyModel.Parent = v_u_130.OffHandWorldModel.Weapon.Viewmodel.Model
												v_u_130.OffHandWorldModel.Attachments.Parent = v_u_130.OffHandWorldModel.Weapon.Viewmodel.Model
												v_u_130.OffHandWorldModel.LowPolyModel.Parent = nil
												v_u_130.OffHandWorldModel.HideKeyparts(false)
											elseif v131 > 5 then
												v_u_130.OffHandWorldModel.Weapon.LowPolyMode = true
												if v_u_130.OffHandWorldModel.Weapon.Viewmodel.ViewmodelLoaded then
													v_u_130.OffHandWorldModel.Attachments.Parent = nil
												end
												v_u_130.OffHandWorldModel.HideKeyparts(true)
												v_u_130.OffHandWorldModel.HighPolyModel.Parent = nil
												v_u_130.OffHandWorldModel.LowPolyModel.Parent = v_u_130.OffHandWorldModel.Weapon.Viewmodel.Model
											end
										end
									elseif v_u_130.OffHandWorldModel then
										DestroyOffHandModel(v_u_130)
									end
								end
							end
						end
					end
				else
					v_u_59(v_u_129)
				end
			end
		end)
	end,
	["GetPlayerLookDirection"] = function(_, p279) -- name: GetPlayerLookDirection
		-- upvalues: (copy) v_u_26
		local v280 = v_u_26[p279]
		if v280 and (v280.LookAttachment and v280.Head) then
			return (v280.LookAttachment.WorldPosition - v280.Head.Position).Unit
		else
			return nil
		end
	end
}
function GetWeapon(p_u_282, p_u_283, p_u_284) -- name: GetWeapon
	-- upvalues: (copy) v_u_12, (copy) v_u_11, (copy) v_u_22, (copy) v_u_19
	return v_u_12.new(function(p_u_285)
		-- upvalues: (ref) v_u_11, (copy) p_u_282, (copy) p_u_283, (ref) v_u_22, (copy) p_u_284, (ref) v_u_19
		v_u_11:StreamViewmodel(p_u_282):andThen(function(p286)
			-- upvalues: (ref) p_u_283, (ref) v_u_22, (ref) p_u_284, (copy) p_u_285, (ref) v_u_19, (ref) p_u_282
			local v287 = p286:Clone()
			v287.HumanoidRootPart.Anchored = false
			local v288
			if p_u_283 and p_u_283 ~= "" then
				v288 = v_u_22:RetrieveAttachmentData(p_u_283, p_u_284)
			else
				v288 = nil
			end
			p_u_285(v_u_19.new(p_u_282, v287, v288))
		end)
	end)
end
function DestroyModel(p289) -- name: DestroyModel
	if p289.WorldModel then
		if p289.WorldModel.Promise then
			p289.WorldModel.Promise:cancel()
		end
		if p289.WorldModel.WeldedShoulders then
			for _, v290 in p289.WorldModel.WeldedShoulders do
				if v290 then
					v290.Enabled = true
				end
			end
		else
			for _, v291 in p289.Shoulders do
				if v291 then
					v291.Enabled = true
				end
			end
		end
		if p289.WorldModel.Weapon then
			p289.WorldModel.Weapon.Viewmodel:Destroy()
			p289.WorldModel.LowPolyModel:Destroy()
		end
		p289.WorldModel = {}
	end
end
function DestroySecondaryModel(p292) -- name: DestroySecondaryModel
	if p292.SecondaryWorldModel then
		if p292.SecondaryWorldModel.Promise then
			p292.SecondaryWorldModel.Promise:cancel()
		end
		if p292.SecondaryWorldModel.WeldedShoulders then
			for _, v293 in p292.SecondaryWorldModel.WeldedShoulders do
				if v293 then
					v293.Enabled = true
				end
			end
		end
		if p292.SecondaryWorldModel.ArmModel then
			p292.SecondaryWorldModel.ArmModel:Destroy()
		end
		if p292.SecondaryWorldModel.Weapon then
			p292.SecondaryWorldModel.Weapon.Viewmodel:Destroy()
			p292.SecondaryWorldModel.LowPolyModel:Destroy()
		end
		p292.SecondaryWorldModel = nil
	end
end
function DestroyOffHandModel(p294) -- name: DestroyOffHandModel
	if p294.OffHandWorldModel then
		if p294.OffHandWorldModel.Promise then
			p294.OffHandWorldModel.Promise:cancel()
		end
		if p294.WorldModel and (p294.WorldModel.Weapon and p294.OffHandWorldModel.WeldedShoulders) then
			local v295 = p294.WorldModel.Weapon.Viewmodel.Model
			local v296 = p294.WorldModel.Weapon
			p294.WorldModel.WeldedShoulders = p294.WorldModel.WeldedShoulders or {}
			for _, v297 in p294.OffHandWorldModel.WeldedShoulders do
				if v297 and v297.Part1 then
					if v296.Config.ArmIgnores and v296.Config.ArmIgnores[v297.Name] then
						v297.Enabled = true
					else
						local v298 = v295:FindFirstChild(v297.Part1.Name)
						if v298 then
							local v299 = false
							for _, v300 in v295:GetChildren() do
								if v300:IsA("Weld") and (v300.Part0 == v297.Part1 and v300.Part1 == v298) then
									v299 = true
									break
								end
							end
							if not v299 then
								local v301 = Instance.new("Weld")
								v301.Part0 = v297.Part1
								v301.Part1 = v298
								v301.C1 = v298.Size.Y > 3 and CFrame.new(0, -1, 0) or CFrame.new()
								v301.Parent = v295
							end
							local v302 = false
							for _, v303 in p294.WorldModel.WeldedShoulders do
								if v303 == v297 then
									v302 = true
									break
								end
							end
							if not v302 then
								local v304 = p294.WorldModel.WeldedShoulders
								table.insert(v304, v297)
							end
						else
							v297.Enabled = true
						end
						v297.Enabled = false
					end
				end
			end
		elseif p294.OffHandWorldModel.WeldedShoulders then
			for _, v305 in p294.OffHandWorldModel.WeldedShoulders do
				if v305 then
					v305.Enabled = true
				end
			end
		end
		if p294.OffHandWorldModel.Weapon then
			p294.OffHandWorldModel.Weapon.Viewmodel:Destroy()
			p294.OffHandWorldModel.LowPolyModel:Destroy()
		end
		p294.OffHandWorldModel = nil
	end
end
return v281