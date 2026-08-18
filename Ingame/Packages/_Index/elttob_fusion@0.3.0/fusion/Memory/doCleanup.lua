local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.scopePool)
local v_u_4 = require(v1.Memory.poisonScope)
local v_u_5 = {}
local function v_u_10(p6) -- name: doCleanup
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_10, (copy) v_u_3, (copy) v_u_4
	if v_u_5[p6] then
		return v_u_2.logError("destroyedTwice")
	end
	v_u_5[p6] = true
	if typeof(p6) == "Instance" then
		p6:Destroy()
	elseif typeof(p6) == "RBXScriptConnection" then
		p6:Disconnect()
	elseif typeof(p6) == "function" then
		p6()
	elseif typeof(p6) == "table" then
		local v7 = p6.destroy
		if typeof(v7) == "function" then
			p6:destroy()
		else
			local v8 = p6.Destroy
			if typeof(v8) == "function" then
				p6:Destroy()
			elseif p6[1] ~= nil then
				for v9 = #p6, 1, -1 do
					v_u_10(p6[v9])
					p6[v9] = nil
				end
				if v_u_2.isTimeCritical() then
					v_u_3.giveIfEmpty(p6)
				else
					v_u_4(p6, "`doCleanup()` was previously called on this scope. Ensure you are not reusing scopes after cleanup.")
				end
			end
		end
	end
	v_u_5[p6] = nil
end
return v_u_10