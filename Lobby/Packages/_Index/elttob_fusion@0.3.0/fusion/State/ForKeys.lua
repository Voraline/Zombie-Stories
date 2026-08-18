local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.doCleanup)
local v_u_4 = require(v1.State.For)
local v_u_5 = require(v1.State.Value)
local v_u_6 = require(v1.State.Computed)
require(v1.State.For.ForTypes)
local v_u_7 = require(v1.Logging.parseError)
local v_u_11 = {
	["__index"] = {
		["roamKeys"] = false,
		["roamValues"] = true,
		["invalidateInputKey"] = nil,
		["invalidateInputValue"] = nil,
		["useOutputPair"] = nil,
		["invalidateInputKey"] = function(p8) -- name: invalidateInputKey
			p8._inputKeyState:set(p8.inputKey)
		end,
		["invalidateInputValue"] = function(_) -- name: invalidateInputValue end,
		["useOutputPair"] = function(p9, p10) -- name: useOutputPair
			return p10(p9._outputKeyState), p9.inputValue
		end
	}
}
local function v_u_23(p12, p13, p14, p15) -- name: SubObject
	-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (copy) v_u_2, (copy) v_u_3, (copy) v_u_11
	local v_u_16 = {
		["maybeScope"] = p12,
		["inputKey"] = p13,
		["inputValue"] = p14,
		["_inputKeyState"] = v_u_5(p12, p13),
		["_processor"] = p15
	}
	v_u_16._outputKeyState = v_u_6(p12, function(p17, p18)
		-- upvalues: (copy) v_u_16, (ref) v_u_7, (ref) v_u_2, (ref) v_u_3
		local v19 = p17(v_u_16._inputKeyState)
		local v20, v21 = xpcall(v_u_16._processor, v_u_7, p17, p18, v19)
		if v20 then
			return v21
		end
		v21.context = ("while processing key %*"):format((tostring(v19)))
		v_u_2.logErrorNonFatal("callbackError", v21)
		v_u_3(p18)
		table.clear(p18)
		return nil
	end)
	local v22 = v_u_11
	return setmetatable(v_u_16, v22)
end
return function(p24, p25, p_u_26, p27) -- name: ForKeys
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_23
	if typeof(p25) == "function" then
		v_u_2.logError("scopeMissing", nil, "ForKeys", "myScope:ForKeys(inputTable, function(scope, use, key) ... end)")
	elseif p27 ~= nil then
		v_u_2.logWarn("destructorRedundant", "ForKeys")
	end
	return v_u_4(p24, p25, function(p28, p29, p30)
		-- upvalues: (ref) v_u_23, (copy) p_u_26
		return v_u_23(p28, p29, p30, p_u_26)
	end)
end