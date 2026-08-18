local v_u_1 = require(script.Parent.Spawn)
local function v_u_3(p2) -- name: IsComplete
	return p2.ValueList ~= nil
end
local function v_u_5(p4) -- name: IsPending
	return p4.ValueList == nil
end
local function v_u_10(p6, p7) -- name: Expect
	local v8 = p6.ValueList
	assert(v8, p7)
	local v9 = p6.ValueList
	return table.unpack(v9)
end
local function v_u_12(p11) -- name: Unwrap
	return p11:Expect("Attempt to unwrap pending future!")
end
local function v_u_15(p13, ...) -- name: UnwrapOr
	if not p13.ValueList then
		return ...
	end
	local v14 = p13.ValueList
	return table.unpack(v14)
end
local function v_u_19(p16, p17) -- name: UnwrapOrElse
	if not p16.ValueList then
		return p17()
	end
	local v18 = p16.ValueList
	return table.unpack(v18)
end
local function v_u_25(p20, p21) -- name: After
	-- upvalues: (copy) v_u_1
	if p20.ValueList then
		local v22 = v_u_1
		local v23 = p20.ValueList
		v22(p21, table.unpack(v23))
	else
		local v24 = p20.AfterList
		table.insert(v24, p21)
	end
end
local function v_u_30(p26) -- name: Await
	if p26.ValueList then
		local v27 = p26.ValueList
		return table.unpack(v27)
	end
	local v28 = p26.YieldList
	local v29 = coroutine.running
	table.insert(v28, v29())
	return coroutine.yield()
end
local function v_u_38(p31, ...) -- name: Future
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_10, (copy) v_u_12, (copy) v_u_15, (copy) v_u_19, (copy) v_u_25, (copy) v_u_30, (copy) v_u_1
	local v32 = {
		["ValueList"] = nil,
		["AfterList"] = nil,
		["YieldList"] = nil,
		["IsComplete"] = nil,
		["IsPending"] = nil,
		["Expect"] = nil,
		["Unwrap"] = nil,
		["UnwrapOr"] = nil,
		["UnwrapOrElse"] = nil,
		["After"] = nil,
		["Await"] = nil,
		["AfterList"] = {},
		["YieldList"] = {},
		["IsComplete"] = v_u_3,
		["IsPending"] = v_u_5,
		["Expect"] = v_u_10,
		["Unwrap"] = v_u_12,
		["UnwrapOr"] = v_u_15,
		["UnwrapOrElse"] = v_u_19,
		["After"] = v_u_25,
		["Await"] = v_u_30
	}
	v_u_1(function(p33, p34, ...)
		-- upvalues: (ref) v_u_1
		local v35 = { p34(...) }
		p33.ValueList = v35
		for _, v36 in p33.YieldList do
			task.spawn(v36, table.unpack(v35))
		end
		for _, v37 in p33.AfterList do
			v_u_1(v37, table.unpack(v35))
		end
	end, v32, p31, ...)
	return v32
end
return {
	["new"] = v_u_38,
	["Try"] = function(p39, ...) -- name: Try
		-- upvalues: (copy) v_u_38
		return v_u_38(pcall, p39, ...)
	end
}