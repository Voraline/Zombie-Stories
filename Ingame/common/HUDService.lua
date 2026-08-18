local v1 = game.ReplicatedStorage.common
local v2 = game.ReplicatedStorage.common.RedEvents
local v3 = require(v1.Signal)
local v_u_4 = {}
local v_u_5 = game:GetService("RunService"):IsServer()
local v_u_6 = require(v2.Framework.HUDServiceEvent)
local v_u_7 = {}
local v_u_40 = {
	["Elements"] = {},
	["ElementServices"] = {},
	["Visible"] = true,
	["VisibilityBlacklist"] = {
		["Fade"] = true
	},
	["VisibilityChanged"] = v3.new(),
	["AddElementService"] = function(_, p8, p9) -- name: AddElementService
		-- upvalues: (copy) v_u_5, (copy) v_u_40
		local v10 = v_u_5
		assert(v10, "AddElementService only available on Server")
		v_u_40.ElementServices[p8] = p9
	end,
	["GetElementService"] = function(_, p11) -- name: GetElementService
		-- upvalues: (copy) v_u_5, (copy) v_u_40
		local v12 = v_u_5
		assert(v12, "GetElementService only available on Server")
		return v_u_40.ElementServices[p11]
	end,
	["AddElement"] = function(_, p13, p14) -- name: AddElement
		-- upvalues: (copy) v_u_5, (copy) v_u_40, (copy) v_u_4
		local v15 = not v_u_5
		assert(v15, "AddElement only available on Client")
		v_u_40.Elements[p13] = p14
		runElementQueue(p13)
		if not v_u_40.Visible then
			v_u_4[p13] = p14.IsShowing
			p14:Hide()
		end
	end,
	["GetElement"] = function(_, p16) -- name: GetElement
		-- upvalues: (copy) v_u_5, (copy) v_u_40
		local v17 = not v_u_5
		assert(v17, "GetElement only available on Client")
		return v_u_40.Elements[p16]
	end,
	["RemoveElement"] = function(_, p18) -- name: RemoveElement
		-- upvalues: (copy) v_u_5, (copy) v_u_40
		local v19 = not v_u_5
		assert(v19, "RemoveElement only available on Client")
		v_u_40.Elements[p18] = nil
	end,
	["ShowElement"] = function(_, p20, p21, ...) -- name: ShowElement
		-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_40, (copy) v_u_4
		if v_u_5 then
			local v22 = {
				["Type"] = "ShowElement",
				["ElementName"] = nil,
				["Args"] = nil,
				["ElementName"] = p20,
				["Args"] = { ... }
			}
			if p21 then
				v_u_6:FireClient(p21, v22)
			else
				v_u_6:FireAllClients(v22)
			end
		else
			local v23 = v_u_40.Elements[p20]
			if v23 then
				if v_u_40.Visible or v_u_40.VisibilityBlacklist[p20] then
					v23:Show(unpack({ ... }))
					return
				end
				v_u_4[p20] = true
			end
			return
		end
	end,
	["HideElement"] = function(_, p24, p25, ...) -- name: HideElement
		-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_40, (copy) v_u_4
		if v_u_5 then
			local v26 = {
				["Type"] = "HideElement",
				["ElementName"] = nil,
				["Args"] = nil,
				["ElementName"] = p24,
				["Args"] = { ... }
			}
			if p25 then
				v_u_6:FireClient(p25, v26)
			else
				v_u_6:FireAllClients(v26)
			end
		else
			local v27 = v_u_40.Elements[p24]
			if v27 then
				if v_u_40.Visible or v_u_40.VisibilityBlacklist[p24] then
					v27:Hide(unpack({ ... }))
					return
				end
				v_u_4[p24] = false
			end
			return
		end
	end,
	["SetAllVisibility"] = function(_, p28, p29) -- name: SetAllVisibility
		-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_40, (copy) v_u_4
		if v_u_5 then
			local v30 = {
				["Type"] = "SetAllVisibility",
				["Visible"] = nil,
				["Visible"] = p28
			}
			if p29 then
				v_u_6:FireClient(p29, v30)
			else
				v_u_6:FireAllClients(v30)
				v_u_40.Visible = p28
				v_u_40.VisibilityChanged:Fire(p28)
			end
		else
			if v_u_40.Visible or not p28 then
				if v_u_40.Visible and not p28 then
					for v31, v32 in pairs(v_u_40.Elements) do
						if not v_u_40.VisibilityBlacklist[v31] then
							v_u_4[v31] = v32.IsShowing
							if v32.IsShowing then
								v32:Hide()
							end
						end
					end
				end
			else
				for v33, v34 in pairs(v_u_40.Elements) do
					if not v_u_40.VisibilityBlacklist[v33] then
						if v_u_4[v33] then
							v34:Show()
						else
							v34:Hide()
						end
					end
				end
			end
			v_u_40.Visible = p28
			v_u_40.VisibilityChanged:Fire(p28)
			return
		end
	end,
	["SendElementCommand"] = function(_, p35, p36, p37, ...) -- name: SendElementCommand
		-- upvalues: (copy) v_u_5, (copy) v_u_6
		local v38 = v_u_5
		assert(v38, "SendElementCommand can only be used on the server. Use GetElement instead.")
		local v39 = {
			["Type"] = "SendCommand",
			["ElementName"] = nil,
			["CommandName"] = nil,
			["Args"] = nil,
			["ElementName"] = p35,
			["CommandName"] = p36,
			["Args"] = { ... }
		}
		if p37 then
			v_u_6:FireClient(p37, v39)
		else
			v_u_6:FireAllClients(v39)
		end
	end
}
function runPacket(p41) -- name: runPacket
	-- upvalues: (copy) v_u_40
	local v42 = p41.ElementName
	if p41.Type == "ShowElement" then
		v_u_40:ShowElement(v42, p41.Args)
		return
	elseif p41.Type == "HideElement" then
		v_u_40:HideElement(v42, p41.Args)
		return
	elseif p41.Type == "SetAllVisibility" then
		v_u_40:SetAllVisibility(p41.Visible)
	elseif p41.Type == "SendCommand" then
		local v43 = v_u_40:GetElement(v42)
		if v43 ~= nil and v43[p41.CommandName] ~= nil then
			if p41.Args then
				local v44 = v43[p41.CommandName]
				local v45 = p41.Args
				v44(v43, unpack(v45))
				return
			end
			v43[p41.CommandName](v43)
		end
	end
end
function runElementQueue(p46) -- name: runElementQueue
	-- upvalues: (copy) v_u_7
	if v_u_7[p46] ~= nil then
		for _, v47 in v_u_7[p46] do
			runPacket(v47)
		end
	end
end
if v_u_5 then
	local v_u_48 = {}
	v_u_6:SetServerListener(function(p49)
		-- upvalues: (copy) v_u_48, (copy) v_u_40, (copy) v_u_6
		if not v_u_48[p49] then
			v_u_48[p49] = true
			if not v_u_40.Visible then
				v_u_6:FireClient(p49, {
					["Type"] = "SetAllVisibility",
					["Visible"] = false
				})
			end
		end
	end)
	return v_u_40
else
	v_u_6:SetClientListener(function(p50)
		-- upvalues: (copy) v_u_40, (copy) v_u_7
		local v51 = p50.ElementName
		if v51 == nil then
			runPacket(p50)
			return
		elseif v_u_40:GetElement(v51) == nil then
			if v_u_7[v51] == nil then
				v_u_7[v51] = {}
			end
			local v52 = v_u_7[v51]
			table.insert(v52, p50)
		else
			runPacket(p50)
		end
	end)
	v_u_6:FireServer()
	return v_u_40
end