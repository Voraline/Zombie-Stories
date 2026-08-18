local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Logging.parseError)
local v_u_4 = require(v1.Memory.checkLifetime)
local v_u_5 = require(v1.Graph.Observer)
local v_u_6 = require(v1.State.castToState)
local v_u_7 = require(v1.State.peek)
local v_u_8 = require(v1.Utility.xtypeof)
local function v_u_12(p9, p10, p11) -- name: setProperty_unsafe
	p9[p10] = p11
end
local function v_u_15(p13, p14) -- name: testPropertyAssignable
	p13[p14] = p13[p14]
end
local function v_u_24(p16, p17, p18) -- name: setProperty
	-- upvalues: (copy) v_u_12, (copy) v_u_3, (copy) v_u_15, (copy) v_u_2
	local v19, v20 = xpcall(v_u_12, v_u_3, p16, p17, p18)
	if not v19 then
		if not pcall(v_u_15, p16, p17) then
			v_u_2.logErrorNonFatal("cannotAssignProperty", nil, p16.ClassName, p17)
			return
		end
		local v21 = typeof(p18)
		local v22 = p16[p17]
		local v23 = typeof(v22)
		if v21 == v23 then
			v_u_2.logErrorNonFatal("propertySetError", v20)
			return
		end
		v_u_2.logErrorNonFatal("invalidPropertyType", nil, p16.ClassName, p17, v23, v21)
	end
end
local function v_u_29(p25, p_u_26, p_u_27, p_u_28) -- name: bindProperty
	-- upvalues: (copy) v_u_6, (copy) v_u_4, (copy) v_u_5, (copy) v_u_24, (copy) v_u_7
	if v_u_6(p_u_28) then
		v_u_4.bOutlivesA(p25, p_u_26, p_u_28.scope, p_u_28.oldestTask, v_u_4.formatters.boundProperty, p_u_27)
		v_u_5(p25, p_u_28):onBind(function()
			-- upvalues: (ref) v_u_24, (copy) p_u_26, (copy) p_u_27, (ref) v_u_7, (copy) p_u_28
			v_u_24(p_u_26, p_u_27, v_u_7(p_u_28))
		end)
	else
		v_u_24(p_u_26, p_u_27, p_u_28)
	end
end
return function(p30, p31, p32) -- name: applyInstanceProps
	-- upvalues: (copy) v_u_8, (copy) v_u_29, (copy) v_u_2
	local v33 = {
		["self"] = {},
		["descendants"] = {},
		["ancestor"] = {},
		["observer"] = {}
	}
	for v34, v35 in pairs(p31) do
		local v36 = v_u_8(v34)
		if v36 == "string" then
			if v34 ~= "Parent" then
				v_u_29(p30, p32, v34, v35)
			end
		elseif v36 == "SpecialKey" then
			local v37 = v34.stage
			local v38 = v33[v37]
			if v38 == nil then
				v_u_2.logError("unrecognisedPropertyStage", nil, v37)
			else
				v38[v34] = v35
			end
		else
			v_u_2.logError("unrecognisedPropertyKey", nil, v36)
		end
	end
	for v39, v40 in pairs(v33.self) do
		v39:apply(p30, v40, p32)
	end
	for v41, v42 in pairs(v33.descendants) do
		v41:apply(p30, v42, p32)
	end
	if p31.Parent ~= nil then
		v_u_29(p30, p32, "Parent", p31.Parent)
	end
	for v43, v44 in pairs(v33.ancestor) do
		v43:apply(p30, v44, p32)
	end
	for v45, v46 in pairs(v33.observer) do
		v45:apply(p30, v46, p32)
	end
end