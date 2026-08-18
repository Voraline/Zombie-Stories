local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
require("../Types")
local v_u_3 = require("../Utilities/Output")
local v_u_4 = nil
local v_u_5 = {}
local v_u_6 = {}
local v_u_7 = {}
local v_u_25 = {
	["start"] = function() -- name: start
		-- upvalues: (ref) v_u_4, (copy) v_u_1, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (copy) v_u_25
		v_u_4 = v_u_1:WaitForChild("identifierStorage")
		for v8, v9 in v_u_4:GetAttributes() do
			v_u_5[v8] = v9
			v_u_6[v9] = v8
		end
		v_u_4.AttributeChanged:Connect(function(p10)
			-- upvalues: (ref) v_u_4, (ref) v_u_7, (ref) v_u_5, (ref) v_u_6
			local v11 = v_u_4:GetAttribute(p10)
			if v11 then
				local v12 = v_u_7[p10]
				if v12 then
					for v13 in v12 do
						task.spawn(v13, v11)
					end
					v_u_7[p10] = nil
				end
				v_u_5[p10] = v11
				v_u_6[v11] = p10
			else
				local v14 = v_u_5[p10]
				v_u_5[p10] = nil
				v_u_6[v14] = nil
			end
		end)
		v_u_25.ref("NIL_VALUE")
	end,
	["ref"] = function(p15, p16) -- name: ref
		-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7
		v_u_3.typecheck("string", "ReferenceIdentifier", "identifierName", p15)
		if v_u_2:IsStudio() then
			v_u_5[p15] = p15
			v_u_6[p15] = p15
			return p15
		end
		if p16 ~= nil then
			v_u_3.typecheck("number", "ReferenceIdentifier", "maxWaitTime", p16)
		end
		local v17 = p16 or 1
		local v18 = v_u_5[p15]
		if v18 then
			return v18
		end
		local v_u_19 = coroutine.running()
		local v_u_20 = v_u_7[p15]
		if v_u_20 then
			v_u_20[v_u_19] = true
		else
			v_u_20 = {
				[v_u_19] = true
			}
			v_u_7[p15] = v_u_20
		end
		local v21 = task.delay(v17, function()
			-- upvalues: (ref) v_u_20, (copy) v_u_19
			v_u_20[v_u_19] = nil
			task.spawn(v_u_19, nil)
		end)
		local v22 = coroutine.yield()
		if v22 == nil then
			v_u_3.fatal((("reached max wait time for identifier %*, broke yield. Did you forget to implement it on the server?"):format(p15)))
		else
			task.cancel(v21)
		end
		return v22
	end,
	["deser"] = function(p23) -- name: deser
		-- upvalues: (copy) v_u_3, (copy) v_u_6
		v_u_3.fatalAssert(typeof(p23) == "string", string.format("Deserialize takes string, got %*", (typeof(p23))))
		return v_u_6[p23]
	end,
	["ser"] = function(p24) -- name: ser
		-- upvalues: (copy) v_u_3, (copy) v_u_5
		v_u_3.fatalAssert(typeof(p24) == "string", string.format("Serialize takes string, got %*", (typeof(p24))))
		return v_u_5[p24]
	end
}
return v_u_25