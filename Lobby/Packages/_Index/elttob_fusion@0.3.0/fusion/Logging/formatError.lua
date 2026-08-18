local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Logging.messages)
return function(p3, p4, p5, ...) -- name: formatError
	-- upvalues: (copy) v_u_2
	local v6
	if typeof(p5) == "table" then
		v6 = p5
	else
		v6 = nil
	end
	if typeof(p5) == "table" then
		p5 = p5.trace
	end
	local v7 = v_u_2[p4]
	local v8
	if v7 == nil then
		v8 = "unknownMessage"
		v7 = v_u_2[v8]
	else
		v8 = p4
	end
	local v9 = v7:format(...)
	local v10
	if v6 == nil then
		v10 = v9:gsub("ERROR_MESSAGE", p4)
	else
		v10 = v9:gsub("ERROR_MESSAGE", v6.message)
		if v6.context ~= nil then
			v10 = v10 .. (" (%*)"):format(v6.context)
		end
	end
	local v11 = ("[Fusion] %* \nID: %*"):format(v10, v8)
	if p3 ~= nil and p3.policies.allowWebLinks then
		v11 = v11 .. ("\nLearn more: https://elttob.uk/Fusion/0.3/api-reference/general/errors/#%*"):format((v8:lower()))
	end
	if p5 ~= nil then
		v11 = v11 .. (" \n---- Stack trace ----\n%*"):format(p5)
	end
	return v11:gsub("\n", "\n    ")
end