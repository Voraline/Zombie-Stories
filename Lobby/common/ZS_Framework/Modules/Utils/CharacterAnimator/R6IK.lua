local function v_u_8(p1, p2, p3) -- name: UpdateC0IfChanged
	local v4 = p1.C0
	local v5 = p3 and 0.0001 or 0.005
	if (p3 and 0.0001 or 0.005) < (p2.Position - v4.Position).Magnitude then
		p1.C0 = p2
		return true
	end
	local v6 = 1 - v4.LookVector:Dot(p2.LookVector)
	local v7 = 1 - v4.UpVector:Dot(p2.UpVector)
	if v5 >= v6 and v5 >= v7 then
		return false
	end
	p1.C0 = p2
	return true
end
local function v_u_27(p9, p10, p11, p12, p13, p14) -- name: SolveArmIK
	local v15 = nil
	if p14 == "Left" then
		v15 = p9 * CFrame.new(0, 0, p13.X)
	elseif p14 == "Right" then
		v15 = p9 * CFrame.new(0, 0, -p13.X)
	end
	local v16 = v15:pointToObjectSpace(p10)
	local v17 = v16.unit
	local v18 = v16.magnitude
	local v19 = (Vector3.new(0, 0, -1)):Cross(v17)
	local v20 = -v17.Z
	local v21 = math.acos(v20)
	local v22 = v15 * CFrame.fromAxisAngle(v19, v21)
	if v18 < math.max(p12, p11) - math.min(p12, p11) then
		return v22 * CFrame.new(0, 0, math.max(p12, p11) - math.min(p12, p11) - v18), -1.5707963267948966, 3.141592653589793
	end
	if p11 + p12 < v18 then
		return v22, 1.5707963267948966, 0, v18
	end
	local v23 = (-(p12 * p12) + p11 * p11 + v18 * v18) / (2 * p11 * v18)
	local v24 = -math.acos(v23)
	local v25 = (p12 * p12 - p11 * p11 + v18 * v18) / (2 * p12 * v18)
	local v26 = math.acos(v25)
	return v22, v24 + 1.5707963267948966, v26 - v24
end
local function v_u_45(p28, p29, p30, p31, p32) -- name: SolveLegIK
	local v33 = p28 * CFrame.new(-p32.X, 0, 0)
	local v34 = v33:pointToObjectSpace(p29)
	local v35 = v34.unit
	local v36 = v34.magnitude
	local v37 = (Vector3.new(0, 0, -1)):Cross(-v35)
	local v38 = -v35.Z
	local v39 = math.acos(v38)
	local v40 = v33 * CFrame.fromAxisAngle(v37, v39):Inverse()
	if v36 < math.max(p31, p30) - math.min(p31, p30) then
		return v40 * CFrame.new(0, 0, math.max(p31, p30) - math.min(p31, p30) - v36), -1.5707963267948966, 3.141592653589793
	end
	if p30 + p31 < v36 then
		return v40, 1.5707963267948966, 0, v36
	end
	local v41 = (-(p31 * p31) + p30 * p30 + v36 * v36) / (2 * p30 * v36)
	local v42 = -math.acos(v41)
	local v43 = (p31 * p31 - p30 * p30 + v36 * v36) / (2 * p31 * v36)
	local v44 = math.acos(v43)
	return v40, 1.5707963267948966 - v42, -(v44 - v42)
