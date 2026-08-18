local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = workspace.CurrentCamera
local v5 = v_u_1.common
local _ = v_u_1.common.SharedResources.VModels
local v_u_6 = workspace.Ignore
local v7 = script.ViewmodelUtils
local v8 = script.Parent.Parent.Utils
local v9 = script.Parent.Parent.Controllers
local v10 = script.Parent.Parent.Shared
local _ = script.Resources
local v_u_11 = require(v7.FakeArmUtil)
local v_u_12 = require(v7.ArmModelUtil)
local v_u_13 = require(v7.GunMovementUtil)
local v_u_14 = require(v7.PointRotationUtil)
local v_u_15 = require(v7.RecoilUtil)
local v_u_16 = require(v7.HolographicEffect)
local v_u_17 = require(v7.GripBlenderEffect)
local v_u_18 = require(v7.ScopeHideEffect)
local v_u_19 = require(v8.BobbingUtil)
local v_u_20 = require(v8.SpringUtil)
local v_u_21 = require(v9.LocalPlayerController)
local v_u_22 = require(v10.SharedSprings)
local v_u_23 = require(v5.Promise)
local v_u_24 = require(v5.Janitor)
local v_u_25 = require(v9.CameraController)
local v_u_26 = require(v5.WepConfig)
local v_u_27 = require(v8.RaycastUtil)
local v_u_28 = require(v8.CursorRecoilUtil)
local v_u_29 = require(v_u_1.common.SharedResources.Attachments.AttachmentSystem)
local v_u_30 = require(v_u_1.common.NPCs_Shared.Utils.DamageFalloffUtil)
local v_u_31 = require("@game/ReplicatedStorage/common/Settings")
local v_u_32 = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local v_u_33 = require("@game/ReplicatedStorage/common/Signal")
local v_u_34 = require(v7.ShellSystem)
local v_u_35 = require(v_u_1.Packages.Fusion)
local v_u_36 = require(v_u_1.common.skillTree.SkillTreeData)
local v_u_37 = require(v5.AnimatedTextures)
local v_u_38 = {}
local v_u_39 = 0
local v_u_40 = CFrame.new()
local v_u_41 = v_u_20.new(0)
v_u_41.Target = 0
v_u_41.Speed = 13
v_u_41.Damper = 0.9
local v_u_42 = v_u_20.new(0)
v_u_42.Target = 0
v_u_42.Speed = 18
v_u_42.Damper = 1
local v43 = v_u_20.new(0)
v43.Target = 0
v43.Speed = 19
v43.Damper = 0.7
local v_u_44 = v_u_20.new(0)
v_u_44.Target = 0
v_u_44.Speed = 20
v_u_44.Damper = 0.7
local v_u_45 = v_u_20.new(0)
v_u_45.Target = 0
v_u_45.Speed = 20
v_u_45.Damper = 1
local v_u_46 = v_u_20.new(0)
v_u_46.Target = 0
v_u_46.Speed = 20
v_u_46.Damper = 1
local v_u_47 = Enum.RenderPriority.Last.Value
local v_u_48 = CFrame.new
local v_u_49 = CFrame.Angles
Vector2.new(0.5, 0.5)
local v_u_50 = {}
v_u_50.__index = v_u_50
function v_u_50.new(p51) -- name: new
	-- upvalues: (copy) v_u_50, (ref) v_u_39, (copy) v_u_24, (copy) v_u_33, (copy) v_u_20
	local v52 = {}
	local v53 = v_u_50
	setmetatable(v52, v53)
	v52.Weapon = p51
	v52.Config = p51.Config
	v52.Offsets = {}
	v52.TotalOffset = CFrame.new()
	v52.ImpulseCF = CFrame.new()
	v_u_39 = v_u_39 + 1
	v52.Name = "VM_" .. p51.Name .. "_" .. v_u_39
	v52.Enabled = false
	v52.Animations = {}
	v52.Janitor = v_u_24.new()
	v52.ConfigLoaded = v_u_33.new()
	v52.ManagedByManager = false
	v52.ManagerState = "Full"
	v52.ManagerGrantedArms = {
		["Right"] = true,
		["Left"] = true
	}
	v52.ArmOffsets = {
		["Right"] = CFrame.new(),
		["Left"] = CFrame.new()
	}
	v52.ArmOffsetTargets = {
		["Right"] = CFrame.new(),
		["Left"] = CFrame.new()
	}
	v52.ArmOffsetSpeed = 12
	v52.ViewmodelBaseOffset = CFrame.new()
	v52.ViewmodelBaseOffsetTarget = CFrame.new()
	v52.PrevArmControlled = {
		["Right"] = true,
		["Left"] = true
	}
	v52.ForceOneHanded = false
	v52.ForceLoweredPosition = false
	v52.DedicatedArms = nil
	v52.RightArmOnly = false
	v52.LeftArmOnly = p51.IsDualWieldLeft or false
	v52.IsMirrored = p51.IsDualWieldLeft or false
	v52.IsDualWieldRight = p51.IsDualWieldRight or false
	v52.UseArmModels = p51.UseArmModels or false
	v52.LoadingFrame = v_u_20.new(0)
	v52.LoadingFrame.Target = 0
	v52.LoadingFrame.Speed = 19
	v52.LoadingFrame.Damper = 0.7
	v52.EquipSpring = v_u_20.new(0)
	v52.EquipSpring.Target = 0
	v52.EquipSpring.Speed = 12
	v52.EquipSpring.Damper = 0.8
	loadViewmodelPromise(v52):catch(function() end)
	return v52
