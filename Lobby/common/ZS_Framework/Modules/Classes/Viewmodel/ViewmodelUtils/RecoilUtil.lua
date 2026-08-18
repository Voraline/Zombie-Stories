local v1 = script.Parent.Parent.Parent.Parent.Utils
local v_u_2 = require(v1.SpringUtil)
local v_u_3 = require("./PointRotationUtil")
local v4 = script.Parent.Parent.Parent.Parent.Controllers
local v_u_5 = require(v4:WaitForChild("LocalPlayerController"))
local v_u_6 = CFrame.new(0.588401794, 0.546500206, -4.0329895)
local v_u_7 = {}
v_u_7.__index = v_u_7
local v_u_8 = {}
function v_u_7.new(p9) -- name: new
	-- upvalues: (copy) v_u_7, (copy) v_u_2, (copy) v_u_8
	local v10 = v_u_7
	local v11 = setmetatable({}, v10)
	v11.Weapon = p9
	v11.SpringPos = v_u_2.new((Vector3.new()))
	v11.SpringPos.Target = Vector3.new()
	v11.SpringPos.Speed = 15
	v11.SpringPos.Damper = 0.6
	v11.SpringRot = v_u_2.new((Vector3.new()))
	v11.SpringRot.Target = Vector3.new()
	v11.SpringRot.Speed = 7
	v11.SpringRot.Damper = 0.6
	v11.BackImpulse = CFrame.new()
	v_u_8[p9] = v11
	return v11
end
function v_u_7.getOrCreate(p12) -- name: getOrCreate
	-- upvalues: (copy) v_u_8, (copy) v_u_7
	if v_u_8[p12] then
		return v_u_8[p12]
	else
		return v_u_7.new(p12)
	end
end
function v_u_7.remove(p13) -- name: remove
	-- upvalues: (copy) v_u_8
	v_u_8[p13] = nil
end
function v_u_7.VMImpulse(p14, p15, p16, p17, p18, p19, p20, p21) -- name: VMImpulse
	local v22 = math.random() - 0.5
	local v23 = p14 + math.random() * 0.02 * p21
	local v24 = p15 + 0.075 * p20
	local v25 = p16 + 0.09 + math.random() * 0.01 * p21 * p20
	local v26 = p17 + 0.015 * p20
	local v27 = v22 * 0.1 * p21
	return v23, v24, v25, v26, p18 + math.rad(v27), p19 + 0.01 * v22 * (p21 * 0.5)
end
function v_u_7.Impulse(p28) -- name: Impulse
	-- upvalues: (copy) v_u_5, (copy) v_u_7
	local v29 = p28.Weapon.Config
	local v30 = p28.SpringPos.Position.X
	local v31 = p28.SpringPos.Position.Y
	local v32 = p28.SpringPos.Position.Z
	local v33 = p28.SpringRot.Position.X
	local v34 = p28.SpringRot.Position.Y
	local v35 = p28.SpringRot.Position.Z
	local v36 = v29.VerticalRecoil
	local v37 = v29.HorizontalRecoil
	local v38, v39, v40, v41, v42, v43
	if v29.VMImpulse then
		v38, v39, v40, v41, v42, v43 = v29.VMImpulse(p28.Weapon, v_u_5, v30, v31, v32, v33, v34, v35, v36, v37)
	elseif v36 and v37 then
		v38, v39, v40, v41, v42, v43 = v_u_7.VMImpulse(v30, v31, v32, v33, v34, v35, v36, v37)
	else
		v38 = v30 + math.random(0, 1000) * 0.00007
		v39 = v31 + math.random(0, 1000) * 0.00007 + 0.05
		v40 = v32 + 0.12
		v41 = v30 + 0.025
		local v44 = math.random(-500, 500) * 0.003
		v42 = v31 + math.rad(v44)
		v43 = 0.01
	end
	local v45
	if v_u_5.States.Crouching or v_u_5.States.Sliding then
		v45 = v29.CrouchRecoilMultiplier or 0.92
	elseif v_u_5.States.Proning then
		v45 = v29.ProneRecoilMultiplier or 0.85
	else
		v45 = v29.StandardRecoilMultiplier or 1
	end
	local v46 = v38 * v45
	local v47 = v39 * v45
	local v48 = v40 * v45
	local v49 = v41 * v45
	local v50 = v42 * v45
	local v51 = v43 * v45
	p28.SpringPos.Position = Vector3.new(v46, v47, v48)
	p28.SpringRot.Position = Vector3.new(v49, v50, v51)
