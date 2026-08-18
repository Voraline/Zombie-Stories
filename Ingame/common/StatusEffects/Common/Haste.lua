local v_u_1 = game:GetService("RunService"):IsServer()
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("ReplicatedStorage").common
local v_u_4 = nil
local v_u_5 = nil
local v_u_6 = {}
v_u_6.__index = v_u_6
local function v_u_8(p7) -- name: UpdatePlayer
	-- upvalues: (copy) v_u_1, (ref) v_u_5, (copy) v_u_2
	if not v_u_1 and (p7._Player and (p7._Player.Parent and (p7._PlayerState and not p7._PlayerState.IsDead))) then
		if not v_u_5 then
			local _ = v_u_2.LocalPlayer
			v_u_5 = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.LocalPlayerController)
		end
		if p7.Count and p7.Count > 0 then
			p7.MeleeSpeedMult = p7.Count * 0.05
			p7.SpeedMult = p7.Count * 0.05
		else
			p7.MeleeSpeedMult = nil
			p7.SpeedMult = nil
		end
		v_u_5:UpdateCurrentWeapon()
	end
end
function v_u_6.new(p9) -- name: new
	-- upvalues: (ref) v_u_4, (copy) v_u_3, (copy) v_u_6, (copy) v_u_1, (ref) v_u_5
	if not v_u_4 then
		v_u_4 = require(v_u_3.PlayerHandler)
	end
	local v10 = v_u_6
	local v11 = setmetatable({}, v10)
	if not v_u_1 and p9.Player == game.Players.LocalPlayer then
		PersonalEffect = v11
		local _ = p9.Player
		v_u_5 = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.LocalPlayerController)
	end
	v11._TemporaryTimers = {}
	v11._PlayerState = v_u_4:WaitForPlayerState(p9.Player)
	v11._Player = p9.Player
	v11.Count = 1
	return v11
end
function v_u_6.Serialize(p12) -- name: Serialize
	return { p12.Duration }
end
function v_u_6.CopyStatus(_, _, _) -- name: CopyStatus end
function v_u_6.RemoveStack(p13, p14) -- name: RemoveStack
	-- upvalues: (copy) v_u_8
	if p14 then
		p13.Count = math.max(0, p14)
	else
		p13:Destroy()
	end
	print("Removed", p14, "Current Haste:", p13.Count)
	v_u_8(p13)
end
function v_u_6.Apply(p15, _, p16, p17) -- name: Apply
	-- upvalues: (copy) v_u_8
	p15.Inactive = false
	p15.Count = p15.Count + (p16 or 1)
	if p17 then
		local v18 = p15._TemporaryTimers
		table.insert(v18, { p17, p16 or -1 })
	end
	v_u_8(p15)
end
function v_u_6.Update(p19, p20) -- name: Update
	-- upvalues: (copy) v_u_1, (copy) v_u_8
	if not p19.Inactive then
		local v21 = nil
		for _, v22 in p19._TemporaryTimers do
			v22[1] = v22[1] - p20
			if v22[1] < 0 then
				p19:RemoveStack(v22[2])
				v21 = true
			end
		end
		if not v_u_1 and v21 then
			v_u_8(p19)
		end
	end
end
function v_u_6.Destroy(p23) -- name: Destroy
	-- upvalues: (copy) v_u_8
	p23.Count = 0
	v_u_8(p23)
	setmetatable(p23, nil)
	table.clear(p23)
	table.freeze(p23)
end
return v_u_6