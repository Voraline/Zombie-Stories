local v_u_1 = require(script.Parent.Spawn)
local v_u_2 = {}
v_u_2.__index = v_u_2
function v_u_2.new(p3) -- name: new
	-- upvalues: (copy) v_u_2
	local v4 = v_u_2
	local v_u_5 = setmetatable({}, v4)
	v_u_5.Status = "Pending"
	v_u_5.OnResolve = {}
	v_u_5.OnReject = {}
	v_u_5.Value = {}
	v_u_5.Thread = coroutine.create(xpcall)
	task.spawn(v_u_5.Thread, p3, function(p6)
		-- upvalues: (copy) v_u_5
		v_u_5:_Reject(p6)
	end, function(...)
		-- upvalues: (copy) v_u_5
		v_u_5:_Resolve(...)
	end, function(...)
		-- upvalues: (copy) v_u_5
		v_u_5:_Reject(...)
	end)
	return v_u_5
end
function v_u_2.Resolve(...) -- name: Resolve
	-- upvalues: (copy) v_u_2
	local v7 = v_u_2
	local v8 = setmetatable({}, v7)
	v8.Status = "Resolved"
	v8.OnResolve = {}
	v8.OnReject = {}
	v8.Value = { ... }
	v8.Thread = nil
	return v8
end
function v_u_2.Reject(...) -- name: Reject
	-- upvalues: (copy) v_u_2
	local v9 = v_u_2
	local v10 = setmetatable({}, v9)
	v10.Status = "Rejected"
	v10.OnResolve = {}
	v10.OnReject = {}
	v10.Value = { ... }
	v10.Thread = nil
	return v10
end
function v_u_2.All(p_u_11) -- name: All
	-- upvalues: (copy) v_u_2
	if #p_u_11 == 0 then
		return v_u_2.Resolve({})
	else
		return v_u_2.new(function(p_u_12, p_u_13)
			-- upvalues: (copy) p_u_11
			local v_u_14 = false
			local v_u_15 = 0
			local v_u_16 = {}
			for v_u_17, v18 in p_u_11 do
				if v18.Status == "Resolved" then
					v_u_15 = v_u_15 + 1
					v_u_16[v_u_17] = v18.Value[1]
				else
					if v18.Status == "Rejected" then
						p_u_13(v18.Value[1])
						break
					end
					local v19 = v18.OnResolve
					local function v21(p20)
						-- upvalues: (ref) v_u_14, (ref) v_u_15, (copy) v_u_16, (copy) v_u_17, (ref) p_u_11, (copy) p_u_12
						if not v_u_14 then
							v_u_15 = v_u_15 + 1
							v_u_16[v_u_17] = p20
							if v_u_15 == #p_u_11 then
								p_u_12(v_u_16)
								v_u_14 = true
							end
						end
					end
					table.insert(v19, v21)
					local v22 = v18.OnReject
					table.insert(v22, function(p23)
						-- upvalues: (ref) v_u_14, (copy) p_u_13
						if not v_u_14 then
							p_u_13(p23)
							v_u_14 = true
						end
					end)
				end
			end
			if v_u_15 == #p_u_11 then
				p_u_12(v_u_16)
			end
		end)
	end
end
function v_u_2.AllSettled(p_u_24) -- name: AllSettled
	-- upvalues: (copy) v_u_2
	if #p_u_24 == 0 then
		return v_u_2.Resolve({})
	else
		return v_u_2.new(function(p_u_25, _)
			-- upvalues: (copy) p_u_24
			local v_u_26 = false
			local v_u_27 = 0
			local v_u_28 = {}
			for v_u_29, v30 in p_u_24 do
				if v30.Status == "Resolved" then
					v_u_27 = v_u_27 + 1
					v_u_28[v_u_29] = "Resolved"
				elseif v30.Status == "Rejected" then
					v_u_27 = v_u_27 + 1
					v_u_28[v_u_29] = "Rejected"
				else
					local v31 = v30.OnResolve
					local function v32(_)
						-- upvalues: (ref) v_u_26, (ref) v_u_27, (copy) v_u_28, (copy) v_u_29, (ref) p_u_24, (copy) p_u_25
						if not v_u_26 then
							v_u_27 = v_u_27 + 1
							v_u_28[v_u_29] = "Resolved"
							if v_u_27 == #p_u_24 then
								p_u_25(v_u_28)
								v_u_26 = true
							end
						end
					end
					table.insert(v31, v32)
					local v33 = v30.OnReject
					local function v34(_)
						-- upvalues: (ref) v_u_26, (ref) v_u_27, (copy) v_u_28, (copy) v_u_29, (ref) p_u_24, (copy) p_u_25
						if not v_u_26 then
							v_u_27 = v_u_27 + 1
							v_u_28[v_u_29] = "Rejected"
							if v_u_27 == #p_u_24 then
								p_u_25(v_u_28)
								v_u_26 = true
							end
						end
					end
					table.insert(v33, v34)
				end
			end
			if v_u_27 == #p_u_24 then
				p_u_25(v_u_28)
			end
		end)
	end