end
function v_u_50.SetEnabled(p_u_54, p55) -- name: SetEnabled
	-- upvalues: (copy) v_u_35, (copy) v_u_36, (copy) v_u_15, (copy) v_u_19, (copy) v_u_42, (copy) v_u_20, (copy) v_u_48, (copy) v_u_34, (copy) v_u_2, (copy) v_u_47, (copy) v_u_14, (copy) v_u_13, (copy) v_u_41, (copy) v_u_21, (copy) v_u_22, (copy) v_u_32, (copy) v_u_31, (ref) v_u_40, (copy) v_u_49, (copy) v_u_44, (copy) v_u_45, (copy) v_u_4, (copy) v_u_25, (copy) v_u_28, (copy) v_u_27, (copy) v_u_46, (copy) v_u_16, (copy) v_u_18, (copy) v_u_11, (copy) v_u_17, (copy) v_u_3, (copy) v_u_37, (copy) v_u_12
	if p_u_54.Enabled == p55 then
		return
	else
		p_u_54.Enabled = p55
		if p55 then
			p_u_54.LoadingFrame.Position = 1
			p_u_54.LoadingFrame.Target = 1
			p_u_54.EquipSpring.Position = 1
			p_u_54.EquipSpring.Target = 0
			p_u_54.EquipSpring.Speed = 12 * (p_u_54.Weapon.Config.DrawSpeed or 1)
			local v56 = v_u_35.peek(v_u_36.SwapSpeedMult)
			p_u_54.EquipSpring.Speed = p_u_54.EquipSpring.Speed * v56
			p_u_54.RecoilInstance = v_u_15.getOrCreate(p_u_54.Weapon)
			if not (p_u_54.LeftArmOnly or p_u_54.IsMirrored) then
				v_u_15.CurrentWeapon = p_u_54.Weapon
				v_u_19.CurrentWeapon = p_u_54.Weapon
			end
			local v_u_57 = p_u_54.Weapon.Config.ADSSpeed or 1
			v_u_42.Speed = 18 * v_u_57
			if p_u_54.Aimpart then
				p_u_54.HRPADSAttachment = Instance.new("Attachment")
				p_u_54.HRPADSAttachment.Parent = p_u_54.PrimaryPart
				if p_u_54._idleAimRelCF then
					p_u_54.HRPADSAttachment.WorldCFrame = p_u_54.PrimaryPart.CFrame * p_u_54._idleAimRelCF:Inverse()
				end
				p_u_54.VMAnimInfluenceSpring = v_u_20.new(0)
				p_u_54.VMAnimInfluenceSpring.Target = 0
				p_u_54.VMAnimInfluenceSpring.Speed = 10
				p_u_54.VMAnimInfluenceSpring.Damper = 0.8
			end
			if p_u_54.ViewmodelReady then
				p_u_54:Loaded()
			end
			local v_u_58 = v_u_48()
			v_u_34.UsingViewmodelStep = true
			v_u_2:BindToRenderStep(p_u_54.Name, v_u_47, function(p59)
				-- upvalues: (ref) v_u_14, (copy) p_u_54, (ref) v_u_57, (ref) v_u_42, (ref) v_u_13, (ref) v_u_41, (ref) v_u_21, (ref) v_u_22, (ref) v_u_48, (ref) v_u_32, (ref) v_u_31, (ref) v_u_19, (ref) v_u_40, (ref) v_u_49, (ref) v_u_44, (ref) v_u_45, (ref) v_u_4, (ref) v_u_25, (ref) v_u_15, (ref) v_u_28, (ref) v_u_20, (ref) v_u_27, (ref) v_u_46, (ref) v_u_16, (ref) v_u_18, (ref) v_u_11, (ref) v_u_17, (ref) v_u_35, (ref) v_u_36, (ref) v_u_3, (ref) v_u_34, (ref) v_u_58, (ref) v_u_37
				v_u_14.SetActiveViewmodel(p_u_54.Weapon)
				v_u_57 = p_u_54.Weapon.Config.ADSSpeed or 1
				v_u_42.Speed = 18 * v_u_57
				local v60 = p_u_54.Weapon.Config
				local v61 = p_u_54.IsDualWieldRight or p_u_54.IsMirrored
				local v62 = p_u_54.Aimpart
				if v62 then
					v62 = not v60.AimingDisabled
				end
				local v63
				if v62 then
					v63 = not v61
				else
					v63 = v62
				end
				if v62 and (not p_u_54.Weapon.Aiming and (p_u_54.Weapon.SecondaryAttackDown and p_u_54.Weapon.IsEquipped)) then
					p_u_54:StopAnimation("Inspect")
					p_u_54.Weapon.Aiming = true
					if v60.CustomAiming then
						v60.CustomAiming(p_u_54.Model, true)
					end
				elseif p_u_54.Weapon.Aiming and not (p_u_54.Weapon.SecondaryAttackDown and p_u_54.Weapon.IsEquipped) then
					p_u_54.Weapon.Aiming = false
					if v60.CustomAiming then
						v60.CustomAiming(p_u_54.Model, false)
					end
				end
				local v64, v65 = v_u_13:Update(p59, p_u_54.Weapon.Aiming)
				local v66 = p_u_54.RecoilInstance and p_u_54.RecoilInstance:Update(p59, v_u_42, v_u_41) or CFrame.new()
				p_u_54:UpdatePhysics()
				if p_u_54.ViewmodelReady or (not p_u_54.ViewmodelLoaded or (not p_u_54.Model or (not p_u_54.Animations or (not p_u_54.Animations.Idle or p_u_54.Animations.Idle.Length <= 0)))) then
					p_u_54.LoadingFrame.Target = 0
				else
					p_u_54.ViewmodelReady = true
					p_u_54:Loaded()
				end
				if p_u_54.Model and p_u_54.ViewmodelReady then
					local v67 = v_u_21.ThirdPerson or v_u_21.hrp
					if v67 then
						v67 = v_u_22.TPSpring.Position > 0.05
					end
					if p_u_54.VMAnimInfluenceSpring then
						if p_u_54.Weapon.Reloading then
							p_u_54.VMAnimInfluenceSpring.Target = v60.ReloadADSInfluence or 0.15
						else
							p_u_54.VMAnimInfluenceSpring.Target = 0
						end
					end
					local v68
					if v63 then
						local v69
						if p_u_54.HRPADSAttachment and p_u_54.VMAnimInfluenceSpring then
							v69 = p_u_54.Aimpart.CFrame:Lerp(p_u_54.HRPADSAttachment.WorldCFrame, p_u_54.VMAnimInfluenceSpring.Position)
						else
							v69 = p_u_54.Aimpart.CFrame
						end
						local v70 = p_u_54.Aimpart == p_u_54.DefaultAimpart and (p_u_54.Model:GetAttribute("SkinAimPartOffset") or v_u_48()) or v_u_48()
						v68 = (v69 * (v60.AimOffset or v_u_48()) * v70):toObjectSpace(p_u_54.PrimaryPart.CFrame)
					else
						v68 = v_u_48()
					end
					if v67 then
						v68 = v_u_48()
					end
					if not p_u_54.ForceLoweredPosition then
						v_u_42.Target = p_u_54.Weapon.Aiming and (not v60.DisableADSReload or v60.DisableADSReload and not p_u_54.Weapon.Reloading) and 1 or 0
					end
					p_u_54.Weapon.ADSStrength = v_u_42.Target >= 1 and v_u_42.Position / v_u_42.Target or 0
					local v71 = v60.GripOffset
					local v72
					if v60.LeftArmGrip and v71 then
						v72 = v71:Lerp(v_u_48(), p_u_54.Weapon.ADSStrength)
					else
						v72 = v_u_48()
					end
					local v73 = p59 * 10
					local v74 = math.clamp(v73, 0.01, 1)
					p_u_54.ImpulseCF = p_u_54.ImpulseCF:Lerp(CFrame.new(), v74)
					local v75 = v60.DynamicFOVOffsetConstant
					local v76 = v60.AimDynamicFOVOffsetConstant or v75
					local v77 = CFrame.new()
					local v78 = CFrame.new()
					if v75 then
						local v79 = v_u_32(v_u_31.Graphics.BaseFOV) * 0.5
						local v80 = math.rad(v79)
						local v81 = math.sin(v80) + -0.573576436351046
						v77 = CFrame.new(0, 0, v81 * v75)
						v78 = CFrame.new(0, 0, v81 * v76)
					end
					local v82 = v77:Lerp(v78, v67 and 0 or v_u_42.Position) * v_u_19.gunBobCF * v64 * v_u_40 * v66 * p_u_54.TotalOffset * p_u_54.ImpulseCF * v72
					local v83 = CFrame.new()
					if p_u_54.StartingTransform and p_u_54.CameraBoneMotor6D then
						local v84 = p_u_54.StartingTransform * p_u_54.CameraBoneMotor6D.Transform:inverse()
						if v60.UseAltCameraReload then
							local _, _, v85 = (v84 - v84.Position):ToOrientation()
							v84 = v_u_49(0, 0, v85 * 0.05)
						end
						local v86 = (p_u_54.LeftArmOnly or p_u_54.IsMirrored) and p_u_54.EquipSpring.Position or v_u_22.EquipSpring.Position
						v83 = v84:Lerp(CFrame.new(), v86)
					end
					local v87 = v82:Lerp(v68 * v_u_19.gunBobCF * v64 * v_u_40 * v66 * v83 * p_u_54.ImpulseCF, v67 and 0 or v_u_42.Position)
					local v88 = v_u_44
					local v89 = Lerp
					local v90 = v_u_44.Target
					local v91 = p59 * 10 * v_u_57
					v88.Target = v89(v90, 0, (math.clamp(v91, 0.0001, 1)))
					local v92 = v_u_45
					local v93 = Lerp
					local v94 = v_u_45.Target
					local v95 = p59 * 10 * v_u_57
					v92.Target = v93(v94, 0, (math.clamp(v95, 0.0001, 1)))
					local v96 = v_u_4.CFrame
					if v67 and (v_u_21.hrp and (v_u_21.hrp.Parent and (v_u_21.humanoid.Humanoid and v_u_21.humanoid.Humanoid.Health > 0))) then
						v96 = v_u_21.hrp.Parent.HEADCOPY.CFrame
						local v97 = v_u_21.hrp.CFrame
						local v98 = v_u_42.Position
						if v_u_21.Animator then
							local v99 = v_u_21.States.Proning
							local v100 = v_u_25.Y
							local v101 = v99 and 1.5707963267948966 or 0
							local v102 = -v100 / 1.5707963267948966
							local v103 = math.clamp(v102, 0, 1)
							local v104 = v100 / 1.5707963267948966
							local v105 = math.clamp(v104, 0, 1)
							if v99 then
								v96 = v96 * v_u_48(0, -1, 0.8)
								v97 = v97 * v_u_48(0, -1, 0.8)
							end
							local v106 = v99 and 0 or v_u_21.Animator:GetAimTwistAngle()
							local v107 = v96 * v_u_49(v101, 0, 0) * v_u_49(0, v106, 0) * v_u_49(v100 * 0.5, 0, 0)
							local v108 = v_u_15:GetPitchRecoil()
							v96 = v107:Lerp(v97 * v_u_48(0, 1.5, 0) * v_u_49(v100 + v108 * 2, 0, 0) * v_u_48():Lerp(not v99 and v_u_48(0, 0.5, -1.5) or v_u_48(), v103) * v_u_48():Lerp(not v99 and v_u_48(0, 1, 1.5) or v_u_48(), v105), v98)
						end
					end
					if p_u_54.ManagerState == "Lowered" or (p_u_54.ManagerState == "Hidden" or p_u_54.ForceLoweredPosition) then
						p_u_54.PrimaryPart.CFrame = v96 * p_u_54.ViewmodelBaseOffset * v_u_19.gunBobCF * v64 * p_u_54.TotalOffset * p_u_54.ImpulseCF
					else
						local v109 = v_u_42.Target > 0 and 0 or 1
						local v110 = p_u_54.LoadingFrame.Position * v109
						local v111 = v_u_44.Position * v109
						local v112 = v_u_45.Position * v109
						p_u_54.PrimaryPart.CFrame = v96 * p_u_54.ViewmodelBaseOffset * v_u_48():Lerp(v_u_48(0, 0, -0.5) * v_u_49(-0.2617993877991494, 0, 0.2617993877991494), v111) * v_u_48():Lerp(v_u_48(0, 0, -0.5) * v_u_49(0, 0, -0.2617993877991494), v112) * v_u_48():Lerp(v_u_48(0, 0, 1), v110) * v87
					end
					if p_u_54.IsMirrored then
						local v113 = p_u_54.PrimaryPart.CFrame
						local v114 = CFrame.fromMatrix(v113.Position, v113.XVector * -1, v113.YVector, v113.ZVector)
						p_u_54.PrimaryPart.CFrame = v114
					end
					if not p_u_54.ForceLoweredPosition then
						v_u_14.Update(p59, p_u_54.Model, p_u_54.Weapon.Aiming, v_u_42, v96, v78, p_u_54.Weapon)
					end
					local v115 = v_u_28.crosshairRecoil
					if p_u_54.Weapon.Aiming and (v115.Magnitude > 0.0001 and p_u_54.Aimpart) then
						local v116 = CFrame.new(Vector3.new(0, 0, 1), v115 * Vector3.new(1, 1, 1))
						local v117 = v116 - v116.Position
						local v118 = p_u_54.Aimpart.CFrame
						local v119 = v118:ToObjectSpace(p_u_54.PrimaryPart.CFrame)
						local v120 = v118 * v117
						p_u_54.PrimaryPart.CFrame = v120:ToWorldSpace(v119)
					end
					if v60.Lasers then
						for _, v121 in v60.Lasers do
							local v122 = v121[1]
							local v123 = v121[2]
							if not v121[3] then
								v121[3] = v_u_20.new(0)
								v121[3].Target = 0
								v121[3].Speed = 20
								v121[3].Damper = 1
							end
							local _ = v121[3]
							local v124 = v_u_27.CustomRayDirection(v122.CFrame.Position, -v122.CFrame.RightVector.Unit * 100).Position
							v122.End.WorldCFrame = v_u_48(v124)
							local v125 = v96.LookVector:Dot(-v122.CFrame.RightVector)
							local v126 = 1 - math.abs(v125)
							local v127 = v126 > 0.0005 and 1 or v126
							if v67 then
								v_u_46.Target = 1 - v127
							else
								v_u_46.Target = 0
							end
							v123.BillboardGui.Enabled = true
							v123.Position = v124:Lerp(v_u_27.CastBaseRay().Position, v_u_46.Position)
						end
					end
					local v128 = v60.Lense
					if v128 and p_u_54.Reticle then
						v_u_16.UpdateReticle(v128, p_u_54, v96)
					end
					local v129 = v60.Shadow
					if v129 and p_u_54.ShadowRing then
						v_u_16.UpdateShadow(v129, p_u_54, v96)
					end
					if v60.HideScopeModel then
						v_u_18.Update(p_u_54, v60.HideScopeModel, v_u_42)
					end
					local v130 = p_u_54.DedicatedArms or v_u_11.Arms
					local v131 = v_u_48()
					local v132 = v_u_11:OwnsArm(p_u_54.Model, "Left")
					local v133 = v_u_11:OwnsArm(p_u_54.Model, "Right")
					if v130 and v132 then
						if v60.LeftArmGrip then
							v131 = v_u_17(v130, p_u_54.Weapon)
						else
							v130.LeftWeld.C0 = v_u_48()
						end
					end
					if v132 then
						local v134 = p_u_54.Weapon.Config.ArmIgnores and p_u_54.Weapon.Config.ArmIgnores["Left Arm"] and true or false
						local v135 = v_u_21.States.IsDowned and not v_u_35.peek(v_u_36.HasLastStand) and true or v134
						local v136 = (not p_u_54.ManagerGrantedArms.Left or p_u_54.ForceOneHanded) and true or v135
						if v130 then
							local v137 = p_u_54.PrevArmControlled.Left
							local v138 = not v136
							if v137 and not v138 then
								local v139 = v130.Left.CFrame
								local v140 = v130.LeftShoulder.Part0.CFrame
								local v141 = v130.LeftShoulder.C1
								local v142 = v140:Inverse() * v139 * v141
								v130.LeftShoulder.C0 = v142
								v130.LeftShoulder.Enabled = true
								v130.LeftWeld.Enabled = false
								v_u_3:Create(v130.LeftShoulder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["C0"] = v130.LeftShoulderC0
								}):Play()
							elseif v137 or not v138 then
								v130.LeftWeld.Enabled = not v136
								v130.LeftShoulder.Enabled = v136
							else
								local v143 = v130.Left.CFrame
								local v144 = v130.LeftWeld.Part0.CFrame:Inverse() * v143
								v130.LeftWeld.C0 = v144
								v130.LeftWeld.Enabled = true
								v130.LeftShoulder.Enabled = false
							end
							p_u_54.PrevArmControlled.Left = v138
						end
					end
					if v133 then
						local v145 = p_u_54.Weapon.Config.ArmIgnores and p_u_54.Weapon.Config.ArmIgnores["Right Arm"] and true or false
						local v146 = not p_u_54.ManagerGrantedArms.Right and true or v145
						if v130 then
							local v147 = p_u_54.PrevArmControlled.Right
							local v148 = not v146
							if v147 and not v148 then
								local v149 = v130.Right.CFrame
								local v150 = v130.RightShoulder.Part0.CFrame
								local v151 = v130.RightShoulder.C1
								local v152 = v150:Inverse() * v149 * v151
								v130.RightShoulder.C0 = v152
								v130.RightShoulder.Enabled = true
								v130.RightWeld.Enabled = false
								v_u_3:Create(v130.RightShoulder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["C0"] = v130.RightShoulderC0
								}):Play()
							elseif v147 or not v148 then
								v130.RightWeld.Enabled = not v146
								v130.RightShoulder.Enabled = v146
							else
								local v153 = v130.Right.CFrame
								local v154 = v130.RightWeld.Part0.CFrame:Inverse() * v153
								v130.RightWeld.C0 = v154
								v130.RightWeld.Enabled = true
								v130.RightShoulder.Enabled = false
							end
							p_u_54.PrevArmControlled.Right = v148
						end
					end
					p_u_54:UpdateArmOffsets(p59)
					if v130 and (p_u_54.ManagerState ~= "Lowered" and (p_u_54.ManagerState ~= "Hidden" and not p_u_54.ForceLoweredPosition)) then
						local v155 = Lerp(0.4, 1, v_u_22.SprintSpring.Position)
						local v156 = p_u_54.Weapon.Config.IsMelee and 1 or v155
						local v157 = (p_u_54.PrimaryPart.CFrame * v65 * v_u_19.gunBobCF):Lerp(p_u_54.PrimaryPart.CFrame, v156)
						if v132 then
							local v158 = v130.LeftWeld.Part0.CFrame * v131
							local v159 = v157:ToObjectSpace(v158)
							local v160 = v158 * CFrame.new(0.1, -1.4, 0)
							v130.LeftWeld.C0 = v130.LeftWeld.Part0.CFrame:Inverse() * p_u_54.PrimaryPart.CFrame * v159
							local v161 = v130.LeftWeld.Part0.CFrame:toWorldSpace(CFrame.new(v130.LeftWeld.C0.Position))
							v130.LeftWeld.C0 = v130.LeftWeld.C0 * CFrame.Angles(-1.5707963267948966, 0, 0)
							local v162 = CFrame.lookAt(v161.Position, v160.Position, v130.Left.CFrame.UpVector) * CFrame.Angles(1.5707963267948966, 0, 0)
							v130.LeftWeld.C0 = v130.LeftWeld.Part0.CFrame:toObjectSpace(v162)
							v130.LeftWeld.C0 = v130.LeftWeld.C0 * p_u_54.ArmOffsets.Left
						end
						if v133 then
							local v163 = v130.RightWeld.Part0.CFrame
							local v164 = v157:ToObjectSpace(v163)
							local v165 = v163 * CFrame.new(-0.1, -1.4, 0)
							v130.RightWeld.C0 = v130.RightWeld.Part0.CFrame:Inverse() * p_u_54.PrimaryPart.CFrame * v164
							local v166 = v130.RightWeld.Part0.CFrame:toWorldSpace(CFrame.new(v130.RightWeld.C0.Position))
							v130.RightWeld.C0 = v130.RightWeld.C0 * CFrame.Angles(-1.5707963267948966, 0, 0)
							local v167 = CFrame.lookAt(v166.Position, v165.Position, v130.Right.CFrame.UpVector) * CFrame.Angles(1.5707963267948966, 0, 0)
							v130.RightWeld.C0 = v130.RightWeld.Part0.CFrame:toObjectSpace(v167)
							v130.RightWeld.C0 = v130.RightWeld.C0 * p_u_54.ArmOffsets.Right
						end
					end
					v_u_34:Update(p59)
					if v60.ChainAtt then
						local v168 = v60.ChainAtt.CFrame
						v_u_58 = v168 - v168.Position
						v60.ChainAtt.CFrame = v_u_48(v60.ChainAtt.Parent.AttachmentPart.Position) * v_u_58
					end
					if p_u_54.AnimatedTextures then
						v_u_37.update(p_u_54.AnimatedTextures)
					end
					if v60.CustomRS then
						v60.CustomRS(p_u_54.Model, {
							["Ammo"] = p_u_54.Weapon.Ammo
						}, p59)
					end
					if v60.AnimateTextureThink then
						v60.AnimateTextureThink(p_u_54.Model, v60, v_u_42, p59, p_u_54)
					end
				end
			end)
		else
			p_u_54.EquipSpring.Target = 1.5
			p_u_54.EquipSpring.Speed = 12 * (p_u_54.Weapon.Config.HolsterSpeed or 1)
			v_u_34.UsingViewmodelStep = false
			if p_u_54.UseArmModels then
				v_u_12:DetachArms(p_u_54.Model)
			else
				v_u_11:Hide(p_u_54.Model)
			end
			if p_u_54.Model then
				p_u_54.Model.Parent = nil
			end
			v_u_2:UnbindFromRenderStep(p_u_54.Name)
			v_u_25:SetCameraBone(nil, nil)
			if p_u_54.HRPADSAttachment then
				p_u_54.HRPADSAttachment:Destroy()
				p_u_54.HRPADSAttachment = nil
			end
		end
	end
