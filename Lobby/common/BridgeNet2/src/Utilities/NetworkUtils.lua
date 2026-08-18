local v_u_1 = game:GetService("HttpService")
local v_u_2 = require("./Output")
return {
	["CreateUUID"] = function() -- name: CreateUUID
		-- upvalues: (copy) v_u_1
		return string.gsub(v_u_1:GenerateGUID(false), "-", "")
	end,
	["FromHex"] = function(p3) -- name: FromHex
		return string.gsub(p3, "..", function(p4)
			local v5 = tonumber(p4, 16)
			return string.char(v5)
		end)
	end,
	["ToHex"] = function(p6) -- name: ToHex
		-- upvalues: (copy) v_u_2
		v_u_2.fatalAssert(typeof(p6) == "string", (("ToHex takes string, got %*"):format(p6)))
		return string.gsub(p6, ".", function(p7)
			return string.format("%02X", string.byte(p7))
		end)
	end,
	["ToReadableHex"] = function(p8) -- name: ToReadableHex
		-- upvalues: (copy) v_u_2
		v_u_2.fatalAssert(typeof(p8) == "string", (("ToReadableHex takes string, got %*"):format(p8)))
		return string.format(string.rep("%02X ", #p8), string.byte(p8, 1, -1))
	end,
	["NumberToBestForm"] = function(p9) -- name: NumberToBestForm
		local v10 = tostring(p9)
		if #v10 <= 7 then
			return v10
		else
			return p9
		end
	end
}