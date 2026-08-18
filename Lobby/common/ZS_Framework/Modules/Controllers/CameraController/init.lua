local v_u_1 = UserSettings():GetService("UserGameSettings")
local v2 = game:GetService("ContextActionService")
local v3 = game:GetService("CollectionService")
local v4 = game:GetService("ReplicatedStorage")
local v_u_5 = game:GetService("UserInputService")
local v_u_6 = game:GetService("RunService")
local v_u_7 = game:GetService("Players").LocalPlayer
local v_u_8 = workspace.CurrentCamera
local v_u_9 = script.Resources
workspace:WaitForChild("Ignore")
v4.common:WaitForChild("Remotes")
local v10 = script:WaitForChild("CameraUtils")
local v_u_11 = script.Parent
v_u_11.Parent:WaitForChild("Classes")
local v12 = v_u_11.Parent:WaitForChild("Utils")
local v13 = v_u_11.Parent:WaitForChild("Shared")
local v14 = game.ReplicatedStorage.common.RedEvents
local v15 = require(v12:WaitForChild("SpringUtil"))
local v_u_16 = require(v4.Packages.Fusion)
local v_u_17 = require(v4.common.skillTree.SkillTreeData)
local v_u_18 = require(v4.common.skillTree.SkillTreeMain)
local v_u_19 = CFrame.new()
local v_u_20 = v15.new(0)
v_u_20.Target = 0
v_u_20.Speed = 15
v_u_20.Damper = 0.9
local v21 = v15.new(0)
v21.Target = 0
v21.Speed = 12
v21.Damper = 0.9
local v22 = v15.new((Vector3.new()))
v22.Target = Vector3.new(0.01, 0.01, 0.01)
v22.Speed = 12
v22.Damper = 0.9
local v_u_23 = 0
local v_u_24 = nil
CFrame.new()
local v_u_25 = {}
local v_u_26 = {}
local v_u_27 = CFrame.new()
local v_u_28 = nil
local v_u_29 = nil
local v_u_30 = CFrame.new()
local v_u_31 = CFrame.new()
local v_u_32 = CFrame.new()
local v_u_33 = CFrame.new()
local v_u_34 = {}
local v_u_35 = false
local v_u_36 = {}
local v_u_37 = nil
local v_u_38 = 0
local function v_u_47(p39) -- name: IsInThumbstickArea
	-- upvalues: (copy) v_u_7
	local v40 = v_u_7:FindFirstChildOfClass("PlayerGui")
	if v40 then
		v40 = v40:FindFirstChild("TouchGui")
	end
	if v40 then
		v40 = v40:FindFirstChild("TouchControlFrame")
	end
	if not v40 then
		return false
	end
	local v41 = v40:FindFirstChild("ThumbstickFrame")
	if v41 and v41.Visible then
		local v42 = v41.AbsolutePosition
		local v43 = v42 + v41.AbsoluteSize
		if p39.X >= v42.X and (p39.Y >= v42.Y and (p39.X <= v43.X and p39.Y <= v43.Y)) then
			return true
		end
	end
	local v44 = v40:FindFirstChild("DynamicThumbstickFrame")
	if v44 and v44.Visible then
		local v45 = v44.AbsolutePosition
		local v46 = v45 + v44.AbsoluteSize
		if p39.X >= v45.X and (p39.Y >= v45.Y and (p39.X <= v46.X and p39.Y <= v46.Y)) then
			return true
		end
	end
	return false
end
local v_u_48 = 1
local v_u_49 = CFrame.new()
CFrame.new()
CFrame.new()
local v_u_50 = nil
local v_u_51 = nil
local _ = Vector2.new(1, 0.77) * 0.06981317007977318
local v_u_52 = require(v10:WaitForChild("RecoilUtil"))
local v_u_53 = require(v10:WaitForChild("TransparencyUtil"))
local v_u_54 = require(v_u_11:WaitForChild("LocalPlayerController"))
local v_u_55 = require(v12:WaitForChild("BobbingUtil"))
local v_u_56 = require(v13:WaitForChild("SharedSprings"))
local v_u_57 = require(v12:WaitForChild("RaycastUtil"))
local v_u_58 = require(v12:WaitForChild("CursorRecoilUtil"))
local v59 = require(v10:WaitForChild("CameraShaker"))
local v_u_60 = require("@game/ReplicatedStorage/common/Settings")
local v_u_61 = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local v_u_62 = require(v_u_11.CameraController.CameraUtils.CameraShaker.CameraShakePresets)
local v63 = require(v14.Framework.CameraEvent)
local v64 = require(v14.Framework.CameraShakeEvent)
local v_u_65 = {}
local v_u_66 = 0
local v_u_67 = {}
local v_u_68 = 0
local v_u_69 = {}
local v_u_70 = 0
local v_u_71 = {}
local v_u_72 = Vector2.new(0, 0)
local v_u_73 = Vector2.new(0, 0)
local v_u_74 = CFrame.new(3, 1.5, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1)
local v_u_75 = CFrame.new(3, 1.5, 3)
local v_u_76 = v_u_74
local v_u_77 = {}
local v_u_78 = {}
local v_u_79 = {}
local v_u_80 = 0
local v_u_81 = false
local function v_u_82() -- name: getMaxZoom
	-- upvalues: (copy) v_u_61, (copy) v_u_60
	return v_u_61(v_u_60.Camera.MaxCameraDistance)