end
function v_u_50.ChangedFiremode(_) -- name: ChangedFiremode
	-- upvalues: (copy) v_u_44, (copy) v_u_45
	v_u_44.Target = 0.3
	v_u_45.Target = -0.2
end
function v_u_50.GetModel(p169) -- name: GetModel
	return p169.Model
end
function v_u_50.Destroy(p170) -- name: Destroy
	-- upvalues: (copy) v_u_2
	if p170.Model then
		p170.Model:Destroy()
	end
	if p170.Enabled then
		v_u_2:UnbindFromRenderStep(p170.Name)
	end
	if p170.HRPADSAttachment then
		p170.HRPADSAttachment:Destroy()
		p170.HRPADSAttachment = nil
	end
	local v171 = p170.Janitor
	if v171 then
		v171:Destroy()
		p170.Janitor = nil
	end
end
function v_u_50.StopAnimation(p172, p173) -- name: StopAnimation
	if p172.Animations and p172.Animations[p173] then
		p172.Animations[p173]:Stop()
	end
end
function v_u_50.PlayAnimation(p_u_174, p_u_175, ...) -- name: PlayAnimation
	-- upvalues: (copy) v_u_23
	local v176, v177, v178 = unpack({ ... })
	local v_u_179 = v176 or 0
	local v_u_180 = v177 or 1
	local v_u_181 = v178 or 1
	return v_u_23.new(function(p182, _, _)
		-- upvalues: (copy) p_u_174
		if not p_u_174.Animations then
			repeat
				task.wait()
			until p_u_174.Animations
		end
		p182()
	end):andThen(function()
		-- upvalues: (copy) p_u_174, (copy) p_u_175, (ref) v_u_179, (ref) v_u_180, (ref) v_u_181
		if p_u_174.Animations[p_u_175] then
			p_u_174.Animations[p_u_175]:Play(v_u_179, v_u_180, v_u_181)
		end
	end)
