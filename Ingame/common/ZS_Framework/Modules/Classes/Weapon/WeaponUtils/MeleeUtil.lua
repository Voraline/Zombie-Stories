local v1 = game:GetService("ReplicatedStorage")
local _ = v1.common
local v2 = v1.common.RedEvents
local v_u_3 = require(v1.Packages.Fusion)
local v_u_4 = require(v1.common.skillTree.SkillTreeData)
local v_u_5 = require(v2.Framework.FrameworkEvents).MeleeSwing
function roundVector(p6, p7) -- name: roundVector
	local v8 = p6.X
	local v9 = string.format
	local v10 = "%." .. (p7 or 0) .. "f"
	local v11 = tonumber(v9(v10, v8))
	local v12 = p6.Y
	local v13 = string.format
	local v14 = "%." .. (p7 or 0) .. "f"
	local v15 = tonumber(v13(v14, v12))
	local v16 = p6.Z
	local v17 = string.format
	local v18 = "%." .. (p7 or 0) .. "f"
	return v11, v15, tonumber(v17(v18, v16))
end
return {
	["Shoot"] = function(p19) -- name: Shoot
		-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
		if p19.SwingCombo then
			p19.SwingCombo = p19.SwingCombo + 1
		else
			p19.SwingCombo = 1
		end
		if p19.PreviouslyPlayed then
			p19.Viewmodel:StopAnimation(p19.PreviouslyPlayed)
		end
		local v20 = p19.Config
		local v21 = v20.SwingAnimationTimeScale or 1
		local v22 = v_u_3.peek(v_u_4.MeleeSwingSpeedMult) or 1
		local v23 = v21 * v22
		if p19.DoCharging and (p19.PrimaryAttackStart and os.clock() >= p19.PrimaryAttackStart + (p19.Config.ChargeTime or 9999)) then
			local v24 = (v20.HeavySwingAnimationTimeScale or 1) * v22
			local v25 = p19.PreviouslyPlayed == "Swing1" and "HeavySwing2" or "HeavySwing"
			p19.PreviouslyPlayed = v25
			p19.Viewmodel:PlayAnimation(v25, 0, 1, v24)
			p19.DoingHeavy = true
		elseif p19.SwingCombo and p19.Viewmodel.Animations["Swing" .. p19.SwingCombo] then
			p19.Viewmodel:StopAnimation("HeavySwing")
			p19.Viewmodel:StopAnimation("HeavySwing2")
			p19.Viewmodel:StopAnimation("Swing1")
			p19.Viewmodel:StopAnimation("Swing2")
			p19.Viewmodel:PlayAnimation("Swing" .. p19.SwingCombo, 0.1, 1, v23)
			p19.PreviouslyPlayed = "Swing" .. p19.SwingCombo
		else
			p19.SwingCombo = 1
			p19.Viewmodel:PlayAnimation("Swing1", nil, nil, v23)
			p19.PreviouslyPlayed = "Swing1"
		end
		v_u_5:FireServer({ p19.Slot, p19.DoingHeavy, game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0) })
	end,
	["NewMelee"] = function(p26) -- name: NewMelee
		p26.Config.FireMode = { "Melee" }
		p26.Config.AmmoPerShot = 0
		p26.Config.Ammo = 0
	end
}