local v1 = require("@self/GetPromiseLibrary")
local v_u_2 = require("@self/RbxScriptConnection")
local v3 = require("@self/Symbol")
local v_u_4, v_u_5 = v1()
local v_u_6 = v3("IndicesReference")
local v_u_7 = v3("LinkToInstanceIndex")
local v_u_8 = {
	["ClassName"] = "Janitor",
	["CurrentlyCleaning"] = true,
	[v_u_6] = nil
}
v_u_8.__index = v_u_8
local v_u_9 = {
	["function"] = true,
	["thread"] = true,
	["RBXScriptConnection"] = "Disconnect"
}
function v_u_8.new() -- name: new
	-- upvalues: (copy) v_u_6, (copy) v_u_8
	local v10 = {
		["CurrentlyCleaning"] = false,
		[v_u_6] = nil
	}
	local v11 = v_u_8
	return setmetatable(v10, v11)
end
function v_u_8.Is(p12) -- name: Is
	-- upvalues: (copy) v_u_8
	local v13
	if type(p12) == "table" then
		v13 = getmetatable(p12) == v_u_8
	else
		v13 = false
	end
	return v13
end
function v_u_8.Add(p14, p15, p16, p17) -- name: Add
	-- upvalues: (copy) v_u_6, (copy) v_u_9
	if p17 then
		p14:Remove(p17)
		local v18 = p14[v_u_6]
		if not v18 then
			v18 = {}
			p14[v_u_6] = v18
		end
		v18[p17] = p15
	end
	local v19 = typeof(p15)
	local v20 = p16 or (v_u_9[v19] or "Destroy")
	if v19 == "function" or v19 == "thread" then
		if v20 ~= true then
			warn(string.format("Object is a %s and as such expected `true?` for the method name and instead got %s. Traceback: %s", v19, tostring(v20), debug.traceback(nil, 2)))
		end
	elseif not p15[v20] then
		warn(string.format("Object %s doesn\'t have method %s, are you sure you want to add it? Traceback: %s", tostring(p15), tostring(v20), debug.traceback(nil, 2)))
	end
	p14[p15] = v20
	return p15
end
function v_u_8.AddPromise(p21, p_u_22) -- name: AddPromise
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	if not v_u_4 then
		return p_u_22
	end
	if not v_u_5.is(p_u_22) then
		error(string.format("Invalid argument #1 to \'Janitor:AddPromise\' (Promise expected, got %s (%s)) Traceback: %s", typeof(p_u_22), tostring(p_u_22), debug.traceback(nil, 2)))
	end
	if p_u_22:getStatus() ~= v_u_5.Status.Started then
		return p_u_22
	end
	local v23 = newproxy(false)
	local v26 = p21:Add(v_u_5.new(function(p24, _, p25)
		-- upvalues: (copy) p_u_22
		if not p25(function()
			-- upvalues: (ref) p_u_22
			p_u_22:cancel()
		end) then
			p24(p_u_22)
		end
	end), "cancel", v23)
	v26:finallyCall(p21.Remove, p21, v23)
	return v26
end
function v_u_8.Remove(p27, p28) -- name: Remove
	-- upvalues: (copy) v_u_6
	local v29 = p27[v_u_6]
	local v30 = v29 and v29[p28]
	if v30 then
		local v31 = p27[v30]
		if v31 then
			if v31 == true then
				if type(v30) == "function" then
					v30()
				else
					task.cancel(v30)
				end
			else
				local v32 = v30[v31]
				if v32 then
					v32(v30)
				end
			end
			p27[v30] = nil
		end
		v29[p28] = nil
	end
	return p27
end
function v_u_8.RemoveList(p33, ...) -- name: RemoveList
	-- upvalues: (copy) v_u_6
	local v34 = p33[v_u_6]
	if v34 then
		local v35 = select("#", ...)
		if v35 == 1 then
			return p33:Remove(...)
		end
		for v36 = 1, v35 do
			local v37 = v34[select(v36, ...)]
			if v37 then
				local v38 = p33[v37]
				if v38 then
					if v38 == true then
						if type(v37) == "function" then
							v37()
						else
							task.cancel(v37)
						end
					else
						local v39 = v37[v38]
						if v39 then
							v39(v37)
						end
					end
					p33[v37] = nil
				end
				v34[v36] = nil
			end
		end
	end
	return p33