end
function v_u_50.Shoot(p_u_183) -- name: Shoot
	-- upvalues: (copy) v_u_34, (copy) v_u_32, (copy) v_u_31
	if not p_u_183.Weapon.Config.ShellOn then
		v_u_34:Eject(p_u_183)
	end
	if p_u_183.RecoilInstance then
		p_u_183.RecoilInstance:Impulse()
	end
	if v_u_32(v_u_31.Graphics.ParticleQuality) > 1 and p_u_183.MuzzleModule then
		pcall(function()
			-- upvalues: (copy) p_u_183
			p_u_183.MuzzleModule:Emit(p_u_183)
		end)
	end
	if p_u_183.Weapon.Config.CustomShoot then
		p_u_183.Weapon.Config.CustomShoot(p_u_183.Weapon.Ammo, p_u_183.Model)
	end
end
function v_u_50.Loaded(p_u_184) -- name: Loaded
	-- upvalues: (copy) v_u_12, (copy) v_u_11, (copy) v_u_14, (copy) v_u_6, (copy) v_u_25
	local v185 = not p_u_184.RightArmOnly
	local v186 = not p_u_184.LeftArmOnly
	if p_u_184.UseArmModels then
		v_u_12:AttachArms(p_u_184.Model, v186, v185, p_u_184.IsMirrored)
	else
		v_u_11:ShowForArms(p_u_184.Model, v185, v186)
	end
	if not p_u_184.ForceLoweredPosition then
		v_u_14.NewWeapon(p_u_184)
	end
	p_u_184.Model.Parent = v_u_6
	if not (p_u_184.NoCameraBone or (p_u_184.CameraBoneMotor6D or (p_u_184.IgnoreCameraBone or p_u_184.Weapon.Config.DisableCameraBone))) then
		local v187, v188 = p_u_184.Model:FindFirstChild("Head")
		if v187 then
			v188 = p_u_184.Model.Head:FindFirstChild("Camera")
		end
		local v189 = v188 or p_u_184.Model.HumanoidRootPart:FindFirstChild("Camera") or (p_u_184.Model:FindFirstChild("TrackMe", true) or p_u_184.Model:FindFirstChild("Head \240\159\161\170 Handle", true))
		if v189 then
			p_u_184.StartingTransform = v189.Transform
			p_u_184.CameraBoneMotor6D = v189
		else
			p_u_184.NoCameraBone = true
		end
	end
	v_u_25:SetCameraBone(p_u_184.StartingTransform, p_u_184.CameraBoneMotor6D)
	local v_u_190 = p_u_184.Weapon.Config.FirstDrawAnimation
	local v_u_191 = p_u_184.Weapon.Config.DrawAnimation
	if v_u_190 and not p_u_184.FirstDrew then
		p_u_184.FirstDrew = true
		p_u_184:PlayAnimation(v_u_190):andThen(function()
			-- upvalues: (copy) p_u_184, (copy) v_u_190
			p_u_184.Animations[v_u_190].TimePosition = p_u_184.Weapon.Config.FirstDrawAnimationTime or 0
		end)
	elseif v_u_191 and not p_u_184.Weapon.Reloading then
		p_u_184:PlayAnimation(v_u_191, nil, nil, p_u_184.Weapon.Config.DrawSpeed or 1):andThen(function()
			-- upvalues: (copy) p_u_184, (copy) v_u_191
			p_u_184.Animations[v_u_191].TimePosition = p_u_184.Weapon.Config.DrawAnimationTime or 0
		end)
	end
