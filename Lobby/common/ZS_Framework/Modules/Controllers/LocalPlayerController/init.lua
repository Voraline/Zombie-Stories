local v1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = require(v3.common.Settings)
local v_u_5 = require(v3.Packages.Fusion).peek
local v_u_6 = Instance.new("BindableEvent")
local v_u_7 = os.clock()
local v_u_8 = nil
local v_u_9 = true
local v_u_10 = 100
local v_u_11 = os.clock() + 0.75
local v_u_12 = os.clock()
local v_u_13 = 0
local v_u_14 = 1
local v_u_15 = {}
local v_u_16 = nil
local v_u_17 = 0
local v_u_18 = nil
local v_u_19 = CFrame.new()
local v_u_20 = CFrame.new()
local v_u_21 = 0
local v_u_22 = CFrame.new(0, -0.25, 0)
local v_u_23 = false
local v_u_24 = Vector3.new(0, 0, 0)
local v_u_25 = nil
local v_u_26 = nil
local v_u_27 = nil
local v_u_28 = nil
local v_u_29 = nil
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = nil
local v_u_33 = nil
local v_u_34 = CFrame.new(0, 1.5, 0)
require(v3.common.ZS_Shared.Data.GameState)
local v_u_35 = require(v3.common.skillTree.SkillTreeData)
local v_u_36 = require(v3.Packages.Fusion)
local v37 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
local v_u_38 = CFrame.new(0, 0, 0, -1, 0, 0, 0, -0.1097783, 0.993956029, 0, 0.993956029, 0.1097783)
local v39 = CFrame.new(0, 0, 1.25) * v_u_38
local v40 = CFrame.new(0, 0, -1.5) * v_u_38
local v41 = CFrame.new(0, -0.5, 1.25) * CFrame.Angles(0, 3.141592653589793, 0)
local v_u_42 = require(v3.common.ZS_Shared.Data.GameState)
local v_u_43 = {
	["Normal"] = v37,
	["NormalFP"] = v40,
	["Slide"] = v39,
	["Prone"] = v41
}
local v_u_44 = 5
local v_u_45 = 5
local v_u_46 = 10
local v_u_47 = 0.25
local v_u_48 = os.clock()
local v49 = game.ReplicatedStorage.common
local v50 = script:WaitForChild("LocalPlayerUtils")
local v51 = v50:WaitForChild("PlayerMovementUtil")
v50:WaitForChild("PlayerStateUtil")
local v52 = script.Parent.Parent:WaitForChild("Shared")
local v_u_53 = workspace.CurrentCamera
local v_u_54 = script:WaitForChild("Resources")
local v_u_55 = v1.LocalPlayer
v_u_54:WaitForChild("AlignPosition")
local v_u_56 = require(v52:WaitForChild("SharedSprings"))
local v_u_57 = require(v50:WaitForChild("PhysBallUtil"))
local v_u_58 = require(script.Parent.Parent.Utils:WaitForChild("CharacterAnimator"))
local v_u_59 = require(script.Parent:WaitForChild("ViewmodelManager"))
local v_u_60 = nil
local v_u_61 = nil
local v_u_62 = 0
local v_u_63 = false
local v_u_64 = 0
local function v_u_82(p65, _) -- name: GetSafeFirstPersonOffset
	-- upvalues: (ref) v_u_64, (ref) v_u_63, (copy) v_u_38, (ref) v_u_61, (ref) v_u_62
	local v66 = os.clock()
	local v67 = v66 - v_u_64 > 0.1
	v_u_64 = v66
	if v_u_63 and not v67 then
		return CFrame.new(0, 0, 1.25) * v_u_38
	end
	local v68 = workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)
	local v69
	if v68.Magnitude > 0.3 then
		v69 = v68.Unit
	else
		local v70 = p65.CFrame.LookVector * Vector3.new(1, 0, 1)
		v69 = v70.Magnitude <= 0.01 and Vector3.new(0, 0, -1) or v70.Unit
	end
	local v71 = -v69
	local v72 = p65.Position + v69 * 0.5
	local v73 = v_u_61.CustomRayDirection(v72, v71 * 3, true)
	local v74 = -p65.CFrame.LookVector
	local v75 = v_u_61.CustomRayDirection(p65.Position, v74 * 3, true)
	local v76 = 3
	if v73.Instance then
		local v77 = v73.Distance - 0.5
		v76 = math.min(v76, v77)
	end
	if v75.Instance then
		local v78 = v75.Distance
		v76 = math.min(v76, v78)
	end
	local v79 = v76 - 1
	local v80 = math.max(0, v79)
	local v81 = math.min(1.25, v80)
	if v67 then
		v_u_62 = v81
		v_u_63 = false
	else
		v_u_62 = v_u_62 + (v81 - v_u_62) * 0.03
	end
	if v_u_62 >= 1.24 then
		v_u_62 = 1.25
		v_u_63 = true
	end
	return CFrame.new(0, 0, v_u_62) * v_u_38
end
local v_u_83 = require(v49.PlayerHandler)
local v84 = require(v49.Signal)
local v_u_85 = Enum.RenderPriority.Character.Value + 1
local v_u_86 = {
	["PlayerVelocity"] = 0,
	["PlayerVelocityDT"] = 0,
	["character"] = nil,
	["head"] = nil,
	["hrp"] = nil,
	["humanoid"] = require(v50:WaitForChild("HumanoidUtil")),
	["PlayerMovementUtil"] = require(v51),
	["States"] = v_u_83:WaitForPlayerState(v_u_55),
	["CharacterChanged"] = v_u_6.Event,
	["StaminaChanged"] = v84.new(),
	["ThirdPersonChanged"] = v84.new(),
	["MovementEnabled"] = true,
	["FocusEnabled"] = false,
	["SprintPressed"] = false,
	["CrouchPressed"] = false,
	["PronePressed"] = false,
	["RequestSlideJump"] = false,
	["RequestVault"] = false,
	["RequestThirdPerson"] = false,
	["ThirdPersonSide"] = v_u_5(v_u_4.Camera.ThirdPersonSide) == 2 and -1 or 1
}
v_u_4.SettingsChanged:Connect(function(p87)
	-- upvalues: (copy) v_u_86, (copy) v_u_5, (copy) v_u_4
	if p87 and (p87[1] == "Camera" and p87[2] == "ThirdPersonSide") then
		v_u_86.ThirdPersonSide = v_u_5(v_u_4.Camera.ThirdPersonSide) == 2 and -1 or 1
	end
	if p87 and (p87[1] == "Graphics" and (p87[2] == "ProceduralAnimations" and v_u_86.Animator)) then
		v_u_86.Animator:SetIKEnabled(v_u_5(v_u_4.Graphics.ProceduralAnimations))
	end
end)
function v_u_86.HPUpdated(_, p88) -- name: HPUpdated
	-- upvalues: (copy) v_u_86
	v_u_86.HP = p88
	v_u_86.humanoid:hpUpdated(p88)