end
local v_u_83 = 0
local v_u_84 = 0
local v_u_85 = false
local v_u_86 = Enum.RenderPriority.Camera.Value + 1
local v_u_87 = CFrame.new(0, 1.5, 0)
local v_u_88 = Vector3.new(0, 0, 1)
local v_u_123 = {
	["X"] = 0,
	["Y"] = 0,
	["FOV"] = 70,
	["Enabled"] = false,
	["AimCFrame"] = CFrame.new(),
	["CameraShaker"] = v59.new(Enum.RenderPriority.Camera.Value, "shakeOne"),
	["CameraShakerAlt"] = v59.new(Enum.RenderPriority.Camera.Value, "shakeTwo"),
	["Init"] = function(_) -- name: Init
		-- upvalues: (copy) v_u_53, (copy) v_u_11, (ref) v_u_83
		v_u_53:Init()
		MakeConnections()
		task.defer(function()
			-- upvalues: (ref) v_u_11, (ref) v_u_83
			require(v_u_11:WaitForChild("WeaponController")).GunFired:Connect(function()
				-- upvalues: (ref) v_u_83
				v_u_83 = os.clock()
			end)
		end)
	end,
	["GetCameraShakeCF"] = function(_) -- name: GetCameraShakeCF
		-- upvalues: (ref) v_u_31
		return v_u_31
	end,
	["GetCameraBoneAngle"] = function(_) -- name: GetCameraBoneAngle
		-- upvalues: (ref) v_u_30
		return v_u_30
	end,
	["NewRecoil"] = function(_, p89) -- name: NewRecoil
		-- upvalues: (copy) v_u_26, (copy) v_u_52
		v_u_26[p89] = v_u_52.new(p89)
		return v_u_26[p89]
	end,
	["SetCameraBone"] = function(_, p90, p91) -- name: SetCameraBone
		-- upvalues: (ref) v_u_28, (ref) v_u_29
		v_u_28 = p90
		v_u_29 = p91
	end,
	["ForceTeleport"] = function(_, p92) -- name: ForceTeleport
		-- upvalues: (copy) v_u_34
		local v93 = v_u_34
		table.insert(v93, p92)
	end,
	["GetZoomDistance"] = function(_) -- name: GetZoomDistance
		-- upvalues: (ref) v_u_80
		return v_u_80
	end,
	["SetZoomDistance"] = function(_, p94) -- name: SetZoomDistance
		-- upvalues: (ref) v_u_80, (copy) v_u_61, (copy) v_u_60, (copy) v_u_54
		local v95 = v_u_61(v_u_60.Camera.MaxCameraDistance)
		v_u_80 = math.clamp(p94, 0, v95)
		v_u_54.RequestThirdPerson = v_u_80 >= 1
	end,
	["SetMouseUnlocked"] = function(_, p96, p97) -- name: SetMouseUnlocked
		-- upvalues: (copy) v_u_67, (ref) v_u_68
		local v98 = table.find(v_u_67, p96)
		if p97 and not v98 then
			local v99 = v_u_67
			table.insert(v99, p96)
			v_u_68 = v_u_68 + 1
		elseif not p97 and v98 then
			table.remove(v_u_67, v98)
			v_u_68 = v_u_68 - 1
		end
	end,
	["SetMouseLockPosition"] = function(_, p100, p101) -- name: SetMouseLockPosition
		-- upvalues: (copy) v_u_69, (ref) v_u_70
		local v102 = table.find(v_u_69, p100)
		if p101 and not v102 then
			local v103 = v_u_69
			table.insert(v103, p100)
			v_u_70 = v_u_70 + 1
		elseif not p101 and v102 then
			table.remove(v_u_69, v102)
			v_u_70 = v_u_70 - 1
		end
	end,
	["MouseIconEnabled"] = function(_, p104, p105, p106) -- name: MouseIconEnabled
		-- upvalues: (copy) v_u_65, (copy) v_u_71, (copy) v_u_5, (ref) v_u_66
		local v107 = table.find(v_u_65, p104)
		if p105 and not v107 then
			v_u_71[p104] = p106
			v_u_5.MouseIcon = p106 or ""
			local v108 = v_u_65
			table.insert(v108, p104)
			v_u_66 = v_u_66 + 1
			return
		end
		if not p105 and v107 then
			table.remove(v_u_65, v107)
			v_u_66 = v_u_66 - 1
			local v109 = v_u_71[p104]
			if v109 ~= nil and v_u_5.MouseIcon == v109 then
				local v110 = false
				for v111 = #v_u_65, 1, -1 do
					local v112 = v_u_71[v_u_65[v111]]
					if v112 then
						v_u_5.MouseIcon = v112
						v110 = true
						break
					end
				end
				if not v110 then
					v_u_5.MouseIcon = ""
				end
			end
		end
	end,
	["SetMagnificationSensitivity"] = function(_, p113) -- name: SetMagnificationSensitivity
		-- upvalues: (ref) v_u_48
		v_u_48 = p113
	end,
	["GetMagnificationSensitivity"] = function(_) -- name: GetMagnificationSensitivity
		-- upvalues: (copy) v_u_54, (ref) v_u_48
		local v114 = v_u_54.CurrentWeapon
		return not (v114 and v114.Aiming) and 1 or v_u_48
	end,
	["GetSensitivity"] = function(_) -- name: GetSensitivity
		-- upvalues: (copy) v_u_54, (copy) v_u_61, (copy) v_u_60
		local v115 = v_u_54.CurrentWeapon
		if v115 and v115.Aiming then
			return v_u_61(v_u_60.Controls.AimingSensitivity)
		else
			return v_u_61(v_u_60.Controls.Sensitivity)
		end
	end,
	["ShouldGunRest"] = function(_) -- name: ShouldGunRest
		-- upvalues: (copy) v_u_54, (ref) v_u_83, (ref) v_u_84
		if not v_u_54.ThirdPerson then
			return false
		end
		local v116 = v_u_54.CurrentWeapon
		if not v116 then
			return false
		end
		if v116.Aiming then
			return false
		end
		local v117 = os.clock()
		local v118 = v117 - v_u_83 < 2
		local v119 = v117 - v_u_84 < 2
		local v120 = not v118
		if v120 then
			v120 = not v119
		end
		return v120
	end,
	["LookAt"] = function(_, p121) -- name: LookAt
		-- upvalues: (copy) v_u_123
		local v122
		if p121 == "s" then
			v122 = nil
		else
			v122 = p121
		end
		v_u_123.Tracking = v122
		v_u_123.TrackingEnd = os.clock() + 1
	end
}
v_u_6.Heartbeat:Connect(function(_)
	-- upvalues: (copy) v_u_54, (ref) v_u_35, (copy) v_u_123, (ref) v_u_70, (copy) v_u_18, (copy) v_u_16, (copy) v_u_5, (ref) v_u_68, (ref) v_u_66
	local v124 = v_u_54.ThirdPerson
	if v124 then
		v124 = not v_u_54.CurrentWeapon
	end
	local v125
	if v124 then
		v125 = v_u_35
	else
		v125 = v124
	end
	if v_u_123.Enabled then
		if v_u_70 > 0 or v125 and not (v_u_18.isSkillTreeOpen and v_u_16.peek(v_u_18.isSkillTreeOpen)) then
			v_u_5.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
		elseif v_u_68 <= 0 and not v124 then
			v_u_5.MouseBehavior = Enum.MouseBehavior.LockCenter
		else
			v_u_5.MouseBehavior = Enum.MouseBehavior.Default
		end
		v_u_5.MouseIconEnabled = v_u_66 > 0 and true or v124
	end
end)
function v_u_123.SetEnabled(_, p126) -- name: SetEnabled
	-- upvalues: (copy) v_u_123, (copy) v_u_6, (copy) v_u_86, (copy) v_u_54, (copy) v_u_8, (ref) v_u_48, (copy) v_u_61, (copy) v_u_60, (ref) v_u_72, (copy) v_u_1, (ref) v_u_73, (ref) v_u_31, (ref) v_u_32, (copy) v_u_58, (copy) v_u_55, (ref) v_u_23, (copy) v_u_20, (ref) v_u_27, (ref) v_u_30, (ref) v_u_33, (ref) v_u_19, (ref) v_u_81, (copy) v_u_56, (ref) v_u_88, (copy) v_u_53, (copy) v_u_79, (ref) v_u_76, (copy) v_u_57, (copy) v_u_87, (ref) v_u_50, (ref) v_u_51, (copy) v_u_9, (copy) v_u_34, (ref) v_u_85, (ref) v_u_84, (ref) v_u_83, (ref) v_u_49, (ref) v_u_24, (ref) v_u_80, (copy) v_u_75, (copy) v_u_74
	v_u_123.Enabled = p126
	if p126 then
		v_u_6:BindToRenderStep("CameraController", v_u_86, function(p127)
			-- upvalues: (ref) v_u_54, (ref) v_u_8, (ref) v_u_48, (ref) v_u_61, (ref) v_u_60, (ref) v_u_72, (ref) v_u_1, (ref) v_u_73, (ref) v_u_123, (ref) v_u_31, (ref) v_u_32, (ref) v_u_58, (ref) v_u_55, (ref) v_u_23, (ref) v_u_20, (ref) v_u_27, (ref) v_u_30, (ref) v_u_33, (ref) v_u_19, (ref) v_u_81, (ref) v_u_56, (ref) v_u_88, (ref) v_u_53, (ref) v_u_79, (ref) v_u_76, (ref) v_u_57, (ref) v_u_87, (ref) v_u_50, (ref) v_u_51, (ref) v_u_9, (ref) v_u_34, (ref) v_u_85, (ref) v_u_84, (ref) v_u_83, (ref) v_u_49, (ref) v_u_24, (ref) v_u_80, (ref) v_u_75, (ref) v_u_74
			if not v_u_54.States.IsDead then
				v_u_8.CameraType = Enum.CameraType.Scriptable
			end
			local v128 = v_u_54.CurrentWeapon
			local v129 = 1
			local v130
			if v128 and v128.Aiming then
				v129 = v_u_48
				v130 = v_u_61(v_u_60.Controls.AimingSensitivity)
			else
				v130 = v_u_61(v_u_60.Controls.Sensitivity)
			end
			local v131 = v_u_72
			local v132 = v131.X * v_u_1.MouseSensitivity * 9 + v_u_73.X * v129
			local v133 = (v131.Y * v_u_1.MouseSensitivity * 9 + v_u_73.Y) * v129 * v_u_1:GetCameraYInvertValue()
			local v134 = v132 * v130
			local v135 = v133 * v130
			v_u_73 = Vector2.new()
			v_u_123.X = ((v_u_123.X - v134 / 150 * 1) % 6.283185307179586 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
			local v136 = v_u_123
			local v137 = v_u_123.Y - v135 / 150 * 1
			v136.Y = math.clamp(v137, -1.4, 1.4)
			if v_u_54.humanoid.Humanoid then
				v_u_54.humanoid.Humanoid.AutoRotate = false
			end
			if v_u_54.character and (v_u_54.hrp and v_u_54.PhysBall._fullyInitialized) then
				local v138 = p127 * 10
				local v139 = math.clamp(v138, 0.01, 1)
				local v140 = v_u_54.hrp.Position
				if v_u_54.PhysBall.isActive then
					v140 = v_u_54.PhysBall.chasis.CFrame.p
				end
				CalculateAngles(v140, v139)
				v_u_31 = v_u_123.CameraShaker:Update(p127)
				v_u_32 = v_u_123.CameraShakerAlt:Update(p127)
				local v141 = v_u_58
				local v142
				if v128 then
					v142 = v128.Aiming
				else
					v142 = v128
				end
				v141:Update(p127, v142)
				local v143 = v_u_55.cameraBobCF * CFrame.Angles(v_u_23, 0, v_u_20.Position) * v_u_27 * v_u_31 * (v_u_32 or CFrame.new())
				local v144 = v_u_30 * CFrame.new() * v_u_33
				v_u_19 = v_u_19:Lerp(v_u_54.States.Proning and CFrame.new(0, -1, 0) or CFrame.new(), v139)
				local v145 = v_u_54.ThirdPerson and v_u_54.hrp and 1 or 0
				local v146 = v145 == 1
				local v147 = v146 ~= v_u_81
				v_u_56.TPSpring.Target = v145
				if v147 then
					v_u_56.TPSpring.Position = v145
					if v146 then
						local v148 = CFrame.Angles(0, v_u_123.X, 0).LookVector
						local v149 = v148.X
						local v150 = v148.Z
						v_u_88 = Vector3.new(v149, 0, v150).Unit
					end
				end
				v_u_81 = v146
				local v151 = false
				if v_u_56.TPSpring.Position > 0.05 then
					if v_u_53.TransparencyModifier == 1 then
						v_u_53.TransparencyModifier = 0
						v_u_53:Update()
						for v152, v153 in v_u_79 do
							v152.Parent = v153
						end
					end
					v151 = true
					if not v_u_54.States.IsDead then
						v_u_123.AimCFrame = CFrame.new(v140) * CFrame.Angles(0, v_u_123.X, 0) * CFrame.Angles(v_u_123.Y, 0, 0) * CFrame.new(0, 1.5, 0):Lerp(v_u_76, v_u_56.TPSpring.Position) * v143
						v_u_8.CFrame = v_u_123.AimCFrame * v144
					end
					local v154 = v_u_54.hrp.Position + Vector3.new(0, 1.5, 0)
					local v155 = v_u_57.CustomRay(v154, v_u_8.CFrame.Position, true)
					if v155.Instance and not v_u_54.States.IsDead then
						v_u_8.CFrame = v_u_8.CFrame - (v_u_8.CFrame.Position - v155.Position) + (v154 - v_u_8.CFrame.Position).Unit
					end
				else
					if v_u_53.TransparencyModifier == 0 then
						v_u_53.TransparencyModifier = 1
						v_u_53:Update()
						for v156, _ in v_u_79 do
							v156.Parent = game.ReplicatedStorage
						end
					end
					if not v_u_54.States.IsDead then
						v_u_123.AimCFrame = CFrame.new(v140) * v_u_87 * v_u_19 * CFrame.Angles(0, v_u_123.X, 0) * CFrame.Angles(v_u_123.Y, 0, 0) * CFrame.new(0, 0, 0):Lerp(v_u_76 * CFrame.new(0, -1.5, 0), v_u_56.TPSpring.Position) * v143
						v_u_8.CFrame = v_u_123.AimCFrame * v144
					end
				end
				if v_u_54.ThirdPerson or (not v_u_54.hrp or (not v_u_54.hrp.Parent or v_u_54.States.Proning)) then
					if v_u_50 then
						v_u_50.Parent = v_u_9
					end
				else
					if not (v_u_50 and (v_u_50.Parent and (v_u_51.Parent and v_u_51.Parent.Parent))) then
						if v_u_51 and (v_u_51.Parent and not v_u_51.Parent.Parent) then
							v_u_51.Parent:Destroy()
						end
						if v_u_50 then
							v_u_50:Destroy()
						end
						if v_u_51 then
							v_u_51:Destroy()
						end
						v_u_50 = v_u_9.Collision:Clone()
						v_u_51 = Instance.new("Weld")
						v_u_51.Part0 = v_u_54.hrp.Parent.Head
						v_u_51.Part1 = v_u_50
						v_u_51.Parent = v_u_51.Part0
						v_u_51.C0 = v_u_51.C0 * CFrame.new(0, -1, -1.5)
						v_u_50.Name = "HeadCol"
						v_u_50.Parent = workspace.Ignore
					end
					if v_u_50.Parent == v_u_9 then
						v_u_50.Parent = workspace.Ignore
					end
				end
				if #v_u_34 > 0 then
					local v157 = v_u_34[1]
					local v158 = nil
					if typeof(v157) == "Vector3" then
						v157 = CFrame.new(v157) * v_u_54.PhysBall.chasis.CFrame.Rotation
					elseif typeof(v157) ~= "CFrame" then
						v157 = v158
					end
					v140 = v157.Position
					v_u_54.PhysBall.chasis.Velocity = Vector3.new()
					v_u_54.PhysBall.chasis.CFrame = v157
					v_u_54.character:PivotTo(v157)
					table.remove(v_u_34, 1)
				end
				local v159 = Vector3.new()
				if v_u_54.humanoid.Humanoid then
					v159 = v_u_54.humanoid.Humanoid.MoveDirection
				end
				local v160
				if v128 then
					v160 = v128.Aiming
				else
					v160 = v128
				end
				if v_u_85 and not v160 then
					v_u_84 = os.clock()
				end
				v_u_85 = v160
				local v161 = os.clock()
				local v162 = v160 or (v161 - v_u_83 < 1.5 or v161 - v_u_84 < 1.5)
				local v163
				if v151 then
					v163 = v_u_54.States.Sprinting or v_u_54.States.Jogging or not (v_u_54.CurrentWeapon and v162)
				else
					v163 = v151
				end
				local v164 = nil
				local v165 = 5
				if v151 then
					if v163 then
						if v159.Magnitude > 0.1 then
							v164 = v159.Unit
						end
					else
						local v166 = CFrame.Angles(0, v_u_123.X, 0).LookVector
						local v167 = v166.X
						local v168 = v166.Z
						v164 = Vector3.new(v167, 0, v168).Unit
						v165 = 10
					end
					if v164 then
						local v169 = v_u_88
						local v170 = v169.Z
						local v171 = v169.X
						local v172 = math.atan2(v170, v171)
						local v173 = v164.Z
						local v174 = v164.X
						local v175 = (v172 + ((math.atan2(v173, v174) - v172 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * p127 * v165 + 6.283185307179586) % 6.283185307179586
						local v176 = math.cos(v175)
						local v177 = math.sin(v175)
						v_u_88 = Vector3.new(v176, 0, v177)
					end
					v_u_49 = CFrame.new(Vector3.new(0, 0, 0), v_u_88)
				else
					v_u_49 = CFrame.Angles(0, v_u_123.X, 0)
				end
				v_u_54.hrp.CFrame = CFrame.new(v140) * v_u_49 * (v_u_54.PhysBall.slideVector or CFrame.new()) * (v_u_54.ProneCF or CFrame.new())
				if v_u_54.PhysBall then
					v_u_54.PhysBall:update(p127)
				end
				v_u_24 = v140
				local v178
				if v_u_61(v_u_60.Camera.ScrollWheelZoom) then
					v178 = v_u_80
				else
					v178 = v_u_61(v_u_60.Camera.MaxCameraDistance)
				end
				local v179
				if v178 >= 1 then
					local v180 = v178 / v_u_61(v_u_60.Camera.MaxCameraDistance)
					local v181 = math.clamp(v180, 0, 1)
					local v182
					if v128 then
						v182 = (1 - v181 * 0.1) * 2
						if v_u_54.ThirdPersonSide < 0 then
							v182 = -v182
						end
					else
						v182 = 0
					end
					if v128 and v128.Aiming then
						local v183 = v178 * 0.5
						v178 = math.max(v183, 1) or v178
					end
					v179 = CFrame.new(v182, 1.5, v178)
				else
					v179 = v128 and v128.Aiming and v_u_75 or v_u_74
					if v128 and v_u_54.ThirdPersonSide < 0 then
						v179 = v179 * CFrame.new(-4, 0, 0)
					end
				end
				if v147 then
					v_u_76 = v179
				else
					v_u_76 = v_u_76:Lerp(v179, v139)
				end
				local v184 = v_u_61(v_u_60.Graphics.BaseFOV) * 0.8
				if v128 and (v128.Config and v128.Config.AimFOVMultiplier) then
					v184 = v184 * v128.Config.AimFOVMultiplier
				end
				if not (v128 and (v128.Aiming and v184)) then
					v184 = v_u_61(v_u_60.Graphics.BaseFOV)
				end
				v_u_8.FieldOfView = Lerp(v_u_8.FieldOfView, v184, v139)
				if v_u_123.Tracking then
					local v185 = v_u_123.Tracking
					local v186
					if type(v185) == "userdata" and v_u_123.Tracking:IsA("BasePart") then
						v186 = v_u_123.Tracking.Position
					else
						v186 = v_u_123.Tracking
					end
					local v187 = v_u_8.CFrame.Position - v186
					local v188 = v187.X
					local v189 = v187.Z
					local v190 = math.atan2(v188, v189)
					local v191 = v187.Y / v187.Magnitude
					local v192 = -math.asin(v191)
					local v193 = math.clamp(v192, -1.4, 1.4)
					local v194 = v_u_123.TrackingEnd - os.clock()
					local v195 = Lerp
					local v196 = v139 * 5
					local v197 = 1 - v194 / 1
					local v198 = v195(v139, v196, (math.clamp(v197, 0, 1)))
					v_u_123.X = Lerp(v_u_123.X, v190, v198)
					v_u_123.Y = Lerp(v_u_123.Y, v193, v198)
				end
			end
		end)
	else
		v_u_6:UnbindFromRenderStep("CameraController")
	end
end
function v_u_123.Shake(_, ...) -- name: Shake
	-- upvalues: (copy) v_u_62, (copy) v_u_77, (copy) v_u_123, (copy) v_u_78
	local v199 = { ... }
	local v200 = v199[1]
	if v200 == "Sustained" then
		local v201 = v199[2]
		local v202 = v199[4] or 0.3
		if v199[3] then
			local v203 = v_u_62[v201]
			v_u_77[v201] = v203
			v203.fadeInDuration = v202
			v_u_123.CameraShakerAlt:ShakeSustain(v203)
			return
		end
		if v_u_77[v201] then
			v_u_77[v201]:StartFadeOut(v202)
			v_u_77[v201] = nil
			return
		end
	else
		if v200 == "Duration" then
			local v204 = v_u_62[v199[2]]
			local v205 = v199[3] or 1
			v204.fadeInDuration = v199[4] or 0.3
			v_u_123.CameraShakerAlt:ShakeSustain(v204)
			task.wait(v205)
			v204:StartFadeOut(v199[5] or 0.3)
			return
		end
		if v200 == "Single" then
			local v206 = v_u_62[v199[2]]
			v_u_123.CameraShakerAlt:Shake(v206)
			return
		end
		if v200 == "SingleCustom" then
			local v207 = v199[2] or 1
			local v208 = v199[3] or 1
			local v209 = v199[4]
			local v210 = v199[5]
			local v211 = v199[6]
			local v212 = v199[7]
			v_u_123.CameraShakerAlt:ShakeOnce(v207, v208, v209, v210, v211, v212)
			return
		end
		if v200 == "SustainedCustom" then
			local v213 = v199[2] or "custom"
			local v214 = v199[4] or 1
			local v215 = v199[5] or 1
			local v216 = v199[6]
			local v217 = v199[7]
			local v218 = v199[8]
			local v219 = v199[9]
			if v199[3] and not v_u_78[v213] then
				v_u_78[v213] = { v_u_123.CameraShakerAlt:StartShake(v214, v215, v216, v218, v219), v217 }
				return
			end
			if v_u_78[v213] then
				v_u_78[v213][1]:StartFadeOut(v_u_78[v213][2])
				v_u_78[v213] = nil
			end
		end
	end
end
function CalculateAngles(p220, p221) -- name: CalculateAngles
	-- upvalues: (ref) v_u_24, (copy) v_u_8, (copy) v_u_20, (ref) v_u_23, (copy) v_u_56, (copy) v_u_26, (copy) v_u_16, (copy) v_u_17, (ref) v_u_27, (ref) v_u_28, (ref) v_u_29, (ref) v_u_30, (copy) v_u_54, (ref) v_u_33
	local v222 = p220 - (v_u_24 or p220)
	if v222.Magnitude > 1 then
		v222 = p220 - p220
	end
	local v223 = v222:Dot(v_u_8.CFrame.RightVector)
	if v223 > 0.1 or v223 < 0.1 then
		v_u_20.Target = -0.1 * v223
	else
		v_u_20.Target = 0
	end
	v_u_23 = Lerp(v_u_23, v_u_56.YawSpring.Position, p221)
	local v224 = 0
	local v225 = 0
	local v226 = 0
	for v227, v228 in v_u_26 do
		v224 = v224 + v228.ImpulsePitch.p
		v225 = v225 + v228.ImpulseYaw.p
		v226 = v226 + v228.ImpulseRoll.p
		if v227.IsDestroyed then
			v_u_26[v227] = nil
		end
	end
	local v229 = math.clamp(v224, -100, 100)
	local v230 = math.clamp(v225, -100, 100)
	local v231 = math.clamp(v226, -100, 100)
	local v232 = v_u_16.peek(v_u_17.RecoilMult)
	v_u_27 = v_u_27:lerp(CFrame.Angles(v229 * 0.5 * v232, v230 * 0.15 * v232, v231), p221)
	if v_u_28 and v_u_29 then
		v_u_30 = v_u_29.Transform:Lerp(CFrame.new(), v_u_56.EquipSpring.Position)
		if v_u_29.Name ~= "Camera" then
			local v233, v234, v235 = v_u_30:toEulerAnglesXYZ()
			v_u_30 = CFrame.Angles(v233 * 0.05, v234 * 0.03, v235 * 0.015):Lerp(CFrame.new(), v_u_56.EquipSpring.Position)
		end
	else
		v_u_30 = v_u_30:lerp(CFrame.new(), p221)
	end
	local v236 = v_u_54.CurrentWeapon
	if v236 and (v236.Reloading and v236.Viewmodel) then
		local v237 = v236.Viewmodel
		if v237.HRPADSAttachment and v237._idleAimRelCF then
			local v238 = (v237.PrimaryPart.CFrame * v237._idleAimRelCF:Inverse()):ToObjectSpace(v237.Aimpart.CFrame)
			local v239 = v_u_29 and 0 or 0.02
			local v240 = v236.Config.ReloadCameraMultiplier or v239
			local v241, v242, v243 = v238:ToEulerAnglesYXZ()
			local v244 = -v243
			local v245 = Vector3.new(v242, v241, v244) * v240
			v_u_33 = v_u_33:Lerp(CFrame.Angles(v245.Y, v245.X, v245.Z), p221)
		else
			v_u_33 = v_u_33:Lerp(CFrame.new(), p221)
		end
	else
		v_u_33 = v_u_33:Lerp(CFrame.new(), p221)
		return
	end
end
function Lerp(p246, p247, p248) -- name: Lerp
	return p246 * (1 - p248) + p247 * p248
end
local function v_u_252(p249) -- name: thumbstickCurve
	local v250 = (math.abs(p249) - 0.1) / 0.9 * 2
	local v251 = (math.exp(v250) - 1) / 6.38905609893065
	return math.sign(p249) * math.clamp(v251, 0, 1)
end
v2:BindActionAtPriority("Testzsd", function(_, _, p253) -- name: thumbstick
	-- upvalues: (ref) v_u_72, (ref) v_u_252
	local v254 = p253.Position
	v_u_72 = Vector2.new(v_u_252(v254.X), -v_u_252(v254.Y))
	return Enum.ContextActionResult.Pass
end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick2)
function MakeConnections() -- name: MakeConnections
	-- upvalues: (copy) v_u_25, (copy) v_u_5, (copy) v_u_123, (ref) v_u_73, (copy) v_u_20, (copy) v_u_61, (copy) v_u_60, (ref) v_u_80, (copy) v_u_82, (copy) v_u_54, (copy) v_u_47, (copy) v_u_36, (ref) v_u_37, (ref) v_u_38, (ref) v_u_35, (ref) v_u_72
	CleanConnections()
	local v255 = v_u_25
	local v256 = v_u_5.InputChanged
	local function v270(p257, p258)
		-- upvalues: (ref) v_u_123, (ref) v_u_73, (ref) v_u_20, (ref) v_u_61, (ref) v_u_60, (ref) v_u_80, (ref) v_u_82, (ref) v_u_54, (ref) v_u_47, (ref) v_u_36, (ref) v_u_37, (ref) v_u_38
		if v_u_123.Enabled then
			if p257.UserInputType == Enum.UserInputType.MouseMovement then
				v_u_73 = Vector2.new(p257.Delta.X, p257.Delta.Y)
				v_u_20.Position = v_u_20.Position - p257.Delta.X * 0.0002
			elseif p257.UserInputType == Enum.UserInputType.MouseWheel then
				if v_u_61(v_u_60.Camera.ScrollWheelZoom) and not p258 then
					local v259 = v_u_80 - p257.Position.Z * 1.5
					local v260 = v_u_82
					v_u_80 = math.clamp(v259, 0, v260())
					v_u_54.RequestThirdPerson = v_u_80 >= 1
					return
				end
			elseif p257.UserInputType == Enum.UserInputType.Touch then
				if v_u_47(p257.Position) then
					if v_u_36[p257] then
						v_u_36[p257] = nil
						v_u_37 = nil
						v_u_38 = 0
					end
					return
				end
				if v_u_36[p257] then
					v_u_36[p257] = p257.Position
				end
				local v261 = 0
				local v262 = {}
				for _, v263 in v_u_36 do
					v261 = v261 + 1
					table.insert(v262, v263)
				end
				if v261 == 2 and v_u_61(v_u_60.Camera.PinchToZoom) then
					local v264 = (v262[1] - v262[2]).Magnitude
					if v_u_37 then
						v_u_38 = v_u_38 + (v_u_37 - v264)
						while true do
							local v265 = v_u_38
							if math.abs(v265) < 50 then
								break
							end
							if v_u_38 > 0 then
								local v266 = v_u_80 + 1.5
								local v267 = v_u_82
								v_u_80 = math.clamp(v266, 0, v267())
								v_u_38 = v_u_38 - 50
							else
								local v268 = v_u_80 - 1.5
								local v269 = v_u_82
								v_u_80 = math.clamp(v268, 0, v269())
								v_u_38 = v_u_38 + 50
							end
							v_u_54.RequestThirdPerson = v_u_80 >= 1
						end
					end
					v_u_37 = v264
				end
			end
		else
			return
		end
	end
	table.insert(v255, v256:connect(v270))
	local v271 = v_u_25
	local v272 = v_u_5.InputBegan
	local function v279(p273, p274)
		-- upvalues: (ref) v_u_35, (ref) v_u_61, (ref) v_u_60, (ref) v_u_80, (ref) v_u_82, (ref) v_u_54, (ref) v_u_47, (ref) v_u_36
		if p273.UserInputType == Enum.UserInputType.MouseButton2 then
			v_u_35 = true
		end
		if not p274 and v_u_61(v_u_60.Camera.ScrollWheelZoom) then
			if p273.KeyCode == Enum.KeyCode.I then
				local v275 = v_u_80 - 1.5
				local v276 = v_u_82
				v_u_80 = math.clamp(v275, 0, v276())
				v_u_54.RequestThirdPerson = v_u_80 >= 1
			elseif p273.KeyCode == Enum.KeyCode.O then
				local v277 = v_u_80 + 1.5
				local v278 = v_u_82
				v_u_80 = math.clamp(v277, 0, v278())
				v_u_54.RequestThirdPerson = v_u_80 >= 1
			end
		end
		if p273.UserInputType == Enum.UserInputType.Touch and not v_u_47(p273.Position) then
			v_u_36[p273] = p273.Position
		end
	end
	table.insert(v271, v272:connect(v279))
	local v280 = v_u_25
	local v281 = v_u_5.InputEnded
	local function v283(p282, _)
		-- upvalues: (ref) v_u_72, (ref) v_u_35, (ref) v_u_36, (ref) v_u_37, (ref) v_u_38
		if p282.KeyCode == Enum.KeyCode.Thumbstick2 then
			v_u_72 = Vector2.new()
		end
		if p282.UserInputType == Enum.UserInputType.MouseButton2 then
			v_u_35 = false
		end
		if p282.UserInputType == Enum.UserInputType.Touch then
			v_u_36[p282] = nil
			v_u_37 = nil
			v_u_38 = 0
		end
	end
	table.insert(v280, v281:connect(v283))
end
function CleanConnections() -- name: CleanConnections
	-- upvalues: (copy) v_u_25
	for _, v284 in v_u_25 do
		v284:Disconnect()
	end
	table.clear(v_u_25)
end
v_u_60.OpenChanged:Connect(function(p285)
	-- upvalues: (copy) v_u_123
	v_u_123:MouseIconEnabled("Settings", p285)
	v_u_123:SetMouseUnlocked("Settings", p285)
end)
v_u_54.CharacterChanged:Connect(function(p286)
	-- upvalues: (copy) v_u_123, (ref) v_u_88
	if p286 then
		local v287 = CFrame.Angles(0, v_u_123.X, 0).LookVector
		local v288 = v287.X
		local v289 = v287.Z
		v_u_88 = Vector3.new(v288, 0, v289).Unit
	end
end)
v_u_54.ThirdPersonChanged:Connect(function(p290)
	-- upvalues: (ref) v_u_80, (copy) v_u_61, (copy) v_u_60
	if p290 and v_u_80 < 1 then
		v_u_80 = v_u_61(v_u_60.Camera.MaxCameraDistance)
	elseif not p290 and v_u_80 >= 1 then
		v_u_80 = 0
	end
end)
v63:SetClientListener(function(p291)
	-- upvalues: (copy) v_u_123
	if p291 and p291.Type == "SetEnabled" then
		v_u_123:SetEnabled(p291.Enabled)
	end
end)
v3:GetInstanceAddedSignal(v_u_7.Name .. "_OutfitVFX"):Connect(function(p292)
	-- upvalues: (copy) v_u_79
	local v293 = 10
	repeat
		v293 = v293 - task.wait()
	until p292.Parent or v293 <= 0
	if p292.Parent then
		print(p292.Parent)
	else
		print("cannot resolve vfx parent of", p292)
	end
	v_u_79[p292] = p292.Parent
end)
v3:GetInstanceRemovedSignal(v_u_7.Name .. "_OutfitVFX"):Connect(function(p294)
	-- upvalues: (copy) v_u_79
	v_u_79[p294] = nil
end)
if game.ReplicatedStorage:FindFirstChild("Remotes") and game.ReplicatedStorage.common.Remotes:FindFirstChild("CameraShake") then
	game.ReplicatedStorage.common.Remotes.CameraShake.OnClientEvent:Connect(function(...)
		-- upvalues: (copy) v_u_123
		v_u_123:Shake(...)
	end)
end
v64:SetClientListener(function(p295)
	-- upvalues: (copy) v_u_123
	v_u_123:Shake(unpack(p295))
end)
return v_u_123