end
function v_u_50._resolveIdleAimCFrame(p_u_192) -- name: _resolveIdleAimCFrame
	-- upvalues: (copy) v_u_48, (copy) v_u_2
	local v_u_193 = p_u_192.Weapon.Config.Viewmodel
	if v_u_193 then
		task.spawn(function()
			-- upvalues: (copy) v_u_193, (ref) v_u_48, (copy) p_u_192, (ref) v_u_2
			local v194 = v_u_193:Clone()
			v194:PivotTo(v_u_48(0, 10000, 0))
			v194.Parent = workspace.Ignore
			local v195 = v194:FindFirstChild("HumanoidRootPart")
			local v196 = v194:WaitForChild("KeyParts"):FindFirstChild("Aimpart")
			if v195 and v196 then
				local v197 = v194:FindFirstChildWhichIsA("AnimationController")
				if not v197 then
					v197 = Instance.new("AnimationController")
					v197.Parent = v194
				end
				local v198 = v197:FindFirstChildOfClass("Animator")
				if not v198 then
					v198 = Instance.new("Animator")
					v198.Parent = v197
				end
				local v199 = v194:FindFirstChild("Animations")
				if v199 then
					local v200 = v199:FindFirstChild("Idle")
					if not v200 then
						local v201 = p_u_192.Weapon.Config
						v200 = v201.IsMelee and v199:FindFirstChild("Swing1") or (v201.UsesLoadLoop and v199:FindFirstChild("LoadStart") or v199:FindFirstChild("Reload"))
						if v200 then
							v200 = v200:Clone()
							v200.Name = "Idle"
						end
					end
					if v200 then
						local v202 = v198:LoadAnimation(v200)
						v202.Looped = true
						v202.Priority = Enum.AnimationPriority.Core
						v202:Play(0, 1, 1)
						local v203 = v_u_48()
						local v204 = p_u_192.Model and p_u_192.Model:FindFirstChild("KeyParts")
						if v204 then
							v204 = p_u_192.Model.KeyParts:FindFirstChild("Aimpart")
						end
						if v204 and (p_u_192.Aimpart and p_u_192.Aimpart ~= v204) then
							v203 = v204.CFrame:ToObjectSpace(p_u_192.Aimpart.CFrame)
						end
						local v205 = false
						for _ = 1, 60 do
							v_u_2.RenderStepped:Wait()
							if p_u_192.Weapon.IsDestroyed then
								v194:Destroy()
								return
							end
							if not v205 and v202.Length > 0 then
								v202:AdjustSpeed(0.0001)
								v202.TimePosition = 0
								v205 = true
							end
							local v206 = (v196.CFrame * v203):ToObjectSpace(v195.CFrame)
							p_u_192._idleAimRelCF = v206
							if p_u_192.HRPADSAttachment and p_u_192.PrimaryPart then
								p_u_192.HRPADSAttachment.WorldCFrame = p_u_192.PrimaryPart.CFrame * v206:Inverse()
							end
						end
						v202:Stop(0)
						v202:Destroy()
						v194:Destroy()
					else
						v194:Destroy()
					end
				else
					v194:Destroy()
					return
				end
			else
				v194:Destroy()
				return
			end
		end)
	end
