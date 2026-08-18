local v_u_1 = require(script.Parent.Parent.Trove)
local v_u_2 = require(script.Parent.Parent.Signal)
local v_u_3 = {}
v_u_3.__index = v_u_3
function v_u_3.new(p4, p_u_5) -- name: new
	-- upvalues: (copy) v_u_3, (copy) v_u_1, (copy) v_u_2
	local v_u_6 = {}
	local v7 = v_u_3
	setmetatable(v_u_6, v7)
	v_u_6._trove = v_u_1.new()
	v_u_6._shown = v_u_6._trove:Construct(v_u_2)
	v_u_6._shownTrove = v_u_1.new()
	v_u_6._trove:Add(v_u_6._shownTrove)
	v_u_6.Instance = p4:FindFirstChild(p_u_5)
	local function v_u_9() -- name: OnInstanceSet
		-- upvalues: (copy) v_u_6
		local v_u_8 = v_u_6.Instance
		if typeof(v_u_8) == "Instance" then
			v_u_6._shown:Fire(v_u_8, v_u_6._shownTrove)
			v_u_6._shownTrove:Connect(v_u_8:GetPropertyChangedSignal("Parent"), function()
				-- upvalues: (copy) v_u_8, (ref) v_u_6
				if not v_u_8.Parent then
					v_u_6._shownTrove:Clean()
				end
			end)
			v_u_6._shownTrove:Add(function()
				-- upvalues: (ref) v_u_6, (copy) v_u_8
				if v_u_6.Instance == v_u_8 then
					v_u_6.Instance = nil
				end
			end)
		end
	end
	v_u_6._trove:Connect(p4.ChildAdded, function(p10) -- name: OnChildAdded
		-- upvalues: (copy) p_u_5, (copy) v_u_6, (copy) v_u_9
		if p10.Name == p_u_5 and not v_u_6.Instance then
			v_u_6.Instance = p10
			v_u_9()
		end
	end)
	if v_u_6.Instance then
		v_u_9()
	end
	return v_u_6
end
function v_u_3.primary(p_u_11) -- name: primary
	-- upvalues: (copy) v_u_3, (copy) v_u_1, (copy) v_u_2
	local v_u_12 = {}
	local v13 = v_u_3
	setmetatable(v_u_12, v13)
	v_u_12._trove = v_u_1.new()
	v_u_12._shown = v_u_12._trove:Construct(v_u_2)
	v_u_12._shownTrove = v_u_1.new()
	v_u_12._trove:Add(v_u_12._shownTrove)
	v_u_12.Instance = p_u_11.PrimaryPart
	v_u_12._trove:Connect(p_u_11:GetPropertyChangedSignal("PrimaryPart"), function() -- name: OnPrimaryPartChanged
		-- upvalues: (copy) p_u_11, (copy) v_u_12
		local v14 = p_u_11.PrimaryPart
		v_u_12._shownTrove:Clean()
		v_u_12.Instance = v14
		if v14 then
			v_u_12._shown:Fire(v14, v_u_12._shownTrove)
		end
	end)
	if v_u_12.Instance then
		local v15 = p_u_11.PrimaryPart
		v_u_12._shownTrove:Clean()
		v_u_12.Instance = v15
		if v15 then
			v_u_12._shown:Fire(v15, v_u_12._shownTrove)
		end
	end
	return v_u_12
end
function v_u_3.Observe(p16, p17) -- name: Observe
	if p16.Instance then
		task.spawn(p17, p16.Instance, p16._shownTrove)
	end
	return p16._shown:Connect(p17)
end
function v_u_3.Destroy(p18) -- name: Destroy
	p18._trove:Destroy()
end
return v_u_3