local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require("@game/ReplicatedStorage/common/Janitor")
local v_u_3 = require(v1.common.RedEvents.NPC.StatusEvent)
local v_u_4 = require("@game/ReplicatedStorage/common/NPCRegistry")
local v_u_5 = game:GetService("RunService"):IsServer()
local v_u_6 = {}
v_u_6.__index = v_u_6
v_u_6.TickRate = 1
function v_u_6.UpdateIcon(p7) -- name: UpdateIcon
	-- upvalues: (copy) v_u_5, (copy) v_u_3
	if v_u_5 then
		v_u_3:FireAllClients({
			["UID"] = nil,
			["status"] = nil,
			["Type"] = "UpdateIcon",
			["packetTime"] = nil,
			["args"] = nil,
			["UID"] = p7.getNPC().UID,
			["status"] = p7._Name,
			["packetTime"] = workspace:GetServerTimeNow(),
			["args"] = { p7.Potency, p7.Count }
		})
	elseif p7.Label then
		local v8 = p7.Label
		local v9 = v8.Count
		local v10 = v8.Potency
		v9.Text = p7.Count
		v10.Text = p7.Potency
	end
end
function v_u_6.extend(_, _) -- name: extend end
if not v_u_5 then
	v_u_3:SetClientListener(function(p11)
		-- upvalues: (copy) v_u_4
		if p11.Type == "UpdateIcon" then
			local v12 = p11.packetTime
			local v13 = p11.args
			local v14, v15 = table.unpack(v13)
			local v16 = v_u_4:GetNPC(p11.UID)
			local v17 = v16.CurrentEffects and v16.CurrentEffects[p11.status]
			if v17 then
				if v17._lastUpdate and v17._lastUpdate >= v12 then
					if v12 < v17._lastUpdate then
						return
					end
				else
					v17._lastUpdate = v12
				end
				v17.Count = v15
				v17.Potency = v14
				v17:UpdateIcon(v14, v15)
			end
		end
	end)
end
return function(_, p_u_18)
	-- upvalues: (copy) v_u_6, (copy) v_u_2
	local v19 = v_u_6
	local v_u_20 = setmetatable({}, v19)
	v_u_20.Count = 1
	v_u_20.Potency = 1
	v_u_20._Janitor = v_u_2.new()
	function v_u_20.getNPC() -- name: getNPC
		-- upvalues: (copy) p_u_18
		return p_u_18
	end
	function v_u_20.contains(p21) -- name: contains
		-- upvalues: (copy) p_u_18
		local v22 = p_u_18.CurrentEffects
		if v22 then
			return v22[p21]
		else
			return nil
		end
	end
	function v_u_20.canTick(p23) -- name: canTick
		-- upvalues: (copy) v_u_20
		local v24 = os.clock() > v_u_20._lastTick
		if not p23 and v24 then
			v_u_20._lastTick = os.clock() + (v_u_20.TickRate or 1)
		end
		return v24
	end
	function v_u_20.AddConnection(p25) -- name: AddConnection
		-- upvalues: (copy) v_u_20
		v_u_20._Janitor:Add(p25)
	end
	function v_u_20.Destroy() -- name: Destroy
		-- upvalues: (copy) v_u_20
		if not v_u_20._Destroyed then
			v_u_20._Destroyed = true
			v_u_20._Janitor:Destroy()
			if v_u_20.clearFunc then
				v_u_20.clearFunc()
			end
		end
	end
	v_u_20._lastTick = os.clock() + v_u_20.TickRate
	v_u_20.ShowPotency = true
	v_u_20.ShowCount = true
	return v_u_20
end