end
local v_u_207 = CFrame.new(0.5, 1.5, -0.3) * CFrame.Angles(0.5235987755982988, 0, 0.2617993877991494)
local v_u_208 = CFrame.new(-0.5, 1.5, -0.3) * CFrame.Angles(0.5235987755982988, 0, -0.2617993877991494)
local v_u_209 = CFrame.new(0, 3, -1) * CFrame.Angles(1.0471975511965976, 0, 0)
local v_u_210 = CFrame.new(0, 0, 0) * CFrame.Angles(-0.3490658503988659, 0.4363323129985824, 0)
function v_u_50.ApplyManagerState(p211, p212, p213) -- name: ApplyManagerState
	-- upvalues: (copy) v_u_210, (copy) v_u_209, (copy) v_u_207, (copy) v_u_208
	p211.ManagerState = p212
	p211.ManagerGrantedArms = p213
	if p212 == "Lowered" then
		p211.ViewmodelBaseOffsetTarget = v_u_210
		p211.ArmOffsetTargets.Right = v_u_209
		p211.ArmOffsetTargets.Left = v_u_209
		return
	elseif p212 == "Hidden" then
		p211.ViewmodelBaseOffsetTarget = CFrame.new(0, -10, 0)
		p211.ArmOffsetTargets.Right = v_u_209
		p211.ArmOffsetTargets.Left = v_u_209
		return
	else
		if p211.ForceLoweredPosition then
			p211.ViewmodelBaseOffsetTarget = v_u_210
		else
			p211.ViewmodelBaseOffsetTarget = CFrame.new()
		end
		if p211.ForceOneHanded then
			p211.ArmOffsetTargets.Right = CFrame.new()
			p211.ArmOffsetTargets.Left = v_u_207
			return
		else
			if p213.Right then
				p211.ArmOffsetTargets.Right = CFrame.new()
			else
				p211.ArmOffsetTargets.Right = v_u_208
			end
			if p213.Left then
				p211.ArmOffsetTargets.Left = CFrame.new()
			else
				p211.ArmOffsetTargets.Left = v_u_207
			end
		end
	end
end
function v_u_50.SetArmOffset(p214, p215, p216) -- name: SetArmOffset
	if p215 == "Right" or p215 == "Left" then
		p214.ArmOffsetTargets[p215] = p216
	end
end
function v_u_50.GetArmOffset(p217, p218) -- name: GetArmOffset
	if p218 == "Right" or p218 == "Left" then
		return p217.ArmOffsets[p218]
	else
		return CFrame.new()
	end
end
function v_u_50.UpdateArmOffsets(p219, p220) -- name: UpdateArmOffsets
	local v221 = p219.ArmOffsetSpeed * p220
	local v222 = math.clamp(v221, 0.01, 1)
	p219.ArmOffsets.Right = p219.ArmOffsets.Right:Lerp(p219.ArmOffsetTargets.Right, v222)
	p219.ArmOffsets.Left = p219.ArmOffsets.Left:Lerp(p219.ArmOffsetTargets.Left, v222)
	p219.ViewmodelBaseOffset = p219.ViewmodelBaseOffset:Lerp(p219.ViewmodelBaseOffsetTarget, v222)
end
function v_u_50.CreateDedicatedArms(p223) -- name: CreateDedicatedArms
	-- upvalues: (copy) v_u_11
	if p223.DedicatedArms then
		return p223.DedicatedArms
	end
	if not p223.Model then
		return nil
	end
	p223.DedicatedArms = v_u_11:CreateDedicatedArms(p223.Model)
	return p223.DedicatedArms
end
function v_u_50.DestroyDedicatedArms(p224) -- name: DestroyDedicatedArms
	-- upvalues: (copy) v_u_11
	if p224.DedicatedArms then
		v_u_11:DestroyDedicatedArms(p224.Model)
		p224.DedicatedArms = nil
	end
end
function v_u_50.ApplyImpulse(p225, p226) -- name: ApplyImpulse
	p225.ImpulseCF = p225.ImpulseCF * p226
end
function v_u_50.ApplyOffset(p227, p228, p229) -- name: ApplyOffset
	p227.Offsets[p228] = p229 or CFrame.new()
	updateOffset(p227)
end
function v_u_50.RemoveOffset(p230, p231) -- name: RemoveOffset
	p230.Offsets[p231] = nil
	updateOffset(p230)
end
function v_u_50.ApplyOffsetImpulse(p232, p233, p234) -- name: ApplyOffsetImpulse
	local v235 = p232.Offsets[p233]
	if v235 then
		p232.Offsets[p233] = v235 * (p234 or CFrame.new())
		updateOffset(p232)
	else
		_G:warn("Tried to apply impulse to a non-existant offset: " .. p233)
	end