end
local v_u_46 = {}
v_u_46.__index = v_u_46
function v_u_46.New(p47, p48) -- name: New
	-- upvalues: (copy) v_u_46
	local v49 = v_u_46
	local v50 = setmetatable({}, v49)
	v50.isLocalPlayer = p48 or false
	v50.Torso = p47:WaitForChild("Torso")
	v50.Head = p47:WaitForChild("Head")
	v50.HumanoidRootPart = p47:WaitForChild("HumanoidRootPart")
	v50.LeftArm = p47:WaitForChild("Left Arm")
	v50.RightArm = p47:WaitForChild("Right Arm")
	v50.LeftLeg = p47:WaitForChild("Left Leg")
	v50.RightLeg = p47:WaitForChild("Right Leg")
	v50.Motor6Ds = {
		["Left Shoulder"] = v50.Torso:WaitForChild("Left Shoulder"),
		["Right Shoulder"] = v50.Torso:WaitForChild("Right Shoulder"),
		["Left Hip"] = v50.Torso:WaitForChild("Left Hip"),
		["Right Hip"] = v50.Torso:WaitForChild("Right Hip"),
		["Neck"] = v50.Torso:WaitForChild("Neck"),
		["RootJoint"] = v50.HumanoidRootPart:WaitForChild("RootJoint")
	}
	v50.C0s = {
		["Left Shoulder"] = v50.Motor6Ds["Left Shoulder"].C0,
		["Right Shoulder"] = v50.Motor6Ds["Right Shoulder"].C0,
		["Left Hip"] = v50.Motor6Ds["Left Hip"].C0,
		["Right Hip"] = v50.Motor6Ds["Right Hip"].C0,
		["Neck"] = v50.Motor6Ds.Neck.C0,
		["RootJoint"] = v50.Motor6Ds.RootJoint.C0
	}
	v50.C1s = {
		["Left Shoulder"] = v50.Motor6Ds["Left Shoulder"].C1,
		["Right Shoulder"] = v50.Motor6Ds["Right Shoulder"].C1,
		["Left Hip"] = v50.Motor6Ds["Left Hip"].C1,
		["Right Hip"] = v50.Motor6Ds["Right Hip"].C1,
		["RootJoint"] = v50.Motor6Ds.RootJoint.C1
	}
	v50.Part0s = {
		["Left Shoulder"] = v50.Motor6Ds["Left Shoulder"].Part0,
		["Right Shoulder"] = v50.Motor6Ds["Right Shoulder"].Part0,
		["Left Hip"] = v50.Motor6Ds["Left Hip"].Part0,
		["Right Hip"] = v50.Motor6Ds["Right Hip"].Part0,
		["RootJoint"] = v50.Motor6Ds.RootJoint.Part0
	}
	v50.Part1s = {
		["Left Shoulder"] = v50.Motor6Ds["Left Shoulder"].Part1,
		["Right Shoulder"] = v50.Motor6Ds["Right Shoulder"].Part1,
		["Left Hip"] = v50.Motor6Ds["Left Hip"].Part1,
		["Right Hip"] = v50.Motor6Ds["Right Hip"].Part1,
		["RootJoint"] = v50.Motor6Ds.RootJoint.Part1
	}
	v50.LeftUpperArmLength = 1
	v50.LeftLowerArmLength = 1
	v50.RightUpperArmLength = 1
	v50.RightLowerArmLength = 1
	v50.LeftUpperLegLength = 1
	v50.LeftLowerLegLength = 1
	v50.RightUpperLegLength = 1
	v50.RightLowerLegLength = 1
	return v50
