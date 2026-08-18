local v_u_1 = game:GetService("RunService")
local v_u_2 = v_u_1:IsServer() and "[BridgeNet2:S]: " or "[BridgeNet2:C]: "
local v_u_18 = {
	["silent"] = function(p3) -- name: silent
		-- upvalues: (copy) v_u_1, (copy) v_u_2
		if v_u_1:IsStudio() then
			print((("%*%*"):format(v_u_2, p3)))
		end
	end,
	["log"] = function(p4) -- name: log
		-- upvalues: (copy) v_u_2
		print((("%*%*"):format(v_u_2, p4)))
	end,
	["logAssert"] = function(p5, p6) -- name: logAssert
		-- upvalues: (copy) v_u_18
		if not p5 then
			v_u_18.log(p6)
		end
	end,
	["warn"] = function(p7) -- name: warn
		-- upvalues: (copy) v_u_2
		warn((("%*%*"):format(v_u_2, p7)))
	end,
	["warnAssert"] = function(p8, p9) -- name: warnAssert
		-- upvalues: (copy) v_u_18
		if not p8 then
			v_u_18.warn(p9)
		end
	end,
	["typecheck"] = function(p10, p11, p12, p13) -- name: typecheck
		-- upvalues: (copy) v_u_2
		local v14 = typeof(p13)
		if v14 ~= p10 then
			error(("%*%* parameter %* takes %*, got %*"):format(v_u_2, p11, p12, p10, v14), 0)
		end
	end,
	["fatal"] = function(p15) -- name: fatal
		-- upvalues: (copy) v_u_2
		error(("%*%*"):format(v_u_2, p15), 0)
	end,
	["fatalAssert"] = function(p16, p17) -- name: fatalAssert
		-- upvalues: (copy) v_u_2
		if not p16 then
			error(("%*%*"):format(v_u_2, p17), 0)
		end
	end
}
return v_u_18