end
function v_u_50.UpdatePhysics(p236) -- name: UpdatePhysics
	-- upvalues: (copy) v_u_22, (copy) v_u_41, (copy) v_u_21, (copy) v_u_25, (copy) v_u_14, (copy) v_u_48, (copy) v_u_49, (ref) v_u_40
	local v237 = p236.Weapon.Config
	if v237.BlockSpringSpeed and p236.Weapon.Blocking then
		v_u_22.BlockSpring.Speed = v237.BlockSpringSpeed
	else
		v_u_22.BlockSpring.Speed = 25
	end
	v_u_22.BlockSpring.Target = p236.Weapon.Blocking and 1 or 0
	local v238 = p236.IsDualWieldRight or p236.IsMirrored
	local v239 = p236.ForceOneHanded
	if v239 then
		v239 = not v238
	end
	v_u_41.Target = v_u_21.States.Crouching and not (p236.Weapon.Aiming or (v238 or v239)) and 1 or 0
	local v240 = v_u_21.ThirdPerson or v_u_21.hrp
	if v240 then
		v240 = v_u_22.TPSpring.Position > 0.05
	end
	if v240 then
		v240 = v_u_25:ShouldGunRest()
	end
	local v241 = not v238
	if not v241 then
		if v237.DualWieldRestMode == "sprint" then
			v241 = true
		else
			local v242 = v237.DualWieldRestMode
			v241 = typeof(v242) == "CFrame"
		end
	end
	local v243 = p236.ForceOneHanded
	if v243 then
		v243 = not v238
	end
	if v241 then
		v241 = not v243
	end
	if v_u_21.States.Sliding then
		v_u_22.SprintSpring.Target = 0
	elseif v_u_21.States.Sprinting and not v237.FireWhileSprinting then
		v_u_22.SprintSpring.Target = v_u_21.States.Jogging and 0.5 or 1
	elseif v240 and v241 then
		v_u_22.SprintSpring.Target = 1
	else
		v_u_22.SprintSpring.Target = 0
	end
	v_u_14.UpdateRotation("Sliding", nil, v_u_48():Lerp(p236.Weapon.Config.CrouchAnimation or v_u_48(-0.6, 0, 0) * v_u_49(0, 0, 0.7853981633974483), v_u_41.Position))
	local v244 = v_u_48(0, 0, 0) * v_u_49(-0.7853981633974483, 0.4363323129985824, 0.4363323129985824)
	local v245 = (p236.LeftArmOnly or p236.IsMirrored) and p236.EquipSpring.Position or v_u_22.EquipSpring.Position
	local v246 = v_u_48():Lerp(v244, v245)
	local v247 = p236.Config.SprintOffset
	if v238 and p236.Config.DualWieldSprintOffset then
		v247 = p236.Config.DualWieldSprintOffset
	end
	v_u_40 = CFrame.new():Lerp(v247, v_u_22.SprintSpring.Position) * CFrame.new():Lerp(p236.Config.BlockOffset or v_u_48(), v_u_22.BlockSpring.Position) * v246
end
function createVM(p248) -- name: createVM
	-- upvalues: (copy) v_u_38
	local v249 = p248.Name
	local v250 = p248.Config.Viewmodel
	if v250 then
		if not v_u_38[v249] or p248.dontCache then
			v_u_38[v249] = true
			for v251 = 1, p248.Config.BarrelCount or 1 do
				local v252 = v250:WaitForChild("KeyParts"):FindFirstChild("Barrel" .. (v251 > 1 and v251 and v251 or "")) or v250.KeyParts.Handle
				local v253 = Instance.new("Attachment")
				v253.Name = "BarrelAttachment"
				v253.Parent = v252
				for _, v254 in v252:GetChildren() do
					if v254:IsA("ParticleEmitter") or (v254:IsA("Light") or v254:IsA("Attachment") and v254 ~= v253) then
						v254.Parent = v253
					end
				end
			end
		end
		local v255 = v250:Clone()
		v255.Name = v249
		local v256 = v255:FindFirstChild("HumanoidRootPart")
		if v256 then
			local v257 = v255:FindFirstChildWhichIsA("AnimationController")
			if not v257 then
				v257 = Instance.new("AnimationController")
				v257.Parent = v255
			end
			local v258 = v257:FindFirstChildOfClass("Animator")
			if not v258 then
				v258 = Instance.new("Animator")
				v258.Parent = v257
			end
			for _, v259 in v255:QueryDescendants("BasePart") do
				v259.CastShadow = false
			end
			return v255, v256, v258
		end
		warn("[Viewmodel]: Could not find HumanoidRootPart for weapon: " .. v249)
	else
		warn("[Viewmodel] Could not find viewmodel for weapon: " .. v249)
	end
end
function updateOffset(p260) -- name: updateOffset
	p260.TotalOffset = CFrame.new()
	for _, v261 in pairs(p260.Offsets) do
		p260.TotalOffset = p260.TotalOffset * v261
	end
end
function loadAnimations(p_u_262, p263, p264) -- name: loadAnimations
	-- upvalues: (copy) v_u_34
	local v265 = {}
	for _, v266 in pairs(p264:GetChildren()) do
		if v266:IsA("Animation") then
			local v_u_267 = p_u_262.Weapon.Config
			local v268 = p263:LoadAnimation(v266)
			v268.Looped = v266.Name == "Idle"
			p_u_262.Janitor:Add(v268, "Destroy")
			p_u_262.Janitor:Add(v268.KeyframeReached:Connect(function(p269)
				-- upvalues: (copy) v_u_267, (copy) p_u_262, (ref) v_u_34
				if v_u_267.KeyFrameSounds[p269] then
					local v270 = Instance.new("Sound")
					v270.SoundId = "rbxassetid://" .. (v_u_267.KeyFrameSounds[p269][1] or v_u_267.KeyFrameSounds[p269].SoundId)
					v270.Volume = v_u_267.KeyFrameSounds[p269][2] or v_u_267.KeyFrameSounds[p269].Volume
					v270.Parent = script
					game:GetService("SoundService"):PlayLocalSound(v270)
					game.Debris:AddItem(v270, 10)
				end
				if v_u_267.ShellOn and (p269 == v_u_267.ShellOn and p_u_262.Weapon.NeedShell) then
					p_u_262.Weapon.NeedShell = false
					v_u_34:Eject(p_u_262)
				end
				if v_u_267.OnKeyframeReached then
					v_u_267.OnKeyframeReached(p269, p_u_262.Weapon)
				end
				if v_u_267.CustomKF then
					v_u_267.CustomKF(p269, p_u_262.Model, p_u_262.Weapon.Config)
				end
			end), "Disconnect")
			v265[v266.Name] = v268
		end
	end
	if v265.Idle then
		v265.Idle:Play(0, 1, 1)
		v265.Idle.Priority = Enum.AnimationPriority.Idle
		v265.Idle.Looped = true
	else
		local v271 = p_u_262.Weapon.Config.IsMelee and p264.Swing1:Clone() or (p_u_262.Weapon.Config.UsesLoadLoop and p264.LoadStart:Clone() or p264.Reload:Clone())
		v271.Name = "Idle"
		local v272 = p263:LoadAnimation(v271)
		v272.Looped = true
		repeat
			task.wait()
		until v272.Length > 0
		v272:Play(0, 1, 1)
		v272.TimePosition = v272.Length
		v272:AdjustSpeed(0)
		v265.Idle = v272
	end
	if v265.IdleLayer then
		v265.IdleLayer:Play(0, 1, 1)
	end
	return v265
