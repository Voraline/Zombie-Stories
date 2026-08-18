local v_u_1 = require(script:WaitForChild("Table"))
local v_u_2 = {}
v_u_2.__index = v_u_2
v_u_2.__type = "PartCache"
local v_u_3 = CFrame.new(0, 1000000000, 0)
function v_u_2.new(p4, p5, p6) -- name: new
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_3
	local v7 = p5 or 5
	local v8 = p6 or workspace
	local v9 = v7 > 0
	assert(v9, "PrecreatedParts can not be negative!")
	if v7 ~= 0 == false then
		warn("PrecreatedParts is 0! This may have adverse effects when initially using the cache.")
	end
	if p4.Archivable == false then
		warn("The template\'s Archivable property has been set to false, which prevents it from being cloned. It will temporarily be set to true.")
	end
	local v10 = p4.Archivable
	p4.Archivable = true
	local v11 = p4:Clone()
	p4.Archivable = v10
	local v12 = {
		["Open"] = nil,
		["InUse"] = nil,
		["CurrentCacheParent"] = nil,
		["Template"] = nil,
		["ExpansionSize"] = 10,
		["Open"] = {},
		["InUse"] = {},
		["CurrentCacheParent"] = v8,
		["Template"] = v11
	}
	local v13 = v_u_2
	setmetatable(v12, v13)
	for _ = 1, v7 do
		local v14 = v_u_1.insert
		local v15 = v12.Open
		local v16 = v12.CurrentCacheParent
		local v17 = v11:Clone()
		v17.CFrame = v_u_3
		v17.Anchored = true
		v17.Parent = v16
		v14(v15, v17)
	end
	v12.Template.Parent = nil
	return v12
end
function v_u_2.GetPart(p18) -- name: GetPart
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_3
	local v19 = getmetatable(p18) == v_u_2
	assert(v19, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("GetPart", "PartCache.new"))
	if #p18.Open == 0 then
		for _ = 1, p18.ExpansionSize do
			local v20 = v_u_1.insert
			local v21 = p18.Open
			local v22 = p18.Template
			local v23 = p18.CurrentCacheParent
			local v24 = v22:Clone()
			v24.CFrame = v_u_3
			v24.Anchored = true
			v24.Parent = v23
			v20(v21, v24)
		end
	end
	local v25 = p18.Open[#p18.Open]
	p18.Open[#p18.Open] = nil
	v_u_1.insert(p18.InUse, v25)
	return v25
end
function v_u_2.ReturnPart(p26, p27) -- name: ReturnPart
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_3
	local v28 = getmetatable(p26) == v_u_2
	assert(v28, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("ReturnPart", "PartCache.new"))
	local v29 = v_u_1.indexOf(p26.InUse, p27)
	if v29 == nil then
		error("Attempted to return part \"" .. p27.Name .. "\" (" .. p27:GetFullName() .. ") to the cache, but it\'s not in-use! Did you call this on the wrong part?")
	else
		v_u_1.remove(p26.InUse, v29)
		v_u_1.insert(p26.Open, p27)
		p27.CFrame = v_u_3
		p27.Anchored = true
	end
end
function v_u_2.SetCacheParent(p30, p31) -- name: SetCacheParent
	-- upvalues: (copy) v_u_2
	local v32 = getmetatable(p30) == v_u_2
	assert(v32, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("SetCacheParent", "PartCache.new"))
	local v33 = p31:IsDescendantOf(workspace) or p31 == workspace
	assert(v33, "Cache parent is not a descendant of Workspace! Parts should be kept where they will remain in the visible world.")
	p30.CurrentCacheParent = p31
	for v34 = 1, #p30.Open do
		p30.Open[v34].Parent = p31
	end
	for v35 = 1, #p30.InUse do
		p30.InUse[v35].Parent = p31
	end
end
function v_u_2.Expand(p36, p37) -- name: Expand
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_3
	local v38 = getmetatable(p36) == v_u_2
	assert(v38, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Expand", "PartCache.new"))
	if p37 == nil then
		p37 = p36.ExpansionSize
	end
	for _ = 1, p37 do
		local v39 = v_u_1.insert
		local v40 = p36.Open
		local v41 = p36.Template
		local v42 = p36.CurrentCacheParent
		local v43 = v41:Clone()
		v43.CFrame = v_u_3
		v43.Anchored = true
		v43.Parent = v42
		v39(v40, v43)
	end
end
function v_u_2.Dispose(p44) -- name: Dispose
	-- upvalues: (copy) v_u_2
	local v45 = getmetatable(p44) == v_u_2
	assert(v45, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Dispose", "PartCache.new"))
	for v46 = 1, #p44.Open do
		p44.Open[v46]:Destroy()
	end
	for v47 = 1, #p44.InUse do
		p44.InUse[v47]:Destroy()
	end
	p44.Template:Destroy()
	p44.Open = {}
	p44.InUse = {}
	p44.CurrentCacheParent = nil
	p44.GetPart = nil
	p44.ReturnPart = nil
	p44.SetCacheParent = nil
	p44.Expand = nil
	p44.Dispose = nil
end
return v_u_2