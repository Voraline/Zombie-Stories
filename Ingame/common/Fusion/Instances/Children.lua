local v1 = script.Parent.Parent
require(v1.PubTypes)
local v_u_2 = require(v1.Logging.logWarn)
local v_u_3 = require(v1.State.Observer)
local v_u_4 = require(v1.Utility.xtypeof)
return {
	["type"] = "SpecialKey",
	["kind"] = "Children",
	["stage"] = "descendants",
	["apply"] = function(_, p_u_5, p_u_6, p7) -- name: apply
		-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_2
		local v_u_8 = {}
		local v_u_9 = {}
		local v_u_10 = {}
		local v_u_11 = {}
		local v_u_12 = false
		local v_u_13 = nil
		local function v_u_28() -- name: updateChildren
			-- upvalues: (ref) v_u_12, (ref) v_u_9, (ref) v_u_8, (ref) v_u_11, (ref) v_u_10, (ref) v_u_4, (copy) p_u_6, (ref) v_u_3, (ref) v_u_13, (ref) v_u_2, (ref) p_u_5
			if v_u_12 then
				v_u_12 = false
				local v14 = v_u_9
				v_u_9 = v_u_8
				v_u_8 = v14
				local v15 = v_u_11
				v_u_11 = v_u_10
				v_u_10 = v15
				table.clear(v_u_8)
				table.clear(v_u_10)
				local function v_u_25(p16, p17) -- name: processChild
					-- upvalues: (ref) v_u_4, (ref) v_u_8, (ref) v_u_9, (ref) p_u_6, (copy) v_u_25, (ref) v_u_11, (ref) v_u_3, (ref) v_u_13, (ref) v_u_10, (ref) v_u_2
					local v18 = v_u_4(p16)
					if v18 == "Instance" then
						v_u_8[p16] = true
						if v_u_9[p16] == nil then
							p16.Parent = p_u_6
						else
							v_u_9[p16] = nil
						end
					elseif v18 == "State" then
						local v19 = p16:get(false)
						if v19 ~= nil then
							v_u_25(v19, p17)
						end
						local v20 = v_u_11[p16]
						if v20 == nil then
							v20 = v_u_3(p16):onChange(v_u_13)
						else
							v_u_11[p16] = nil
						end
						v_u_10[p16] = v20
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
						v_u_2("unrecognisedChildType", v18)
					end
				end
				if p_u_5 ~= nil then
					v_u_25(p_u_5)
				end
				for v26 in pairs(v_u_9) do
					v26.Parent = nil
				end
				for _, v27 in pairs(v_u_11) do
					v27()
				end
			end
		end
		v_u_13 = function()
			-- upvalues: (ref) v_u_12, (copy) v_u_28
			if not v_u_12 then
				v_u_12 = true
				task.defer(v_u_28)
			end
		end
		local function v29()
			-- upvalues: (ref) p_u_5, (ref) v_u_12, (copy) v_u_28
			p_u_5 = nil
			v_u_12 = true
			v_u_28()
		end
		table.insert(p7, v29)
		v_u_12 = true
		v_u_28()
	end
}