local v1 = script.Parent.Parent
require(v1.PubTypes)
local v_u_2 = require(v1.Utility.cleanup)
local v_u_3 = require(v1.Utility.xtypeof)
local v_u_4 = require(v1.Logging.logError)
local v_u_5 = require(v1.State.Observer)
local function v_u_9(p6, p7, p8) -- name: setProperty_unsafe
	p6[p7] = p8
end
local function v_u_12(p10, p11) -- name: testPropertyAssignable
	p10[p11] = p10[p11]
end
local function v_u_19(p13, p14, p15) -- name: setProperty
	-- upvalues: (copy) v_u_9, (copy) v_u_12, (copy) v_u_4
	if not pcall(v_u_9, p13, p14, p15) then
		if not pcall(v_u_12, p13, p14) then
			if p13 == nil then
				v_u_4("setPropertyNilRef", nil, p14, (tostring(p15)))
			else
				v_u_4("cannotAssignProperty", nil, p13.ClassName, p14)
			end
		end
		local v16 = typeof(p15)
		local v17 = p13[p14]
		local v18 = typeof(v17)
		v_u_4("invalidPropertyType", nil, p13.ClassName, p14, v18, v16)
	end
end
local function v_u_27(p_u_20, p_u_21, p_u_22, p23) -- name: bindProperty
	-- upvalues: (copy) v_u_3, (copy) v_u_19, (copy) v_u_5
	if v_u_3(p_u_22) == "State" then
		local v_u_24 = false
		local function v25() -- name: updateLater
			-- upvalues: (ref) v_u_24, (ref) v_u_19, (copy) p_u_20, (copy) p_u_21, (copy) p_u_22
			if not v_u_24 then
				v_u_24 = true
				task.defer(function()
					-- upvalues: (ref) v_u_24, (ref) v_u_19, (ref) p_u_20, (ref) p_u_21, (ref) p_u_22
					v_u_24 = false
					v_u_19(p_u_20, p_u_21, p_u_22:get(false))
				end)
			end
		end
		v_u_19(p_u_20, p_u_21, p_u_22:get(false))
		local v26 = v_u_5(p_u_22)
		table.insert(p23, v26:onChange(v25))
	else
		v_u_19(p_u_20, p_u_21, p_u_22)
	end
end
return function(p28, p29) -- name: applyInstanceProps
	-- upvalues: (copy) v_u_3, (copy) v_u_27, (copy) v_u_4, (copy) v_u_2
	local v30 = {
		["self"] = {},
		["descendants"] = {},
		["ancestor"] = {},
		["observer"] = {}
	}
	local v_u_31 = {}
	for v32, v33 in pairs(p28) do
		local v34 = v_u_3(v32)
		if v34 == "string" then
			if v32 ~= "Parent" then
				v_u_27(p29, v32, v33, v_u_31)
			end
		elseif v34 == "SpecialKey" then
			local v35 = v32.stage
			local v36 = v30[v35]
			if v36 == nil then
				v_u_4("unrecognisedPropertyStage", nil, v35)
			else
				v36[v32] = v33
			end
		else
			v_u_4("unrecognisedPropertyKey", nil, v_u_3(v32))
		end
	end
	for v37, v38 in pairs(v30.self) do
		v37:apply(v38, p29, v_u_31)
	end
	for v39, v40 in pairs(v30.descendants) do
		v39:apply(v40, p29, v_u_31)
	end
	if p28.Parent ~= nil then
		v_u_27(p29, "Parent", p28.Parent, v_u_31)
	end
	for v41, v42 in pairs(v30.ancestor) do
		v41:apply(v42, p29, v_u_31)
	end
	for v43, v44 in pairs(v30.observer) do
		v43:apply(v44, p29, v_u_31)
	end
	p29.Destroying:Connect(function()
		-- upvalues: (ref) v_u_2, (copy) v_u_31
		v_u_2(v_u_31)
	end)
end