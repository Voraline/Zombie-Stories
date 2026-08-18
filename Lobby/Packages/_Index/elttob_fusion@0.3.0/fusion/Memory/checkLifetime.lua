local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.whichLivesLonger)
local v_u_4 = require(v1.Utility.nameOf)
local v5 = {
	["formatters"] = {}
}
function v5.formatters.useFunction(p6, p7) -- name: useFunction
	-- upvalues: (copy) v_u_4
	local v8 = v_u_4(p6, "object")
	return ("The use()-d %*"):format((v_u_4(p7, "object"))), ("the %*"):format(v8)
end
function v5.formatters.boundProperty(p9, p10, p11) -- name: boundProperty
	-- upvalues: (copy) v_u_4
	local v12 = p9.Name
	return ("The %* (bound to the %* property)"):format(v_u_4(p10, "value"), p11), ("the %* instance"):format(v12)
end
function v5.formatters.boundAttribute(p13, p14, p15) -- name: boundAttribute
	-- upvalues: (copy) v_u_4
	local v16 = p13.Name
	return ("The %* (bound to the %* attribute)"):format(v_u_4(p14, "value"), p15), ("the %* instance"):format(v16)
end
function v5.formatters.propertyOutputsTo(p17, p18, p19) -- name: propertyOutputsTo
	-- upvalues: (copy) v_u_4
	local v20 = p17.Name
	return ("The %* (which the %* property outputs to)"):format(v_u_4(p18, "object"), p19), ("the %* instance"):format(v20)
end
function v5.formatters.attributeOutputsTo(p21, p22, p23) -- name: attributeOutputsTo
	-- upvalues: (copy) v_u_4
	local v24 = p21.Name
	return ("The %* (which the %* attribute outputs to)"):format(v_u_4(p22, "object"), p23), ("the %* instance"):format(v24)
end
function v5.formatters.refOutputsTo(p25, p26) -- name: refOutputsTo
	-- upvalues: (copy) v_u_4
	local v27 = p25.Name
	return ("The %* (which the Ref key outputs to)"):format((v_u_4(p26, "object"))), ("the %* instance"):format(v27)
end
function v5.formatters.animationGoal(p28, p29) -- name: animationGoal
	-- upvalues: (copy) v_u_4
	local v30 = v_u_4(p28, "object")
	return ("The goal %*"):format((v_u_4(p29, "object"))), ("the %* that is following it"):format(v30)
end
function v5.formatters.parameter(p31, p32, p33) -- name: parameter
	-- upvalues: (copy) v_u_4
	local v34 = v_u_4(p31, "object")
	local v35 = v_u_4(p32, "object")
	if p33 == false then
		return ("The %* parameter"):format(v35), ("the %* that it was used for"):format(v34)
	else
		return ("The %* representing the %* parameter"):format(v35, p33), ("the %* that it was used for"):format(v34)
	end
end
function v5.formatters.observer(p36, p37) -- name: observer
	-- upvalues: (copy) v_u_4
	local v38 = v_u_4(p36, "object")
	return ("The watched %*"):format((v_u_4(p37, "object"))), ("the %* that\'s observing it for changes"):format(v38)
end
function v5.bOutlivesA(p39, p40, p41, p42, p43, ...) -- name: bOutlivesA
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	if p41 == nil then
		v_u_2.logError("useAfterDestroy", nil, p43(p40, p42, ...))
	elseif v_u_3(p39, p40, p41, p42) == "definitely-a" then
		local v44, v45 = p43(p40, p42, ...)
		v_u_2.logWarn("possiblyOutlives", v44, v45, p39 == p41 and "they\'re in the same scope, but the latter is destroyed too quickly" or "the latter is in a different scope that gets destroyed too quickly")
	end
end
return v5