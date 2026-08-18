local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.State.For)
local v_u_4 = require(v1.State.Value)
local v_u_5 = require(v1.State.Computed)
require(v1.State.For.ForTypes)
local v_u_6 = require(v1.Logging.parseError)
local v_u_7 = require(v1.Memory.doCleanup)
local v_u_13 = {
	["__index"] = {
		["roamKeys"] = false,
		["roamValues"] = false,
		["invalidateInputKey"] = nil,
		["invalidateInputValue"] = nil,
		["useOutputPair"] = nil,
		["invalidateInputKey"] = function(p8) -- name: invalidateInputKey
			p8._inputKeyState:set(p8.inputKey)
		end,
		["invalidateInputValue"] = function(p9) -- name: invalidateInputValue
			p9._inputValueState:set(p9.inputValue)
		end,
		["useOutputPair"] = function(p10, p11) -- name: useOutputPair
			local v12 = p11(p10._outputPairState)
			return v12.key, v12.value
		end
	}
}
local function v_u_27(p14, p15, p16, p17) -- name: SubObject
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_2, (copy) v_u_7, (copy) v_u_13
	local v_u_18 = {
		["maybeScope"] = p14,
		["inputKey"] = p15,
		["inputValue"] = p16,
		["_inputKeyState"] = v_u_4(p14, p15),
		["_inputValueState"] = v_u_4(p14, p16),
		["_processor"] = p17
	}
	v_u_18._outputPairState = v_u_5(p14, function(p19, p20)
		-- upvalues: (copy) v_u_18, (ref) v_u_6, (ref) v_u_2, (ref) v_u_7
		local v21 = p19(v_u_18._inputKeyState)
		local v22 = p19(v_u_18._inputValueState)
		local v23, v24, v25 = xpcall(v_u_18._processor, v_u_6, p19, p20, v21, v22)
		if v23 then
			return {
				["key"] = v24,
				["value"] = v25
			}
		end
		v24.context = ("while processing key %* and value %*"):format(tostring(v22), (tostring(v22)))
		v_u_2.logErrorNonFatal("callbackError", v24)
		v_u_7(p20)
		table.clear(p20)
		return {
			["key"] = nil,
			["value"] = nil
		}
	end)
	local v26 = v_u_13
	return setmetatable(v_u_18, v26)
end
return function(p28, p29, p_u_30, p31) -- name: ForPairs
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_27
	if typeof(p29) == "function" then
		v_u_2.logError("scopeMissing", nil, "ForPairs", "myScope:ForPairs(inputTable, function(scope, use, key, value) ... end)")
	elseif p31 ~= nil then
		v_u_2.logWarn("destructorRedundant", "ForPairs")
	end
	return v_u_3(p28, p29, function(p32, p33, p34)
		-- upvalues: (ref) v_u_27, (copy) p_u_30
		return v_u_27(p32, p33, p34, p_u_30)
	end)
end