end
function v_u_2.Any(p_u_35) -- name: Any
	-- upvalues: (copy) v_u_2
	if #p_u_35 == 0 then
		return v_u_2.Reject({})
	else
		return v_u_2.new(function(p_u_36, p_u_37)
			-- upvalues: (copy) p_u_35
			local v_u_38 = false
			local v_u_39 = 0
			local v_u_40 = {}
			for v_u_41, v42 in p_u_35 do
				if v42.Status == "Resolved" then
					p_u_36(v42.Value[1])
					break
				end
				if v42.Status == "Rejected" then
					v_u_39 = v_u_39 + 1
					v_u_40[v_u_41] = v42.Value[1]
				else
					local v43 = v42.OnResolve
					table.insert(v43, function(p44)
						-- upvalues: (ref) v_u_38, (copy) p_u_36
						if not v_u_38 then
							p_u_36(p44)
							v_u_38 = true
						end
					end)
					local v45 = v42.OnReject
					local function v47(p46)
						-- upvalues: (ref) v_u_38, (ref) v_u_39, (copy) v_u_40, (copy) v_u_41, (ref) p_u_35, (copy) p_u_37
						if not v_u_38 then
							v_u_39 = v_u_39 + 1
							v_u_40[v_u_41] = p46
							if v_u_39 == #p_u_35 then
								p_u_37(v_u_40)
								v_u_38 = true
							end
						end
					end
					table.insert(v45, v47)
				end
			end
			if v_u_39 == #p_u_35 then
				p_u_37(v_u_40)
			end
		end)
	end
end
function v_u_2.Race(p_u_48) -- name: Race
	-- upvalues: (copy) v_u_2
	if #p_u_48 == 0 then
		return v_u_2.Reject("No promises to resolve.")
	else
		return v_u_2.new(function(p_u_49, p_u_50)
			-- upvalues: (copy) p_u_48
			local v_u_51 = false
			for _, v52 in p_u_48 do
				if v52.Status == "Resolved" then
					local v53 = v52.Value
					p_u_49(unpack(v53))
					break
				end
				if v52.Status == "Rejected" then
					local v54 = v52.Value
					p_u_50(unpack(v54))
					break
				end
				local v55 = v52.OnResolve
				table.insert(v55, function(p56)
					-- upvalues: (ref) v_u_51, (copy) p_u_49
					if not v_u_51 then
						p_u_49(p56)
						v_u_51 = true
					end
				end)
				local v57 = v52.OnReject
				table.insert(v57, function(p58)
					-- upvalues: (ref) v_u_51, (copy) p_u_50
					if not v_u_51 then
						p_u_50(p58)
						v_u_51 = true
					end
				end)
			end
		end)
	end
end
function v_u_2.Retry(p_u_59, p_u_60, ...) -- name: Retry
	-- upvalues: (copy) v_u_2
	local v_u_61 = { ... }
	return v_u_2.new(function(p62, p63)
		-- upvalues: (copy) p_u_59, (copy) p_u_60, (copy) v_u_61
		local v64 = 0
		while v64 < p_u_59 do
			v64 = v64 + 1
			local v65 = {}
			local v66 = v_u_61
			__set_list(v65, 1, {pcall(p_u_60, unpack(v66))})
			if table.remove(v65, 1) then
				p62(unpack(v65))
				return
			end
			if v64 == p_u_59 then
				p63(unpack(v65))
				return
			end
		end
	end)
end
function v_u_2.RetryWithDelay(p_u_67, p_u_68, p_u_69, ...) -- name: RetryWithDelay
	-- upvalues: (copy) v_u_2
	local v_u_70 = { ... }
	return v_u_2.new(function(p71, p72)
		-- upvalues: (copy) p_u_67, (copy) p_u_69, (copy) v_u_70, (copy) p_u_68
		local v73 = 0
		while v73 < p_u_67 do
			v73 = v73 + 1
			local v74 = {}
			local v75 = v_u_70
			__set_list(v74, 1, {pcall(p_u_69, unpack(v75))})
			if table.remove(v74, 1) then
				p71(unpack(v74))
				return
			end
			if v73 == p_u_67 then
				p72(unpack(v74))
				return
			end
			task.wait(p_u_68)
		end
	end)
end
function v_u_2._Resolve(p76, ...) -- name: _Resolve
	-- upvalues: (copy) v_u_1
	local v77 = p76.Status == "Pending"
	assert(v77, "Cannot resolve a promise that is not pending.")
	p76.Status = "Resolved"
	p76.Value = table.pack(...)
	for _, v78 in p76.OnResolve do
		v_u_1(v78, ...)
	end
	task.defer(task.cancel, p76.Thread)
