local function v_u_6(p1) -- name: cleanupOne
	-- upvalues: (copy) v_u_6
	local v2 = typeof(p1)
	if v2 == "Instance" then
		p1:Destroy()
		return
	elseif v2 == "RBXScriptConnection" then
		p1:Disconnect()
		return
	elseif v2 == "function" then
		p1()
	elseif v2 == "table" then
		local v3 = p1.destroy
		if typeof(v3) == "function" then
			p1:destroy()
			return
		end
		local v4 = p1.Destroy
		if typeof(v4) == "function" then
			p1:Destroy()
			return
		end
		if p1[1] ~= nil then
			for _, v5 in ipairs(p1) do
				v_u_6(v5)
			end
		end
	end
end
return function(...) -- name: cleanup
	-- upvalues: (copy) v_u_6
	for v7 = 1, select("#", ...) do
		v_u_6(select(v7, ...))
	end
end