end
function v_u_7.GetPitchRecoil(p52) -- name: GetPitchRecoil
	return p52.SpringRot.Position.X * 0.6
end
function v_u_7.Update(p53, p54, p55, p56) -- name: Update
	-- upvalues: (copy) v_u_3, (copy) v_u_6
	local v57 = p53.SpringPos.Position.X
	local v58 = p53.SpringPos.Position.Y
	local v59 = p53.SpringPos.Position.Z
	local v60 = p53.SpringRot.Position.X
	local v61 = p53.SpringRot.Position.Y
	local v62 = p53.SpringRot.Position.Z
	local v63 = p53.BackImpulse
	local v64 = CFrame.new(v57, v58 - v60 / 1.5, 0) * CFrame.Angles(v60 / 3, v61, v62)
	local v65 = p54 * 10
	p53.BackImpulse = v63:Lerp(v64, (math.min(1, v65)))
	local v66 = CFrame.new().LookVector:Dot(p53.BackImpulse.LookVector)
	local v67 = math.acos(v66)
	local v68
	if v67 <= 0.0001 then
		v68 = v67 >= -0.0001
	else
		v68 = false
	end
	if v68 then
		local v69 = p53.BackImpulse.Position.Magnitude
		local v70
		if v69 <= 0.0001 then
			v70 = v69 >= -0.0001
		else
			v70 = false
		end
		if v70 then
			p53.BackImpulse = CFrame.new()
		end
	end
	local v71 = p53.BackImpulse
	local v72 = CFrame.new
	local v73 = 0
	local v74 = 0
	local v75
	if v59 <= 0.0001 then
		v75 = v59 >= -0.0001
	else
		v75 = false
	end
	local v76 = (v71 * v72(v73, v74, v75 and 0 or v59)):Lerp(CFrame.new(), p55.Position)
	local v77 = v60 * 0.6
	local v78
	if v77 <= 0.0001 then
		v78 = v77 >= -0.0001
	else
		v78 = false
	end
	local v79 = v78 and 0 or v77
	local v80 = CFrame.new
	local v81 = 0
	local v82 = 0
	local v83
	if v59 <= 0.0001 then
		v83 = v59 >= -0.0001
	else
		v83 = false
	end
	local v84 = v80(v81, v82, v83 and 0 or v59 / (p53.Weapon.Aiming and 2 or 1))
	local v85 = CFrame.Angles(v79, 0, 0):Lerp(v76 * CFrame.Angles(v79, 0, 0), p56.Position)
	v_u_3.UpdateRotation("Recoil", v_u_6, v85:Lerp(v84 * CFrame.Angles(0, 0, v61), p55.Position))
	return v76:Lerp(CFrame.new(), p56.Position)
end
v_u_7.CurrentWeapon = nil
return setmetatable({}, {
	["__index"] = function(_, p86) -- name: __index
		-- upvalues: (copy) v_u_7, (copy) v_u_8
		if p86 == "CurrentWeapon" then
			return v_u_7.CurrentWeapon
		elseif p86 == "Impulse" then
			return function()
				-- upvalues: (ref) v_u_7, (ref) v_u_8
				local v87 = v_u_7.CurrentWeapon and v_u_8[v_u_7.CurrentWeapon]
				if v87 then
					v87:Impulse()
				end
			end
		elseif p86 == "VMImpulse" then
			return v_u_7.VMImpulse
		elseif p86 == "Update" then
			return function(_, p88, p89, p90)
				-- upvalues: (ref) v_u_7, (ref) v_u_8
				local v91 = v_u_7.CurrentWeapon and v_u_8[v_u_7.CurrentWeapon]
				if v91 then
					return v91:Update(p88, p89, p90)
				else
					return CFrame.new()
				end
			end
		elseif p86 == "GetPitchRecoil" then
			return function()
				-- upvalues: (ref) v_u_7, (ref) v_u_8
				local v92 = v_u_7.CurrentWeapon and v_u_8[v_u_7.CurrentWeapon]
				return not v92 and 0 or v92:GetPitchRecoil()
			end
		elseif p86 == "new" then
			return v_u_7.new
		elseif p86 == "getOrCreate" then
			return v_u_7.getOrCreate
		elseif p86 == "remove" then
			return v_u_7.remove
		else
			return v_u_7[p86]
		end
	end,
	["__newindex"] = function(p93, p94, p95) -- name: __newindex
		-- upvalues: (copy) v_u_7
		if p94 == "CurrentWeapon" then
			v_u_7.CurrentWeapon = p95
		else
			rawset(p93, p94, p95)
		end
	end
})