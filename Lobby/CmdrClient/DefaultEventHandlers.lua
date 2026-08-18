local v_u_1 = game:GetService("StarterGui")
local v_u_2 = require("./CmdrInterface/Window")
return function(p3)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	p3:HandleEvent("Message", function(p4)
		-- upvalues: (ref) v_u_1
		v_u_1:SetCore("ChatMakeSystemMessage", {
			["Text"] = ("[Announcement] %s"):format(p4),
			["Color"] = Color3.fromRGB(249, 217, 56)
		})
	end)
	p3:HandleEvent("AddLine", function(...)
		-- upvalues: (ref) v_u_2
		v_u_2:AddLine(...)
	end)
end