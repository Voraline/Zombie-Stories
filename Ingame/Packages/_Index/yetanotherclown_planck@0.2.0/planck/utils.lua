local v_u_1 = {
	"Connect",
	"On",
	"on",
	"connect"
}
local v_u_2 = {
	"disconnect",
	"Disconnect",
	"destroy",
	"Destroy"
}
local function v_u_11(p3, p_u_4) -- name: getConnectFunction
	-- upvalues: (copy) v_u_1
	local v_u_5 = p3
	if typeof(p_u_4) == "RBXScriptSignal" or type(p_u_4) == "table" then
		v_u_5 = p_u_4
	elseif type(p_u_4) == "string" then
		v_u_5 = p3[p_u_4]
	end
	if type(v_u_5) == "function" then
		return v_u_5
	end
	if typeof(v_u_5) == "RBXScriptSignal" then
		return function(p6)
			-- upvalues: (ref) v_u_5
			return v_u_5:Connect(p6)
		end
	end
	if type(v_u_5) == "table" then
		if type(p_u_4) == "function" then
			return function(p7)
				-- upvalues: (copy) p_u_4, (ref) v_u_5
				return p_u_4(v_u_5, p7)
			end
		end
		for _, v_u_8 in v_u_1 do
			local v9 = v_u_5[v_u_8]
			if type(v9) == "function" then
				return function(p10)
					-- upvalues: (ref) v_u_5, (copy) v_u_8
					return v_u_5[v_u_8](v_u_5, p10)
				end
			end
		end
	end
	return nil
end
return {
	["getSystem"] = function(p12) -- name: getSystem
		if type(p12) == "function" then
			return p12
		elseif type(p12) == "table" and p12.system then
			return p12.system
		else
			return nil
		end
	end,
	["getSystemName"] = function(p13) -- name: getSystemName
		local v14 = debug.info(p13, "n")
		if not v14 or string.len(v14) == 0 then
			local v15, v16 = debug.info(p13, "sl")
			v14 = ("%*:%*"):format(v15, v16)
		end
		return v14
	end,
	["isPhase"] = function(p17) -- name: isPhase
		if type(p17) == "table" and p17._type == "phase" then
			return p17
		else
			return nil
		end
	end,
	["isPipeline"] = function(p18) -- name: isPipeline
		if type(p18) == "table" and p18._type == "pipeline" then
			return p18
		else
			return nil
		end
	end,
	["getEventIdentifier"] = function(p19, p20) -- name: getEventIdentifier
		return ("%*%*"):format(p19, p20 and ("@%*"):format(p20) or "")
	end,
	["isValidEvent"] = function(p21, p22) -- name: isValidEvent
		-- upvalues: (copy) v_u_11
		return v_u_11(p21, p22) ~= nil
	end,
	["getConnectFunction"] = v_u_11,
	["disconnectEvent"] = function(p23) -- name: disconnectEvent
		-- upvalues: (copy) v_u_2
		if type(p23) == "function" then
			p23()
			return
		elseif typeof(p23) == "RBXScriptConnection" then
			p23:Disconnect()
		elseif type(p23) == "table" then
			for _, v24 in v_u_2 do
				if p23[v24] then
					local v25 = p23[v24]
					if type(v25) == "function" then
						p23[v24](p23)
						return
					end
				end
			end
		end
	end
}