end
function setupViewmodel(p_u_273) -- name: setupViewmodel
	-- upvalues: (copy) v_u_6, (copy) v_u_29, (copy) v_u_30, (copy) v_u_37, (copy) v_u_1
	local v_u_274, v275, v276 = createVM(p_u_273.Weapon)
	p_u_273.Model = v_u_274
	p_u_273.PrimaryPart = v275
	p_u_273.Barrel = v_u_274:WaitForChild("KeyParts"):FindFirstChild("Barrel") or v_u_274.KeyParts:FindFirstChild("Handle")
	p_u_273.BarrelAttachment = p_u_273.Barrel:WaitForChild("BarrelAttachment")
	p_u_273.Aimpart = v_u_274.KeyParts:FindFirstChild("Aimpart")
	p_u_273.DefaultAimpart = p_u_273.Aimpart
	p_u_273.Animator = v276
	v_u_274.Parent = v_u_6
	p_u_273.Animations = loadAnimations(p_u_273, v276, v_u_274:WaitForChild("Animations"))
	p_u_273.Animations.Idle.Priority = Enum.AnimationPriority.Core
	if p_u_273.Weapon.Mods then
		v_u_29.DressWeapon(v_u_274.Name, p_u_273.Weapon.Mods, p_u_273.Weapon.Config.AttachmentNodeData, v_u_274, function(_, p277, p278)
			-- upvalues: (copy) v_u_274, (ref) v_u_6, (copy) p_u_273, (ref) v_u_30
			local v279 = v_u_274.Parent
			v_u_274.Parent = v_u_6
			local v280
			if p278 then
				v280 = require(p278).new(p277, p_u_273.Weapon.Config, p_u_273)
				if v280.SettingChanges then
					for v281, v282 in v280.SettingChanges do
						if v281 == "Aimpart" then
							p_u_273.Aimpart = v282
							local v283 = p_u_273.Model.KeyParts.Handle
							local v284 = v282.CFrame:toObjectSpace(v283.CFrame)
							p_u_273.Aimpart:BreakJoints()
							local v285 = Instance.new("Weld")
							v285.Name = v283.Name .. ":" .. v282.Name
							v285.Part0 = v283
							v285.Part1 = v282
							v285.C0 = CFrame.new()
							v285.C1 = v284
							v285.Parent = v283
						elseif v281 == "Lense" then
							if p_u_273.Weapon.Config.Lense then
								p_u_273.Model.KeyParts:WaitForChild("Lense"):FindFirstChildWhichIsA("SurfaceGui").Enabled = false
							end
							if p_u_273.Weapon.Config.Shadow and not v280.SettingChanges.Shadow then
								p_u_273.Weapon.Config.Shadow = false
								p_u_273.Model.KeyParts:WaitForChild("Shadow"):FindFirstChildWhichIsA("SurfaceGui").Enabled = false
							end
							p_u_273.LenseIsCircular = v282:GetAttribute("IsCircular") == true
							p_u_273.Reticle = v282:FindFirstChildWhichIsA("ImageLabel", true)
						elseif v281 == "Shadow" then
							p_u_273.ShadowRing = v282:FindFirstChild("Ring", true)
							if p_u_273.Weapon.Config.Shadow then
								p_u_273.Weapon.Config.Shadow = false
								p_u_273.Model.KeyParts:WaitForChild("Shadow"):FindFirstChildWhichIsA("SurfaceGui").Enabled = false
							end
						elseif v281 == "BarrelAttachment" then
							p_u_273.BarrelAttachment = v282
						end
						if v281 == "Damage" and (p_u_273.Weapon.Config.DamageDropoff and not v280.SettingChanges.DamageDropoff) then
							p_u_273.Weapon.Config.DamageDropoff = v_u_30.RescaleDropoff(p_u_273.Weapon.Config.DamageDropoff, p_u_273.Weapon.Config.Damage, v282)
						end
						p_u_273.Weapon.Config[v281] = v282
					end
				end
			else
				v280 = nil
			end
			v_u_274.Parent = v279
			return v280
		end, true)
	end
	p_u_273.AnimatedTextures = v_u_37.collect(v_u_274)
	if p_u_273.Weapon.Config.Lense == true then
		p_u_273.Weapon.Config.Lense = p_u_273.Model.KeyParts:WaitForChild("Lense")
		p_u_273.Weapon.Config.Lense:FindFirstChildWhichIsA("SurfaceGui").Enabled = true
		p_u_273.LenseIsCircular = p_u_273.Weapon.Config.Lense:GetAttribute("IsCircular") == true
		p_u_273.Reticle = p_u_273.Weapon.Config.Lense:FindFirstChildWhichIsA("ImageLabel", true)
	end
	if p_u_273.Weapon.Config.Shadow == true then
		p_u_273.Weapon.Config.Shadow = p_u_273.Model.KeyParts:WaitForChild("Shadow")
		p_u_273.Weapon.Config.Shadow:FindFirstChildWhichIsA("SurfaceGui").Enabled = true
		p_u_273.ShadowRing = p_u_273.Weapon.Config.Shadow:FindFirstChildWhichIsA("ImageLabel", true)
	end
	if p_u_273.Weapon.Config.MuzzleModule then
		local v286 = v_u_1.common.SharedResources.MuzzleFlash[p_u_273.Weapon.Config.MuzzleModule]
		v286.Effects.MuzzleModuleFX:Clone().Parent = p_u_273.BarrelAttachment
		p_u_273.MuzzleModule = require(v286)
	end
	p_u_273.EjectionAttachment = p_u_273.Model.KeyParts.Handle:FindFirstChild("BulletEjection")
	if p_u_273.EjectionAttachment and not p_u_273.EjectionAttachment:IsA("Attachment") then
		p_u_273.EjectionAttachment = nil
	end
	v_u_274.Parent = nil
	p_u_273.ViewmodelLoaded = true
	p_u_273.ConfigLoaded:Fire()
	p_u_273:_resolveIdleAimCFrame()
end
function loadViewmodelPromise(p_u_287) -- name: loadViewmodelPromise
	-- upvalues: (copy) v_u_26
	return v_u_26:StreamViewmodel(p_u_287.Weapon.WeaponId):andThen(function(p288, p289)
		-- upvalues: (copy) p_u_287
		p_u_287.Weapon.dontCache = p289
		p_u_287.Weapon.Config.Viewmodel = p288
		if not p_u_287.Weapon.IsDestroyed then
			setupViewmodel(p_u_287)
		end
	end)
end
function Lerp(p290, p291, p292) -- name: Lerp
	return p290 * (1 - p292) + p291 * p292
end
return v_u_50