end
function v_u_8.Get(p40, p41) -- name: Get
	-- upvalues: (copy) v_u_6
	local v42 = p40[v_u_6]
	if v42 then
		return v42[p41]
	else
		return nil
	end
end
function v_u_8.Cleanup(p_u_43) -- name: Cleanup
	-- upvalues: (copy) v_u_6
	if not p_u_43.CurrentlyCleaning then
		p_u_43.CurrentlyCleaning = nil
		local function v46()
			-- upvalues: (copy) p_u_43, (ref) v_u_6
			for v44, v45 in next, p_u_43 do
				if v44 ~= v_u_6 then
					return v44, v45
				end
			end
		end
		local v47, v48 = v46()
		while v47 and v48 do
			if v48 == true then
				if type(v47) == "function" then
					v47()
				else
					task.cancel(v47)
				end
			else
				local v49 = v47[v48]
				if v49 then
					v49(v47)
				end
			end
			p_u_43[v47] = nil
			v47, v48 = v46()
		end
		local v50 = p_u_43[v_u_6]
		if v50 then
			table.clear(v50)
			p_u_43[v_u_6] = {}
		end
		p_u_43.CurrentlyCleaning = false
	end
end
function v_u_8.Destroy(p51) -- name: Destroy
	p51:Cleanup()
	table.clear(p51)
	setmetatable(p51, nil)
end
v_u_8.__call = v_u_8.Cleanup
function v_u_8.LinkToInstance(p_u_52, p53, p54) -- name: LinkToInstance
	-- upvalues: (copy) v_u_7
	local v55 = p54 and newproxy(false) or v_u_7
	return p_u_52:Add(p53.Destroying:Connect(function()
		-- upvalues: (copy) p_u_52
		p_u_52:Cleanup()
	end), "Disconnect", v55)
end
function v_u_8.LegacyLinkToInstance(p_u_56, p57, p58) -- name: LegacyLinkToInstance
	-- upvalues: (copy) v_u_7, (copy) v_u_2
	local v_u_59 = nil
	local v60 = p58 and newproxy(false) or v_u_7
	local v_u_61 = p57.Parent == nil
	local v62 = v_u_2
	local v_u_63 = setmetatable({}, v62)
	local function v65(_, p64) -- name: ChangedFunction
		-- upvalues: (copy) v_u_63, (ref) v_u_61, (ref) v_u_59, (copy) p_u_56
		v_u_61 = v_u_63.Connected and p64 == nil
		if v_u_61 then
			task.defer(function()
				-- upvalues: (ref) v_u_63, (ref) v_u_59, (ref) p_u_56, (ref) v_u_61
				if v_u_63.Connected then
					if v_u_59.Connected then
						while v_u_61 and (v_u_59.Connected and v_u_63.Connected) do
							task.wait()
						end
						if v_u_63.Connected and v_u_61 then
							p_u_56:Cleanup()
						end
					else
						p_u_56:Cleanup()
					end
				else
					return
				end
			end)
		end
	end
	local v_u_66 = p57.AncestryChanged:Connect(v65)
	v_u_63.Connection = v_u_66
	if v_u_61 then
		local v67 = p57.Parent
		if v_u_63.Connected then
			if v67 == nil then
				v_u_61 = true
			else
				v_u_61 = false
			end
			if v_u_61 then
				task.defer(function()
					-- upvalues: (copy) v_u_63, (ref) v_u_66, (copy) p_u_56, (ref) v_u_61
					if v_u_63.Connected then
						if v_u_66.Connected then
							while v_u_61 and (v_u_66.Connected and v_u_63.Connected) do
								task.wait()
							end
							if v_u_63.Connected and v_u_61 then
								p_u_56:Cleanup()
							end
						else
							p_u_56:Cleanup()
						end
					else
						return
					end
				end)
			end
		end
	end
	return p_u_56:Add(v_u_63, "Disconnect", v60)
end
function v_u_8.LinkToInstances(p68, ...) -- name: LinkToInstances
	-- upvalues: (copy) v_u_8
	local v69 = v_u_8.new()
	for _, v70 in ipairs({ ... }) do
		v69:Add(p68:LinkToInstance(v70, true), "Disconnect")
	end
	return v69
end
function v_u_8.__tostring(_) -- name: __tostring
	return "Janitor"
end
table.freeze(v_u_8)
return v_u_8