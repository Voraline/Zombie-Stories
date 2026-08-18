local v1 = script.Parent
local v_u_2 = require(v1.Logging.formatError)
require(v1.Types)
local v_u_3 = {
	["safetyTimerMultiplier"] = 1
}
local v_u_4 = {}
local v_u_5 = nil
local v_u_6 = 0
function v_u_3.setExternalProvider(p7) -- name: setExternalProvider
	-- upvalues: (ref) v_u_5
	local v8 = v_u_5
	if v8 ~= nil then
		v8.stopScheduler()
	end
	v_u_5 = p7
	if p7 ~= nil then
		p7.startScheduler()
	end
	return v8
end
function v_u_3.isTimeCritical() -- name: isTimeCritical
	return false
end
function v_u_3.doTaskImmediate(p9) -- name: doTaskImmediate
	-- upvalues: (ref) v_u_5, (copy) v_u_3
	if v_u_5 == nil then
		v_u_3.logError("noTaskScheduler")
	else
		v_u_5.doTaskImmediate(p9)
	end
end
function v_u_3.doTaskDeferred(p10) -- name: doTaskDeferred
	-- upvalues: (ref) v_u_5, (copy) v_u_3
	if v_u_5 == nil then
		v_u_3.logError("noTaskScheduler")
	else
		v_u_5.doTaskDeferred(p10)
	end
end
function v_u_3.logError(p11, p12, ...) -- name: logError
	-- upvalues: (copy) v_u_2, (ref) v_u_5
	error(v_u_2(v_u_5, p11, p12, ...), 0)
end
function v_u_3.logErrorNonFatal(p13, p14, ...) -- name: logErrorNonFatal
	-- upvalues: (copy) v_u_2, (ref) v_u_5
	local v15 = v_u_2(v_u_5, p13, p14, ...)
	if v_u_5 == nil then
		print(v15)
	else
		v_u_5.logErrorNonFatal(v15)
	end
end
function v_u_3.logWarn(p16, ...) -- name: logWarn
	-- upvalues: (copy) v_u_2, (ref) v_u_5
	local v17 = v_u_2(v_u_5, p16, debug.traceback(nil, 2), ...)
	if v_u_5 == nil then
		print(v17)
	else
		v_u_5.logWarn(v17)
	end
end
function v_u_3.bindToUpdateStep(p18) -- name: bindToUpdateStep
	-- upvalues: (copy) v_u_4
	local v_u_19 = {}
	v_u_4[v_u_19] = p18
	return function()
		-- upvalues: (ref) v_u_4, (copy) v_u_19
		v_u_4[v_u_19] = nil
	end
end
function v_u_3.performUpdateStep(p20) -- name: performUpdateStep
	-- upvalues: (ref) v_u_6, (copy) v_u_4
	v_u_6 = p20
	for _, v21 in v_u_4 do
		v21(p20)
	end
end
function v_u_3.lastUpdateStep() -- name: lastUpdateStep
	-- upvalues: (ref) v_u_6
	return v_u_6
end
return v_u_3