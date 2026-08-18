local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require(v1.common.ZS_Shared.Data.GameState)
local v_u_4, v_u_5 = require(v1.Packages.Bin)()
function lerp(p6, p7, p8) -- name: lerp
	return p6 + (p7 - p6) * p8
end
local function v61() -- name: toggleMotionSickness
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_4, (copy) v_u_2
	local v9 = v_u_3.Data.Variables.MotionSicknessEnabled
	v_u_5()
	if v9 then
		local v_u_10 = 0
		local v_u_11 = 0
		local v_u_12 = 0
		local v_u_13 = 1
		local v_u_14 = 0
		local v_u_15 = 0
		local v_u_16 = 0
		local v_u_17 = 1
		local v_u_18 = 0
		local v_u_19 = 0
		local v_u_20 = 0
		local v_u_21 = 1
		local v_u_22 = 0
		local v_u_23 = 0
		local v_u_24 = 0
		local v_u_25 = 1
		local v_u_26 = 0
		local v_u_27 = 0
		local v_u_28 = 0
		local v_u_29 = 1
		local v_u_30 = 0
		local v_u_31 = 0
		local v_u_32 = 0
		local v_u_33 = 1
		local v_u_34 = 0
		local v_u_35 = 0
		local v_u_36 = v_u_22
		local v_u_37 = v_u_23
		local v_u_38 = v_u_24
		local v_u_39 = v_u_25
		local v_u_40 = v_u_26
		local v_u_41 = v_u_27
		local v_u_42 = v_u_28
		local v_u_43 = v_u_29
		local v_u_44 = v_u_30
		local v_u_45 = v_u_31
		local v_u_46 = v_u_32
		local v_u_47 = v_u_33
		v_u_4(v_u_2.RenderStepped:Connect(function(p48)
			-- upvalues: (ref) v_u_35, (ref) v_u_34, (ref) v_u_36, (ref) v_u_37, (ref) v_u_38, (ref) v_u_22, (ref) v_u_23, (ref) v_u_24, (ref) v_u_39, (ref) v_u_40, (ref) v_u_41, (ref) v_u_25, (ref) v_u_26, (ref) v_u_27, (ref) v_u_42, (ref) v_u_43, (ref) v_u_44, (ref) v_u_28, (ref) v_u_29, (ref) v_u_30, (ref) v_u_45, (ref) v_u_46, (ref) v_u_47, (ref) v_u_31, (ref) v_u_32, (ref) v_u_33, (ref) v_u_10, (ref) v_u_11, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_19, (ref) v_u_20, (ref) v_u_21
			v_u_35 = v_u_35 + p48
			if v_u_34 <= v_u_35 then
				v_u_35 = 0
				local v49 = v_u_23
				local v50 = v_u_24
				v_u_36 = v_u_22
				v_u_37 = v49
				v_u_38 = v50
				local v51 = v_u_26
				local v52 = v_u_27
				v_u_39 = v_u_25
				v_u_40 = v51
				v_u_41 = v52
				local v53 = v_u_29
				local v54 = v_u_30
				v_u_42 = v_u_28
				v_u_43 = v53
				v_u_44 = v54
				local v55 = v_u_32
				local v56 = v_u_33
				v_u_45 = v_u_31
				v_u_46 = v55
				v_u_47 = v56
				v_u_10 = math.random(-25, 25) * 0.01
				v_u_11 = math.random(-25, 25) * 0.01
				v_u_12 = math.random(-25, 25) * 0.01
				v_u_13 = 1 + math.random(-25, 0) * 0.01
				v_u_14 = math.random(-50, 50) * 0.01
				v_u_15 = 0
				v_u_16 = math.random(-50, 50) * 0.01
				v_u_17 = 1 + math.random(-25, 0) * 0.01
				v_u_18 = 0
				v_u_19 = math.random(-50, 50) * 0.01
				v_u_20 = math.random(-50, 50) * 0.01
				v_u_21 = 1 + math.random(-25, 0) * 0.01
				v_u_34 = math.random(25, 5000) / 1000
			end
			local v57 = v_u_35 / v_u_34
			local v58 = math.clamp(v57, 0, 1)
			v_u_22 = lerp(v_u_36, v_u_10, v58)
			v_u_23 = lerp(v_u_37, v_u_11, v58)
			v_u_24 = lerp(v_u_38, v_u_12, v58)
			v_u_25 = lerp(v_u_39, v_u_13, v58)
			v_u_26 = lerp(v_u_40, v_u_14, v58)
			v_u_27 = lerp(v_u_41, v_u_15, v58)
			v_u_28 = lerp(v_u_42, v_u_16, v58)
			v_u_29 = lerp(v_u_43, v_u_17, v58)
			v_u_30 = lerp(v_u_44, v_u_18, v58)
			v_u_31 = lerp(v_u_45, v_u_19, v58)
			v_u_32 = lerp(v_u_46, v_u_20, v58)
			v_u_33 = lerp(v_u_47, v_u_21, v58)
			local v59 = CFrame.new(v_u_22, v_u_23, v_u_24, v_u_25, v_u_26, v_u_27, v_u_28, v_u_29, v_u_30, v_u_31, v_u_32, v_u_33)
			local v60 = workspace.CurrentCamera
			v60.CFrame = v60.CFrame * v59
		end))
	end
end
v61()
v_u_3.Signals.Variables.MotionSicknessEnabled:Connect(v61)
return {}