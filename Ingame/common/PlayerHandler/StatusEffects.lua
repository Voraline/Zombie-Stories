local v1 = game:GetService("Players")
local v2 = game.ReplicatedStorage.common
local v3 = game.ReplicatedStorage.common.RedEvents
require(v2.TableKit)
local v4 = require(v2.Signal)
local v_u_5 = {}
local v_u_6 = {}
local v_u_7 = game:GetService("ReplicatedStorage")
local v_u_8 = game:GetService("RunService"):IsServer()
local v_u_9 = require(v3.Framework.StatusEffectsEvent)
local v_u_10 = {
	["Downed"] = true
}
local v_u_39 = {
	["StateAdded"] = v4.new(),
	["__index"] = function(p11, p12) -- name: __index
		-- upvalues: (copy) v_u_39, (copy) v_u_10
		local v13 = rawget(p11, p12)
		if p11.EffectObjects[p12] == nil then
			if v13 == nil then
				if v_u_39[p12] then
					return v_u_39[p12]
				elseif v_u_10[p12] then
					return nil
				else
					return nil
				end
			else
				return v13
			end
		elseif p11.EffectObjects[p12].Inactive then
			return false
		else
			return p11.EffectObjects[p12]
		end
	end,
	["new"] = function(p14, _) -- name: new
		-- upvalues: (copy) v_u_39, (copy) v_u_5, (copy) v_u_10, (copy) v_u_7, (copy) v_u_6
		local v15 = {
			["Player"] = p14,
			["_Events"] = {},
			["EffectObjects"] = {}
		}
		local v16 = v_u_39
		setmetatable(v15, v16)
		v_u_5[p14] = v15
		for v17, _ in v_u_10 do
			local v18 = v_u_7.common.StatusEffects:FindFirstChild(v17, true)
			v_u_6[v17] = v18
			require(v18)
		end
		return v15
	end,
	["CopyEffects"] = function(p19, p20) -- name: CopyEffects
		for v21 in p19.EffectObjects do
			p19:RemoveStatus(v21)
		end
		for v22, v23 in p20.EffectObjects do
			local v24 = getStatusModule(v22)
			local v25 = require(v24).new(p19)
			p19.EffectObjects[v22] = v25
			v25:CopyStatus(v23, p19)
		end
	end,
	["Apply"] = function(p26, p27, ...) -- name: Apply
		-- upvalues: (copy) v_u_8, (copy) v_u_9
		if p26.EffectObjects[p27] then
			if p26.EffectObjects[p27].Apply then
				p26.EffectObjects[p27]:Apply(p26, ...)
			end
		else
			local v28 = getStatusModule(p27)
			p26.EffectObjects[p27] = require(v28).new(p26)
			p26.EffectObjects[p27]:Apply(p26, ...)
		end
		local v29 = p26._Events[p27]
		if v29 then
			v29:Fire(p26[p27])
		end
		if v_u_8 then
			v_u_9:FireAllClients({
				["Type"] = "StatusApplied",
				["Player"] = nil,
				["Status"] = nil,
				["Params"] = nil,
				["Player"] = p26.Player,
				["Status"] = p27,
				["Params"] = { ... }
			})
		end
	end,
	["RemoveStatus"] = function(p30, p31) -- name: RemoveStatus
		-- upvalues: (copy) v_u_8, (copy) v_u_9
		local v32 = p30.EffectObjects[p31]
		if v32 then
			v32:Destroy()
			p30.EffectObjects[p31] = nil
		end
		if v_u_8 then
			v_u_9:FireAllClients({
				["Type"] = "StatusRemoved",
				["Player"] = nil,
				["Status"] = nil,
				["Player"] = p30.Player,
				["Status"] = p31
			})
		end
	end,
	["Update"] = function(p33, p34) -- name: Update
		for _, v35 in p33.EffectObjects do
			if not v35.Inactive and v35.Update then
				v35:Update(p34)
			end
		end
	end,
	["Destroy"] = function(p36) -- name: Destroy
		-- upvalues: (copy) v_u_5
		v_u_5[p36.Player] = nil
		rawset(p36, "_Destroyed", true)
		for _, v37 in p36.EffectObjects do
			v37:Destroy()
		end
		for _, v38 in p36._Events do
			v38:DisconnectAll()
		end
	end
}
function getStatusModule(p40) -- name: getStatusModule
	-- upvalues: (copy) v_u_6, (copy) v_u_7
	local v41 = v_u_6[p40] or v_u_7.common.StatusEffects:FindFirstChild(p40, true)
	assert(v41, ("Status Module %s does not exist"):format(p40))
	if not v_u_6[p40] then
		v_u_6[p40] = v41
	end
	return v41
end
if v_u_8 then
	return v_u_39
end
local v_u_42 = {}
local v_u_43 = {}
local function v_u_49(p44, p45) -- name: handlePacket
	local v46 = p44.Type
	if v46 == "StatusApplied" then
		local v47 = p44.Status
		local v48 = p44.Params or {}
		p45:Apply(v47, unpack(v48))
	elseif v46 == "StatusRemoved" then
		p45:RemoveStatus(p44.Status)
	end
end
v_u_9:SetClientListener(function(p50) -- name: newPacket
	-- upvalues: (copy) v_u_5, (copy) v_u_43, (copy) v_u_49, (copy) v_u_42
	if p50 then
		local v51 = p50.Player
		local v52 = v_u_5[v51]
		if v52 and v_u_43[v51] then
			v_u_49(p50, v52)
		else
			v_u_42[v51] = v_u_42[v51] or {}
			local v53 = v_u_42[v51]
			table.insert(v53, p50)
		end
	else
		return
	end
end)
v_u_39.StateAdded:Connect(function(p54)
	-- upvalues: (copy) v_u_43, (copy) v_u_5, (copy) v_u_42, (copy) v_u_49
	v_u_43[p54.Player] = true
	local v55 = p54.Player
	local v56 = v_u_5[v55]
	if v56 then
		if v_u_43[v55] then
			local v57 = v_u_42[v55]
			if v57 then
				for _, v58 in v57 do
					v_u_49(v58, v56)
				end
				v_u_42[v55] = nil
			end
		end
	else
		return
	end
end)
v1.PlayerRemoving:Connect(function(p59)
	-- upvalues: (copy) v_u_42, (copy) v_u_43
	v_u_42[p59] = nil
	v_u_43[p59] = nil
end)
return v_u_39