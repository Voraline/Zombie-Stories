local v_u_1 = game:GetService("CollectionService")
require("./types/fusion")
local v_u_2 = require(script.Parent.utils["lock-value"])
local v_u_3 = require(script.Parent["use-event-listener"])
return function(p4, p5) -- name: useTagged
	-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_2
	local v_u_6 = p4.peek
	local v_u_7 = p4:Value(v_u_1:GetTagged(p5))
	v_u_3(p4, v_u_1:GetInstanceAddedSignal(p5), function(p8)
		-- upvalues: (copy) v_u_6, (copy) v_u_7
		local v9 = table.clone(v_u_6(v_u_7))
		table.insert(v9, p8)
		v_u_7:set(v9)
	end)
	v_u_3(p4, v_u_1:GetInstanceRemovedSignal(p5), function(p10)
		-- upvalues: (copy) v_u_6, (copy) v_u_7
		local v11 = table.clone(v_u_6(v_u_7))
		local v12 = table.find(v11, p10)
		if v12 then
			table.remove(v11, v12)
		end
		v_u_7:set(v11)
	end)
	return v_u_2(v_u_7)
end