local v_u_1 = newproxy()
local v_u_2 = newproxy()
local v_u_3 = game:GetService("RunService")
local function v_u_9(p4, p5) -- name: GetObjectCleanupFunction
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v6 = typeof(p4)
	if v6 == "function" then
		return v_u_1
	end
	if v6 == "thread" then
		return v_u_2
	end
	if p5 then
		return p5
	end
	if v6 == "Instance" then
		return "Destroy"
	end
	if v6 == "RBXScriptConnection" then
		return "Disconnect"
	end
	if v6 == "table" then
		local v7 = p4.Destroy
		if typeof(v7) == "function" then
			return "Destroy"
		end
		local v8 = p4.Disconnect
		if typeof(v8) == "function" then
			return "Disconnect"
		end
	end
	error("Failed to get cleanup function for object " .. v6 .. ": " .. tostring(p4), 3)
end
local v_u_10 = {}
v_u_10.__index = v_u_10
function v_u_10.new() -- name: new
	-- upvalues: (copy) v_u_10
	local v11 = v_u_10
	local v12 = setmetatable({}, v11)
	v12._objects = {}
	return v12
end
function v_u_10.Extend(p13) -- name: Extend
	-- upvalues: (copy) v_u_10
	return p13:Construct(v_u_10)
end
function v_u_10.Clone(p14, p15) -- name: Clone
	return p14:Add(p15:Clone())
end
function v_u_10.Construct(p16, p17, ...) -- name: Construct
	local v18 = nil
	local v19 = type(p17)
	if v19 == "table" then
		v18 = p17.new(...)
	elseif v19 == "function" then
		v18 = p17(...)
	end
	return p16:Add(v18)
end
function v_u_10.Connect(p20, p21, p22) -- name: Connect
	return p20:Add(p21:Connect(p22))
end
function v_u_10.BindToRenderStep(p23, p_u_24, p25, p26) -- name: BindToRenderStep
	-- upvalues: (copy) v_u_3
	v_u_3:BindToRenderStep(p_u_24, p25, p26)
	p23:Add(function()
		-- upvalues: (ref) v_u_3, (copy) p_u_24
		v_u_3:UnbindFromRenderStep(p_u_24)
	end)
end
function v_u_10.AddPromise(p_u_27, p_u_28) -- name: AddPromise
	if type(p_u_28) == "table" then
		local v29 = p_u_28.getStatus
		if type(v29) == "function" then
			local v30 = p_u_28.finally
			if type(v30) == "function" then
				local v31 = p_u_28.cancel
				if type(v31) == "function" then
					::l5::
					if p_u_28:getStatus() == "Started" then
						p_u_28:finally(function()
							-- upvalues: (copy) p_u_27, (copy) p_u_28
							return p_u_27:_findAndRemoveFromObjects(p_u_28, false)
						end)
						p_u_27:Add(p_u_28, "cancel")
					end
					return p_u_28
				end
			end
		end
	end
	error("Did not receive a Promise as an argument", 3)
	goto l5
end
function v_u_10.Add(p32, p33, p34) -- name: Add
	-- upvalues: (copy) v_u_9
	local v35 = v_u_9(p33, p34)
	local v36 = p32._objects
	table.insert(v36, { p33, v35 })
	return p33
end
function v_u_10.Remove(p37, p38) -- name: Remove
	return p37:_findAndRemoveFromObjects(p38, true)
end
function v_u_10.Clean(p39) -- name: Clean
	for _, v40 in ipairs(p39._objects) do
		p39:_cleanupObject(v40[1], v40[2])
	end
	table.clear(p39._objects)
end
function v_u_10._findAndRemoveFromObjects(p41, p42, p43) -- name: _findAndRemoveFromObjects
	local v44 = p41._objects
	for v45, v46 in ipairs(v44) do
		if v46[1] == p42 then
			local v47 = #v44
			v44[v45] = v44[v47]
			v44[v47] = nil
			if p43 then
				p41:_cleanupObject(v46[1], v46[2])
			end
			return true
		end
	end
	return false
end
function v_u_10._cleanupObject(_, p48, p49) -- name: _cleanupObject
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	if p49 == v_u_1 then
		p48()
		return
	elseif p49 == v_u_2 then
		coroutine.close(p48)
	else
		p48[p49](p48)
	end
end
function v_u_10.AttachToInstance(p_u_50, p51) -- name: AttachToInstance
	local v52 = p51:IsDescendantOf(game)
	assert(v52, "Instance is not a descendant of the game hierarchy")
	return p_u_50:Connect(p51.Destroying, function()
		-- upvalues: (copy) p_u_50
		p_u_50:Destroy()
	end)
end
function v_u_10.Destroy(p53) -- name: Destroy
	p53:Clean()
end
return v_u_10