end
function v_u_86.SetWalkSpeedOverride(_, p89) -- name: SetWalkSpeedOverride
	-- upvalues: (copy) v_u_86
	v_u_86.WalkSpeedOverride = p89
end
function v_u_86.InfiniteStamina(_) -- name: InfiniteStamina
	-- upvalues: (ref) v_u_44, (ref) v_u_45, (ref) v_u_46, (ref) v_u_47
	v_u_44 = 0
	v_u_45 = 0
	v_u_46 = 0
	v_u_47 = 0
	game:GetService("SoundService"):PlayLocalSound(workspace.Cola)
end
function v_u_86.Init(_) -- name: Init
	-- upvalues: (ref) v_u_61, (copy) v_u_83, (copy) v_u_86, (copy) v_u_36, (copy) v_u_35, (ref) v_u_60, (ref) v_u_18, (copy) v_u_55, (copy) v_u_6, (copy) v_u_57, (copy) v_u_56, (copy) v_u_2, (copy) v_u_85, (copy) v_u_59, (ref) v_u_47, (ref) v_u_10, (ref) v_u_11, (ref) v_u_48, (ref) v_u_17, (copy) v_u_54, (ref) v_u_16, (copy) v_u_82, (copy) v_u_43, (ref) v_u_20, (ref) v_u_19, (ref) v_u_26, (copy) v_u_22, (ref) v_u_21, (ref) v_u_23, (ref) v_u_25, (ref) v_u_24, (ref) v_u_28, (ref) v_u_31, (ref) v_u_29, (ref) v_u_30
	local v_u_90 = require("./CameraController")
	v_u_61 = require("../Utils/RaycastUtil")
	v_u_83.HealthChanged:Connect(function(p91, p92, p93)
		-- upvalues: (ref) v_u_86, (copy) v_u_90, (ref) v_u_36, (ref) v_u_35, (ref) v_u_60, (ref) v_u_18
		v_u_86:HPUpdated(p91)
		if p92 > 0 then
			v_u_90.CameraShaker:ShakeOnce(7, 7, 0, 0.5, Vector3.new(), Vector3.new(1, 1, 1))
			local v94 = v_u_36.peek(v_u_35.AdrenalineStamina) or 0
			if v94 > 0 then
				v_u_60(v94)
			end
			if v_u_86.CurrentWeapon and (p93 and p93.damagePos) then
				local v95 = -(p93.damagePos - v_u_86.hrp.Position).unit
				local v96 = v95:Dot(v_u_86.hrp.CFrame.lookVector)
				local v97 = v95:Dot(v_u_86.hrp.CFrame.rightVector)
				v_u_86.CurrentWeapon.Viewmodel:ApplyImpulse(CFrame.Angles(0.13962634015954636 * v96, -0.13962634015954636 * v97, -0.05235987755982989 * v97))
			end
		end
		if p91 <= 0 then
			v_u_18 = true
			v_u_86.CrouchPressed = false
			v_u_86.RequestSlideJump = false
			v_u_86.humanoid.HasLanded = true
		elseif v_u_18 then
			v_u_18 = false
			v_u_86.CrouchPressed = false
			v_u_86.RequestSlideJump = false
			v_u_86.humanoid.HasLanded = true
			if not v_u_86.PhysBall.chasis.Parent and (v_u_86.PhysBall.chasisLoaded and not v_u_86.PhysBall.loadingChasis) then
				PlayerRespawned()
			end
		end
	end)
	v_u_55.CharacterRemoving:Connect(function()
		-- upvalues: (ref) v_u_6
		v_u_6:Fire(nil)
	end)
	v_u_86.PlayerMovementUtil:Init()
	v_u_86.PhysBall = v_u_57.new(game.Players.LocalPlayer)
	v_u_86.humanoid:SetJumpPower(30)
	v_u_86.humanoid.Landed:Connect(function()
		-- upvalues: (ref) v_u_56
		v_u_56.YawSpring.Position = v_u_56.YawSpring.Position + 0.05
	end)
	v_u_86.humanoid.Jumped:Connect(function()
		-- upvalues: (ref) v_u_56
		v_u_56.YawSpring.Position = v_u_56.YawSpring.Position - 0.05
	end)
	v_u_2.Stepped:Connect(function(_, p98)
		-- upvalues: (ref) v_u_86
		if v_u_86.Animator and v_u_86.character then
			v_u_86.Animator:UpdateStepped(p98)
		end
	end)
	v_u_2:BindToRenderStep("LPC", v_u_85, function(p99)
		-- upvalues: (ref) v_u_86, (ref) v_u_59, (ref) v_u_36, (ref) v_u_35, (ref) v_u_47, (ref) v_u_55, (ref) v_u_10, (ref) v_u_11, (ref) v_u_48, (ref) v_u_17, (ref) v_u_54, (ref) v_u_16, (ref) v_u_82, (ref) v_u_43, (ref) v_u_20, (ref) v_u_61, (ref) v_u_19, (ref) v_u_26, (ref) v_u_22, (ref) v_u_21, (ref) v_u_23, (ref) v_u_25, (ref) v_u_24, (ref) v_u_28, (ref) v_u_31, (ref) v_u_29, (ref) v_u_30
		GetNewPlayerCharacter()
		if v_u_86.humanoid.Humanoid and v_u_86.character then
			StatesHandler()
			SlidingHandler(p99)
			VaultingHandler()
			local v100 = -1 * (p99 * 10)
			local v101 = 1 - math.exp(v100)
			local v102 = math.clamp(v101, 0.01, 1)
			if v_u_86.Animator then
				v_u_86.Animator:SetState(v_u_86.States)
				v_u_86.Animator:SetWeaponEquipped(v_u_86.CurrentWeapon ~= nil)
				local v103 = v_u_86.CurrentWeapon and v_u_59:GetEntry(v_u_86.CurrentWeapon)
				if v103 then
					v_u_86.Animator:SetArmControl(v103.GrantedArms.Left, v103.GrantedArms.Right)
				end
				v_u_86.Animator:UpdateRenderStepped(p99)
			end
			HandleHumanoid(v102)
			if v_u_86.States.Sprinting then
				if not v_u_86.States.Jogging then
					local v104 = v_u_36.peek(v_u_35.DesperateSprintThreshold) or 0
					local v105 = v_u_86.States.HP or 100
					local v106 = v_u_86.States.MaxHP or 100
					local v107 = v106 > 0 and v105 / v106 or 1
					if v104 <= 0 or v104 < v107 then
						DrainStamina(v_u_47 * v102)
					end
				end
			else
				local v108 = v_u_55:GetAttribute("Skill_StaminaRegenMult") or 1
				local v109 = 100 * (v_u_55:GetAttribute("Skill_StaminaMaxMult") or 1)
				if v_u_10 < v109 and (v_u_11 < os.clock() and v_u_48 < os.clock()) then
					setStamina(v_u_10 + v102 * 2 * v108, v109 / 100)
				end
			end
			if v_u_86.TPPressed then
				v_u_17 = v_u_17 + p99
				if v_u_17 >= 0.33 then
					v_u_54.tp:Play()
					v_u_17 = 0
					v_u_86.TPPressed = false
					v_u_86.RequestThirdPerson = not v_u_86.RequestThirdPerson
				end
			else
				if v_u_86.ThirdPerson and v_u_17 > 0 then
					v_u_54.swapside:Play()
					if v_u_86.ThirdPersonSide > 0 then
						v_u_86.ThirdPersonSide = -1
					else
						v_u_86.ThirdPersonSide = 1
					end
				end
				v_u_17 = 0
			end
			if v_u_86.RequestThirdPerson and not v_u_86.States.IsDead then
				if v_u_86.CurrentWeapon and (v_u_86.CurrentWeapon.Config.AimFOVMultiplier and (v_u_86.CurrentWeapon.Config.AimFOVMultiplier <= 0.5 and v_u_86.States.Aiming)) then
					updateThirdPerson(false)
				else
					updateThirdPerson(true)
				end
			else
				updateThirdPerson(false)
				if v_u_86.States.IsDead then
					v_u_86.RequestThirdPerson = false
				end
			end
			if v_u_16 then
				local v110
				if v_u_86.ThirdPerson then
					v110 = v_u_86.States.Proning and "Prone" or "Normal"
				else
					local v111 = v_u_86.States.Proning and "Prone" or (v_u_86.States.Sliding and "Slide" or "NormalFP")
					v110 = (v_u_86.States.IsDowned or v_u_86.States.IsDead) and "Normal" or v111
				end
				local v112 = not v_u_86.ThirdPerson
				local v113
				if v110 == "NormalFP" and v_u_86.hrp then
					v113 = v_u_82(v_u_86.hrp, v112)
				else
					v113 = v_u_43[v110]
				end
				v_u_20 = v_u_20:Lerp(v113, v102)
				local v114 = v_u_86.hrp
				if (v_u_86.States.Proning or v_u_86.States.IsDowned) and (v114 and v114.Parent) then
					local v115 = v_u_61.CustomRay(v114.CFrame.Position, v114.CFrame.Position + Vector3.new(0, -5, 0), true)
					if v115.Instance then
						local v116 = v115.Normal
						local v117 = v116:Cross(v114.CFrame.LookVector).Unit
						local v118 = v117:Cross(v116).Unit
						local v119 = CFrame.new(0, 0, 0, v117.X, v116.X, v118.X, v117.Y, v116.Y, v118.Y, v117.Z, v116.Z, v118.Z)
						local v120 = v114.CFrame.Rotation:ToObjectSpace(v119)
						v_u_19 = v_u_19:lerp(v120 * CFrame.Angles(0, -3.141592653589793, 0), v102)
						if v_u_26 then
							v_u_26.C0 = v_u_26.C0:Lerp(v_u_22 * v120, v102)
						end
					else
						v_u_19 = v_u_19:lerp(CFrame.new(), v102)
						if v_u_26 then
							v_u_26.C0 = v_u_26.C0:Lerp(v_u_22, v102)
						end
					end
				else
					v_u_19 = v_u_19:lerp(CFrame.new(), v102)
				end
				local v121 = v_u_19 * v_u_20
				if v_u_86.ThirdPerson then
					v_u_16.C0 = v121
				else
					v_u_21 = v_u_21 + ((v_u_86.States.Proning and 1 or (v_u_86.States.Crouching and 0.25 or 0)) - v_u_21) * v102
					local v122 = v_u_21
					if math.abs(v122) < 0.01 then
						v_u_21 = 0
					end
					if v_u_86.States.Crouching and not v_u_86.States.Sliding then
						local v123 = CFrame.new(0, v_u_21, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
						local v124 = CFrame.new(0, 0, 1)
						local v125 = (0.5 - v_u_21) / 0.25
						v_u_16.C0 = v121 * v123:Lerp(v124, (math.clamp(v125, 0, 1)))
					elseif v_u_86.States.Sliding then
						v_u_16.C0 = v121 * CFrame.new(0, 1, 0)
					else
						v_u_16.C0 = v121 * CFrame.new(0, v_u_21, 0)
					end
				end
				if v114 then
					v114.Size = Vector3.new(2, 2, 1)
				end
				if v114 then
					local v126 = v_u_86.character
					if v126 then
						v126 = v_u_86.character:FindFirstChild("Torso")
					end
					if v126 then
						v126.CanCollide = false
					end
					local v127 = v_u_86.States.Proning or v_u_86.States.Diving
					if v127 and (v_u_23 and v_u_86.character) then
						for _, v128 in v_u_86.character:GetChildren() do
							if v128:IsA("BasePart") and (v128.Name ~= "ProneCollider" and (v128.Name ~= "FPHeadCollider" and v128.Name ~= "Vehicle")) then
								v128.CanCollide = false
							end
						end
						if v127 and (v_u_25 and v_u_25.Parent) then
							local v129 = v_u_25.Position
							local v130 = v_u_86.hrp.CFrame.LookVector * Vector3.new(1, 0, 1)
							if v130.Magnitude > 0.01 then
								v130 = v130.Unit
							end
							local v131 = Vector3.new(0, 0, 0)
							local v132 = v_u_61.CollisionRayDirection(v129, v130 * 4)
							if v132.Instance then
								local v133 = 4 - v132.Distance + 0.5
								if v133 > 0 then
									v131 = v131 - v130 * v133
								end
							end
							local v134 = v_u_61.CollisionRayDirection(v129, -v130 * 4)
							if v134.Instance then
								local v135 = 4 - v134.Distance + 0.5
								if v135 > 0 then
									v131 = v131 + v130 * v135
								end
							end
							v_u_24 = v131
						else
							v_u_24 = Vector3.new(0, 0, 0)
						end
					elseif not v127 and v_u_23 then
						v_u_28()
					end
					local v136 = not v_u_86.ThirdPerson
					if v136 then
						v136 = not v127
					end
					if v136 and not v_u_31 then
						v_u_29()
					elseif not v136 and v_u_31 then
						v_u_30()
					end
				end
			end
			v_u_86.PlayerVelocityDT = v_u_86.PlayerVelocityDT + v_u_86.PlayerVelocity * p99
		end
	end)
end
function v_u_86.DrainStamina(_, p137, p138) -- name: DrainStamina
	-- upvalues: (copy) v_u_55, (ref) v_u_48
	DrainStamina(p137)
	local v139 = v_u_55:GetAttribute("Skill_StaminaCooldownMult") or 1
	v_u_48 = os.clock() + (p138 or 0) * v139
end
function v_u_86.GetStamina(_) -- name: GetStamina
	-- upvalues: (ref) v_u_10
	return v_u_10
end
function v_u_86.UpdateInventory(_, p140) -- name: UpdateInventory
	-- upvalues: (ref) v_u_15
	RefreshWalkspeedChanges()
	v_u_15 = p140
end
function v_u_86.UpdateCurrentWeapon(_) -- name: UpdateCurrentWeapon
	RefreshWalkspeedChanges()
end
v_u_55:GetAttributeChangedSignal("TurkeyHuntWalkSpeedBoostExpires"):Connect(function()
	RefreshWalkspeedChanges()
end)
v_u_55:GetAttributeChangedSignal("Skill_StaminaMaxMult"):Connect(function()
	-- upvalues: (copy) v_u_55
	local v141 = v_u_55:GetAttribute("Skill_StaminaMaxMult") or 1
	local v142 = 100 * v141
	setStamina(v142, v141)
end)
function v_u_86.SetMovementEnabled(_, p143) -- name: SetMovementEnabled
	-- upvalues: (copy) v_u_86
	v_u_86.MovementEnabled = p143
end
function v_u_86.FocusActivated(_, p144) -- name: FocusActivated
	-- upvalues: (copy) v_u_86
	v_u_86.FocusEnabled = p144
end
function setStamina(p145, p146) -- name: setStamina
	-- upvalues: (copy) v_u_55, (ref) v_u_10, (copy) v_u_86
	local v147 = 100 * (p146 or (v_u_55:GetAttribute("Skill_StaminaMaxMult") or 1))
	local v148 = math.clamp(p145, 0, v147)
	if v148 ~= v_u_10 then
		v_u_86.StaminaChanged:Fire(v148)
	end
	v_u_10 = v148
end
function DrainStamina(p149) -- name: DrainStamina
	-- upvalues: (copy) v_u_86, (copy) v_u_55, (ref) v_u_10, (ref) v_u_11
	local v150 = v_u_86.States.IsFocused
	local v151 = p149 * (v_u_55:GetAttribute("Skill_StaminaCostMult") or 1) * (v150 and p149 > 0 and 0.5 or 1)
	setStamina(v_u_10 - v151)
	if v_u_10 < 0 then
		setStamina(0)
	end
	v_u_11 = os.clock() + 0.75
end
local function _(p152) -- name: AddStamina
	-- upvalues: (ref) v_u_10
	setStamina(v_u_10 + p152)
end
function Lerp(p153, p154, p155) -- name: Lerp
	return p153 * (1 - p155) + p154 * p155
end
function PlayerRespawned() -- name: PlayerRespawned
	-- upvalues: (ref) v_u_9, (copy) v_u_86, (copy) v_u_57, (ref) v_u_27, (ref) v_u_26, (ref) v_u_25, (ref) v_u_23, (ref) v_u_33, (ref) v_u_32, (ref) v_u_31
	if v_u_9 then
		v_u_9 = false
	else
		if v_u_86.PhysBall then
			v_u_86.PhysBall:setActive(false)
			v_u_86.PhysBall:Destroy()
		end
		v_u_86.PhysBall = v_u_57.new(game.Players.LocalPlayer)
	end
	v_u_86.CrouchPressed = false
	v_u_86.PronePressed = false
	v_u_86.RequestSlideJump = false
	if v_u_27 then
		v_u_27:Disconnect()
		v_u_27 = nil
	end
	if v_u_26 then
		v_u_26:Destroy()
		v_u_26 = nil
	end
	if v_u_25 then
		v_u_25:Destroy()
		v_u_25 = nil
	end
	v_u_23 = false
	if v_u_33 then
		v_u_33:Disconnect()
		v_u_33 = nil
	end
	if v_u_32 then
		v_u_32:Destroy()
		v_u_32 = nil
	end
	if v_u_31 then
		v_u_31:Destroy()
		v_u_31 = nil
	end
end
local function v_u_160()
	-- upvalues: (copy) v_u_86, (ref) v_u_25, (ref) v_u_26, (copy) v_u_22, (ref) v_u_27
	if v_u_86.hrp and not v_u_25 then
		v_u_25 = Instance.new("Part")
		v_u_25.Name = "ProneCollider"
		v_u_25.Size = Vector3.new(2, 1, 1)
		v_u_25.Transparency = 1
		v_u_25.CanCollide = true
		v_u_25.CanQuery = false
		v_u_25.CanTouch = false
		v_u_25.Massless = true
		v_u_25.CollisionGroup = "Player"
		v_u_25.Parent = v_u_86.character
		v_u_26 = Instance.new("Weld")
		v_u_26.Part0 = v_u_86.hrp
		v_u_26.Part1 = v_u_25
		v_u_26.C0 = v_u_22
		v_u_26.Parent = v_u_86.hrp
		local v156 = v_u_86.character:FindFirstChild("Vehicle")
		if v156 and (v_u_25 and (v_u_25.Parent and not v_u_25:FindFirstChild("VehicleNoCollision"))) then
			local v157 = Instance.new("NoCollisionConstraint")
			v157.Name = "VehicleNoCollision"
			v157.Part0 = v_u_25
			v157.Part1 = v156
			v157.Parent = v_u_25
		end
		v_u_27 = v_u_86.character.ChildAdded:Connect(function(p158)
			-- upvalues: (ref) v_u_25
			if p158.Name == "Vehicle" and (p158:IsA("BasePart") and v_u_25) then
				if not v_u_25.Parent then
					return
				end
				if v_u_25:FindFirstChild("VehicleNoCollision") then
					return
				end
				local v159 = Instance.new("NoCollisionConstraint")
				v159.Name = "VehicleNoCollision"
				v159.Part0 = v_u_25
				v159.Part1 = p158
				v159.Parent = v_u_25
			end
		end)
	end
end
local function v_u_161()
	-- upvalues: (ref) v_u_27, (ref) v_u_26, (ref) v_u_25
	if v_u_27 then
		v_u_27:Disconnect()
		v_u_27 = nil
	end
	if v_u_26 then
		v_u_26:Destroy()
		v_u_26 = nil
	end
	if v_u_25 then
		v_u_25.CanCollide = false
		v_u_25:Destroy()
		v_u_25 = nil
	end
end
local function v_u_163()
	-- upvalues: (copy) v_u_86, (ref) v_u_160, (ref) v_u_23
	if v_u_86.character then
		for _, v162 in v_u_86.character:GetChildren() do
			if v162:IsA("BasePart") and (v162.Name ~= "ProneCollider" and v162.Name ~= "Vehicle") then
				v162.CanCollide = false
			end
		end
		v_u_160()
		v_u_23 = true
	end
end
local function _()
	-- upvalues: (copy) v_u_86, (ref) v_u_161, (ref) v_u_23
	if v_u_86.character then
		v_u_161()
		if v_u_86.hrp then
			v_u_86.hrp.CanCollide = true
		end
		v_u_23 = false
		if v_u_86.head then
			v_u_86.head.CanCollide = true
		end
	end
end
local function _()
	-- upvalues: (copy) v_u_86, (ref) v_u_31, (ref) v_u_32, (copy) v_u_34, (ref) v_u_33
	if v_u_86.hrp and not v_u_31 then
		v_u_31 = Instance.new("Part")
		v_u_31.Name = "FPHeadCollider"
		v_u_31.Size = Vector3.new(2, 1, 1)
		v_u_31.Transparency = 1
		v_u_31.CanCollide = true
		v_u_31.CanQuery = false
		v_u_31.CanTouch = false
		v_u_31.Massless = true
		v_u_31.CollisionGroup = "Player"
		v_u_31.Parent = v_u_86.character
		v_u_32 = Instance.new("Weld")
		v_u_32.Part0 = v_u_86.hrp
		v_u_32.Part1 = v_u_31
		v_u_32.C0 = v_u_34
		v_u_32.Parent = v_u_86.hrp
		local v164 = v_u_86.character:FindFirstChild("Vehicle")
		if v164 and (v_u_31 and (v_u_31.Parent and not v_u_31:FindFirstChild("FPHeadVehicleNoCollision"))) then
			local v165 = Instance.new("NoCollisionConstraint")
			v165.Name = "FPHeadVehicleNoCollision"
			v165.Part0 = v_u_31
			v165.Part1 = v164
			v165.Parent = v_u_31
		end
		v_u_33 = v_u_86.character.ChildAdded:Connect(function(p166)
			-- upvalues: (ref) v_u_31
			if p166.Name == "Vehicle" and (p166:IsA("BasePart") and v_u_31) then
				if not v_u_31.Parent then
					return
				end
				if v_u_31:FindFirstChild("FPHeadVehicleNoCollision") then
					return
				end
				local v167 = Instance.new("NoCollisionConstraint")
				v167.Name = "FPHeadVehicleNoCollision"
				v167.Part0 = v_u_31
				v167.Part1 = p166
				v167.Parent = v_u_31
			end
		end)
	end
end
local function _()
	-- upvalues: (ref) v_u_33, (ref) v_u_32, (ref) v_u_31
	if v_u_33 then
		v_u_33:Disconnect()
		v_u_33 = nil
	end
	if v_u_32 then
		v_u_32:Destroy()
		v_u_32 = nil
	end
	if v_u_31 then
		v_u_31.CanCollide = false
		v_u_31:Destroy()
		v_u_31 = nil
	end
end
function GetNewPlayerCharacter() -- name: GetNewPlayerCharacter
	-- upvalues: (copy) v_u_86, (copy) v_u_6, (copy) v_u_58, (ref) v_u_61, (copy) v_u_5, (copy) v_u_4, (ref) v_u_16
	if not v_u_86.character or v_u_86.character and v_u_86.character.Parent == nil then
		if v_u_86.character then
			v_u_86.character:Destroy()
		end
		if v_u_86.Animator then
			v_u_86.Animator:Destroy()
			v_u_86.Animator = nil
		end
		if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.Parent then
			v_u_86.character = game.Players.LocalPlayer.Character
			v_u_6:Fire(v_u_86.character)
			PlayerRespawned()
			v_u_86.Animator = v_u_58.new(v_u_86.character, true)
			if v_u_86.Animator then
				v_u_86.Animator:SetRaycastParams(v_u_61:GetAltRaycastParams())
				v_u_86.Animator:SetIKEnabled(v_u_5(v_u_4.Graphics.ProceduralAnimations))
			end
		else
			v_u_86.hrp = nil
			v_u_86.head = nil
			v_u_86.character = nil
		end
	end
	if (not v_u_86.hrp or v_u_86.hrp.Parent ~= v_u_86.character) and v_u_86.character then
		v_u_86.hrp = v_u_86.character:FindFirstChild("HumanoidRootPart")
		v_u_86.head = v_u_86.character:FindFirstChild("Head")
	end
	if (not v_u_16 or v_u_86.hrp and v_u_16.Parent ~= v_u_86.hrp) and (v_u_86.character and v_u_86.hrp) then
		v_u_86.hrp.CanCollide = true
		v_u_16 = v_u_86.hrp:FindFirstChild("RootJoint")
	end
	if v_u_86.hrp and v_u_86.character then
		local v168 = v_u_86.character:FindFirstChild("Vehicle")
		if v168 and not v_u_86.hrp:FindFirstChild("HRPVehicleNoCollision") then
			local v169 = Instance.new("NoCollisionConstraint")
			v169.Name = "HRPVehicleNoCollision"
			v169.Part0 = v_u_86.hrp
			v169.Part1 = v168
			v169.Parent = v_u_86.hrp
		end
	end
end
function VaultingHandler() -- name: VaultingHandler
	-- upvalues: (copy) v_u_86, (copy) v_u_53, (ref) v_u_61, (copy) v_u_54
	if v_u_86.humanoid.Humanoid.Jump == true and not v_u_86.Vaulted then
		if v_u_86.humanoid.Humanoid.MoveDirection:Dot(v_u_53.CFrame.LookVector) > 0.1 and (v_u_86.hrp and v_u_86.hrp.Parent) then
			local v170 = nil
			local v171 = nil
			local v172 = nil
			local v173 = v_u_86.hrp.CFrame
			local v174 = v173.Position - Vector3.new(0, 2.5, 0)
			local v175 = v_u_61.CustomRayDirection(v174, v173.LookVector * 3, true)
			if v175.Instance then
				local v176 = v175.Normal:Dot(Vector3.new(0, 1, 0))
				local v177 = math.acos(v176)
				v170 = v177 > 1.37 and v177 < 1.77 and true or v170
			end
			local v178 = v173.Position - Vector3.new(0, 0, 0)
			local v179 = v_u_61.CustomRayDirection(v178, v173.LookVector * 3, true).Instance and true or v171
			local v180 = v173.Position + Vector3.new(0, 3, 0)
			local v181 = v_u_61.CustomRayDirection(v180, v173.LookVector * 4, true).Instance and true or v172
			if not v_u_86.States.Crouching and (not v_u_86.States.Proning and (v170 and not (v179 and v181))) and v_u_86.hrp:FindFirstChild("RootAttachment") then
				v_u_54.slide_in1:Play()
				v_u_86.humanoid.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				v_u_86.humanoid.Animations.Vault:Play()
				local v182 = v173.LookVector + Vector3.new(0, 200, 0)
				v_u_86.hrp:ApplyImpulse(v182)
				v_u_86.Vaulted = true
				return
			end
		end
	elseif not v_u_86.humanoid.Humanoid.Jump then
		v_u_86.Vaulted = false
	end
end
function SlidingHandler(_) -- name: SlidingHandler
	-- upvalues: (copy) v_u_42, (copy) v_u_86, (ref) v_u_10, (ref) v_u_44, (ref) v_u_8, (ref) v_u_7, (copy) v_u_54, (copy) v_u_56, (ref) v_u_12, (ref) v_u_46
	if v_u_42.Data.Variables.SlidingEnabled then
		local v183 = v_u_86.humanoid.WaterSensor
		if v183 then
			v183 = v_u_86.humanoid.WaterSensor.TouchingSurface
		end
		local v184 = not v_u_86.hrp and 0 or v_u_86.hrp.AssemblyLinearVelocity
		if v_u_86.States.Sliding or (v183 or (v_u_86.States.Proning or (not v_u_86.States.Crouching or (not v_u_86.States.Sprinting or (v184.Magnitude <= 10 or v_u_44 > v_u_10))))) then
			local v185 = false
			local v186 = v_u_86.PhysBall.isGrounded
			if v186 then
				v_u_12 = os.clock() + 0.15
			else
				v186 = v186 or v_u_12 > os.clock()
			end
			if v_u_86.RequestSlideJump and not v_u_8 then
				v_u_86.RequestSlideJump = false
				if v_u_86.States.Sliding and (v_u_46 <= v_u_10 and v186) then
					DrainStamina(v_u_46)
					v_u_86.CrouchPressed = false
					v_u_8 = true
					v_u_7 = os.clock() + 0.2
					v_u_86.humanoid.Animations.Slide:Stop()
					v_u_54.crouch_out:Play()
					v_u_86.PhysBall:jump()
				else
					v_u_86.CrouchPressed = false
					v185 = true
				end
			end
			if v_u_86.RequestCancel then
				v_u_86.RequestCancel = false
				v185 = true
			end
			if v_u_86.States.Sliding then
				if v_u_86.States.Crouching and (v186 and v_u_7 < os.clock()) then
					v_u_8 = false
					if not v_u_86.humanoid.Animations.Slide.IsPlaying then
						v_u_86.humanoid.Animations.Slide:Play()
					end
				end
				local v187 = v_u_86.PhysBall.chasis.AssemblyLinearVelocity.Magnitude
				if v183 or not v_u_86.States.Crouching and (v_u_7 < os.clock() and v186) or (v187 < 7 and (v186 and v_u_7 < os.clock()) or (v_u_86.States.Proning or (v_u_86.States.Diving or v185 and v186) or (v_u_86.HP and v_u_86.HP <= 0 or not v_u_86.hrp))) then
					v_u_86.States.Sliding = false
					v_u_86.RequestCancel = false
					if v_u_8 and not v_u_86.States.Diving then
						v_u_54.prone_dive_landing:Play()
					end
					v_u_8 = false
				end
				if not v_u_86.States.Sliding and v_u_86.PhysBall.isActive then
					v_u_86.PhysBall:setActive(false)
					v_u_86.humanoid.Animations.Slide:Stop()
					v_u_54.slide_loop:Stop()
					v_u_8 = false
					return
				end
				local v188 = (v187 - 7) / 7
				v_u_54.slide_loop.Volume = v186 and (math.clamp(v188, 0, 1) or 0) or 0
				v_u_54.slide_loop.PlaybackSpeed = math.clamp(v188, 0.5, 1)
			end
		else
			DrainStamina(v_u_44)
			v_u_86.States.Sliding = true
			v_u_8 = false
			v_u_86.RequestSlide = false
			v_u_7 = os.clock() + 0.2
			v_u_54["slide_in" .. math.random(1, 2)]:Play()
			v_u_86.humanoid.Animations.Slide:Play()
			v_u_56.YawSpring.Position = v_u_56.YawSpring.Position - 0.1
			local v189 = v184.Y
			local v190 = v184 - Vector3.new(0, v189, 0)
			v_u_86.PhysBall:setActive(true, 2)
			v_u_86.PhysBall.chasis:ApplyImpulse(v190 * 1.5 + Vector3.new(0, -5, 0))
			v_u_54.slide_loop:Play()
		end
	else
		return
	end
end
function RefreshWalkspeedChanges() -- name: RefreshWalkspeedChanges
	-- upvalues: (ref) v_u_13, (ref) v_u_14, (ref) v_u_15, (copy) v_u_86, (copy) v_u_55
	v_u_13 = 0
	v_u_14 = 1
	for _, v191 in v_u_15 do
		if v191 and v191.Config then
			if v191 == v_u_86.CurrentWeapon then
				v_u_13 = v_u_13 + (v191.Config.EquippedWalkspeedChange or 0)
				v_u_14 = v_u_14 * (v191.Config.EquippedWalkspeedMultiplier or 1)
			else
				v_u_13 = v_u_13 + (v191.Config.HolsteredWalkspeedChange or 0)
				v_u_14 = v_u_14 * (v191.Config.HolsteredWalkspeedMultiplier or 1)
			end
		end
	end
	local v192 = v_u_86.States.StatusEffects.EffectObjects
	if v192 then
		for _, v193 in v192 do
			if v193.SpeedMult then
				v_u_14 = v_u_14 + v193.SpeedMult
			end
		end
	end
	local v194 = v_u_55:GetAttribute("TurkeyHuntWalkSpeedBoostExpires")
	local v195
	if typeof(v194) == "number" then
		local v196
		if workspace.GetServerTimeNow then
			v196 = workspace:GetServerTimeNow()
		else
			v196 = os.clock()
		end
		v195 = v194 - v196
	else
		v195 = 0
	end
	if v195 > 0 then
		v_u_14 = v_u_14 + 1
	end
end
local v197 = OverlapParams.new()
v197.CollisionGroup = "NPCCollision"
v197.RespectCanCollide = false
function HandleHumanoid(p198) -- name: HandleHumanoid
	-- upvalues: (copy) v_u_86, (copy) v_u_55, (ref) v_u_13, (ref) v_u_14, (copy) v_u_42, (ref) v_u_8
	local v199 = v_u_86.humanoid.Humanoid
	if v199 then
		local v200
		if v_u_86.States.IsDowned then
			v200 = 3
		elseif v_u_86.States.Crouching then
			v200 = 5
		elseif v_u_86.States.Proning then
			v200 = 4
		elseif v_u_86.States.Aiming then
			local v201 = v_u_86.CurrentWeapon
			v200 = not (v201 and v201.Config) and 9 or 9 * (v201.Config.AimWalkSpeedMultiplier or 1)
		else
			v200 = v_u_86.States.Blocking and 5 or (v_u_86.States.Sprinting and (v_u_86.States.Jogging and 15 or 19) or 13)
		end
		local v202 = v_u_55:GetAttribute("Skill_MoveSpeedMult")
		local v203 = (typeof(v202) ~= "number" or v202 <= 0) and 1 or v202
		local v204 = (v200 + v_u_13) * v_u_14 * v203 * v_u_42.Data.Variables.PlayerSpeed
		local v205 = math.max(1, v204)
		v199.WalkSpeed = v_u_86.WalkSpeedOverride or Lerp(v199.WalkSpeed, v205, p198 / 2)
		local v206 = v_u_86.States.Proning and -1.8 or 0
		local v207 = (v_u_86.States.Crouching or v_u_86.States.Sliding) and -1.5 or v206
		local v208 = v_u_86.States.IsDowned and -1.8 or v207
		v199.HipHeight = Lerp(v199.HipHeight, v208, p198 * 0.5)
		if v199 and (v_u_86.humanoid.HasLanded == true and (v199.SeatPart == nil and (v_u_86.hrp and (v199.MoveDirection ~= Vector3.new() and (v_u_86.PlayerMovementUtil.MoveVector.Magnitude > 0.1 and not (v_u_86.States.Sliding or (v_u_8 or v_u_86.PlayerMovementUtil.Diving))))))) then
			local v209 = v_u_86
			local v210 = v_u_86.PlayerVelocity * 0.92 + (v_u_86.hrp.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).magnitude * 0.075
			local v211 = math.max(v210, -20)
			v209.PlayerVelocity = math.min(20, v211)
			return
		end
		v_u_86.PlayerVelocity = Lerp(v_u_86.PlayerVelocity, 0, p198)
	end
end
function StatesHandler() -- name: StatesHandler
	-- upvalues: (copy) v_u_86, (copy) v_u_53, (ref) v_u_163, (ref) v_u_61, (ref) v_u_10, (ref) v_u_45, (copy) v_u_54, (ref) v_u_24
	local v212 = v_u_86.CurrentWeapon and v_u_86.CurrentWeapon.Aiming or false
	local v213 = v_u_86.SprintPressed
	local v214 = v_u_86.humanoid.Humanoid
	local v215 = v214.MoveDirection:Dot(v_u_53.CFrame.LookVector)
	local v216 = not v_u_86.hrp and 0 or v214.MoveDirection:Dot(v_u_86.hrp.CFrame.lookVector)
	local v217 = v_u_86.States.IsDowned or v_u_86.States.IsDead
	local v218 = v213 and (v_u_86.PlayerMovementUtil.Direction.Target.Magnitude > 0.1 and (v_u_86.hrp and (v_u_86.hrp.Parent and (v_u_86.hrp.AssemblyLinearVelocity.Magnitude > 5 and not (v_u_86.States.Sliding or (v212 or (v_u_86.PlayerMovementUtil.Diving or (v_u_86.States.Proning or (v_u_86.States.Crouching or v217))))))))) and true or false
	if v_u_86.PronePressed and (not v_u_86.States.Proning and (not v_u_86.States.Diving and (v_u_86.hrp and not v217))) then
		v_u_86.CrouchPressed = false
		v_u_86.States.Proning = true
		v_u_163()
		local v219 = true
		if v_u_86.hrp then
			local v220 = v_u_86.humanoid.Humanoid.MoveDirection
			if v220.Magnitude > 0.1 and v_u_61.CustomRayDirection(v_u_86.hrp.Position, v220.Unit * 3, true).Instance then
				v219 = false
			end
		end
		if v219 and (v218 or v_u_86.States.Sliding) and v_u_45 <= v_u_10 then
			DrainStamina(v_u_45)
			v_u_54.prone_dive_start:Play()
			v_u_86.humanoid:SetJumpPower(30)
			v_u_86.humanoid.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			v_u_86.States.Diving = true
			local v221 = v_u_86.hrp.AssemblyLinearVelocity
			local v222 = v221.Y
			local v223 = v221 - Vector3.new(0, v222, 0)
			if v_u_86.States.Sliding and v_u_86.humanoid.HasLanded then
				local v224 = v_u_86.PhysBall.chasis.AssemblyLinearVelocity
				local v225 = v224.Y
				v223 = v224 - Vector3.new(0, v225, 0)
			end
			v_u_86.humanoid.HasLanded = false
			v_u_86.hrp:ApplyImpulse(v223 * 25)
		elseif v219 then
			v_u_54.prone_in:Play()
		end
	end
	if v_u_86.States.Diving and (v_u_86.humanoid.HasLanded or (not v_u_86.hrp or (v_u_86.humanoid.Climbing or v217))) then
		if v_u_86.hrp then
			v_u_54.prone_dive_landing:Play()
		else
			v_u_86.humanoid.HasLanded = true
		end
		v_u_86.States.Diving = false
		v_u_86.humanoid:SetJumpPower(30)
	end
	if v_u_86.States.Diving then
		v_u_86.PronePressed = true
		v_u_86.CrouchPressed = false
	end
	if v218 and v_u_86.States.Proning then
		v218 = false
	end
	if v_u_86.States.Proning and not v_u_86.States.Diving then
		local v226 = v_u_86.humanoid.Animations.Prone
		v226:AdjustSpeed(v_u_86.PlayerVelocity * (v216 > 0.5 and 1 or -1) / v214.WalkSpeed)
		if not v226.IsPlaying then
			v226:Play(0.2, 1, 1)
		end
		if v_u_86.hrp and (v_u_86.hrp.AssemblyLinearVelocity.Magnitude > 3 and not v_u_54.prone_move.Playing) then
			v_u_54.prone_move:Play()
		elseif v_u_54.prone_move.Playing and v_u_86.hrp.AssemblyLinearVelocity.Magnitude < 3 then
			v226:AdjustSpeed(1e-7)
			v_u_54.prone_move:Stop()
		end
	elseif v_u_54.prone_move.Playing then
		v_u_54.prone_move:Stop()
	elseif v_u_86.humanoid.Animations.Prone.IsPlaying then
		v_u_86.humanoid.Animations.Prone:Stop(0.0001)
	end
	if v217 then
		v_u_86.CrouchPressed = false
	end
	if v_u_86.States.Proning and (not v_u_86.States.Diving and v_u_86.CrouchPressed) or (not v_u_86.PronePressed and v_u_86.States.Proning or v_u_86.States.Proning and v217) then
		if v_u_86.States.Proning then
			if StanceLocked() then
				v_u_86.PronePressed = true
				v_u_86.CrouchPressed = false
			else
				v_u_86.PronePressed = false
				v_u_86.States.Proning = false
				if v_u_86.hrp and v_u_24.Magnitude > 0.1 then
					v_u_86.hrp.CFrame = v_u_86.hrp.CFrame + v_u_24
				end
			end
		end
		if not (v_u_86.States.Proning or (v_u_86.States.Sliding or v_u_86.CrouchPressed)) then
			v_u_54.prone_out:Play()
		end
	end
	if v_u_86.States.Crouching and (not v_u_86.CrouchPressed and (not v_u_86.States.Proning and StanceLocked(3))) then
		v_u_86.CrouchPressed = true
	end
	if v_u_86.States.Crouching or not v_u_86.CrouchPressed then
		if v_u_86.States.Crouching and not v_u_86.CrouchPressed then
			v_u_54.crouch_out:Play()
		end
	else
		v_u_54.crouch_in:Play()
	end
	if v_u_86.States.Crouching and not (v_u_86.States.Diving or v217) then
		local v227 = v_u_86.humanoid.Animations.Crouch
		v227:AdjustSpeed(v_u_86.PlayerVelocity * (v216 > 0.5 and 1 or -1) / v214.WalkSpeed)
		if not v227.IsPlaying then
			v227:Play()
		end
	elseif v_u_86.humanoid.Animations.Crouch.IsPlaying then
		v_u_86.humanoid.Animations.Crouch:Stop()
	end
	if v_u_86.States.IsDowned then
		local v228 = v_u_86.humanoid.Animations.Downed
		v228:AdjustSpeed(-v_u_86.PlayerVelocity * (v216 > 0.5 and 1 or -1) / v214.WalkSpeed)
		if not v228.IsPlaying then
			v228:Play()
		end
	elseif v_u_86.humanoid.Animations.Downed.IsPlaying then
		v_u_86.humanoid.Animations.Downed:Stop()
	end
	if v_u_86.States.IsDead then
		if not v_u_86.humanoid.Animations.Death.IsPlaying then
			v_u_86.humanoid.Animations.Death.Priority = Enum.AnimationPriority.Action4
			v_u_86.humanoid.Animations.Death:Play()
		end
	elseif v_u_86.humanoid.Animations.Death.IsPlaying then
		v_u_86.humanoid.Animations.Death:Stop()
	end
	v_u_86.States.Sprinting = v218
	local v229 = not v_u_86.ThirdPerson
	if v229 then
		if v215 < -0.1 then
			v229 = not v_u_86.FocusEnabled
		else
			v229 = false
		end
	end
	local v230 = v_u_86.States
	if v218 then
		v218 = v_u_10 <= 0 and true or v229
	end
	v230.Jogging = v218
	v_u_86.States.Crouching = v_u_86.CrouchPressed
	v_u_86.States.Aiming = v212
	v_u_86.States.EquippedGun = v_u_86.CurrentWeapon and true or false
	v_u_86.States.Blocking = v_u_86.CurrentWeapon and v_u_86.CurrentWeapon.Blocking or false
	v_u_86.States.Charging = v_u_86.CurrentWeapon and v_u_86.CurrentWeapon.DoCharging or false
end
function updateThirdPerson(p231) -- name: updateThirdPerson
	-- upvalues: (copy) v_u_86
	local v232 = v_u_86.ThirdPerson
	v_u_86.ThirdPerson = p231
	if p231 ~= v232 then
		v_u_86.ThirdPersonChanged:Fire(p231)
	end
end
function StanceLocked(p233) -- name: StanceLocked
	-- upvalues: (copy) v_u_86, (ref) v_u_61
	if v_u_86.hrp then
		local v234 = v_u_86.hrp.CFrame
		local v235 = v234.Position
		local v236 = p233 or (v_u_86.CrouchPressed and 2 or 4)
		if v_u_61.CustomRayDirection(v235, v234.UpVector * v236, true).Instance then
			return true
		end
		local v237 = v234.Position + v234.LookVector * 1
		if v_u_61.CustomRayDirection(v237, v234.UpVector * v236, true).Instance then
			return true
		end
		local v238 = v234.Position + v234.LookVector * -1
		if v_u_61.CustomRayDirection(v238, v234.UpVector * v236, true).Instance then
			return true
		end
	end
end
local v239 = game.Players.LocalPlayer.Character
if v239 then
	local v_u_240 = v239:WaitForChild("Humanoid")
	v_u_240:GetPropertyChangedSignal("Jump"):Connect(function()
		-- upvalues: (copy) v_u_86, (copy) v_u_240
		if not v_u_86.MovementEnabled then
			v_u_240.Jump = false
		end
	end)
end
game.Players.LocalPlayer.CharacterAdded:Connect(function(p241)
	-- upvalues: (copy) v_u_86
	local v_u_242 = p241:WaitForChild("Humanoid")
	v_u_242:GetPropertyChangedSignal("Jump"):Connect(function()
		-- upvalues: (ref) v_u_86, (copy) v_u_242
		if not v_u_86.MovementEnabled then
			v_u_242.Jump = false
		end
	end)
end)
return v_u_86