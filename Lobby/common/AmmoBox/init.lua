local v1 = game.ReplicatedStorage.common
local v_u_2 = game:GetService("HttpService")
local v_u_3 = game:GetService("CollectionService")
local v4 = game.ReplicatedStorage.common.RedEvents
local v_u_5 = script.Sounds
local v_u_6 = require(v1.ProximityPromptZS)
local v_u_7 = require(v1.Signal)
local v_u_8 = {}
local v_u_9 = game:GetService("RunService"):IsServer()
local v_u_10 = require(v4.General.AmmoBox)
local v_u_11
if v_u_9 then
	v_u_11 = require("@game/ServerStorage/common/WepHandler")
else
	v_u_11 = nil
end
local v_u_12 = {}
local v_u_13 = {
	["UseLimit"] = true,
	["RefillTime"] = true,
	["InteractPart"] = true,
	["Uses"] = true
}
function v_u_12.ResetAll() -- name: ResetAll end
function v_u_12.__index(p14, p15) -- name: __index
	-- upvalues: (copy) v_u_13, (copy) v_u_12
	local v16 = rawget(p14, p15)
	if v_u_13[p15] then
		return rawget(p14, "Properties")[p15]
	elseif v16 == nil then
		return v_u_12[p15]
	else
		return v16
	end
end
function v_u_12.__newindex(p17, p18, p19) -- name: __newindex
	-- upvalues: (copy) v_u_13, (copy) v_u_12
	local v20 = rawget(p17, p18)
	if v_u_13[p18] then
		p17:_SetProperty(p18, p19)
		return p17
	elseif v20 == nil then
		v_u_12[p18] = p19
		return p17
	else
		p17[p18] = p19
		return p17
	end
end
function v_u_12.new(p_u_21, p_u_22) -- name: new
	-- upvalues: (copy) v_u_9, (copy) v_u_5, (copy) v_u_2, (copy) v_u_3, (copy) v_u_7, (copy) v_u_8, (copy) v_u_12, (copy) v_u_6, (copy) v_u_10
	if not v_u_9 then
		if not p_u_21.InteractPart then
			p_u_21.InteractPart = getUnreplicatedPart(p_u_22)
		end
		p_u_21.Uses = p_u_21.UseLimit
		local v_u_23 = {
			["_Identifier"] = nil,
			["Properties"] = nil,
			["_CoolingDown"] = false,
			["_Identifier"] = p_u_22,
			["Properties"] = p_u_21,
			["Used"] = v_u_7.new(),
			["CooldownStarted"] = v_u_7.new(),
			["CooldownFinished"] = v_u_7.new()
		}
		local v_u_24 = v_u_6.new({
			["ActionText"] = "REFILL",
			["ObjectText"] = "",
			["Part"] = nil,
			["Obstructable"] = false,
			["Range"] = 7,
			["Enabled"] = true,
			["Part"] = p_u_21.InteractPart
		})
		v_u_23._Prompt = v_u_24
		v_u_12._UpdateUseText(v_u_23)
		v_u_24.Triggered:Connect(function()
			-- upvalues: (copy) p_u_21, (ref) v_u_5, (ref) v_u_10, (ref) p_u_22, (copy) v_u_23, (ref) v_u_12, (copy) v_u_24
			if p_u_21.Replenishing then
				v_u_5.Error:Play()
				return
			else
				p_u_21.Replenishing = true
				v_u_10:FireServer({
					["Type"] = "RequestRefill",
					["Identifier"] = nil,
					["Identifier"] = p_u_22
				})
				v_u_23.Used:Fire(game.Players.LocalPlayer)
				local v25 = p_u_21
				v25.Uses = v25.Uses - 1
				v_u_12._UpdateUseText(v_u_23)
				if p_u_21.Uses > 0 then
					v_u_23.CooldownStarted:Fire()
					v_u_23._CoolingDown = true
					local v26 = p_u_21.RefillTime
					local v27 = math.floor(v26)
					v_u_24.ActionText = "COOLDOWN... " .. v27
					repeat
						task.wait(1)
						v27 = v27 - 1
						v_u_24.ActionText = "COOLDOWN... " .. v27
					until v27 <= 0 or not p_u_21.Replenishing
					v_u_24.ActionText = "REFILL"
					p_u_21.Replenishing = false
					v_u_23._CoolingDown = false
					v_u_23.CooldownFinished:Fire()
				else
					v_u_24.ActionText = "EMPTY"
				end
			end
		end)
		v_u_8[p_u_22] = v_u_23
		local v28 = v_u_12
		return setmetatable(v_u_23, v28)
	end
	local v29 = p_u_21:FindFirstChild("UseLimit")
	local v30 = p_u_21:FindFirstChild("RefillTime")
	local v31 = p_u_21:FindFirstChild("Interact")
	assert(v31, "Missing \"Interact\" Part")
	if not v31:FindFirstChild("Ammo") then
		v_u_5.Ammo:Clone().Parent = v31
	end
	local v32 = v_u_2:GenerateGUID(false)
	v_u_3:AddTag(v31, v32)
	local v33 = {
		["UseLimit"] = not v29 and 3 or v29.Value,
		["RefillTime"] = not v30 and 15 or v30.Value,
		["InteractPart"] = v31
	}
	local v34 = {
		["_Identifier"] = v32,
		["Properties"] = v33,
		["PlayerUses"] = {},
		["Used"] = v_u_7.new()
	}
	v_u_8[v32] = v34
	sendAddPacket(game.Players:GetPlayers(), v32, v33)
	local v35 = v_u_12
	return setmetatable(v34, v35)