end
function v_u_2._Reject(p79, ...) -- name: _Reject
	-- upvalues: (copy) v_u_1
	local v80 = p79.Status == "Pending"
	assert(v80, "Cannot reject a promise that is not pending.")
	p79.Status = "Rejected"
	p79.Value = table.pack(...)
	for _, v81 in p79.OnReject do
		v_u_1(v81, ...)
	end
	task.defer(task.cancel, p79.Thread)
end
function v_u_2.Then(p_u_82, p_u_83, p_u_84) -- name: Then
	-- upvalues: (copy) v_u_2
	return v_u_2.new(function(p_u_85, p_u_86)
		-- upvalues: (ref) v_u_2, (copy) p_u_82, (copy) p_u_83, (copy) p_u_84
		local function v_u_96(p87, ...) -- name: PromiseResolutionProcedure
			-- upvalues: (ref) v_u_2, (copy) p_u_85, (copy) p_u_86
			if type(p87) == "table" and getmetatable(p87) == v_u_2 then
				if p87.Status == "Pending" then
					local v88 = p87.OnResolve
					local v89 = p_u_85
					table.insert(v88, v89)
					local v90 = p87.OnReject
					local v91 = p_u_86
					table.insert(v90, v91)
					return
				end
				if p87.Status == "Resolved" then
					local v92 = p_u_85
					local v93 = p87.Value
					v92(unpack(v93))
					return
				end
				if p87.Status == "Rejected" then
					local v94 = p_u_86
					local v95 = p87.Value
					v94(unpack(v95))
					return
				end
			else
				p_u_85(p87, ...)
			end
		end
		if p_u_82.Status == "Pending" then
			if p_u_83 then
				local v97 = p_u_82.OnResolve
				local function v98(...)
					-- upvalues: (copy) v_u_96, (ref) p_u_83
					v_u_96(p_u_83(...))
				end
				table.insert(v97, v98)
			else
				local v99 = p_u_82.OnResolve
				table.insert(v99, v_u_96)
			end
			if p_u_84 then
				local v100 = p_u_82.OnReject
				local function v101(...)
					-- upvalues: (copy) v_u_96, (ref) p_u_84
					v_u_96(p_u_84(...))
				end
				table.insert(v100, v101)
			else
				local v102 = p_u_82.OnReject
				table.insert(v102, p_u_86)
			end
		elseif p_u_82.Status == "Resolved" then
			if p_u_83 then
				local v103 = p_u_83
				local v104 = p_u_82.Value
				v_u_96(v103(unpack(v104)))
			else
				local v105 = p_u_82.Value
				p_u_85(unpack(v105))
			end
		else
			if p_u_82.Status == "Rejected" then
				if p_u_84 then
					local v106 = p_u_84
					local v107 = p_u_82.Value
					v_u_96(v106(unpack(v107)))
					return
				end
				local v108 = p_u_82.Value
				p_u_86(unpack(v108))
			end
			return
		end
	end)
end
function v_u_2.Catch(p109, p110) -- name: Catch
	return p109:Then(nil, p110)
end
function v_u_2.Finally(p_u_111, p_u_112) -- name: Finally
	return p_u_111:Then(function(...)
		-- upvalues: (copy) p_u_112, (copy) p_u_111
		p_u_112(p_u_111.Status)
		return p_u_111
	end, function(_)
		-- upvalues: (copy) p_u_112, (copy) p_u_111
		p_u_112(p_u_111.Status)
		return p_u_111
	end)
end
function v_u_2.Await(p113) -- name: Await
	if p113.Status == "Resolved" then
		local v114 = p113.Value
		return unpack(v114)
	end
	if p113.Status == "Rejected" then
		local v115 = error
		local v116 = p113.Value
		return v115(unpack(v116))
	end
	local v_u_117 = coroutine.running()
	local function v118() -- name: Resume
		-- upvalues: (copy) v_u_117
		task.spawn(v_u_117)
	end
	local v119 = p113.OnResolve
	table.insert(v119, v118)
	local v120 = p113.OnReject
	table.insert(v120, v118)
	coroutine.yield()
	if p113.Status == "Resolved" then
		local v121 = p113.Value
		return unpack(v121)
	end
	local v122 = error
	local v123 = p113.Value
	return v122(unpack(v123))
end
function v_u_2.StatusAwait(p124) -- name: StatusAwait
	if p124.Status == "Resolved" then
		local v125 = p124.Status
		local v126 = p124.Value
		return v125, unpack(v126)
	end
	if p124.Status == "Rejected" then
		local v127 = p124.Status
		local v128 = p124.Value
		return v127, unpack(v128)
	end
	local v_u_129 = coroutine.running()
	local function v130() -- name: Resume
		-- upvalues: (copy) v_u_129
		coroutine.resume(v_u_129)
	end
	local v131 = p124.OnResolve
	table.insert(v131, v130)
	local v132 = p124.OnReject
	table.insert(v132, v130)
	coroutine.yield()
	local v133 = p124.Status
	local v134 = p124.Value
	return v133, unpack(v134)
end
return v_u_2