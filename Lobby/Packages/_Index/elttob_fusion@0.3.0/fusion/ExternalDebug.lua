local v1 = script.Parent
require(v1.Types)
local v_u_2 = nil
return {
	["setDebugger"] = function(p3) -- name: setDebugger
		-- upvalues: (ref) v_u_2
		local v4 = v_u_2
		if v4 ~= nil then
			v4.stopDebugging()
		end
		v_u_2 = p3
		if p3 ~= nil then
			p3.startDebugging()
		end
		return v4
	end,
	["trackScope"] = function(p5) -- name: trackScope
		-- upvalues: (ref) v_u_2
		if v_u_2 ~= nil then
			v_u_2.trackScope(p5)
		end
	end,
	["untrackScope"] = function(p6) -- name: untrackScope
		-- upvalues: (ref) v_u_2
		if v_u_2 ~= nil then
			v_u_2.trackScope(p6)
		end
	end
}