end
function v_u_46.ArmIK(p51, p52, p53) -- name: ArmIK
	-- upvalues: (copy) v_u_27
	if p52 == "Left" then
		local v54 = p51.Torso.CFrame * p51.C0s["Left Shoulder"]
		local v55 = p51.C1s["Left Shoulder"]
		local v56, v57, v58, _ = v_u_27(v54, p53, p51.LeftUpperArmLength, p51.LeftLowerArmLength, v55, p52)
		local v59 = CFrame.Angles(v57, 0, 0)
		local v60 = CFrame.Angles(v58, 0, 0)
		local v61 = v56 * v59 * CFrame.new(0, -p51.LeftUpperArmLength * 0.5, 0) * CFrame.new(0, -p51.LeftUpperArmLength * 0.5, 0) * v60 * CFrame.new(0, -p51.LeftLowerArmLength * 0.5, 0) * CFrame.new(0, (p51.LeftArm.Size.Y - p51.LeftLowerArmLength) * 0.5, 0)
		local v62 = p51.Motor6Ds["Left Shoulder"]
		local v63 = p51.Motor6Ds["Left Shoulder"]
		local v64 = v63.Part0.CFrame
		local v65 = v63.C1
		v62.C0 = v64:inverse() * v61 * v65
	elseif p52 == "Right" then
		local v66 = p51.Torso.CFrame * p51.C0s["Right Shoulder"]
		local v67 = p51.C1s["Right Shoulder"]
		local v68, v69, v70, _ = v_u_27(v66, p53, p51.RightUpperArmLength, p51.RightLowerArmLength, v67, p52)
		local v71 = CFrame.Angles(v69, 0, 0)
		local v72 = CFrame.Angles(v70, 0, 0)
		local v73 = v68 * v71 * CFrame.new(0, -p51.RightUpperArmLength * 0.5, 0) * CFrame.new(0, -p51.RightUpperArmLength * 0.5, 0) * v72 * CFrame.new(0, -p51.RightLowerArmLength * 0.5, 0) * CFrame.new(0, (p51.RightArm.Size.Y - p51.RightLowerArmLength) * 0.5, 0)
		local v74 = p51.Motor6Ds["Right Shoulder"]
		local v75 = p51.Motor6Ds["Right Shoulder"]
		local v76 = v75.Part0.CFrame
		local v77 = v75.C1
		v74.C0 = v76:inverse() * v73 * v77
	end
end
function v_u_46.LegIK(p78, p79, p80) -- name: LegIK
	-- upvalues: (copy) v_u_45, (copy) v_u_8
	if p79 == "Left" then
		local v81 = p78.Torso.CFrame * p78.C0s["Left Hip"]
		local v82 = p78.C1s["Left Hip"]
		local v83, v84, v85, _ = v_u_45(v81 * CFrame.Angles(0, 1.5707963267948966, 0), p80, p78.LeftUpperLegLength, p78.LeftLowerLegLength, v82)
		local v86 = CFrame.Angles(v84, 0, 0)
		local v87 = CFrame.Angles(v85, 0, 0)
		local v88 = v83 * v86 * CFrame.new(0, -p78.LeftUpperLegLength * 0.5, 0) * CFrame.new(0, -p78.LeftUpperLegLength * 0.5, 0) * v87 * CFrame.new(0, -p78.LeftLowerLegLength * 0.5, 0) * CFrame.new(0, (p78.LeftLeg.Size.Y - p78.LeftLowerLegLength) * 0.5, 0)
		local v89 = p78.Motor6Ds["Left Hip"]
		local v90 = v89.Part0.CFrame
		local v91 = v89.C1
		local v92 = v90:inverse() * v88 * v91
		v_u_8(p78.Motor6Ds["Left Hip"], v92, p78.isLocalPlayer)
	elseif p79 == "Right" then
		local v93 = p78.Torso.CFrame * p78.C0s["Right Hip"]
		local v94 = p78.C1s["Right Hip"]
		local v95, v96, v97, _ = v_u_45(v93 * CFrame.Angles(0, -1.5707963267948966, 0), p80, p78.RightUpperLegLength, p78.RightLowerLegLength, v94)
		local v98 = CFrame.Angles(v96, 0, 0)
		local v99 = CFrame.Angles(v97, 0, 0)
		local v100 = v95 * v98 * CFrame.new(0, -p78.RightUpperLegLength * 0.5, 0) * CFrame.new(0, -p78.RightUpperLegLength * 0.5, 0) * v99 * CFrame.new(0, -p78.RightLowerLegLength * 0.5, 0) * CFrame.new(0, (p78.RightLeg.Size.Y - p78.RightLowerLegLength) * 0.5, 0)
		local v101 = p78.Motor6Ds["Right Hip"]
		local v102 = v101.Part0.CFrame
		local v103 = v101.C1
		local v104 = v102:inverse() * v100 * v103
		v_u_8(p78.Motor6Ds["Right Hip"], v104, p78.isLocalPlayer)
	end
end
return v_u_46