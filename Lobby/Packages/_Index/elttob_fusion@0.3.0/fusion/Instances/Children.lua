local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.Observer)
local v_u_4 = require(v1.State.peek)
local v_u_5 = require(v1.State.castToState)
local v_u_6 = require(v1.Memory.doCleanup)
return {
	["type"] = "SpecialKey",
	["kind"] = "Children",
	["stage"] = "descendants",
	["apply"] = nil,
	["apply"] = function(_, p7, p_u_8, p_u_9) -- name: apply
		-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_3, (copy) v_u_2, (copy) v_u_6
		local v_u_10 = {}
		local v_u_11 = {}
		local v_u_12 = {}
		local v_u_13 = {}
		local function v_u_28() -- name: updateChildren
			-- upvalues: (ref) v_u_11, (ref) v_u_10, (ref) v_u_13, (ref) v_u_12, (copy) p_u_9, (ref) v_u_5, (ref) v_u_4, (ref) v_u_3, (copy) v_u_28, (ref) v_u_2, (ref) p_u_8, (ref) v_u_6
			local v14 = v_u_11
			v_u_11 = v_u_10
			v_u_10 = v14
			local v15 = v_u_13
			v_u_13 = v_u_12
			v_u_12 = v15
			local function v_u_25(p16, p17) -- name: processChild
				-- upvalues: (ref) v_u_10, (ref) v_u_11, (ref) p_u_9, (ref) v_u_5, (ref) v_u_4, (copy) v_u_25, (ref) v_u_13, (ref) v_u_3, (ref) v_u_28, (ref) v_u_12, (ref) v_u_2
				local v18 = typeof(p16)
				if v18 == "Instance" then
					v_u_10[p16] = true
					if v_u_11[p16] == nil then
						p16.Parent = p_u_9
					else
						v_u_11[p16] = nil
					end
				elseif v_u_5(p16) then
					local v19 = v_u_4(p16)
					if v19 ~= nil then
						v_u_25(v19, p17)
					end
					local v20 = v_u_13[p16]
					if v20 == nil then
						v20 = {}
						v_u_3(v20, p16):onChange(v_u_28)
					else
						v_u_13[p16] = nil
					end
					v_u_12[p16] = v20
					return
				elseif v18 == "table" then
					for v21, v22 in pairs(p16) do
						local v23 = typeof(v21)
						local v24 = nil
						if v23 == "string" then
							v24 = v21
						elseif v23 == "number" and p17 ~= nil then
							v24 = p17 .. "_" .. v21
						end
						v_u_25(v22, v24)
					end
				else
					v_u_2.logWarn("unrecognisedChildType", v18)
				end
			end
			if p_u_8 ~= nil then
				v_u_25(p_u_8)
			end
			for v26 in pairs(v_u_11) do
				v26.Parent = nil
			end
			table.clear(v_u_11)
			for _, v27 in pairs(v_u_13) do
				v_u_6(v27)
			end
			table.clear(v_u_13)
		end
		table.insert(p7, function()
			-- upvalues: (ref) p_u_8, (copy) v_u_28
			p_u_8 = nil
			v_u_28()
		end)
		v_u_28()
	end
}