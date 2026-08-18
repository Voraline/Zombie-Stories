local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
local v_u_5 = {}
local v_u_6 = {}
local v_u_7 = v3:IsStudio()
local v_u_8 = v3:IsServer()
local v_u_9 = nil
local function v_u_19(...) -- name: GetParamString
	local v10 = table.pack(...)
	local v11 = v10.n
	local v12 = math.min(10, v11)
	for v13 = 1, v12 do
		local v_u_14 = v10[v13]
		local v15 = v10[v13]
		local v16 = typeof(v15)
		if v16 == "string" then
			v10[v13] = string.format("%q[%d]", #v_u_14 <= 18 and v_u_14 and v_u_14 or v_u_14:sub(1, 15) .. "...", #v_u_14)
		elseif v16 == "Instance" then
			local v17, v18 = pcall(function()
				-- upvalues: (copy) v_u_14
				return v_u_14.ClassName
			end)
			if v17 then
				v16 = string.format("%s<%s>", v16, v18) or v16
			end
			v10[v13] = v16
		else
			v10[v13] = v16
		end
	end
	return table.concat(v10, ", ", 1, v12) .. (v12 < v10.n and string.format(", ... (%d more)", v10.n - v12) or "")
end
local v_u_20 = {}
local v_u_21 = 0
local v_u_22, v_u_23
if v_u_8 then
	local v24 = Instance.new("Folder", v2)
	v24.Name = "Communication"
	v_u_22 = Instance.new("Folder", v24)
	v_u_22.Name = "Functions"
	v_u_23 = Instance.new("Folder", v24)
	v_u_23.Name = "Events"
else
	local v25 = v2:WaitForChild("Communication")
	v_u_22 = v25:WaitForChild("Functions")
	v_u_23 = v25:WaitForChild("Events")
end
local v_u_26 = Instance.new("BindableEvent")
function FastSpawn(p_u_27, ...) -- name: FastSpawn
	-- upvalues: (copy) v_u_26
	coroutine.wrap(function(...)
		-- upvalues: (ref) v_u_26, (copy) p_u_27
		v_u_26.Event:Wait()
		p_u_27(...)
	end)(...)
	v_u_26:Fire()
end
function YieldThread() -- name: YieldThread
	-- upvalues: (copy) v_u_26
	return (function(...)
		-- upvalues: (ref) v_u_26
		v_u_26.Event:Wait()
		return ...
	end)(coroutine.yield())
end
function ResumeThread(p28, ...) -- name: ResumeThread
	-- upvalues: (copy) v_u_26
	coroutine.resume(p28, ...)
	v_u_26:Fire()
end
function SafeInvokeCallback(p_u_29, ...) -- name: SafeInvokeCallback
	-- upvalues: (copy) v_u_8, (copy) v_u_4
	local v_u_30 = false
	local v_u_31 = nil
	local v_u_32 = nil
	local v_u_33 = nil
	local function v_u_34(...) -- name: finish
		-- upvalues: (ref) v_u_30, (ref) v_u_33, (ref) v_u_32
		if not v_u_30 then
			v_u_30 = true
			v_u_33 = table.pack(...)
			if v_u_32 then
				ResumeThread(v_u_32)
			end
		end
	end
	FastSpawn(function(...)
		-- upvalues: (ref) v_u_31, (copy) v_u_34, (copy) p_u_29
		v_u_31 = coroutine.running()
		v_u_34(true, p_u_29.Callback(...))
	end, ...)
	if not v_u_30 then
		local v_u_35 = v_u_8
		if v_u_35 then
			v_u_35 = ...
		end
		coroutine.wrap(function()
			-- upvalues: (ref) v_u_30, (ref) v_u_31, (ref) v_u_8, (copy) v_u_35, (ref) v_u_4, (copy) v_u_34
			while not v_u_30 and (coroutine.status(v_u_31) ~= "dead" and (not v_u_8 or v_u_35.Parent == v_u_4)) do
				wait(0.5)
			end
			v_u_34(false)
		end)()
	end
	if not v_u_30 then
		v_u_32 = coroutine.running()
		YieldThread()
	end
	local v36 = v_u_33
	return unpack(v36)
end
function SafeInvoke(p37, p_u_38, ...) -- name: SafeInvoke
	-- upvalues: (copy) v_u_8
	local v_u_39 = coroutine.running()
	local v_u_40 = false
	local v_u_41 = nil
	coroutine.wrap(function(...)
		-- upvalues: (ref) v_u_8, (ref) v_u_41, (copy) p_u_38, (ref) v_u_40, (copy) v_u_39
		if v_u_8 then
			v_u_41 = table.pack(pcall(function(...)
				-- upvalues: (ref) p_u_38
				return p_u_38.Remote:InvokeClient(...)
			end, ...))
		else
			v_u_41 = table.pack(pcall(function(...)
				-- upvalues: (ref) p_u_38
				return p_u_38.Remote:InvokeServer(...)
			end, ...))
		end
		if not v_u_40 then
			v_u_40 = true
			ResumeThread(v_u_39)
		end
	end)(...)
	if typeof(p37) == "number" then
		delay(p37, function()
			-- upvalues: (ref) v_u_40, (copy) v_u_39
			if not v_u_40 then
				v_u_40 = true
				ResumeThread(v_u_39)
			end
		end)
	end
	YieldThread()
	if not v_u_41 or (v_u_41[1] ~= true or v_u_41[2] ~= true) then
		return false
	end
	local v42 = v_u_41
	return true, unpack(v42, 3)
end
function SafeFireEvent(p43, ...) -- name: SafeFireEvent
	local v_u_44 = p43.Callbacks
	local v_u_45 = #v_u_44
	while v_u_45 > 0 do
		local v_u_46 = true
		FastSpawn(function(...)
			-- upvalues: (ref) v_u_46, (ref) v_u_45, (copy) v_u_44
			while v_u_46 and v_u_45 > 0 do
				local v47 = v_u_44[v_u_45]
				v_u_45 = v_u_45 - 1
				v47(...)
			end
		end, ...)
		v_u_46 = false
	end
end
function WaitForChild(p48, p_u_49) -- name: WaitForChild
	local v_u_50 = p48:FindFirstChild(p_u_49)
	if not v_u_50 then
		local v_u_51 = coroutine.running()
		local v_u_52 = nil
		v_u_52 = p48.ChildAdded:Connect(function(p53)
			-- upvalues: (copy) p_u_49, (ref) v_u_52, (ref) v_u_50, (copy) v_u_51
			if p53.Name == p_u_49 then
				v_u_52:Disconnect()
				v_u_50 = p53
				ResumeThread(v_u_51)
			end
		end)
		YieldThread()
	end
	return v_u_50
end
function GetEventHandler(p54) -- name: GetEventHandler
	-- upvalues: (copy) v_u_5, (ref) v_u_23, (copy) v_u_8, (ref) v_u_21, (copy) v_u_7
	local v55 = v_u_5[p54]
	if v55 then
		return v55
	end
	local v_u_56 = {
		["Name"] = nil,
		["Folder"] = nil,
		["Callbacks"] = nil,
		["IncomingQueueErrored"] = nil,
		["Name"] = p54,
		["Folder"] = v_u_23,
		["Callbacks"] = {}
	}
	v_u_5[p54] = v_u_56
	if not v_u_8 then
		FastSpawn(function()
			-- upvalues: (copy) v_u_56, (ref) v_u_21, (ref) v_u_7
			v_u_56.Queue = {}
			local v_u_57 = WaitForChild(v_u_56.Folder, v_u_56.Name)
			v_u_56.Remote = v_u_57
			if #v_u_56.Callbacks == 0 then
				v_u_56.IncomingQueue = {}
			end
			v_u_57.OnClientEvent:Connect(function(...)
				-- upvalues: (ref) v_u_56, (copy) v_u_57, (ref) v_u_21
				if v_u_56.IncomingQueue then
					if #v_u_56.IncomingQueue >= 2048 then
						if not v_u_56.IncomingQueueErrored then
							v_u_56.IncomingQueueErrored = true
							FastSpawn(error, string.format("Exhausted remote invocation queue for %s", v_u_57:GetFullName()), -1)
							delay(1, function()
								-- upvalues: (ref) v_u_56
								v_u_56.IncomingQueueErrored = nil
							end)
						end
						if #v_u_56.IncomingQueue >= 8172 then
							table.remove(v_u_56.IncomingQueue, 1)
						end
					end
					v_u_21 = v_u_21 + 1
					local v58 = v_u_56.IncomingQueue
					local v59 = table.pack
					local v60 = v_u_21
					local v61 = v_u_56
					table.insert(v58, v59(v60, v61, ...))
				else
					SafeFireEvent(v_u_56, ...)
				end
			end)
			if not v_u_7 then
				v_u_57.Name = ""
			end
			for _, v62 in pairs(v_u_56.Queue) do
				v62()
			end
			v_u_56.Queue = nil
		end)
		return v_u_56
	end
	local v63 = Instance.new("RemoteEvent")
	v63.Name = v_u_56.Name
	v63.Parent = v_u_56.Folder
	v_u_56.Remote = v63
	return v_u_56
end
function GetFunctionHandler(p64) -- name: GetFunctionHandler
	-- upvalues: (copy) v_u_6, (ref) v_u_22, (copy) v_u_8, (ref) v_u_21, (copy) v_u_7
	local v65 = v_u_6[p64]
	if v65 then
		return v65
	end
	local v_u_66 = {
		["Name"] = nil,
		["Folder"] = nil,
		["Callback"] = nil,
		["IncomingQueueErrored"] = nil,
		["Name"] = p64,
		["Folder"] = v_u_22
	}
	v_u_6[p64] = v_u_66
	if not v_u_8 then
		FastSpawn(function()
			-- upvalues: (copy) v_u_66, (ref) v_u_21, (ref) v_u_7
			v_u_66.Queue = {}
			local v_u_67 = WaitForChild(v_u_66.Folder, v_u_66.Name)
			v_u_66.Remote = v_u_67
			v_u_66.IncomingQueue = {}
			function v_u_66.OnClientInvoke(...)
				-- upvalues: (ref) v_u_66, (copy) v_u_67, (ref) v_u_21
				if not v_u_66.Callback then
					if #v_u_66.IncomingQueue >= 2048 then
						if not v_u_66.IncomingQueueErrored then
							v_u_66.IncomingQueueErrored = true
							FastSpawn(error, string.format("Exhausted remote invocation queue for %s", v_u_67:GetFullName()), -1)
							delay(1, function()
								-- upvalues: (ref) v_u_66
								v_u_66.IncomingQueueErrored = nil
							end)
						end
						if #v_u_66.IncomingQueue >= 8172 then
							table.remove(v_u_66.IncomingQueue, 1)
						end
					end
					v_u_21 = v_u_21 + 1
					local v68 = table.pack(v_u_21, v_u_66, coroutine.running())
					local v69 = v_u_66.IncomingQueue
					table.insert(v69, v68)
					YieldThread()
				end
				return SafeInvokeCallback(v_u_66, ...)
			end
			if not v_u_7 then
				v_u_67.Name = ""
			end
			for _, v70 in pairs(v_u_66.Queue) do
				v70()
			end
			v_u_66.Queue = nil
		end)
		return v_u_66
	end
	local v71 = Instance.new("RemoteFunction")
	v71.Name = v_u_66.Name
	v71.Parent = v_u_66.Folder
	v_u_66.Remote = v71
	return v_u_66
end
function AddToQueue(p_u_72, p73, p74) -- name: AddToQueue
	if p_u_72.Remote then
		return p73()
	end
	p_u_72.Queue[#p_u_72.Queue + 1] = p73
	if p74 then
		delay(5, function()
			-- upvalues: (copy) p_u_72
			if not p_u_72.Remote then
				warn(debug.traceback(("Infinite yield possible on \'%s:WaitForChild(\"%s\")\'"):format(p_u_72.Folder:GetFullName(), p_u_72.Name)))
			end
		end)
	end
end
function ExecuteDeferredHandlers() -- name: ExecuteDeferredHandlers
	-- upvalues: (ref) v_u_20
	local v75 = v_u_20
	local v76 = {}
	v_u_20 = {}
	for v77 in pairs(v75) do
		local v78 = v77.IncomingQueue
		v77.IncomingQueue = nil
		table.move(v78, 1, #v78, #v76 + 1, v76)
	end
	table.sort(v76, function(p79, p80)
		return p79[1] < p80[1]
	end)
	for _, v81 in ipairs(v76) do
		local v82 = v81[2]
		if v82.Callbacks then
			SafeFireEvent(v82, unpack(v81, 3))
		else
			ResumeThread(v81[3])
		end
	end
end
local v_u_100 = {
	["MatchParams"] = function(p_u_83, p84) -- name: MatchParams
		-- upvalues: (copy) v_u_8, (copy) v_u_7
		local v_u_85 = { unpack(p84) }
		local v_u_86 = 1
		for v87, v89 in pairs(v_u_85) do
			if type(v89) == "string" then
				local v89 = string.split(v89, "|") or v89
			end
			local v90 = ""
			local v91 = {}
			for _, v92 in pairs(v89) do
				local v93 = v92:gsub("^%s+", ""):gsub("%s+$", "")
				v90 = v90 .. (#v90 > 0 and " or " or "") .. v93
				v91[v93:lower()] = true
			end
			v91._string = v90
			v_u_85[v87] = v91
		end
		if v_u_8 then
			table.insert(v_u_85, 1, false)
			v_u_86 = 2
		end
		return function(p94, ...) -- name: MatchParams
			-- upvalues: (ref) v_u_85, (ref) v_u_7, (copy) p_u_83, (ref) v_u_86
			local v95 = table.pack(...)
			if v95.n <= #v_u_85 then
				for v96 = v_u_86, #v_u_85 do
					local v97 = v95[v96]
					local v98 = typeof(v97)
					local v99 = v_u_85[v96]
					if not (v99[v98:lower()] or v99.any) then
						if v_u_7 then
							warn(("[Network] Invalid parameter %d to %s (%s expected, got %s)"):format(v96 - v_u_86 + 1, p_u_83, v99._string, v98))
						end
						return
					end
				end
				return p94(...)
			end
			if v_u_7 then
				warn(("[Network] Invalid number of parameters to %s (%s expected, got %s)"):format(p_u_83, #v_u_85 - v_u_86 + 1, v95.n - v_u_86 + 1))
			end
		end
	end
}
function combineFn(p_u_101, p_u_102, ...) -- name: combineFn
	-- upvalues: (copy) v_u_100, (ref) v_u_9, (copy) v_u_19
	local v_u_103 = { ... }
	if typeof(p_u_102) == "table" then
		local v104 = p_u_102
		p_u_102 = p_u_102[1]
		if v104.MatchParams then
			local v105 = v_u_100.MatchParams(p_u_101.Name, v104.MatchParams)
			table.insert(v_u_103, v105)
		end
	end
	return function(...) -- name: NetworkHandler
		-- upvalues: (ref) v_u_9, (copy) p_u_101, (ref) v_u_19, (copy) v_u_103, (ref) p_u_102
		if v_u_9 then
			local v106 = v_u_9[...][p_u_101.Remote].dataIn
			local v107 = v_u_19
			local v108 = select
			table.insert(v106, v107(v108(2, ...)))
		end
		local v_u_109 = 1
		local function v_u_111(p_u_110, ...) -- name: runMiddleware
			-- upvalues: (ref) v_u_109, (ref) v_u_103, (copy) v_u_111, (ref) p_u_102
			if p_u_110 == v_u_109 then
				v_u_109 = v_u_109 + 1
				if p_u_110 <= #v_u_103 then
					return v_u_103[p_u_110](function(...)
						-- upvalues: (ref) v_u_111, (copy) p_u_110
						return v_u_111(p_u_110 + 1, ...)
					end, ...)
				else
					return p_u_102(...)
				end
			else
				return
			end
		end
		return v_u_111(1, ...)
	end
end
function v_u_1.BindEvents(_, p112, p113) -- name: BindEvents
	-- upvalues: (copy) v_u_8, (ref) v_u_20
	local v114
	if typeof(p112) == "table" then
		v114 = nil
	else
		v114 = p112
		p112 = p113
	end
	for v115, v116 in pairs(p112) do
		local v_u_117 = GetEventHandler(v115)
		if not v_u_117 then
			error(("Tried to bind callback to non-existing RemoteEvent %q"):format(v115))
		end
		v_u_117.Callbacks[#v_u_117.Callbacks + 1] = combineFn(v_u_117, v116, v114)
		if v_u_8 then
			v_u_117.Remote.OnServerEvent:Connect(function(...)
				-- upvalues: (copy) v_u_117
				SafeFireEvent(v_u_117, ...)
			end)
		elseif v_u_117.IncomingQueue then
			v_u_20[v_u_117] = true
		end
	end
	ExecuteDeferredHandlers()
end
function v_u_1.BindFunctions(_, p118, p119) -- name: BindFunctions
	-- upvalues: (copy) v_u_8, (ref) v_u_20
	local v120
	if typeof(p118) == "table" then
		v120 = nil
	else
		v120 = p118
		p118 = p119
	end
	for v121, v122 in pairs(p118) do
		local v_u_123 = GetFunctionHandler(v121)
		if not v_u_123 then
			error(("Tried to bind callback to non-existing RemoteFunction %q"):format(v121))
		end
		if v_u_123.Callback then
			error(("Tried to bind multiple callbacks to the same RemoteFunction (%s)"):format(v_u_123.Remote:GetFullName()))
		end
		v_u_123.Callback = combineFn(v_u_123, v122, v120)
		if v_u_8 then
			function v_u_123.Remote.OnServerInvoke(...)
				-- upvalues: (copy) v_u_123
				return SafeInvokeCallback(v_u_123, ...)
			end
		elseif v_u_123.IncomingQueue then
			v_u_20[v_u_123] = true
		end
	end
	ExecuteDeferredHandlers()
end
if v_u_8 then
	function HandlerFireClient(p124, p125, ...) -- name: HandlerFireClient
		-- upvalues: (ref) v_u_9, (copy) v_u_19
		if v_u_9 then
			local v126 = v_u_9[p125][p124.Remote].dataOut
			local v127 = v_u_19
			table.insert(v126, v127(...))
		end
		return p124.Remote:FireClient(p125, ...)
	end
	function v_u_1.GetPlayers(_) -- name: GetPlayers
		-- upvalues: (copy) v_u_4
		return v_u_4:GetPlayers()
	end
	function v_u_1.GetPlayerPosition(_, p128) -- name: GetPlayerPosition
		return p128 and (p128.Character and (p128.Character.PrimaryPart and p128.Character.PrimaryPart.Position)) or nil
	end
	function v_u_1.FireClient(_, p129, p130, ...) -- name: FireClient
		local v131 = GetEventHandler(p130)
		if not v131 then
			error(("\'%s\' is not a valid RemoteEvent"):format(p130))
		end
		HandlerFireClient(v131, p129, ...)
	end
	function v_u_1.FireAllClients(p132, p133, ...) -- name: FireAllClients
		local v134 = GetEventHandler(p133)
		if not v134 then
			error(("\'%s\' is not a valid RemoteEvent"):format(p133))
		end
		for _, v135 in pairs(p132:GetPlayers()) do
			HandlerFireClient(v134, v135, ...)
		end
	end
	function v_u_1.FireOtherClients(p136, p137, p138, ...) -- name: FireOtherClients
		local v139 = GetEventHandler(p138)
		if not v139 then
			error(("\'%s\' is not a valid RemoteEvent"):format(p138))
		end
		for _, v140 in pairs(p136:GetPlayers()) do
			if v140 ~= p137 then
				HandlerFireClient(v139, v140, ...)
			end
		end
	end
	function v_u_1.FireOtherClientsWithinDistance(p141, p142, p143, p144, ...) -- name: FireOtherClientsWithinDistance
		local v145 = GetEventHandler(p144)
		if not v145 then
			error(("\'%s\' is not a valid RemoteEvent"):format(p144))
		end
		local v146 = p141:GetPlayerPosition(p142)
		if v146 then
			for _, v147 in pairs(p141:GetPlayers()) do
				if v147 ~= p142 then
					local v148 = p141:GetPlayerPosition(v147)
					if v148 and (v146 - v148).Magnitude <= p143 then
						HandlerFireClient(v145, v147, ...)
					end
				end
			end
		end
	end
	function v_u_1.FireAllClientsWithinDistance(p149, p150, p151, p152, ...) -- name: FireAllClientsWithinDistance
		local v153 = GetEventHandler(p152)
		if not v153 then
			error(("\'%s\' is not a valid RemoteEvent"):format(p152))
		end
		for _, v154 in pairs(p149:GetPlayers()) do
			local v155 = p149:GetPlayerPosition(v154)
			if v155 and (p150 - v155).Magnitude <= p151 then
				HandlerFireClient(v153, v154, ...)
			end
		end
	end
	function v_u_1.InvokeClientWithTimeout(_, p156, p157, p158, ...) -- name: InvokeClientWithTimeout
		local v159 = GetEventHandler(p158)
		if not v159 then
			error(("\'%s\' is not a valid RemoteEvent"):format(p158))
		end
		return SafeInvoke(p156, v159, p157, ...)
	end
	function v_u_1.InvokeClient(p160, ...) -- name: InvokeClient
		return p160:InvokeClientWithTimeout(60, ...)
	end
	function v_u_1.LogTraffic(p161, ...) -- name: LogTraffic
		FastSpawn(p161.LogTrafficAsync, p161, ...)
	end
	function v_u_1.LogTrafficAsync(_, p162, p163) -- name: LogTrafficAsync
		-- upvalues: (ref) v_u_9
		local v164 = p163 or warn
		if not v_u_9 then
			v164("Logging Network Traffic...")
			v_u_9 = setmetatable({}, {
				["__index"] = function(p165, p166) -- name: __index
					p165[p166] = setmetatable({}, {
						["__index"] = function(p167, p168) -- name: __index
							p167[p168] = {
								["dataIn"] = {},
								["dataOut"] = {}
							}
							return p167[p168]
						end
					})
					return p165[p166]
				end
			})
			local v169 = os.clock()
			wait(p162)
			local v170 = os.clock() - v169
			local v171 = v_u_9
			v_u_9 = nil
			for v172, v173 in pairs(v171) do
				local v174 = 0
				local v175 = 0
				for _, v176 in pairs(v173) do
					v174 = v174 + #v176.dataIn
					v175 = v175 + #v176.dataOut
				end
				v164(string.format("Player \'%s\', total received/sent: %d/%d", v172.Name, v174, v175))
				for v177, v178 in pairs(v173) do
					local v179 = v178.dataIn
					if #v179 > 0 then
						v164(string.format("   %s %s: %d (%.2f/s)", "FireServer", v177.Name, #v179, #v179 / v170))
						local v180 = #v179
						local v181 = math.min(v180, 3)
						for v182 = 1, v181 do
							local v183 = v182 - 1
							local v184 = v181 - 1
							local v185 = v183 / math.max(1, v184) * (#v179 - 1) + 1 + 0.5
							local v186 = math.floor(v185)
							v164(string.format("      %d: %s", v186, v179[v186]))
						end
					end
					local v187 = v178.dataOut
					if #v187 > 0 then
						v164(string.format("   %s %s: %d (%.2f/s)", "FireClient", v177.Name, #v187, #v187 / v170))
						local v188 = #v187
						local v189 = math.min(v188, 3)
						for v190 = 1, v189 do
							local v191 = v190 - 1
							local v192 = v189 - 1
							local v193 = v191 / math.max(1, v192) * (#v187 - 1) + 1 + 0.5
							local v194 = math.floor(v193)
							v164(string.format("      %d: %s", v194, v187[v194]))
						end
					end
				end
			end
		end
	end
else
	v_u_23.ChildAdded:Connect(function(p195)
		GetEventHandler(p195.Name)
	end)
	for _, v196 in pairs(v_u_23:GetChildren()) do
		GetEventHandler(v196.Name)
	end
	v_u_22.ChildAdded:Connect(function(p197)
		GetFunctionHandler(p197.Name)
	end)
	for _, v198 in ipairs(v_u_22:GetChildren()) do
		GetFunctionHandler(v198.Name)
	end
	function v_u_1.FireServer(_, p199, ...) -- name: FireServer
		local v_u_200 = GetEventHandler(p199)
		if not v_u_200 then
			error(("\'%s\' is not a valid RemoteEvent"):format(p199))
		end
		if v_u_200.Remote then
			v_u_200.Remote:FireServer(...)
		else
			local v_u_201 = table.pack(...)
			AddToQueue(v_u_200, function()
				-- upvalues: (copy) v_u_200, (copy) v_u_201
				local v202 = v_u_201
				v_u_200.Remote:FireServer(unpack(v202))
			end, true)
		end
	end
	function v_u_1.InvokeServerWithTimeout(_, p203, p204, ...) -- name: InvokeServerWithTimeout
		local v205 = GetFunctionHandler(p204)
		if not v205 then
			error(("\'%s\' is not a valid RemoteFunction"):format(p204))
		end
		if not v205.Remote then
			local v_u_206 = coroutine.running()
			AddToQueue(v205, function()
				-- upvalues: (copy) v_u_206
				ResumeThread(v_u_206)
			end, true)
			YieldThread()
		end
		local v207 = table.pack(SafeInvoke(p203, v205, ...))
		local v208 = v207[1] == true
		assert(v208, "InvokeServer error")
		return unpack(v207, 2)
	end
	function v_u_1.InvokeServer(p209, p210, ...) -- name: InvokeServer
		return p209:InvokeServerWithTimeout(nil, p210, ...)
	end
end
local v_u_213 = setmetatable({}, {
	["__index"] = nil,
	["__mode"] = "k",
	["__index"] = function(p211, p212) -- name: __index
		p211[p212] = {}
		return p211[p212]
	end
})
local v_u_216 = setmetatable({}, {
	["__index"] = nil,
	["__mode"] = "k",
	["__index"] = function(p214, p215) -- name: __index
		p214[p215] = {}
		return p214[p215]
	end
})
local v_u_217 = {
	"number",
	"string",
	"boolean",
	"nil",
	"Vector2",
	"Vector3",
	"CFrame",
	"Color3",
	"BrickColor",
	"UDim2",
	"UDim"
}
for _, v218 in ipairs(v_u_217) do
	v_u_217[v218] = true
end
local function v_u_226(p219, p220) -- name: addEntry
	-- upvalues: (copy) v_u_217, (copy) v_u_213, (copy) v_u_8, (copy) v_u_1
	local v221 = typeof(p219)
	if not v_u_217[v221] then
		error(string.format("Invalid value passed to Network:Pack (values of type %s are not supported)", v221))
	end
	if v221 == "boolean" or (v221 == "nil" or p219 == "") then
		return p219
	end
	if v221 == "string" and #p219 > 64 then
		return "\0" .. p219
	end
	local v222 = v_u_213[p220]
	local v223 = v222[p219]
	if not v223 then
		if #v222 < 32 then
			local v224 = #v222 + 1
			v223 = {
				["char"] = nil,
				["value"] = nil,
				["last"] = 0,
				["char"] = string.char(v224),
				["value"] = p219
			}
			v222[v224] = v223
			v222[p219] = v223
		else
			for _, v225 in ipairs(v222) do
				if not v223 or v225.last < v223.last then
					v223 = v225
				end
			end
			v222[v223.value] = nil
			v222[p219] = v223
			v223.value = p219
		end
		if v_u_8 then
			v_u_1:FireClient(p220, "SetPackedValue", v223.char, v223.value)
		else
			v_u_1:FireServer("SetPackedValue", v223.char, v223.value)
		end
	end
	v223.last = os.clock()
	return v223.char
end
if v_u_8 then
	function v_u_1.Pack(_, p227, p228) -- name: Pack
		-- upvalues: (copy) v_u_226
		local v229
		if typeof(p228) == "Instance" then
			v229 = p228:IsA("Player")
		else
			v229 = false
		end
		assert(v229, "client is not a player")
		return v_u_226(p227, p228)
	end
	function v_u_1.Unpack(_, p230, p231) -- name: Unpack
		-- upvalues: (copy) v_u_216
		local v232
		if typeof(p231) == "Instance" then
			v232 = p231:IsA("Player")
		else
			v232 = false
		end
		assert(v232, "client is not a player")
		if typeof(p230) == "string" and p230 ~= "" then
			local v233 = string.byte(p230, 1)
			if v233 == 0 then
				return string.sub(p230, 2)
			else
				return v_u_216[p231][v233]
			end
		else
			return p230
		end
	end
	v_u_1:BindEvents({
		["SetPackedValue"] = function(p234, p235, p236) -- name: SetPackedValue
			-- upvalues: (copy) v_u_217, (copy) v_u_216
			if typeof(p235) ~= "string" or #p235 ~= 1 then
				return p234:Kick()
			end
			local v237 = string.byte(p235)
			if v237 < 1 or v237 > 32 then
				return p234:Kick()
			end
			local v238 = typeof(p236)
			if not v_u_217[v238] or v238 == "string" and #p236 > 64 then
				return p234:Kick()
			end
			v_u_216[p234][v237] = p236
		end
	})
else
	function v_u_1.Pack(_, p239) -- name: Pack
		-- upvalues: (copy) v_u_226
		return v_u_226(p239, "Server")
	end
	function v_u_1.Unpack(_, p240) -- name: Unpack
		-- upvalues: (copy) v_u_216
		if typeof(p240) == "string" and p240 ~= "" then
			local v241 = string.byte(p240, 1)
			if v241 == 0 then
				return string.sub(p240, 2)
			else
				return v_u_216.Server[v241]
			end
		else
			return p240
		end
	end
	v_u_1:BindEvents({
		["SetPackedValue"] = function(p242, p243) -- name: SetPackedValue
			-- upvalues: (copy) v_u_216
			v_u_216.Server[string.byte(p242)] = p243
		end
	})
end
local v_u_244 = {
	["Character"] = {},
	["CharacterPart"] = {}
}
local v_u_245 = {}
local v_u_246 = {}
for v247, _ in pairs(v_u_244) do
	v_u_245[v247] = {}
	v_u_246[v247] = {}
end
function v_u_1.AddReference(_, p248, p249, ...) -- name: AddReference
	-- upvalues: (copy) v_u_244, (copy) v_u_245, (copy) v_u_246
	local v250 = v_u_244[p249]
	assert(v250, "Invalid Reference Type")
	local v251 = {
		["Type"] = p249,
		["Reference"] = p248,
		["Objects"] = { ... },
		["Aliases"] = {}
	}
	v_u_245[p249][v251.Reference] = v251
	local v252 = v_u_246[p249]
	for _, v253 in ipairs(v251.Objects) do
		local v254 = v252[v253] or {}
		v252[v253] = v254
		v252 = v254
	end
	v252.__Data = v251
end
function v_u_1.AddReferenceAlias(_, p255, p256, ...) -- name: AddReferenceAlias
	-- upvalues: (copy) v_u_244, (copy) v_u_245, (copy) v_u_246
	local v257 = v_u_244[p256]
	assert(v257, "Invalid Reference Type")
	local v258 = v_u_245[p256][p255]
	if v258 then
		local v259 = { ... }
		v258.Aliases[#v258.Aliases + 1] = v259
		local v260 = v_u_246[p256]
		for _, v261 in ipairs(v259) do
			local v262 = v260[v261] or {}
			v260[v261] = v262
			v260 = v262
		end
		v260.__Data = v258
	else
		warn("Tried to add an alias to a non-existing reference")
	end
end
function v_u_1.RemoveReference(_, p263, p264) -- name: RemoveReference
	-- upvalues: (copy) v_u_244, (copy) v_u_245, (copy) v_u_246
	local v265 = v_u_244[p264]
	assert(v265, "Invalid Reference Type")
	local v_u_266 = v_u_245[p264][p263]
	if v_u_266 then
		v_u_245[p264][v_u_266.Reference] = nil
		local function v_u_272(p267, p268, p269) -- name: rem
			-- upvalues: (copy) v_u_272, (copy) v_u_266
			if p269 <= #p268 then
				local v270 = p268[p269]
				local v271 = p267[v270]
				v_u_272(v271, p268, p269 + 1)
				if next(v271) == nil then
					p267[v270] = nil
					return
				end
			elseif p267.__Data == v_u_266 then
				p267.__Data = nil
			end
		end
		local v273 = v_u_246[v_u_266.Type]
		local v274 = v_u_266.Objects
		if #v274 >= 1 then
			local v275 = v274[1]
			local v276 = v273[v275]
			v_u_272(v276, v274, 2)
			if next(v276) == nil then
				v273[v275] = nil
			end
		elseif v273.__Data == v_u_266 then
			v273.__Data = nil
		end
		for _, v277 in ipairs(v_u_266.Aliases) do
			if #v277 >= 1 then
				local v278 = v277[1]
				local v279 = v273[v278]
				v_u_272(v279, v277, 2)
				if next(v279) == nil then
					v273[v278] = nil
				end
			elseif v273.__Data == v_u_266 then
				v273.__Data = nil
			end
		end
	else
		warn("Tried to remove a non-existing reference")
	end
end
function v_u_1.GetObject(_, p280, p281) -- name: GetObject
	-- upvalues: (copy) v_u_244, (copy) v_u_245
	local v282 = v_u_244[p281]
	assert(v282, "Invalid Reference Type")
	local v283 = v_u_245[p281][p280]
	if not v283 then
		return nil
	end
	local v284 = v283.Objects
	return unpack(v284)
end
function v_u_1.GetReference(_, ...) -- name: GetReference
	-- upvalues: (copy) v_u_244, (copy) v_u_246
	local v285 = { ... }
	local v286 = table.remove(v285)
	local v287 = v_u_244[v286]
	assert(v287, "Invalid Reference Type")
	local v288 = v_u_246[v286]
	for _, v289 in ipairs(v285) do
		v288 = v288[v289]
		if not v288 then
			break
		end
	end
	if v288 then
		v288 = v288.__Data
	end
	return v288 and v288.Reference or nil
end
return v_u_1