end
function v_u_12.GiveAmmo(p36, p37) -- name: GiveAmmo
	-- upvalues: (ref) v_u_11
	local v38 = p36.PlayerUses[p37] or p36.UseLimit
	if v38 > 0 then
		local v39 = v38 - 1
		p36.PlayerUses[p37] = v39
		p36.InteractPart.Ammo:Play()
		v_u_11:RefillAmmo(p37)
		p36.Used:Fire(p37)
	end
end
function v_u_12.Reset(p40) -- name: Reset
	-- upvalues: (copy) v_u_9, (copy) v_u_8
	if v_u_9 then
		v_u_8[p40._Identifier].PlayerUses = {}
		v_u_8[p40._Identifier]._SetProperty(p40, "Uses", 3)
	end
end
function v_u_12._UpdateUseText(p41) -- name: _UpdateUseText
	p41._Prompt.ObjectText = ("AMMO %d/%d USES"):format(p41.Properties.Uses, p41.Properties.UseLimit)
end
function v_u_12._SetProperty(p42, p43, p44) -- name: _SetProperty
	-- upvalues: (copy) v_u_13, (copy) v_u_9, (copy) v_u_10
	if v_u_13[p43] then
		p42.Properties[p43] = p44
		if v_u_9 then
			v_u_10:FireAllClients({
				["Type"] = "PropertyChanged",
				["Identifier"] = nil,
				["Index"] = nil,
				["Value"] = nil,
				["Identifier"] = p42._Identifier,
				["Index"] = p43,
				["Value"] = p44
			})
			return
		end
		if p43 == "UseLimit" then
			p42:_UpdateUseText()
			return
		end
		if p43 == "Uses" then
			p42:_UpdateUseText()
			p42._Prompt.ActionText = "REFILL"
			p42.Properties.Replenishing = false
		end
	end
end
function init() -- name: init
	-- upvalues: (copy) v_u_9, (copy) v_u_8, (copy) v_u_12, (copy) v_u_10
	if v_u_9 then
		function v_u_12.ResetAll() -- name: ResetAll
			-- upvalues: (ref) v_u_8
			for _, v45 in v_u_8 do
				v45:Reset()
			end
		end
		v_u_10:SetServerListener(function(p46, p47)
			-- upvalues: (ref) v_u_8
			if p47 then
				local v48 = p47.Type == "RequestRefill" and v_u_8[p47.Identifier]
				if v48 then
					v48:GiveAmmo(p46)
					return
				end
			else
				for v49, v50 in v_u_8 do
					sendAddPacket({ p46 }, v49, v50)
				end
			end
		end)
	else
		v_u_10:SetClientListener(function(p51)
			-- upvalues: (ref) v_u_12, (ref) v_u_8
			if p51 then
				if p51.Type == "Add" then
					v_u_12.new({
						["UseLimit"] = p51.UseLimit,
						["RefillTime"] = p51.RefillTime,
						["InteractPart"] = p51.InteractPart
					}, p51.Identifier)
					return
				end
				local v52 = p51.Type == "PropertyChanged" and v_u_8[p51.Identifier]
				if v52 then
					v52:_SetProperty(p51.Index, p51.Value)
				end
			end
		end)
		v_u_10:FireServer()
	end
end
function sendAddPacket(p53, p54, p55) -- name: sendAddPacket
	-- upvalues: (copy) v_u_10
	v_u_10:FireClients(p53, {
		["Type"] = "Add",
		["Identifier"] = nil,
		["UseLimit"] = nil,
		["RefillTime"] = nil,
		["InteractPart"] = nil,
		["Identifier"] = p54,
		["UseLimit"] = p55.UseLimit,
		["RefillTime"] = p55.RefillTime,
		["InteractPart"] = p55.InteractPart
	})
end
function getUnreplicatedPart(p56) -- name: getUnreplicatedPart
	-- upvalues: (copy) v_u_3
	local v57 = v_u_3:GetTagged(p56)[1]
	while v57 == nil do
		v57 = v_u_3:GetInstanceAddedSignal(p56):Wait()
	end
	return v57
end
init()
return v_u_12